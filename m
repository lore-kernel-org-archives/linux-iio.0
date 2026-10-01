Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C74A7C9B;
	Thu,  1 Oct 2026 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846205; cv=fail; b=LSlRVgGI7/n6mfWZvoZL2l0f7Ql4K7jaQdFrmweMCsTNvVcWAfM7zgK7ti/tTgAsvyMJNYR25tiomslBS8r+peGyJGWc9TEKCbOtNK8/K4NJjamb8gZv1lALN35wjXjm4W+Io4+JVKcfh/2xSsC2aHtRc/bQykP4rWwfN12NPJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846205; c=relaxed/simple;
	bh=jLjMU0xHMAR2kJCLrPPAxdDs86ZZdRt89cKriKRjXRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jVzWnyYR6ZoTHVNUdq3EhGzg29ggm+4RiKS63gkyaRjFllABMj9ABQy9+VzrqjYC5fbvwC8hMKXBQv6AK0tsDLH7p8vs7zS59TyexLpXdxOjMIvHq+LRpu1IT1X8IZPXIfJEouashlqWnlTQ34e2hqPsciYxcAMeGW0IkPadHrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BcMnFwEl; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BcMnFwEl"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69172Gp03881367;
	Thu, 1 Oct 2026 05:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jLjMU
	0xHMAR2kJCLrPPAxdDs86ZZdRt89cKriKRjXRY=; b=BcMnFwElsNZuNYU8KbJ/3
	Zi7MsS8rr6sI1DgAnszJr59EtZq8G4T/TFArqzpplrPm9GewRMntHBaPPNGUa+4/
	O6nHQ14DMpMB/isG7i3vxx35v4w5cylkae+vVXimm+yCX5ztcr9H9fkZi6z4MyVb
	XlA5ubW6tfuhIoT9WVS60B1/32N2ZB4Az3QMZsiKowJgo07YZlBi/0D3/cLE5nFe
	jhi17N1PAiitLm+Dq3hweakLLBaQA6WDbMDTdtZdiRWsGF/hVGiy8UFjKaIwH/aS
	cZBZBCr3uXUSptL5C9ARWGJ0LmfFX66zUghWkmBIFQWKjizC61fRmR+3iw/GbyIS
	A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h1afctjav-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 05:16:19 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTiO+X2CwVV1hUTQVw61W3hCVvzZCfXtVWx7h2Fqyd5XDPOVpFVdaQat6a5jzSfqZAjrOjf0UaxMsapKniVtoAOQ8D+7w1ABDi5av2gM8LFwmJlOKBzmWYeV/PpGqHrdKX+GqqSLEFQLrJDY9UVAarVry81aeRtQ34FUYPOT8bnYGCda8CAXMpCYCEEOLM5WSHe56k8O+DZ4QyZFB7rgUga0kFgEJSTJMzgkhmekhQct+hszHH3JdrLqpzKunSvxcqtwhVNRi2+cVaoeJQ+CvRjJslTT7rwrvfA6fUob3Y816HzKg4h/+tLAgABMOGAnIP/6ECffgUYXWqdvUkl47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLjMU0xHMAR2kJCLrPPAxdDs86ZZdRt89cKriKRjXRY=;
 b=YBLO1JkvijhHJCWdSji+Z87T5zhEB5lErG3LXWHfsWgmVB5auXN+inMORxUxpiKE8O/ZzSaYBf8qUnMNigwmDh+x78fWdI/s1IX3b7ldgpbpW+Q9Y6Ezzl9jdkUtRK+fo0mPksGM688V+hMDUkGqMbwiCn82hnZ0iHYqsbJ4NhexuOgH2flF5o5E3xY2bGICCXGDai5qLm+Ss7su4oIntsc9n4sc51boHkLqqkMeBShme2rJXc+F6FwkMGOErOD4Vxi27rQROw1ZCrCVGoJlEjgNIYxRhed4vS7FydYF+UgDw4pzSktl8X5iMsK1qHfjbFRzy/PMdeezLd0UX3ydLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by EA8PPFB5E518D3B.namprd03.prod.outlook.com (2603:10b6:30f:fff5::856) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 09:16:16 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 09:16:16 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: iio: imu: Add bindings for ADI ADIS16607
