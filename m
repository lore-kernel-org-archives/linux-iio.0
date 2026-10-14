Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3571756328E;
	Wed, 14 Oct 2026 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996883; cv=fail; b=bAkZESfhr3VwVcI6GUovXhkLYLyEnJ/fF+zsjcVF/TdtvazBYaWNob3mY1D8FQXHk9piB1NP9rfFH2S6pdOVCUGY8RqALNzeG82Z6/umV/rUUygcG9UvTjtG7EJoyQxPyylaBy+bleBXv2lPRMzLdQurq1yndt3sT8iCVHvKnpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996883; c=relaxed/simple;
	bh=f0lmn7JrWmxhpjZfGc2JHu8y5RsCQRPb+OnhO01jEzo=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=i5zjD/PJZzcG7tboWBpPnN8uATuvlZZzyA6iZrgy8RWbFNr4sUpyVEVLoWr82PQoCnwrvK/6ITilRuiaj4y6mw8ZlqSD5dEt7+P5/NqJyX+4rA5I7oUOFfI5FtVjUDItK+0Zz0zIMXZpCBtmNEi9qcSvjMetHm9c+MNIEQZNMTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=Jp9eEeJJ; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aHO1ydFL; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="Jp9eEeJJ";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aHO1ydFL"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEcfDB3558596;
	Wed, 14 Oct 2026 12:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=EZGlHNMp8GwMDAanufxV09Ve8JC2hXftN5T/R+MEaI8=; b=Jp9eEeJ
	JnvDFBZvOKIxKZK+hWX9awOc5ydEPgG8lxXLSYp2jHbfZeLD2TcXgQj+LSrsw+Mx
	ySTnUiwpmpwCUvcuAkf4u6KhmCo77iLcsV0ZCgNHSJ1aXmPMC6kMxICu0ycO2R+X
	e3dFjE/R0K7BHnb7qbzY2JD7eHPEe2GNooIFIybOi6xy8QgJHh5ieyDbsVFKdWCn
	iiR+/T5mSFRpm2R+WzZFQz9gHpIPrH/QbtXJWCq17hjrfqjCe63tnZCoDi9cdrt0
	Dg4srmcHluEw26xFqZPKlqD4UD8NmIiA+KGFL2WQT/tvrNfDn+5SBfJBuP8CgSEh
	RnkpeGCVZFgTyGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EZGlH
	NMp8GwMDAanufxV09Ve8JC2hXftN5T/R+MEaI8=; b=aHO1ydFL8KU/kLFE2cMpt
	fe9ignd0/0NpOwzOeKr6VjyuABOdAIk6QAfQJlpp7E1yXYK5d9cjw5PdgzbR4aDA
	Zy3COAtJV1NpKGnz9OefxraO52awl3+BHpTHs0qwJaDO3skc2ooJ140WG1fYkS0V
	3Klwza5u2p5Omksoyfn5aH4cxKgmIaI/ZBGOYVL+9WdbuGs4IMMil/dL4TVekrM3
	7Ro5W5HMRBpioIK8WIoZttF5mrCfBjpW3NHZHVfr1dtze1kSY69xIZToKWziZOjK
	nku6jGc1j/nc1wHSqdNQpxSC2ELa0uaU01jl0TfFRNfJTpdatv5RO48s6BuAIEpo
	A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h9xnsd8pc-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:54:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdHhnQbjSovvtA/erEsK5bTPEcTnMoVnEclDCgfpsEbpG7D5v3vX5zBHrXMuDwSHfgno+x0faLKF2un5KLBmXzJY1z6DhAV4KYouYBLvBt6NwraqMqQMXkNn56rIvkvjaUGnaSgEM/IxFuBsKwNSROx/aKVf1QJvRLpl5+a+01rPFDweeDPBxAIRXNs7nIwQUETwTDMGM2si/uMfMJId2hDYFuPo9q57lKzLxjBh03ANtSvWqVvNbMMKE4Gz8SgaoIs3B2XR4XHq/8e4NQ6TcErgLsFCGe+ymDHGzH37M7IQudTtK/YxHpzpWUUBMjMoRx3zLbYe7X4Z6IhONbwlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZGlHNMp8GwMDAanufxV09Ve8JC2hXftN5T/R+MEaI8=;
 b=Nd4a3PYaD0uqBOgovE6X6iMcoSZSrg62tsSBcOn0UxY9nv8HyiBmPKs5BIu7wU5yoHDk9jrOh+PxiM72zJxMg+be6MOFvyYJuBO2/f8zZQUUUdi+7i+IzCCw24aIGp+PR7g9KahnTOY/4CPRGksV90TVJYnHk2IPersLYktz2O8TlAq5AiDH56SuQmXAeJ8jSnqKvPTMKMSjB/deGfPuHwZP1u81htOAyEjyOfIpbt3x752kVBMXwqAiKqH+qgLuGERebCGSTX1sm6TIqijrUKJGQhgJbOq7JAtNRRFSEEDcn/QALCRkwSwdQBIHFRtbUQ5OwUEMD5DNl/wRVCEW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB8350.namprd03.prod.outlook.com (2603:10b6:806:45d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:54:34 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:54:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 10/13] iio: adc: ad4134: Support SPI 4-wire mode
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
        nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
        Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
        marcelo.schmitt1@gmail.com
