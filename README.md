**README.md**

# Soft Delete Implementation in Rails App

This Ruby on Rails application implements soft delete functionality for a model named `Item`. Soft delete allows items to be marked as "deleted" without actually removing them from the database. The deleted state is managed through a `deleted_at` attribute.

## Setup

1. **Install Dependencies:**

   ```bash
   bundle install
   ```

2. **Database Setup:**

   ```bash
   rails db:create
   rails db:migrate
   ```

   (Optional) Seed the database for testing:

   ```bash
   rails db:seed
   ```

3. **Run the Server:**
   ```bash
   rails s
   ```

The application should now be accessible at `http://localhost:3000`.

## Soft Delete Functionality

### 1. Model Creation

The `Item` model is created with the following attributes:

- `name` (string)
- `deleted_at` (datetime)

### 2. Soft Delete Implementation

Two methods, `soft_delete` and `restore`, are added to the `Item` model to manage soft delete functionality:

- **soft_delete:** Marks an item as deleted by updating the `deleted_at` attribute with the current timestamp.

- **restore:** Restores a soft-deleted item by setting the `deleted_at` attribute to `nil`.

### 3. Default Scope

A default scope is included in the `Item` model to exclude "deleted" items from normal queries. This ensures that soft-deleted items are not returned in regular queries.

### 4. Testing

RSpec tests are provided to ensure the correct functioning of the soft delete functionality. The tests cover the following scenarios:

- Soft deleting an item.
- Restoring a soft-deleted item.
- Verifying that soft-deleted items are excluded from normal queries.

To run the tests execute the following commands:

```bash
bundle exec rspec
```

All tests should pass, confirming the correct implementation of soft delete functionality.

## API Endpoints

The application exposes the following API endpoints for managing items:

- **GET /api/v1/items:** Retrieve a list of items.

- **GET /api/v1/items/:id:** Retrieve details of a specific item.

- **POST /api/v1/items:** Create a new item.

- **PUT /api/v1/items/:id/restore:** Restore a soft-deleted item.

- **PATCH/PUT /api/v1/items/:id:** Update details of a specific item.

- **DELETE /api/v1/items/:id:** Soft delete or permanently delete an item based on its deletion status.
