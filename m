Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1E55C32A;
	Wed, 14 Oct 2026 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996868; cv=fail; b=PjGCwI4+RfdtXIcM4zx7tihTzEQwCHyVw7BtwtsiZokjoVm4TBImwjYUgqzb4XQYSf9PYidZx8xyRM2xMrKNN6uRUauMqiA++xZgAuAB8k4qg9c8OLlUdBqa53ZFjpBuuUdP6Uj7SgnJarVvdmnnAbKSly6FKmGg5ZKc41a4sZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996868; c=relaxed/simple;
	bh=5kpmhLgXvBRQ6FupP/0sS6xUOzSmyfZMD7OghHquStE=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=REaddJxHgfj3COMvC2WABfRuVkTQnCMGgBJb+PyuwuaQyIrCOhrxVsvQ1B1B01FSKw3PvoY5iXIS+e44IsY4eCSaTABdSXXgLIHooooz/RBmgCAZGaEjmlpN3bNYlDIACRo3yHBeItYGaTSjJod30nX2b3EmxVaBovTsOBpkgVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=n+z6wUHf; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T32TMn3k; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="n+z6wUHf";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T32TMn3k"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEdxrj4174708;
	Wed, 14 Oct 2026 12:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=IWWQQkLlU+XsXp+LREInzoc9X3Y4glR0X4OlbcbskII=; b=n+z6wUH
	fmbY333Ehok4TGnUyQnnK/BMu2U2PrupMliSaHnQ1x0vrsjUz4s0sx8Htt4g92Cp
	vBOZeF1cAJORa2IjY3sjfSo9FwZYjEFSApXl16vZKHQl/Js+Oy0C4vhXWSdgqHTn
	7matKl3IO+1/ERnhfn/Bxf6YTSv6EZeHIXvHfSGRGEY+aYZABIJ2ojwsYp+qkDQQ
	+Q9jM7wLbdnJqWBvZBmkAP51btFsoH18ID1NycyGNEgmOwH1tEGnUIEx821Hxohw
	KeVc6pfwh4bEPlS7/qihMw0EIoGOlb7AgIfKNcfu+nHZiehV/sv8dl/OL+GhDAkm
	+R+QR2wfZjCjtmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IWWQQ
	kLlU+XsXp+LREInzoc9X3Y4glR0X4OlbcbskII=; b=T32TMn3kV/SXw2ORgqPyj
	HjAoc2u4BTUB7DG5/OSTmEpxuuu9riSDuKf8wqWGAUErRVk55w9TuptfNXt6FoMW
	xe9tPD7faJB/Ir6ZA+qWnfi7pm3+HoefdGUPEex8rTN4irLmxc318bRkgYLtS4P1
	12mKjxa5OqLRYO0EufQ02BjvUjta+N2XUrV7EY1VyFdq3Uvsb+m/zsgG0lKXT9y9
	P6XbcOig0LdQEaisnnbfYHclYwLfs/c+eacuvdE3k8w6lPXa7GzKpk5TFRKOar6g
	uGRUB1A3Z57trYHp+oKVzcxorDOuZF7zsQYqupNdAu4o6sA1YRY7oC91YvGJ3zjZ
	A==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h9ryn71fa-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:54:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S750KBDZ0GsWfKYmLb2g1WNlzBnrSXpwgp7SeTeWUyrEfmMgHqYF9PR5SW+rDpErgrxXJ1r4pJu60TmbZTroJA6X43EU8zskt/9OMhMoSPz5H6VjyxKkdO5/ynxnahrqOkiXYIaACw+AeGu74xpYrcFQqCYDIqVI/g2MTd9diAjf1JUPWFOi8pA4KuHFg64WwWFKg5K4g1d78cEaf8b76vK/Y0LrofQyhtkhQ5/7uWPvOA4UxhGbtjlWQizjKtY3O0iQBd/EGbYUhVhJoDyB9nKq6E9xl4Sr4cR1qmFziLuSQrQJ6Xc/+pzwf20G/uGD2BeBFCP+5CD4QBtVCczDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWWQQkLlU+XsXp+LREInzoc9X3Y4glR0X4OlbcbskII=;
 b=JS5JTSo6RHGzO2eymBZuNHyuh1/LkJKTfBfzTo00U/QOQ6/k87bXyfl0LRMK0NWO2FhgTB1JK31HyK7xiHs6g3yHVOySF4lmhNMuHy0DXKUGWHisNh5qwAsa4UlJszUsYPuvxJzPvaM7ogOGkZM/7b9BNihZV4QIuuItaNcJD0nGMAIwm1gRVz3BpAFRuCoHi48tPJPBt6A9oYieNr3hn4ImYXw8Yn27GFQ7lzYXTqao1EysnI7xAkCck4Xh79x4EocJKjrHH3umxDFogupvQx5KZPUobnTwvU/Av/opS/f7hN2Ra/9LrweVAwBE4rsYwWg4nTqb+Xcmves7V0dqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB8350.namprd03.prod.outlook.com (2603:10b6:806:45d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:54:20 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:54:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 04/13] iio: adc: ad4134: Serialize single-read
 operations
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
        nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
        Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
        marcelo.schmitt1@gmail.com,
        Andy Shevchenko <andriy.shevchenko@intel.com>
