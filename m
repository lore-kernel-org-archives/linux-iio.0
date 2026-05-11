Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7D379EE8;
	Mon, 11 May 2026 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500975; cv=fail; b=d1OlvZrUjrmoBykR94w6eMH1L2AY+8lkbqeFQTd7CpJeZ91V5pYvd46N6sn/7LYn3ZOFushGB7BjBxD9+8uAGhpfJSP1JZVBfgRkuhwL/D7viv2/vKvRd/33GgYUmSob6fEQviPi352E4UOb/NEcrO4IyExWkmWB/d6feQiLP2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500975; c=relaxed/simple;
	bh=5zT6l1X1s7X6oxpnvVex/H2AgqcEk9k7AmkMVYHTQRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=noUucVEK05xDbGlTWiWRwXawT2IE/UmZ2006Vwr/c0eIwHj4Mm/E37SnsnwS2+fsWelHRck+cDGFKNsIBg+I4P/mFNFMrJOF1Q3+U3GjTnZ0lwFUstn3rxJVR21jMmka4F2m2Qk4v5jIa4AvoIesV52B0ZONXfkXtsdw0Qphl6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Kg6EPfJ5; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Kg6EPfJ5"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B6LN1O3322422;
	Mon, 11 May 2026 08:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5zT6l
	1X1s7X6oxpnvVex/H2AgqcEk9k7AmkMVYHTQRU=; b=Kg6EPfJ54zrcJ40529qky
	RRVilz20A/yFMMS5bPn1WL2PzmprudN8p0LDHjVVAajsB+NrdHRUN11nOtEQjUWL
	tdqNC0qeiLOGVJw0YC+2npE3BHO462c4acv1qN6fBznkluwmB/qtClA7nuPqRDXv
	Td/KnUVGuTBynP/i3GG+qN3UpafCOgCdxnglcFJbVmBvaf6A0+luiofNR3fCuUUs
	TZhzP8VTJRpRaiWCTuSK0WO4lwH+MLhCV9zK17C8cnS0wLgD2543Q6PsZMfD1QmU
	cLsl/lgr9lTAtayXR2GK+/eYVES0oDkyGBh6i96pXQTT+qkSRnG6d8rrRxfM9/Ru
	w==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e2nhhu64p-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 08:02:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFFQOhTTcSmx5TgR6XBvwGvaQYUVU/Q79/duKBny1qT2iBrQjnFUFYh9i+Ue9KBnJt8oDL7eNiRA9sLm7U5Xj7Jmw7xOjySQ6MwuzB79XSH3OB29/GnSar8nTbADkHArP2kiJF4W4II3GNpvPEAYmdTKkP6XlWqXLTLNhr3iSNk91QWFMMt21H/TrofSZCXwwVpCaBjOwqxSSrl+yrMgQL5KrM2IEnMf8GZJKo8xuQrz5n+fxk0Ign4AzqE5K2J/W4zfVQV9gbqJbG0L4kdM6O70ZgGU4p6nCWa5Al6mydAZE4g4Uq/f94nqer7pbZqpvJQIUelarnIMN3rbSmNXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zT6l1X1s7X6oxpnvVex/H2AgqcEk9k7AmkMVYHTQRU=;
 b=WfppEeewCrQUJkZ2ounAG8/9lJ5WIHbHtCAAuePi020/6UQxW8Yhtx1+CXpV1WgVug22akgn52xmjQTSXfAs9YUGs+p3sll0i8kkUrgPqKjB0r31hrE8a/Gp8xjLUuEVHEL1iRqO1cjdcVMEdO7fG0Gyt3/O2qunbT/IOZbvK1m/pkf4V6Dokk4PS41Mx+dlJfuwJJBsL3hqa88lgFcWYR7dqlgkhsEnx7Q6ZehViAj48oKh1yEjtpv+nBrcpLK2cG+scSoh5bjBM3cnDZ56G+SbO/w9z01CRiC5qV8ooOMfiYHjCJt0J+kkWOf+FIeM3QlTjyvAFx8BzlnR4BX/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by CH0PR03MB5970.namprd03.prod.outlook.com (2603:10b6:610:e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 11 May
 2026 12:02:32 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Mon, 11 May 2026
 12:02:32 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>,
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
Thread-Index:
 AQHc1kn/5d/Hh1H9DE+/jMXiSvhLvbX0U6uAgA5CZsCAAVTVgIAAIEGAgAAYMKCAABGiAIAADdZQgAAbwgCAAXn1AIACljLwgABUcgCAAArCQA==
Date: Mon, 11 May 2026 12:02:31 +0000
Message-ID:
 <SA5PR03MB83772A1A57DC052CB21B9187F6382@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
	<20260427132526.272716-3-liviu.stan@analog.com>	<afCVtXBHIIoLlsRo@nsa>
	<SA5PR03MB83772D8F6A3CC39094DE5241F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af2no3bJA9MSjXvV@nsa>	<20260508121441.39ad9f65@jic23-huawei>
	<SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af3oezNmmBhI4Yu4@nsa>
	<SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af4LCQiqNaiMzFkX@nsa>	<20260509154600.02e2d11a@jic23-huawei>
	<SA5PR03MB83770D945E92C40A74D9C0DAF6382@SA5PR03MB8377.namprd03.prod.outlook.com>
 <20260511121820.3be9e635@jic23-huawei>
In-Reply-To: <20260511121820.3be9e635@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|CH0PR03MB5970:EE_
x-ms-office365-filtering-correlation-id: ab2cdcdb-0049-4aa5-49a1-08deaf552e80
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|11063799003|22082099003|18002099003|56012099003|38070700021|3023799003;
x-microsoft-antispam-message-info:
 T/KyzK1VQ4OfINYWGrynGm9Pv42Y0noY0uqKcXlATS+rfPohiF3VoyYCxuEio8n9NyIL+GTFCBPS3CgNTVvHjbYx5YuQrMZPYFEYDCRFp9o3yEM6xQyTVGMI4b8s8mzkGct9E/KfrQavxjgEr5zp93+lx5xkB9+lNnyCQ3Oh0U1LiM/zGaxs/J9hM6fSRotSp8c5uCKTcC8MOClBEMA1hT4u/5KJihcx6FICEqtQELL+X5tgeddzi2bAAQkWI890FquP9iacPin7kGzf8ml1NbtfpU8rds1f75qXlup7EDVoVJTKFwIiHzRtlt5E/tYkWJhGGV7JN7chL66ZfHSpSwndE3fybBIoVTIzbSn9eocasUgSPGTa2opV/umRzwqHG5CPCz+iX27LLzRvttoUC/tZXoU5RUsiczhsAPlOjo/5Y9oBEqdWrnJiZQnGDPhNkLdIHUGVrwXMw0YePZ49eaI/1/puTd41w61nj1Omww7zM6iJu53EO+xOzbCYPmJd6n3H4MCD2o70T+o2Pp+RAshTHGfXcI9geIyOQ4PjUEm3XRUqmrisJ3olke04kZw5xy2+g03b0LtpYU1Qp/sxC1L0VOrTAwwiZTtM9fg6/u1xEP5QFViGP6X2Ri/x5buQNeg2pO4QrCADR0N4+/VkSu8O2MvhDY7ePYbL31QbRZjbYbKfmkTZTS0Y/kPcTFRjuNQJC5tMWlIda3lDH70XqFtrh4iNXR0vMTjDybN6RpksBhcSqoI4ItfUh7UGv4h6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(11063799003)(22082099003)(18002099003)(56012099003)(38070700021)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U05ndGlLNzBFeERWaEI3NzJtUFUvTDc5QXRHQjM5OVZCVmlVVmpFNTRYSnF2?=
 =?utf-8?B?a1l5UWJvQ1pwSk1oZ0h6ZDVueDdJajNHeWFEbGZBQ0xyWmxKL1lRVjFIdWtn?=
 =?utf-8?B?RFhyb0drQ1hhRGFtcG9PSS9jaURXQXp0NEs0cDZWREVVWm1tVkl6aHRJdTdo?=
 =?utf-8?B?NGltNTE3aENwbi8rQWF5Sml4N1pUa1pMQ0ExOVB3Ly9zWjNyWGZjT29BQzhW?=
 =?utf-8?B?elhZbloxNUhCTU1IV3h6WFhqNUU4NXJ2Wk1odUpzbjBNa3F3SmJZY1VIQWVs?=
 =?utf-8?B?TlI3MnZWekEyZHlieW9vcFhET1REQlVGZXJxbnFoRGdPYjZIcmt2OGdKQ1Rs?=
 =?utf-8?B?V0JHNUtmUzNTaE5HUHBjNk13NnJlU2YvajNqc1hsRUVXU2ZaOVpobU1TY3ho?=
 =?utf-8?B?dEJVbW4vOHVZaXRMUzdSazIvU2g0bVRybCtVN0JCYUQ2ODk1Ynl2WmxPa29X?=
 =?utf-8?B?MHVHaXlsSkhGeHMwY2NtMXJBUms5TUxJMzA3czFZYlVPS0dEMElYN1JsNTRL?=
 =?utf-8?B?c3lPemg3YlMxZWRWVFA3VnNtUzdlYVQvOEtIWW00ZHM2bE1Ddkd6OGFRUVd0?=
 =?utf-8?B?ZmsyL0R5MzhFaDdRa1NEenVWL3NyNkcwcENISk9YcFp0aWd3VUsrTm9ncjFP?=
 =?utf-8?B?T0ZDbHpRbXZOWWNSRlBUZm5BekZwTlNOWExCb3I0Z2hSeXp2OVNsUWp2YldK?=
 =?utf-8?B?Y0VLMmZYN2UxazZrQ1lxenBKcUNydXhmREk4Nld0YnlnQ1BUYWQyQzdtNmor?=
 =?utf-8?B?cFh5M2ZIVjUvZUgrNTJ0dEFoK2U2aElaWnNQTFFacGcyTU0rMS8wdDV2MThV?=
 =?utf-8?B?VnFzbHRJR2RBQ1RGdjFsSGFiQjI1ZHFnT3ZyWWFDeE13dyt1VnFkbkVIRVFP?=
 =?utf-8?B?TlFkWjBESFNuanhVODVBaTBnZWE2Y2JwVkZMTXV4Zk1XeWpHODBoOTJUSHlB?=
 =?utf-8?B?ZWZxY3locWF1MFdja1dNZmlsNjZXUVA5VDlxdUtMcklHTWRrUDdaUU1hUE42?=
 =?utf-8?B?TFk2cGhuWGtwODFjWWIySFFTSmNnNExXVkdxdjZlVjJsQ1UxbExHeGo5UzVT?=
 =?utf-8?B?TVJQMU9yYXBIWmcrRGxCbEhjOUxURHFVejF0ZGM2L3l4a011dnArcTdKcU1p?=
 =?utf-8?B?N3daSjJycmJRTDVzNjZ2N0VGSm9JVUhPb0lBcW1HcDNMWXpLMmd6cC81KzJz?=
 =?utf-8?B?VzdGeUxEVFJPeTRLQStpMTY2eklub05WYjlMUTBIWlNLU25tem9DMEdEVmdX?=
 =?utf-8?B?cTBZOVUvOUZSdHM0bTkvMnhFd25Tb093NktQZG91M0ZBWnQ0elBBSzZWSWFa?=
 =?utf-8?B?NHIwMzRoU1oybnd2ZmlTYXVWMm8rdFd0RXltTEVVRTNFMEQzN0pBTDZHZGtU?=
 =?utf-8?B?L1o1SVQ1eVFPdHhnZFFDVzEvcHZrSUxOS3dDSXVjVkRYZUdKSDNtUW5hcHla?=
 =?utf-8?B?ejR5N3lSUnRkUnBhdHhmTStMV0hMa2xCMVByU3BmYmZYZTFsbnpXZ3kyTGNC?=
 =?utf-8?B?Q1J4SnR2MmU0ZkRTYWJaT2FDRDJRM3VnQzkyVElCVGc3Rlhka3p0a2FETHhm?=
 =?utf-8?B?SUpnTkEvcy9jdUJzODRhdmQ2MTViVUgrRG9SM2VUQ09zKzRPTDEvRUt4UHIz?=
 =?utf-8?B?RDk4U0lsYWJUdkNyWXlQVmVvSEZWdHMvNGw5NjBPUkdWZkFucDUwcEZPbFls?=
 =?utf-8?B?NUhkZEYzOW1CVmt4U2JuSE9CNW9xMlhvQ29iWHhSdUhkWVI2RlpVOFJQRElq?=
 =?utf-8?B?QUoxZE1xK25uZlBkQmw2eG81SUtJdTZLVDlKdHdZdU9qUGM5aUExa2lYSm5V?=
 =?utf-8?B?cmlDMlZUdVVJSEhMVEtrS1M5ekR4STM3SEVkZnd4cS84UEI5WUlKVVJwcHJE?=
 =?utf-8?B?SHFLSzR6R3FORSt3Z0h4WXRacEM3VHJvd25PQi9HTENNeUk1ampndEFCZWth?=
 =?utf-8?B?TUZuejF3L1J0My9ZSlRFdi81T21aWXI0UmZ1RXplS2ZNRklLRGNnL1ZvekxP?=
 =?utf-8?B?aUxBVW1tdjd3N2JyME1rdjlYem9EZUFyOU9ySmVrUjAxZjhoWnpxb1Jlalda?=
 =?utf-8?B?M1FRSGNaZWZISTByTFNEbTlpbGI0Z20yekh4RTNPc0Q2NGxqc0hkT3RPZHE3?=
 =?utf-8?B?UWtaTWtjU0RUYXN5dGh6M2ZoU3ZKeFNXdS9XQ01WZ2NOY1U3OU9oQmpaMisr?=
 =?utf-8?B?d1hDSGtwR1NrME0vSzlxTFNVMlVzcmhSRmFMUmNyZjJkemFvclk4MnQ4Tmpt?=
 =?utf-8?B?cTFkTmp3bDNtQTcrZVJiTDI1SzlLV1Q3NWVjOXVKWmN3UlN5bVNvZDFDZ0Qx?=
 =?utf-8?B?QVRoMjVUam5WWEtac1ovSHZqcG85U3plUWtlZlVjNlJEMTNVWlYyUTMzMjE2?=
 =?utf-8?Q?yLpFe2cQcURoUuT0jlk65pqoE2zrtklgEtc0XfkKFLDIx?=
x-ms-exchange-antispam-messagedata-1: bewDeVZEdk2aJw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	U88UkLwF8CgB/b/mqoLo7FglywT/rIhw3nTGjNWENYvg2kAJz6ch5aNl/I/rQOtUmWhYbrYwVMgvtsoGCMtWJbPCek/cvsOgD269tj8IQABSuLfzpcAOxKn/wgEU0BDKMWkEWwVGh9+ReO2O8QJdCSfKKOGYn3j3QLZET5dNYTIXEvVaMVzznnsJPKN3cfLSaWckkzwyujnn4P0cjO8e6WEfbmn/JEydluFXQ5xd5PI2CtkU489YLNnpnDmTlDkjNT0eGovtBr6h2ef1VSH+h+siYOGvSIbDIpRob/faJgrtnfadJqqA0vGO/JvY6nKDhWAG9a6p3V4IciHn3VzMdA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2cdcdb-0049-4aa5-49a1-08deaf552e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 12:02:31.9837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V5ex7eOMmXCYnWb8UX9aVCYNlpX3O3JjxSJjLlZFqXioBaqO/gv6DdZ2/ZFXxTU3Qr5L7WzsIWU2XpsoLpKl/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5970
X-Proofpoint-GUID: jJjEWu5ChOW6fc5DFjrtVJDI_CbquKNK
X-Proofpoint-ORIG-GUID: jJjEWu5ChOW6fc5DFjrtVJDI_CbquKNK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEzMyBTYWx0ZWRfXwhIoTf35JnLI
 JQyhFTP5/OdrRFUrksjMRQQ+H2bh8fRuCn12712mjb/i/EHsYpAQzuFy7Nghe9ZP3BWXZVR4eEk
 dHjvQnehfdfvnQ2e+xLtQ/XrI4/cxDpJODYkeD+c1ler3ikD44C+n7ubNV1/kfLCMJcyeLWIPWp
 547mvC1xHyLzHvBQOqpkIIz0HiSejdA4YTCNs5ufJlHhYAEZiKUXkJm+FSuikz/ooAInluC1Ons
 47bNr7j7CiFFFnzRJG0STnmPMQDTAK+u8wfcHQBApYl5smyqbvf78az1MHE+f4F3OHyFofs3eGS
 +hFfqE7f2IVQn4y9HXdafqT2IABeIRZmWbD1mFH+HZnE5BHbadAQkE9ZrOnmUAq2rUwrS6xprlF
 vkG7Pd5bOk1lKFGLHESmyyJ+4Vxi+bLXOgSX02Sa2yKVVFn+6/f4AGG1TmSeqCprm0uL10e0rRD
 tvh6tOB266xJTdtcRFQ==
X-Authority-Analysis: v=2.4 cv=YvA/gYYX c=1 sm=1 tr=0 ts=6a01c55c cx=c_pps
 a=F5APu9G2MQgGAPAZFPwQAQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=023bsk_xDbL7PwYptMsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110133

T24gTW9uLCAxMSBNYXkgMjAyNiBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+ID4gT2suIFNv
IHdoYXQgYXJlIG91ciBvcHRpb25zIGhlcmU/ICBQcmVzZW50IGl0IGFzIHNpbXBsZSByZXNpc3Rh
bmNlIGFuZCBsZWF2ZQ0KPiA+ID4gdXNlcnNwYWNlIHRvIGZpZ3VyZSBpdCBvdXQgb3IgYWRkIGEg
bmV3IGNoYW5uZWwgdHlwZT8gVG8gbWUgZmVlbHMgbGlrZSBuZXcNCj4gPiA+IGNoYW5uZWwgdHlw
ZSBtYWtlcyBzZW5zZS4NCj4gPg0KPiA+IFRoZSBjdXJyZW50IGFwcHJvYWNoIHByZXNlbnRzIGl0
IGFzIElJT19URU1QIHNpbmNlIHRoZSBjaGlwIG91dHB1dHMgY292ZXJhZ2UNCj4gPiAodXNpbmcg
dGhlIGN1c3RvbSB0YWJsZSBpbnRlcnBvbGF0aW9uKSB2aWEgdGhlIHRlbXBlcmF0dXJlIHJlc3Vs
dCBiYW5rLCBub3QNCj4gPiB0aGUgcmVzaXN0YW5jZSBiYW5rLCBidXQgSSBhZ3JlZSBhIG5ldyBj
aGFubmVsIHR5cGUgbWFrZXMgc2Vuc2UuIFNob3VsZCBJDQo+ID4gY3JlYXRlIGEgc3BlY2lmaWMg
dHlwZSBsaWtlIElJT19DT1ZFUkFHRV9QRVJDRU5UIG9yIHdvdWxkIGEgZ2VuZXJhbA0KPiA+IElJ
T19QRVJDRU5UQUdFIGJlIGJldHRlcj8NCj4gDQo+IEZvciBBQkkgcHVycG9zZXMgd2UgZG9uJ3Qg
Y2FyZSB3aGVyZSBpdCBjb21lcyBmcm9tLg0KPiANCj4gV2UgYWxyZWFkeSBoYXZlIHNvbWUgJ3Jh
dGlvJyB0eXBlIG1lYXN1cmVtZW50cyBsaWtlIGNvbmNlbnRyYXRpb24gd2hpY2ggYXJlDQo+IHBl
cmNlbnRhZ2VzIGFuZCBzaW1pbGFyIHRvIHRob3NlIEkgdGhpbmsgd2UgbmVlZCBzb21lIGluZGlj
YXRpb24gb2YgJ3doYXQnDQo+IGlzIGJlaW5nIG1lYXN1cmVkIGdpdmVuIGl0J3MgdW5pdCBmcmVl
LiAgSGVuY2UgSUlPX0NPVkVSQUdFX1BFUkNFTlQgc2VlbXMNCj4gdGhlIGJldHRlciBjaG9pY2Ug
dG8gbWUuDQoNClVuZGVyc3Rvb2QuIFdpbGwgZG8gdGhhdCBpbiB2Mi4NCg0KVGhhbmsgeW91IQ0K
DQpMaXZpdQ0K
