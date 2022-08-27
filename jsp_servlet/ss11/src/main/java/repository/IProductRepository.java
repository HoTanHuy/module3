package repository;

import model.Product;

import java.util.List;

public interface IProductRepository {
    List<Product> findAll();
    boolean add(Product product);
    void save(Product product);
    Product findById(int id);
    boolean delete(int id);
}
