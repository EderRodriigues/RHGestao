/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.dao;

import br.sp.telesul.model.Certificacao;
import br.sp.telesul.model.FilterReturn;
import br.sp.telesul.model.Funcionario;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Eder Rodrigues
 */
public class CertificacaoDAOImpl implements CertificacaoDAO {

    private SessionFactory sessionFactory;
    private static final Logger logger = LoggerFactory.getLogger(FuncionarioDAOImpl.class);

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void save(Certificacao c) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(c);
        
    }

    @Override
    public void change(Certificacao c) {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(c);
     
    }

    @Override
    public void delete(Certificacao c) {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(c);
  
    }

    @Override
    public Certificacao searchById(Long id) {
        Session session = this.sessionFactory.getCurrentSession();
        try {

            Certificacao certificacao = (Certificacao) session.load(Certificacao.class, new Long(id));
            return certificacao;
        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Certificacao> search() {
        Session session = this.sessionFactory.getCurrentSession();

        List<Certificacao> certificacoes = session.createQuery("from Certificacao").list();
        return certificacoes;

    }

    @Override
    public FilterReturn searchPage(int pageNumber, int pageSize, String filter) {
        String countQ = "Select count (c.id) from Certificacao c";
        Session session = this.sessionFactory.getCurrentSession();
        Query countQuery = session.createQuery(countQ);
        Long countResults = (Long) countQuery.uniqueResult();
        int lastPageNumber = (int) ((countResults / pageSize) + 1);
        FilterReturn filterReturn = new FilterReturn();
        filterReturn.setTotalEntities(countResults);
        Query selectQuery = session.createQuery("From Certificacao Where nome LIKE :filter");
        selectQuery.setParameter("filter", "%" + filter + "%");
        selectQuery.setFirstResult((pageNumber - 1) * pageSize);
        selectQuery.setMaxResults(pageSize);
        List<Funcionario> funcionarios = selectQuery.list();

        filterReturn.setEmployees(funcionarios);
        return filterReturn;
    }

}
