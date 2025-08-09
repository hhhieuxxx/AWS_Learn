## DynamoDB Labs

### Lab 1: Table Creation

1. Tạo table `student` với:
   - `id`: String - Partition key
   - `name`: String - Sort key
2. Thêm một số record:

   - id: st-01, name: Linh, birthday: 1992/05/06, hobbies: ["piano","travel"], skill: false
   - id: st-02, name: Truc, birthday: 1999/12/03, hobbies: ["ielts", "dance"], skill: true
   - id: st-03, name: Phuong, birthday: 2000/08/02, hobbies: ["gym", "yoga"], skill: ["guitar"], is_married: true

3. Query student có id: st-01, name: "Linh"
4. Scan student có name: "Phuong"
5. Scan student có is_married: false

---

### Lab 2: Indexing

- Tạo Global Secondary Index:
  - Partition key: name
  - Sort key: birthday
- Thực hành query/scan sử dụng indexing.
- So sánh tốc độ, RCU khi scan và query.

---
