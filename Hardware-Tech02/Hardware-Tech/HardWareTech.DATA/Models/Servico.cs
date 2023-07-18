﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace HardWareTech.DATA.Models
{
    public partial class Servico
    {
        public Servico()
        {
            ProdutoClienteManutencao = new HashSet<ProdutoClienteManutencao>();
        }

        [Key]
        [Column("id")]
        public int Id { get; set; }
        [Required]
        [Column("nome_servico")]
        [StringLength(50)]
        [Unicode(false)]
        public string NomeServico { get; set; }
        [Required]
        [Column("descricao")]
        [StringLength(255)]
        [Unicode(false)]
        public string Descricao { get; set; }
        [Column("preco", TypeName = "decimal(10, 2)")]
        public decimal Preco { get; set; }

        [InverseProperty("IdServicoNavigation")]
        public virtual ICollection<ProdutoClienteManutencao> ProdutoClienteManutencao { get; set; }
    }
}