In-Reply-To: <ec26e0e1cbb6572c8eee391951c084a7c264887c.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <ec26e0e1cbb6572c8eee391951c084a7c264887c.1791309733.git.marcelo.schmitt@analog.com>
Date: Wed, 14 Oct 2026 17:55:28 +0100
Message-Id: <179199692830.658576.14049229425648931434.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996931; l=2229;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=f0lmn7JrWmxhpjZfGc2JHu8y5RsCQRPb+OnhO01jEzo=;
 b=W2Ofxw4jDWxXNFG00QsPeOXb+/ES7/3hbWFp45Bil9tyBQqFLM2ajTsv0Hg7MXabBTCLl8AZ8
 DmeYLnpAnTKCzTTvHPgiaRcDXngmtR2uGReICJkDFBZbtIeKgbdiLV2
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0021.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: a1574e84-6e23-4f81-bec7-08df2a13d33c
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 tZ3RVD/J8F0PbLZo7nOId0bFwPMfZKokq5rc6r8Bca8DgKEzhPr5ZTrxdeI87gQUSRbYe/XaN7OfyeBhlmYyhR0gk00I/PHybskAUGxtNKxFH/L4etcXmEAzXDVnMkRQ9fwh2j20qeSu9efsCfaIygFROxqFKK6RQpB46jZE5cjvlGlCblEMISaIPfFAWXIQEdEJEF/5PdEa3o5Komo62/GLrpFaKTXsT/V0pXQMmdQnPP0BcObytZC/4ZPg3aWbLJA1Wr+NPtAeoaaQ0kDlyhje+tfRQnawu4s3bicC7ppcVO/gBfj1UhU11oV4oN5G4lhQUcq0vet8/s0fS30vEuq3GyUAdT0oIvT9WunVgSCf4eiQXfjVtgavwgvkNGswPGCMZAWMlCCdJImc3A0Ms5lySt2cmYPrZVjFF3f94kkBsSYdszvmyzEvbxevi2b4/JP3FwancbUQDOJXkOwUaU5t56RAkBcdl6VUUXxMk9nYS5so9n4ngQ8P11gRn2LVs7r+qPD+OaXmGKLnZ+tEX/gsLt8WSHo9x1mbvh2bA6H4IkEuGYFY5OwEAzyXlFe3FnMx9ka4T/YzoD5q0jCUm4TwlAhsuI8fvt8BHyrQE5ZyZlz/+iTjAFiI29cD/qv7lA4PEbkKJv/+riE9C4GiSoEqpvU5sTHafwiglyeJUmk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TTM3QXM0ejBWYlBHU3ZCZW1tTmxuVEVHdzJac2NvaVViUktNT3VheUhSWTFW?=
 =?utf-8?B?UzVWaGRIWC9BVS9HcFduWk15aTloMm9QamQ5OUV2cTNQbFVKcWg4WlVqK2wv?=
 =?utf-8?B?L3lqbzRJZmExWHlrZUZQdXA4ODFqaGxOTHFWaHdLTnZSVTZlTmtDaFVYRnkx?=
 =?utf-8?B?VjlIQTJXRHpyYTlBbVZpU0h5dVJ4R2ZNVkMwMCt2bDVyQm0vTTR4UWdaZUlw?=
 =?utf-8?B?TklqTnErcXFLS1BKVS90VU1CZlBuZnpJbHY0QkpUSjA1VTkwV3FTSTRDQW1M?=
 =?utf-8?B?S3p6ZjBQRnd5UVA5RFBWclpoZC9EWkU1cTVQdWtXV2xBMEpTKy9zRkxMWW5T?=
 =?utf-8?B?RjQrTHFwcWdBVkt4Tk4rb3ozOCtZZ1huRTBVZ296dVpLQUprV0FTZ1g4VE55?=
 =?utf-8?B?T2IrTE1oeGhKeXNFU1pUNlJxRHZhb3g0WEhYRkM5bDV1YmdpUktoTHpGVlJ0?=
 =?utf-8?B?RDJ0Zkd3VjJ6djQwQ1NxK1l1ZzRsMFJGS3ZSamZmdmlBZ1JxWUlIaXd4c2ZE?=
 =?utf-8?B?eDhyQ0Q4ck1WVCtPMjA4RFdPRFRzSy9hWU52aWdUZTloTTd5d29SM1ZzSWw0?=
 =?utf-8?B?Vks3d3ovd2RPK25mZ0h0VUpoaEpJNE9qeVBKR2YwVHNzeDF5UXg5SmJ1NUhK?=
 =?utf-8?B?N0JpOTY0djlQWTVIZ09GY3JxWFFZQnp6MDc0NHNoUzhIODNyQ3l0YTY5blFa?=
 =?utf-8?B?c2d4c2N2YU5CVEFodkI4cVQxNXdIZGZWckZGYjFaeFYrTkhPMk9sdVJCaEI5?=
 =?utf-8?B?OHBsY2QzQVppTTI5U3ljdjdkSjdmdXFZWXhsRWhYMllrd1dtU2xZUFREaGpY?=
 =?utf-8?B?UXMzUUUyRGo0a082ZTFidVJhcW5NZE1mUW96WEJWaTlKdGhTWndYenVzNjgw?=
 =?utf-8?B?eFFHUS9nUlN5Qm8vNFdZYlp2R2RFRlVhZUM5WCtaK1RhSlNWRVZrbnB4Ymdt?=
 =?utf-8?B?dXp5T2hUY2ZvQ2M1cWJRb3ozeGFSdzZQTXQ3dEQ0UmtObW0zN0Vod0U3MnNo?=
 =?utf-8?B?OFdZT0ZhMk1KQnRRZ2g2WUR2T0xGWlE4anhRT2Jqd2g1QUhiN2hzUlgwVzdE?=
 =?utf-8?B?eFpqQjRvb3FhZzBWV1FJeGh1VE1KMWJVQ0NmeTlCTXB4N0hqeDRLSythSVc5?=
 =?utf-8?B?RU9WalRjRS9VRys3OGJzZnhWU2NuaFU0VGJZQWVGaW5iZ3F2Vk9hNlo1eVJK?=
 =?utf-8?B?TVhzTjN4cEdPdGtXM0xoYmZxTVVxZzJqMWtWQi9IZ2plMGdGTHJFdmZyM0E4?=
 =?utf-8?B?S0d5WHRqeHhOSElQVHVGc09QdFJhaUlsNU96UVlHUTQ5YTU5L201V2xWZWN5?=
 =?utf-8?B?UWhzM0U2eU9qMDVEWWRUVCsxVDNkTGRvVDFiY2M3YzJHc0l2UGUvNnl5RjBR?=
 =?utf-8?B?bVRFMW1Xei95NDcwcFVab2x0WWNlUlFHZk05NEQyeGx0NVNjKzdHdUVWb3Zm?=
 =?utf-8?B?WHhvdDJlYnkyemNHbWJSd2Jnb1MrSzRqV3M0RnB6cDFCR3U3cnh0SmRYemc0?=
 =?utf-8?B?QkR2SE5hbE9JYjVlQ0NBU2FKWkVKeDJaRkl6YmNmWHhoaXhvekQwcWczSUMv?=
 =?utf-8?B?WFgrQW9CSkFhNHp6UktxQ0VMbWI2OEVWMXJaZmdmVXdBR3lXb3hJNXFwQ3Ro?=
 =?utf-8?B?L0xwa1FxOFVOWjVlcXc4dE55TVQyNUZJcHBpSWRBVHZMUzhHcVdNeGNnSDFs?=
 =?utf-8?B?ZWpXaVpKaitiWk1wc2pidUJab3dlUjFra1Z3S0J2MFQ1aDQ4K2dkZjl0UFVP?=
 =?utf-8?B?V0w5S0dOZFAxeEdJZmVNbzJmNGVXa3JCQ1pra2ZiTU5DRHcyOTZTQW1iM3Vj?=
 =?utf-8?B?RXJaZ0NFUC9tZ1NNZmNoNm1iQkJUeDRQT1phWEhDMlQ3eGh1Q01EbFJ5OXZM?=
 =?utf-8?B?eGlVeFQvcnlXczc2NUtvdWpIZXkzVGd3cTRBblJOejR2ZytCT1dhZk5lNDMr?=
 =?utf-8?B?cy82TVRwcXRkZUhLT3ZpRllyWnFiWGViYmtrdFNyWVExelRLMytEZTg1U1Mr?=
 =?utf-8?B?V1VxRnphR2t4VWgwaUtvWWhkbUpPTzhvY2t2R1BGYmk4cHNQN08wMzZ3cno0?=
 =?utf-8?B?S2pWMnlBTllqb0dBdG5YWXJmUlcxMUlzVlE1aTdCUDVVaDdUaHVEZExoNDJn?=
 =?utf-8?B?R1dJZmdTNGJTTDNYcW5CYkhKWVpkNjJtWmN4amJ2THVMUFhLQWlNNWppaVN5?=
 =?utf-8?B?OG52dkxtbFpUb1ZIQ1BvSklLdXNBSXd5a0RNbkxRQ0ZVVDh3bkJrTy9FdlRP?=
 =?utf-8?B?UjVMcFFCajlPMzRQVEVXTVpHTXU5b3Q1dDFSOHhHN3ZJcVJWM3pLd3pudFlW?=
 =?utf-8?B?dnBqQXJtckRrVHNxYmREdkJhL0Ftb3V5Q2luSC90K0VRZHZ4WjVwQT09?=
