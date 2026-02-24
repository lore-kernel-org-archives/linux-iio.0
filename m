Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9DF37AA81;
	Tue, 24 Feb 2026 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931618; cv=fail; b=EyUYHb0iWlJfDvzcC8tEV1fEMBuZGJYPmOZJ/eclJsYkkJPbOraaytyZSpE2eQqnqTBn4tGntTmlug5XIC+WGS/zM32uo3RV0ljlWlIiJ7qXIqllp7uDnbhPegF63ssxiJvgJLhPv6WBuzaaB+60uB6AI5GojgZwAutLVVvLrA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931618; c=relaxed/simple;
	bh=ZQsznr9Ra50REjUBdRKaBAHU9wDG/0iSGuu+3+WkrD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Br/j2/GzE2smFUVazMagrLhBVCRYPchG64KjnC6k/2IfyQO/MYqTBbebw23zxZk7XRYDQKMmoMu9gwe9C5BpPuMcmRcemiaP4tG2xQQdKkuULHsXHSdhrxUoBAVibVX1tsy2tio7vwTw6au6D65vtizsn5hXqODddMcceprzGOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rP4x0okO; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rP4x0okO"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O89cLQ1743194;
	Tue, 24 Feb 2026 06:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZQszn
	r9Ra50REjUBdRKaBAHU9wDG/0iSGuu+3+WkrD8=; b=rP4x0okOlq1YI88OfkCBT
	CpmRs6Nmthgl8vBNv+m4pqoLTYUIyuAILOKUBLL/FLwvnwFKNutuIhHNckY7s47a
	Uuvn4lGifp3+m5E96Y6zlV9Tz63U4ik5NP8Bq4p50Q7kV2ALeGKSfsyALXrqh4gm
	kQGcmEquSKnWQ1cVRQ1qQ+kNWOHPO0Tz4Rov+GOjii6JGB4Bbwc4N3424G9ru22I
	OHJAqy73y0pIp5UxwmhzjopqgsoecxKCZihjLW2tBP+dcMyhYS1ZdAiQEGylIOZL
	gPGM8Xz5NAgKR7tE0ooo4P5hrzMl6o2QqK1fFpJvCTtVZRyYx/vRWdSAaR5YjiB1
	Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4qevr-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 06:13:01 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5tKmsDz/nnxRAcnc2Ab+zYQxq16JdTlJeZbrZ/eERtmFkOLksCYlTwGBPXc/0A3+5lFFoVNmGIB84SgFiQqSMGG65Gh9q0+wvOX86h1fQOiKlsXUE38fi7ZY7YuonXIHyn8jypjyVtOvveVW5sR4YVBAnWXO22T1a9ahzW49jFIXt/LibjYtpTnT7xVMt64fD8k2Xuc/7unTgXk8KFOWHoxPPaZXLBB4euFjgXzWMZG4k0sSfkg+0zSMNbXhoVo44JyVqKWDqEibFAJnHwcN6l/EyCcIHOmPVZUUeMUYaKrOe2a+bPNwpMEjGuX0R4y9tt3v6JW8qKz9hgt1Ti9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQsznr9Ra50REjUBdRKaBAHU9wDG/0iSGuu+3+WkrD8=;
 b=xUpwPmA7JoZmIDiplDxy4Pdew+tPJzl0kFVmYbKSZL2Jlbkb8t8upkev5mY5KLKkRcKI9pGT/qe0+zIQqSgSmRQ2rBRTGfjm7vaAdw8KIsxfTiJLdHFsBrx7RaudB5oHmnnzf0efHl5JyMf8eIAjq67aFRf2EmRct9zEwV7A+TnSV6dK3334TN+qtqugeN+71XRnA6M8/i71qpC5RmyoV5TeCvZkae/nTzXf0fGq0k+qSRelLR4BSlhiQTgBZul6/KXARJVFOGOx7xnA60hdmkn0pgLUOKJfSJYZZqIXCCe8BB3e+KnremtkaeEfxdp+5zrIHXfw/XfIHuf28uD4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by MN2PR03MB5229.namprd03.prod.outlook.com (2603:10b6:208:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:12:58 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Tue, 24 Feb 2026
 11:12:58 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH v4 1/5] spi: allow ancillary devices to share parent's
 chip selects
Thread-Topic: [PATCH v4 1/5] spi: allow ancillary devices to share parent's
 chip selects
Thread-Index: AQHcpOCmJb84+vMLtk+IrvyXF9SSi7WRoZAAgAARdwA=
Date: Tue, 24 Feb 2026 11:12:57 +0000
Message-ID:
 <CY4PR03MB33992FF58E620DCE44FE0B419B74A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
 <20260223162110.156746-2-antoniu.miclaus@analog.com>
 <aZ142CVjMQ8Dypnb@smile.fi.intel.com>