Thread-Topic: [PATCH 1/2] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Thread-Index: AQHdUYTnPfCnQVN/rUumtWUErn3NVbboZ2Wg
Date: Thu, 1 Oct 2026 09:16:16 +0000
Message-ID:
 <LV9PR03MB84143D3F55D43B7EAA02284AF78A2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261001-adis16607-v1-0-9c89cee35d56@analog.com>
 <20261001-adis16607-v1-1-9c89cee35d56@analog.com>
In-Reply-To: <20261001-adis16607-v1-1-9c89cee35d56@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|EA8PPFB5E518D3B:EE_
x-ms-office365-filtering-correlation-id: 2d43c406-ce40-47c1-7e89-08df1f9ca57e
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|56012099006|11063799006|6133799003|4143699003|921020|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 in+iMaWxWkHJ373uFlliItOY+XNu1FfVZGGMGG1R3hCl+Lp2kmOMfo1pj1Xwm3joz/WiBoETzIsMBHgTYI3fRmOEoqHA5Z3vTHgaFfQaSeoLWXbHwpUHTiSGNzMJx32y4tfZRKxYRX+iWYazvceYkMcfowXbyFztXZljIan3FTDABll/BTMNu3EWFlAuAdcl6SDwY8fZCZZEA1wdY7ISOuJxn0Mcfs6pAoTRolTFa70tj9XrkVILTbkxurAVRi2+DU/xEu1v6sr9QwKHPxsFAYRFQ2oXMGS5czfSw2yY66M4+/1R10AwpyVWqhyiXF/e3E9GcC+o57AbFj6ptYy71HMudshkaovhbdNswTDMvZQPcN+VElapct2eraAS5KA5hLbxtAlV0tNG62qBUKNarJ3efRkeAFwQ1FPBdpf7SIucxUxGiBMSGOfz9CXpolpASBfnQyEqNzWweW3Cya/Ge/3A5odfxrZ4PucY7uP/Vqt+28DS68n2DsLLH59k6xuoJqafl++88XAaQbX+pU/QLgncUa3JafEOtTmekjhJzS02/vm8nQSyW/zP2DcRYOaMqmklultUrWUIrV1hHkxiL7QZQp1NHz866KR46ZIPDq0HbN7B4YXUq8jtWT7BU01Nw8ErejeUnGCYjRXKD/DRzi8VOwda/oKRge8NI+zIUcopi60eG9DdF8s50LMCf9ub30UGlW749liB5U+rbP04I2irjGIKO8doBYF8aeM8pvmiW/7YEZw3R7usWCUaucAK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(4143699003)(921020)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODNZTDRveFVmem1SanAxbFB2a1FzRHI0K1ZYTkFwZytQdStldWhTTFdDNkRz?=
 =?utf-8?B?MnNOVm1Fdk90QmkwVmdUUkRWS254K0pBeThzOFJxN0FKYmMxUTFodFlQZWNQ?=
 =?utf-8?B?WENBQThmQnZnMkhmL0dCRWh5VWYzZmxKM0w4ODhjaU9Haklsd043ZC9xaFd2?=
 =?utf-8?B?bkJhdEk1Y25tT2RwMmhJSXFjVU43MEpUUkE3dWRJcU4waHFwdGVHT1B2c0Js?=
 =?utf-8?B?anBvWG5PMDVHUVJrcHlLTWFkamJsS3kxMURuWVBWUkRhVGRrOVlaNXdXZmxP?=
 =?utf-8?B?czRseFZERkRSTjgvR2I1R1krVmMxVW5ERUhvbWVCUzRYS0w1WDRZMlRLOEZM?=
 =?utf-8?B?Q21pMmtONDl5YkF5UjNDcHBmUG9BYXp0N0R5QmdpMVN4ZHArcXoxUE02TUpG?=
 =?utf-8?B?dzZVb3hqSVJCV0VaNnlhT0IySlAzUUxybG96MkRYUittVmdzL2MrVHFRNmtl?=
 =?utf-8?B?Q0p0cHhaQmJOdjh6MmJyaFZDSXU0SmJqMi9WRlhFcVl6VkwyWFRKSDEyNkNs?=
 =?utf-8?B?cTkxZWtJRFBXMTdURVFoWjdDVVBjb3BlbkVXVFhuY3BuVVhVaU93VmlGQkZG?=
 =?utf-8?B?K0pRTThGbWVzTVo1RUZsV2hLWmE5SkNvR25JMG0xaHpBMG1SWjlnbmVKV1Vl?=
 =?utf-8?B?VWhLNUFRb2NTdkNORWZXY0lNTVVXR3IwTHdvWTh4UkY0djVoZCtpK2Q0OGpG?=
 =?utf-8?B?VzR2OG1kWGl2TUVCQ01PWEpZd25LR05naFBZL0d4ekRwa2VxTUVxUHY3V2wy?=
 =?utf-8?B?cXNaazl1d2xLQTVsdG00cU9WdFVxTlNhaUUyQ1luSnRTT3hWSkV3T0lGeE83?=
 =?utf-8?B?eFdQNkRMc2VUbDhKNWpJcmM1bmhDMzluN1RQc2YvakdEZXAvQ3NYOW9Tc2Y1?=
 =?utf-8?B?VkhMRklZQWFEU2NRK0swWHhlVDJaWmtoK2R1cEd6azJaajZkMXpGWFUxSFZz?=
 =?utf-8?B?cVJFbjE1ejJJbWJoOUNYZDAyb3Y2VXlQOThhZnBkVjJ5S3YyWnVCK0hsRVU2?=
 =?utf-8?B?STZYU3dVNEpJU3Iwcjg3eXp6aW1jSEJ0M2ZJaGQxVzc3Y2w4MThoOCtjVHhi?=
 =?utf-8?B?UDIxNUp3cjZxL25RUll2a1dOTCtVREx1eEMrQkE5U3RZUElqak5zYyszdTVY?=
 =?utf-8?B?WFJqYXIwaEE0Mjc2ZWt0M0dsZ05JNHUwaWd2WjM5Tkw0NkZTWDVoVTJCSUZT?=
 =?utf-8?B?SVNRQzVwZUM1cERBUUtLSEd1ZHZUUmYwUVRuQk9ndldneDc0YUZFY3lva0t3?=
 =?utf-8?B?WGxUSnZiUjQ2RlQrYnpVUWd1V2cwdjZIRDBLdFVKc1c4cUVZbnZYN0VkVU9y?=
 =?utf-8?B?YUdhb055VEQzTXBDNi8yUE83dmdmN3ZVU0tiVVNvN3NIenJZU2IvR3hoQ01W?=
 =?utf-8?B?UjhLMW1pc1RXUkZGY0tSTzlmYlhNSDVack1ENlY0THlOeUJMWGt2K2t1a1RG?=
 =?utf-8?B?djVjS3p0YVUvajVPSU1pMmdZUFBTbExDNjViQ2s5S3BlYWpOdW9jUUxkeU1v?=
 =?utf-8?B?bi9xejFDKzdudjh2RWl0SDVycFBkNUpwNVF0amNNQ2t0b1NmTDJ4UTJWZjlV?=
 =?utf-8?B?cEVZV0hTdy9adnBXWTA3Z2ZZeWtYbm5nTWJCMlRDUkdIOFdMUEdQazNKSENI?=
 =?utf-8?B?RnRnZi9XZ0NRbHl5d2sxbXF0OEVrelZWeGJVenFMRllDSjlzblk1cmdINmNZ?=
 =?utf-8?B?QXc4VEIzam1tcnRUMnNMWENQaWV3TEk3enUrZ2RkU1JrOWxVS0UyUG14K1gz?=
 =?utf-8?B?QWFqN2tOV2xtOTYwTUZNdENZU012eUlCa29seno5NElVR1hNOUJ0TzJlMTlQ?=
 =?utf-8?B?ak03WGVjMG92WHJLckJ3Q0pkcGFtc2JVaVYvZFhDSDFTRlhYb2ZIVzI5R1Jx?=
 =?utf-8?B?cjlhd0psWGErMndxazgvWk40a3hIb0hsWTBNY1puN2d3c1M0YWdjeU0zR0Nu?=
 =?utf-8?B?OWNmejBJaEUvY1IzNUcvNDFkMjZLaURDbnJ3NVZhYjZlYm1IM1JaWENQVUZn?=
 =?utf-8?B?WHk4dE9hVkdqeDlDT0RsMllCODdXL3l4Z1dqYWk5RmdibUNoREF5d0NseDZ1?=
 =?utf-8?B?UTNaenA4a29takZUOGl3VnNxRzhlaXdFRElKRkZML0JpZHhhaVhDVXBINUJl?=
 =?utf-8?B?Q0ZQanBrOWRKSFFVSXV3aHJNSVhGSWlQamdTQnpiM0dLNTMyNUh5UlpXMURx?=
 =?utf-8?B?Vk5oZG5lTk1qTFFqQkZ1L3BYeG05V0RhcFdIZ3Q5RDR0alJIT29POUFYSnN4?=
 =?utf-8?B?RDRVa2gva0pnbk1BK2VDZFUybWlic1JiVFc4TzB2TnpTcWxMbXl1U1k5TVR0?=
 =?utf-8?Q?T5tsp7vjcRdT7IAvDU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	1HBEcD9bzAdF1JFxXzgCoM3Glj0/P1Xbh0hrpgPoYqZl0UcY2rDv+apzInkLE1CGo+4w2RXCcdxdF83O7V7CvqzLPAs1NLdu4AInH+cXN+St/KckDkb9RkJw6vAScM4kNEhaIuw5n/RL8cpKKe4/w/HRRGTPqfSTmChXctv5CFfPCX3VrZRmHDqk8tW+jOgzbOudBHQIc4L8nUerwJhmLNT1XEAePRn5Srr91FLK9M2PlAAgWUrpkna1SMSAaUva3u7MnBikuStvQ0MrpbZWuluZYrEWu+3iFJkjThx7hyt0tGVGUTyPwIs8xWaCE9r8Qgx8t+b+4GMRJYUZMJCfqQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d43c406-ce40-47c1-7e89-08df1f9ca57e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 09:16:16.1231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: US7zXnJJRODXoL7Tag/jQxVCtsuaad44ySESS774unBWa9kSppbNKKzTKKCt6h19PeBgcDONZvG6p0QmBHSU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPFB5E518D3B
