from datetime import datetime

from lib.pg import PgConnect

from dotenv import load_dotenv
load_dotenv()

import os

pg_warehouse_host = str(os.getenv('PG_WAREHOUSE_HOST') or "")
pg_warehouse_port = int(str(os.getenv('PG_WAREHOUSE_PORT') or 0))
pg_warehouse_dbname = str(os.getenv('PG_WAREHOUSE_DBNAME') or "")
pg_warehouse_user = str(os.getenv('PG_WAREHOUSE_USER') or "")
pg_warehouse_password = str(os.getenv('PG_WAREHOUSE_PASSWORD') or "")

def pg_warehouse_db():
        return PgConnect(
            pg_warehouse_host,
            pg_warehouse_port,
            pg_warehouse_dbname,
            pg_warehouse_user,
            pg_warehouse_password
        )



class StgRepository:
    def __init__(self, db: PgConnect) -> None:
        self._db = db

    def order_events_insert(object_id: int,
                            object_type: str,
                            sent_dttm: datetime,
                            payload: str
                            ) -> None:

        with pg_warehouse_db().connection() as conn:
            with conn.cursor() as cur:
                query = f"""
                        INSERT INTO stg.order_events
                        (object_id, payload, object_type, sent_dttm)
                        VALUES('{object_id}',' {payload}', '{object_type}', '{sent_dttm}')
                        ON CONFLICT (object_id)
                        DO UPDATE 
                        SET object_id=EXCLUDED.object_id, payload='{payload}', object_type='{object_type}', sent_dttm='{sent_dttm}';

                    """
                print(query)
                cur.execute(query
                    
                )