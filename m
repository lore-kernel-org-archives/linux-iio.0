Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A323A6402;
	Tue, 31 Mar 2026 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954421; cv=fail; b=CKPlqSCjm335TbmHco+k/U1YN/abZBMyp08z1FKO7EzTSXkIQSpChCj+9/cs15aBUpYq3NpRTYEnYXax+9rPfrK2j5BDWwS/y5S6LzG1Lgv0AHBjzOKSFeRqnTy0lUqmpba2q/vdv+hbtFYBU31ZdfIRNrRG0eU+Myzov4nhrqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954421; c=relaxed/simple;
	bh=g4KK8P64g7QjAAweDjZFf3CsK4fuOhs9l4trtaySCSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XX5PdGggpz2w6cN4gbBAI5wKeJFn3egXDE1t7x+PsUqv1jQ13CkOFsH3eVp2n8UsbhN2UiVsE5j64TUb4pblW7UPbvpLvDD18zVhBrjENkTWBEabU11HtuoJRjz7pV8VSVg5mlrYumJ9PbTYodMwpKm/7MIDNJ3ZT2BWZKXrkKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g+HwuJw2; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g+HwuJw2"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V7VBfb1955015;
	Tue, 31 Mar 2026 06:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=g4KK8
	P64g7QjAAweDjZFf3CsK4fuOhs9l4trtaySCSo=; b=g+HwuJw2/2Q1SyUnJ6x6n
	hLlQDDS3W1KdINW3t3zTDYBbYnQS47GBUjblRUd50Oj5egXqSuUTFluqyhmIX6V4
	EY38WXxRsHyCwzJ3no6Esg9YNt3yW6nfx35FyJ2qBzZc4s3XK0WgNIYm1fWZECXX
	nSLBgqktRixSmfsDK0KTlV6c46hxNKOXPwIsOBzJs5gKUuMld0KazkqR6SPQbj8V
	BxVT5X7TBUVy7kmm0p5Y0qB+7Ueh3no51scP2iJ+CT3x3/NTwn0syBROVon7f/GO
	9822GShwERSuQWTv7gz7y34+pZuCUSmDl3xE8pMneSsqCikCci/MH2zVHiWu4D/w
	Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d740yh6dh-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 06:53:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9Ix5YfOo09oNjgNd8HQaf/pYQQIk37Jg8+NhnZsf2sDayBnn//xQuD3SEadsICbCl0ln6VFhSwI59oU/NvbypMjgFMq3TKukA36pBXxdNN4zvpPqJyqwLR5HsGd01C/RMELz9euYbv/qecULoH80l+70mC7s/wo9UgDGY6FLzbSp/Ulm9/qp3IFdcYB4M+LzDycxm5tmHbP/Rg3FF9wdbIeTIYYBczo4GeL77D3+v6cwJ6fVinVC+ULoeYnvhdiz/B+o5iL1mbd1ikzlYyrT0yOg6W9/VRN2x+heEQXcZ8N/SbyyHUqIm/CaYSmcvHY6MCTs452Qzu0plJxnufZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4KK8P64g7QjAAweDjZFf3CsK4fuOhs9l4trtaySCSo=;
 b=D8ENNq0QaY2hc3X6UvH6eCb14c34acTHf/a68oPHoBmd1xJWaXtzcP8XRe+JaHAe0ShXYvD/xBeFmFrKzTGO82CPXetTXlgbEg+f8clLb/2DwYMxyERfAW/YNaPLCOQG9wudcBt/EfBoQTJ6dZMKWH8QfcKNkus7JNA4hCYEP+Valwdq+bvxfVp/JiHzPk2BSl6sI7EsCpvc3PjEkjEV2HzZJ+Zm7shyCV7b/Mt5dpGaNuLHA9xoVFD2kkKTmEI+x7Zj5VX9GqffCnAmR8rZYM3VDG4L19XXlTChX7to+k73IC0e/aKfIzzgIjNVHQu7C2uA41sS8cIZgEzfvDLBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 10:53:23 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 10:53:23 +0000
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
Thread-Index: AQHcwEn8Qxc6HLDZw0mwofc8cAcz8rXHHZmAgAAEOWCAACbtgIABL4Ew
Date: Tue, 31 Mar 2026 10:53:23 +0000
Message-ID:
 <LV9PR03MB841477AC17E269713AC58356F753A@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260330-ad4696-fix-v1-1-e841e96451b2@analog.com>
 <cfe07818-e040-4ce8-9407-d951df637af1@baylibre.com>
 <LV9PR03MB84144580E5523DC01542E56FF752A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <ede20708-2575-4761-9876-80df5574cb2f@baylibre.com>