X-Proofpoint-ORIG-GUID: YFpysrg5oAFWVHuIJhngNFzNSUlZTKc7
X-Authority-Analysis: v=2.4 cv=CvIq4X4D c=1 sm=1 tr=0 ts=6abe24e3 cx=c_pps
 a=0w/E51Vap1Xy1BB5zk4tLA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=PDO2efoT9y_rySfujYgA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzNiBTYWx0ZWRfX8CQtFS7qSKmW
 GZi6Qq0GPZiYCRqUEb12HTWZcxksto3yPlZlt0KjtXXNbm1X9vSp02rfp1QaQ6EuMrSznXHFGWS
 h/I5Y79pD6gEU1hpm5dk6b5wadbUYRilw27C46R8dwMm8/8qsvnS1M2sPDQipP8StgL8Ehf2gzC
 kqR2H506DLu1Pioqya/PS89Ty94BRIK3sAbrg1RYjOCLlEuSpUmGNzaAqmM27w6MnVwNIdF2ZpB
 mbmgP/EZ+gQ45rXiHPoP+DIgx1dg5mbBDteULxFgaBudyKF5nNcGoIwvHy3cGeR1/kLR0st+WLB
 PyCczszygHDWmrd3Ed3soV460OfrWQoNh4vqnItaxXOssisg8HSYs/dOD0Wlm54fEv+ZiwWx2g+
 GqraliRQ9QqLGk4sHxHY+N++sxVm4zAiiAqg2TQJcNnmjEvO3Z6BKmltoZGfAP4Pw96X5ENen0H
 t7fOrd6wdaZxCK5nu8w==
