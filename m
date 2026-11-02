Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793606951;
	b=gla1XfcTg0XbEaVq4PNa6rOUnkRStO1g2rMwpVxszd/PS/t8ez4T2sQ7bmtXi04MA2R4
	 9OKfaZzejUzNIiHCiWZB0E/28khNIxlv3Yhb48Vhrbuv1mreyTfeVLFXeWz1BNWyJvr8n
	 WQ0PAUQpYYl7Vg+gaWKRMkrJLk8ZVtM5bbuVKsmKZdwcjofjvAGdpstzEYNSU6CPDuoBy
	 NdDVkeAO4yJ4N7fjTCd77euYhUzo4n5c/5pe84IPkldwiJAC1OHfzfd4qUVOfKZ702M1T
	 O9XyvaLmikGXpeMB87hAdKnCuI1Qy46X0nDl1F+fDp7cv2GF9Z9SL1n/Lwb07yCUnPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606951;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sV0mxbUHf7ub191hRXJ3Ee0BAK0NFJY+pyuSvObLYgE=;
	b=iK43pXApSq/YtnDso0+Tn93Dex0yvWC3zadh6zbFaQKTmTKWQ7f5WMaTEYniikRJ8Jvj
	 0ZB2fIO9CrMlpyCGhXuO6wohB8X5iIryjvGJQNAvPeInGBiLVedQ8P8f4dV7ii0arM5dW
	 ARIBuhArH2McLoFihktUx4bUvyYWMbWGrE/ymoptXH37og/f5dzlRnAq2mrgNKFOdllg9
	 N1QvzVvicKA86qOalUka7sWQAMoqkkykxV361T/SMxOY7k9OAPweZLB8uazndpOYHgYiu
	 oqyv7CBWvEzfvTwILSyJFif2GW1Mp14ml9S2lcCPaMeyznooR5zcy7jZMecuVXzCrtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=bi45JbPg;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=HbdGSzxh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB898606A324;
	Mon,  2 Nov 2026 08:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB898606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=bi45JbPg;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=HbdGSzxh
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A23uhMb2200027;
	Mon, 2 Nov 2026 03:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=sV0mxbUHf7ub191hRXJ3Ee0BAK0NFJY+pyuSvObLYgE=; b=bi45JbP
	gj4Ib9XNgh8eNUwYvnrbJfFu/F+WYFO7JjMpYuetLb3V+xl26AVWqrCX4Z4220nW
	V4qI29VLeSAGjBpsCLSvhe19qDX4leraIWbctd16TLLEH2XXIf3DUutz2sJi9At7
	YgOiv78DICQViQtHOv985LPP23K7uCBmPimYsdX6+I/4I9eA1gudQxPw01ZEy7sy
	lNnzUuphzoiuGzUB515+YaPtd218sCZr+7vMED4mWEYBYf3GEh2fJ6+p/hglHaN8
	Ln8Q0MQkLBzirn2jb86+A4KEbLpJsYIFx77yndh/eiRSRQh4u3E+wv3AW4bm1ZTC
	7AhueH/vxALwU1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sV0mx
	bUHf7ub191hRXJ3Ee0BAK0NFJY+pyuSvObLYgE=; b=HbdGSzxhzAgZujfRWiMk9
	pbIcPctzJvhyOYNXN5LIYwYjpjQOC5JEn52v1HBYFmDIxWaFblUw6Z6/p09BymDS
	Jzf4Q4X4WRK5gv8W9dvRMwq6kiqZEXbZPth7VLfA8IiGyipKSx4qSWlPCAc8OT2P
	rNN+84bui9yBUslpwYtxpMBj/R0BDMafhhqligUbpT/w/hymBmwvKQCFVnbibrnf
	ZLMZzCtC/lvZ61eJpI91Ab+RaQ7KwqJirOrudGs0hfcrxTLk7MD01OSFgRXqYWpH
	tFOuoylYdkkENQhSQG8XgNxDasXmi5EUA72wmdoIvqe5qyuHsOdvc0sLezWHwRVQ
	g==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hp38m415t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 03:08:52 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzG6VBozrbnD0f5ai096gaOXAajQM6e6wG0hHogNmhwBWmFb6bD9nAm7O4ea6tOkJrXYhUFZVQ2qynDMBbQrSlG2TwPVS2I3RoNKKofIYjxB/tH4JE5yHeH8Yzqcl7ziD86+UMNUXRNuujFjkXPEQXL+hPCS0T0UmdO6ZovBr9tMJr7aSNUHCTjmNf59MNA4QovsnstoqUQ2QwpWGx3IS4VNziBQi8rM2PPVEWZNBxdGyl11wQg03NBjShhXo/c3ZOLXCZHhwOYXJV9VfxsLtG6+tXZKcPjXSkMWM933sECkKRMTh2G+v9V/vBLabgSxMLh23ZZ0S58LNZQRYniPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV0mxbUHf7ub191hRXJ3Ee0BAK0NFJY+pyuSvObLYgE=;
 b=dq2amv5+qbkVIwvV4KRsArlcep9XbcKjuUnwUC7hh5T/a1tJ2jpiKtKppCTQcR0eopyNTXZ2cmI3JE9T3h9ZOhRRAGnTgXzcOAvFtWQMoTUihX791v5VYORuYHpX/YFeyxGE3V7nqqFtJ6QGgxl6/TByObuCcri0bmSO0O+GxC4A7n2O4tAszP8Rrd/BWr7VMexXwHOChXUamyiDRuAQeS2EEMIoy+C+DVvfke1OFSAghbOXzlRrQzf72Tw5DCHss/HctaoHeqar5qWe2zJhPTz8nCYiVAv541dNUgAaCMAeMNYRQCr7FJWKwpioI/Ag8YGSvcrBW6FJm5IPHFaRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by EA8PPF968D0B777.namprd03.prod.outlook.com (2603:10b6:30f:fff5::84f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 08:08:50 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%2]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 08:08:50 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: "Sa, Nuno" <Nuno.Sa@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Alexandru
 Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux
	<linux@analog.com>
