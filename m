Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51159331A6E;
	Tue, 12 May 2026 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570007; cv=fail; b=R6YSqavi++0lJqsvZzEaQHbAUpa1RUZ6aQz0UBYV8E/iLx5y9eDCnNakHl/Ymbg/Qzb8S8S3ggkzeVAjR2jzC7GBwexOcYviE5Fn5Xcn0bvKAWxxHU/EOauSYXsV4W4WntvEHJUpE+QND5+2jHDnngI2Gc/ctxTIy8MKbSDAE2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570007; c=relaxed/simple;
	bh=WIeBFrti8CCoyVv3lzaPBhFz74rBx6EinGP2lQlcplo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aZTXmG3HAZxA3FuEH9msT99a5Q1e8zYCtuYO0eMyA/sKOMq7hNVSQHrVFHiEpREZrNVcudemOVepRWpzMvPsTwUixPgHQBLii3QgO3fb7OHvElWVo9JxbqsI6l8trK/MeZ90qEADEqPNmC/A7qDF9Kk25TAGRi3XXW2YbfdeZ2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=K27xjH+W; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="K27xjH+W"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C33RgY2752421;
	Tue, 12 May 2026 03:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=t4+xk
	q4XEmJbO9DoQbZGOvbuMzyarYl0qSK35Muzc+I=; b=K27xjH+WAuobvfmE+EyqE
	Kh3Z4nSWtN/+70p/e3d+tcv9kuaJmdUsRP0vn4a0SJZA9hFzlZY/sKdBGQjf4NUW
	8aEPeFBOB8VtMDC4thzG9/f1EIL75fKHw4KjT0EG8iAnBRaiif3oU+Gv72279iHC
	HQ2MKQ3l+m8EjJC2YhnvTEXaGJCnjtwi9Lsjq6dzTwjoNNprocSWFM6xXtW3fNtl
	DS5qIwIp5XlEmu5pjbBo5UEX46ocZv/jyYG1qWzbosPrWLipQPK+ZvSuxcTV2Y7R
	Sxfd1G1LeTH8pkZqGTXI0/QvNyY6J2lLOaUiMvzm7kBhCLXnpIU5yY1OLvNENZy1
	w==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e3nw4hp0y-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 03:13:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WD+A3+cVx+BJLLKjB7Q5qSi0sXSvLRi6+lhrhmO5lApbCKwtVroMeT4bu1IXXkWj0JMZUOsAtQwjCN2bSUMM42Nv+5tsbONv5iKZSWRL5Dk8aTb0vmV6Bx0b6e9T3/n9UoxmQaafscsE5KRIJFOktib0DolDNBXDcse7bzq+QQNDnCYKSu7a7gkZkp85vPQbcIp/A2x2KfmnOLEeDR5UlSo1FgK00FDfN9zIupjzcYuGJ99BGKLUwFVYlvch4yAZ0Xs8LL4IIlg0lnGIY0PE7YZ0MCady2JU+4rd+9HwN05+wU1XJjYN3wr3w29QVUF9+TNPWb9i7QPdQn/sgfzE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4+xkq4XEmJbO9DoQbZGOvbuMzyarYl0qSK35Muzc+I=;
 b=iOFC2kGKOPUx5vrfL3DqL7RbmKtctqx9LKoqVFcPewMgN5dceWd6zi6dy3tTv0I36fSQHatNAw067XeJt+bW3e6Yy2772GKOFO9CiGgmiEP5AANaSXqDK/PxkWcbOAdkhv+Jw2+8srDDQpT2mdbzUQuWhELOZUYgPr5JdSByoVDlu797El7/PHvJY1BynlqWDNjCRRdgpCkqz3NRYsOCurVoaNBw7vzduR+b6vbkdG7oF/FtJbjA+hPStOXX/AylMvdm4X55WgJPFWm2KbfPc1iGoxrjdrTsZ1pfOCTaKii52N68rStQnSepSuVF4g9iRGG4AZn5tcQ2okWRVeI0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by SN7PR03MB7208.namprd03.prod.outlook.com (2603:10b6:806:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 07:12:57 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Tue, 12 May 2026
 07:12:57 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Topic: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Index: AQHc1kn/5d/Hh1H9DE+/jMXiSvhLvbXzOXOAgA9qvqCAASwcgIAGPn+A
Date: Tue, 12 May 2026 07:12:57 +0000
Message-ID:
 <SA5PR03MB8377DB8F5136CC7BF9594B64F6392@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-3-liviu.stan@analog.com>
 <ae-pvxKhqmkWwXdX@ashevche-desk.local>
 <SA5PR03MB837776014440C2594B811BF7F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af2UQ7ZLA2DL4FWY@ashevche-desk.local>
In-Reply-To: <af2UQ7ZLA2DL4FWY@ashevche-desk.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|SN7PR03MB7208:EE_
x-ms-office365-filtering-correlation-id: 3a5883ff-f5e2-4f67-1776-08deaff5e4f1
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|11063799003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 0Wco+ZybeFxALkofqluEGhVeOOUUgbDSEfltTKFUNQeSDt4YghCq5yiFoT2fZbn/2tm9eAAZ60gjrpkd7kss1OQAOhyJphTCTVoZcaOT4G80R8OiD4LvugjqMnDBCCk33pfwhBF/hlhRRKMhJJBzL13NzceDyqO5kBBe/0aMrQKGzJnhD2FAuLW0KtNlnMEF85/eaEfJSOLAEJ6Cb2+tAlfmMdOhjgQdqXbGLhAnxgpkA41ZO8HqRBPdu1zxUmXtLO/5fL+JrQT7SVJwl7ln91/6dNRcpmdgnJ9wncDexmUc7uJu3mffUhKhDAmmYwCGcTqKiUcAPWavU1Ifl2dxLyzG63KTVkb/GvvojpdSa1siM7PVLb2osNeurnyqsMLgvaUPLyG+ZXFtcG9lui8/XVM4EqPY6Ek7edue7kaLwNBZjPFmnRLQQjtsBlWdFEoYc+butQxgAMEFTQ3uYK9DdCF3Ew1Otj4qdKwFDivRZINpeSl7C2YhV/xnnKFBmOPFEH9JBjrbMzah/fz8QTOU2BbtyzMf5yd6IS+3FLgEDkPxLdSSDAh2vOiTwyplgugWjEw8nkNF6236PAKYRTNtOWOh2DSxY9iXPv3VMbFUxnvO6D04o6j3DGcXcfS+imOoa/qTIuHrwdA7ULsoT6XxSu7Ckct22jHfyTBKzFFMZcgP7EGSWkhLtbvmTmmKHwZe4H7lgFYiWWUchiyj3ar9R/5GOScUD7S3T9C27vgWYDX9H6Q0FUKw6gWE2YgCu3k9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OgP8IKJAhu3yc9REfEZfhPRakF5I2Zs6X1YhCFF9wI1l7drkRf5iJWAZcFjg?=
 =?us-ascii?Q?7vhXSYf1+ZaVt8+qIZ2JV/OM+NzR2jc1G3CbTyCzYJXaE44yYeojajc45ZVF?=
 =?us-ascii?Q?/ELodgWcoHqt1D7Z8jkwNYnKjGCMGvglutRI06pjcNwIWVDYe1EyzY9MZ3Al?=
 =?us-ascii?Q?9xEG+ASeAT/uiHKwvBKe/BP0+X6u4DkTrDniK9DP3NZ8khdvehqTSzOClNiK?=
 =?us-ascii?Q?ylHIq5LCyt/s77Pb9ZNpuOSejMeWyW4EkLAvR6s0MGB05xOPfePhnsCi8wc+?=
 =?us-ascii?Q?Vyg2vPqlrmahIkJdNFklug3L9oYPUC6p3tV3h75Z1loEVYoJ6Qk7Eq6BuEMf?=
 =?us-ascii?Q?z5hE+n/nk7Rn8zOwSxi5UmkuhmligosBs5LJpS4wLeYJxpi3XHhQ00T+lTv/?=
 =?us-ascii?Q?m5rMqfCoxeYuhoWuodOI2PLNcEjclyA/UJtfiNtmgsU2uz8yriSfPguaYziO?=
 =?us-ascii?Q?PvoWb7FeLtHVWdB7yZ5RUzomBKPyN5Y0s/zO5in+ZHk0Pu6372IUaCxDdrf1?=
 =?us-ascii?Q?RsRwtpBW+Ld5n5KGNy8u+dN/yydx/4R3epiuC5xixi34ESzvUV1o9zGkbRGx?=
 =?us-ascii?Q?WDCN6Czyk+V3FEqJO40hGAVlEQxXPY8tT8RjyXgFu4QC2HQRtp1xb6hMQWzR?=
 =?us-ascii?Q?meNiuvKBQ6zHGVxr98xRkfxKpHL5SY4Uo8OO7R0uwcR6fbgFCAAJLGHGRPE/?=
 =?us-ascii?Q?F+4luB3i7p5/Tvf+y1Qz5NGOTsvlFD6EQU5eCoWPacqx/PSWtMuaKGzVAWs5?=
 =?us-ascii?Q?M8xmcO7KSbXZ3dRP7AeapygBVT5tRNVQXOrZlA7Aybie1VcG30YjVA/U9U5w?=
 =?us-ascii?Q?6CaEiBUkHLUTaCfbFPLmvOESiw5WPuiNZdsBiepSK/+4AhK5z7egLr1QHUF9?=
 =?us-ascii?Q?/1pEFiJDdMFAWJNrii/G14heCL+3xb5ZEXbkjwfrL/kwVCznmQ77xE9be58x?=
 =?us-ascii?Q?rTcNZiEpXT7nDBccoeBwGlBkaD1sANmspH3OLAV+3PvhdUQTHWlvqqU3Pgi+?=
 =?us-ascii?Q?rXfmCdHvN3iEs4JsAYVvrad3uVmVaKUlyM2wbeERlNxUGT0zrl+rvniN9khx?=
 =?us-ascii?Q?g9OFO0Z34c7yN1gcc3FwbnvSXSW9RHi4jRFBkbkuUOUU2qEMLbkrRNzoNGrx?=
 =?us-ascii?Q?Ahsp4PL9EJ3Z9KCPlcUDMtvERrKD+eNC94nuLwcvCcGYdC6+ELVqUvLTUzBl?=
 =?us-ascii?Q?90axz940RlS2N6f70zRQOlOjaOfGi3kijqXKSDyZ6+5gWWJ4jk1KzA5F1Nkv?=
 =?us-ascii?Q?+393ht56LonVmA/KZ+Dt8Sxw6Erde5LRHgBD1Vxzed44YyqrxBzMgQRdNeO6?=
 =?us-ascii?Q?zCPP4Um+N8i9sLReRxo3L6heS166/MdLxErA7mTDNJm42Mx4TKZhoKBSpjmG?=
 =?us-ascii?Q?t8P2qq+a8Urf/iwQEdSZ6ZotpyNaQKE/3+/aTJJvazHnGs7Zwk/ckulWFvu3?=
 =?us-ascii?Q?a5DTPd6VBeA5QtJosRJdQEmYnLMHkyzyW0ItlfEgf404BIMZ3W0Vu01h1YEC?=
 =?us-ascii?Q?qf98VInansf3NczI07SYKBIJV6olbRXbtD27rL5aH1w1hHuMSU50iPnnZ2P9?=
 =?us-ascii?Q?CEQlOtcxJPoo1OJqwJF/tEw9swLKb4JKlGx8W2AMCdY82VoPS2R08LpL1EqK?=
 =?us-ascii?Q?E0F/L5Gsb5wlDoyN/iU8rgPY4bU9wuEWD/VludZMcc7k1K6iAz7Ye3DBenAV?=
 =?us-ascii?Q?Ros4gBJtyJah1TxBvmBETNbe0wDp7w5PFaLCPF06mkOWlvf4KovjrYTfdN7F?=
 =?us-ascii?Q?IhKU770fgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	R1i2ClUE4glrdvctm/UV9nuEvp11ZqdsEvvKlrwKkO0FDxggps9cKEyEl+RkFBtKw4xe2GFXANUdKMFlqjDuA5I3jTOZAMhBUlGBZ8DU9Ggub4+oqLVD+5SMaHugXSqUwbJnZjn+dQ9G8+eQIgQI62iOWHd8IScuHicZrYz6S+fj/AWCgEUiGCvSEGji/cjP/keRFFZ4BtE2TSkuOAge4ryuIlXsxqO3Kqac9eRP+U/rNTGrPdMhF+1hR9mKtHqZbDM1N248UdxoAsXO4osVSXWN1B7R0YQD64gE86vMnlydJOc3qZBxb+xznsyAzikFLyGFxu9Fnk3S+MzbDDxz6g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5883ff-f5e2-4f67-1776-08deaff5e4f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 07:12:57.5928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBTzp/ljpZL1StzxKy4M6m5HqqDTpObzEySSRjPZetg4vOogl+WU4fhu4dLM6u4q5fZcg+pgljUvGkSbd4pzPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7208
X-Authority-Analysis: v=2.4 cv=LN5WhpW9 c=1 sm=1 tr=0 ts=6a02d2fc cx=c_pps
 a=4YDC/s56AEiJKWlPnw2jOg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=HcneQ26LweoyU_PHxn4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: DAkq9JkgP0PPk0K9nxjeC17U7vBonrxC
X-Proofpoint-GUID: DAkq9JkgP0PPk0K9nxjeC17U7vBonrxC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2OSBTYWx0ZWRfX8U+8lJXXUZ+l
 tyQXK7AN0zzvzkDE4TYKUUmNpgcQo4GOj3Q9RAZXtarG1gQmRWnZa8ateNjWhKB0woVeZhhDBU2
 DQPxPMZPKKENevLA8FEZbSs7fMxDNkZhjhvSXu6EzH1Hgi+gfMk0zSExC4ohUTQ2ZSjD9ZVSt5z
 EkN5ukU6qp6x0T2ybgn/XGcb9glPMMdPlrW+u2+CzDhBAGjnUacw/EWvkauR0g+OKv+gG+bVTvy
 Fl89DAANc1qT9DnnzPUurXcht1ztauUPVN2A45JfypumNtdjagrZPLSzMganNYMb1e27Znt60Gq
 85VVgA3lrhaOHhBreK1ChHAM3Pd23+MqQw6jRufm6Rbb54OH8jY82M1UEJ/N6X44A4oTg/iMc7A
 N8HleydrWJNM3EB6N5XZiey8Ex+kfwiLH54MLHBvKnxP+XBhda7RCLE4EtcSG17eMIhTjKxk4r7
 mOwlgeW8zFBBwe4ECSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120069

On Mon, Apr 27, 2026 Andy Shevchenko wrote:
...
> >  #define LTC2983_CHAN_START_ADDR(chan) \
> >  			(((chan - 1) * 4) +
> LTC2983_CHAN_ASSIGN_START_REG)
> > -#define LTC2983_CHAN_RES_ADDR(chan) \
> > -			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
> > +#define LTC2983_CHAN_RES_ADDR(chan, base) \
> > +			((((chan) - 1) * 4) + (base))
>=20
> For the sake of consistency I would see (base) also to be in the _START_A=
DDR()
> macro.

I said I would change this in v2, but on second look, I think it would be b=
etter
to keep LTC2983_CHAN_START_ADDR without a (base) parameter. The base
parameter in LTC2983_CHAN_RES_ADDR exists because the ADT7604 adds a
second result register bank, so the base genuinely varies. For channel assi=
gnment
there is only one bank, so adding a base parameter would make the macro loo=
k
configurable when it isn't and force callers to always pass
LTC2983_CHAN_ASSIGN_START_REG. Happy to change if you still prefer=20
consistency.

Thanks,
Liviu
