Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDB73A8740;
	Mon, 11 May 2026 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485981; cv=fail; b=bJUyt/4CR/Lh8/qnrGRncUt7DUdi/ILVypL5N9NJc6IYEUXX1QQTIaAaFTAnMCyTZSrAOTxM5EGrZz5Q/CuX70i6iSGoCZNkFkn3qEsC7iXl+3QdAHoTIv1PsGYerVkjv/NFk2F7Ph4QLFAWQ2rb1F37cYPEZcuAWl4r1uFHyE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485981; c=relaxed/simple;
	bh=vCpjPJ19kmQ6PIMIQ2nm4oQDp6/5FRFhL9+QU8iEYio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kUSHZoxSHc6AUGjgim2wtP2DiPDq0jdC5aSDLaiJ5GghVS1Xu862ZlXGqy2kHM2vtPjZoO2mGRqicxliiGFgdKE6LF64jP/7T1e0JdrNsj6F7Y8kwse+pt9XEYWy1PNGo69kN+JfsI6AmfTIrXdijes8V8Q2g9fDGjUXZJbv2fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iBdpcPFs; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iBdpcPFs"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B6W61W422411;
	Mon, 11 May 2026 03:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vCpjP
	J19kmQ6PIMIQ2nm4oQDp6/5FRFhL9+QU8iEYio=; b=iBdpcPFsN2DPNs0/CDOru
	7EjO6wcM1xSJCc9xOvO3GMQsmwlBjWIwKpON7Ih/+G5xLLY3pBcOgsRXtXielMEI
	NQH9r3ChE0qumfxsgSNFkWn110TUBFsfJtL68DAzjTe0ROqbqJofyOZMRh5b3dbs
	jcPmtT7khqpbDklh4wr0/nnVY7tj6wvPwACnuFS1111W/YD454Jz/CpeqB3M+5E6
	C1eEOK4zD54qLxie4OyYck76GHl/nfISYT7UblfzMa/gG7C4k8IpBj74UJPCeU3L
	28Vz5hP5i5c8OSMrOc/pNKwmsPaguC92SbSSoVETQCS+GChhiX4CzTbvp64Ut750
	A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e33sx975t-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 03:52:20 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iU9jkMZJqzvgs9GlLTKho1/WanfzImCGXJiJOK0g0PA8s0dQdqsX4fHKWb6HLrpGlcw9I397T5pItS0+G6BI/ZLZ+2ppP8U5efTS5F513Kda5R5EoX2Qupj+ymxUcWVwGULRHHTRDgFAsoAPeIEqEgb+G+NVaImLuG9iQ0F0WasVrUM7ZEGxhGGx+Vtc/JapRdMmhQ/R1CzZZEQ+sI2j4dcrucRDuM9v6OKykK9q/zarH/q0XwydEk60SNOrX7xxMAFewZ3Hol6TtvwCDo1spUeauqaCgDQCezBzteEqHrCxg8DkneVEN3efyAHZQ1eP/O1nfWkjPuewp9AhfwJ1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCpjPJ19kmQ6PIMIQ2nm4oQDp6/5FRFhL9+QU8iEYio=;
 b=OMOCf4783yIYjJWlgToPMll1YwFSNbbDpS0jcEhxfz8yH5D5wHSXQWPxQNAY6AKErYS+5Spe3SkOzQGc5xTO8S5nXxSLv6v0SHQIMqBnVXpXv6XQRlP3WhbsFomVCSjDf33kS4/uDqUekqQPWoQhTRb3lwB5zYpzJUsJdNvkLNstxssca10SJnTuDwkR5x4PW9H0ApMhf0hOhauv0LEC0lwqzdxEljaK51KqvCkYDjNx5XJIu28PpGyt2Umc2z/QRuy/kgAfJpHBZ3T97lrlw35BtSWqbJPu0hR+cejQ75nmqbnkKTOVe7lVRvsTv3rKOKBKnJr50U8NcR3vC5aMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by CH7PR03MB7788.namprd03.prod.outlook.com (2603:10b6:610:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:52:17 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Mon, 11 May 2026
 07:52:17 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Topic: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Index:
 AQHc1kn/5d/Hh1H9DE+/jMXiSvhLvbX0U6uAgA5CZsCAAVTVgIAAIEGAgAAYMKCAABGiAIAADdZQgAAbwgCAAXn1AIACljLw
Date: Mon, 11 May 2026 07:52:17 +0000
Message-ID:
 <SA5PR03MB83770D945E92C40A74D9C0DAF6382@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
	<20260427132526.272716-3-liviu.stan@analog.com>	<afCVtXBHIIoLlsRo@nsa>
	<SA5PR03MB83772D8F6A3CC39094DE5241F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af2no3bJA9MSjXvV@nsa>	<20260508121441.39ad9f65@jic23-huawei>
	<SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af3oezNmmBhI4Yu4@nsa>
	<SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af4LCQiqNaiMzFkX@nsa> <20260509154600.02e2d11a@jic23-huawei>
In-Reply-To: <20260509154600.02e2d11a@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|CH7PR03MB7788:EE_
x-ms-office365-filtering-correlation-id: a7667d04-ba14-44de-6329-08deaf32393d
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|38070700021|3023799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 iocSA45Pso6IXPGBsPaFfnCHEujBmCkZsm2tb74dbQMKWuly2M6eHX2Zb/T/VxzQ3uhmNdIp6paMYjJBIlC7rNGWpH+RfKhD/8OIohH93Pb8HYU4BFDIcFVfoymApDfgkYl+XLQnd3I5n8+Puj5BkgkMNthjkEe68YRtllBlW58RBZ8QFwhoZqADCCfoIS6C204SKfFSGEHpZkJURe87bi+xgRN3OHCPgzci9/46nczdW7v6ddxHyb0yqADHk/XzK+Qu3YQfnZqClEoIJPqpJQl0LsoED2xqs8QA5P1yGh9J8VLqXRXP+aFzsjG46EaavyOJ7CuHxKGNyFGJtklYdLMihB1aP88Dx93xBdLJU6ep6yRkCTns9Ut/j+DemIMjtB3ra4OZ14Zt8Ejymd8IO1hXK3/Z31958vgQUn4WcwnvGj+HPXghRQb9GDDkiCG/Hd4KLPzxSDCdjqDhtJTZqEFJJ+cZ5F0zSzVXAfMFASFPjIDXdaUg3nndCeSfnkdrTgcgj7T4dLXrJOj2L8gqqMwvndYRSBWeKLMwGQGc5I1hAmR9FjfjVfJo36X79EvDabAUbT/0clYYk/vTyKLXWn19rHrFAG0VuSJqrzimg/Mw4nXKvY5FFI70TzmcukLXadBmioeYqmlWtDs8FHenD008vYw2rDuQrD+1NUW/819s88sFWo9/XDlV1YXbZ/91sUq6daMBXOEz+uwt9FkPpWgVhuOve5nKVjaqKGWjaGTrf4ZFQql4bnJImIZcN4/L
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(38070700021)(3023799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ty9kQU83NWRGbWV0NEcyK2prdWxqdVp0RktpcWRwMTFlOGcyZEoyaldlNURK?=
 =?utf-8?B?cXE4cndpOWxqS1p0YkJmM1hTSi9aTnFXTG9ha0lOeHE1N05zcHZ2WGQyS1py?=
 =?utf-8?B?OWJjaURpWGRBcTd1STlGVXBVSWxEZlZ5N1o4OFJLdU43QloycStNR3NHeHVT?=
 =?utf-8?B?dUJFZzNCMGtRSVllR2FGRlE3eWNQNmo3TGVpOHd5UU5YeDZITlVuRUIwK2hR?=
 =?utf-8?B?enVtYUV1WnBjaXZZc2xGQkVFM0liak8zLzk5TWJHbzVmRWRFV256OTZ3amxo?=
 =?utf-8?B?UWVLNTZ2aTd0TUQvSTlDNlcrc3RCUnI3enA5SzFzQ2V1UERkd1ZIQ3F2WVdn?=
 =?utf-8?B?VGZqQ1JHQnlkN09hcUliU3VacXRHODVzemg3NTdxTk8zdHJzZnA3bnc3RE44?=
 =?utf-8?B?WEJTWUNXanJ5NEU1Ty9zSi82SWdXc1ZOWW1IL3RRQ0NVbmp0VWxRQjZPaktu?=
 =?utf-8?B?eXBqM1B2N2s2dytCeDE4TWFyOThLYUpVNkNYYk9oVDFTVlR3SUpTaGljTXhC?=
 =?utf-8?B?dVRXZGprOUdSWEpLVVorU0hNTzRTOUFRaVhUbktzR09KdzNOVDJqai9DOWlD?=
 =?utf-8?B?VnExTFc2anVsSVdjOFZLRHh3Wjd2cndQbG0vdFR1WWMxVHljODkxcUhlQVRG?=
 =?utf-8?B?MGIrZWpvWFdZTk0yTlBmcFZ6RTUwNE5CdFczQnhweVF0cjh0NTdva2xBTXVt?=
 =?utf-8?B?aGFIcnRzR2pqbEViU0JWVGp4S2xiNFJCZGQ5Q2RZa2tZZU9OMENndDJ1VXBz?=
 =?utf-8?B?c0tJTjA5SmRmNDNrSHNSTmh1M2pUcnRRbHpXM2NNTmVuWTdxcVRPVFhnenBW?=
 =?utf-8?B?TEpGOU9HV2dOV1llNTlOQkVSNklRMGU2NWpZZlR6ZExaZWlNY2ZCUk9nMnNC?=
 =?utf-8?B?QTFTRXZXSWtUL01NYjN2eC9MalBneFcxbldCSUVaTlhwMUdBaVE5dkJhM3NM?=
 =?utf-8?B?QytEaFBQZGN1MnVwZUtaNkUvbVVocEpxa2VaRHV4dWlvKzhWc0N6V1ZOUlox?=
 =?utf-8?B?LzNPelY4ZnhWMEtNbWlCT0taTWpYcEJsM1dZcUowQVlBandlUkRCQ3czaTRN?=
 =?utf-8?B?MkIrNnErV1lCY0lMRWlGcXpyaXc4Zm5tVGgzTDYzN095TDA4eTZlZnB2NjRI?=
 =?utf-8?B?bnJiK3N4a2VybHF6bDRlY0ZXVjFCbXNKRDh5eHhja3ZvRG1IanEraUVwdVJk?=
 =?utf-8?B?dUNiQ2N5L2hIM0hBWmlrSU9YUlF2WHA4MlF1aURudS91WjdQSFFERHVPN2gr?=
 =?utf-8?B?VDNwUVpjRlkvc3VnblZ6dEcwVWJHYmc3VjVzYVdnY0VwMDNXM2xFWjdxaU00?=
 =?utf-8?B?RWllbVdCblhZNTZINkRZN0ppdE1qNTVPcXhQUmlWbU1adVBBV1JsejlmRXlL?=
 =?utf-8?B?SVNQSTJHUDZCYUY3cStwbFBuKzVtRWlyWDdYNHZtbGR0dzlvMmZoQzVnQkt2?=
 =?utf-8?B?NUdrUGRCenBRV20wMEtRK1ZuZGVrTzEzTU5IQktLMVNTT0h4YXV6RndkYW05?=
 =?utf-8?B?aWp0enZ2UWozaXdXTHgvZ09Jcm5JQ2FuWXlMeHRqbERLdGRwWlMyZ3VmblBu?=
 =?utf-8?B?L0lYM3ZVZVRYNkNoeHAxcjZSZ3pwT2VpTWwzWEFWVmY5OUY2R3B5cHMwdU9i?=
 =?utf-8?B?Q3RYa29mNklJWCthYVp2aWdxdmFVMGFGU2F0MXlqczJ1czlrUjdoeE9uUDk3?=
 =?utf-8?B?S0NaUDhGK2JEUE5jd3hOVG1DRXpOdnEvVjRXbnB1YzJzSGxPb1Y4eU84Q05y?=
 =?utf-8?B?ZVUvdFB5Q21CNEVoOHBPL1JRdTgzcTRSNG95SDhnSjVGQ21ZZ0JRUjRxWTRp?=
 =?utf-8?B?YmNuL2czSWFBT09hZmUwWFo5UHJJenFyb1dyUnZ4cUJkOG1CVnRndmZ0V25Q?=
 =?utf-8?B?N3h0d05UR012NEgzMXBLdm5jdzloYkZmTUx1azczUjVITXN3U2xsajJhcHNK?=
 =?utf-8?B?ZzNEcHFUMWNuSnhsTnhQOEF4eGlScEJuamVORlNNRkVLVWR6R3pmaGh4cjds?=
 =?utf-8?B?cHBKc2Q4Ujg3WWNNK05FeTZ6elY2akxPUGM3M2RLcWlNUVFVeGJER21YWGpn?=
 =?utf-8?B?eDRnbFNMUk5BQzFJQ3NoV1BGcnVjWE83MUcxMGJWUHRSazRHV1JMcFpwVkFZ?=
 =?utf-8?B?TUxYTFZTTlJxQVEzaEtERTcyWmJKYVVQYWhFTDlwSWJUR2Q2dGRHaUdnd2Zt?=
 =?utf-8?B?Z1BzdTFWVzFRRXdHVEZBbTlTWGNZWDFGM0RZQmZjcWZtRzQrUkNUTkZaQnVJ?=
 =?utf-8?B?VGlIMC9tTnhMdGFJOXQ0US81VXJpNWI1RU5nVVFVejNteHlvWEh0Uk1mUlFz?=
 =?utf-8?B?eXRXaXA5RkVyVjdLbUxEU2ttTWJaYnk3dHExWElzeTRGRlA4YzRhZThpUVdC?=
 =?utf-8?Q?LsjB0glQ5uttQcdv81Zup1ZWL5qlt4V7jKnGmF6evazhO?=
x-ms-exchange-antispam-messagedata-1: xcX0XfcD4iVQEg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	NtIrMMONsPlRKgovsK9i2GfkuBZxSnJyL1JLD46clG6j7VStoRCbhCD6F8z1+HId8SmrG2T4Z4E7XwpEyhbLjRthrrIxCceIjUnbnxtcPtlvrPmCTpa8U/Pn5WNID2FR0QFsynNNMbwMKPaTQYX3YiTHAAH4tP4j0gx5jvVPT3goGDDONPuPOyRc/MK5iRvo0Ni9IJBFmlErcssPricqMnL/jp7+TkYTG9Ho57QkW1LP+mWiChBCqD9S5StpjK4lLU4wnftP8RFMq1d/ZZCTXQalxMafb9IyPavBw5zOSLudlWPndIzsVGHMWx7BQu6J95kp08pTuCfUmLBpDzTfRQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7667d04-ba14-44de-6329-08deaf32393d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 07:52:17.6508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYbWDrRgR8KZaJYVPtOKEG9Wyk5f14rXVoITiZIqd/5r32WkSYmaBxvv5buwOZjVEqlgZe2/cICJ5QIgbOczFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7788
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4NSBTYWx0ZWRfXysF8DZQMgC3x
 QuhVTfC6OtXXBOfqRr2lZCKjdG2FKympDViGKdV6R49qyvCVWkK09106u6oF4N8Bn0Qr+NE8cSh
 GnO1ViqbUETxAVWNtFExyN8xf4Jn+tn8DSinp7vsz6nIp3+UX1h/0DOEyMbHOwFZ/FnMSoVwekv
 Mmw7Z1sd8BYv+i7pKiW7Ff71cDUCwpjUx0oSbJqpJT6zODxYcGKSTvaMOKPToKQ78BH5FDD2pdw
 Z+J4MYnE5IbqWb5/AQtT70kQFFOQmSr+pLK+cnZ6s2wB0lI5VYuynAX0mRMnPKdnsEalhtcAPCw
 imJRIL/mLZaW77h1wXVu9K73qzHMtDi46MpqkbGpTKCVUKvDT88T62ANmMrmSkm8yEs0Ge7lFAL
 YpHPYQOqe2Qsf6PKqpkKJTKaP/VHTKuPiwFCtbhfvDakfZX+lnbk1l9c0b4saj3UV1p//pOtUWa
 8M99/NEdsElyOLOtaGg==
X-Authority-Analysis: v=2.4 cv=b7mCJNGx c=1 sm=1 tr=0 ts=6a018ab4 cx=c_pps
 a=QA4htdGqYz999Ta5EyqdmA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=6uuS2Hb84ZVUaToxOeQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ohG9buQbJxKMN5hMqkDxSd4vc26ZAU4e
X-Proofpoint-ORIG-GUID: ohG9buQbJxKMN5hMqkDxSd4vc26ZAU4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110085

T24gRnJpLCA4IE1heSAyMDI2LCBOdW5vIFPDoSB3cm90ZToNCj4gPiA+ID4gQSBsZWFrIGRldGVj
dG9yIGlzIGEgc2Vuc29yIGxpa2UgdGhlIHJhaW5kcm9wIGRldGVjdGlvbiBtb2R1bGVzLCB3aG9z
ZQ0KPiA+ID4gPiByZXNpc3RhbmNlIGRlY3JlYXNlcyBhcyBtb3JlIG9mIGl0cyBzdXJmYWNlIGlz
IGNvbnRhY3RlZCBieSBsaXF1aWQuIEluIHRoaXMNCj4gPiA+ID4gY2FzZSwgZm9yIGV4YW1wbGUs
IGlmIGhhbGYgb2YgdGhlIHNlbnNvcidzIHN1cmZhY2UgaXMgaW4gY29udGFjdCANCj4gPiA+ID4g
d2l0aCBhIGxpcXVpZCwgdGhlIEFEVDc2MDQgc2hvdWxkLCB3aXRoIGFuIGFwcHJvcGlhdGUgdXNl
ci1wcm92aWRlZCANCj4gPiA+ID4gcmVzaXN0YW5jZS12cy1jb3ZlcmFnZSB0YWJsZSwgcmVwb3J0
IDUwJSBjb3ZlcmFnZSBpbiB0aGUgSUlPIGNoYW5uZWwuDQo+ID4gPg0KPiA+ID4gQW5kLCBBRkFJ
VSwgZGVwZW5kaW5nIG9uIHRoZSBjb3ZlcmFnZSB0aGUgcmVzaXN0YW5jZSBjaGFuZ2VzIGFuZCB0
aGF0J3MNCj4gPiA+IGhvdyB3ZSBnZXQgaW50byB0aGUgaW5kaXJlY3QgdGVtcGVyYXR1cmUgdmFy
aWF0aW9ucz8NCj4gPg0KPiA+IElmIEkgdW5kZXJzdGFuZCB5b3VyIGNvbW1lbnQgY29ycmVjdGx5
LCB5b3UncmUgaW1wbHlpbmcgdGhhdCB0aGVyZSBhcmUNCj4gPiBpbmRpcmVjdCB0ZW1wZXJhdHVy
ZSB2YXJpYXRpb25zIGNhdXNlZCBieSByZXNpc3RhbmNlIGNoYW5nZXMsIGFuZCANCj4gPiB0aGF0
J3Mgd2hhdCB0aGUgY2hpcCBpcyBtZWFzdXJpbmc/IFRoZSBjaGlwIGRvZXMgbm90IG1lYXN1cmUg
YW55IGFjdHVhbA0KPiA+IHRlbXBlcmF0dXJlIGZvciB0aGlzIHNlbnNvciB0eXBlLCB0aGUgdmFs
dWUgaW4gdGhlIHRlbXBlcmF0dXJlIHJlc3VsdCANCj4gPiByZWdpc3RlciBiYW5rIGlzIHNvbGVs
eSBhIHJlc3VsdCBvZiB0aGUgY2hpcCdzIGludGVycG9sYXRpb24gb2YgdGhlIA0KPiA+IHVzZXIt
ZGVmaW5lZCBjdXN0b20gdGFibGUuDQo+DQo+IEkgbWVhbnQgdGhhdCdzIHdoYXQgdGhlIHRhYmxl
IGlzIHRyeWluZyB0byBhY2NvbXBsaXNoPyBUaGF0J3Mgd2h5IEkga2luZA0KPiBvZiBwdXQgaXQg
YXMgImluZGlyZWN0Ii4gTXkgdW5kZXJzdGFuZGluZyB3YXMgdGhlIGNoaXAgZG9lcyBub3QgbWVh
c3VyZQ0KPiBhbnkgdGVtcGVyYXR1cmUgYXMgd2VsbC4NCg0KT2gsIG9rYXksIEkgdW5kZXJzdGFu
ZCBub3cuIFllcywgdGhpcyBpcyB3aGF0IHRoZSB0YWJsZSBpcyB0cnlpbmcgdG8gYWNjb21wbGlz
aC4NCg0KT24gU2F0LCA5IE1heSAyMDI2LCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+IEkg
bWVhbnQgdGhhdCdzIHdoYXQgdGhlIHRhYmxlIGlzIHRyeWluZyB0byBhY2NvbXBsaXNoPyBUaGF0
J3Mgd2h5IEkga2luZA0KPiA+IG9mIHB1dCBpdCBhcyAiaW5kaXJlY3QiLiBNeSB1bmRlcnN0YW5k
aW5nIHdhcyB0aGUgY2hpcCBkb2VzIG5vdCBtZWFzdXJlDQo+ID4gYW55IHRlbXBlcmF0dXJlIGFz
IHdlbGwuDQo+ID4NCj4gT2suIFNvIHdoYXQgYXJlIG91ciBvcHRpb25zIGhlcmU/ICBQcmVzZW50
IGl0IGFzIHNpbXBsZSByZXNpc3RhbmNlIGFuZCBsZWF2ZQ0KPiB1c2Vyc3BhY2UgdG8gZmlndXJl
IGl0IG91dCBvciBhZGQgYSBuZXcgY2hhbm5lbCB0eXBlPyBUbyBtZSBmZWVscyBsaWtlIG5ldw0K
PiBjaGFubmVsIHR5cGUgbWFrZXMgc2Vuc2UuDQoNClRoZSBjdXJyZW50IGFwcHJvYWNoIHByZXNl
bnRzIGl0IGFzIElJT19URU1QIHNpbmNlIHRoZSBjaGlwIG91dHB1dHMgY292ZXJhZ2UNCih1c2lu
ZyB0aGUgY3VzdG9tIHRhYmxlIGludGVycG9sYXRpb24pIHZpYSB0aGUgdGVtcGVyYXR1cmUgcmVz
dWx0IGJhbmssIG5vdCB0aGUNCnJlc2lzdGFuY2UgYmFuaywgYnV0IEkgYWdyZWUgYSBuZXcgY2hh
bm5lbCB0eXBlIG1ha2VzIHNlbnNlLiBTaG91bGQgSQ0KY3JlYXRlIGEgc3BlY2lmaWMgdHlwZSBs
aWtlIElJT19DT1ZFUkFHRV9QRVJDRU5UIG9yIHdvdWxkIGEgZ2VuZXJhbA0KSUlPX1BFUkNFTlRB
R0UgYmUgYmV0dGVyPw0KDQpUaGFua3MsDQpMaXZpdQ0K
