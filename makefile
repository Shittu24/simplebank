postgres:
	docker run --name postgres13 -p 5432:5432 -e POSTGRES_USER=ibrah -e POSTGRES_PASSWORD=arsenalFC -d postgres:13-alpine

createdb:
	docker exec -it postgres13 createdb --username=ibrah --owner=ibrah simple_bank

dropdb:
	docker exec -it postgres13 dropdb -U ibrah simple_bank

migrateup:
	migrate -path db/migration  -database postgres://ibrah:arsenalFC@localhost:5432/simple_bank?sslmode=disable -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://ibrah:arsenalFC@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc: 
	docker run --rm -v "${CURDIR}:/src" -w /src kjconroy/sqlc generate

init:
	sqlc init

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc init test 

