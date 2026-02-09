Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C036BCF5;
	Mon,  9 Feb 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644407; cv=fail; b=m5XzLuj3jL2i5TILbkwk/DBhSqSgf1wpw2Sv0q0Gi1/wu/vFJg+f8/h7WK3UESTvus8UeQdMjMUx//DquOEvXcU7yNXDWVsX+viZdxjir7OB61dslNsoAvPULYh5RDiFs5XA4oj4zmWcvgkeLxUNiW8auY8WIXToQP/DdMm+iag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644407; c=relaxed/simple;
	bh=c5HDfh/qUPf9s7vQuSJFT4Xp8zlJxD6EFR8/2rl1t3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FkGP9Dh5GlXcgQvH7f07g/g9zhX7KXvi5RXDbIQ1g3hOO8vEjL8/iGpsuInIwTOqqco6+4nVimPbx5NV4n0X/RE+ccRGMnjzIKoaNGcJsRaV/PDct1IzxbK4bTcf4Z5zyMasH9dH6h/GMJ8iCxN1WdtUEORIrsIoyubAJw0fsh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZU13rl82; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZU13rl82"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6198kSeh610730;
	Mon, 9 Feb 2026 08:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=c5HDf
	h/qUPf9s7vQuSJFT4Xp8zlJxD6EFR8/2rl1t3g=; b=ZU13rl82tkBz3faZnKCUS
	qy+Ij7IhSj/cfD7qfrpTY+W1CXQxJyhnb2mA7U14bQbhD6H2ayptGiS+82GQXGg3
	268IcwUpU7N3aD/fwHzBPX0kbvKcGaKSa1oLUVAYfGNjmjvEZSLED0x4zMZ2l2EX
	SDrjSgX00DzOgKbzmZSOuQHhoXAJimcMtNEEL8GgPIjoAB0kJ3crFcaVpZbVZaLB
	Xk3nu0xrFQm1N/31S+MPU8SZaeRHh3d1zeEyXIAvx2dDcz8DXUxwfCubL1PzQvV6
	wGLeAQPbxwqIz4vqrKdrKLAPR9MZ01VXp82ueCT6syzgWMDpecUeFUvGXAiKdDdI
	g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c6xgcuhfd-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 08:40:02 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOIzK4oLPV7VjQzqGWuYw3BWaCbBH3CIC2kT3KdF+UIKDNieUMuFoUnti1G1V2f0T/6SxEHNJK1UagtMaXy5SreYpevJoqI7+wCTKATGF41f2u2QUWRfP3n6lHWvlOSgLLxYZlejrEcyqT2mNIXa72PMBCnC3wM2cmdXH0vS9VaibWQikmCbJJMBsst5+wJmJZR6ep2vhkz6DD2h70+YHBYTRHiljqxhjuiky3V58fxB6vEeRTap57hUoEIsaEN1cJNpX5+k5KJoJnHoxKfJsXY0w6re7UnBzvgmC2X7QIMtEwmFFUkwlxV9uQiTNfL+FwcQEcHth/DauAw58il72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5HDfh/qUPf9s7vQuSJFT4Xp8zlJxD6EFR8/2rl1t3g=;
 b=w0+RMEhHbsK1CDqXUdoGowhZTTunxyUCFJrXNWPY+G23B3Aa9AvhovuFKaQ83YSJoJVDmc5loRNO8x4KsX9nmU9TiGywchX2R66aVIlVRf1wouNIwh26iIkNf/wPuNo+bT/gif39aIG5twSpk0TGAfZYZNXPRlsaSPYYQDodfQ7cywvpHiDqHOg28zzuPlqcsTnfooPI6K+CvrauY58QShs29eOwQQxoOKU3+vaKLBEXfGmFU/jKK2npS0L1y18g369luUmOJq0FiPJybmwt9r0ji2D+lGOANt5XHc6J8Gob9+ZCfDYMSzyq1GU+zt3cbZc8vMnwMZAWGn5ndgiCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SN7PR03MB7294.namprd03.prod.outlook.com (2603:10b6:806:2e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 13:39:58 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Mon, 9 Feb 2026
 13:39:57 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] iio: gyro: mpu3050: fix pm_runtime error handling
Thread-Topic: [PATCH v3 0/2] iio: gyro: mpu3050: fix pm_runtime error handling
Thread-Index: AQHcmbuf7kwgy8keWEy37ajJxLJgWLV6RzpAgAAWQwCAAAH1sA==
Date: Mon, 9 Feb 2026 13:39:57 +0000
Message-ID:
 <CY4PR03MB3399C98D6EB02F4C087534B59B65A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <cover.1770636034.git.antoniu.miclaus@analog.com>
 <CY4PR03MB33997BF46685A6E43BF40EAA9B65A@CY4PR03MB3399.namprd03.prod.outlook.com>
 <aYnh1IjCfeZz7BH-@smile.fi.intel.com>