In-Reply-To: <ede20708-2575-4761-9876-80df5574cb2f@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CH2PR03MB8027:EE_
x-ms-office365-filtering-correlation-id: ac62e2ac-38fa-46fc-37e1-08de8f13baa4
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 j82W3Gz4nawmYADT8alJ8pos9IvFcpZvME1EciVLvgkszzYUnbA8/lJ3qBhINnaAwqTz2aQEsJgGYSUK+CW5eMJ+DZOZxNxiJhlynWVXuSxYVZZVkVeee8yDdcuWjBnzBAuUVK04/pPAjD5MLGxLNDSWRJAvoBzLtWKQ8m516pRY3qS6NDqCKGYCSk8+GqHSn37+4txMPYLs/RUToZOAV3PpWulr+xM/fGmLAQ00SX3fhA9GCGRmQdegef8W2asUfs3jcKtI0bUwgVfBKE2xjL8PYP8KoofjcFc5UburOnKxvtfPtrm+2nScWKt72MoNBf+KllgBRsI1aL02q07Ea3szPLEJ0bpAcBC7lRoJAnw3nzNfEU3vUDAgZFctQJhgGLW9s7IpgowanmqcJoUHTCEIGINsih4464ME3xnmQrzv1mD8Av7MpEYS05JW3iMPSsoiAhEhe8GZ3V8Pfb6L2HfoEL4fgfV53i860fcoGMIMV5LWqGb/rNYYOOCPhDdvvLaxVfZsD5pyG2QXA8X0TBXbvo0bKLDELTTpox2IdzPE7+Zg/gzDmYL6vR8TtTMEL7pSJYbBm/XHNtC/IqfY1SkKNGB+E3IV074I4QKQjxnV/MdbCi+eF4o35Q1GdITG0KnECiYWfNxlEcTKf8sxmMRt9hx9Ty+f+8FlbCy7cuLON8X7vsrSRlj48/uWU4K1EcIMLFph5Dzj8wuPOP0CMrzbwJLLp4JCUQ2le1fbHbSja+qPdg/cVxW7N60fPFIMvjKSJjG3IuSEQI+LkMyduHyIBc4p+xP2UGg8GXuPhZk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2pXOThReWxMaVBNVWxGam01Y0k4b1RxTGk2Uk95cW5HWjNObDRNcGJySlZH?=
 =?utf-8?B?S3pYUlhWbWhVMEpscmtqcVFldkg2dlN0S2dKekVDTTBMNGZRQzdDMjdmVGJ3?=
 =?utf-8?B?VWJtL2tlRVBJUHZpYStuNHFVTzN0SVA1RFQreTAwSDIzMzJUQTY1VDhsMnAv?=
 =?utf-8?B?SXJEb3pPTDJpY2lwSHdsVGNGdVFxMzBrWGNuNHpEbXhkS0JlS09pT0RJWVdX?=
 =?utf-8?B?UjU2SUxKOUVQVHZzVnBpekJzRjF0SzM3VjdBWncrT2czc3hVUUdZM1Bsazc4?=
 =?utf-8?B?U3F3ay81aUZPTXZGeFBkRFdvcWRSYS9rSElqRzVUMFIzSUN3MXJYMlg2N0x6?=
 =?utf-8?B?RnpWYXRSMUhhUHJNekxxazI5K3dOQzNJcTZsSjlLQkhVcUhHRWxwQit0K2Vq?=
 =?utf-8?B?UTlCVnRHTXJ5TlNJVmFoMDBsMEEvanc1alYrdmdLZU5UQkd5UjgxbkJ3dWE2?=
 =?utf-8?B?NVlOSS9IbllTbmlVd1pvaytOelBrc3prcFk4TkR1aHR3WmdKVytXdklUc0FQ?=
 =?utf-8?B?Qy9Md2QvMkRTSmt4dDlodzVVaGlkeGpTSnk4REliMEc4N1g2eGNHTUZIbjlV?=
 =?utf-8?B?cXhpODZoenV0TlVNejJ6eW05QVlEUTR1a1Q1OHo4SVVXbU1YelliUDBYK2FP?=
 =?utf-8?B?MGFtcGk1Z2cvdm1CN1pWeCtwSTdvY1lMdURpSEhBNG9xaUsyd2RMaUpKaHJY?=
 =?utf-8?B?a01WNVVhc25ua0lnZjdtV1VZb2kwK3RZS1hydTI2R2RqU3g5aUFGMER4UFNZ?=
 =?utf-8?B?TEFYbEN2VVptYTBXQ0FRL0IxazVhYUNVMm9vTEVNOWt2QXJ0S3dMUE54cGVR?=
 =?utf-8?B?dzNUSHpnRVUwSTI4K093YlNsYnRMZUtkN2tIVENpcVJ4ekJqNmtmZjRnZ2tW?=
 =?utf-8?B?b004Mks5ZDAybFlidFE0WUZISmlQYnZBdnU2L0E2U0JDL2JCNjRZblltbm1v?=
 =?utf-8?B?aHN3ZlNqdURQalcxeUg3alVGaVJwK0VYMW1LcWtvODR4OVJtZlRoKy9QVG0r?=
 =?utf-8?B?ajUzOFRWNDhVOUVQMmRQeE1kZ2lFT0dSa0NYY0JHWm1uaUE4eXFNdXNkVyt0?=
 =?utf-8?B?NExUUnNrRmpKT05UZVhYeEVCcTk5YVp6OUxGM1lSYUQrTXJjV3BSVG9ENGdx?=
 =?utf-8?B?Wi9tWWVFc0tSSmVzb3VrOHlsUjJXNkh6RnhSYTNVRUM0bjY5VFVQanV0TmMw?=
 =?utf-8?B?L0k1QmtSb0RsSzRyZkNuWnpHQStPUFVSeC95ektTaEF0NWd4R3AzZkJTUkox?=
 =?utf-8?B?TGd2Uk1xMDhQMEdOUjU1M0JVR041VXhIaGFaeUlhV3R2T3VJZVcyalkwQkYx?=
 =?utf-8?B?clV2Um1MTjZRZ2ZnYXg0MVkvS2l3SkJIc1NPYmVsWXY2TG1NdHFtZFNnaHB2?=
 =?utf-8?B?WUZlVk5XWWZ1TXViN0dXelBsVy91OGlpNkhGV0E5djNCVnhhdmlpbHpmSHhZ?=
 =?utf-8?B?MFpWdmRvZll5VURLYWxiRTloTytKV2NNYXRSaVZmRXVPQWN4YlcwNHpUamFj?=
 =?utf-8?B?NWdCUnNxNWJGTDFEaDhoUUJ6WFZUZVVZb1hIM3Q3K1ZXZldMZUV1QloxaElm?=
 =?utf-8?B?Mm5jUEdFTW9oNzRqa09Zdnp3dnA0REc1a2FPemxOWkVSdzFuZEYyZGNsNldu?=
 =?utf-8?B?RERLTFNRSDVsZVdneVhZQ0V1eWFlZWlKVnpoUVNHeC9KU0FMa0V4K0t6VUZD?=
 =?utf-8?B?d0FnUW92eGNwWUl6WUp0ekNLckw2dVRhVnB5U3d4TmlNUHE0ZUs5VW9pL1pY?=
 =?utf-8?B?RDAxWkUzRXMvRHhQVUVIblZFdkVuMzB1QnhWdExUblJJNlV3NUJxTU5KUDll?=
 =?utf-8?B?NWg1U2xSNWNyY2krTnRzU0N0bkhmbW0zUVFLbkVTUnNsc1dtZmVZd215cXdB?=
 =?utf-8?B?bGJRV0lBT3REbnVKaXlSdXZjcDlnVWJGOFRRaWFlWXQ3UHdUQWdPNG5oVExZ?=
 =?utf-8?B?ak5yaU5BRlVWN0N1cEtpSEppNUQ5eUluOWhqYUxRa3JQQzlvVFpVQkIwYmNT?=
 =?utf-8?B?WDUwaDRFT0I1WmxhL0VhRGdTcUM1cFVxWE5JSThGRU9Sa0R6NG1DaXlSS2pO?=
 =?utf-8?B?T1B1L0NMbnJpY3N5eDhONTJLS3RUZzNXVi9FU0VXSm1MZUE1U2N4VG1kVXdF?=
 =?utf-8?B?Zlc2Sk1rRDFHUE5pQTdlQzJIdW5rUG1NRCtlZ3RxMFFlMHRSdUNDTng3T3g4?=
 =?utf-8?B?WngwWXA1SkdmdlMvQUZ0TjdLenZ3TXlOSVg2Njk4bzNtWG9WR1NGSUltYitn?=
 =?utf-8?B?WW9GUWIvS0JpVWx3MHNDblhxNnl4M25yak8zM3kvOC93MVBQWkF3NFl4R00z?=
 =?utf-8?B?L2x5ek5hYUtxdnFNcXYrWjVEM3lOeEFIbnp6YUhndFVDbjB3SXVBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qqvqatJPWqYrQWDIbKD5dyY8enWYD9WBi59+AEiXYG86WWrMripJtiS5SrSEYQp30rEuedV1+1ChlA4l3o2XFz6es2RKn4usYNTdg8u8T/YLcU+xaEKwt/7YlaqgsZGRlIcaKBvQKd5XgFUf3/eEnE+cLYi7hA04EqP6UYQZEmAWE7WXEQpzpMcFfySACoB7F5OEDsMFQlAt8Gg7nuSzU0iNcxzUovQ5cxNHyMp8AZzwADYBxBvNmAdd1fxMn/xGX2iM1u3OqEWmGYH8gEuu1o2EOFYNhVEwKoVv18lvOjOC8rsiGqXx570dfUDJu3EioG8y6noGs7Pa+Odd9e9/GQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac62e2ac-38fa-46fc-37e1-08de8f13baa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 10:53:23.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFM0E66ydUZCJjmNSHahReiH+qcntIexI/+6CVcaPbzzTpmdiuChN8S2G/VZ9pXtnqh+S5+9yyZHB5u0VMW+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027