In-Reply-To: <aZ142CVjMQ8Dypnb@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|MN2PR03MB5229:EE_
x-ms-office365-filtering-correlation-id: 7b32976a-4f96-4c90-f444-08de7395aa8a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?7TNRYTqGZFH6qBNNfq243bXplelfApFFaGHTCXqnbMpFgLxwXJM87gsAr9?=
 =?iso-8859-2?Q?ICOLD99hP3OOFxU1CV7v/007MEdPuJh6xdvYdjcL8v5AK5/vFeS6m9I0MT?=
 =?iso-8859-2?Q?+6cHQQ5RE0DTiRGVJc4wBhBNzsjjIE6T100dxv6B3zdslzCuw+1mJNuMfj?=
 =?iso-8859-2?Q?KAr7b30NjQhfC5MFwVwWi65f7+qomVGbU0BltUiki82CdLThJV+u1omVmI?=
 =?iso-8859-2?Q?c6SNpR94sq4OEpEt2ZUEVvsxZ2nfW2rX3F59l2TArUoPK0WqcPsoArqJeB?=
 =?iso-8859-2?Q?vx4fC0ATnXSKJERdkKB+W+YWGMLICCw/noY+0ZO64JiptdC3MuyFBAxsg8?=
 =?iso-8859-2?Q?9doCYXyZDMfGweSkXUIeIpCLAnLqmKv74PLDKkiSUAZvItjjDFq+y0spz4?=
 =?iso-8859-2?Q?7u+0IhNJLGjT837PceQLWmYqqt5pN/2G4aILBNhmsZlxI8DdlZDdyCSUyV?=
 =?iso-8859-2?Q?70FhW/cxytwIkLbTwxqj7Fme8yyHDk8n4nhwARGLPC+lCZEC+l/HYFo0bM?=
 =?iso-8859-2?Q?qzNY3CFRkCaO1+/NCqknyGrpwyCDSb+GCdIQ/GW7JtrJTltmeN3n8wI+om?=
 =?iso-8859-2?Q?bEKlMlinW4UxOARXEBTeerFDy7n1Vv1L0qov0uM4dJ2kxb8x8nMASBKuj/?=
 =?iso-8859-2?Q?PE+PR88ZNnW72rKDP5Wtwrn4Uf+fVdzA9oCC7MMDTZQNLHBt/3SUium9yi?=
 =?iso-8859-2?Q?njF4TiEuNc+FEp7f0C+ToR4Oy2ba5Xw6PGKxsbG60mlnCny6D7tWmi7Fyr?=
 =?iso-8859-2?Q?McEHjrSV3NHfSUHidtXiuhRa/W38PdVMffQ6pK008CKYuy1fj2cf8LI4Li?=
 =?iso-8859-2?Q?CwTipJDThi3v3oD2tvY/9vmnhhC1h4YBsKd+Bq7ZA/wuNoF0NOmDGmklRK?=
 =?iso-8859-2?Q?4QeN4LHrq3//MDutGh8mEHn/6ZbVKomj7GOMIQafn8FB6p3PyfD7pSo3ZM?=
 =?iso-8859-2?Q?unzfWf0JlnohjqaVbJMygFQsQOCl7nOvE7XFFtvBvoOrmk2qIm9FQDxW2t?=
 =?iso-8859-2?Q?ikA0abWX32bpf8XbToVOyekjUDRLtkFbbBtM84Qdv3cUsXfSjCRsOlwvze?=
 =?iso-8859-2?Q?/ht4XwloLeGU5n8Ffjjb9xQiyUlbeLj6chHyhj83yEx3+MIZr9iBoS2Hj7?=
 =?iso-8859-2?Q?0nK85StTSzHafX2Nmev8I2NOZMNs79RV64imAy1548ABXpPWuiw55nWW/d?=
 =?iso-8859-2?Q?SeKPo4RiotBtRzhQdWLnsSdDi+yERRoWpsFS48jV6jtapeuhXXIL98jZ3K?=
 =?iso-8859-2?Q?X1vfFaThIIJY6DLxHXVXfjHdyPfgpOyXWgXgdFCGk01gnwSaIAyYq7awSY?=
 =?iso-8859-2?Q?sfH6mkLMI+WxJFL6jQZ5qs58APd9Xa511zvvQeRmDzoKDCSKxMw1pJ7FIN?=
 =?iso-8859-2?Q?qa6PBYm8JRUjMrJdzngq6p8Ngy9H2BWgcY+Bx4ZZT2VbH71VAtRGu28wc9?=
 =?iso-8859-2?Q?xfnllNxezJD+iw4bzvMK9oJVMDkNl0WbWc1iaG64AzWjWH0jAsdiKlq8MH?=
 =?iso-8859-2?Q?hgJ799b6F9haQk9pCPt4hzJRTC6WWfDsxI3ub6zEI+Arr8X50+Xs+0JMft?=
 =?iso-8859-2?Q?l7ebDR+q5bY+lMx29csefQxDGvcUUg0OBoczqzZ21aqxM5Mf57PYV1hVVB?=
 =?iso-8859-2?Q?5pxjV8tAgVnSJoDt0tv7zbll0KGA4XtQlyXfkFSj7ffb55o8pAcrhDot4S?=
 =?iso-8859-2?Q?qzZ/ZBT+QteYkOgDk6E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?VcVjtiRR8b/JOqi28zUWIrPQF6DYQWX4zx/wejlrqOpIiIeaKWYalLSdVg?=
 =?iso-8859-2?Q?lg3BLZmATd0YNY8M2scbWf5RVXEEEdTyFk6Wo9AYtECzcEeqZJoKQb/GrV?=
 =?iso-8859-2?Q?wWgrDB994emAE/2O8kW3kNGbSb+vYkSnreItFjh80zKlyATtvX3vNV52ib?=
 =?iso-8859-2?Q?DpM7glsezi8dpBoZMgrPhgVtBFO8GwDxz7s4T61fnbhoz810iOgjYLDBkT?=
 =?iso-8859-2?Q?MFwjrTr2ajkPDmtLDDmCUPlzkmZrDtlIGqwYb/Vcga5bBM7cWdz21jzyZG?=
 =?iso-8859-2?Q?tZbt1KcAtzbBX8E+ss/O7D48AuY+H/ooIbyjIJjzwuktkYR3jt0fAFhNBl?=
 =?iso-8859-2?Q?ryxatHzxYE8ZbMcCu5mv3thVkVo5wL42sW3WtTOOIwyJ12ubUoNVvewQsr?=
 =?iso-8859-2?Q?zqoCJcDswG4b/zcR00xj/+94/RS0pgyCHKY2yCw+3cSUEBPhk/C6L0sSEk?=
 =?iso-8859-2?Q?90fqHoTD0JKIYJRAj72Gx/yicRph+vLHxa1VpsJ6FUiFITvxOhn5ARKiYE?=
 =?iso-8859-2?Q?V0S3VJ3m0doE8koxSGdomt/w1jX/DQ0WRk29aTzcg1udDu8U8b15TtoaEi?=
 =?iso-8859-2?Q?0c0h7JMKa7/ovVdrDX8Z7C5wCNOFIhZY3h2T40QW1FPzH2+PwBw1GPgG0x?=
 =?iso-8859-2?Q?qfNT4W4V41HkxcKtEWhRyAK3Ywo3Wm7Og2XTTlh7vUoYOg6EKDMP8NvhxE?=
 =?iso-8859-2?Q?dtnbuaJCVzvwMp6n2W2wjUgF2Dqm4ymG/3BPpcaiaBB2k0JSNb7j+CBvFU?=
 =?iso-8859-2?Q?U14cwcuiBKvBtytFAH81qbSfUipOjzvxwYkdqkkDteQLmYrQPZognIY9av?=
 =?iso-8859-2?Q?m8qyyBhS2tpGR564PCHjz4iX5poHM2yXrutdPtcVebVGjBcTInCG8RUute?=
 =?iso-8859-2?Q?jMxUs5D+uURVYFQ5fvvAL7w2THbxwcxSZvHKRKl31c8EMpNoAiN74U6Vry?=
 =?iso-8859-2?Q?av3fK2qHGDrOEv1EBBRLEyVeoVZglhj0cXNTooe2b9eQYFBmELQILHtNg7?=
 =?iso-8859-2?Q?xUcQHZVdZ5a+drojKBJXy+Oo5iFSi1IFZZmZZBp8l3LLuVPtiV3zo7+/PT?=
 =?iso-8859-2?Q?jXT+a0COcOtTrP+LG5vQ6drWVaakzhluaTbvKDPJAxiJJhur2o+jYUBrOQ?=
 =?iso-8859-2?Q?SSBd9haENTyDB5ls23Zxp/lTX8BB0Y3djnGbJGaCED7jEo79na5G4hIcfm?=
 =?iso-8859-2?Q?WAhsFw1V2+bljMwZ32y/4CNuLMzTXtjkc/Fgq8cZnAs2oB2CU90JYOvDRG?=
 =?iso-8859-2?Q?k1ky8yf8mXPd+Vy68Kq1AVEYtsOij7CSM8u5uOn3cU60pZmDXT93RAGysP?=
 =?iso-8859-2?Q?sHIYNKcrcowSF4F2ojAxE7ILUGa3DzYR16tjq0LFLhKySiELGJO55R8/R4?=
 =?iso-8859-2?Q?ATTNjRVo/2mPg08+9p5xqjmYb129fj/ZylvoI0Yq9PeVI+4e9IB1UPcAAk?=
 =?iso-8859-2?Q?Wjgmy4z/arkrRFyFzRbfn8GI0cy4SWcaz/ehvM4kKqCnldXtI7JOGpF8Ll?=
 =?iso-8859-2?Q?303LpyNEdaVTqVnfQzXnhAtdaDZF3sffOxLhk8pBcPFbrOSbgTsr6ztfOi?=
 =?iso-8859-2?Q?2Mtm/VGgheFtey11bgX8m2f4q6DD86Xpo9u7lhRcZrweNent71bAryYHNI?=
 =?iso-8859-2?Q?Kt93Ua5eejofGqzFoev8ZQXeoXJ8YFITW2ZGkgQuY0iEp0WH1uuNE/nD8T?=
 =?iso-8859-2?Q?xE/OzEDx6OaDOhOWzbrgfEJ8JaeXID8pN7TbeQGGFBpE+RO3A7P4cXJBsc?=
 =?iso-8859-2?Q?67yapm3SAxawjtyanu3KKGxOUAwGUo9FoOmBOjuAR6V12RyJ5csPgbeekU?=
 =?iso-8859-2?Q?pM3DQ1q+Aw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b32976a-4f96-4c90-f444-08de7395aa8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 11:12:58.1274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HsTnfsM414z6Gz+WoR/jHcj53qKtGD03AfsEy0ZSHZXob6tvsti6wBrmLuAvCiJEH8TnXPcIvQQSeK72dvsDgRI2J5P1jC0IMjuS/GfKss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5229
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA5MCBTYWx0ZWRfX8Z/dsgtzvAwy
 j0UVh30l1uGVqDEYgw+oTl1iP/MB7T5YAa/PRH6YjzUK6zlDmKYmO+uEMSN1hIMj4Ki9khMKrdn
 jvXuOAR1bsHAtNEBBv7irI0Z/+LszHY4LtMFIQDiHaXQhsBFnoQEjTKLEFvvac9ePC6trcHqn0Q
 yfx97X8NAEAYsDlNDY5s04IakqsKMMVABN3twQyaArkaxJxJe9pUk8YgFI2+5bpS+HNO/cjs987
 Qo0Ak1RtIwUM607ShBSymzPcrbOljZcrxoXRi9GGjZulpFVS+n1UQjTC0FvSgjGJnFsutfoNghm
 RU6pL9xnb+To6uMW5WMmx4cB6upEOP/dFGcwmoHZ802Lu9JSBiKvuuyRRdS/Nmsd4pjkact0/4v
 4HjVuxTPixYx7XGc5ttDN8USOQAOP8p9TMeqveYhRy7CCMpwfvneasMcPETFqExBYNOVsxde+Ky
 znwLeD7FAno3HU5VZlQ==
