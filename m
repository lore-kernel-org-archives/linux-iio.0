Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B4372068;
	Tue, 12 May 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588801; cv=fail; b=noU18Yvgw0mMwFvoBYhmOpXScQZX2OpGBefX4KMCBYrndN2y25qBhWsc842goVE1xTQFFAOg6moFoVDtHsyePzu4yminPiddVf0F+A0197ltox0dgAoLGdJZ1JZ9OofXUopPNebvszEwTxXuI1AlnfVTKryLYcU4u2wk5wevYd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588801; c=relaxed/simple;
	bh=40j7HYGnP26aIW4aXm5PqrocI4R6p85QDOHN6TpFWs4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TKWINOyaM8jJCqrx7XRQBKQmK2sXsazvNXkZLPj/XAThicI2zPbMVzad7GutVv79xEBTDEt/88dJ82TT7ArHV9Xbs9H19ETRVm1eRsCe9V06vRLWvtY09xFMTZN6PHUeXOmi4D1B39DHEg9VYoJcP3DMkioh1z1ZJ35HlP/63UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uLKGzdLg; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uLKGzdLg"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C8D9aZ1982044;
	Tue, 12 May 2026 08:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=40j7H
	YGnP26aIW4aXm5PqrocI4R6p85QDOHN6TpFWs4=; b=uLKGzdLgitRVaLxe69prb
	YFRF+DEmkiK5UR+xR5lhbRQDSj+ZOKZDJTd4M24qwLcXd+XOi46xX1B6wuInxye6
	RLCziyI8jcv5NArkCiOnV1o5KxhgOuw9JUcoiViWNB3qbPti3+TBfbKEtnB7Opre
	1VkfakODq8sDZjREjGHLmeuhBYx1FomBP2nQQrLS+JUrwABKwNlYyRB/huQLR9Nm
	11+iVsVyQyfgZFwCU2/19P2kzvSkdVn95St9pSsElc/keRoj/ly9Srsamqa2PtSC
	KT+xD5RmxC34unlupMazSOKY8/ZKwiugD6mcWYBQA8QJh40zAa110cLmiJtT8tvm
	A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e3nwa2u6a-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 08:26:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lADP2xboPeLwpmUGxJ1A0tgfNTFyVZWQ/DsdR2gC6gmtfPqqkLAhQdI8IqWIOY7uzhcrE7DI4YAeHXUkfNwT990YpDQojuXlvnh3zJiMvMuKfWpg3ciGcc5cGpLFI6gL6XjiGObt/dCcZgbZuFam+fFIvKg8aohVzi0JsX5gK6Q6I1BLlC/Ua/U4uBXiJ+kpd2+MHsQPwN+adwA8ZQEXSDNWxJU9EI6uaaPA+5dANIjEWxxvj7HAx3tf45NCa/TB4IGYhjvFxXlWaowtNBaNNkaRWYDKZ3gNEWOciYZuXxipQR+3skrGpjnpriH+Kbq89w9z1wCUSTaQnPcuNdqcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40j7HYGnP26aIW4aXm5PqrocI4R6p85QDOHN6TpFWs4=;
 b=l2xUQV04Qe58D7ySG7+KfuVjZh9Hbsx/7/dc505oxXJTLvogufrawK+4/1yYb6t7P3pRlTeH2zmTPhm5lLrUDrGajQfGu4R5OYJaY8/GHPFH3cO47S03CZVt+U/6r73gho6nDl2OyxHHrf84fYgqJWlCzmncgE/ykhnjmukpoH4DK7Rp9qzyfvGb57jLlAhDFdOU1C/Uaj+FSRyc9DoHhpq8V6c9SwNIlZWTJajvJZQ3XlNwwhtuGAUFsdIOX+7FhbbivlOWZVeox+N/7ykdHgc3yYhgHbSuEkMqpv+kPscaCuP1cpjt965EStBjlpKvQYV49Kgu8VOq0cR0FrSu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by MW4PR03MB6992.namprd03.prod.outlook.com (2603:10b6:303:1bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 12:26:02 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Tue, 12 May 2026
 12:26:02 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>
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
 AQHc1kn/5d/Hh1H9DE+/jMXiSvhLvbX0U6uAgA5CZsCAAVTVgIAAIEGAgAAYMKCAABGiAIAADdZQgAAbwgCAAXn1AIACljLwgABUcgCAAArCQIABVv6AgAAduqCAACA9AIAAAqvA
Date: Tue, 12 May 2026 12:26:02 +0000
Message-ID:
 <SA5PR03MB83776E4DF7B5542B40C3B925F6392@SA5PR03MB8377.namprd03.prod.outlook.com>
References:
 <SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af3oezNmmBhI4Yu4@nsa>
 <SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af4LCQiqNaiMzFkX@nsa> <20260509154600.02e2d11a@jic23-huawei>
 <SA5PR03MB83770D945E92C40A74D9C0DAF6382@SA5PR03MB8377.namprd03.prod.outlook.com>
 <20260511121820.3be9e635@jic23-huawei>
 <SA5PR03MB83772A1A57DC052CB21B9187F6382@SA5PR03MB8377.namprd03.prod.outlook.com>
 <agLhb-S2ISSjaopc@nsa>
 <SA5PR03MB837758532C0007A97121F6CCF6392@SA5PR03MB8377.namprd03.prod.outlook.com>
 <agMXiWA39tW9mZ2O@nsa>
In-Reply-To: <agMXiWA39tW9mZ2O@nsa>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|MW4PR03MB6992:EE_
x-ms-office365-filtering-correlation-id: 52757dd3-b77d-4faa-f08b-08deb021a18a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003|38070700021|3023799003|11063799003;
x-microsoft-antispam-message-info:
 MAEuTWo+66jmrz42LV3k0BLc5740p3H0VI3Hz/EYARo4fBu5/EGI1WfyWYm5qWFtCzQK3HanTEyOzLBx4UANdTeNTZEuZnyRETZHRWbSJr/P/u7Q6KulC34F6Vz/hoLA8HUtyG8tqHwr6hkvGMWTIM65P++yAaHjuQHNvwfYzZ7qH7uPz7ZOV3AdQ5adp7415vMgvraW4c+EdxPGNtZnQGVAOnbh4hNX6iqy5jlML5HwMY3HlHTkiNDP1/DDFw73Ku09M9xPOfAEctk4aaKRLh4Solnpn/2mYrZ59HpB42ex5YKTtxag8+L99FUv6gHYi1+j3bJv9EDJW7LsWaDsSDJ2rYDG2dHWonzf1UCe8WGSB2U5VmlvC0VjAwpbPxRf5DEPmsWx93wHKkap1c5xu4RGgI9ZyxA8pdbE8qmSTtV7yjl200sHr1hs6Mn8du7LhoDduvXc+ROvmOZCEKK/OFxEpj5PfJlRHnnHoxzj+rohYwvTMWIi6ugWT3VuJSGKxXPy9RJBX7nnnrsGVwjyfaDCdQyeWPKT62UPuLstFB8zkihrIRQXERheei2Y+ugyYidUgAhcYobM0IO4ov4vE5dR4eqTA4zeYdR0evIG/khz0h8iv3QkJvVHMyBwIYm8q5g6pGM0mYveek3SUlOQ2RzORXlLQ3Onap6mQOv/7xc4q+jY9fz2osWzbFlb1ueo4dYjxWbaBRxWEkW7rxfvUWJHgAbYvhLnhjS3UW0/cXp8jO2DiuYBuHMT1522NDWT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021)(3023799003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UllTNmMwcGdZSzRnaThHZjIwM0ZqU3RkR2gyQTQ1dnJFTExMVjV2ZXhxVTZu?=
 =?utf-8?B?SzJ3empkTTMwY1lzYTVNaU5HN3RmOXBWNnNrU2tnOXRoaGkyS0ljZ1A1NnYv?=
 =?utf-8?B?eXp2M3BPekFvME9hblBDTG11bmZVMzdFckVzQVh0NWVBME9jWlZ0NWRWRzB5?=
 =?utf-8?B?SmdIUllFU04wWk5xQnlYM2c5dWIvVmRGNjd6L1B0QWRsMVpvUGF6dGVUcWFE?=
 =?utf-8?B?bzV3bFlLSExMS2lzNlRPTzJVd0s0dVFJWEFrR3NTbWg4djd6ZUN1M1k1M1dG?=
 =?utf-8?B?cDJrUXJTU0Z4d0hlMnUrdEYrN0tzY2dHbXFQcGxNU3Z0ZUJOV1FwdU8va3ps?=
 =?utf-8?B?Z0YyNXJOZU5GMWhhQzA1aUtVaHR2czVEMlBOQ2V1bGQ4bERjeFhhREZnQS84?=
 =?utf-8?B?cmRzYXBFYUNOTzY1Zk9Yb2daSWxHQTZzc0w3eitTTGJ5MEdzejRqZCtuOFBu?=
 =?utf-8?B?Q0ZkaHJCTWxOWDNYMjRRaEIyMkJBT3hmNWxEbW9UNVdsZkdaUXJmYnVhOGt3?=
 =?utf-8?B?cEZmbTNBVWZ4ajduVlBES0FXMUZkMkR0TkdxZWtxSzlITS9UdTJZSGNmaGNJ?=
 =?utf-8?B?YXFNY3p1ZEFPNktxVFF2aW9CNEtlZG9vcDhQTER2ZUh5WGFtcFhidW45Z1FG?=
 =?utf-8?B?U21OZzlBc1dhSlFKQ21oREd3UVFQK2hlYlgzMVUraXVkbktHd2VVd1VMY25l?=
 =?utf-8?B?aWZKbDk2aEo5RUFTRDBTSndBUnk4MVdzUlF4dDloWG5Uc0VLekx1V2VPUm1L?=
 =?utf-8?B?Ymx1LzB4NmM5dzFYRDM5OEtnSjRqMElYUzBLT3dxamdxMmovYVRtNVhlNnlG?=
 =?utf-8?B?RmdBcUNwalZBd1h6ME5SdUVpNGFjMXVtbDdEZzBkVDRZVW4wekxBTGZ2Ykln?=
 =?utf-8?B?dElya0oxQjFLYk54eGx2WEhmV0UyQUVFcndLUDRLTHhMNHFLOTBqb3I3RGI4?=
 =?utf-8?B?SmIrcytnM0tpaUwxajdPRWhlMWFZMytKenBDZ0doay9GdzRWMXlzWnBjRXZF?=
 =?utf-8?B?eEdWZkpSWEcyT2lGVkd0bmQ3VVJHV2pVQXJCd1ZSY05vbVV2cVBqMS9ORXFj?=
 =?utf-8?B?WWN5Rzg1ZHA2bUZOdDBMUHBFZG1RcWtldUJjaGcxUTAzV0hiMmRTQnNOUHdB?=
 =?utf-8?B?R283NUhYMUdBblgvUWZIN2JNSDB5ZzFOQXZPcC9iQ1pWUzJ6TnZXVldpREJY?=
 =?utf-8?B?YjlkMEg4cUxra3VsSFBsM2l6cjFCdXVkdi8rNDJyRUFuWFJscUwzWVNMWERN?=
 =?utf-8?B?b29ubWFaMHlmY0x6VDlpcUlhcG93RmdZS3pmclMvUmNmQzJPWWprd3JRNERj?=
 =?utf-8?B?SExOeHorU0p0cVk1alVmcFh2MS9pcVZRMXE1SGRvVWNJVTk5aDlwZDN6LzF1?=
 =?utf-8?B?dXVFMHVSTjJnZm1ka3JTajN4NGQ4akZweFNuVHdVUmJwL0kxazBxK2tHMDQ1?=
 =?utf-8?B?UUZKY28wMVhTQlEyc1hTTWJXckovb1cxWXBqUEx5dHhXTHJlU1JwY3hEMkUv?=
 =?utf-8?B?N3lWMXlQS2gyUVB1a3JzOGdSMFhhWDROYmdqVnRTa2x6WWxzMVB5dEhIU0E3?=
 =?utf-8?B?eFdlc1AycHVHRUY3T0dyaFNuWC80amdOUWYyUzFxNVFkL1dHdGlLU0V1Mjgx?=
 =?utf-8?B?MTMvdzBVeWVtQjU1ZFNldzdhWjVUSzRCZklpdWdRL0xmcUtTT0ZRRFU5Njlt?=
 =?utf-8?B?ODlnTnh0K1l4dEVsNmRRT2RkZTBsczBxdVV4VmxiMWZTQWkydjFadDFXTE41?=
 =?utf-8?B?S1dBZ2d0RFU1TnVWbFFHV0FoMXZSQmh1Y1AzZFZETkRWTWk4VU5ab2NyYVpP?=
 =?utf-8?B?N0YwalN6TVVDNmZTMWcvQVNYNnBueFBEK3AvQ1A4MlkxSnlNcG9NOXhINnJ6?=
 =?utf-8?B?QzNGQ01EbFdvRkd5OFpITGVVWGNiT0twTW81WUNkakdxajZac1NqRHpyQXYw?=
 =?utf-8?B?em92dnBmd2FVNzlqV2tKbGtpZTZDbTBuTnV4bkJCRzBxM0p4MGpuMXo2Wkov?=
 =?utf-8?B?OE9jUkVETTQxQzNSSXNLSlQ3V1RZdHlneTdlVTM1ejh1dkdQZE5nbVZMZndJ?=
 =?utf-8?B?NFQ3NDk3ZmdNamc4Z0pyb3JUME4xb3dCb0hnN2htSTF1eXlZTHNESWhvTEIr?=
 =?utf-8?B?ZmQyQ25RU2ZLVksxZTdTdjdEQkw1cnJ3ZVMyZkFqVkJEOGRzYUdHTXZ4WWVo?=
 =?utf-8?B?Mlp0bVg1USt1cTdTUmY2aHRsNURVb2JDeERxTFVYVGtaMVRUZ1BOWDRWU0pB?=
 =?utf-8?B?bGtSRk1CTEluS0dJR1hrTWpsay9zRjRGdUtEREtPL0tYQWZyZmpvSEQ2UURh?=
 =?utf-8?Q?IfKLYsSviriAGgLKPH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LIr5R/c9AJPjA3KPkXfumJxj2GEn87iKzH0jZDarBxgL7ybfh+lB6nak7Mvky3bDCB3jY2qeT/Rfud0uK1M4GHQ8LFKf7Jl7vzuYRO5Rdt2J7XU5fSqs7hNKyy7OPdJ/Dqhxr+LO3Wuesh72if/hW0lyb9WCNP2Z9H5k76rp1CTsfZA8zTx35/nW3ylDkzf1xIB9aFStIT2WiT5jekqbFIgNrfbWpv2vFn8e7oGAXbbFDDqhN+7pv3FajLULhtSHN6qEt44PQ+fddIgYOEP0HBfiykienpJNVNBnFMk9bBjYAv75fKCuDPTy6wRBOMuAmTcG4DTbUN+h2qnH3ggoIQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52757dd3-b77d-4faa-f08b-08deb021a18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 12:26:02.3210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPOvYTDyilC2BFMu3BFLyy4gTCpX1HvgCxJaSvO9or8PFZonXD/9SdRRxpn5Le7Cntj1+T+Q33SWFsfE/+ZZVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6992
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyOSBTYWx0ZWRfXzs4jDOFxejKZ
 lXl4RuOGHHB7L6C63UgJAWEw5o7Boo8viukvgtKdwBo97OagSP2f5+um4PPs5nGC6ggbUCZNXbt
 JI7N4QD1o7no1o/4WQbfsfXHH2Qa95ZAD11jKwneRHLlJpdq8+LixLDJ52i/esf5EpvG7OBJXlk
 JtoV3lCVFiHiNQJPL2DCdg7G3FySWf4CwzrHl04MKs0piGmycNdTYTB5kpYqnXdi5hbX/eqeI+J
 Vbv4lSxosT6CAqIH3/TtRJnLVon6p9u8xOgPOtyvAQTkkCqR4wGKfgwF/tCVJr1lj7nlc0l72eO
 QMOa0TwykXHWD53Con7rjWxsA8fw6AQ7Y49ydUIi+ZayghBeJWRpls3dYZW7VkO+v+3js5Z7orQ
 lj4e7IZi+BEzMI4nxsTQTgFWigC+rxqi/9hhMCCImrUVC2jH2qP8wRJUN6nqjApC1p8k+vCsEBN
 xtvcRlE0230aPu667rg==
X-Authority-Analysis: v=2.4 cv=WLxPmHsR c=1 sm=1 tr=0 ts=6a031c5e cx=c_pps
 a=UZZKR2DsB1PZv1vhPkDPDA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=JXGNztmYqp5fpL7yH2EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nlcnY9fILe8PNpiWORno_iAUI52x4pLE
X-Proofpoint-GUID: nlcnY9fILe8PNpiWORno_iAUI52x4pLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120129

T24gVHVlLCBNYXkgMTIsIDIwMjYsIE51bm8gU8OhIHdyb3RlOg0KPiA+ID4gV2hhdCBJJ20gbm90
IHRvbyBjb252aW5jZWQgaXMgdGhhdCBjb3ZlcmFnZSBpcyByZWxhdGl2ZSB0byB3aGF0PyBXZWxs
DQo+ID4gPiBpdCdzIGEgcGVyY2VudGFnZSBzbyBJIGd1ZXNzIHdlIGNvdWxkIG5vdCBjYXJlIGFu
ZCBsZWF2ZSBpbnRlcnByZXRhdGlvbiB0bw0KPiA+ID4gdXNlcnNwYWNlICh0byBrbm93IHdoaWNo
IGRldmljZSBpcyBkZWFsaW5nIHdpdGgpLiBTdGlsbCBJIHdvbmRlciBpZiBhDQo+ID4gPiBuZXcg
aWlvX2NoYW5faW5mbyB3b3VsZG4ndCBiZSBtb3JlIGFwcHJvcHJpYXRlPyBJbiB0aGlzIGNhc2Ug
YXBwbGllZCB0bw0KPiA+ID4gaWlvX3Jlc2lzdGFuY2UuIFNvIHNvbWV0aGluZyBsaWtlOg0KPiA+
ID4NCj4gPiA+IGluX3Jlc2lzdGFuY2VfY292ZXJhZ2VfcmF0aW8NCj4gPiA+DQo+ID4gPiBTbyBp
dCdzIGNsZWFyIHdoYXQgcGh5c2ljYWwgcXVhbnRpdHkgY292ZXJhZ2UgcmF0aW8gaXMgYWZmZWN0
aW5nLg0KPiA+DQo+ID4gSSBzdGlsbCB0aGluayBhIG5ldyBjaGFubmVsIHR5cGUgaXMgdGhlIHJp
Z2h0IGFwcHJvYWNoLiBDb25zaWRlciBjb3BwZXINCj4gPiB0cmFjZSBzZW5zb3JzIC0gdGhleSBh
bHNvIHN1cHBvcnQgYSBjdXN0b20gdGFibGUsIGFuZCB3aGVuIG9uZSBpcw0KPiA+IHByb3ZpZGVk
IHRoZSBjaGlwIG91dHB1dHMgYm90aCBhIHJlc2lzdGFuY2UgcmVzdWx0IGFuZCBhIHRlbXBlcmF0
dXJlDQo+ID4gcmVzdWx0ICh0aGUgaW50ZXJwb2xhdGlvbiBvdXRwdXQpLCBlYWNoIGluIHRoZWly
IG93biByZWdpc3RlciBiYW5rLiBUaGUNCj4gPiBjdXJyZW50IGFwcHJvYWNoIGhhbmRsZXMgdGhh
dCB3aXRoIHNlcGFyYXRlIElJT19SRVNJU1RBTkNFIGFuZA0KPiA+IElJT19URU1QIGNoYW5uZWxz
LiBTbywgZm9yIGNvbnNpc3RlbmN5LCBpZiB3ZSB1c2UgYSBjaGFuX2luZm8NCj4gPiBhdHRyaWJ1
dGUgZm9yIHRoZSBsZWFrIGRldGVjdG9yIGNvdmVyYWdlIG91dHB1dCwgd2Ugd291bGQgbmVlZCB0
byBkbw0KPiA+IHRoZSBzYW1lIGZvciB0aGUgY29wcGVyIHRyYWNlIHRlbXBlcmF0dXJlIG91dHB1
dC4gU2luY2UgSUlPX1RFTVANCj4gPiBtYWtlcyBzZW5zZSBmb3IgdGhlIGludGVycG9sYXRpb24g
cmVzdWx0IGZvciBjb3BwZXIgdHJhY2VzIGFuZA0KPiA+IGJlY2F1c2UgaXQgaXMgYSBkaXN0aW5j
dCBwaHlzaWNhbCBxdWFudGl0eSBvdXRwdXQgYnkgdGhlIGNoaXAsIEkgdGhpbmsgaXQNCj4gPiB3
b3VsZCBtYWtlIHRoZSBtb3N0IHNlbnNlIHRoYXQgbGVhayBkZXRlY3RvcnMgZm9sbG93IHRoZSBz
YW1lDQo+ID4gcGF0dGVybiBhbmQgY3JlYXRlIGEgc2VwYXJhdGUgSUlPIGNoYW5uZWwuDQo+ID4N
Cj4gPiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gPg0KPiANCj4gWWVhaCwgbWFrZXMgc2Vuc2UuIEpv
bmF0aGFuIGFscmVhZHkgcHV0IGl0IHZlcnkgbmljZWx5IGZvciB0aGUgZGlzdGluY3QNCj4gY2hh
bm5lbCBjYXNlLg0KDQpTb3JyeSwgSSBzYXcgdGhlIGxhc3QgdHdvIG1lc3NhZ2VzIG9ubHkgYWZ0
ZXIgSSBzZW50IG15IHJlcGx5Lg0KDQpPbiBUdWUsIE1heSAxMiwgMjAyNiwgSm9uYXRoYW4gQ2Ft
ZXJvbiB3cm90ZToNCj4gPiBJIGRvIHdvbmRlciBpZiBhIGNvbXBsZXRlIHR5cGUgaXMgd2hhdCB3
ZSB3YW50PyBIb3cgd2lsbCB3ZSBwcmVzZW50IGl0Pw0KPiA+IA0KPiA+IGluX2NvdmVyYWdlX3Jh
dGlvPw0KPiA+IA0KPiA+IFdoYXQgSSdtIG5vdCB0b28gY29udmluY2VkIGlzIHRoYXQgY292ZXJh
Z2UgaXMgcmVsYXRpdmUgdG8gd2hhdD8gV2VsbA0KPiA+IGl0J3MgYSBwZXJjZW50YWdlIHNvIEkg
Z3Vlc3Mgd2UgY291bGQgbm90IGNhcmUgYW5kIGxlYXZlIGludGVycHJldGF0aW9uIHRvDQo+ID4g
dXNlcnNwYWNlICh0byBrbm93IHdoaWNoIGRldmljZSBpcyBkZWFsaW5nIHdpdGgpLiBTdGlsbCBJ
IHdvbmRlciBpZiBhDQo+ID4gbmV3IGlpb19jaGFuX2luZm8gd291bGRuJ3QgYmUgbW9yZSBhcHBy
b3ByaWF0ZT8gSW4gdGhpcyBjYXNlIGFwcGxpZWQgdG8NCj4gPiBpaW9fcmVzaXN0YW5jZS4gU28g
c29tZXRoaW5nIGxpa2U6DQo+ID4gDQo+ID4gaW5fcmVzaXN0YW5jZV9jb3ZlcmFnZV9yYXRpbw0K
PiANCj4gSSdtIHBlcmhhcHMgbWlzc2luZyBzb21ldGhpbmcgLSBhcyBmYXIgYXMgSSB1bmRlcnN0
YW5kIGl0IHRoZXJlIGlzIG5vIG1lYW5pbmdmdWwNCj4gY29ubmVjdGlvbiB0byByZXNpc3RhbmNl
IGluIHdoYXQgaXMgYmVpbmcgbWVhc3VyZWQuDQo+IEkgdGhpbmsgd2hhdCB5b3UgYXJlIHByb3Bv
c2luZyBpcyBzaW1pbGFyIHRvIG1lYXN1cmluZyBjdXJyZW50IHZpYSB2b2x0YWdlDQo+IGRyb3Ag
b3ZlciBhIHNlbnNlIHJlc2lzdG9yLiBXZSBkb24ndCBwcmVzZW50IHRoYXQgYXMgbW9kaWZpZWQg
dm9sdGFnZSwgd2UNCj4gcHJlc2VudCBpdCBhcyBjdXJyZW50Lg0KPg0KPiBIZXJlIHRoZSB0aGlu
ZyBiZWluZyBtZWFzdXJlZCBpcyBjb3ZlcmFnZSByYXRoZXIgdGhhbiByZXNpc3RhbmNlDQo+IHNv
IGtlZXBpbmcgcmVzaXN0YW5jZSBpbiB0aGVyZSBpcyBjb25mdXNpbmcgZm9yIHRoZSB1c2VyLg0K
Pg0KPiBJZiB3ZSB3YW50ZWQgYSB0eXBlIHRvIG1vZGlmeSB0aGVuIHdlIGNvdWxkIGRvIHRoaXMg
YXMgYSBtb2RpZmllZCBhcmVhIG1lYXN1cmVtZW50Lg0KPiBDaGFubmVsIHR5cGUgSUlPX0FSRUEg
KHdoaWNoIGlzIG5ldykgYW5kIG1vZGlmaWVyIElJT19NT0RfUkFUSU8gKGFsc28gbmV3KS4NCg0K
T24gdGhlIGltcGxlbWVudGF0aW9uOiB5b3Ugb3JpZ2luYWxseSBzdWdnZXN0ZWQgSUlPX0NPVkVS
QUdFX1BFUkNFTlQsDQp3aGljaCB3b3VsZCBnaXZlIGluX2NvdmVyYWdlcGVyY2VudDBfcmF3IGlu
IHN5c2ZzLiBUaGUgSUlPX0FSRUEgKyBJSU9fTU9EX1JBVElPDQphbHRlcm5hdGl2ZSB3b3VsZCBn
aXZlIGluX2FyZWEwX3JhdGlvX3Jhdywgd2hpY2ggaXMgbW9yZSBnZW5lcmljIGJ1dCBsZXNzDQpp
bW1lZGlhdGVseSBvYnZpb3VzIGZvciBhIGxlYWsgZGV0ZWN0b3IuIERvIHlvdSBoYXZlIGEgcHJl
ZmVyZW5jZSANCmJldHdlZW4gdGhlIHR3bz8NCg0KVGhhbmtzLA0KTGl2aXUNCg0K