X-Authority-Analysis: v=2.4 cv=ANnNY0ku c=1 sm=1 tr=0 ts=69cba7a6 cx=c_pps
 a=c79N1uTKLHxLQxOLln6vMg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=bZ4ukaxUoOnr1ZwBx_QA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEwNSBTYWx0ZWRfXwaemJnGdRafx
 eHtxXu1ASrRn0qykuAdCPgIgpcJsIvEAd9KHRvmFWU7efhIiKl21df90XG61pxzEZbowPxAOzmL
 dIu7pPyefnQO6N3dcMCZZ4wEZgQINmryM+MdTXy0UkGRa+nZZ5F/pRN9ZalOFOviuM2YBb/UBbe
 vYPKukXiPpnofbXQisylld+QG0E6mxNUwyUcd9C03IfO62fqwdIf5aLT4WPF6AVn5A79JQI1ebR
 Az09+Cm6qmtSlyEFfcYAhsuTyCnNf30u0bU8FHqRxCP6aLOC+Cv9UWwkdjvZUZRBfBA2YR/7NgV
 N/ZxwEKVwPyNpA9rwGNITa9j9SFbds+mIAUMeQVAAX887K7xD3MQFXERncEl9nTZqXKmOlufi6O
 AO0+OsHDjB+ykOqXyfRT50FxEiJwEyU3IRAUQ6j5GqvA2UOy9oATO5mPgcdN6lsu6mJBc6oTzrM
 ND1gqTUqIgLRzC3Mo1A==
