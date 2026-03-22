Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0095713B7A3;
	Sun, 22 Mar 2026 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774206985; cv=fail; b=VHUCb/Pp7dnuczK2HETMEJEuqkEqX1NW4VwyznDKN5bax2EjJrLfBV3JWTrKsXLluyRVY5kXUBCillMdmZkwon9ERbgSS3fthoBTEgiPyXmgLlKR5IEv15qzCsaj53ddOGZT1165c7KBXZ7P9vTOWzo3tXemhL5EuxXAiyXxeMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774206985; c=relaxed/simple;
	bh=TIlWZ1Yv+8sr7sRUsGWwaV0ww12vvhDTeSHzHfaD1jo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dqE5Q1eDZg1F67o4ReWwLq0cFasNOoi7fJ4v04BGELdxFyrVCU7kswBv7H4s3/kGapKQeHOmsJR13Wz3lxQWxq5CrsZixuQNNOKsgFaolsuCe6uHT/lPP+CqufVhfc7Txw8zY1uALsj9ZFOcKcX6U3MncqqDWuRlNCNYcRm7P1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ucnn04Cl; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ucnn04Cl"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62M7JN7d2430411;
	Sun, 22 Mar 2026 15:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TIlWZ
	1Yv+8sr7sRUsGWwaV0ww12vvhDTeSHzHfaD1jo=; b=Ucnn04Cllg/Z5pEi8s2xh
	+6JZ9DCIEcE1hAbaIOPvD7JOPMeDze8AIwtfFqi1tpPBBdx1MOoHfaB9XhNpE/DE
	uAuMCOGj+5Ct62/oS35BOCxJ5eC6zwY38r3D6GtyH4db2LVFqBxw9MGQetTvxFBS
	q8+XsGRc7Jq1fbSqnOV99N0aW+/zI4PFyviHxdld4ZLN9WdUpXLKWkUPjaKMlKCi
	OixqW8eV6GRmurkOr9U0H2BfGboGjBUAYCT0IOpUXPPi2BhlKxmxkn8VYrsNTOhl
	qEBBDqNISIMQ3mipv1delunlrJULOw3k9Z2YfMSZlCXpY0DvSd5Ge8wO1QDF78Jj
	Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d2bxe90jh-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Mar 2026 15:16:02 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbThuyaY28pNZ5ZSKYuYI7PlBFBv1dIuyrI6wYZIFA6EPQBH16D/uVsFwq5HgUDk/KUJePhPW2Q05FAX3PmXvY3IEy4PLv6fU18wk43WCnjtiO9JzZy+0ZoGUiusFieBzfWHMu1kdE6B25QPyKf6PHwc1GYcfiX72/6gc63Y901OSJS7f2o/Ox1ijCaQfNYCvDQeEvUZGgWPIleC7y1bcWdnq3ibmn0MadoNhcrz+qxuVBA1WYfOY/zuwf41dVrxubS1TxzNTiLKfQs+HAh5AZMYBjBpaLxiuJrgpjE+y9K0HdFQgQ8dqL+Nl2KVI0Ld/amAw0cGE9otnV5xsuHl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIlWZ1Yv+8sr7sRUsGWwaV0ww12vvhDTeSHzHfaD1jo=;
 b=Bwvb1MjeMCp4USvcp1VTD8ZpQOWfa485FKqlEHmhHX1Rgei54UdAmkUMZblJlHTdFA3zmnFdjN95DlWZg9nZg47gsZvkKbRYBzyrRV03dI0uqGrkm0Cf9Pu+YeOYG+NCDbPaxUUakcQI34NP/6ScwZLmhGznfeck4dmcpYG7w2MHfihr/QqYaxA6b150USpww7bJKm8O30TeyOq8AoDVpMD+OiVSBrWhRvEtFwhzmXtcgkrYx5GOv7rvYlVzahGQq4YBFx4UkXV8tpuiryb3WO9LeJyaqKhAxSlmP4CNUlZCD6IoaGtPmOl62DdHLjANaA2avxDxtciVPbdMQO9X1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DS0PR03MB7292.namprd03.prod.outlook.com (2603:10b6:8:12c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sun, 22 Mar
 2026 19:15:48 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%4]) with mapi id 15.20.9700.025; Sun, 22 Mar 2026
 19:15:58 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Thread-Topic: [PATCH v7 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Thread-Index: AQHcuRnoJmS7hrV6fUSTeyQYI8A0X7W451cAgAHLjfCAACCDAIAAGZAQ
Date: Sun, 22 Mar 2026 19:15:58 +0000
Message-ID:
 <CY4PR03MB3399639D0E7F0FE2706601C99B4AA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260321100154.1258-1-antoniu.miclaus@analog.com>
	<20260321100154.1258-5-antoniu.miclaus@analog.com>
	<20260321121806.3bc18f53@jic23-huawei>
	<CY4PR03MB339971AED25BA03A4E6947CC9B4AA@CY4PR03MB3399.namprd03.prod.outlook.com>
 <20260322173916.0dba368d@jic23-huawei>
In-Reply-To: <20260322173916.0dba368d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DS0PR03MB7292:EE_
x-ms-office365-filtering-correlation-id: aaffbac5-8aa8-4922-ad3f-08de884772e3
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 7EpjrMf6ostBHCoYQ2NgozFoyWM9KEFyHtHHuEyHArAUlDLHsZyqdaG5Z0h7PUAfMpAvfMBVysdbILc42dcdGFWMpL0hJ8K2555aor0f3SIxM5la66s813v3Ohmbkc1v8bwgEMrdJPpiptuE4hecaisMpPwtBEpPDcBqyYGnvBcGBVEzwGWNlyOSm7ose5vk+y7dhJnzzMjz6AfcOgLWIsX438nKrmBFJHw2X6V6oiJk4gRTvENpA0/wKNWyd2JYxStnsPvqrrvY47VMrbH5SgDoJ8h9WGUigfFgvaTfX/qbcPy61/SC37wjtzfRBvOmRUmB6aHFqjV2CbhAosGGk4hxgYByLC13pUK1TnrdCw6ZBy/dAVJIMWB0Oaih5EzrtLvBNb/rQx9f12dI9K7KLBOgt6H+eHs7A6pmwMivK1DKkE1NPTJVrb+wJZrzvK3G9buf8I1kYph7XtlH4XEnhtjzebrcrEEDRvJSnDjwFOJaYVUHXuRSOQ9JxtC11aiKyNJOiGVDnJhlEO0blUc9k7U+E+hKimu6Mg09VUljZrl5Y1IweFU0qkK3f6VkCbEPobZUfVpNDMNzfIh3mGn7LtFDzXMXgr8BFjNz4MLkVeNyGZiUd1w4G4ergG/KxV7VNmGyaPgBifp4UPBOOtzYh4CUU58rV1haD7TG7l69f13YpRkB7keg7sGLSJoeWmlUq9fEsXtyGRjeFvEG2O2Zz7w2zCzb1XHifmXiGPytlhRZJl3ep+SvWHMbwBSWfqh2ZvrQcVKotrYfVXweY8OLoFynvslBFR10ySt82ZnrIxc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnhuMSt4ei9UVEh4SjZZaXM0bi9NeVJSQWprVENKTkp1NzdBZEtpM0ppTnpp?=
 =?utf-8?B?WXhNUWxNd0MwRGp2RldkSmx0RUUzTjlKRVNUcVBXaVc1dkxSRC9WMkVEejNl?=
 =?utf-8?B?dFFKL2xyc2dZSStubUZ3L01lVmJVRnBGSmVDMGRhUWVHZS9HSDZqN1R4TGxp?=
 =?utf-8?B?V1FKMHBUT2VRbTNJV3N6T21JYmZIdnB6azZjNk9Nc0g0TmpLamhhS0Qydld3?=
 =?utf-8?B?dktDcjByNkZLZFFra0owaEZtNjlNbEtjOVhlbzROaDBiRVRERkt2WktZU245?=
 =?utf-8?B?aWg5REUrd041RXo1MSszdkNUQkJTYTFUMDdLSWZXaVBIOEZJL3p3T3pUaHJ0?=
 =?utf-8?B?UDhIUER2VytOVm9YYmlKd3FyMnNxSzJybWNYdU9WY0JzaE91RDhvd0R1dFl6?=
 =?utf-8?B?QUhoZmxmemoyZEx6eVpKYmI4dGRnUURsYjFpY2VIallTejFPUlhwSnBIemZZ?=
 =?utf-8?B?RUhIbW12aVRQVjAvcmFwQVRCa0c0RThIdUNzNEFLRjY4RGpEendJQVlmL2xQ?=
 =?utf-8?B?U1dnakMxVjB4b1dvdWxlZk1QSjVndjJEN1lzK2xTQzFCNDVXZmNGc1pUeEUv?=
 =?utf-8?B?UE9vUmZpZFM0WXk1MWZMMHk2R0Uxa3hnR2NkWCtkUktZdzQwaVVseSs3L0l1?=
 =?utf-8?B?dnVoSDVnNE9CWGswZkhaaFU3MVE1Y0pCU0dWYmVnVVBmTWtYQUIrZmx4YVp6?=
 =?utf-8?B?WGVpZjFXZGsvRTJKYVdrMG5DNlpKNGRCQ3F6cHdvZEtZNXBoYUpEZElFcGpx?=
 =?utf-8?B?SFYxVFpxY1FYNzdOR1Vrc1Q2MWIxYVY5NG5FMThoMUxaRXZBcjFVNTlrU0lt?=
 =?utf-8?B?STljS2FIQkZLYW9JRE1CNVV4bERuWTFzenlMZUdLVGhlaUU3a0VFcmdGN0JO?=
 =?utf-8?B?djd1cUhnYUFGWlhoV0E0SFRueURJeGUvRFJOVm5VU21oa2hqK1J4OEZPZWM3?=
 =?utf-8?B?aUg3LzlFdFlPdHo0ZnBZYmkrcG84Yk42UjJXZm1aaWVqY1FPMXZxenhVNWJx?=
 =?utf-8?B?d2F4T2dVdm5FMGZXSWtCYWtsTkdZRVRkYWhSeVN4RFlJaW1LSkk2OEtnU3lT?=
 =?utf-8?B?cHNzN2F5blVXZElFczJBUlFjT1RnWVFWcUdMLzNKUlNMSWw4anV0SXRJQTk1?=
 =?utf-8?B?QjVhMmprbEVEQ0RZVjZpMmZTbDI3dUZjaWpDMVI2UUNYNm41TUF0cVB5VXF2?=
 =?utf-8?B?Mmo2dHp5eFFKZ0xnejNsNGNyY0lqQk9FMUNCZTJsVTRCVHFZZmRiNW45Z25R?=
 =?utf-8?B?MGVleGxkelhQbG5pSERqMkwzNlUwRFZjMk1IblpXendYejdOczNZWW0xaXNr?=
 =?utf-8?B?VGlkNHBJQ3NiOWpPYXJGU0ZHWHNBdUFZTC9CVEdNMGNRQVpXbTdtekZ2WXhY?=
 =?utf-8?B?UzNhNGxXb3EzaUhicmRwYUpWa2MrZjE5TmYzSm9hWFc3Y09kQnduSUpVSUt2?=
 =?utf-8?B?RzZyQWZyYVdPU0VVMS9TZlNmK1U2RHlJOEVRTE1iMklqMW5qT3F2VHlBU1Rm?=
 =?utf-8?B?Ukh6RGtOOGNjQmNBSE5iNDFleXI4L2tqc01Xa0p0L1h0L2VDdzgzTnNXV1B4?=
 =?utf-8?B?RktORngrck1YcGtmcjNSbkpNRjgvRytVbDlQZ0cwWDlkVnhmWmppRkpmVVM1?=
 =?utf-8?B?ZlA3eEtQK3Q5d3pnOGlyS3NFT05ZemxESlZjZ0NCdC9Bd0Q3Yy82Y3lMRDYx?=
 =?utf-8?B?OFZhUzQ1Yit3R2RNME5LbVE1TVZBODcvTE9ubytKTEV0bVI2MlRHenlwTE42?=
 =?utf-8?B?cURURlpIRHlGRUllV1M3RXlpNUVXdklNMFpJcWVMcFljTXUvZWVjQ0JMamUx?=
 =?utf-8?B?ZnZRQ1N5WFlLcUNRNG1taVFBLzQzMkg5ci9hdnExTEJpS3dZSjJzWnBvSmFN?=
 =?utf-8?B?blRLQ0hPZzNIaWZrbEJzaXUvb2Rvc1o4NXZlaStLc09RSk1URk9TTXBmTU5m?=
 =?utf-8?B?UEJ6bHI3ZTVqRWdFSzdoU1pzS0tXdTVEYnhOV1JFMjhFT09WS1l2d1hJbDBj?=
 =?utf-8?B?cTRkME90QTRnclBBOTI1QUk3UnJ3Q1pqVnNnRmVDellGeWFHOG40UkNyOEJ1?=
 =?utf-8?B?WjgvVXRZaXpVRUZnc0d3RWg2cnpTQyt2Um5jQ3FWSUVBbXlaNVJpMEE2YzIw?=
 =?utf-8?B?TExudzVyK2RCM3VRVnh4VWUxTlFOM3l5R0RwWTlWWWxoWURyYzlvWjRYanNO?=
 =?utf-8?B?L1A4ZFlySjZQdGlpZ1JvVGJUMHNmR05OanR4V1p3Yi9PRGdBZENsdjY5L2Vu?=
 =?utf-8?B?MWR0TnErTmdUem44ZmFVY0RQZW1qMk5JOGd6UXdLUTVVY05IcDRSRTY5b2RH?=
 =?utf-8?B?VWVSNWdGcnhGTW9rV29YYjZvOEtBcnpJdGluNTJCM0VkenVka0F5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pNbcMcTAEHrTi8rtowsFCOKCgJipLTJUlDZruMSnJvFVv3qEHz7qVXwsDlWbWWKzn+8ZhUJmVAEGsQES6EYy1nPPvuukoIYwqK98ln0qOPz7D8ZtdZnmeqhkh1qkxJ+TMBcWZUV3LgzX8q+pk7DKXgusG4k/ti0wnSox/SnnXOxCshI1TWTnl1cHaYpI/N+5nL5duyVaSmpiiTzTyRS3JrtckGuNNNI3wca2NkQkCi/bYMkTfHq/Yefx5G/QSGgTSi4mk1CN/EGLg+WMFYQO+qAzJC1VMjvaXx+5376sGHeKgpi7zeQkTvFCpBdCSOCN+nhNGQACWLurDlfvJCKz0w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaffbac5-8aa8-4922-ad3f-08de884772e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2026 19:15:58.4501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GLBKt6SOUJfZnfnD3NPs2qHYNVw5lsvCphomJSAYbb5lFFFV1pg08K72vdze1svMHtUBWZ/YUzwz+5wP5d5qYxKZ/06TUkOGtYrbh16cw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7292
X-Authority-Analysis: v=2.4 cv=P+03RyAu c=1 sm=1 tr=0 ts=69c03ff2 cx=c_pps
 a=HkOkC5mvV7OaefGfpXsf6A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=8b9GpE9nAAAA:8 a=9I4qcgEobFQkHmS5CDwA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: 7bagW0hsLW2CVw-rRyROzaPVYtltn2Ua
X-Proofpoint-GUID: 7bagW0hsLW2CVw-rRyROzaPVYtltn2Ua
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIyMDE2OCBTYWx0ZWRfXyhNQLBcIcQuu
 Dffv0Tu5gK8NdHEXZzkuWxsPZ5spcyfpqEGOy98us1PgWvRSLvfdGGQs4rCPIO6NeVYWTvBrPvn
 f8LDfb7a98u9c10Q+D82vHx2OtRA67khIAdiBY7rsSyL6jvv2rptC+i6/Ofv0np+ljnbF1Wf4hV
 em4qnSzuJGkPu1h89y/iCpiFnsdRllb/UXfMUvR24kFFG+E6ImsI61AwJtju43G+G+BlEmeaewz
 9HrGCF8BfkIhWlDH6tVKooXexMCoPGmQhgAVw4AZuy/96s65es+xThqbB1Cy4Uy6T2TxdJUeKEj
 vKgvpMk/mL78sn9wE7AX4q8ZcQ5KE+LKFtYZu0gUyS9aiMCKpyc3WkNur7ncWUoW3zImKvP5xXj
 T4jUcPLDSw99BDZE1MbJAkYBXfTI2Wa417dk8aSsKEJvmQ7tUUdLvTIXKLZZpV1eOB3nVMX582q
 UpbG7tGt+7N274d3AdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_06,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603220168

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5kYXksIE1hcmNoIDIyLCAyMDI2IDc6MzkgUE0N
Cj4gVG86IE1pY2xhdXMsIEFudG9uaXUgPEFudG9uaXUuTWljbGF1c0BhbmFsb2cuY29tPg0KPiBD
YzogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBIZW5uZXJpY2gsIE1pY2hh
ZWwNCj4gPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+Ow0KPiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPjsgUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiBLb3psb3dza2kgPGtyemsr
ZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47DQo+IE9s
aXZpZXIgTW95c2FuIDxvbGl2aWVyLm1veXNhbkBmb3NzLnN0LmNvbT47IGxpbnV4LWlpb0B2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgNC80XSBpaW86IGFkYzog
YWQ0MDgwOiBhZGQgc3VwcG9ydCBmb3IgQUQ0ODgwIGR1YWwtDQo+IGNoYW5uZWwgQURDDQo+IA0K
PiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBTdW4sIDIyIE1hciAyMDI2IDE2OjI2OjU4ICswMDAwDQo+
ICJNaWNsYXVzLCBBbnRvbml1IiA8QW50b25pdS5NaWNsYXVzQGFuYWxvZy5jb20+IHdyb3RlOg0K
PiANCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBKb25hdGhh
biBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogU2F0dXJkYXksIE1hcmNo
IDIxLCAyMDI2IDI6MTggUE0NCj4gPiA+IFRvOiBNaWNsYXVzLCBBbnRvbml1IDxBbnRvbml1Lk1p
Y2xhdXNAYW5hbG9nLmNvbT4NCj4gPiA+IENjOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0
YWZvby5kZT47IEhlbm5lcmljaCwgTWljaGFlbA0KPiA+ID4gPE1pY2hhZWwuSGVubmVyaWNoQGFu
YWxvZy5jb20+OyBEYXZpZCBMZWNobmVyDQo+IDxkbGVjaG5lckBiYXlsaWJyZS5jb20+Ow0KPiA+
ID4gU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5l
bC5vcmc+Ow0KPiBLcnp5c3p0b2YNCj4gPiA+IEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3Jn
PjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsNCj4gPiA+IE9saXZpZXIgTW95
c2FuIDxvbGl2aWVyLm1veXNhbkBmb3NzLnN0LmNvbT47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5v
cmc7DQo+ID4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyA0LzRdIGlpbzogYWRjOiBh
ZDQwODA6IGFkZCBzdXBwb3J0IGZvciBBRDQ4ODANCj4gZHVhbC0NCj4gPiA+IGNoYW5uZWwgQURD
DQo+ID4gPg0KPiA+ID4gW0V4dGVybmFsXQ0KPiA+ID4NCj4gPiA+IE9uIFNhdCwgMjEgTWFyIDIw
MjYgMTI6MDE6NTQgKzAyMDANCj4gPiA+IEFudG9uaXUgTWljbGF1cyA8YW50b25pdS5taWNsYXVz
QGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gQWRkIHN1cHBvcnQgZm9yIHRoZSBB
RDQ4ODAsIGEgZHVhbC1jaGFubmVsIDIwLWJpdCA0ME1TUFMgU0FSIEFEQw0KPiB3aXRoDQo+ID4g
PiA+IGludGVncmF0ZWQgZnVsbHkgZGlmZmVyZW50aWFsIGFtcGxpZmllcnMgKEZEQSkuDQo+ID4g
PiA+DQo+ID4gPiA+IFRoZSBBRDQ4ODAgaGFzIHR3byBpbmRlcGVuZGVudCBBREMgY2hhbm5lbHMs
IGVhY2ggd2l0aCBpdHMgb3duIFNQSQ0KPiA+ID4gPiBjb25maWd1cmF0aW9uIGludGVyZmFjZS4g
VGhlIGRyaXZlciB1c2VzIHNwaV9uZXdfYW5jaWxsYXJ5X2RldmljZSgpIHRvDQo+ID4gPiA+IGNy
ZWF0ZSBhbiBhZGRpdGlvbmFsIFNQSSBkZXZpY2UgZm9yIHRoZSBzZWNvbmQgY2hhbm5lbCwgYWxs
b3dpbmcgYm90aA0KPiA+ID4gPiBjaGFubmVscyB0byBzaGFyZSB0aGUgc2FtZSBTUEkgYnVzIHdp
dGggZGlmZmVyZW50IGNoaXAgc2VsZWN0cy4NCj4gPiA+DQo+ID4gPiBTaWxseSBxdWVzdGlvbiAt
IGNhbiB3ZSBiZSBzdXJlIHRoYXQgdGhleSBib3RoIGFyZSBvbiB0aGUgc2FtZSBTUEkgYnVzPw0K
PiA+ID4gSSB0aGluayBpdCdzIHJlYXNvbmFibGUgdG8gYXNzdW1lIG5vIG9uZSB3b3VsZCBidXJu
IHBpbnMgdG8gd2lyZSB0aGUNCj4gPiA+IGNvbnRyb2wgaW50ZXJmYWNlcyB1cCB0byBzZXBhcmF0
ZSBidXNzZXMuIEknbSBub3QgZXZlbiBzdXJlIGhvdyB3ZSdkDQo+ID4gPiBkbyBhIGJpbmRpbmcg
aWYgdGhleSB3ZXJlIG9uIHNlcGFyYXRlIGJ1c3Nlcy4NCj4gPiA+DQo+ID4gPiBPdGhlcndpc2Us
IGEgZm9sbG93IG9uIGZyb20gdGhlICdpcyBpdCBvbmUgYmFja2VuZCBvciB0d28nIHF1ZXN0aW9u
DQo+ID4gPiBvbiB0aGUgYmluZGluZy4NCj4gPiA+DQo+ID4gPiBUaGF0IGxvbmcgZGlzY3Vzc2lv
biBiZXR3ZWVuIHlvdSBhbmQgQW5keSBoYXMgbWUgbG9va2luZyBhdCB0aGlzIGEgbGl0dGxlDQo+
ID4gPiBtb3JlIGNsb3NlbHkuDQo+ID4NCj4gPiAgIFllcywgYm90aCBjaGFubmVscyBhcmUgb24g
dGhlIHNhbWUgU1BJIGJ1cyB3aXRoIHR3byBjaGlwDQo+ID4gICBzZWxlY3RzIOKAlCBvbmUgcGVy
IGludGVybmFsIEFEQyBkaWUuDQo+IA0KPiBDYW4geW91IGdpdmUgYSByZWZlcmVuY2UgZm9yIHRo
aXM/ICBUaGUgZGF0YXNoZWV0IEknbSBsb29raW5nIGF0DQo+IGhhcyBzZXBhcmF0ZSBjcywgc2Ns
aywgc2RpIGFuZCBzZG8gcGVyIGNoYW5uZWwuICBTbyBpdCB3b3VsZCBiZQ0KPiBhIGJvYXJkIHRo
aW5nIG9ubHkgdGhhdCBwdXRzIHRoZW0gb24gdGhlIHNhbWUgU1BJIGJ1cy4NCg0KVGhlIEFENDg4
MCBkYXRhc2hlZXQgc2hvd3MgYm90aCB0b3BvbG9naWVzIOKAlCBGaWd1cmUgNzAgd2l0aCBmdWxs
eSBpbmRlcGVuZGVudCBTUEkgaW50ZXJmYWNlcw0KYW5kIEZpZ3VyZSA3MSB3aXRoIHNoYXJlZCBT
Q0xLL1NESSBhbmQgc2VwYXJhdGUgY2hpcCBzZWxlY3RzLg0KDQpUaGUgY29uZmlnIFNQSSBpcyBv
bmx5IHVzZWQgZm9yIHJlZ2lzdGVyIGFjY2VzcyDigJQgdGhlIGFjdHVhbCBkYXRhIGNhcHR1cmUg
aGFwcGVucyBvdmVyIExWRFMsIHdoZXJlDQpib3RoIGNoYW5uZWxzIGFyZSBpbnRlcmxlYXZlZCBp
bnRvIG9uZSBzdHJlYW0gbm8gbWF0dGVyIGhvdyB0aGUgY29uZmlnIFNQSSBpcyB3aXJlZC4gU2lu
Y2UgdGhlDQpkcml2ZXIgdHJlYXRzIHRoaXMgYXMgYSBzaW5nbGUgSUlPIGRldmljZSB3aXRoIG9u
ZSBidWZmZXIgKG1hdGNoaW5nIHRoZSBpbnRlcmxlYXZlZCBzdHJlYW0pLCB0aGUNCnNoYXJlZC1i
dXMgbW9kZWwgd2l0aCBzcGlfbmV3X2FuY2lsbGFyeV9kZXZpY2UoKSBmaXRzIG5hdHVyYWxseSBJ
TU8g4oCUIG9uZSBwcm9iZSwgb25lIGRldmljZSwgb25lIElJTw0KaW5zdGFuY2UuDQoNCj4gDQo+
ID4NCj4gPiAgIEZvciB0aGUgYmFja2VuZCBxdWVzdGlvbiDigJQgYXMgZXhwbGFpbmVkIGluIG15
IHJlcGx5IHRvIHRoZQ0KPiA+ICAgYmluZGluZyBwYXRjaCwgdGhlIEZQR0EgdXNlcyB0d28gc2Vw
YXJhdGUgYXhpX2FkNDA4eCBJUA0KPiA+ICAgaW5zdGFuY2VzLiBUaGUgYnVmZmVyIGlzIHJlcXVl
c3RlZCBmcm9tIGJhY2tbMF0gYmVjYXVzZQ0KPiA+ICAgdGhlIHBhY2tlciBvdXRwdXQgZmVlZHMg
dGhlIERNQSB0aHJvdWdoIGJhY2tlbmQgQSdzIGNsb2NrDQo+ID4gICBkb21haW4uDQo+IA0KPiBP
ay4gU28gZ2l2ZW4gdGhlIHBhY2tlciBwYXJ0IG1ha2VzIHRoaXMgcmVhbGx5IG9uZSBGUEdBIElQ
DQo+IHdpdGggdHdvICdiYWNrZW5kIGludGVyZmFjZXMnLg0KPiANCj4gTGV0cyBiZSBjbGVhciBh
Ym91dCB0aGF0IGluIHRoZSBjb21tZW50cyBldGMuDQo+IA0KU3VyZSwgY2FuIGRvIHRoYXQgaW4g
djguDQo+IEpvbmF0aGFuDQo+IA0KPiA+DQo+ID4gPiBKb25hdGhhbg0KPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4gUmV2aWV3ZWQtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNv
bT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+DQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFudG9uaXUgTWljbGF1cyA8YW50b25pdS5taWNsYXVzQGFu
YWxvZy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBDaGFuZ2VzIGluIHY3Og0KPiA+ID4gPiAg
IC0gRHJvcCBkZWJ1Z2ZzX3JlZ19hY2Nlc3MgZm9yIGR1YWwtY2hhbm5lbCBBRDQ4ODAgdmFyaWFu
dA0KPiA+ID4gPiAgIC0gUGFzcyBzdHJ1Y3QgZGV2aWNlICogdG8gYWQ0MDgwX3Byb3BlcnRpZXNf
cGFyc2UoKSBpbnN0ZWFkIG9mDQo+ID4gPiA+ICAgICB1c2luZyByZWdtYXBfZ2V0X2RldmljZShz
dC0+cmVnbWFwWzBdKQ0KPiA+ID4gPg0KPiA+ID4gPiAgZHJpdmVycy9paW8vYWRjL2FkNDA4MC5j
IHwgMjMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gLS0tLQ0KPiA+ID4gLS0t
LQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE4MSBpbnNlcnRpb25zKCspLCA1MCBkZWxldGlv
bnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hZDQw
ODAuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDQwODAuYw0KPiA+ID4gPiBpbmRleCA3Y2YzYjZlZDc5
NDAuLjg3NjdlZWY0MThlOSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2Fk
NDA4MC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDQwODAuYw0KPiA+ID4NCj4g
PiA+ID4gQEAgLTYzMiw5ICs3NTIsMTAgQEAgc3RhdGljIGludCBhZDQwODBfcHJvYmUoc3RydWN0
IHNwaV9kZXZpY2UgKnNwaSkNCj4gPiA+ID4gIAlpbmRpb19kZXYtPm5hbWUgPSBzdC0+aW5mby0+
bmFtZTsNCj4gPiA+ID4gIAlpbmRpb19kZXYtPmNoYW5uZWxzID0gc3QtPmluZm8tPmNoYW5uZWxz
Ow0KPiA+ID4gPiAgCWluZGlvX2Rldi0+bnVtX2NoYW5uZWxzID0gc3QtPmluZm8tPm51bV9jaGFu
bmVsczsNCj4gPiA+ID4gLQlpbmRpb19kZXYtPmluZm8gPSAmYWQ0MDgwX2lpb19pbmZvOw0KPiA+
ID4gPiArCWluZGlvX2Rldi0+aW5mbyA9IHN0LT5pbmZvLT5udW1fY2hhbm5lbHMgPiAxID8NCj4g
PiA+ID4gKwkJCSAgJmFkNDg4MF9paW9faW5mbyA6ICZhZDQwODBfaWlvX2luZm87DQo+ID4gPiA+
DQo+ID4gPiA+IC0JcmV0ID0gYWQ0MDgwX3Byb3BlcnRpZXNfcGFyc2Uoc3QpOw0KPiA+ID4gPiAr
CXJldCA9IGFkNDA4MF9wcm9wZXJ0aWVzX3BhcnNlKHN0LCBkZXYpOw0KPiA+ID4gPiAgCWlmIChy
ZXQpDQo+ID4gPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gPiA+DQo+ID4gPiA+IEBAIC02NDQsMTUg
Kzc2NSwyMyBAQCBzdGF0aWMgaW50IGFkNDA4MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZQ0KPiAq
c3BpKQ0KPiA+ID4gPg0KPiA+ID4gPiAgCXN0LT5jbGtfcmF0ZSA9IGNsa19nZXRfcmF0ZShjbGsp
Ow0KPiA+ID4gPg0KPiA+ID4gPiAtCXN0LT5iYWNrID0gZGV2bV9paW9fYmFja2VuZF9nZXQoZGV2
LCBOVUxMKTsNCj4gPiA+ID4gLQlpZiAoSVNfRVJSKHN0LT5iYWNrKSkNCj4gPiA+ID4gLQkJcmV0
dXJuIFBUUl9FUlIoc3QtPmJhY2spOw0KPiA+ID4gPiArCS8qIEdldCBiYWNrZW5kcyBmb3IgYWxs
IGNoYW5uZWxzICovDQo+ID4gPiA+ICsJZm9yICh1bnNpZ25lZCBpbnQgY2ggPSAwOyBjaCA8IHN0
LT5pbmZvLT5udW1fY2hhbm5lbHM7IGNoKyspIHsNCj4gPiA+ID4gKwkJc3QtPmJhY2tbY2hdID0g
ZGV2bV9paW9fYmFja2VuZF9nZXRfYnlfaW5kZXgoZGV2LCBjaCk7DQo+ID4gPiA+ICsJCWlmIChJ
U19FUlIoc3QtPmJhY2tbY2hdKSkNCj4gPiA+ID4gKwkJCXJldHVybiBQVFJfRVJSKHN0LT5iYWNr
W2NoXSk7DQo+ID4gPiA+DQo+ID4gPiA+IC0JcmV0ID0gZGV2bV9paW9fYmFja2VuZF9yZXF1ZXN0
X2J1ZmZlcihkZXYsIHN0LT5iYWNrLCBpbmRpb19kZXYpOw0KPiA+ID4gPiAtCWlmIChyZXQpDQo+
ID4gPiA+IC0JCXJldHVybiByZXQ7DQo+ID4gPiA+ICsJCXJldCA9IGRldm1faWlvX2JhY2tlbmRf
ZW5hYmxlKGRldiwgc3QtPmJhY2tbY2hdKTsNCj4gPiA+ID4gKwkJaWYgKHJldCkNCj4gPiA+ID4g
KwkJCXJldHVybiByZXQ7DQo+ID4gPiA+ICsJfQ0KPiA+ID4gPg0KPiA+ID4gPiAtCXJldCA9IGRl
dm1faWlvX2JhY2tlbmRfZW5hYmxlKGRldiwgc3QtPmJhY2spOw0KPiA+ID4gPiArCS8qDQo+ID4g
PiA+ICsJICogUmVxdWVzdCBidWZmZXIgZnJvbSB0aGUgZmlyc3QgYmFja2VuZCBvbmx5LiBGb3Ig
bXVsdGktY2hhbm5lbA0KPiA+ID4gPiArCSAqIGRldmljZXMgKGUuZy4sIEFENDg4MCksIGFsbCBi
YWNrZW5kcyBzaGFyZSBhIHNpbmdsZSBJSU8gYnVmZmVyDQo+ID4gPiA+ICsJICogYXMgZGF0YSBm
cm9tIGFsbCBBREMgY2hhbm5lbHMgaXMgaW50ZXJsZWF2ZWQgaW50byBvbmUgc3RyZWFtLg0KPiA+
ID4gPiArCSAqLw0KPiA+ID4gPiArCXJldCA9IGRldm1faWlvX2JhY2tlbmRfcmVxdWVzdF9idWZm
ZXIoZGV2LCBzdC0+YmFja1swXSwgaW5kaW9fZGV2KTsNCj4gPiA+DQo+ID4gPiBTbyB0aGlzIGlz
IHRoZSBpbnRlcmxlYXZpbmcgYml0LiAgRm9sbG93cyBvbiBmcm9tIG15IHF1ZXN0aW9uIG9uIHRo
ZSBiaW5kaW5nDQo+ID4gPiBhbmQgd2hldGhlciBpdCBpcyBhcHByb3ByaWF0ZSB0byByZXByZXNl
bnQgaXQgYXMgdHdvIHNlcGFyYXRlIGJhY2tlbmRzDQo+ID4gPiB2cyBhIHNpbmdsZSBvbmUuICBX
aXRoIGEgc2luZ2xlIG9uZSB3ZSdkIG5lZWQgdG8gbWFrZSB0aGUgY29udHJvbCBpbnRlcmZhY2Vz
DQo+ID4gPiB0YWtlIGEgcGFyYW1ldGVyIHRvIHNheSB3aGljaCAnZnJvbnQgZW5kJyB3ZSB3ZXJl
IGNvbmZpZ3VyaW5nIC0gdGhvdWdoIGl0DQo+ID4gPiBraW5kIG9mIG1hcHMgdG8gY2hhbm5lbHMg
aW4gdGhlIHBhcnRpY3VsYXIgY2FzZSBhbmQgd2UgYWxyZWFkeSBoYXZlDQo+ID4gPiBhIHBhcmFt
ZXRlciBmb3IgdGhhdC4NCj4gPiA+DQo+ID4gPiBUaGUgb3RoZXIgb3B0aW9uIG1pZ2h0IGJlIHRv
IG1ha2UgdGhlIGR0LWJpbmRpbmcgdGFrZSBhIHBoYW5kbGUgKyBpbmRleCB0bw0KPiA+ID4gc2F5
IHRoaXMgYmFja2VuZCwgd2l0aCB0aGlzIGZyb250IGVuZCBpbnRlcmZhY2UuDQo+ID4gPg0KPiA+
ID4gPiAgCWlmIChyZXQpDQo+ID4gPiA+ICAJCXJldHVybiByZXQ7DQo+ID4NCg0K
