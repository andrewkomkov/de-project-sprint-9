import time, json
from datetime import datetime
import uuid

def get_uuid(v):
    uuid_ = uuid.uuid5(name=str(v), namespace=uuid.NAMESPACE_OID)
    return uuid_

class CdmMessageProcessor:
    def __init__(self,KafkaConsumer,KafkaProducer,CdmRepository,_batch_size,logger) -> None:
        self._consumer = KafkaConsumer
        self._producer = KafkaProducer
        self._cdm_repository = CdmRepository
        if _batch_size:
            self._batch_size = _batch_size
        else:
            self._batch_size = 100
        self._logger = logger

    def update_cdm(self,msg):
        mart_name = msg['mart']
        msg.pop('mart')
        columns = list(msg.keys())
        values = list(msg.values())
        print(columns)
        print(values)
        self._cdm_repository.update_mart(mart_name,columns,values)

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
            if message.get('mart'):
                              
            #    object_id = message.get('mart')
            #    text_file = open(f"/Users/andrewkomkov/PycharmProjects/yandex_de/de-project-sprint-9/cdm_test/cdm{object_id}message.json", "w")
            #    res = text_file.write(json.dumps(message))
            #    print(res)
            #    text_file.close()

               self.update_cdm(message)
                

        # Пишем в лог, что джоб успешно завершен.
        # self._logger.info(message)
        self._logger.info(f"{datetime.utcnow()}: FINISH")
