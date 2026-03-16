Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57188395DB1;
	Mon, 16 Mar 2026 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673783; cv=fail; b=IMR0ZyP2MkG2hk7wunPhBq7G3ZSijFi+i4ih/Q3QpRFIkW+N/5wkb2EfZlxk3o5lovh76XpsAzWC01v9D34gKjDYRr2lWh//pOfa+6rMwdksrW6jAkxo4rdyLPEjbCnlejcqvn6Ebw6/NqIB8VnaxAJMtAIJKf5pf/laejHpQnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673783; c=relaxed/simple;
	bh=pd1XXsU/ybG/J+Ozi9HROWmN4Rqeb+8QZcvR/UXgHzY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jrmBz80eBh5yvzqsjBk6Rw6AZmcCiSXjmW+ljzEeznSwcnScOY5G3uSsjLbop5bAB7GaFQEUK8Pto3O5uSiNvS1Dk0lf+DoAJh+o42sfrhNCH95b0v8HE6sXKAu8iZGUzsBgkyQ4pbvFtS6R3lrwdixzWbppkV7WaG/Q6Qo5Y1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mm8wX/d+; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mm8wX/d+"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G9oxMh407856;
	Mon, 16 Mar 2026 11:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Bakuv
	YZNERuJ8NGqCSeq8X36wqede25ZKCR8Wy023OU=; b=mm8wX/d+sfy9JQyrUeb1F
	VqJL7M5dpphEFGsER8yV5DEWMshLsgTOgs2dK+RGxrkOAFNCa94WrceIzuVFX32c
	ohnKPWTrY3nMpYKLBi/mLIXqcz60/RXH0n67agIvwrpOOvQxTKPH/D17Xo2FgB8h
	ql40sx8HPYxeHVovxRjiBTog1yst6dbwv+OMzDIBAiMmzC6hFbcp+d3E/ppckcqr
	36QXqy20Yrx6QIbtCNYxXlfysywcXrjvmkIouRt/IcC3t7zXj8CbRUrmDa7ucJLl
	+9c1XEnsYn/Qfmo3TwqJEOoVmWeVfcufKqDXqYKYQahISvbELhuRgQv2rPKq5MUX
	Q==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cw1e5p635-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 11:09:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHhW9BP+6Ma3/DBcMA4ov8GP6Jx0g5Gx51B60+hsNZWownRqzmSTPqaPJOqfxkqH+rS4X3C7CnRIleH5Yv1OR+sTrXipu81llB1JKI99s2+ROR2h0oK5qLhc2tEFeOX2dlSYjlyvroMds57M1EGFevI3ZlWCc1B2E2LYqbYABzJBywCOJzL4iROffgs0ZwbXP5ulrV4LiEV2oELOzDnS22wEdUQ3l4saXUV8v+bVmB2cGoTm2VZXz9WChn30tgFA4xQNHTk5nqC3uy6jYa9SjUJajNonZIxAaLHdI/FZjVSU5TiSrfkmRDpaJkBXSJzQftmM6mYKd6b3e/4mffb7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BakuvYZNERuJ8NGqCSeq8X36wqede25ZKCR8Wy023OU=;
 b=kLlVqgmS+Qgoo8DlQCLkXa26noKhH/Qqkl+rGHYXWcWxJFa+AWm/4oNIIqezK3th1JDuPeBiar2nk0c5SDy3D7n3b9rmd1Ts4ef5YX93qBpC2VvIqe8maNJjKjeqAiyc8bsj0HhPN6CqU/U/ci6rQE9hIqBDaLJDm040P9AIbx28e1JL24pd+ArzJ48tGp0wKlyZUF0AJhtkNf2JmCfbjwWPOZ2efcIDCqhmyCypjj6qn/8mk4FM6uM/hwxLl3gEJf45WMMAaSVu2SJ1L9ErcjSPvsj3KpnMuZ9aZIpfutakQ1Wh8W11d93jmC5Rzcm10hQzYFe+B64VALqhxN7Wmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6SPR01MB0090.namprd03.prod.outlook.com (2603:10b6:805:d::23)
 by SA0PR03MB5643.namprd03.prod.outlook.com (2603:10b6:806:bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 15:09:11 +0000
Received: from SN6SPR01MB0090.namprd03.prod.outlook.com
 ([fe80::8b7e:c42f:998c:10ef]) by SN6SPR01MB0090.namprd03.prod.outlook.com
 ([fe80::8b7e:c42f:998c:10ef%4]) with mapi id 15.20.9654.022; Mon, 16 Mar 2026
 15:09:18 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        David Lechner
	<dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Thread-Topic: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Thread-Index:
 AQHcsuDicaoN1aZWTUK+A7wds+cMEbWshACAgAFqgwCAAwIhAIAAIhZQgAAth4CAAASQIA==
Date: Mon, 16 Mar 2026 15:09:18 +0000
Message-ID:
 <SN6SPR01MB00904D9E9C5008D32066E2029B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
 <20260313115856.87763-5-antoniu.miclaus@analog.com>
 <abQdvXq9MtIZ0EpZ@ashevche-desk.local> <20260314120022.56265de3@jic23-huawei>
 <abfT3qbFaM6PIDKx@ashevche-desk.local>
 <SN6SPR01MB00908E6EDB8F4D20D391664B9B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
 <abgWpzT_fcMqRHzf@ashevche-desk.local>
In-Reply-To: <abgWpzT_fcMqRHzf@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6SPR01MB0090:EE_|SA0PR03MB5643:EE_
x-ms-office365-filtering-correlation-id: 90b1d16a-e9a7-4a06-6f35-08de836dfefc
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 8XzkHrOlsYmVS90Gk/tQIyUlH0XCPx5TX7Xd1Nyw9uKr2+1jT+Bd6WWjhIgtiOl3AhsPDNgBAnF9lytnbKf/duZsSdP9F8ZSCx0AxN5W/dkHHqUsP+gmpnF7AgP2T/LepkqHub8X3yI4PEDLIxPfBYnWgARjNvn/ijBZHjfVtrNn+zFeKouRFrip4PGnHWb1TAZJXw5HJjijCjgzdzYACYkgrweyyKkHd1oZy6GbtukrlhRTpkIt6i2dgu20lgIPmtELmoJ+YEnDJCDiLAvfARbnsSARaS+gcLYWRjrknGBsOH/wmUH72J9FnWuAmCoPwlfhYmjUZ8jQyzh9lXxl8znZsHbKmvkHzHY68puXkuH45NOxnIDSOJLQb737lBfmz7zd+abNizsWJCvZXw3nS+hpCEPIgRac8XpWYAOdcmXTGXBjFtvh0lIxyGKM/Qs0ie5wsvRDcM10GCuxIsYRhZYZhN2cQu25DbJV9HQWB5LkenbVobRmoMXD8MZqued755DamsQzFO9Mt5yTU/4PrUllWcaIhj5XthBi4Y+UbsyT6PHjGGdnNXl1oHGgik6GSj/9lpPLEgOMpBYFF3RdpsZvBpW6Ig14XTN40SA19yW4Kn3QT2OmsTV+a0UrffehRZbsPaRjfDj+3yS6f8HAEuWIvPBCp/Mz33WuaL3wujnhBHI/TDLH+OBr2/ywuo68H7iZqJfqDqYUk0dDMO2m66sJD13IL+2G2B3GDNHDXnRjArEMiBxm+GZjiSqvELND66bWFyy+wZm3uIaJLQ0vtwhHyg1uedGAQ5Maqw8VOkg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6SPR01MB0090.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aLOhV4cvG+VZkAG+POcYBaf7DXBb9V1yHLEWm4drtzXWkAsVheL889DeZv?=
 =?iso-8859-1?Q?71Sv5sMqAlvIygW57kADxUbrtKl0AV5/UwIhgsVbPvXFcn2C8lcfu/ExDI?=
 =?iso-8859-1?Q?s+tkz1R0E4B0otY32sq468uOKP1YIpu7191VYzuYr+TzuiiT6eq+jDTRSo?=
 =?iso-8859-1?Q?bj7f5ym4XImqkH6HLkBjdrRJGtdlRyEvX8yBfzALsW7In0IEMSsmtXnKME?=
 =?iso-8859-1?Q?AAj0rzdNvilkm3COs/RBT7/54F27hDKqWuUlf1gnYvosKJTtozPBYiR9YK?=
 =?iso-8859-1?Q?r9uTKcmnULTBFLw/DATgwckPRaw92BaD9Y+2BsQDHfnONSlCi/U2P7+aOW?=
 =?iso-8859-1?Q?LyICupLe6mKcFrCGSPdwbO2EeCrSMbCPsPItztEcrYiL5yCFFjPiCk9hT3?=
 =?iso-8859-1?Q?O6ODfNcL3Og4SBxkMFtsauxBVRJHYP0Y2wJJ2mLuKrpF1+e5TcmvxL2UyH?=
 =?iso-8859-1?Q?SuJAG2UaB0o0jzTZcJzJY83LtSHpvA8VbIfUbRwoaHNDRHe0xXAtLznRjX?=
 =?iso-8859-1?Q?u792/yjPr7RZat0/pia+/EAx6ZKkh9KU5bIBjN+cJCaYsgeIsOmBbg20OO?=
 =?iso-8859-1?Q?P8by4i7tEyjrC1b4lYa6oFCX176sD+5x/diXM5pQYWd/3AeK8ifBaubSx+?=
 =?iso-8859-1?Q?s3Hiz1S4n4VR993HaYDShtjfWzckt6aFBVn19iw6NxDzCBHzSXDKBrBuNe?=
 =?iso-8859-1?Q?Fb4Ohww3w4Ap2JRj0a4f9rXl1EGaYeTmiExqtI3HoLBT5y4FUhVPchdhOp?=
 =?iso-8859-1?Q?8Wa8JkQoPncerTPsh9Su+tKeGYOEh4CRH6o3cSFnTYfwuoXQPfUZoTR/RC?=
 =?iso-8859-1?Q?NkkG27pshevaDqgLixelytWNadH/QnzknstfRMeXgte0OY7jx9/GAkCTK/?=
 =?iso-8859-1?Q?NhintBE0n9BqM+4gS+Ogv8DTnqe0moas7z7QB6DCzt55i9/MVymvtWXPpK?=
 =?iso-8859-1?Q?QUEw/1H72yVq8s8POjQEicKn7MkwIqLHfEW188XDjbxndI6erOzZGekmNY?=
 =?iso-8859-1?Q?UlSow22TQKzE0tNLEvOAaiTfn4JPVRqSa/ciMk39DcMOWHpg4QTnE7gdRB?=
 =?iso-8859-1?Q?P7JDrpd+qCjD8LVHGkUXi+KKrpWiY2PfU1uqVTe+WXFpgwf5u5FH3ovbjP?=
 =?iso-8859-1?Q?COvurUvmgsVdDmoJnxNSfaDKyd17YWEvy7sadYrbb4CEs7aUK7bBb/9jqR?=
 =?iso-8859-1?Q?IBdFtay1WfOfieeOXE259PUDw2BDzpWMD4Z61NcVEdgSE2x26nH3BeXKyY?=
 =?iso-8859-1?Q?ybZPAoII5e66XBKRyPrZumcSpD73F0WPMMfdZeTsOFhPdj73OMjvsuSVyA?=
 =?iso-8859-1?Q?8ic+pIdbckek+miBfqDpDpQQzprA6upJmlVwv/GqbhNSyqdcNOx5RB2DI0?=
 =?iso-8859-1?Q?TmtYA310obuFrVPaOlcgJIqeCyqAYwon8nmKC0WKu/USpfFM9HOhp0fQA3?=
 =?iso-8859-1?Q?MfURyWYSWusDzzhp6lPeVpjf54Gtf86I2bWUWIQ9PXe1l4eDun9fqtAi8l?=
 =?iso-8859-1?Q?eqEzmaWeubY8ngdxqb9OWDl3JwswCHDHbjzxnD/ZlON5VTo9YqCnp643Ml?=
 =?iso-8859-1?Q?CfcY19lzx+2RHwBNFgmEXbws9mgfBiYQQoRM6n/HIBqx7iC+gLmTXgGsNb?=
 =?iso-8859-1?Q?z4FF8NDxG+SchTnk+c/EwTgABLEAJOEc9KJyXcEQzuizVmQHySuBdew0bD?=
 =?iso-8859-1?Q?q8kvlb2YHoGCx9xjXxmPgMZLVR3xoV/KQCVGWAxRFDYTuiy2oGh7jHtM6k?=
 =?iso-8859-1?Q?Qctm2owoPG9quFa9FLMAz66L6d6nYsLRwnWWMVqQoV5Ej4VUFhKepezCGO?=
 =?iso-8859-1?Q?7Uu5Smpkhw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	opETizb2QPStBakxOp62UZYOQ6fV0+WGC/9K3+fJZATscVbX+Ty5mDi+a2pac3QPix6mT9ULV8+vfilGawtxLkZEL805x3Oabr7oddVm3iIswllVqR/04CCvRVTLPWR94srMmcKGMWgrVTPdRih8AFjvs0gX64H6iA/dcjld+0PBQKHvV8HseTnm7JXlDk/GtbdP7tgxBNEBCv5fBYVMAk5cQvRFqVlyrbaJ4bt9Un8vOFjNq0KaH7TrxT5JVXATpQde+x1J5Gtlgqjb7sas57Mk2SHHi1UJcRX/9NWjqS2oZskbQ72cxAbpsDo+KZeBOfMJH28z6bKCe1/gKCAVtg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6SPR01MB0090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b1d16a-e9a7-4a06-6f35-08de836dfefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 15:09:18.5770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1YOCHFvJEyh9TT/akskYNWvVjo7RXLZilxFpSIq+x3Yl+Ef7wfM+zbSsDz5KcrYiTlaWc4BPl1pYsqlejz2lp2X9vYYH2R6SKVjAzU2NIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5643
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b81d22 cx=c_pps
 a=OGRNNHJcR/XwrOfql3gobQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=8b9GpE9nAAAA:8 a=WygjWq1EwxeOErbFvbgA:9 a=wPNLvfGTeEIA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: 97X_QgmnR_8RTXbBgtcd4vUG9f1JiziK
X-Proofpoint-ORIG-GUID: 97X_QgmnR_8RTXbBgtcd4vUG9f1JiziK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExMyBTYWx0ZWRfX0zveohlGvY5V
 3XbBODFwjkArK0OKmcnxBmjtlL+7H9eKbUKChmYRgZhYyi/5PqOjiB8jDHVdl5v7oDtRCz0oL6B
 nP1ketXeDVI+A4laLLDSCLYDT8URZWevG0l5AR8Y8wzRJKjvssrhfIWvOPRGM2nHL1Dyre6V3vz
 inaaHoHnnHT6miXUgQNMe9ny4qLDWTCF4wZ6bU9zTacBD9z5gBOSoeV0nl9T/mdvgodxzVB2Vl5
 16YkcLnb/NoiQrmI+XM07MJmGln63mh8M8TH3tk4hfkLdaBpEv77uV6Eo1Z5tht8NswNGcTyuKu
 WKb5gkKJdMDEpOgyoA085JhJj0LhjF5nhx4a7/KmBOgk4CaDRERDYvFn/ztH8p2dZW/hBti/5zp
 L268s6cPw93OzxTaPSVDbypB/2ehpNS9gv7izyaSXbM8PIySP+HnV3+e61lhPaM/YYhKFg0Q4oJ
 VB8cv9wdzDznFCph2Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160113

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Monday, March 16, 2026 4:42 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Olivier Moysan <olivier.moysan@foss.st.com>; linux=
-
> iio@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880 dual=
-
> channel ADC
>=20
> [External]
>=20
> On Mon, Mar 16, 2026 at 12:31:09PM +0000, Miclaus, Antoniu wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Sent: Monday, March 16, 2026 11:57 AM
> > > On Sat, Mar 14, 2026 at 12:00:22PM +0000, Jonathan Cameron wrote:
> > > > On Fri, 13 Mar 2026 16:22:53 +0200
> > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > > On Fri, Mar 13, 2026 at 01:58:53PM +0200, Antoniu Miclaus wrote:
>=20
> ...
>=20
> > > > > - What is special about channel 0?
> > > >
> > > > Nothing.
> > >
> > > Then why code does explicit access to regmap channel 0?
> > > We should have regmap[ch] in all cases in the code.
> > >
> >   There are three places that use channel 0 explicitly, none of which
> >   imply channel 0 is functionally special from a hardware perspective:
> >
> >   1. ad4080_reg_access() - the debugfs reg_access callback has no
> >   channel concept, it's a single (reg, val) interface. We have to
> >   pick one regmap, channel 0 is the default choice. I can improve
> >   the comment to make this clearer.
>=20
> Then it's simply wrong. You allow only one channel to be printed. The deb=
ugfs
> has to print two channels, no?

The IIO debugfs_reg_access callback signature is fixed by the framework -
it provides (reg, writeval, readval) with no channel parameter.

For v7 I can drop debugfs_reg_access. But doesn't hurt if we have at least =
half
access to the debugfs for it.
>=20
> >   2. ad4080_properties_parse() - uses regmap_get_device(st->regmap[0])
> >   solely to obtain the struct device * for reading DT properties.
> >   The device tree properties live on the parent SPI node, which is
> >   channel 0's device. This isn't "channel 0 is special", it's just
> >   "DT properties belong to the primary SPI device."
>=20
> Can we simply pass the struct device to that function?
Yes, can do that in v7 if you think it is absolutely necessary.
>=20
> >   3. devm_iio_backend_request_buffer() - requests the buffer from
> >   st->back[0] because all channel data is interleaved into a
> >   single stream (there's an inline comment). Only one buffer is needed.
>=20
> But this is not regmap related, is it?
>=20
Correct, it's not - I should not have grouped it with the regmap points.

> >   All register configuration (setup, filter, decimation) already uses
> >   regmap[ch] throughout.
> >
> > > > > - Is it okay to communicate with different channels simultaneousl=
y?
> > > >
> > > > Yes. They are entirely parallel bits of silicon. Own state machines
> > > > and everything.
> > > > The configuration registers section of the datasheet says:
> > > > "Each channel has it's own independent configuration memory
> > > > accessible through it's separate configuration SPI interface."
> > > >
> > > > >   Wouldn't be a nasty race with HW IO?
> > > >
> > > > Nope. You are talking to different devices (more or less).
> > >
> > > If it's a twins in the package, why do we have a special handling and=
 not
> just
> > > describing two independent devices in the DT/fw?
> >
> > Because they are not fully independent - they share:
> > - Power supplies and voltage reference
> > - The CNV clock (conversion trigger)
>=20
> Okay, then why not having a core part and a glue driver that registers as=
 many
> devices as you wish and provides just a common stuff?
>=20
Because the AD4880 is not two independent ADCs sharing a package - it is
a single device with a single interleaved data output. Splitting into
separate IIO devices would make synchronized dual-channel capture
impossible from userspace, which is the primary use case for this part.

The shared resources (supplies, CNV clock, interleaved data stream) are
not just "glue" - they define the device's operating model. The
per-channel SPI interfaces exist only for register configuration; the
actual data path is a single stream handled entirely by the backend.

> We have similar (to some extend) cases with SPI/I=B2C where
> drivers/platform/x86/serial-multi-instantiate.c services as "MFD" for tha=
t
> type of busses.
>=20
> > - A single interleaved data output stream
>=20
> How does it work in non-racy way?
>=20

The data path has no software involvement at runtime. The CNV clock
 triggers both channels to sample simultaneously, and the device outputs
 the conversion results as a single interleaved bitstream on the data
 lane(s). The FPGA backend captures this stream directly - no SPI
 register reads are involved in the data path. The only SPI traffic is
 for configuration, and each channel has its own independent SPI
 interface and regmap, so there is no shared bus contention.

> > Describing them as two independent DT nodes would mean duplicating
> > all the shared resources, and more importantly, the data interface
> > is a single interleaved stream feeding into one IIO buffer. Having
> > two separate IIO devices would make synchronized capture impossible
> > from userspace.
> >
> > This is exactly the use case spi_new_ancillary_device() was designed
> > for - a multi-die device sharing a bus with separate chip selects for
> > configuration but common data/clock/power infrastructure.
>=20
> See above.
>=20
> > > TO me is either something special about channel 0, then we have to
> > > synchronise
> > > accesses, or there is no point to have this patch at all, just make d=
evices to
> > > be the same under the hood and describe as independent pair.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

