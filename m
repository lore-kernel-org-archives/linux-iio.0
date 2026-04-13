Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE951514F8;
	Mon, 13 Apr 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776064586; cv=fail; b=DeHzugLlYKPcfDxNZN4DRhZZiXvXWiZkZS2a9ivSbHC4meZtLiG6wrTubPxS9CTGLkHrt6YVS5YlRaozbUQ1rrOmDCgvmfpS6Eol35uRT3S0oOqizUtXD8seJRvPzjwJ1AMJBylhDLEdkFh4Efto/xbeh+GzwfoY0Gi46H7ELGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776064586; c=relaxed/simple;
	bh=9IrWtLJ3Jk7QLd/tN8i1gYtI8sn3o9G8O4n2pv+1Wx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UH+IB1xsEWBtiygjfrfDhhTuMPp4yQEAP9T4D9j9EHgSFgjFJTWTWHN4f/DC33+FsjGXiM45PsFXZl4fs/evhTAeDjpVxmhPpEN2ASyT07EzXn4spjLOiJQ2NJhHNCgx9BaD31NJEpHMjP+VEc9wdJ+IeInPwoHoE2Rmp4izfrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OH531MzE; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OH531MzE"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D0mjEr3639441;
	Mon, 13 Apr 2026 03:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=N6nov
	0Zofukpbxg0MqhUYA/AFJtfqjs3o5YhRK0w5bw=; b=OH531MzEdwCFqwuLDTuR0
	74d6/Wx9PCQDwp4ZCh+622T0BQNftNuLA9mQ7Z77AXQUGby1i++pSmhcePtpoCLE
	nJtwQjjZMWxQnBRxKuBkVygyh+LAPIHtbGa+gFftc5hmBhqzuOAw/NK5cO/KCuUZ
	CAaX8ljrhCw/g6BO0gghWHJ/bSV2zCfqyBDi9gv9nbKY5hpM6mLlsU8ALxVi4xpV
	39IF3nxWjEjw6EUzrW1PpbAfUBWfZLQ0USCqP597sD4u+BhBxKQcUQSXxyh32V0G
	FgDRWyCN8RBJkntZYB2AYn3yqSJ+YZ/DuG/KEjUQ6PUIlcNBEpk3rjFB3cDTBkdM
	w==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dgp8srxfg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 03:15:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdct6IegW9mZkMvdXd1X9fawX2xI90WLqmAT2Fe6jVH199eVLk+DFOPBYZCjwHAZjDpv5GP+LyuKC9P5Z87iyeUPonsW7saRd7P45hDT1w5j/gqgVLassPkJYIXPyBauDSBbIeWTDJ0DCEBYwtoeowif8gdt5VUdT3r14S47sZyZ5vXNrW7JWTz7iz6IZ9toS5Avo5NU0lBOSAHqgt1Wn49euyQLYC5/K186uXmvI6TTSCjJpTJG9Di/ZhIkVbVr9t2vs1By4g5yAPH3JdLqh/LOU3nhcFUyKA8d5gRkjBCjiR2e+bE1js0g4wxUe0bHarR40ivemp7jK/1ikx4ycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6nov0Zofukpbxg0MqhUYA/AFJtfqjs3o5YhRK0w5bw=;
 b=vjWAZy2rWMEoW2uH0GHggcD7K0tspxWZ1Orv1eR0DIK8vk63rT2wYbeKEiTkpjccxQ+YE98m4DLCQ4kudRZzYMJnlnEh5EA0wXI0gHMa0l9fKcOv8JviwKC9Gg/nZ5PDPLs7oPytut0PsdMkzlw8YpGNgTJExTkg1CNxcJSmJ1cJgAlqD9dmORbaxkCAr3Lj257SVWkz2hzFh5vrtog0YigxUrNosdiB0ip9XH9Rs1Ff3mIJlzy5sS9NznGRkzqIh5ePExGrE7rqPT/G1BLwE4SHgWpcNt8HQfL0pFXYlDbJYHMk+nUEaS1/6juqBjcRgXq3r4Gs1T2n+DVkbRLZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by PH8PR03MB989118.namprd03.prod.outlook.com (2603:10b6:510:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Mon, 13 Apr
 2026 07:15:54 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 07:15:54 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: RE: [PATCH v7 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Topic: [PATCH v7 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Index: AQHcyLYbntrYV2qu+ES6PcRhOUDLm7XYv+OAgAPQRcA=
Date: Mon, 13 Apr 2026 07:15:54 +0000
Message-ID:
 <PH0PR03MB63515AAF92A4F2B6F7C26E70F1242@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260410-dev_ad5706r-v7-0-af93a4caa186@analog.com>
 <20260410-dev_ad5706r-v7-2-af93a4caa186@analog.com>
 <cdfb9deb-2439-413b-8c20-3c6ad6a81ce3@baylibre.com>
In-Reply-To: <cdfb9deb-2439-413b-8c20-3c6ad6a81ce3@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|PH8PR03MB989118:EE_
x-ms-office365-filtering-correlation-id: c2095af1-89bd-4984-69f0-08de992c8078
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info:
 GK/IUSzMGifVe5SMVtlUwIf101/OnNT3+T0H66lM64EvBaWf5KGuLZQEj9fOa1stbAlx76N1gF/6Ct7DsZcdQgPAAJNp7/5uvku2QzpSPo5yIB54hC7lyYPZ4P77BNSbNiaXk050CgLhQNSEh6zW3wygiG5I8Nkgs+a0+PbHZS134g7luGx+TubOvhBn6j4daA31HinI8+f5zjZB+U9IN+rjD5Cv3mo1Gd3O1+pds7YR1EaVxnj3OwmUzeLSAe64moTDFX6eRD9FNfuyMpVMQmc1w0gdyw8DMuLJeE7tKfLBob9Yi2MMtgkkBRyTsvRBoUY6Mowtv61HHNJHO94hKWcibC5npfeZ06uVTr7xSTSRrgjLJeKMZJrmHoXxGPu5AulKzyx1J7+oMOlxWnOnb1tNp4C8eORVm4S55WFn+ot5YjdPAZM3xQXQLX325nT7BOgRprpTELxWbfX3YeLgm6WpwBLqVFiEn+z87DT3VNmnj15IlL1r2WrdQM+TMow7MsW42YKB9HBJh0xnWEwQG8q82l44yeekjMG9RqkjzEis7JcCn9PHSxVn/HHMmErPbxrSdcuvilO0cmfQCW53QO7JCPlZbiOH3ve/H0f/6t26Kvswx5GjXcSaJj/y1E3ckiLv71frzNY9GXGmu716FD3YOtgArvVOp7e/o3y5SzMxFpmM/F6+iEeJBT4R/6eOlRKZ4oNJjFUdkvN/aMJmXpkt/oSF6UUoWE99YnYHpQfZD3PLCPnmwLu7aPE3CFU6T8k7xa8pIDTY6xlW2irmCsCnupS4XUcwx/m2cvPfD/6SzV+0MuJy1v4lyIsPPIE4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+d8QB0K5N4rsEyiMUthTZktnABZMSei7FUWoU14yloIWxPRqzase3UdN3ms4?=
 =?us-ascii?Q?teTfhxo11sAPIU+uoUDeubQ0gwAxuk5tdPUjbyH1Z0UlhGLNVeO2KTwZ6WYz?=
 =?us-ascii?Q?sobjferCGtVljh2P0PXbBVMBgOEVyAjxtY2QIErrnPirHya9ZjA+MpuRt+xO?=
 =?us-ascii?Q?dpc9G3jO34G2ZxBQbXu6h9qL4A1/0IgsaVzt5x/ekKapfi1wTt9SU8aBXbdT?=
 =?us-ascii?Q?PaAcC7bFehreqb14jrCY1Y5G7AXDUiGAERXnHqEO6X9pcPr7sqnYban93is5?=
 =?us-ascii?Q?h2BIPNymV38nFcvPLPnxQzzbTMfFZh4D5PxSUt22oo4aPWoN1aStNdxmd7+W?=
 =?us-ascii?Q?y15AB9E5hqI53cCG7SlmyNHX25qNZqJQC33uDY8PvZKGemFoPlI/vWXRGDPw?=
 =?us-ascii?Q?azAkBAfZsss8NJGR/Auyvj79ajgTIo71nOLQx5S1LqVIzCaH7i5Cp5pDvO6v?=
 =?us-ascii?Q?poatZrGFBH7nvhbR0MhjPGYODfxdYm5xEHMSxBCB/TNXKTSJX+5DwWMkqx3r?=
 =?us-ascii?Q?rIantjJ83/WTrxAgTk2P2UaD7NRUXYKv8c+EO72nqT8RAiAslJdKA9uKMdGb?=
 =?us-ascii?Q?YNviBQH7GG/LDrmaPwlqUitam5OUSj91tZ/lYQQABaF40RIrVuB1wHkuoBt3?=
 =?us-ascii?Q?FQSm5hOvKe5sgbWVhkOeYZzx6A3dD252vFWF62/617rITMDYVwztpBGoYyIm?=
 =?us-ascii?Q?B7ZPSX27F4NAjaistrZ91PxeK98eCxnzYF4ZxkENDgWjIXtvS7EIP1SFtOK8?=
 =?us-ascii?Q?ls1EtvYnmMHWrgw6U5QIb126N/GXDe3+Ao1K5mJgBayLcGd+JQ+gPudN4dRe?=
 =?us-ascii?Q?aKUwi0ATWDj0gX26rtUw5YbvfoXaSvVJehS6nTYE+Oi2DDrIQXYrFUb23i1g?=
 =?us-ascii?Q?CPg3MPfRkHhhjSIJcsnFBMahR64B207vk+T/+futP9QbsSJgPTorCII5ZU1c?=
 =?us-ascii?Q?cLBIrX5Jw9dorvCiOcngOCwg6ddpOhSg9RaA63smF0RFVef845D5nzfO1LZC?=
 =?us-ascii?Q?5Jrgc7ZuuPGrKlrpFdEHABTqAmHZ76MsISCelrI3exT2129MUWr61Hra3jcs?=
 =?us-ascii?Q?+wtTKnZZ4BJN0BmeEpUD0WDdOBfKT+0Zh2MirvfbPfgPl+wMpWe2feAMawut?=
 =?us-ascii?Q?MsEaMfY1kH+WxgUyKJXOqI1PnIVb/WA+qzksuB9O98OEnCDEiBab1UA3yZtp?=
 =?us-ascii?Q?HqPruh+j7f+s15AIcZVrYXKGiuQzxnCkYd8P+NoMsiie457nzTXlzDfRvwTJ?=
 =?us-ascii?Q?JZFpVatwc7q1jL8h7teOUTDCt2XPk2Xb9YSWm1hy6LZRjOEkpdp8gC0naKw2?=
 =?us-ascii?Q?Xa0jvMyBWFpEvDNr//R5IewqkKXaTqgvqhVwlK81r7d8B3Jp8tGbn8EWJgBS?=
 =?us-ascii?Q?Gkdm1KUqEJjdqYoSAX1n1rsdGQVcAWwQTaxyl1zjCaOVeJwvPPm7i5Ov8C/q?=
 =?us-ascii?Q?8fbCJzq03pjuoWiUcb7ZV1EyM51IRRGY8Zbqh2QCK0kRxRvFJuddv5lEHC3X?=
 =?us-ascii?Q?l5vDuLoyyV/u5L94k5CaUA3FEK1Uvbdaak7KsKw9UFnYhjDnbM8opPd6C1LY?=
 =?us-ascii?Q?UWqP/Ku7I261I5Aj6jHuesawsUkk5ZqfA5iS4sAsVtSU7ke4RA6BKiLa3loO?=
 =?us-ascii?Q?uKxWBo+V7xy+9gIVrGVGD9owQBdqNqlTIdl7E0gUAdl/DM1XVF25w/v9rRcq?=
 =?us-ascii?Q?kkNOe6pI3bhMD9if1QlefOSW20I/sn7DO9nvlvoWGXiWOEBPCCuPuvmDDhKh?=
 =?us-ascii?Q?d7RTP7DSAp4az+o2ecGORtOr1ccLVJs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	EtLEDlAODyvbWo9639EjtHZrMW98qJNHFybI9zxiB/FQP8vG2eeyfDSAAKEPPxi3FAanfUXfF8vWoE6yB+fBikXhl1wf+vqFp8pyK+oy47SrnEhU7+Onww/vbh0vLsSfMgfbpDyyTpl3KOATpiIkPEjFq43OyFhbDSBrOgjpBSp/21V8hdcAai2c+SlxlbbfDRArFl8nPu1HMRhMDjR+ENvsrGfawsdPPruKO/U9qhiRx7Gl2yzc/g81/qI5Scd+r/Ob66QeN4rMm2WXwNLw+2QqV72ziCPZak7HysqUzAK15AhYRS7vwrnx+PVM7SKfazGy7sHza6uZZIH6UC7iuw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2095af1-89bd-4984-69f0-08de992c8078
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 07:15:54.5628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZptH+uVn4h4M7nqM+0TUy0Ohy9v9GXHV9eXX3GcjbGe9rK/RNNIUg9LIwvq9zM/dezSR9nQJVZngMb67x7TJuZuB/nPALIdLQvbq4WIQbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB989118
X-Proofpoint-GUID: QmkFxFxoiKKyEeG7wTRAA1bsF9Ou6I61
X-Authority-Analysis: v=2.4 cv=XaO5Co55 c=1 sm=1 tr=0 ts=69dc982c cx=c_pps
 a=N2Bp1sGBA0q5hqNMPvyVyQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=oejIdDpOkFeeCy9f-CUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QmkFxFxoiKKyEeG7wTRAA1bsF9Ou6I61
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA2OCBTYWx0ZWRfXzz/eYGAJ8C1+
 YjbwpI5psuKIRDflvuS+AETOIlObtbB4+m2tBqZDJQUVvgHTj9G9//wkhFfz/3DgsQbZNmt+KC1
 NVnhgkuLe78IfHjErnADXYyqbGCh+eN8HNCfTOuyZfxgotVaZr3k39Cc9lBInbdtzeFy1jjxbyq
 gcqQEDK4/kayv77HtgBIHYwxnedBrSBCv/VegfXm9zsRmRIkXPQr7RuQSYGxL0OoSAH+ucsiCFc
 fGgvDR7QPwiETu77U2e42NLS6L/DaBfe6cYClL4MvAp68LDzaWBVFMTdCeEQ8FlZH34L9s+UTkh
 0JMKaP7wwTfUsTRJQ3JsDIjx40oos9FG9UxS8jxchmj1jfiAWD8Ku7kNo9Q3EZdQ/2GC90QxMnL
 qMcACivJHfql81fdWdakPiZQF3nshVg8U7OGOk8nJAOfH3q7WIPYJVDuh4sNIXkoKopqWwEfvf7
 Dtc42SKHOuAetbalEug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130068

> > +static int ad5706r_regmap_write(void *context, const void *data,
> > +size_t count) {
> > +	struct ad5706r_state *st =3D context;
> > +	unsigned int num_bytes, val;
> > +	u16 reg;
> > +
> > +	if (count !=3D 4)
> > +		return -EINVAL;
> > +
> > +	reg =3D get_unaligned_be16(data);
> > +	num_bytes =3D ad5706r_reg_len(reg);
> > +
> > +	struct spi_transfer xfer =3D {
> > +		.tx_buf =3D st->tx_buf,
> > +		.len =3D num_bytes + 2,
> > +	};
> > +
> > +	val =3D get_unaligned_be32(data);
> > +	put_unaligned_be32(val, &st->tx_buf[0]);
>=20
> Can't we just do memcpy() instead of swapping the byte order twice?

This was memcpy before, was changed to this for consistency as per Andy's
suggestion. It was during v5.

Removal of this plus the other mem* commands allowed removal of string.h
in the headers.

>=20
> > +
> > +	/* For single byte, copy the data to the correct position */
> > +	if (num_bytes =3D=3D AD5706R_SINGLE_BYTE_LEN)
> > +		st->tx_buf[2] =3D st->tx_buf[3];
> > +
> > +	return spi_sync_transfer(st->spi, &xfer, 1);
>=20
> There isn't any special paramters in the xfer struct, so spi_write() shou=
ld work
> here and save a bit of code.
>=20
> 	return spi_write(st->spi, data, num_bytes);

Back in v3-v4, Joathan suggested this to be spi_write_then_read() as it was=
 much safer,
but I requested to keep it this way since I would be adding more features t=
o this driver
like changing spi_speeds, which cannot be done if using spi_write_then_read
=20
>=20
> > +}
> > +
> > +static int ad5706r_regmap_read(void *context, const void *reg_buf,
> > +			       size_t reg_size, void *val_buf, size_t val_size) {
> > +	struct ad5706r_state *st =3D context;
> > +	unsigned int num_bytes;
> > +	u16 reg, cmd, val;
> > +	int ret;
> > +
> > +	if (reg_size !=3D 2 || val_size !=3D 2)
> > +		return -EINVAL;
> > +
> > +	reg =3D get_unaligned_be16(reg_buf);
> > +	num_bytes =3D ad5706r_reg_len(reg);
> > +
> > +	/* Full duplex, device responds immediately after command */
> > +	struct spi_transfer xfer =3D {
> > +		.tx_buf =3D st->tx_buf,
> > +		.rx_buf =3D st->rx_buf,
> > +		.len =3D 2 + num_bytes,
> > +	};
> > +
> > +	cmd =3D AD5706R_RD_MASK | (reg & AD5706R_ADDR_MASK);
> > +	put_unaligned_be16(cmd, &st->tx_buf[0]);
> > +	put_unaligned_be16(0, &st->tx_buf[2]);
>=20
> Do we actually need to write 0s while reading?
>=20
> Usually, we would just do a spi_write_then_read for something like this.

Technically it's a don't care data, zero just makes it cleaner signals duri=
ng debug

Discussed spi_write_then_read in a comment above

>=20
> > +
> > +	ret =3D spi_sync_transfer(st->spi, &xfer, 1);
> > +	if (ret)
> > +		return ret;
> > +
>=20
>=20
> > +	/* Extract value from response (skip 2-byte command echo) */
> > +	if (num_bytes =3D=3D AD5706R_SINGLE_BYTE_LEN)
> > +		val =3D st->rx_buf[2];
> > +	else if (num_bytes =3D=3D AD5706R_DOUBLE_BYTE_LEN)
> > +		val =3D get_unaligned_be16(&st->rx_buf[2]);
> > +	else
> > +		return -EINVAL;
> > +
> > +	put_unaligned_be16(val, val_buf);
>=20
> Can't this all be simplified to memcpy(val_buf, &st->rx_buf[2], num_bytes=
); ?
>=20
> Or the whole thing simplified to:
>=20
> 	return spi_write_then_read(st->spi, reg_buf, 2, val_buf, num_bytes);
>=20

as discussed above about mem* and spi_write_then_read
