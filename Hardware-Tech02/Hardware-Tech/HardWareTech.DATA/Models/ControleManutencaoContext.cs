﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace HardWareTech.DATA.Models
{
    public partial class ControleManutencaoContext : DbContext
    {
        public ControleManutencaoContext()
        {
        }

        public ControleManutencaoContext(DbContextOptions<ControleManutencaoContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Categoria> Categoria { get; set; }
        public virtual DbSet<Cliente> Cliente { get; set; }
        public virtual DbSet<Produto> Produto { get; set; }
        public virtual DbSet<ProdutoClienteManutencao> ProdutoClienteManutencao { get; set; }
        public virtual DbSet<ProdutoVenda> ProdutoVenda { get; set; }
        public virtual DbSet<Servico> Servico { get; set; }
        public virtual DbSet<Usuario> Usuario { get; set; }
        public virtual DbSet<Venda> Venda { get; set; }
        public virtual DbSet<VwProdutoClienteManutencao> VwProdutoClienteManutencao { get; set; }
        public virtual DbSet<VwProdutoClienteVenda> VwProdutoClienteVenda { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Data Source=DESKTOP-L7HE5RL\\SQLEXPRESS;Initial Catalog=ControleManutencao;Integrated Security=True;Trust Server Certificate=true");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Cliente>(entity =>
            {
                entity.Property(e => e.Telefone).HasDefaultValueSql("('sem telefone')");
            });

            modelBuilder.Entity<Produto>(entity =>
            {
                entity.HasOne(d => d.IdCategoriaNavigation)
                    .WithMany(p => p.Produto)
                    .HasForeignKey(d => d.IdCategoria)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Produto_Categoria");
            });

            modelBuilder.Entity<ProdutoClienteManutencao>(entity =>
            {
                entity.HasOne(d => d.IdClienteNavigation)
                    .WithMany(p => p.ProdutoClienteManutencao)
                    .HasForeignKey(d => d.IdCliente)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Produto_Cliente_Manutencao_Cliente");

                entity.HasOne(d => d.IdProdutoNavigation)
                    .WithMany(p => p.ProdutoClienteManutencao)
                    .HasForeignKey(d => d.IdProduto)
                    .HasConstraintName("FK_Produto_Cliente_Manutencao_Produto");

                entity.HasOne(d => d.IdServicoNavigation)
                    .WithMany(p => p.ProdutoClienteManutencao)
                    .HasForeignKey(d => d.IdServico)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Produto_Cliente_Manutencao_Servico");
            });

            modelBuilder.Entity<ProdutoVenda>(entity =>
            {
                entity.HasOne(d => d.IdProdutoNavigation)
                    .WithMany(p => p.ProdutoVenda)
                    .HasForeignKey(d => d.IdProduto)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Produto_Venda_Produto");

                entity.HasOne(d => d.IdVendaNavigation)
                    .WithMany(p => p.ProdutoVenda)
                    .HasForeignKey(d => d.IdVenda)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Produto_Venda_Venda");
            });

            modelBuilder.Entity<Venda>(entity =>
            {
                entity.HasOne(d => d.IdClienteNavigation)
                    .WithMany(p => p.Venda)
                    .HasForeignKey(d => d.IdCliente)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Venda_Cliente");
            });

            modelBuilder.Entity<VwProdutoClienteManutencao>(entity =>
            {
                entity.ToView("VW_Produto_Cliente_Manutencao");
            });

            modelBuilder.Entity<VwProdutoClienteVenda>(entity =>
            {
                entity.ToView("VW_Produto_Cliente_Venda");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}