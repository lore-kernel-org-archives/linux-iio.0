Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB40244665;
	Mon,  9 Feb 2026 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770639216; cv=fail; b=cvgdVPBJhPTsXCNR4+3UPDjqnpJKkiJ4bzCbeyk90RPn1EESyuBJn670BpxgAsKcedohh8K9F92tmum9RtDhBHuUGe9Bol8qarPcEdyk4aAV58u74TuO2nEohTYFEzGS5xihJtITILJc9xH4faIcFZiYOm8wMua5ADqG2FuV6OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770639216; c=relaxed/simple;
	bh=ddlT+WMyzA2lsYQA08qt+LiF0m/WrnV6LeAe0mq047g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qfFepia7cq9a38SqAZ8lFUAwwmo0PXy4IPRLgTxVUYcHwUFXa8RtSkCu4qxCPQFeVHU6asAj7zqEL8SWZQ8dbGWtvXC42jEF3iMepZQu8ovU2MUES9g4B+uqWmfuHah1OlrP47HJ9vgm62qtMojStIVgHiFH/RnFLZiaKoPQreE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BmU5fwFp; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BmU5fwFp"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6199IaDD2582255;
	Mon, 9 Feb 2026 07:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hwIbw
	dNN0Y/wrbdq1aQjelH/MXFVAAN8BJnyQofcZ1A=; b=BmU5fwFpR1cJdyXBozVBq
	f1ANUAb8iKU3ifR+/scXF8WAAn8lsohlmMNYH5PkPCTu5MXbV8xAheEoqyt7CRjc
	Cxsop5aJ+rxb5WXhOUrj4JlMK3cBWBwEt8LwTE3VB1YFlJ1Gpaf/5uGwLlbXYRw2
	oT+T/6AZszcpXf4A54LBjlmcYVESi8E7zXD7rmGrnph7xvI45+liKgM2X5m69CG4
	+34Z3ARBF0QzW/QxbLBY4AGx3xg3WDraL+tTGJ5vOJlvaezqJOocVPdAXbG2FZkc
	E7yc9XPvVfqLqDr0tQ+j1zZAsB0UfBmlF4n01ljfXZdGnLojnCa3quXizD0Rj7nV
	w==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c6xgnk9dx-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 07:13:31 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSIM7NpSboNTFjCqHNexFiq5za7EVImyUGzY4iYTZnodVjzbJ/eSU6NnRdbll9mkzWuMvKlGQpsex1+LMFyXM1Nv8ZLzc/CtItoPRSq6n4ELjlQfJFE/u5qIKV9ljUjm1oaO0gWcewVRzAFOonEYcWASZL/rD5+yzzFaY+DWwZWJbaeg+Z37qFmP0sgto8dQhZFIhMTT2IsjNgyThl7AAQIEOIdTLewo9mSCv7SBarPprSS3ezZVh1g6TX6aSYdrTUFxerATYcNl6Ojmdv8R19Gyqs5fyYCeNbODULMzqsw4SuukbPFlEJV7RGgpwFm748S03Zb3y8nyfpQORMozhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwIbwdNN0Y/wrbdq1aQjelH/MXFVAAN8BJnyQofcZ1A=;
 b=SJKTOWTaPvOVsHfZJ/sLgF3n2bhHcxUKctflugX9Nqd3yZjrt8kckrizqAE2+FkHVYlFyWYQGS1ocHlD/8oB4jvppecqe3zg8w//rGCZjGVP/a8eK6h+kgB42Tl/KtsfArqtfEvM937qoU0l6pSmb6LxEELmdi9RPJ2C8E0K7VVdtZwFzvKuSnWWqxv6ThsbbIkColDO8QL+hzqtmOu9FhzS8RoyupD1nwaRVeUbLjMAC57fIYLq5sO9NtxcfbFPsOdHwVZAHrUdhPAzwmoZGtrI93mtu/AQCYpyHPSigz6WvUdRt+ghhwcTZ3nECRSCXEiEpzp5EksWrQ9BXaUalw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DS7PR03MB8194.namprd03.prod.outlook.com (2603:10b6:8:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Mon, 9 Feb
 2026 12:13:29 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Mon, 9 Feb 2026
 12:13:28 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        Linus Walleij
	<linusw@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] iio: gyro: mpu3050: fix pm_runtime error handling
Thread-Topic: [PATCH v3 0/2] iio: gyro: mpu3050: fix pm_runtime error handling
Thread-Index: AQHcmbuf7kwgy8keWEy37ajJxLJgWLV6RzpA
Date: Mon, 9 Feb 2026 12:13:28 +0000
Message-ID:
 <CY4PR03MB33997BF46685A6E43BF40EAA9B65A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <cover.1770636034.git.antoniu.miclaus@analog.com>
