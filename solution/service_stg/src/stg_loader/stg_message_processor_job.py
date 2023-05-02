import time, json
from datetime import datetime


class StgMessageProcessor:
    def __init__(self,KafkaConsumer,KafkaProducer,RedisClient,StgRepository,_batch_size,logger) -> None:
        self._consumer = KafkaConsumer
        self._producer = KafkaProducer
        self._redis = RedisClient
        self._stg_repository = StgRepository
        if _batch_size:
            self._batch_size = _batch_size
        else:
            self._batch_size = 100
        self._logger = logger
    
    # функция, которая будет вызываться по расписанию.
    def run(self) -> None:
        # Пишем в лог, что джоб был запущен.
        self._logger.info(f"START START STARTSTARTSTARTSTART STARTм м START{datetime.utcnow()}: START")
        #### Начало работы сервиса
        i = 0
        while i < self._batch_size:
            message = self._consumer.consume()
            self._logger.info(i)
            i = i+1
            if message is None:
                break
            if message.get('object_id'):

                

                object_id = message['object_id']
                payload = message['payload']
                object_type = message['object_type']
                sent_dttm = message['sent_dttm']

                # text_file = open(f"/Users/andrewkomkov/PycharmProjects/yandex_de/sprint-9-sample-service/mm/mm{object_id}message.json", "w")
                # res = text_file.write(json.dumps(message))
                # print(res)
                # text_file.close()

                self._stg_repository.order_events_insert(object_id, object_type, sent_dttm, json.dumps(payload))

                user_id = payload['user']['id']
                restaurant_id = payload['restaurant']['id']

                user_info_redis = self._redis.get(user_id)
                restaurant_info_redis = self._redis.get(restaurant_id)

                user_info_out = {}
                restaurant_info_out = {}
                payload_out = {}
                product_out = {}
                products_out = []

                # text_file = open("user_info_redis.json", "w")
                # n = text_file.write(json.dumps(user_info_redis))
                # text_file.close()

                # text_file = open("restaurant_info_redis.json", "w")
                # n = text_file.write(json.dumps(restaurant_info_redis))
                # text_file.close()
                
                user_info_out['id'] = user_info_redis['_id']
                user_info_out['name'] = user_info_redis['name']

                restaurant_info_out['id'] = restaurant_info_redis['_id']
                restaurant_info_out['name'] = restaurant_info_redis['name']

                menu = restaurant_info_redis["menu"]
                for it in payload['order_items']:
                    menu_item = next(x for x in menu if x["_id"] == it["id"])
                    product_out = {
                        "id": it["id"],
                        "price": it["price"],
                        "quantity": it["quantity"],
                        "name": menu_item["name"],
                        "category": menu_item["category"]
                    }
                    products_out.append(product_out)

                payload_out['id'] = object_id
                payload_out['date'] = payload['date']
                payload_out['cost'] = payload['cost']
                payload_out['payment'] = payload['payment']
                payload_out['status'] = payload['final_status']
                payload_out['restaurant'] = restaurant_info_out
                payload_out['user'] = user_info_out 
                payload_out['products'] = products_out

                output_message = {}
                output_message['object_id'] = object_id
                output_message['object_type'] = object_type
                output_message['payload'] = payload_out

                # text_file = open("output_message.txt", "w")
                # n = text_file.write(json.dumps(output_message))
                # text_file.close()

                self._producer.produce(output_message)
            else:
                print('Error',message)





        # # Имитация работы. Здесь будет реализована обработка сообщений.
        # time.sleep(2)

        # Пишем в лог, что джоб успешно завершен.
        self._logger.info(message)
        self._logger.info(f"{datetime.utcnow()}: FINISH")
