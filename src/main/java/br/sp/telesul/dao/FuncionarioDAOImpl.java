/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.dao;

import br.sp.telesul.model.FilterReturn;
import br.sp.telesul.model.Funcionario;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Eder Rodrigues
 */
@Repository
public class FuncionarioDAOImpl implements FuncionarioDAO {

    private SessionFactory sessionFactory;
    private static final Logger logger = LoggerFactory.getLogger(FuncionarioDAOImpl.class);
    private Transaction tx;

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void save(Funcionario funcionario) {
        Session session = this.sessionFactory.openSession();

        try {
            tx = session.beginTransaction();
            session.persist(funcionario);
            tx.commit();
            
            logger.info("Save Sucessfully funcionário", funcionario.getNome());
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            logger.error("Error in save funcionário", e);
            System.out.println("erro" + e);
        } finally {
            session.close();
        }

    }

    @Override
    public void update(Funcionario funcionario) {
        Session session = this.sessionFactory.openSession();
        try {
            tx = session.beginTransaction();
            session.update(funcionario);
            tx.commit();
            logger.info("Update Sucessfully funcionário", funcionario.getNome());
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            logger.error("Error in update funcionário", e);
            System.out.println("erro" + e);
        } finally {
            session.close();
        }

    }

    @Override
    public void delete(Funcionario funcionario) {
        Session session = this.sessionFactory.openSession();
        try {
            tx = session.beginTransaction();
            session.delete(funcionario);
            tx.commit();
             logger.info("Funcionário Deleted Sucessfully", funcionario.getNome());
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            logger.error("Error in delete funcionário"+" ", e);
            System.out.println("erro" + e);
        } finally {
            session.close();
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Funcionario> search() {
        Session session = this.sessionFactory.openSession();
        try {
            
            List<Funcionario> funcionarios = (List<Funcionario>) session.createQuery("from Funcionario").list();
            return funcionarios;

        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            logger.error("Error in search funcionários(emplyees)"+" ", e);
            System.out.println("erro" + e);
            return null;
        } finally {
            session.close();
        }

    }

    @Override
    public FilterReturn searchPage(int pageNumber, int pageSize, String filter) {
        String countQ = "Select count (f.id) from Funcionario f";
        Session session = this.sessionFactory.getCurrentSession();
        
        Query countQuery = session.createQuery(countQ);
        Long countResults = (Long) countQuery.uniqueResult();
        
        int lastPageNumber = (int) ((countResults / pageSize) + 1);
        
        FilterReturn filterReturn = new FilterReturn();
        filterReturn.setTotalEntities(countResults);
        
        Query selectQuery = session.createQuery("From Funcionario f Where nome LIKE :filter");
        selectQuery.setParameter("filter", "%" + filter + "%");
        selectQuery.setFirstResult((pageNumber - 1) * pageSize);
        selectQuery.setMaxResults(pageSize);
        List<Funcionario> funcionarios = selectQuery.list();

        filterReturn.setEmployees(funcionarios);
        return filterReturn;
    }

}