In-Reply-To: <466f824eecdbf969c26c988ed0ebcc6cace21ff3.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <466f824eecdbf969c26c988ed0ebcc6cace21ff3.1791309733.git.marcelo.schmitt@analog.com>
Date: Wed, 14 Oct 2026 17:55:28 +0100
Message-Id: <179199692816.658576.8346470423443139714.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996931; l=375;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=5kpmhLgXvBRQ6FupP/0sS6xUOzSmyfZMD7OghHquStE=;
 b=rbY2Tj8WcoKUN0cz+nMOsichTGrHoUEREWy0Evp+pwyFrWEL7YBy6WEqtRP28/jlJxsbQIsWV
 9MX7Nw+xXPDAcnt7xk7rbK8CHNunqKXKYaKE+XLrG3Fh42OOd9PPmm0
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0030.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 65585332-6111-4df6-ba39-08df2a13ca9d
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
 t76Ae8g9iapc0jYCKxJMuErHb0ER9MRQAFrbP82fjQfsasIGzE5/BfJH0zZBbCabBn4jFOaEesLRUqj5TkZt/3SLR8fSq+tUftcHLbXsgr5sXPTr2N8RGeGqh+SOMLhNws/heReMhiP/P7uJm96dEfY1UOGc/qvk3mPrn+YEVuVMe9D4xUI/CrVNW4CX9DYl90mC3GDl8RkLbGPzQpSTUAam306x4vTaNkNTV10xixGD+Z8WouzBoAzAcwRyfpxSAHH7X5wP3o8/ZqER0Nx5Vdtye42NgeoJu5sUNt3VM1qvU3RVRuskhjTc+AGx+ALEVdNiGBBmkcE/KFDJop9+c0Ato/ifhbL86AppD5FRX+d0AR3dIp51ZuLVRdiK5n7VsTMmhUPiRlcf7S7+JQgQfYMZ47cON45ppy3KjCKUehJVne0Wi0ULHSFUEm1UC4y5Gf95xtX3fH9oxsSxIVGIcpJEx81oShPZBGqpu8XfgOkvijsQS5untm9vibWQwCLC5RipN5PZvllF7Gv1NkX0x31TBug7jyhF6/zihjNZY3kcqRg564H8vvrczjVGL2zO2b/9gJFB0/z/bBryJdBM0OXFpCMOiMr1l+d/y9cw/5llm9xgtFPoweuPnz20MIbrbKS4nfcmgTZgZdWItu8U8Su46+CjTvmp6QVMXNW4hSY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?N04wRUFDWWtweWpSSitNbkphT3EyalRaSHQ4YmJOYVBpU3U5SElPM2ovbEti?=
 =?utf-8?B?Z1VBSjFoZEV4UXFFaUlRN0FtdFJ1aFByVENJaWt2Rlk3bzR2WFY0dXFqSTZh?=
 =?utf-8?B?K0FVeDFYS3plN2lEbkJTRzRxWFVpYVBDNnlLN3YraXZyMTNCUTE5UUV6QVQ2?=
 =?utf-8?B?b1FuRXkrTG1EQUw4VE1BSy8wc3ptc3crTzBEZWxQQTFHYWUxT28yMFlSZDlC?=
 =?utf-8?B?TnZIays4TzFSTmRQeXFHZGFEb2gxemNiRUR1MlhlcGhmSHBnK05WM2d0Z2dt?=
 =?utf-8?B?UlhLNTI5S25OSWY5eW1TTDBvWDhEbjhBSEEwZEYwYVY0Y0hlUEJQbFNCMTcw?=
 =?utf-8?B?QlFrVHBUZm80MTc1di9ETEtUVUxFSUlLLzN2NmpkTEtNRk1DQk5Ha3g4clhi?=
 =?utf-8?B?QnZ2K0p0bHBaUC9qRFRaTzZDZk9TbXBDekVXTWlwS1NvUG9CdllDY1VmYmRN?=
 =?utf-8?B?cHJNOGRlMVlTQUl4YUpHSTZQMEt0c2g3REt2N0twaW1QT1VnQkp2OCtsTTFQ?=
 =?utf-8?B?Q2dUSFFiQmlsdis3cHNxZlNjZlpXOUJuUkxmbmEvMWdNQjZFeTFkWWtxZ0Z6?=
 =?utf-8?B?bjN5aTFybkVudU5iWGdGZFUyU2Jrc1FvSm9zRXJYallDd0lkWURHNFlWQ2pY?=
 =?utf-8?B?Q2RvTlNRWFlWSXB0UXpOUVdrc2RKd0E1ajFLODAvR09GYnlqRG9FNEJDajZM?=
 =?utf-8?B?aUZwL2JZcit5aXJUbmlNTitiT2NjbG9oT2hDU0lNbFNNaktWWWppbzM5a0Zs?=
 =?utf-8?B?ejNwd3ljMVI0aUtQaVhXVHA2eldsRHI2bytQcVNLR2E1Tm80NTRHWFlCNnBs?=
 =?utf-8?B?LzIwZ0ZDdnNKWll1aGZEekJYYU0wTXIzV3RRdG5rN1d4STlKaTBWZTVzVk9F?=
 =?utf-8?B?eHpOSGZacW8ydm51RitwUWdscGlqd1hlNVdZbzhYTVJvdjY2OHhybHppNzRm?=
 =?utf-8?B?dzM2b0J5YUZ0d1BvNkJubDAwZXA0YnBPbmw4V1NWMko3TklUTFhVczh6NXI3?=
 =?utf-8?B?VFI3YmxpY2Zsc0pUTUhRaDlkbXFEUW9QUTkzL1VHVitobERsZjRwUmZrRnJm?=
 =?utf-8?B?VnRBenVxUFlGOWVBYmZYQm5zQjdSbkhwZXRXNnhyeUxJZ3RCOXkyc05UVE96?=
 =?utf-8?B?Y28wWS9XMlNJandtOUpRSE1DandCYm16VHdsMTRBdDUyRXcrKzF3TmxseG5a?=
 =?utf-8?B?VEp0YnVTc3oxalVmZWZiS25DTWxCa2c0VkJTQ1p2N2lnQ3VGSXZmT2w4SGor?=
 =?utf-8?B?UDFtejFYZnp4TmNRUkZSVFRaUzJmVDQ5RGhHaXBJbHZ2N2M5NE1Zc085eUNW?=
 =?utf-8?B?YUNxNFZKQ1JFR0Q3SEpJZGwyT3ZRaUVyalY5aHp2aFA1RDk0aDVzUzhTQytP?=
 =?utf-8?B?NFpWLzlObnkvNkczWkk1dlJBY29iS3RBbXNiMzZLY1BiSjl6MUhWVkxlcldz?=
 =?utf-8?B?dC8wY2x6eGhBZDA0RHZsVFNzNVlUbjhDNXFDVnUrK2hscUxaemk0bXluZkha?=
 =?utf-8?B?TWVLcENGRWtFWnJUMXB2R05QMnlsdTFMZGN0U05nQzNyeTlyRjZmWWpCT29L?=
 =?utf-8?B?UmF2L0hVajU1S1k1N0hJS0txL2xoelhwYjkwTWZjbjhrSmxYWGxsY1h2T0VS?=
 =?utf-8?B?QXBjUklqWWppRFc4aHBQb1ltUkhYWmhBdTZ2aW5NL0JMVmhJdFhES3pxSmI4?=
 =?utf-8?B?WEVEdGVaUHU1d2FsWnlSbFRaTFZVYkx4N2kyeUhGNi9LajJuREJIbE14RGdy?=
 =?utf-8?B?UnlHTmt6NTAwZHh6OElXdGdQUVZERjlBTGd4YXc2dVNaOUYyN2liaGVNV2lT?=
 =?utf-8?B?VW1CZzhuUDVPNmxhdzYvWHpBL1BRVCtURDIrRXkxVDlxRmxJdlZSQWFBYWVF?=
 =?utf-8?B?Y3BydjJpcytyY0Z5ZGxTYkkrSlZMejREUUdRV045S09vQXQ4N3g5SXY1bTZF?=
 =?utf-8?B?RDlQd0NMT3cvOXJhcWRsclRha3F3MEllZUMwbGJtRmk1NHdXK3VVeDlnK3Yv?=
 =?utf-8?B?QUNJY092ME04ZXZqSnVhWXcyU0tLR3dnUnpBellNbkxUcHZMRkRiNTUybnZF?=
 =?utf-8?B?bGtlR1lMcHE1eHJLbCsxRXVyZmFCdlhaU1Z6YzNtdkJkYUhramU3K1d0Ymtv?=
 =?utf-8?B?OFBiU1h0OUsyN2Z1ckwwUThwTVlvVzVVTG5ERUlzZ3hPRnV3cEJubXlFZG0w?=
 =?utf-8?B?SUVkZ0ZraGFNSGwwaVZ6aXpHMlVnNEgzMlE1Vkk4dHFzY2xRNUR3RDRzRnZI?=
 =?utf-8?B?aEI2Tzd6UTR0Wml6ekJ2UkV5RHM0aXJPUXEzaU9nVGJQUEk0VTdLSVU5NTJu?=
 =?utf-8?B?bHhwSW51d0FtK3RGYjE0OU83Uml4Q2kxSG40ZG9meFlFZlFsN1k5UT09?=