X-Proofpoint-GUID: YFpysrg5oAFWVHuIJhngNFzNSUlZTKc7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzNiBTYWx0ZWRfX9rb7YutC9cx1
 HCOPnCJ+d5JOAV/nBh8L+jUxf9Bhd3XRsTEvT+unOVaKPCzeISpwOcXtCFBMwPMV/tou9qz/mM6
 q04r3cUvmDfQOYTnhPl4gLjIcHQxpEMHSIxzYVKKojcm2ntuxt0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010036

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWR1IFNhYmF1IHZpYSBCNCBS
ZWxheSA8ZGV2bnVsbCtyYWR1LnNhYmF1LmFuYWxvZy5jb21Aa2VybmVsLm9yZz4NCj4gU2VudDog
VGh1cnNkYXksIE9jdG9iZXIgMSwgMjAyNiAxMjoxMiBQTQ0KPiBUbzogTGFycy1QZXRlciBDbGF1
c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBIZW5uZXJpY2gsIE1pY2hhZWwNCj4gPE1pY2hhZWwuSGVu
bmVyaWNoQGFuYWxvZy5jb20+OyBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsN
Cj4gRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPjsgU2EsIE51bm8gPE51bm8u
U2FAYW5hbG9nLmNvbT47DQo+IEFuZHkgU2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsgUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47DQo+IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsr
ZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9yZz4NCj4g
Q2M6IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2FiYXUsIFJhZHUgYm9nZGFuIDxS
YWR1LlNhYmF1QGFuYWxvZy5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdz
OiBpaW86IGltdTogQWRkIGJpbmRpbmdzIGZvciBBREkgQURJUzE2NjA3DQo+IA0KPiBbRXh0ZXJu
YWxdDQo+IA0KPiBGcm9tOiBSYWR1IFNhYmF1IDxyYWR1LnNhYmF1QGFuYWxvZy5jb20+DQo+IA0K
PiBBZGQgZGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yIHRoZSBBbmFsb2cgRGV2aWNlcyBBRElTMTY2
MDcgUHJlY2lzaW9uDQo+IE1FTVMgSW5lcnRpYWwgTWVhc3VyZW1lbnQgVW5pdC4gVGhlIEFESVMx
NjYwNyBpbnRlZ3JhdGVzIGEgdHJpYXhpYWwNCj4gZ3lyb3Njb3BlLCB0cmlheGlhbCBhY2NlbGVy
b21ldGVyLCBhbmQgdGVtcGVyYXR1cmUgc2Vuc29yLCBhbmQNCj4gY29tbXVuaWNhdGVzIG92ZXIg
U1BJIEhhbGYtRHVwbGV4Lg0KPiANCj4gVGhyZWUgY29tcGF0aWJsZSB2YXJpYW50cyBhcmUgc3Vw
cG9ydGVkOiBhZGlzMTY2MDctMSwgYWRpczE2NjA3LTIsDQo+IGFuZCBhZGlzMTY2MDctMy4NCg0K
VXBkYXRlIGZvciB2MiwgdGhlIC0xIHZhcmlhbnQgd2lsbCBiZSByZW1vdmVkIGZyb20gdGhlIGNv
bW1pdHMgbWVzc2FnZXMNCmFzIHdlbGwgc2luY2UgaXQgaXMgbm90IHJlbGVhc2VkLg0KDQpTb3Jy
eSBpbiBhZHZhbmNlIGZvciBhbnkgY29uZnVzaW9uDQoNCg==