In-Reply-To: <cover.1770636034.git.antoniu.miclaus@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DS7PR03MB8194:EE_
x-ms-office365-filtering-correlation-id: 1b0f22d1-56ec-4803-68e1-08de67d4a271
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BIjCxwzjBnyunFXXuyhKOx2hCmBSOepbgFLZiRX2aH71jZpaq78XSeQnc1Pj?=
 =?us-ascii?Q?QSnR47yd1JSSM0pnL4WaA5seArzCfpGLZxz7fE80sfrEungxP5/Wzqc2PUCL?=
 =?us-ascii?Q?MK482sHi9OuKLjlvV3lEYRnT10FxxEXDAjgSC9sV2l6EExdNrSREYZVyOXHL?=
 =?us-ascii?Q?D9enmedQst1tNHm3v9J1ynU8e0Qe4CedBJ0fwOLAMghLxDPe9Y0FEKO6mf9O?=
 =?us-ascii?Q?a5OwHFHmoiJETjmV8xeHJKjXLmo3YeWbEpLLjISI2tPSqp8zfSHu/8yiJ2XD?=
 =?us-ascii?Q?fxJVESebMmCByBm8G7bTywBh8RsybdtuFLkJuVF8Sd0IyhY1lVdiRdafXTLC?=
 =?us-ascii?Q?RbIWkbrWD7xeExd4H2KMwDVxqyazqW99/r6NP5Q9QI2T8eCWCY23F5H2k8bP?=
 =?us-ascii?Q?OUxivr86iTG4WFW77W7B2Ha/yifTP+XARRmaSJdDUVv8WSRRB+ILe1GbSoIU?=
 =?us-ascii?Q?Smp20Qebd2pKHKLhKiozxhNqKa9HXBM6LrLOGAVdhP2OPQUS0gx2MyWNfbGQ?=
 =?us-ascii?Q?GLtTZnrnXtwJMYOQhD5qnWPNM+Wi9AH+MuLmXJZlEwyVAJMGdRbIIITrDPZb?=
 =?us-ascii?Q?U9pUMlpUJLBLRMSF7RPG6oSEH1HO3tLeBaCLTKtclz/PkPMARPnpxwI8AtEY?=
 =?us-ascii?Q?4Wt3T5srHGRyXRm3iC2/LL1R9YuWGwYsRLHpovYeIN8GXAXP1Cho/qjj1Xzu?=
 =?us-ascii?Q?H6bj7FmxPej9YJfeM5E23qdakDG+kdjo7wdGiNCmSZFTXD0BUMPjgSPwxv5Y?=
 =?us-ascii?Q?CnBBaect1PBIyrI3VYqM4Vt38FgUgzmcV529OutCEYS3b733VAA+Xm/FSc9H?=
 =?us-ascii?Q?uqrneMMtYVwjP4L6iwZcr5qAAeHT63GkDQvs5kJ/2wLDrMztKuqGULsBsIyX?=
 =?us-ascii?Q?caHoATscKpnELEtYEtbZb+0Hck1V+Q8e9mf8+AV3EvQyGBFGpT8OsreOVk3D?=
 =?us-ascii?Q?MbsThCE8PF68XbhNNdq+4NryaCczjpkc5RuNDLLJ8EWcxUrFgszExYhkdPCG?=
 =?us-ascii?Q?Fd41b+2eNZA2gWMHBs+eRxYP0SHmbuxQGy9xqrVOGjXOZGfbu49PaX8r+YwI?=
 =?us-ascii?Q?wzA5qsH7bmGTT1nsv4lAmtGZUZcHoJ/lUEZfjP3gEYrkWWa9rSMIki/t9Fxv?=
 =?us-ascii?Q?UhQvYEJ8fZ7xBfql4ZmmDBfyy3bzpBDCzW3FLJJJVLE1fDhZM+dX4mBS0bQ0?=
 =?us-ascii?Q?b/cWQZB9cmi6FrZnp/dyNDxDOxuiiB5HHlkQ/J51NZPkbyiE5kCgvB4+6ltk?=
 =?us-ascii?Q?4Re0dkorAXNUseABEEG7YqOG885yO+dHwHlJ1PGp6ZsueJtVJr5krEvNbJq9?=
 =?us-ascii?Q?8CuLQRhCa3wbV9IPZCmpkVNfVNoN5Mx8H8NdkZBMB4NXWcjWO/o7Hc9B0NcR?=
 =?us-ascii?Q?mVvvvxxebBP2MlkyJxZlsYibsoAgMkkPmvCfmSKZHPwgUKcMNGjSjjQb8N9r?=
 =?us-ascii?Q?4hQcYxvWoWoy48ATs2qkTI1aGVPhK89CplmL+6n60ij15NoX4l6s8B221Aba?=
 =?us-ascii?Q?PCSxdtrt3npkoBFkHHdMj3gqcoKYqx+HfZ5NdL5b3lAwQTd4CxIgoFWLmHij?=
 =?us-ascii?Q?hZ00gj3wwueo2lgQRLokvhwiEbyT6nFEaEP6Q+MF06/pNVIA9OIullTEp9Bq?=
 =?us-ascii?Q?EQhXVXV1ZwCp0MgHgxqALguoH+Czv/8SqNd+E8eXv4O0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MvsSrnUERxs5OLyaVi8vWH2sQqZ2AV0cz6npnFPFWcDyJt5UE97m9TJ4sTTq?=
 =?us-ascii?Q?mviYsDApxufKrtNkqFrKkPgREq7M/+MZH0J4tKGMpwRZbp9OKNKEKsgOEAng?=
 =?us-ascii?Q?NyTRXGeU21Jm3XhmzsXpWhxjQEz94QNO6hd6h2v0+vgzp7EddksHzinDVOPg?=
 =?us-ascii?Q?M7ezPxV4txt1h4re015MHFqwsx6ssDwJc7SXWVCC+GShbmDrqAlgRphrUYpF?=
 =?us-ascii?Q?HsiJ4QEpuvO4wk5GBL+yDUikDn0kosBMlD/T2oBsjoXm+ZXVwv4bJsi05G3i?=
 =?us-ascii?Q?b8HprYgEPVjzmdBx8ydK0zoAk7mPUmqIRlBheztNmfT9tzqQ070sgcOhX1si?=
 =?us-ascii?Q?1bk+nrrET01hcGop/zw6Aj34CnWLIimGIIlmjVdNbWFqD+l1uMXqenfxb2dE?=
 =?us-ascii?Q?fX/DVs7/Xq7xkHv4ZguKOil2bXWXEBj+R9dX9hz6rOqSBwu9JCYpb8jMJBpB?=
 =?us-ascii?Q?Nck2OSqJYWTQkfKB3qG5TxqNc6dMCd+mMDPRnvidLxLpwTYE25ikM4ClZ+n8?=
 =?us-ascii?Q?f6vY09rPTRAYhUuiXnNyRekfyI5fXx/e38qcQLhcFfVyfz+BfgaKwevxVy1M?=
 =?us-ascii?Q?hoArissWKkL7SAD+K+pKVaT4mHOi6buy3ODIM+27ms6x/qMeAEYxm+/c+OR7?=
 =?us-ascii?Q?rpQG/I/fZN99aOrf9R06aVixi9PKr2z9ExuzDJ0rZ0kILY14mso1QDWIxde9?=
 =?us-ascii?Q?J0gRwDdqtjBNqtewZJBDrx3hViG19Ilcb9Pq4MD+GbhceK5pj/lNMpFnqJ3j?=
 =?us-ascii?Q?ExeqeZgdGArv719H3me5pdluV0k9AjwKE+3AvQxHZ2bV4SI/JwDaBpi4pOrz?=
 =?us-ascii?Q?Oy1bGrM5fgi1A0HReQsyeshu+QsCPwDFnScq8qaeiHaCIABM0Ej7sZ59C2Z5?=
 =?us-ascii?Q?LKmRLvHn1x0bjmiJMTRpM1zKJ6/7ISUj5o6GEjGZoiYHHXW4POH2y7tLITjB?=
 =?us-ascii?Q?y8jeTSwBQ8dsE9gWcJ7F7TCcwtLeEYEDHFd/mSY20lkJoTaAdSpu49cHJwHs?=
 =?us-ascii?Q?LEC4HTtdDVW+EbAAbOgZVAfCAWOkAUh34bb8XYZenxatU+ybliU+KotKr8cx?=
 =?us-ascii?Q?xSaXhlOc3kLpxGR0mQ0CxN3muDGQJoN4CoFwl5TizPz1XlplY0/E5TxdLrr0?=
 =?us-ascii?Q?7VIpcGQji3q1qbhxDxEZK1EDWrw3M2GLwNPgV5YCxbsSg0/NafLGuplND7+5?=
 =?us-ascii?Q?r1oWU3PycjbSenLCOVgtvpxWNoSqvMs3v7a+zZT6rNVUy6d/eeHSlERmPqb4?=
 =?us-ascii?Q?w56by9gHLWIRnJ2ueKFEqv+paSvcBmivxJKKwXoNJNUll9aRPljuC2DmsJBU?=
 =?us-ascii?Q?Vzh1u1gVrnoErTTpDnP2scLEPVc2RGseUF0fob8H1Dw1Vsz5gdjH2fTYNupF?=
 =?us-ascii?Q?Jh+vmYp/i+1ItsFMxgj3lL+ppZzcWk02CksAYd5pWW5MSxzDZZvdAkhnF0+d?=
 =?us-ascii?Q?vFMhxZv4k0vR3x4i0KmAEsaE6UKFabcKjkZCTAelmMxvhco+Qm+t1uj9Y19+?=
 =?us-ascii?Q?myTtQ42y5y6gsDH1unxEPNvDdGDkREzrMHFgKoViOYpToG+XBXIqQuG614u1?=
 =?us-ascii?Q?VzXOjoqVaSOO0IufkIsVXH28qRIElcHfVKjsZyMboTx6VjACQuFs11q7SbxC?=
 =?us-ascii?Q?yhz93YgYXx/AMBK+fFr5dxC9wN1VWfTu1+fUrbfLHQdVYCz9BwzMFKQSpitV?=
 =?us-ascii?Q?whc1WYha4gOIZveOjBghzQ60TmmjHBfNLLN2f7/+LuhnuvJtwOS4UR0QFnjN?=
 =?us-ascii?Q?Duh7B+1OXw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0f22d1-56ec-4803-68e1-08de67d4a271
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 12:13:28.8859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzufcN27dOZbvcpTeYisH5LOCd31mA6BovlBezoQ6Bs7F6bvXj5p9ksdGY/79ViuAyT5B//t1qjDHaWJeofk1h119eKrMt0m4VgRgGgtYyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8194
X-Proofpoint-GUID: 2nKBgP8QnBUXdZhejFTO3ovYGp92Ny7B
X-Authority-Analysis: v=2.4 cv=YeuwJgRf c=1 sm=1 tr=0 ts=6989cf6b cx=c_pps
 a=+HTpKnCyMzx6Y2VIV8u7NA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=8JbS7x9gPqfSyyMVoc8A:9 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: 2nKBgP8QnBUXdZhejFTO3ovYGp92Ny7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEwMSBTYWx0ZWRfX9TjH9JjFKGjN
 FEJMsUPrJ+jd7fEysuAiglcWEepx6OUc3uTsvydaAbXuwotNQLZXt+oTKpSg/l8Y7ndVYQNcDQP
 pYbqT9WVF7lU2RT5P0H/KjWtokK0ZqoqhlpAmf+RK+P+G8hseG/0bg3Kr9f3JfhcsMeRopu2y9t
 995DemOYqhVINiVcQXEIY2gSkAI3+qW4J1zsbV2IEc0etJe1xzLzyFDLTsMy5IXGfi8lXQ6PV2y
 UPpqCm0U9WBr2CLPfoaHLUbA+nPTennp+MYJ0pnOIpsTDcDssosiDIn6Sb9tsf9LEZwFMBZggJJ
 BVqEUTRPaRgnztCadVk7IeyC43OSM9JTnEkq/wWQt9iMVvzXeXqeMK/7Pa204yfF5uopn+yQwZd
 5dLaOzVF8PYBfg72h0vhCG9Hy7lFv/XSSFStl/1x5j+shl/61UyqHHOZn14cf5AS1pIJuZBT87A
 OdNPmeo2+kzQn45nAnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090101