X-Exchange-RoutingPolicyChecked:
	yAsNjWKIUEHRfZVUNWvYS2fV+r4b71LMGU3LP9wW8C9gscmoOfIeudiMbJoSL+FH25IBjVtJ83XDvarPugdR8fNGvR/GxjdslH2a+2ge3X5OKAVQB/4n8iCEFE0pVoorQszm1u5aHLlzx+BgO6cmzZeOWGkywS4DqIzM5ohkjzbMRf2jxi+fqMNkf35Ajg3MF3S6KmPkSMezwhYsYFKRYPbjqKJRQ7TK8QMGp0k56i2rR6bBWAPWzQfijbp+GRzQlU9IFookk/KScWIEUDcx2aUCd6zxyDbxRS1xSJu7VjYoXo+tMOXz3ADCCgD54MLJdZ7OaEwxjJ3Y5/ogEboILA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65585332-6111-4df6-ba39-08df2a13ca9d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:54:20.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XW0+QjB+VFPnOHOSxZJMxPe84DkfG3GLmdA2+T6B8ZtlbTgRHxb/iOrFGJXXuZ63BLx1IwmZv1kbKmaCcFWwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8350
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXzaZhau7g5/hk
 tWEchMkV1EpGjPQstxLQd0PFxpy5tz9NBIptF4rdpYwKtlxfGYPnZOdiyyTyPZW4MzJ7rW8C8pV
 3dM8v7JJH6EG+vKR0k3b5/s6k/rXMpFtaTDwCy7zN4uccpO6PdGeXqggyDNMVZlTSIRXZzt4q5K
 mye/BwReJwz+DMYx0kVtaZi9miJcAK/+c/Iva0v2CRgJkz7oFlPqmulXDazvnAZx80vXsZQP739
 G0H6eky7ALkEfxKbxfGU4iQhQ6Rx+XlBLTwxUCwKyH6DrIsXYpdUyXpGzVZoMK//5BQm+9EB9pL
 I2FqXCrH+ruL09DtBW1FCofuF7d+4vu0YXG8RfzMhSSAnT1BnSqilPJ+N2xWx/CGyQlzeH/zyBv
 YAe/MLcCtffHY3drUCV5emoBs95NuEEuFaL8d71thO26Wg58gpAW3vZl2KrEV3wYMc4RWJJZAGL
 YRPu4GcyKOa1G6CrAJg==
X-Proofpoint-GUID: ufA8ftz-mnXVc77dRdEmLmXtDMkCZCE8
X-Proofpoint-ORIG-GUID: ufA8ftz-mnXVc77dRdEmLmXtDMkCZCE8
X-Authority-Analysis: v=2.4 cv=DYeCOftW c=1 sm=1 tr=0 ts=6acfb3be cx=c_pps
 a=CJt2AWVwLbfAHulDA2arTw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=vyyfZZIEfrTZoA6lZUQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX+zLYv+myi4Bt
 lWhJU3XTrB0AhcP3sDcmcGnKb7omYT9NTEsOOo1XZnXGxXEopUW1IOuAyV+TI8mLvMZwrqSEsYr
 1emzp6RYWAnGjB2zn0Ie4g1hGfRKrs1MChtECGlBCi0C++NvMjs1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067

On Tue, 06 Oct 2026 15:17:01 -0300, Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> Protect single-sample read operations from going wrong if two or more of
> them run concurrently. Serialize the data read operation so to avoid
> single-sample read requests disrupting each other.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