In-Reply-To: <aYnh1IjCfeZz7BH-@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SN7PR03MB7294:EE_
x-ms-office365-filtering-correlation-id: 327cb21b-3421-45b0-0743-08de67e0b756
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?wB2RT4JuoKLKTTNQjJTKwNeitOZIiO5wUlG0uvi4+2RoP1NVncpznz1BWP?=
 =?iso-8859-2?Q?YvSFFie5ubaqv/lCWqzeYcF90EiKCarmIQ10YEzMNd6By/tUFD+i76iuIh?=
 =?iso-8859-2?Q?A7gh4GAC+3SJ16Vjdabtk+WEEsg5XxH/XyTwrwIv9clomchDtsrpEhv5bC?=
 =?iso-8859-2?Q?mi2N5IqncSgFf2q9F6nhhbbmtnvBIvKjWsQGSEr7eGYBeUU6XZh1GiKzk/?=
 =?iso-8859-2?Q?UHlVnOHQHTn1M00Tjt1AXcDsnxT8TE/Def9VB+fWesa7mArqEv0tPQhylv?=
 =?iso-8859-2?Q?rBO7kwZNzGXtwWvbFZ6Am4JmacEurbMvNKCzM10YeaJMQ7tudAIjPntuJi?=
 =?iso-8859-2?Q?PgYFFe5kHKvXUhCO3+jnxKR/jC5B2aBaAvWKEKSFs1XLCW9u9I7I6xsS8J?=
 =?iso-8859-2?Q?L+Ci4E+E1aLxFycRXYMyE1agvgE+VsPR2waD74S+TcZFJTxLCd/oVnkyKw?=
 =?iso-8859-2?Q?omFq/lZ4sAv5SKI0PeVNPPCqNgzSnOkgJ05nv9Z0xLZYiFJEuixaGMYuV4?=
 =?iso-8859-2?Q?4jtURNbTM20TTqCUccGEEpYr7eYGfCCbbovE7Tal167kBzTCTT+hAOvKa3?=
 =?iso-8859-2?Q?5x5xCaOm2agzNPf50Vhik8TxbD7FF9JewXHcHM20tbWtr8+RjdT5FUpdGN?=
 =?iso-8859-2?Q?C1BJ5y65HaXWxJTBtdVHtNxnkKAGhERI5nkSJcZCyWfZ1ExVEtJbtoo8KE?=
 =?iso-8859-2?Q?f7InkHCrXZVNgePtGVFtAoTTOns3Nzbw4NTnDM/OxrPptXC9/AQRjAgEfP?=
 =?iso-8859-2?Q?2H/gqEZOlnyAMuopNWoyjs3piSZBodwHAMN49g709GXXKuk7AQxVF/NMm9?=
 =?iso-8859-2?Q?H0aiLxtSqazIF4YguRbjLFkRpTmmgUxbNY3k/ZeZJjjVUCnfpHTI6dHFLj?=
 =?iso-8859-2?Q?QxFd/iIlTrj3kwpg7xX4VuL+cO2tDC/Wo2zc0jPqsSXA2ie2JarH15q30g?=
 =?iso-8859-2?Q?+iWUxsYiXPthiqH+9Ye+RGqsnJAYYnPNuiWwmp3+tUJESIs/9mEo3A56Of?=
 =?iso-8859-2?Q?tL2vp4ZEBtNFuOr1ZsevUazlg/wPDOB+ORPV9+iCI6Kcq0bk2CoW9lvM6X?=
 =?iso-8859-2?Q?bqjRXd6Kfyrlcrr1dFYCrZRdJJB8cK7Sm8mHoT2I1E35d6L6RBBSrrH61E?=
 =?iso-8859-2?Q?+gIHKf9dhCVm3cZpQdfGrCVNzP9FJ9t1wGI8j44rNusWeJKIG5Wt/Ufx1O?=
 =?iso-8859-2?Q?MWcdPf43CfIq/IFYGfTZX+UyRTcvfbA3/h4w6HKMcFVNTsCqyF58rSZLI6?=
 =?iso-8859-2?Q?FrZgclV3dI+NOH/+22md3jwxrLVEv+kUeAqct+/+XMT4OW4wAsFI5UDWFf?=
 =?iso-8859-2?Q?UCDTUrCDOUkzfspfaLhgfOhwRa34Ygz61bRizAPB7C+7pdjHar4HqPq/9m?=
 =?iso-8859-2?Q?yR30qXIOsT30DkqJgGyfVH+qavLTid5rw2UkqjzdOSOfbcH1P+7efn1C3N?=
 =?iso-8859-2?Q?MBykKnKS7TjYMDrjgx8hfvempB/49+xiPIXdZpDnAjwqGboQGNjxgo6lGz?=
 =?iso-8859-2?Q?I/5iTpbUDxvSA4RGtJPVrkDbA0zUM92XxlLErtYUZznhdQxgRxQSZxmbMU?=
 =?iso-8859-2?Q?1GXBK2rEltQhWIM5NJb3g/h+RgWYYXgtL6f9Is7KLfLws0Ub3KOCJjwtmv?=
 =?iso-8859-2?Q?NFoqLoukguq34uoQ6pa+49D/z4GORcdhEhVcODouZUiyDVkdp8yXB+zdnP?=
 =?iso-8859-2?Q?FIFA4soU8hpUOgqsE2U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?FpNwJ1d/sICoc796z7wxqJyZwonlUGbOgQ9rXe1QVBHLqscwzfiZ5J1vpb?=
 =?iso-8859-2?Q?jN6lDjNrTeX3gLggRl0mSb28jRanAYv5j6cBNXV096xLfotefyBi2irv9R?=
 =?iso-8859-2?Q?KrDmlhXZAECTTvXQE/1Oc6CNuBhDd7i/e/BS5AICvlvOl9LRMFKABAU3qH?=
 =?iso-8859-2?Q?YXAx8JK7Ve0PZcx2c+ZYYTDHAsDlGf/9guX0V+f/I5GCQc0Hqg4bArwHTi?=
 =?iso-8859-2?Q?gaEqqsvJS9pkeZqGMyhyJndisiRzQgcQWs46zipTx+Hr9cNDpjLR9ef9f9?=
 =?iso-8859-2?Q?GUXqLrSHqxcYBUOlmCaodS6oy4cBZsfKqkg7isNq/8IQyRqrpWY9cDlYML?=
 =?iso-8859-2?Q?Isga7I3NcEXj4EfqyWJbjjGZAskVADQiEXyVHunqamfnWw+coCLqZSi0sn?=
 =?iso-8859-2?Q?g6Gip2mPBiF9U6pVoakZZWLJugUJ41JV44RGTneWppeMP+0Np6brgx/gTs?=
 =?iso-8859-2?Q?Ny935BXr4psxTsv1tVEFoKYe4SdTHqZu8rP0Bz6Oqmlyje++UJ5M1HPXwO?=
 =?iso-8859-2?Q?ECNHyB/XrJ7yJIqdCv4HlAcaxlr6wWdytxcVqisUFX+b33UT4gN481gpUc?=
 =?iso-8859-2?Q?u1j5T4GjR+bAjB1HgmEvP45EsWhxU0Jhghs9L50G8L24Jkdw317i0hn8qu?=
 =?iso-8859-2?Q?0Gji3sv7RamuMkwYuR6Hu6Xgm3EvjTIDq13p0FXuyc8dU57xXYZQ4ieNWN?=
 =?iso-8859-2?Q?uNrg76CEbbERa1sQxEkY+RZxwnlEKVP5D3iZOelKRalTRczoPFHUzGKr/y?=
 =?iso-8859-2?Q?zh4pLtvpxuuT+5uECRwAHg171aAf1hQ3I23gnxnIuK2dbb4GKJXOpSJFTU?=
 =?iso-8859-2?Q?61VwKF8J1Vq7n+So3HmjhhZHUiXFicbMX46JFPu0hHVNaWzZ5T/2ZVhEyO?=
 =?iso-8859-2?Q?IRQHf1Su4OkX4GtTXBJaRHYPIy9oO3UCC9TPYJ1cC4UQcsWY/RtZCK6Jqa?=
 =?iso-8859-2?Q?uUAVyoYlQIc15JI2Wwph+CCwvxLmAqj4gXBXXoOtkxjGOd7KmokDLACB0j?=
 =?iso-8859-2?Q?/T4mXWveUfI7NT9s4BiROBX1RUuyTylESjuMT5+YGe3NbaudTBoXMrqb5z?=
 =?iso-8859-2?Q?jYhMPinlSYowXhfuDLZKk80O9l5VZguer9FV6HFWNpFmWilBQh7qMJ+ddP?=
 =?iso-8859-2?Q?c+Uqjk7KdlBxaGSTJ+SE2Pxw9Nv+qkeGgl+d24kyFtdggI62zAFlB8x826?=
 =?iso-8859-2?Q?SledLxfA2f+5ZeGDs6v6/A1VzDNdrfg6ys8iwLgX6YIrerxCZH282QrT39?=
 =?iso-8859-2?Q?FuHNx0MuD240aVqJYixPm4nIcZXYi0Jz30o1XGoqyGpxF4DkRR3/h+tEmr?=
 =?iso-8859-2?Q?CXnVaS0Ub+7M8RQxlR79ygROy3qYSYwg9D9V5sQi/44Hk/57PSz1oaTT1k?=
 =?iso-8859-2?Q?Bszwz3Ybxw3IhgJ2FWxOs4s8+4yaI0BkfQ/50VfqIN3cGCLve0JWLSzlQ6?=
 =?iso-8859-2?Q?dMdYDHPEO0Dwz+dlbd7M0dxq6zADufR6u7Ga4RY3rQuE2RkaBYA8MdETey?=
 =?iso-8859-2?Q?SNPHD0gp54yy45RtgV//r/9OMUq3BQP+habuhszn5KJkmFeqkV+tld6f1f?=
 =?iso-8859-2?Q?hjJXZ7mG6xKXVhyBPq/uM9taCyhNVx8lGnBs2jdkNUwHqgYtls1nKaFvim?=
 =?iso-8859-2?Q?Ft4kpr8uF57bbQKnEqmpva7CfHH4ar/QxqNgeyFl9orrvk42+jMy2xwjQ6?=
 =?iso-8859-2?Q?sJOCKy2zC3dxXKT6vomr5zDk6qcw6/MKaKzHqcfxr5k0Mm0+jKe3znwWyR?=
 =?iso-8859-2?Q?Nw4K/77Lp6dHQWuHlPndF7zJfgavpm2R6niMNTfmLgzDUumijnINCmUXag?=
 =?iso-8859-2?Q?9qD6DY4olQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327cb21b-3421-45b0-0743-08de67e0b756
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 13:39:57.8963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icrATJ5xhT3hqeUFMW/OJjPNY+tIihS8ygy4tTHlyS78alGX99aqtqeGHSntqJCOZnfHJyhVF5Ria0oJjfe3yEJZjSh6+qFE/aqhUpldjO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7294
X-Authority-Analysis: v=2.4 cv=I59ohdgg c=1 sm=1 tr=0 ts=6989e3b2 cx=c_pps
 a=GYEwMlAgQavT3rNqZldEpA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=-CRmgG0JhlAA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=nSV_r-SEQ6_kIhfmslwA:9 a=jiObf9B0YAUA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 2FCqDw1I706ZNrCmNwdFwFiseSeTBimN
