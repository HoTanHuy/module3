package repository.impl;

import model.Product;
import repository.IProductRepository;

import java.util.ArrayList;
import java.util.List;

public class ProductRepository implements IProductRepository {
    private static final List<Product> productList = new ArrayList<>();
    static {
        productList.add(new Product(1,"Iphone13",1000,"Iphone","Apple"));
        productList.add(new Product(2,"Samsung Galaxy Z Fold 4",1370,"Samsung Galaxy","Samsung"));
        productList.add(new Product(3,"Poco X3 Pro",640,"Poco","Xiaomi"));
        productList.add(new Product(4,"Vivo X3 Pro",853,"Vivo X","Vivo"));
        productList.add(new Product(5,"Mobiistar Zumbo J2",300,"Mobiistar Zumbo","Mobiistar"));
    }
    @Override
    public List<Product> findAll() {
        return productList;
    }

    @Override
    public boolean add(Product product) {
        productList.add(product);
        return true;
    }

    @Override
    public void update(int id, Product product) {
        for (int i = 0; i < productList.size(); i++) {
            if (productList.get(i).getId() == id){
                productList.set(i, product);
                break;
            }
        }

    }

    @Override
    public Product findById(int id) {
        for (int i = 0; i < productList.size(); i++) {
            if (productList.get(i).getId() == id){
                return productList.get(i);
            }
        }
        return productList.get(id);
    }

    @Override
    public boolean delete(int id) {
        for (int i = 0; i < productList.size(); i++) {
            if (productList.get(i).getId()==id){
                productList.remove(i);
                break;
            }
        }
        return true;
    }

}
