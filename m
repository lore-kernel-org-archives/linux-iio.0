Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83728468E;
	Mon, 30 Mar 2026 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881086; cv=fail; b=P3paP31fFu2F0PSJnp9lIBHMBc96ZrTAQT3tq9o6FBYoi7rYnEZUv8lgalGQ+E4C0AmsQLB1ARqLCMNs0Y7jkGhVdtyvvZ6snlCc7hR48duf8jpnKMwdVCzf/iHw9DL817RAANdMDZJPRlU/qLSUIQgbaegYgHcrfRwobFmGOZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881086; c=relaxed/simple;
	bh=mCPjPGWYzRVzrqlKj+QaS2hnAMLBR1a8PABlXXPPfT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vx/GrCb8dKPRLNXcX8MtdgI+cpsF8VTCeXxJNZOwH2ZQBTp4LWP/HSHuA32/wuvSjkqvvXuEZFwHyZD9dYVVf0BkIZKy+PZuIlvefOI8OSOietn2zF4tZslNot9YftPpuHM3WDSzZE+gG96ZwmyUkzLGHRKNMlJlCjLnzRNWY9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VWKPFn5A; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VWKPFn5A"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAwI712844920;
	Mon, 30 Mar 2026 10:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mCPjP
	GWYzRVzrqlKj+QaS2hnAMLBR1a8PABlXXPPfT0=; b=VWKPFn5AutLQgvkc4S7L/
	g/7c1TqbfygSxt5MHvQ9s361KlOFIagHSexwP2Vd16q/N7c/3JJJEkfS5j5QmSbD
	nuR1sZjJc36pClOCgwGGmp/+vSB7O81vTbG0cCZ51f09kwxfM4I/eGc6jg7BybHO
	uk8TnJcP5iRZtmTlOaWMsNvRYCnrSfjxDDxXlwjNVm5kvndXpDnrHwZ7kwGTQG4Z
	FwROIsUyWr7x6jxMjlnBLuXQ+L9EJXETzGXLFXcc3H78dmGr0Zi3+9H/eu2CjbrK
	RvF048mFHEIlJR4iAMOJtsWF1TyCqE/mGTJMa3oxqjPQo74Pqrf/z1RICzkzC3KH
	A==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d6bw0ydqy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 10:31:10 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi116WoxmhAkCCxvKLYhv8RVu+1PufPdBDTPCuAZlHt/M1HQfjhOyGkyQo88vLFwVYh5OgK60S6yre42N5NnkwsdPdpvejTUDgE+MZsz2U2UiFCzkNgU19QL1Umm6R8YNFXfsxSjzuarcnsFOCppalmGHGS45iajqad8/ow6CoCXJv8bOKJo++ab4rDE2usHB4TnwypZ69rVXHeght9UF6k4m3gwhGgjqdWQhyLWD3yzZVHIbnxYvPhFSSZ/MTV73ciXFjJVmzfCio/CxUiggLP+LadtjvKdz4cJuLBiNhMdwm/GbUViBgCKJxKcXv0NssMutaXRZf3VqQWsmKvXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCPjPGWYzRVzrqlKj+QaS2hnAMLBR1a8PABlXXPPfT0=;
 b=Cp0Q3Dkotj66PLM7juJwOVZF/HMLxevNdwqcIOMqxn804Mwaf0lnIymCrJm2sNC2kChTz59NDDIAwU2dddI0LH7MnPV1Yxfo3OkUDDEmFdIZ9mZQNosEodQ+4v4+LSh/HYeczYTKe+amGD85DoAQOLtflxx5+U8E+k0gm07dnNOy/5jdDyQ3xPo9T2i9jY/3Zhqff0jtc8mMvII6SJIRGaoSoHE+V6CNQYH95GzjxX8MNTM8U+E7V17TZtUrdaldYuIDK4uIrtLVLPeMjHw2VGJu6UIk2RslUIDRrCCn+rQiCmsHzvE3arnqoKC6Ff4DMKwZ6L/U/MobB2bTetjKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA5PR03MB8425.namprd03.prod.outlook.com (2603:10b6:806:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:31:08 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 14:31:07 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        Andy
 Shevchenko <andy@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: ad4695: Fix call ordering in offload buffer
 postenable
Thread-Topic: [PATCH] iio: adc: ad4695: Fix call ordering in offload buffer
 postenable
Thread-Index: AQHcwEn8Qxc6HLDZw0mwofc8cAcz8rXHHZmAgAAEOWA=
Date: Mon, 30 Mar 2026 14:31:07 +0000
Message-ID:
 <LV9PR03MB84144580E5523DC01542E56FF752A@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260330-ad4696-fix-v1-1-e841e96451b2@analog.com>
 <cfe07818-e040-4ce8-9407-d951df637af1@baylibre.com>
In-Reply-To: <cfe07818-e040-4ce8-9407-d951df637af1@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA5PR03MB8425:EE_
x-ms-office365-filtering-correlation-id: d5bf997a-686e-4023-880e-08de8e68fb72
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 W2gqGNbnIEdBEd37nU5ifmx6ZxE90cC9Zq5GqmJ7Miqt2+qNe7SVkjzUADwZPGZ9koWUeGJbLnTCnll+C0u+/1/bfL0FWUEw4c4DU6d722CPc4y+OWD1V+Dsi7OyTG6DFq7DSnl+IrD2ZKhsu+c/WVx//8ORKa7cAF/qwpH6EAVzCcAEeQCD/TajvC/8oxXF8cQK/JfxeBnTvBpb3NdNJ6mZ/yTy/w1o17zsn+cMZqx6zlXZcWJq5RVzwyNds2KcS3XmL05JYF+04u9A2uddKLxU72T2a3ESCtAbEszAXf7+W2HOf57OXDGKMJOBJf6JWT1saiAKA39vJe4riDOKp+RxXgkvvKqmNe+g8AecimCOKHLKUERRo3MdZBxd0K5qlpRvHf1OmMM1YFxMopbpvJeznIHMOID7sJ/oJTc1J4nk9u7NTNYmB2EEbLLJGCpjfFMdu8rkKCh8P4augVskk1WB643ZkNLFRvEql5wAS25RFQdBJw2G9pyJciUhqQj1Q0ampHaHWeFDCOaIhfPyiYNwyoFRvy/Sq1sNUBWmgQLCCr+WrQhgNMWvySfEehuawJTwEtBwZhjjv8HQwX3b0XfPHSnmx5jfHwf0d9zpZbG7VUsjhtQ2PVx38Tixv8xb/JPoY0cE8x+UEa3BNd1aEh2qKV2m3bSniR6+2sDf6M09+b4BvLaazuqa+VUJIPxHi2AF82OF3DYJHylK+NMA6MsEBhD1TL45CZZud6jMnd/5TzKdfpjtsusptXBC39L90wmfkqEOs35YyZHx8mqx2xd4TA9+tbr5JLgpU6W2wmg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWFadm44VGdEbXY3OGN2NjhEQm1saVBXMy9pOWdGTjR3Ym1GOUFISmdIdFN5?=
 =?utf-8?B?Qm5VVGp0Ym45TE9XQTcyUjIyYk5xQXUzOW1kVjR2L3RHVVNGdnd6QzJvOEJS?=
 =?utf-8?B?Y2RPREFBc2FXRWlMc1o1V1BUNjh6QmNUZjRzNU1wS2gvTG5iby9qejV0Q2xD?=
 =?utf-8?B?OEtzR09TNXdsdGpZY1VCTWtqbVlXVTI2dFc0OFdsaGE3Rlo1cC9YcCtjeGhO?=
 =?utf-8?B?L0JhWGJuTFRVeURFbnJJWFQ2NDE2U2xvQnlPQU1zbXZwc2dOT2FoUmNSZ2E2?=
 =?utf-8?B?OTVDbGxSalA3MzhvZlUzNE5LeDNvZG5lNitrVzZrVFNCQkVyMFd5Vlp6UmRp?=
 =?utf-8?B?emIwMzVlWVh3Tkh6MlNxQmhYTGdHVHdNL0tEeEpWdFV4a1VlUWVJc0ZzTUxY?=
 =?utf-8?B?S2w3VC9wUCt5dmxPa2dqTi9Jek9KOFhZU1VCODVCcFNwZEw2Q2FCZmxFL01N?=
 =?utf-8?B?V3R3ZEIvZHZPTHp5cGVtenZxOVpSVU1lZ3JPOVRsVzV6WXBnZUhwalMxZ1NE?=
 =?utf-8?B?VGI0ckh5YUd6R25vOXRaaDRJWWxqTHFPOFNQVEVDN0xvTld2czRaWHR0QXJ3?=
 =?utf-8?B?TXF5VXNHT2lvdkc1Qk1zekRtZDkxcjRkQ3dlbnViRElOYkVCb1ROUlRtSnYw?=
 =?utf-8?B?c2ZqOG5yYlF4OFFCRTNWZ0Q5T0ZxdXdnUzJRWER1SlB4VmpudFE2YXQ0bVpV?=
 =?utf-8?B?NGxYVXBtbFhRd2d0a1dqUEswQkJPK3FFL3Z5SkFYcXhJcUZSZ25XWUJMWERx?=
 =?utf-8?B?Vngrc3djK291U0dpWWFUOVExZW5JQ3ZkaUovOVlQc1FIa3FtK25KaXg4aXN1?=
 =?utf-8?B?Lzg4SUJLYjV0M1grakR0Vi9jcTBiNk0ycjQ0QmU4dWNzMWpDbWRKbEF6Zm90?=
 =?utf-8?B?amZ4eStWTkZlTmNodHZ5LzI1djhKMUlVZmxQaSsrNVVQZm5MeEQyUU02a3NI?=
 =?utf-8?B?MkVsV2JWdjZCVmF0SmVkT0FnSDd0akEvRjgwVS9pY01Ybm5taGdwTjIyM3lW?=
 =?utf-8?B?RnNOVEVhVmxkSzgxaFNFS01EQy9rc2tCT3NBYWhwTnpOYSsxcjNNdzBiR0RM?=
 =?utf-8?B?MlVNSkYyUTI2bFNyQndFeXNTSTV4cXlCNmhxZ1JZSVJob2hLck1CM0VHME5i?=
 =?utf-8?B?Z0FSV2QwSlM2Qm5OODY2QWR2b3FtajBHajUvU0pDZ3RPRXErcGpQdzlnUWsv?=
 =?utf-8?B?ZUFRSFlGYmlFSXZMRktNVEd2Undia1MzMUczKzFPL2grNEVSWjhQdFk1bDJS?=
 =?utf-8?B?aUpUcFY0L1JGZGVScVB6UkMrMEFuVlV0M08zZWdCc2xtaVltSExBWitkaWIy?=
 =?utf-8?B?NXFaS3ZJanNGbFg5RzBUVWt5UDEvR3d4RjZTVktQelFjcnZHZVI2aElIR1V1?=
 =?utf-8?B?UTg4Y3MxQUU5dzJuajIzQ05GRVRqZWxIdkp5anM3OHFuL2VDK1Fsc3A2Kzcr?=
 =?utf-8?B?b0pOeHpyYlJVYTE5NzRCclp6RTJ2VzArTU5qMUd2ZHFESnB6L0l6T1NSaURT?=
 =?utf-8?B?UHhlTXBORytTY0ovQkducWx1cFIrZm0yZnBiSnNqSzhVdUcwYTU1VGQzL1Jo?=
 =?utf-8?B?Vmo0TFduWVpaZGRPazNScURhOXkxbGZzc0xPTkVOMjdJRitqT0J4MmZSWTNy?=
 =?utf-8?B?alJNQWZIUVM4TTNqTjlpdHQ0VkZXdFNZWjVUUTg5bFQrZmZYMjl1V0ZyRXQ5?=
 =?utf-8?B?WXhMZloxbEdISGN3ZjhiY2NMa0h4TVNkRlMyV2VxbHhTV21YVkNMMnlDL0xn?=
 =?utf-8?B?NTVvN1gzc2JRdGd3cURNc3A4S3lpeUZITm5LYXdkbTg2RU9SZDk0RExzVTk2?=
 =?utf-8?B?NmhJMEpPSDVGNGwySFVYTHBtSDIzblpYTUw0N2xwcTBTLytKL1QyMVQ2SUVa?=
 =?utf-8?B?NmJZb2k2cEQxOFo4QTFsU0FVM1NQU0RzTG1XUFROY2FPZmZZczV4b2NHS3g0?=
 =?utf-8?B?K0IzVFNSc2x1MTJjNDNmSk9nU1M2bXYzQzFCbktpME1qcUZuM1dIQzRtTGxa?=
 =?utf-8?B?dW5oTzN3L29Ga3VGOVYyTFFORXhKVVFycEV5SVFOSWVxTm1Penp2N1RQWG1J?=
 =?utf-8?B?T3RIMHJKcWY5bzJQZW1kcG4zR0psb2ZBL1A0TCtVV1JjL2kvdVRGSTFuVEV4?=
 =?utf-8?B?emlaSFplYytOTjRVc1hKRDNIaTZJdDRxS3FkT0RGSHMxT2U5NVZBT28rRHlq?=
 =?utf-8?B?dENSS0FJL3Ywc2ptdTBaT1V3Rkp4RHdER2huT3lKQzFDb2diM3E1YU9WQUl1?=
 =?utf-8?B?SGppSlNQN3loWk4wZ3F1bDZRTlJCcVplS3RheVoyazdGam9ZWWl4aHRhYmJ5?=
 =?utf-8?B?Q0IxUlE2QllINExRNk5oMzU0ZzBidjJubWxRTHRhdXhRMUVWR0hqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	OcshYjMHklHaYwJozPODFWzqJUSGt87rCl5F1oZcAn2IMeGOdkgdZ6n9HOZsDB8mCot4+dnSTl0I7TXxuzA1G17hjFHKR5+SWEoPoxNrUr24O0E/0RWBn17dFDrSrQtoH9MaUk41Vzfn/gPGu5iTfn6h9Tnbk2yI3NMDfrArY3IrwSEX89ylDHyCT0HhC28zxDnH6tXWFQ4yJajsSKgZTT8XgR5vpBN18a4IcNVkTDEUUrdOZ+1qzflwimSLGio2+1FhTVqCdVm25VO3+hipSmcjVPStt7sG/jt3OETWzM5sVYFtokO3OMhodPZA2GIkXCDnc7zhZitUhifff+Eo9w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bf997a-686e-4023-880e-08de8e68fb72
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 14:31:07.8979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoZhNjwzTxM9OEvBrX+lH0fsWFaoWdxCBFNTvBxhibrQwVhKHrnACNV2UQuZYX+h1xDwGI+QP1zNPTogaT8GVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8425
X-Proofpoint-GUID: AKbDiarwwgmbd7fo6PlJUyobaygJYWjY
X-Authority-Analysis: v=2.4 cv=BqyQAIX5 c=1 sm=1 tr=0 ts=69ca892e cx=c_pps
 a=feJg8xcwi6yo0k/5NfVkgw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=XxBwZlBNi-Vj5sPlYN8A:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: AKbDiarwwgmbd7fo6PlJUyobaygJYWjY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDExMyBTYWx0ZWRfXwa1bZrDjwAEW
 RoGvSJkFusR1ANb9D0b479ifMoSf8aVRfhZ8g+RjjDNsiURZdW3bBu7OkYTQCwfU4R8QPKZqIRq
 n8zbptX27ERDMTboPG1nI7fy32u/1GmPRfe1rPlo/2dGXN2dVMT22/VMEBgIa9iobt6ONtKm1BP
 fo1Q/joTBt/kQMRcK+McWAEgWoB4H6t6nrkkwuKSO+c1gLOm8DlEr0NKlOTXHesXSY9jOyfCYUF
 VCvOcP1CniZG2g+wZhNEeNS/dpUZIDyAvFn+3C+a5KMLRc4m2d7lnBDLG6LcwXcHLY/3SKxHR05
 SAvlflrltdr3UM9xwNQvVBIxEq2tsfdG5+yR8qK3hu9AxKa1RgcVL43r0YQaWPhFJknySYaTad/
 2DuD0bXhHvp5DWJG0v52/6s3BBhlBUteIDwRWePtl6gp6FnoW6uxkBiQ+gvH5EQ6IXulPXvqtR0
 wiiLGkm0/R9rjzavcmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300113

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDMwLCAyMDI2IDU6
MTEgUE0NCj4gVG86IFNhYmF1LCBSYWR1IGJvZ2RhbiA8UmFkdS5TYWJhdUBhbmFsb2cuY29tPjsg
TGFycy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28uZGU+OyBIZW5uZXJpY2gsIE1pY2hh
ZWwgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+Ow0KPiBTYSwgTnVubyA8TnVuby5TYUBh
bmFsb2cuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47DQo+IEFuZHkg
U2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPg0KPiBDYzogbGludXgtaWlvQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBpaW86IGFkYzogYWQ0Njk1OiBGaXggY2FsbCBvcmRlcmluZyBpbiBvZmZsb2FkIGJ1ZmZlcg0K
PiBwb3N0ZW5hYmxlDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiAzLzMwLzI2IDg6MzQgQU0s
IFJhZHUgU2FiYXUgdmlhIEI0IFJlbGF5IHdyb3RlOg0KPiA+IEZyb206IFJhZHUgU2FiYXUgPHJh
ZHUuc2FiYXVAYW5hbG9nLmNvbT4NCj4gPg0KPiA+IGFkNDY5NV9lbnRlcl9hZHZhbmNlZF9zZXF1
ZW5jZXJfbW9kZSgpIHdhcyBjYWxsZWQgYWZ0ZXINCj4gPiBzcGlfb2ZmbG9hZF90cmlnZ2VyX2Vu
YWJsZSgpLCBtZWFuaW5nIGEgcmVndWxhciBTUEkgdHJhbnNmZXIgY291bGQgYmUgaW4NCj4gPiBm
bGlnaHQgd2hpbGUgdGhlIG9mZmxvYWQgd2FzIGFscmVhZHkgYWN0aXZlLiBXaGVuIHRoZSBvZmZs
b2FkIGZpcmVzIGl0cw0KPiA+IGNvbXBsZXRpb24gaW50ZXJydXB0IGNvbmN1cnJlbnRseSB3aXRo
IHRoZSByZWd1bGFyIHRyYW5zZmVyLCB0aGUgU1BJDQo+ID4gZW5naW5lIGludGVycnVwdCBoYW5k
bGVyIGlzIG5vdCBkZXNpZ25lZCB0byBoYW5kbGUgYm90aCBhdCBvbmNlLCBsZWFkaW5nDQo+ID4g
dG8gYSBrZXJuZWwgcGFuaWMuDQo+ID4NCj4gPiBGaXggdGhpcyBieSBjYWxsaW5nIGFkNDY5NV9l
bnRlcl9hZHZhbmNlZF9zZXF1ZW5jZXJfbW9kZSgpIGJlZm9yZQ0KPiA+IHNwaV9vZmZsb2FkX3Ry
aWdnZXJfZW5hYmxlKCksIGVuc3VyaW5nIGFsbCBTUEkgYnVzIGFjY2Vzc2VzIGFyZSBjb21wbGV0
ZQ0KPiA+IGJlZm9yZSB0aGUgb2ZmbG9hZCBiZWNvbWVzIGFjdGl2ZS4gVGhpcyBpcyBjb25zaXN0
ZW50IHdpdGggdGhlIHNhbWUNCj4gPiBjb25zdHJhaW50IHRoYXQgYWxyZWFkeSBhcHBsaWVzIHRv
IHRoZSBCVVNZX0dQX0VOIHdyaXRlIGFib3ZlIGl0Lg0KPiA+DQo+ID4gVXBkYXRlIHRoZSBlcnJv
ciB1bndpbmQgbGFiZWxzIGFjY29yZGluZ2x5OiBhZGQgZXJyX2V4aXRfY29udmVyc2lvbl9tb2Rl
DQo+ID4gc28gdGhhdCBhIGZhaWx1cmUgb2Ygc3BpX29mZmxvYWRfdHJpZ2dlcl9lbmFibGUoKSBj
b3JyZWN0bHkgZXhpdHMNCj4gPiBjb252ZXJzaW9uIG1vZGUgYmVmb3JlIGNsZWFyaW5nIEJVU1lf
R1BfRU4uDQo+ID4NCj4gPiBGaXhlczogZjA5ZjE0MGUzZWE4ICgiaWlvOiBhZGM6IGFkNDY5NTog
QWRkIHN1cHBvcnQgZm9yIFNQSSBvZmZsb2FkIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYWR1IFNh
YmF1IDxyYWR1LnNhYmF1QGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gV2hlbiBlbmFibGluZyB0
aGUgSUlPIGJ1ZmZlciBmb3IgU1BJIG9mZmxvYWQgb3BlcmF0aW9uIG9uIEFENDY5NS9BRDQ2OTYs
DQo+ID4gYWQ0Njk1X2VudGVyX2FkdmFuY2VkX3NlcXVlbmNlcl9tb2RlKCkgd2FzIGNhbGxlZCBh
ZnRlcg0KPiA+IHNwaV9vZmZsb2FkX3RyaWdnZXJfZW5hYmxlKCksIHJlc3VsdGluZyBpbiBhIHJl
Z3VsYXIgU1BJIHRyYW5zZmVyIGJlaW5nDQo+ID4gaW4gZmxpZ2h0IHdoaWxlIHRoZSBvZmZsb2Fk
IHdhcyBhbHJlYWR5IGFjdGl2ZS4gVGhpcyBjYXVzZWQgYSBrZXJuZWwNCj4gPiBwYW5pYyBpbiB0
aGUgU1BJIGVuZ2luZSBpbnRlcnJ1cHQgaGFuZGxlci4NCj4gDQo+IFRoaXMgdXNlZCB0byB3b3Jr
IChJIHNwZW5kIG1hbnkgaG91cnMgdGVzdGluZyBpdCB0byBhcnJpdmUgYXQgdGhlIGN1cnJlbnQN
Cj4gc3RhdGUpLiBBcmUgd2Ugc3VyZSB0aGVyZSBoYXNuJ3QgYmVlbiBhIGJ1ZyBpbnRyb2R1Y2Vk
IGluIHRoZSBBWEkgU1BJIEVuZ2luZQ0KPiBpbnN0ZWFkPw0KPiANCg0KSGkgRGF2aWQsDQoNCkkg
YWxzbyB0cmllZCBsb29raW5nIGluIHRoZSBBWEkgU1BJIEVuZ2luZSBhbmQgZmluZCBzb21ldGhp
bmcgcmVsYXRlZCBmaXJzdA0KYnV0IGNvdWxkbid0IGZpbmQgYW55dGhpbmcsIHRob3VnaCBJIGFt
IGhhcHB5IHRvIGJlIGNvcnJlY3RlZC4NCg0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgZml4ZXMgdGhl
IGNhbGwgb3JkZXJpbmcgc28gYWxsIFNQSSBidXMgYWNjZXNzZXMgY29tcGxldGUNCj4gPiBiZWZv
cmUgdGhlIG9mZmxvYWQgYmVjb21lcyBhY3RpdmUsIGNvbnNpc3RlbnQgd2l0aCB0aGUgY29uc3Ry
YWludCB0aGF0DQo+ID4gd2FzIGFscmVhZHkgZG9jdW1lbnRlZCBmb3IgdGhlIEJVU1lfR1BfRU4g
d3JpdGUgaW4gdGhlIHNhbWUgZnVuY3Rpb24uDQoNCi4uLg0KDQo+ID4gLQlyZXQgPSBzcGlfb2Zm
bG9hZF90cmlnZ2VyX2VuYWJsZShzdC0+b2ZmbG9hZCwgc3QtPm9mZmxvYWRfdHJpZ2dlciwNCj4g
PiAtCQkJCQkgJmNvbmZpZyk7DQo+ID4gKwlyZXQgPSBhZDQ2OTVfZW50ZXJfYWR2YW5jZWRfc2Vx
dWVuY2VyX21vZGUoc3QsIG51bV9zbG90cyk7DQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCWdvdG8g
ZXJyX2Rpc2FibGVfYnVzeV9vdXRwdXQ7DQo+ID4NCj4gPiAtCXJldCA9IGFkNDY5NV9lbnRlcl9h
ZHZhbmNlZF9zZXF1ZW5jZXJfbW9kZShzdCwgbnVtX3Nsb3RzKTsNCj4gPiArCXJldCA9IHNwaV9v
ZmZsb2FkX3RyaWdnZXJfZW5hYmxlKHN0LT5vZmZsb2FkLCBzdC0+b2ZmbG9hZF90cmlnZ2VyLA0K
PiA+ICsJCQkJCSAmY29uZmlnKTsNCj4gDQo+IFN3YXBwaW5nIHRoZSBvcmRlciBoZXJlIGludHJv
ZHVjZXMgYSByYWNlIGNvbmRpdGlvbi4NCj4gDQo+IGFkNDY5NV9lbnRlcl9hZHZhbmNlZF9zZXF1
ZW5jZXJfbW9kZSgpIHN0YXJ0cyBzYW1wbGluZyAodHJpZ2dlcmVkIGZyb20NCj4gdGhlDQo+IGlu
dGVybmFsIGNsb2NrIGluIHRoZSBBREMpIGFuZCB0aGUgZmlyc3Qgc2FtcGxlIGNvdWxkIGJlIGNv
bXBsZXRlZCBiZWZvcmUNCj4gdGhlIFNQSSBvZmZsb2FkIGlzIGVuYWJsZWQuIElmIHRoZSBmaXJz
dCBzYW1wbGUgaXMgbWlzc2VkLCB0aGVuIGFsbCBvZiB0aGUNCj4gZGF0YSB3aWxsIGJlIG9mZiBi
eSBvbmUgaW5kZXggb24gdGhlIGJ1ZmZlci4NCj4gDQoNCkkgdGhvdWdodCB0aGlzIHRvbyBhdCB0
aGUgZmlyc3QgZ2xhbmNlLCBidXQgY291bGRu4oCZdCBiZSBzdXJlIHNvIEkgdHJpZWQgdGVzdGlu
ZyBpdA0KYW55d2F5IHVzaW5nIHRoZSBGTUNaIGV2YWx1YXRpb24gYm9hcmQgYW5kIGEgWmVkYm9h
cmQsIGFuZCBldmVyeXRoaW5nDQp3b3JrZWQgYXMgZXhwZWN0ZWQuDQpJIGhhdmUgcGxvdHRlZCBi
dWZmZXJlZCBkYXRhIGFuZCBpdCBzaG93ZWQgZXhhY3RseSB3aGF0IHRoZSBTaWduYWwgR2VuZXJh
dG9yDQp3YXMgb3V0cHV0dGluZyBhbmQgb24gdGhlIHJpZ2h0IGNoYW5uZWwsIHNvIG5vIGluZGV4
IHdhcyBvZmYsIGlmIHRoYXQncyB3aGF0DQp5b3UgbWVhbnQuDQoNCkJlc3QgUmVnYXJkcywNClJh
ZHUNCg0K