X-Proofpoint-ORIG-GUID: 2FCqDw1I706ZNrCmNwdFwFiseSeTBimN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDExNSBTYWx0ZWRfX4tNEGOEBgmgx
 5ptxrHErr3IoJtgw50CtY0D9C3lJD4zRPD2686AJF4ND812cWEDZJtpA8pzXj1adiOYxlZmsBX0
 Y3rGbG+yBdqj0GcVM6qGkz+vBDMCHzRPe5ZdFaMKS77dNYDV3/N1R471XFnks8+JyBeH+BSgapL
 Krnk8YwJDOAegAVniSrL0DnpKL/RODgVFn3qZAIM1/M72KW6jKkaXSxJWMCvxAVWaboO/xl6wcU
 a3yovFDkCoSDFYhRcGr2hxzu3gb0XOeftc91SZz4h//8KvADvpdwCaDQUvH3XT2e0Wqx8TbNciu
 svWkvAMsbP04lLgztohU1T8JqeR5AoODrhmyj45515iT2O7iyZjRdDn26QaijmOrbXQWFI1Oobp
 j/b90Q7KPbveBbGBBEw+LGbXN0g7Xs0wbgiEx3rvSMV0tNik90aY3MNa0R55qF8fYhCk7sH32Ph
 UJIbVwHCeiOz0GGKNxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090115