X-Exchange-RoutingPolicyChecked:
	zN9ke9xORtAKA2+pnqVZa97IRY1eEkcSY0uRssQZ5lX/43NSg5ob0VEoINSOcdqrx2nnU/IRQmZyl/e2vSyQcidV9VHFcJFpuEAsvG0R6PEO9DbcaTjt7woVTxtFv+hJgZC5CvX4qzdezZsZ3XQ6NcsoqgCgIm/vJ/0LGjOgtLZ/F3SuzLXACu0Y5FIO+6pWsoE+ItPqSLH/mOl3zkVmLbhhgTam9MjIJ3VCahECAx6V0UPjqkfPR7i3mR16OE03O284n7Rtl7RLW1J/ZtQEaH7u5aks1zLauXBN9TpuKy7hGZyElRVRzTCHr/lYjMoYTjYorzEDI0uDAMCCwwbvoA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1574e84-6e23-4f81-bec7-08df2a13d33c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:54:34.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rf5EgoJ/OrkPF5P0/RM1/OjoWCh2s2CP4qme+w8nliSxH4HXhZUSxG+T5ewP7Rbam6dNssdYUiKRwghtkVrs6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8350
X-Proofpoint-GUID: qk3XcQBO7VJoqk60pwJ0uBjWsf7c4Y9O
X-Authority-Analysis: v=2.4 cv=MIr1C8Zl c=1 sm=1 tr=0 ts=6acfb3cd cx=c_pps
 a=UcHwULevSueSKPp+kiqIJg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=rbi-IJjGDUivLVIcm9IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXx8H9BEBgNHx3
 PrQHbolNKWZByIjHGxgqfcCnQT2EyLYEKZWISCHXNr6+TSAfhYjC9MK+EFemx2NBCZDC3Bd/9jJ
 dmOBb/dODhXKHw/8LpY8Usg7qzwm3uW9i/DNTOwJFcbvYpZX4jRN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX+uf+7KUGDPk3
 mVKXhBQpH4hJoP7nR+GE6Bb7TVKCcinN78lNbaIXfsFr+s2wmw/fE7GBs442ifvOxQxK5+0YfB+
 UOI4CHq55PL2cY8UXmgTLm6TZnEWYK9at7N0QkiyJ5BjOjUYQv2o9IwtvwnqTbkPXnvQKMhiy0Y
 GxpCkFj4geeq1y9YS3vTaps4g4c9aeh1Qve/UP1HoG+LnXyefwfVw5cgRQL2PZFSBoK271Q4Zth
 tuaLQgU1XYOfbWwo+uni4qR67a1kURRF0x7bxAVS3H8C4nt+ygLrFPsrE+9DNCf489IYwPgMi+X
 9IUr7wPU6uUZ4ThbbFEQNfLjBbg+5Zarj1mmQUdgxFI0JWQ20z6psfBuiOfhVexna2mLBaJmMpQ
 4CNIPRrSp6M341/rJQBWkhn8StP/B8dHv/33bNthqjJPJtbbJhqOUelPo5jHCLE+rrN/QkDhFnd
 UxmGXeQUyl/PNOVhQhw==