Subject: RE: [PATCH v4 6/8] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Thread-Topic: [PATCH v4 6/8] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Thread-Index: AQHdYtEldoriJAPt/kCdLx93Gi7oJrcWKjcAgARRykA=
Date: Mon, 2 Nov 2026 08:08:50 +0000
Message-ID:
 <LV9PR03MB8414E62A0A91DEF6FA4C6D80F76A2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
 <20261023-adis16607-v4-6-a4d541ebfd13@analog.com>
 <179336921877.155032.13465457472017394020.b4-review@b4>
In-Reply-To: <179336921877.155032.13465457472017394020.b4-review@b4>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|EA8PPF968D0B777:EE_
x-ms-office365-filtering-correlation-id: f920c97c-24c5-4e88-5a1a-08df38b8871b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|10067099003|18002099003|22082099003|38070700021|56012099006|11063799006|4143699003|5023799004|261021121427099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003;
x-microsoft-antispam-message-info:
 oV8iAnhNEao+xVp76vKiYNF+jVw10tZex2XLlMHT3GSDvvcxtI7KVIFLH5EjgEE1LvbTVU0SWDNHxZzCNS9QQsuOyhwHo72YAHOwiex3tVTapHTFb9h/g1uPqlCoT4Ic6a7Z4y1zM8l1h/tuiO1gOsjpXY5esDoYXXoDb3No9Xig5x6KtJrsUfNxdk8x6x/j6nAMzoycJhVoxJ+hjeg1LwQIwDmpKPoTK2Mqxhw94n0xKW1wsDOCGi8gXPNZP2G2TCaYLHZM+ra6e+PgeLF7JbDhuPPLU32EqfSb6HQdFr3FWfDdJDdjTKi81743I0WJ6PR+N4leq64Wd5GGAbCJ8+b8/HrGNdzx5TWqTLygGqZqEQf8f7PgKYkNnwd0Zh+IJIW5fZROUkupYspMHWPvSkHFO9/sXzL8d9p5Jwc0LW/6A9efWYoGoi3mhY36kcgZh14FWQKvexBNUj+AawpJnQUt4O94qpjXclJ810jpVSDU8V6oHwduG4Mow++lw4oh06Wd771srSNxMdN3rzu8MStxVZ75GPcTpGtuVdsyND3lhaIpw7Y8r8lPLHOgcFbFyBUcfRiKW7wt60pgUz12bdOhHZfpmQnNJl/KTNqzqXurqmgi9yhywP1/Xsat7iJF0l8gElTpi4SZV3KmqW8XLbknOMi9Xa9xZYdku2HoytBhvEcJKe+d8xS9L/G3Wt/vsmrssJWqpPRXt/xGvhy90g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(4143699003)(5023799004)(261021121427099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFZzRW1jTzlreStETUFnYTU3UXljRUZidy9OMTQ2UEVGNDJUZVpsZHVTamdy?=
 =?utf-8?B?QW5kSVdVN1Z4Vk5uM29WM0lETlh2RjZveXV5THFmSlR3RmVXb09LUThLRHBs?=
 =?utf-8?B?ZStVWXVTN3ArcWl6aWFFZUNOK3lWZDJORVowYlN3cVZlNXhGb1pBb2NlQzlW?=
 =?utf-8?B?bE9sakluZSs2Y0xsS1JFWEsxamhvMnk1TDFXU3M2ZVY3R3Y5bzdKVUs1bk4y?=
 =?utf-8?B?alRwQU1kWVVidzRicjNjRlF2eUJsUFBQcjFqWUtwZnY4bXRtY1BQN1NIbG03?=
 =?utf-8?B?NWpvSnRVTy9UNk0xUi9mZ1hXY3ZIbWNkT0JDZWtZMkY4dWdmT2NvdVM5akNQ?=
 =?utf-8?B?RUJXYXRQOTdVNU1lM2h5WjQ5WFBGZ3BrQUI5b2cxNFpsYVF0YmR4SUN1Z0cr?=
 =?utf-8?B?eCtsRnpleW9pMEpUbXF4UVFFMGkwWUdRTHpyYldrcFBmSVdjOFJ6NWE1MDIr?=
 =?utf-8?B?cThhWDJ4aUZJeGY1NVp2SmZpbWhxNmFwMzIzWnZNWG9PcmttUm1xYVBlYnNh?=
 =?utf-8?B?YVJ3aHVMKzdwQlVjb3BwR2M2eFpYdThTVGQreDBPdG8vVjJwdm1Uc2NVSG9H?=
 =?utf-8?B?dkJOK1R5eENhUGkxZXdmZVB6d0FzWlY3cGtIQTRCN2lTZDdFTG1YZmpOQ3R4?=
 =?utf-8?B?UDMvc1VUSkt0QXNIaEtHNlhmcVpDS3hBZ3NPcmdndjdPRXc2NkttYnpGODMx?=
 =?utf-8?B?M3VjenF4cGtwL0J5dENCaFB3UUxNSndpQlI2eU1pSDlWdXVsdzNvWFQrYkJx?=
 =?utf-8?B?VDBFUnViVkZsbk5TdVM3bGVZdmFyWDZiZGdWK1ZrQW5Qejd2Mm5lT1g4WXNh?=
 =?utf-8?B?Q01QYm9yOXg1cUYzUmxYaGNvK2FUSi9HbjRZVDN1MUtFNndjQ0RsT01hSUdV?=
 =?utf-8?B?R29pM3ZGM29yQVpQVjBaRTIwQStpWGJhdGFPVUNjOEcyd0pvMGg2QUtBRzBF?=
 =?utf-8?B?MTBEVUo2dk9UUmlkb3FBTTUwMHFwNU1CaXFsMWlXZjNsK2l4Y3RUNXQzNDUx?=
 =?utf-8?B?VUtEekVRbklRcTVTd0JXYnBTMmY2S1I0TGJJOExzUHFlWlY2M3F1ZGVob2ZG?=
 =?utf-8?B?c1B6L0Z2OTdmSkNZUG9uaVZtSWVrekhIMU4wZ3NQQ0VxM3owRDZ0Ly9Kb2hO?=
 =?utf-8?B?MGMyc2VUSWdDRUVnVFRUZUYvVzEwV3krSklYaG40T09pY2VqbC84M2ZiTitX?=
 =?utf-8?B?U3pLMDhXbTlIOXBHRVdDVmRBVWs5Zm9qUTRiV2g2T016ZVNYcER6QUpjMnRm?=
 =?utf-8?B?VTdRRVFpMEVQYVhUeWJwVE4vSlg4MXNoa3laeE1IVkdMWDczeUNWZjY5ZWRD?=
 =?utf-8?B?dHRlaExVbXM1dGwwY1g2T2h0aHNsem96L2pXbS90ZWRiODEwaUZLM2c2WWpv?=
 =?utf-8?B?c0g5R0dpOUk4U2FjL2l4d2I0NVUvNnVqcHViVjRmcEFWdW52ei9xbzFZUTF4?=
 =?utf-8?B?RWRMRWtoSVlLQmpDcDVnVUFlMDN5ZjdtOHhsdnVTc3UwbGFuZFZKenJQY0F1?=
 =?utf-8?B?dFg5UmJFYU0wdVBFMStKZ1ZkQ01Nc25QQ0QzVkhlOGZnczdYZXNlN0JhcXZx?=
 =?utf-8?B?Q2VTWjNJcVMwRmxJRzdVekRmTzdrOWxZNjVQeXhQWFVpVkdnS0FZV1NPV1NO?=
 =?utf-8?B?OGpWVFo4bWRYNzcwS3ZtY0t1UGF4d1lvOStrQ3J6ZTZlaU1HN0dyN1BiT3R3?=
 =?utf-8?B?L1RjMXkvZHlPU0I3T2FWSzhSOGhoUlBQMU53NnhKajFUNHliaGphTHlWa0tv?=
 =?utf-8?B?ODZFV0w4TWphM3lORjdIcWltalcxMkE3WHVDYUdxMzlCTUNDTU96SWROZnlT?=
 =?utf-8?B?T3I5eFpqWVVnK09lQXhKNTlzZSt0c0ZXUGM3Sk9kSmRoVitpNnRWemkwZ0pj?=
 =?utf-8?B?QnU4UWMxODRNMDlVTzRuUzZLM1QwRjdzQ09sQ0ZaZld5di9JWWVJVFNoSHpz?=
 =?utf-8?B?R0lCaGF6TW5zaU1xeVJMT2xqWDBGT0lqTGs1RnR1Y1Y1cUgyR0VZYTlyUjhz?=
 =?utf-8?B?Yk9RRWVnL1hEVm41bU1Ba1VGbWEyQnFNZUNzeVBWZmtQSnJacHFZc0lhdldY?=
 =?utf-8?B?cTdOQkpac0c3dnhHTjQyRkhpK1luaGVsRXdjOElNUHlNL1RMU05lM3ZpTmpE?=
 =?utf-8?B?VllVSkJocFN4NkRYTWRNcG9mRUN2T2VLQzJPWlVUSWtuc2R0MGVNUUtnS1FY?=
 =?utf-8?B?RHY1WFIxckg2azRmazZhYXJrRFlzdVVhaDVIZGtVMXJSQWRrVEVYcE8yU3ZG?=
 =?utf-8?B?ckh5RWpQM2ZjMWUzTHdWeHZoRWdhR2pmajdSbTFWR1FjYjFaVnZzTDRQUWRI?=
 =?utf-8?B?N2VpVHhxanZ6eDYyc3FTUFlheTJaV0QyNVdQRG03UEMrL05maExvakFUcmV5?=
 =?utf-8?Q?vKLJY3t9wblzOZLYcCBtIRu7HjMy6CXug7aBdFIqZro4Q?=
x-ms-exchange-antispam-messagedata-1: 2yMh8aTdrYqJSw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	wn0gkXKpOfFymK7nS7sHR7cGZAQ3yHiou0/LNims3l1f7oq0QBwJUH772kt0txqd1PjDrkjJUo5y4I8l0jkBThdeZIGt1UDFSyZbuLuazMNadSLvII2vzvYisQ55YcBxVlODZgbi0cmsR825noya+M3os6voRRfm41cqjqCHgO6p7dvovmm96LvKa1dt7Kwn0dLm0bshpYkbHuQyAOsuCiBVJWVMMBQAlUf81fXrgtT6w4jYKq0pa7cRCXWNbu3lu7sAbZv8T64bBU/1mdZDgBjXlfTDZoq9jx3wAlG/YRGJSlMtV5ayoWrKNiUs/9KIhJ33oyFVrsRDSmX+oFsTUA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f920c97c-24c5-4e88-5a1a-08df38b8871b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 08:08:50.1588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2vXGBos1y9mA1RgXgnlVYn2/uazCx1B7bXaMFWop2T60s0OlYnx+hhJcs+EI303xkJ7pyZmouiNp7yi0mq8how==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPF968D0B777
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6ae84514 cx=c_pps
 a=5RlqQmsqPSmFSsyCuDtDZA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=gAnH3GRIAAAA:8 a=O3Xxk-7qk82cUH-gYgAA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: GEhsqOQ9wLwfBvhwJ95j21hFrZcMtK8X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX5qXlayk++LFH
 6PtaPxBxkC+u7oTed89dXFmrFeWkd0QeH5K7RkZwClGSHf8YBivcPuMCoO70HLognqqgspvTXr9
 BOue6yuNqSCBF4faOlBrObEP8qmFDZ106aEY1ORUjE8Z/aV8caULKoyMtCryRb8QhbAcdNRcSBh
 rf5lzlQLjyqzdy6d2a1XDHgPNKdmTo378Oe2s6lxhArQaW0nE1HYluGqTtBdVz1bQ3Tfe6YjgbJ
 X0+YWL0BCF/2IZTK+7WOeApzTUTZmXDCQMlNgqqcvKzgoUDYEYAlVn18WVFRf43LFMvFKkhMMHT
 KVww5KDAxuswIkcgcpg5RiVJRFDDwa1EiRVZbizaNUg7ob0te3UO9+KMki6Lu9NLyuz3MX/kzlm
 23eQPl+0SsNctUkAnRXEttlNGFFCw+chZBxjr+BrPZtBpc4b7gzmJJX6fKK/t1U3sipmvTLCixc
 Wsah2PuyEIuYrXYrl+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfXxOULu7jm6QQs
 EX290SWViKcKfxmM6h0CXZG7cLOyDh4YUY/YruQKjWnCG3XsY0iPjWjAjhGCRQOqe2h+SeU/ofu
 L5I0EP04YsTmGShbkPOlIj+KwhwMJeI165CrswSqdmz4GlLZdirX
X-Proofpoint-ORIG-GUID: GEhsqOQ9wLwfBvhwJ95j21hFrZcMtK8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYSwgTnVubyA8bnVuby5zYUBh
bmFsb2cuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMzAsIDIwMjYgNDowNyBQTQ0KDQou
Li4NCg0KPiA+ICsNCj4gPiArLyoNCj4gPiArICogUHJvY2VzcyBhIHNpbmdsZSBGSUZPIHNhbXBs
ZSBhbmQgcHVzaCB0byBJSU8gYnVmZmVyLg0KPiA+ICsgKiBGSUZPIGRhdGEgZm9ybWF0IGRpZmZl
cnMgZnJvbSByZWd1bGFyIGJ1cnN0IC0gbm8gRElBR19TVEFULCBkYXRhIHN0YXJ0cw0KPiBpbW1l
ZGlhdGVseS4NCj4gDQo+IFNvIEZJRk8gaXMgYW5vdGhlciBjb21tYW5kIGRpZmZlcmVudCBmcm9t
IGJ1cnN0X21vZGU/IElmIHNvLCBpcyB0aGVyZQ0KPiBhbnkgY29uc3RyYWluIHdpdGggdXNpbmcg
U1BJIGZ1bGwgZHVwbGV4IGFuZCBGSUZPPw0KPiANCg0KQnVyc3QgUmVhZCBGdW5jdGlvbiBjYW4g
YmUgdXNlZCBvbiB0d28gcmVnaXN0ZXJzLCBESUFHX1NUQVQgYW5kIEZJRk9fREFUQS4NCk9uIERJ
QUdfU1RBVCBpdCByZXR1cm5zIGEgc2luZ2xlIHNldCBvZiB0aGUgbW9zdCByZWNlbnQgc2FtcGxl
cyBkaXJlY3RseQ0KZnJvbSB0aGUgc2Vuc29yLCBieXBhc3NpbmcgdGhlIEZJRk8uIA0KT24gRklG
T19EQVRBIGVhY2ggYnVyc3QgcmVhZCBwb3BzIG9uZSBzZXQgb2Ygc2FtcGxlcyBmcm9tIHRoZSBG
SUZPLg0KRWl0aGVyIHdheSB0aGUgd2hvbGUgc2V0IGNvbWVzIG91dCBpbiBhIHNpbmdsZSBTUEkg
dHJhbnNmZXIgd2l0aCBDUyBoZWxkDQpsb3cuIEkgdXNlZCBoYWxmLWR1cGxleCBiZWNhdXNlIHRo
YXQgaXMgd2hhdCBnaXZlcyBhY2Nlc3MgdG8gdGhlIGJ1cnN0DQpyZWFkOiBpbiBmdWxsIGR1cGxl
eCwgcmVnaXN0ZXIgcmVhZHMgYXJlIHNlcGFyYXRlIHRyYW5zZmVycyB3aXRoIENTIHRvZ2dsaW5n
DQpiZXR3ZWVuIHRoZW0sIHNvIGEgc2V0IGNhbid0IGJlIHBvcHBlZCBpbiBvbmUgdHJhbnNmZXIu
DQoNCg==