--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Monday, February 9, 2026 3:32 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Linus Walleij <linusw@kernel.org>; Jonathan Cameron <jic23@kernel.org=
>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3 0/2] iio: gyro: mpu3050: fix pm_runtime error
> handling
>=20
> [External]
>=20
> On Mon, Feb 09, 2026 at 12:13:28PM +0000, Miclaus, Antoniu wrote:
> > > -----Original Message-----
> > > From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > Sent: Monday, February 9, 2026 1:33 PM
>=20
> > > Fix pm_runtime error handling across the mpu3050 driver. The existing
> > > code uses pm_runtime_get_sync() without checking return values,
> allowing
> > > operations to proceed even when the device fails to resume.
> > >
> > > Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() and
> > > propagate errors appropriately. Unlike pm_runtime_get_sync(), the usa=
ge
> > > count is not incremented on error.
> > >
> > > Changes in v3:
> > > - Rename patches to focus on fix rather than API change
> > > - Add Fixes: tags
> > > - Collect Reviewed-by
> >
> > Sent by mistake, only the cover-letter. This patch can be ignored.
>=20
> You lost me. Did you send the cover-letter by a mistake, or
> the entire series? "This patch" is absent in the cover letter
> and for the matter of fact, there are two patches in it.

I sent by mistake only the cover letter first.

Then I resent the entire patchseries properly (including cover letter).

> --
> With Best Regards,
> Andy Shevchenko
>=20