> -----Original Message-----
> From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Sent: Monday, February 9, 2026 1:33 PM
> To: Linus Walleij <linusw@kernel.org>; Jonathan Cameron <jic23@kernel.org=
>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Subject: [PATCH v3 0/2] iio: gyro: mpu3050: fix pm_runtime error handling
>=20
> Fix pm_runtime error handling across the mpu3050 driver. The existing
> code uses pm_runtime_get_sync() without checking return values, allowing
> operations to proceed even when the device fails to resume.
>=20
> Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() and
> propagate errors appropriately. Unlike pm_runtime_get_sync(), the usage
> count is not incremented on error.
>=20
> Changes in v3:
> - Rename patches to focus on fix rather than API change
> - Add Fixes: tags
> - Collect Reviewed-by

Sent by mistake, only the cover-letter. This patch can be ignored.

> Antoniu Miclaus (2):
>   iio: gyro: mpu3050-i2c: fix pm_runtime error handling in bypass_select
>   iio: gyro: mpu3050-core: fix pm_runtime error handling
>=20
>  drivers/iio/gyro/mpu3050-core.c | 17 +++++++++++++----
>  drivers/iio/gyro/mpu3050-i2c.c  |  3 +--
>  2 files changed, 14 insertions(+), 6 deletions(-)
>=20
> --
> 2.43.0

