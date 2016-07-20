/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.dao;

import br.sp.telesul.model.Certificacao;
import br.sp.telesul.model.Formacao;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Eder Rodrigues
 */
public class FormacaoDAOImpl implements FormacaoDAO {

    private SessionFactory sessionFactory;
    private static final Logger logger = LoggerFactory.getLogger(FuncionarioDAOImpl.class);

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void save(Formacao f) {
        Session session = this.sessionFactory.getCurrentSession();
        try {

            session.persist(f);
        } catch (Exception e) {

        } finally {
            session.close();
        }
    }

    @Override
    public void change(Formacao f) {
        Session session = this.sessionFactory.getCurrentSession();
        try {

            session.update(f);
        } catch (Exception e) {

        } finally {
            session.close();
        }
    }

    @Override
    public void delete(Formacao f) {
        Session session = this.sessionFactory.getCurrentSession();
        try {

            session.delete(f);
        } catch (Exception e) {

        } finally {
            session.close();
        }
    }

    @Override
    public Formacao searchById(Long id) {
        Session session = this.sessionFactory.getCurrentSession();
        try {

            Formacao formacao = (Formacao) session.load(Formacao.class, new Long(id));
            return formacao;
        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
    }

    @Override
    public List<Formacao> search() {
        Session session = this.sessionFactory.getCurrentSession();
        try {

            List<Formacao> formacoes = session.createQuery("from Formacao").list();
            return formacoes;
        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
    }

}