X-Proofpoint-ORIG-GUID: jI7621FPIM1r9lwEuLESfN-DxihLOQsG
X-Proofpoint-GUID: jI7621FPIM1r9lwEuLESfN-DxihLOQsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310105

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDMwLCAyMDI2IDc6
NDYgUE0NCj4gVG86IFNhYmF1LCBSYWR1IGJvZ2RhbiA8UmFkdS5TYWJhdUBhbmFsb2cuY29tPjsg
TGFycy1QZXRlciBDbGF1c2VuDQoNCkhpIERhdmlkLCBBbmR5LA0KDQo+IA0KPiBXaGljaCBjb21t
aXQgaXMgdGhlIEhETCBiZWluZyBidWlsdCBmcm9tPyBJdCBjb3VsZCBiZSB0aGF0IHNvbWV0aGlu
Zw0KPiBjaGFuZ2VkIGluIHRoZSBGUEdBIGltcGxlbWVudGF0aW9uIHJhdGhlciB0aGFuIHRoZSBk
cml2ZXIuDQo+IA0KDQpHb29kIGNhbGwuIFRoZSBiaXRzdHJlYW0gd2FzIGJ1aWx0IGZyb20gY29t
bWl0IDc5NDQ2ZDhlZSBpbiB0aGUgQURJIEhETA0KdHJlZSDigJQgImxpYnJhcnkvc3BpX2VuZ2lu
ZTogZml4IHNwaSBlbmdpbmUgZm9yIFNESSBiYWNrcHJlc3N1cmUiLA0KYXV0aG9yZWQgYnkgQ2Fy
bG9zIFNvdXphLCBtZXJnZWQgRmVicnVhcnkgNCAyMDI2Lg0KDQpUaGF0IGNvbW1pdCBtYWRlIHR3
byByZWxldmFudCBjaGFuZ2VzIHRvIHNwaV9lbmdpbmVfb2ZmbG9hZC52Og0KDQoxLiBjbWRfdmFs
aWQgd2FzIGRlY291cGxlZCBmcm9tIHNwaV9hY3RpdmUuIFByZXZpb3VzbHk6DQoNCiAgICAgYXNz
aWduIGNtZF92YWxpZCA9IHNwaV9hY3RpdmU7DQoNCiAgIE5vdyBjbWRfdmFsaWQgaXMgZHJpdmVu
IGJ5IGEgc2VwYXJhdGUgb2ZmbG9hZF9jbWRfdmFsaWQgcmVnaXN0ZXIuDQogICBUaGUgcHJhY3Rp
Y2FsIGVmZmVjdCBpcyBjbWRfdmFsaWQgaXMgbm8gbG9uZ2VyIGFzc2VydGVkIHRoZSBpbnN0YW50
DQogICBzcGlfYWN0aXZlIGdvZXMgaGlnaC4NCg0KMi4gc3BpX2FjdGl2ZSBub3cgc3RheXMgYXNz
ZXJ0ZWQgdW50aWwgdGhlIERNQSBoYXMgY29uc3VtZWQgYWxsIHBlbmRpbmcNCiAgIFNESSBkYXRh
LCBub3QganVzdCB1bnRpbCB0aGUgbGFzdCBjb21tYW5kIGlzIGFjY2VwdGVkLiBUaGUgb2xkDQog
ICBkZWFzc2VydGlvbiBjb25kaXRpb24gd2FzOg0KDQogICAgIGNtZF9yZWFkeSAmJiAoc3BpX2Nt
ZF9yZF9hZGRyX25leHQgPT0gY3RybF9jbWRfd3JfYWRkcikNCg0KICAgVGhlIG5ldyBjb25kaXRp
b24gaG9sZHMgc3BpX2FjdGl2ZSBoaWdoIHdoaWxlDQogICBvZmZsb2FkX2Rpc2FibGVfcGVuZGlu
ZyAmJiBzZGlfZGF0YV92YWxpZC4gU2luY2UgaW50ZXJjb25uZWN0X2RpciA9DQogICBzcGlfZW5h
YmxlIHwgc3BpX2FjdGl2ZSwgdGhpcyBtZWFucyB0aGUgaW50ZXJjb25uZWN0IHN0YXlzIGluIG9m
ZmxvYWQNCiAgIGRpcmVjdGlvbiBmb3IgdGhlIGZ1bGwgZHVyYXRpb24gb2YgdGhlIFNESSBkcmFp
biBwaGFzZS4NCg0KVGhlIEZlYnJ1YXJ5IGNvbW1pdCBhbHNvIGNoYW5nZWQgdGhlIGV4ZWN1dGlv
biBtb2R1bGUncyBpb19yZWFkeTEgbG9naWMNCihub3cgZ2F0ZWQgb24gcGVuZGluZ19zZGlfZGF0
YV92YWxpZCBpbnN0ZWFkIG9mIHNkaV9kYXRhX3ZhbGlkIGRpcmVjdGx5KSwNCndoaWNoIHNoaWZ0
cyB3aGVuIHRoZSBleGVjdXRpb24gZW5naW5lIHNpZ25hbHMgY29tcGxldGlvbiB2aWEgU1lOQyBy
ZWxhdGl2ZQ0KdG8gdGhlIGxhc3QgYml0IGJlaW5nIGNsb2NrZWQuIFRvZ2V0aGVyIHRoZXNlIGNo
YW5nZXMgYWx0ZXIgdGhlIHRpbWluZyBvZg0KdGhlIG1vZGUgYm91bmRhcnkgYmV0d2VlbiByZWd1
bGFyIFNQSSBhbmQgb2ZmbG9hZC4gVGhlIHBhbmljIOKAlCBhcyBzaG93bg0KYmVsb3cg4oCUIGlz
IGNvbnNpc3RlbnQgd2l0aCBhIHJhY2Ugd2hlcmUgU1BJX0VOR0lORV9JTlRfQ01EX0FMTU9TVF9F
TVBUWQ0KaXMgbGVmdCBhcm1lZCBpbiBpbnRfZW5hYmxlIGFmdGVyIGhvc3QtPmN1cl9tc2cgaGFz
IGFscmVhZHkgYmVlbiBjbGVhcmVkLg0KVGhlIGV4YWN0IGNhdXNhbCBjaGFpbiBuZWVkcyBtb3Jl
IGluc3RydW1lbnRhdGlvbiB0byBjb25maXJtLCBidXQgdGhpcw0KY29tbWl0IGlzIHRoZSBtb3N0
IHNpZ25pZmljYW50IEhETCBkZWx0YSBiZXR3ZWVuIHlvdXIgdGVzdCBzZXR1cCBhbmQgbWluZS4N
Cg0KU28geW91ciBpbnN0aW5jdCB3YXMgcmlnaHQg4oCUIHNvbWV0aGluZyBjaGFuZ2VkIG9uIHRo
ZSBGUEdBIHNpZGUsDQpzcGVjaWZpY2FsbHkgdGhlIFNESSBiYWNrcHJlc3N1cmUgZml4LiBUaGUg
ZHJpdmVyIG9yZGVyaW5nIGZpeCBpcyBzdGlsbA0KY29ycmVjdCByZWdhcmRsZXNzIChhbmQgSSB3
b3VsZCBzYXkgaXMgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvKSwgYnV0DQpJIHdhbnRlZCB0byBjbG9z
ZSB0aGUgbG9vcCBvbiB0aGUgcm9vdCBjYXVzZS4NCg0KUmVnYXJkaW5nIHRoZSByYWNlIHlvdSBy
YWlzZWQgd2l0aCB0aGUgbmV3IG9yZGVyaW5nIOKAlCBJIHRlc3RlZCB3aXRoDQptc2xlZXAoMTAw
KSBpbnNlcnRlZCBiZXR3ZWVuIGFkNDY5NV9lbnRlcl9hZHZhbmNlZF9zZXF1ZW5jZXJfbW9kZSgp
IGFuZA0Kc3BpX29mZmxvYWRfdHJpZ2dlcl9lbmFibGUoKSB0byBzaW11bGF0ZSBhIHNsb3cgbWFj
aGluZS4gRGF0YSBjYW1lIGJhY2sNCmNvcnJlY3RseSB3aXRoIG5vIGluZGV4IHNoaWZ0LiBUaGlz
IGNvbmZpcm1zIHRoZSBleHBlY3RhdGlvbjogd2l0aCBQV00NCmFzIHRoZSBDTlYgc291cmNlIHRo
ZSBBREMgb25seSBjb252ZXJ0cyBvbiBhbiBleHRlcm5hbCBDTlYgcHVsc2UsIGFuZA0KdGhlIFBX
TSBpc24ndCBydW5uaW5nIHVudGlsIHNwaV9vZmZsb2FkX3RyaWdnZXJfZW5hYmxlKCkgZW5hYmxl
cyB0aGUNCnRyaWdnZXIsIHNvIHRoZXJlIGlzIG5vdGhpbmcgdG8gbWlzcyBkdXJpbmcgdGhhdCBn
YXAuDQoNCkFuZCBmb3IgdGhlIDUgbW9zdCByZWxldmFudCBwYW5pYyBsaW5lcywgaGVyZSB0aGV5
IGFyZToNCg0KICBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDJjIHdoZW4gcmVhZA0KICBQQyBpcyBhdCBzcGlf
ZW5naW5lX3dyaXRlX2NtZF9maWZvKzB4OC8weDc0DQogIExSIGlzIGF0IHNwaV9lbmdpbmVfaXJx
KzB4MTBjLzB4MjkwDQogIHIxIDogMDAwMDAwMDANCiAgIHNwaV9lbmdpbmVfd3JpdGVfY21kX2Zp
Zm8gZnJvbSBzcGlfZW5naW5lX2lycSsweDEwYy8weDI5MA0KDQpUaGUgc2VxdWVuY2UgdGhhdCBs
ZWFkcyB0aGVyZSB3aXRoIHRoZSBvbGQgY2FsbCBvcmRlcmluZzoNCg0KMS4gc3BpX29mZmxvYWRf
dHJpZ2dlcl9lbmFibGUoKSBjb21wbGV0ZXMg4oCUIG9mZmxvYWQgaXMgbm93IGFjdGl2ZSwNCiAg
IGludGVyY29ubmVjdF9kaXIgc3dpdGNoZXMgdG8gMSAob2ZmbG9hZCBkaXJlY3Rpb24pLg0KDQoy
LiBhZDQ2OTVfZW50ZXJfYWR2YW5jZWRfc2VxdWVuY2VyX21vZGUoKSBzdWJtaXRzIGEgcmVndWxh
ciBTUEkNCiAgIHRyYW5zZmVyLiBzcGlfZW5naW5lX3RyYW5zZmVyX29uZV9tZXNzYWdlKCkgc2V0
cyBob3N0LT5jdXJfbXNnLA0KICAgd3JpdGVzIGNvbW1hbmRzIHRvIHRoZSBDUFUgQ01EIEZJRk8s
IGFuZCBhcm1zDQogICBTUElfRU5HSU5FX0lOVF9DTURfQUxNT1NUX0VNUFRZIGluIGludF9lbmFi
bGUsIHRoZW4gd2FpdHMgZm9yDQogICBjb21wbGV0aW9uLg0KDQozLiBXaXRoIGludGVyY29ubmVj
dF9kaXI9MSwgczFfY21kX3JlYWR5PTAg4oCUIHRoZSBleGVjdXRpb24gZW5naW5lDQogICBjYW5u
b3QgY29uc3VtZSB0aGUgQ1BVIGNvbW1hbmRzLiBUaGUgcmVndWxhciB0cmFuc2ZlciBzdGFsbHMu
DQoNCjQuIFRoZSBQV00gZmlyZXMgYSBDTlYgcHVsc2UuIFRoZSBvZmZsb2FkIHN0YXJ0cyBleGVj
dXRpbmcgaXRzDQogICBwcmUtcHJvZ3JhbW1lZCBjb21tYW5kIHNlcXVlbmNlIGFuZCBzZW5kcyBp
dHMgU1lOQyB0aHJvdWdoIHRoZQ0KICAgczAgcGF0aCAobm90IHMxKSwgc28gdGhlIENQVSB0cmFu
c2ZlciBuZXZlciBnZXRzIGl0cyBjb21wbGV0aW9uDQogICBzaWduYWwuDQoNCjUuIFRoZSByZWd1
bGFyIFNQSSB0cmFuc2ZlciB0aW1lcyBvdXQgb3IgaXRzIGNvbXBsZXRpb24gcGF0aCBpcw0KICAg
ZGlzcnVwdGVkLiBob3N0LT5jdXJfbXNnIGdldHMgY2xlYXJlZCAoc2V0IHRvIE5VTEwpLCBidXQN
CiAgIFNQSV9FTkdJTkVfSU5UX0NNRF9BTE1PU1RfRU1QVFkgaXMgc3RpbGwgYXJtZWQgaW4gaW50
X2VuYWJsZS4NCg0KNi4gU1BJX0VOR0lORV9JTlRfQ01EX0FMTU9TVF9FTVBUWSBmaXJlcy4gVGhl
IElSUSBoYW5kbGVyIHJlYWRzDQogICBob3N0LT5jdXJfbXNnID0gTlVMTCBpbnRvIG1zZyAocjE9
MHgwMDAwMDAwMCksIHRoZW4gY2FsbHMNCiAgIHNwaV9lbmdpbmVfd3JpdGVfY21kX2ZpZm8oc3Bp
X2VuZ2luZSwgTlVMTCkuIFRoZSBmdW5jdGlvbg0KICAgaW1tZWRpYXRlbHkgZGVyZWZlcmVuY2Vz
IG1zZyBhdCBvZmZzZXQgMHgyYyDigJQgOCBieXRlcyBpbnRvDQogICB0aGUgZnVuY3Rpb24g4oCU
IGFuZCB0aGUga2VybmVsIHBhbmljcy4NCg0KQmVzdCByZWdhcmRzLA0KUmFkdQ0KDQo=
