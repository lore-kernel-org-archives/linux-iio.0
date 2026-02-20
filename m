Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19631B123;
	Fri, 20 Feb 2026 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596679; cv=fail; b=Imipjm6T2ISre+bj0fO1KO5aYJnyLuqC2tI0zmFVErfXKbdtIsfTAHEl5eWgKepOnEq87vJ6slr6yIbbIuzIFUYI4iG68I6J2d7BAXAhzKH0udWSMkqmxazalgCi4SEwR5kusiJswCjtPYpu089+bBXRoFCRz86mFNHbuysX+gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596679; c=relaxed/simple;
	bh=xYzGCIK5cfHnFUd3Kjt+WDk4AVvEJw3brrpiv9UL2aA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DfECMyeG6Lm+Hnez0Y+RYk9H2Ar587jftbG9C/XrxfsAej819A3EMmPYW9Yh9BYf8iuLaB4a7h7JEcG9yUSx96RKRJu/pK63Bl5azUY+A5+10+YhWpQkViOnnpbsukG9nkKtme7jZppDxKTz1sDqQfrJAtT9pZLEvtsajdaidl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jSUmNcUt; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jSUmNcUt"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87owd570237;
	Fri, 20 Feb 2026 09:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xYzGC
	IK5cfHnFUd3Kjt+WDk4AVvEJw3brrpiv9UL2aA=; b=jSUmNcUtkBN08Fo9kAmhw
	1C8bALn64H8mEH/tvUfgmiPXEaEh8dgjgCKfOT+7eakOVmzV/69LPpDszWAJ9R6P
	lsmB5DuHha+wdUiT0QmjZtVQKKV8i+g6+RHfhzhQDM9Cq9EtccrdkNcRB39EoA6R
	dKxiJ0v8Am3odHFDx2/SZvVEdfTvu/nvPEAHnGrowNzicStwYnl4cRKSEWjJvMFH
	brqiQ5QoQAbUr4snY9RrJQjPhhHcs2GEtYYvAZRi4FDVzzKFGK4ubelp8dN0VSBN
	/eA3hXUXA0rHFS1FcsXQIZXyng4GoPtupqTR9XVWASY0NeXSPU0SdC1PyRnGqFzU
	A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cd33vth0m-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 09:10:50 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZyeutjSxqSduI47Ek7zHYF7aOc+xbqlIckJnvNac5d//tgaF3K8tW2C4inWl3qkWMHw4LzuVawFkbFiSS/WCQ+WcOu6/LOUNlDRFcECVkdhPg5FlQMxYjCQ1xhYUzk0mUQj+hpuzSFN65Zw+eisjSQcO2/sblIjS7fvULOGEM7b5rjAZ2ITiaRyaVP1R4x44QH8lPvMM+dunSsP4rYTos0f2CE5enRrYsaBTmcgno6aYwJhBaxc/cXDU+kFNMG05O1eIK3RU7plNZ72gTd2U7PfXMVZBPeBOVixMOA0aikDFUgfCKbgonveOOVzuqZ6tWuRWFXhqjPD9ylgK/3k/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYzGCIK5cfHnFUd3Kjt+WDk4AVvEJw3brrpiv9UL2aA=;
 b=dzM1hhgXIPXzLCC0HQGnmFIOr0OAZIjEkg3b2FYuYHSB6w3vND3ewdmRDzNVyZ89SAZT0TfLqZ2Be1At9CyWmHX34KStf1EL4hKyNObIKGfy27qCvlHM3SN+mArhsb9wWPRyiq7XGttguDZlZ9CqKfaGzMGQHJZp+rc6um0uWBp0t6rEPOGXlapBlZ2Z29SZH0yYcKXI4hpHiJSW1JQw3dlAGdIYd4OWpxoYbSm5/safCpPqY+GlNaiFUeV6ZYVNvv5tZ5sV3ymKndoXLVOv+NReK+sKkvXJdBQXH04DatBT+qjNAepSwlM9niOmWrUCMqxzXyd9pTGjmnHy2C+WxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by IA1PR03MB8287.namprd03.prod.outlook.com (2603:10b6:208:5ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Fri, 20 Feb
 2026 14:10:48 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Fri, 20 Feb 2026
 14:10:47 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Budai,
 Robert" <Robert.Budai@analog.com>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: imu: adis: Fix NULL pointer dereference in adis_init
Thread-Topic: [PATCH] iio: imu: adis: Fix NULL pointer dereference in
 adis_init
Thread-Index: AQHcom3tv1OWzPf8lU6E4RXXHpm+1bWLnE/w
Date: Fri, 20 Feb 2026 14:10:47 +0000
Message-ID:
 <CY4PR03MB339941AEF0B0F9D6FBCC4C9D9B68A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260220-adis-fix-v1-1-9fa10cce812f@analog.com>
In-Reply-To: <20260220-adis-fix-v1-1-9fa10cce812f@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|IA1PR03MB8287:EE_
x-ms-office365-filtering-correlation-id: 65ede325-9ab8-4d8e-e8d4-08de7089d87c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2J5ZGh0Tk5wWDhQL2gvNHZKVFhIb0RzckJGOUN0SDdDTTNhS1RTZmpKQ0tD?=
 =?utf-8?B?bVhxcm53Wkw2Yms3V2ZaZDFTVFJsUnhiNDVSYVY2eGFSVXFlWTZpSkxSWlFr?=
 =?utf-8?B?L2hoWExsN0pBMTFvV09SbXh3NmhuWng2V3VVUVBQYk90WERIT2M2QTllYytD?=
 =?utf-8?B?U21aeTFVNWdyQitDMFFWUm1pTkpUbWx3SWVTK0hoY09yNmFKOGhUaS9nWmJ5?=
 =?utf-8?B?Y2pLOUlPZWwyUm1NL1FMSXo1blVSdFRkQkRjTVZHeU56OVRyQ1BPRXhKWEVa?=
 =?utf-8?B?OW1LRnAyVWo4NDUvb3BsMGd3c05MaWVWOXd2ays4L1Q4SERRYTB1Ums2RU50?=
 =?utf-8?B?VlpUWUo5ZlZvV1BhcjhCanBRMUUwaWZFQTBNSEpHRjJkemxNNzNGUGVLUkNJ?=
 =?utf-8?B?UzhPUHp1MHFLYnQvandZNFZvS3F6YUllVGVka0ZMZVVuSC9kOHNiL083TUNV?=
 =?utf-8?B?eFNzS3o1TXZJVDh6eG96OVo2MjdlYW13U1NEclNkam9MUHNaMHQvWktsU2NU?=
 =?utf-8?B?QlZZaHkwSDVPQzEyUzVobTZrNy9ZRkJtZG1ReXhiT2FwdXEwdGxCY1ozb2Uw?=
 =?utf-8?B?MmVwUHZOM3h2Unp2Z081aWVEN3hOdzVCQVpERURmWkdubUlXTnlaYWpxVUVv?=
 =?utf-8?B?aGs0dG1IeE9NUEFnNGUzYWptS2tTTUNlclpSNFNOdmFUa254N3FacHAvT1Uw?=
 =?utf-8?B?UVJuUUlQbjNWKzdndUtDUkZmWW1xaERJb0lFR0Y0alhMWEFFM0VBMHlEcjJw?=
 =?utf-8?B?Y0J0RXdVMERId3RxM2pjWTVUbm5BM2ZTaW5zNENUK3NzWUZYeVgycHFaRkhZ?=
 =?utf-8?B?Y3prUFVZc3FKWWZkeGRRUWhPNzZ6bjl3NTIzNnJpaG5pc0l0eGlETitHeWg2?=
 =?utf-8?B?M0RRdHo2eE9xTnQ1MVYrV3FqZjVOQm9ZbzE1cCsyWndobkFMQkNqMTJaM1ZH?=
 =?utf-8?B?NXI0MG1UcjU5M0N1UjJleUxneUlzeFR4THVYUklDWFBIYmFac1piVXJXdC9x?=
 =?utf-8?B?emhVQ2tSR3pTTlhXTmdING1Pa0JzNG9jNEpPaUhqNFM2SWsvcXdZWWRDT2JJ?=
 =?utf-8?B?eFFFYmVVU1h0NlFmcnFKamtqdTdxdzc3T1Y3cG5GLzMvQlJ6QmZZQVZHUEVS?=
 =?utf-8?B?WFBFSlQvd2VHc0xCNVBpTVdZd1p4MWFmekl0RnVQcVFtaFZpNElvVGRnNkdj?=
 =?utf-8?B?T0xHcytkYkdHVHBBdTF0aWxXWXpKelRVM01sR1RaeitTRHBYYTBIeWFoZFdQ?=
 =?utf-8?B?LytnbEk2WGV1T3VYM2ZYc3dPQWh5aGN4L2lVSm1HMjQrRDFrdFpsa2E1UXpG?=
 =?utf-8?B?SUZwVVdTQkZ4Vk1TMy9wUGVRdFBGMDVzMWJmWTlZeFkzQXpDT2UwaE05SjFh?=
 =?utf-8?B?TmVPMTd4R2pRUnVGaVk4WHA3TUJ4OGU3cXV5UWVGSjlEVGRQOFEyRm51djhT?=
 =?utf-8?B?YTVBak01cHFCcHYya25qNXVVWWpDdnNJSnRaY1dRRXpJRGR3TVozb0g3OUNX?=
 =?utf-8?B?MFlDSDhpRlU3a2JwcU9KQlZHYVlnR3NhajZDUzZtSVE5b2hJN3YyV3BSTmNx?=
 =?utf-8?B?ZnpkeGdSSkpGWGdmRW1yVUJtWHpKbGxjaWNkMjJWZ2ttM1o3MmVTMEJ0aFFQ?=
 =?utf-8?B?NDFXVFFPTmdmVXpSOHJIakIyNnptTWFnc005Z1RDNzdQL2VEL3dHYWtWMzEz?=
 =?utf-8?B?SUlxMFpkcDdRNmkwVjBxbFBjOEd4SHpOdldEV0F5cGRxRjFMdUREK1FPeFlD?=
 =?utf-8?B?NnNIaXVINnpEalBKNkRuSTRtd1ZSVW9vZGM5N3EzVmprVjJPcTBHa0piVThE?=
 =?utf-8?B?aVZHUkdOME5TeDhaUzR1b3FCelVCM3VpaVVhTnZkNktPd2VzYVdCVDloZEhw?=
 =?utf-8?B?MVZaY1pEVmx6UGFVQk16TStjTnM2czc4ZmdJMGxJY2FoNUxHWFVaODNYSU1v?=
 =?utf-8?B?a3JKSXJrMnJhUzlxaDVYeC9lTVB2dnBkVDBzUGU2T0pFVkFpenNWOGFReXVk?=
 =?utf-8?B?ZHphMW9BTUNmM1JZcHJHczNjSzdTY1VmSkNWUkNBL1F5NlM3RGN1ai84aXQ5?=
 =?utf-8?B?aXVadlFUSlpEZjdDQXN1Y0h2RjEySGNhTjJ3U2grd2hickNDSmJ0ekxlQWU4?=
 =?utf-8?B?T0JHTHNmS29ia1VlUk5acUc0dzVYc05meE42elZGeFljSlJUdlZPS0NrdW9s?=
 =?utf-8?Q?K+1/hFK5shADblE0BPmKN/yXKRhY7hhrtZwHBry6zfbk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OCtVa0EyS1g4Sms0YzF4VG5MOGJBWUNYcm9yaFh0MGpqb1NkMExpNzlKcERE?=
 =?utf-8?B?bkZiTDVBT3N5WC8zQS9kU3UzTW95MVFaYUVsa2hNZHNqV2oxaDczTVIyamkv?=
 =?utf-8?B?bWZGZ2wxL0tYSzhadkRJMnZkNnplMS9TeDhtaGZGY2RqcDRuNjI0NU4xdlRq?=
 =?utf-8?B?aHMyNXdaNHA1UGhRcytQdUkzMmliV3luVFQ0RVBhNXJRT2owK2VtK3FDN0lz?=
 =?utf-8?B?WHBNTWJjMnY4OTJIRE1kRkhLcWJCK044aEdSRUl2MWxuNkI0RHg4RHUrNFZo?=
 =?utf-8?B?SForZldNU1lwTisrd1dXL1Z5MVFSNU12NEhMVk9mYXpvUWQ2VXZBNVcwSzdS?=
 =?utf-8?B?TTIrVTRGUGd6V21rZXdKV2NZOHVLb3RQaHZnb0MwQ1VNMlJIUnRBRFQ2QW1M?=
 =?utf-8?B?UnM1TkRjb1oyRG5GOG43WndCS1Z4TUtTdUF4SXBsc3JuUmxEWEl4Unl4MEll?=
 =?utf-8?B?NWEyVTYxcENzNFhsUjhmRS9aY25ESEU0a2FhTzNTdTdDdnpwSnVpd1JnaGdM?=
 =?utf-8?B?ZFBqYXh6cFRvbGFNWVVnZXlONm9oc3RpVXJzTFRSamtIUml2QWtUOWkvQ3NW?=
 =?utf-8?B?VUNKamFCU2paMklJeXE3ZzUydHV6OTRPVW4vSlkwMWhOb3lpSzRQSVhSZnYw?=
 =?utf-8?B?TDEwUEx1dVkwVUNmdFpsa2l3NEtBYUF3Rmd0NFdtaldnZWtwRElhZTk1cVRX?=
 =?utf-8?B?cVBERFgvR3hWVE9wd0k0VDZUaWJjam5JUTU1dmpWUmxiV0I5ZVVLTm5vU1Ew?=
 =?utf-8?B?K2RLQXN6MCtJSWRjNkRJV0RlR2NwM2Fhc1M2RXpTVStPd0VlWHQ3RzE4cXRn?=
 =?utf-8?B?QTczcXdMR1JkQ05DUmZEb3NzREZyZDhmQnRJa2FYVjVsUjNJNWtQRCtXMEFP?=
 =?utf-8?B?VkhCNXFnL3l1RmhLNkxzVFp6SitoNGlYZEI2T1RuYkl3WExVZHU4MVpXMmM0?=
 =?utf-8?B?SE5QVk15TWQ4UWVPZGZ0aG9qVi9oY1QxQkxjeUFsM1ViVjVrUjVnNHM4aHhq?=
 =?utf-8?B?d2Q1M2lpMTNjbi9KU09mVkhGVUdGTW1QVThIWklKbWRmdjdIbTFrUVRWYjlW?=
 =?utf-8?B?Umh0dnR5a25yQ2VRcUkyL2tRMURibmFScXNKVkZVTnpDVzdZTUVuT1Y3Q29s?=
 =?utf-8?B?V1Vua0NvZHZlU0tNcjhXbUxwUFI0MHNJdFFEZlp0L1dyOEdPMnlvSVVyeEZw?=
 =?utf-8?B?TEVOQmxPTXZyQldxSzZ4RGxwZ2ZOUWF0ZDY5cndnWkt4ZVdMejNFWXBCTkpx?=
 =?utf-8?B?MmtrdU5OeWtYWGVFQ2U1Uzk3cWN4TUFIUU9WS0ZlVHlhemFyS01wbXo3aFFP?=
 =?utf-8?B?eFg4TXdzbCtPK3JrWFdIVkpFcWtoV2Y2N01SVUNiQjE0cG5UcU9qa3NTR29W?=
 =?utf-8?B?TzhpcmJOOUF6Q0l5a1psT1Z1WmNGYkJKRzMrNnhVQ2RPWEFrZ2xXRC9kd2xL?=
 =?utf-8?B?d1hLaDZZWmJlb0dkNzJ4UFNCbmJzMVlMMmNsUWc4KzZLNTFWQisrQjFFck1u?=
 =?utf-8?B?aEI5VG9yWU43dkM3TktPa01rSGNCaVhydlNEQ0FjbTRQUElkRVpIQWR2S1Iy?=
 =?utf-8?B?OFRhdlR0N3ppTjJEbUUvWkJaTDF3Ri8rY2JyRE5EQXJGelp4VG9SUys4MzZI?=
 =?utf-8?B?RTk3NTVMK0tKc21XcVRxYnR1UVlweEVqLzNaeHpoNklHNjNCOEQ4TmN5MU1B?=
 =?utf-8?B?dEtwZmpxa1hBOGs5VnZ4RmprOWw5Mmo3R3N5TitnZy81bERlTGs0VjhhbUpt?=
 =?utf-8?B?UlNIM0hTeHFmOTliZjhTUkJFMWF6dWgzdjhteEJYdG1YNldGOFhzcC8wWXZ1?=
 =?utf-8?B?eVJ3L1hvaDRPY1JWTmkxRnExYmRuL3dFTWN1M2RYQ01YaHF1NFNsRHFnV3dW?=
 =?utf-8?B?YVMza2E3aHNyY1hrZElBMmdPUVA5ZEtVQ1FQbmt6eWw2RjJzcjl5TzV1MVpq?=
 =?utf-8?B?USs5d0x5ejh4TWo4VjVzbHp4ektyYU14V2thQ1BGZDV5dTRZak8xT1RhRzBD?=
 =?utf-8?B?SnBBZXcwaThpSFRlTFNiR1Fsa0lKWmRlYWN0T2lTR3ZCZXBzT3NUMGE4NWs4?=
 =?utf-8?B?S3hlZFdaNlB6V290OHkybEJBaTZpaVJEQ3BrQUhmZ0ZzWTZmUW80ZXVQNDJF?=
 =?utf-8?B?NzVGVkRmMjllYjZYSDNZSmNHcHgwcVpJNzRPTWRWQ29sWEo2MXhLd2ZITmJ3?=
 =?utf-8?B?VVFhdjZBVjlmNTJQYVMyTmdxckFWc2F1NW16YWx6Vnc0bXBkYyszNy9Bazlx?=
 =?utf-8?B?ZVcyblcrNG1wM01JakxxTm1xYzNBZnEwbWVDb0hUZTR6d20wNCtDZTJ3UlRx?=
 =?utf-8?B?K0ptdFlBT3BLK282TzNWZUdmK3NNMzNUSUg3RzA0ZS9FOERLQTk5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ede325-9ab8-4d8e-e8d4-08de7089d87c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 14:10:47.7902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esVGO70swR/SbwB4kCu6BJNbcArqasi00OhQZISXhsqkARDINCOiV13Acx6YNsvPlBoPDeOUS2nw8nVzT3AmVmde/WVKCQ7AExnPoGOPZxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8287
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDEyNCBTYWx0ZWRfXwAwIpfiuc8Wj
 Rt3D32ZPGmQDYca93HGyDJ/UzoGPXzGayuaFh4lEhZegXIjdwLpv3AvUcuWwLck1hTYuKoCfBb2
 tCgUpoLS4+c1jpga2KSm8WX2hQpx7zMXw1L4nE1Ikn16fxuEbRFl3fQit6uuN+ipV3sfuEmrCbG
 4kIz3W4a358lnT+mco/KBjLVjW6jwWEDBup7fymlerOaKasyY+yiMYBZr07wG7oDGvG2rWkWRTu
 w1W06fG3moKcWUC5nkvlLNfra1f641CLiVzb1hdqvsAbI+Nij72O33QONbazBgmVTw2nSceSt/F
 R1YZVciahvTlA5XF2V2tRwJmnmOwWvoXhZ8n5uxZmF/dBAm1J05dO8vkV+lDa1rqaUOg4vDTQaj
 dnpdoaoUaM+tHVGlsMnBKw1RH1YJtp/oyCw2fWNhhl0iMVVr8GhMkQku+gkRbG9vbFKnqE6RB8P
 1uj78DN1RxUPK43OEbA==
X-Proofpoint-GUID: RAKZROFwZACR9S-NV5xWVLmZBahWYtaT
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=69986b6a cx=c_pps
 a=UcHwULevSueSKPp+kiqIJg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=i0EeH86SAAAA:8 a=ts0TGg1JT23NzXr-qj8A:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: -6w4d7CiOSl7CwLcbQA8UpgBuvHDz8pm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200124

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWR1IFNhYmF1IHZpYSBCNCBS
ZWxheSA8ZGV2bnVsbCtyYWR1LnNhYmF1LmFuYWxvZy5jb21Aa2VybmVsLm9yZz4NCj4gU2VudDog
RnJpZGF5LCBGZWJydWFyeSAyMCwgMjAyNiAzOjM2IFBNDQo+IFRvOiBMYXJzLVBldGVyIENsYXVz
ZW4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5u
ZXJpY2hAYW5hbG9nLmNvbT47IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+Ow0KPiBKb25h
dGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgRGF2aWQgTGVjaG5lcg0KPiA8ZGxlY2hu
ZXJAYmF5bGlicmUuY29tPjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBCdWRh
aSwNCj4gUm9iZXJ0IDxSb2JlcnQuQnVkYWlAYW5hbG9nLmNvbT47IE1pY2xhdXMsIEFudG9uaXUN
Cj4gPEFudG9uaXUuTWljbGF1c0BhbmFsb2cuY29tPjsgR3JhZGluYXJpdSwgUmFtb25hDQo+IDxS
YW1vbmEuR3JhZGluYXJpdUBhbmFsb2cuY29tPg0KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9u
YXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPjsgbGludXgtDQo+IGlpb0B2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNhYmF1LCBSYWR1IGJvZ2Rhbg0KPiA8UmFk
dS5TYWJhdUBhbmFsb2cuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGlpbzogaW11OiBhZGlzOiBG
aXggTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIGFkaXNfaW5pdA0KPiANCj4gW0V4dGVybmFs
XQ0KPiANCj4gRnJvbTogUmFkdSBTYWJhdSA8cmFkdS5zYWJhdUBhbmFsb2cuY29tPg0KPiANCj4g
VGhlIGFkaXNfaW5pdCgpIGZ1bmN0aW9uIGRlcmVmZXJlbmNlcyBhZGlzLT5vcHMgdG8gY2hlY2sg
aWYgdGhlDQo+IGluZGl2aWR1YWwgZnVuY3Rpb24gcG9pbnRlcnMgKHdyaXRlLCByZWFkLCByZXNl
dCkgYXJlIE5VTEwsIGJ1dCBkb2VzDQo+IG5vdCBmaXJzdCBjaGVjayBpZiBhZGlzLT5vcHMgaXRz
ZWxmIGlzIE5VTEwuDQo+IA0KPiBEcml2ZXJzIGxpa2UgYWRpczE2NDgwLCBhZGlzMTY0OTAsIGFk
aXMxNjU0NSBhbmQgb3RoZXJzIGRvIG5vdCBzZXQNCj4gY3VzdG9tIG9wcyBhbmQgcmVseSBvbiBh
ZGlzX2luaXQoKSBhc3NpZ25pbmcgdGhlIGRlZmF1bHRzLiBTaW5jZSBzdHJ1Y3QNCj4gYWRpcyBp
cyB6ZXJvLWluaXRpYWxpemVkIGJ5IGRldm1faWlvX2RldmljZV9hbGxvYygpLCBhZGlzLT5vcHMg
aXMgTlVMTA0KPiB3aGVuIGFkaXNfaW5pdCgpIGlzIGNhbGxlZCwgY2F1c2luZyBhIE5VTEwgcG9p
bnRlciBkZXJlZmVyZW5jZToNCj4gDQo+ICAgICBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxM
IHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbA0KPiAgICAgYWRkcmVzcyAwMDAwMDAwMDAw
MDAwMDAwDQo+ICAgICBwYyA6IGFkaXNfaW5pdCsweGMwLzB4MTE4DQo+ICAgICBDYWxsIHRyYWNl
Og0KPiAgICAgIGFkaXNfaW5pdCsweGMwLzB4MTE4DQo+ICAgICAgYWRpczE2NDgwX3Byb2JlKzB4
ZTAvMHg2NzANCj4gDQo+IEZpeCB0aGlzIGJ5IGNoZWNraW5nIGlmIGFkaXMtPm9wcyBpcyBOVUxM
IGJlZm9yZSBkZXJlZmVyZW5jaW5nIGl0LA0KPiBmYWxsaW5nIHRocm91Z2ggdG8gYXNzaWduIHRo
ZSBkZWZhdWx0IG9wcyBpbiB0aGF0IGNhc2UuDQo+IA0KPiBGaXhlczogN2YxNWQ3YTdkMTJkICgi
aWlvOiBpbXU6IGFkaXM6IEFkZCByZXNldCB0byBjdXN0b20gb3BzIikNCg0KSSB0aGluayB5b3Ug
d2FudCB0byBmaXggM2IyOWJjZWU4ZjZmICgiaWlvOiBpbXU6IGFkaXM6IEFkZCBjdXN0b20gb3Bz
IHN0cnVjdCIpDQp3aGVyZSBpdCB3YXMgZmlyc3QgaW50cm9kdWNlZC4gV2l0aCB0aGlzIGNoYW5n
ZSBhbmQgQW5keSdzIHN1Z2dlc3Rpb25zIGFkZHJlc3NlZDoNCg0KUmV2aWV3ZWQtYnk6IEFudG9u
aXUgTWljbGF1cyA8YW50b25pdS5taWNsYXVzQGFuYWxvZy5jb20+DQoNCj4gU2lnbmVkLW9mZi1i
eTogUmFkdSBTYWJhdSA8cmFkdS5zYWJhdUBhbmFsb2cuY29tPg0KPiAtLS0NCj4gYWRpc19pbml0
KCkgZGVyZWZlcmVuY2VzIGFkaXMtPm9wcyB0byB2YWxpZGF0ZSBpdHMgZnVuY3Rpb24gcG9pbnRl
cnMNCj4gICBiZWZvcmUgY2hlY2tpbmcgd2hldGhlciBhZGlzLT5vcHMgaXRzZWxmIGlzIE5VTEwu
IERyaXZlcnMgdGhhdCByZWx5IG9uDQo+ICAgdGhlIGRlZmF1bHQgb3BzIChhZGlzMTY0ODAsIGFk
aXMxNjQ5MCwgYWRpczE2NTQ1LCBhbW9uZyBvdGhlcnMpIG5ldmVyDQo+ICAgc2V0IGFkaXMtPm9w
cyBwcmlvciB0byBjYWxsaW5nIGFkaXNfaW5pdCgpLCBzbyB0aGUgZmllbGQgaXMgTlVMTCBkdWUg
dG8NCj4gICB6ZXJvLWluaXRpYWxpc2F0aW9uIGJ5IGRldm1faWlvX2RldmljZV9hbGxvYygpLiBU
aGUgcmVzdWx0IGlzIGEga2VybmVsDQo+ICAgY3Jhc2ggb24gcHJvYmU6DQo+IA0KPiAgICAgICBV
bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVh
bCBhZGRyZXNzDQo+IDAwMDAwMDAwMDAwMDAwMDANCj4gICAgICAgSGFyZHdhcmUgbmFtZTogUmFz
cGJlcnJ5IFBpIDUgTW9kZWwgQiBSZXYgMS4wIChEVCkNCj4gICAgICAgcGMgOiBhZGlzX2luaXQr
MHhjMC8weDExOA0KPiAgICAgICBsciA6IGFkaXNfaW5pdCsweDUwLzB4MTE4DQo+ICAgICAgIENh
bGwgdHJhY2U6DQo+ICAgICAgICBhZGlzX2luaXQrMHhjMC8weDExOA0KPiAgICAgICAgYWRpczE2
NDgwX3Byb2JlKzB4ZTAvMHg2NzANCj4gICAgICAgIHNwaV9wcm9iZSsweDhjLzB4ZjgNCj4gICAg
ICAgIHJlYWxseV9wcm9iZSsweGM0LzB4MmIwDQo+IA0KPiAgIFRoZSBidWcgd2FzIGludHJvZHVj
ZWQgaW4gN2YxNWQ3ICgiaWlvOiBpbXU6IGFkaXM6IEFkZCByZXNldCB0byBjdXN0b20gb3BzIikN
Cj4gICB3aGljaCBhZGRlZCB0aGUgb3BzIHZhbGlkYXRpb24gbG9naWMgd2l0aG91dCBhIHByaW9y
IE5VTEwgY2hlY2sNCj4gICBvbiB0aGUgcG9pbnRlciBpdHNlbGYuDQo+IA0KPiAgIFRoZSBmaXgg
aXMgYSBvbmUtbGluZSBhZGRpdGlvbiBvZiAhYWRpcy0+b3BzIHRvIHRoZSBjb25kaXRpb24sIHNv
IHRoYXQNCj4gICBhIE5VTEwgb3BzIHBvaW50ZXIgaXMgdHJlYXRlZCB0aGUgc2FtZSBhcyBhbiBv
cHMgc3RydWN0IHdpdGggYWxsLU5VTEwNCj4gICBmdW5jdGlvbiBwb2ludGVycywgYm90aCBmYWxs
aW5nIHRocm91Z2ggdG8gdGhlIGRlZmF1bHQgb3BzIGFzc2lnbm1lbnQuDQo+ICAgVGhlIHZhbGlk
YXRpb24gcGF0aCBmb3IgcGFydGlhbGx5LXBvcHVsYXRlZCBjdXN0b20gb3BzIHN0cnVjdHMgaXMN
Cj4gICB1bmNoYW5nZWQuDQo+IA0KPiAgIFRlc3RlZCBvbiBSYXNwYmVycnkgUGkgNSB3aXRoIGFk
aXMxNjU0NS0zIGNvbm5lY3RlZCBvdmVyIFNQSS4gV2l0aG91dA0KPiAgIHRoZSBmaXggdGhlIGtl
cm5lbCBjcmFzaGVzIGF0IGFkaXNfaW5pdCsweGMwLiBXaXRoIHRoZSBmaXggdGhlIGRyaXZlcg0K
PiAgIHByb2JlcyBzdWNjZXNzZnVsbHkgYW5kIHRoZSBkZXZpY2UgaXMgYWNjZXNzaWJsZSB2aWEg
dGhlIElJTyBzdWJzeXN0ZW0uDQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vaW11L2FkaXMuYyB8IDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzLmMgYi9kcml2ZXJzL2lpby9pbXUv
YWRpcy5jDQo+IGluZGV4IGQxNjAxNDdjY2UwYi4uZTY4YmMxYzM2ZWQxIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2lpby9pbXUvYWRpcy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzLmMN
Cj4gQEAgLTUyNiw3ICs1MjYsNyBAQCBpbnQgYWRpc19pbml0KHN0cnVjdCBhZGlzICphZGlzLCBz
dHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0KPiANCj4gIAlhZGlzLT5zcGkgPSBzcGk7DQo+
ICAJYWRpcy0+ZGF0YSA9IGRhdGE7DQo+IC0JaWYgKCFhZGlzLT5vcHMtPndyaXRlICYmICFhZGlz
LT5vcHMtPnJlYWQgJiYgIWFkaXMtPm9wcy0+cmVzZXQpDQo+ICsJaWYgKCFhZGlzLT5vcHMgfHwg
KCFhZGlzLT5vcHMtPndyaXRlICYmICFhZGlzLT5vcHMtPnJlYWQgJiYgIWFkaXMtDQo+ID5vcHMt
PnJlc2V0KSkNCj4gIAkJYWRpcy0+b3BzID0gJmFkaXNfZGVmYXVsdF9vcHM7DQo+ICAJZWxzZSBp
ZiAoIWFkaXMtPm9wcy0+d3JpdGUgfHwgIWFkaXMtPm9wcy0+cmVhZCB8fCAhYWRpcy0+b3BzLT5y
ZXNldCkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDhi
ZjIyYzMzZTdhMTcyZmJjNzI0NjRmNGNjNDg0ZDIzYTZiNDEyYmENCj4gY2hhbmdlLWlkOiAyMDI2
MDIyMC1hZGlzLWZpeC0xNzdjYTA0MDVkOGENCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4g
UmFkdSBTYWJhdSA8cmFkdS5zYWJhdUBhbmFsb2cuY29tPg0KPiANCg0K
