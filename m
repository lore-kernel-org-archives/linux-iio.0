Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE16211A28;
	Sat, 11 Apr 2026 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775874443; cv=fail; b=q6UK6DhCIoCSnHRQOjU+Gbjtbi0k/zUviItnjiGKJ2hLzWSWxu6MXzi+3SBO/zBOoj4Ods7wPnfU1CQAdikpefz6ECReG/ZmOpevpwbW8Vrgeg6NbUncDUHjgSwgI2XiTpbrmHIKJIv6j1PPmbVI6Oyged0pjw+FltUMv3R/kyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775874443; c=relaxed/simple;
	bh=ThG4HiQgndi2R0wIwj8tH5GOOwErH425qgo68GqsCAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QpN9E7On2gTIJGDWAOyCC7SHwjLDkVNUmpHEYOQgJt1ayQPcF01awzxk4VP1m0lzzKsYf4VX9Su4+tNRY3jDZujwRE7nAE3YOH/om8tvoMl3X+R+bQcv2DpSomYsPAKaSJVsCFEGnnsCMt7kpgeEN/jP5Jxyb8chC5bEwVT0j+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=x44ZHKZL; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="x44ZHKZL"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AMarXB1757560;
	Fri, 10 Apr 2026 22:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ThG4H
	iQgndi2R0wIwj8tH5GOOwErH425qgo68GqsCAI=; b=x44ZHKZLARRwANPV86Naz
	GCOBn4qMw3VubljSQN3cvPPpdu78aNq1+R0JnbCG2zFhpO7zQ1Kopib36wq4UMgE
	fdyM5GA46mndekRe3A16lI7jPrmr9HJ2C/YFIq008EtG3qjfzr3rBe+DdZ4XjBwe
	EY/N5izxGfaT6SThIlqYaHKsNzTmY0Of10mfcA2q6G7lfcAtilWNAr+Jqmebgxo4
	ql4RdmbePrhp5Dd9KUqOQjZBSpPyrmtDnMuHtm2UgFhCO5ImubLbgvCqErlPowYP
	CmzuypsLO2wzBNxkUT7M4I3CZ0hNTV5mOUOKK0KJulahQMx3kLVewaNST3viE84w
	A==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4de7r4yub5-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 22:27:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAVm/UjXjsYMRn2gXBPrzb4HkTmfhXj0t6kgFoV5Vq22hTPdGChqbInVif7LsrSP6x/O7W0BwWGxO90MT4U+01fOniDfmkrSKdm0AXGaSHzoZIG6+BQX7/qUPBL1+N8oPZTE3dwt40anj4WAxBSJmkNMA9NceyO6th6VScMqxrPH9GZm/QwjNNu/l/kqSs28nhbkAeWgmGnr/CNjc7gp0AiUYHvjNu+13Wtw0EFa+3QvJPBjtrb2NWSFyDlpkfiZDs/CuioWR2+mcDoC67kfmH9MMWC/gfnGOzbq4ZQNvy//d5Ze8b4hK2hN4uiSUJfoEP++TJypvqBaIJXiU5AuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThG4HiQgndi2R0wIwj8tH5GOOwErH425qgo68GqsCAI=;
 b=pmnEzEGGVtvflxjM9gM2iY9Ul0KBQUYjzuxIkn2t6+aBiul5Kz2lBoMC6aiyHzFBHKvmQJbUEA3EfRFYBIQlbHfsbXdscIke5k+bzYe2dlNlCJVfY5Y0svwEn+2wU4RQKVicw9A/EGZ/D+hpQumABkLbyWHQmXp0IZbaE9jvLAlhLjpHEEX31Gpw1ORId2UaSkyNNcj5aunKMzJcIY3VwQTQ9pxC8Mj68dmTwC+e/BhSIlitPFggpZCGF1hSPWN1nJe0Yoxb50yE3hyVtC56C/PyeVFla3wEiyDO6oqpAk+gzg7+vOVQuA78Xcbee9DI0Lmx2tZc+6NNsY4TzPOwWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by LV3PR03MB7610.namprd03.prod.outlook.com (2603:10b6:408:284::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sat, 11 Apr
 2026 02:27:04 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9769.043; Sat, 11 Apr 2026
 02:27:04 +0000
From: "Jones, Carlos jr" <Carlosjr.Jones@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
CC: David Lechner <dlechner@baylibre.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Liam Beguin <liambeguin@gmail.com>,
        "Marques,
 Jorge" <Jorge.Marques@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [PATCH v2 0/2] iio: adc: ltc2309: Add LTC2305 read delay and
 optimize chip_info
Thread-Topic: [PATCH v2 0/2] iio: adc: ltc2309: Add LTC2305 read delay and
 optimize chip_info
Thread-Index: AQHcwNxRJwUQZKu0kkSMq3Lfs7+OFLXZMQIA
Date: Sat, 11 Apr 2026 02:27:04 +0000
Message-ID:
 <SJ0PR03MB5854F9BE63C740C8EDB18E24F4262@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260331012457.9324-1-carlosjr.jones@analog.com>
 <CAHp75VfkdmebYjBdOnkqrT87Sm9PR8OehYvPSwwxiY9zq9hfbw@mail.gmail.com>
In-Reply-To:
 <CAHp75VfkdmebYjBdOnkqrT87Sm9PR8OehYvPSwwxiY9zq9hfbw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|LV3PR03MB7610:EE_
x-ms-office365-filtering-correlation-id: 29c75a93-e132-4a5e-e967-08de9771d208
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 7B0viSNwWpiCMqsmi4oUIQRqzCvvCI7T8oEkPZ9Ew0GAdJgBIyVdYxl2v9l4w/OXl1iI/9XuZb2HlHcKePeEyh0yjeW6rSD8QFfPFWa+pSnsIZb7CHDTZIstsNSc7kJkriD5xTiLhLgNtfPe2EDG0z/trdhOYGT/5so0zzsXAilUmbGRRlWbTmXJs5hH9i0fNJr3rFYXpos8DIvjdLrbGQ9I8ZdR50JXjm+IDByNDjbzmLILo4mZdBHmFPxY/d37AkWFyxCmwqEHvl7p3jRVW26R7oKdwno7uhW2UT5L/oUIGuNKaw9mCJjlOwa5GkHCR7AASi+JkKwXgYyPnJprgM0f8/6luld0uXEATrkD2jptDFIMcaEhUralNcqd6qVfwDwngPU0yk7yq+QXVaADo8VwLFbIKjHUuHKjl3TlwcYJZ/NsfHCT0Lnw61IW6tgQKX1R+YfUUTEddQWrHXs2GmiWrmcSPivfw3HwdHo1JFQtCbMsVwVDgg48rx/cpD9v4WxAetDhCeR7tQ0SDqSqB+D9EcjDgXV3l9BV1PYPJAp7lmrqgfy51tBLN5R6F5e3oXREWzHYzWttsxVSn0JoACWFG9V1KUAPzattEooCMrIJNMHnJrMa+cpnT8NuP3wyMQHxsc8HzPiCjtR30fYjUqsaY+hmV9AhHYNlv5K8Wz3MLZPCD2bmy/eOy2VDsmvoOpKGjCOijuTOsCEOFcP7rfoP5UYjabZmgU5MSF4J6fJY7zvHgeo2PND1lr3Y4rrb5XM8sJaxgC34vs1i+cu6em9wocbvik1DJ50dYyM6m9M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2Ywa0EzcHFWYUhodys1WFVjc3J2SEpGcEpTeHFHZ1EzblFyenhHZ1I3OFUx?=
 =?utf-8?B?RGVucDNEUmpFckhsUy9yODRDVG42UW9UY2dMV3cxWXBGcFpCRmIwc20xU2NX?=
 =?utf-8?B?SlhjaU15NS9RMXBVdUdDWk1XSUdYUkNXeHZNSS9BeDJDekhBdTUveHlramhx?=
 =?utf-8?B?OWlsa0hFUWxkS3B3RHQwSmpqemNaS0IzSTRCT21yTEk4b2Y0VGNoaGNBTlcy?=
 =?utf-8?B?VTVWM2N6d2VVQVY0UzY4SU9aanFYZDhFdVNwbFc4MFhkU0ZWMlpqVXBZSFF1?=
 =?utf-8?B?ZmpmZTNoNTc3MGNyTG5XRlZYb0pwZkY1M1lUdVE5cFZnK0FTVUZEVE9XUjVR?=
 =?utf-8?B?cTJiWG1SbmJrRVlkVXhkS1hYdGlCQXBvYXVRQUFpbmFSZnRiaVk1eWRQUm5W?=
 =?utf-8?B?ZVNjbVU4OG9la05YcHJEOXY4dndPMDRzM25XeHA4bEFMV2VDUENjUzRwOUVJ?=
 =?utf-8?B?V2tDbjRtTGRYL0VIa3JCV0hIVEozTkg3ckNTdjRLQ3N0dXZxMDZTaVdCNTE1?=
 =?utf-8?B?NklFbHlhTDdMYUxTRUk1eTR5bmc2bGV5UTU1cUlFcTlCK2M3YTVlZ295TXBD?=
 =?utf-8?B?bGdKL0VmM1Rka05kRkg4N1Rsa1FRQ3EwbUo2MlViQ002TitVYTRmSGpCUVFX?=
 =?utf-8?B?eHRkQnZMbURRQjNscytTNnZkcG1pWVIzOU1oRmVBR1ZIbU05TVM5Qkkvc3hB?=
 =?utf-8?B?VEUzaWhiT21tOEwwWnc5T0NiQ095eXprR2cwc1h3VTdweGQ3aW8rQjkyZlkx?=
 =?utf-8?B?eEdmc3l1NkxFWjRiSmlpVm1wdHJCd1N2d1kyWGRxUlh1d296Q0xqOEJBNFhi?=
 =?utf-8?B?aFpVUmZVK2FyUnh6bGhvR2hLcWpGMC9zeGZWZHN3RFV2Y2hsVkJKQjAxK1F4?=
 =?utf-8?B?aDJUWHMzOXRjMEh5NTdKT3ZSalZGdUQ4RnZEeEYwUVZjMFQ1akhlTG1Yb3Bp?=
 =?utf-8?B?WXRCSWtVVGFkMkhRQ0ZyYXZZeGQzWEx3L0V0TWx0OVZVdGtrYVN1ZUpIREs5?=
 =?utf-8?B?bTBWSHBSQVFPckFEa0IwUXBWZEQyWS9mdTE1TFlsbEl2eGl4cmxueTlibmNX?=
 =?utf-8?B?azM1Y3VST0JVVmZuc050RUJONTRsQkZYWHN4QVZDMk1BV3VuWU5aSUVsSmlU?=
 =?utf-8?B?RXpqTHN1RVVFSmVXVjhFU0txZ3FRMEVBcW9rSkd6ekp1SDkvUUwzYlc0Uklz?=
 =?utf-8?B?a2Z6VDhEQ29wSXBHWW9PWXVONkNnbUR4YmpXQzlaQXFzbjRIZm5ZWFdJU09s?=
 =?utf-8?B?TmIvQXFXWmpyWFpEMVFpdG9Ha3J4eDA2L1FydFVhUWpDOTVnTU1SdEJwVXFo?=
 =?utf-8?B?aUttNjlTZHVSbVpKWUprek5LWUVjT0JYd3NYc3N2cDJqa04zeEczVkZBOUFT?=
 =?utf-8?B?bEgwT2hYa2xOZ2xoSDkyVnZ2b1RhbDZ5WVJyNXhuT29hYzNOVlNDMjZpNlN2?=
 =?utf-8?B?WUd5djhGRjBCWU1mTXRsMEQ3RzYwdHo1ODJXZWJ3eTEySU83YTh5VFV2Q2hJ?=
 =?utf-8?B?SWlLaFBGNWFyMmZpc3FxUGJhQVhCRmVrZjFrN3pROS9NL0hCU0ZBSDhuNFd3?=
 =?utf-8?B?U0l4VHlpWnNLaVJweEpVak8zOU1LYmgzbStCUERGazhxc2FrNkd6Ulo0Q3B4?=
 =?utf-8?B?MW43WDdZMnNZNG5nUDBxMjV1NUQ4eW1KTDR3dWl6c3Jaa2VMQWc1aXJwWm5q?=
 =?utf-8?B?UUE1My9DSDJMQ2tuNFRMQXo5QStUeDQweHR6clVWMFlTeUlXczZhSXNNYTZp?=
 =?utf-8?B?bVFld1VoQUxqZExURzNCU2E0RGExTHc2SDU2cUtxbmRFcmhhZ3JIT3JaOGhW?=
 =?utf-8?B?WG9oemhLMnl0L2prUFFVcDdEQitWT25kd0IzaTNCN1dXOS9lTHp6QStKaldV?=
 =?utf-8?B?Q0NCZGVEWURrRUx2QlBJUGIwYTNxRUk3NGx5Yzl0Y0ozM1Q2M2FadVNvT0wr?=
 =?utf-8?B?KytQNTc0dFJySFE4Y3J6ckNZWDRaVjFsVlhWN0lZek1TTENQVm1JYkg3S0Jr?=
 =?utf-8?B?WENWTU8rMDkyeVZXOFovZlFiRFdYL25mMnAzaWdPVVhDdysvMjRZNnFTRTNY?=
 =?utf-8?B?NU02bnJRNTlYRWRNdlFYd29tbFRza2hrNjVYVVF1OEZ6V0tIc3RqNGFpdFQ3?=
 =?utf-8?B?WW1LVjcvL1VIaWlkRUhyNkhXb3UxMHR3eERFV1NXU0RHbTZ5Mk5ORjZqN1pS?=
 =?utf-8?B?bVRlVm9qZ21XZXlobXpPTjcrbS9QU2JORE1Hdmp6YlBtWm5MNzA5TTRUT0VB?=
 =?utf-8?B?MDU1R014T3RoeVBXS0R2RGdETzAvZ1puankxdUN5STllN0ZYQ2ZaRXRxN0Rs?=
 =?utf-8?B?ZFJWcTBrN3dhTWQveGZwUTJmV3ZmQ3lCd0xnY2J0NzhXT0NhNlplUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	e/TQac8IqJqqsJF3OeJ0sEbbuPuM3bwVU5eIhgpVQI1FZ6v/FaAVGCBEjQWekRZLxBcMfKlZ5xiBccNRo8Fa0aB+3DPnWMfnJ678YkMhnJ8NDNo/S9UtfmCfao2ivHYyrbvMQq5d1KPHiOV7AcIihLRD+NP0twY/2fHkaXeMi+XO0X/k/V9++lzRuiUcPunx6MQtShwi1wnleeeHZ9Qstd4K2u6ZzFVqakzjIRanvqzwiqNuzICEEjTKSbE5dUHYIH8poVzWk+c7mVDzcGv5dH7LZDYcuZ7T5sp2p7ICWw1cMC+I2uZm4vpEzQ4DJfnBmAtN2DizVzlc2EDi9BQAIQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c75a93-e132-4a5e-e967-08de9771d208
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 02:27:04.3922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAHmZho92gLYbcQwmCj59QG+ro4SW+uVdWtd/eXTEA7ASL38i0TONShL4esK7hzhqaGEpItoyC2MZuF1bA4lbnAVWlhHM+V+p/ouO2oyVmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7610
X-Proofpoint-GUID: ILNO2m1iFtPwct4j1xKqSLK_MA3AN9Nw
X-Proofpoint-ORIG-GUID: ILNO2m1iFtPwct4j1xKqSLK_MA3AN9Nw
X-Authority-Analysis: v=2.4 cv=Kv99H2WN c=1 sm=1 tr=0 ts=69d9b17b cx=c_pps
 a=R7TnPQtMnhj+722GCxzAsw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=yIUHOP6RQ3QiVNmNiB8A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDAxNyBTYWx0ZWRfX+bFNjTwg7ldT
 AxS0n+bWnYviIFkkd3XzpRh5ePvLWERlQjiAStc0B0HW6i221MexabDHhCxCjqybgYEw4CkjpNc
 V+OlUINHgpXFyDJVaLrsKiu/ai2IPya6DiVORo1bIEq3VnNZql3RhCOZBVjM75OsIZbx/2jymnR
 1jnvNY5yIUkg4efmwMglBg6DQp1ZUb9KkgCxMiPYROEOjAuc5G6TE7PTK1ttvPHSl16zl2E0L7D
 pixIurmeLnQro2nfYCeIQshsaRxaOOQ76SlfzcgZJ8Ppg8OHYv0EpWaKnjYkgKPH1vMWHaSim24
 ZDXFO7b9IZ1jwpLfMJGhHoI6NXOES/Vp6IlXoA/vWPW3u8YVHW6iP/CZIunQc9YXkZBgG1osEKE
 jJZFIoRLptp/7QCuwvhDpyLHo4UK9oluISMeob5LHT5qMrm6bictPlKjPV3M2jZEhAGffFQUI66
 0dqDpk5qeZpkHgzR4CQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110017

PiA+IFRoaXMgc2VyaWVzIGFkZHMgbWlzc2luZyByZWFkIGRlbGF5IHN1cHBvcnQgZm9yIHRoZSBM
VEMyMzA1IGFuZA0KPiA+IG9wdGltaXplcyB0aGUgY2hpcF9pbmZvIHN0cnVjdHVyZSBmb3IgYmV0
dGVyIG1lbW9yeSBzYWZldHkgYW5kIGVmZmljaWVuY3kuDQo+ID4NCj4gPiBUaGUgTFRDMjMwNSBy
ZXF1aXJlcyBhIDEuNs68cyBkZWxheSBiZXR3ZWVuIEkyQyBjaGFubmVsIHNlbGVjdGlvbiBhbmQN
Cj4gPiBkYXRhIHJlYWQgb3BlcmF0aW9ucyAtIGEgdGltaW5nIHJlcXVpcmVtZW50IGlkZW50aWZp
ZWQgYnkgdGhlIGhhcmR3YXJlDQo+ID4gZGVzaWduZXIgdGhhdCB3YXNuJ3QgY2FwdHVyZWQgaW4g
dGhlIGluaXRpYWwgTFRDMjMwNSBzdXBwb3J0IChjb21taXQNCj4gPiA4NjI1ZDQxOGQyNGIgKCJp
aW86IGFkYzogbHRjMjMwOTogYWRkIHN1cHBvcnQgZm9yIGx0YzIzMDUiKSkuDQo+ID4NCj4gPiBB
ZGRpdGlvbmFsbHksIHRoZSBjaGlwX2luZm8gc3RydWN0dXJlIGlzIGVuaGFuY2VkIHdpdGgNCj4g
PiBfX2NvdW50ZWRfYnlfcHRyKCkgYW5ub3RhdGlvbiBmb3IgaW1wcm92ZWQgYm91bmRzIGNoZWNr
aW5nIGFuZA0KPiA+IHJlb3JnYW5pemVkIHRvIG1pbmltaXplIHBhZGRpbmcuDQo+IA0KPiBOb3cg
TEdUTSwNCj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPg0K
PiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KDQo+IA0K
PiBSZXZpZXdlZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCg0KVGhhbmsgeW91
IGZvciB0aGUgcmV2aWV3LCBBbmR5IGFuZCBOdW5vLg0KDQpIaSBKb25hdGhhbiwNCg0KSnVzdCBh
IGdlbnRsZSBwaW5nIG9uIHRoaXMgc2VyaWVzLCBpdCBoYXMgcmVjZWl2ZWQgcmV2aWV3cyBmcm9t
IEFuZHkgYW5kIE51bm8uDQpMZXQgbWUga25vdyBpZiB0aGVyZeKAmXMgYW55dGhpbmcgZWxzZSBu
ZWVkZWQgZnJvbSBteSBzaWRlLg0KDQpLaW5kIHJlZ2FyZHMsDQpDYXJsb3MNCg==
