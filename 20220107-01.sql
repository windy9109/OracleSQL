2022-0107-01)
3. DELETE��
  - ���̺��� �ڷḦ �����Ҷ� ���
  - ROLLBACK �� ���

(�������)
DELETE FROM ���̺��
[WHERE ����];
. WHERE ���� �����Ǹ� ��� �ڷḦ ����

��뿹) ���̺� GOODS�� ��� �ڷḦ ����
DELETE FROM GOODS;

COMMIT;

SELECT * FROM GOODS;

ROLLBACK;
SELECT FROM GOODS;



��뿹)���̺� GOODS�� �ڷ��� ��ǰ�ڵ尡 'P101'���� ū �ڷḦ �����Ͻÿ�.
DELETE FROM GOODS
    WHERE GOOD_ID>='P102'; -- ������ ���ʺ��� ���Ͽ� ó��

SELECT * FROM GOODS;