X-Proofpoint-ORIG-GUID: qGG6z3coGde0gFpO036ZS5Yg_CPZKcbD
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699d87bd cx=c_pps
 a=M+4CHf8fKMkYOwSYEMZyZQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=-CRmgG0JhlAA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=QyXUC8HyAAAA:8
 a=IpJZQVW2AAAA:8 a=8b9GpE9nAAAA:8 a=QX4gbG5DAAAA:8 a=TXiAQP7ikAEoh_HNoCIA:9
 a=jiObf9B0YAUA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=T3LWEMljR5ZiDmsYVIUa:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: qGG6z3coGde0gFpO036ZS5Yg_CPZKcbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240090



--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Tuesday, February 24, 2026 12:09 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Olivier Moysan <olivier.moysan@foss.st.com>; Mark
> Brown <broonie@kernel.org>; Sebastian Reichel
> <sebastian.reichel@collabora.com>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> spi@vger.kernel.org
> Subject: Re: [PATCH v4 1/5] spi: allow ancillary devices to share parent'=
s chip
> selects
>=20
> [External]
>=20
> On Mon, Feb 23, 2026 at 06:21:00PM +0200, Antoniu Miclaus wrote:
> > When registering an ancillary SPI device, the current code flags a chip
> > select conflict with the parent device. This happens because the
> > ancillary device intentionally uses one of the parent's chip selects,
> > but __spi_add_device() checks against all existing devices including
> > the parent.
> >
> > Allow this by passing the parent device pointer to __spi_add_device()
> > and skipping the conflict check when the existing device is the parent.
>=20
> Isn't this already applied?
Don't think so.
V2: https://patchwork.kernel.org/project/linux-iio/patch/bcb1eb34fc5e86fd5d=
bb4472ad1d3ea3cf3e9779.1770393792.git.antoniu.miclaus@analog.com/
V3: https://patchwork.kernel.org/project/linux-iio/patch/20260213144742.163=
94-2-antoniu.miclaus@analog.com/
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