X-Proofpoint-ORIG-GUID: qk3XcQBO7VJoqk60pwJ0uBjWsf7c4Y9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067

On Tue, 06 Oct 2026 15:19:00 -0300, Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index b5207f16054e..debc2ff02705 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c
> @@ -308,14 +423,18 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
>  		.len = st->crc_en ? AD4134_SPI_MAX_XFER_LEN : 2,
>  	};
>  	unsigned int inst;
> -	int ret;
> +	int access_ret, ret;
> +
> +	ret = ad4134_claim_reg_access(st);
> +	if (ret)
> +		return ret;

Do we really need to claim/release for every register read? Can't we
just select register mode at probe and leave it in that position by
default? Then when starting to buffer, we deselect + select sample mode
and when exiting do the reverse. Seems even more appropriate when the dt
mode property does not want to use DOUT at all which means that all this
select + deselect is really unneeded.

> @@ -594,10 +728,64 @@ static int ad4134_probe(struct spi_device *spi)
> [ ... skip 16 lines ... ]
>  		return dev_err_probe(dev, ret,
> -				     "failed to setup minimum I/O mode\n");
> +				     "getting adi,spi-mode property failed\n");
> +	} else {
> +		st->spi_mode = ret;
> +	}

Andy has a better idea but I think the way we want to handle the above
in IIO nowadays is like:

if (device_property_present()) {
	ret = device_property_match_property_string();
	if (ret < 0)
		return ret;
	
	...

} else {
	st->spi_mode = AD4134_SPI_MODE_NO_CS
}

> +
> +	if (st->spi_mode == AD4134_SPI_MODE_NO_CS) {
> +		/*
> +		 * The support hardware for AD4134 may have a multiplexer for
> +		 * selecting between AD4134 SDO and AD4134 DOUT0. If that mux
> +		 * is set but the user still wants to run AD4134 in minimum I/O
> +		 * mode, then DOUT0 is not used and the multiplexer OUTSIDE OF
> +		 * AD4134 SILICON must be set to select AD4134 SDO. See AD4134
> +		 * IIO documentation for details.
> +		 */
> +		st->mux_st[AD4134_SDO_INPUT] =
> +			devm_mux_state_get_optional_selected(dev, "reg_access");

Seems like an issue indeed. But with I propose above, stops being one I
think.

-- 
Nuno Sá <nuno.sa@analog.com>
