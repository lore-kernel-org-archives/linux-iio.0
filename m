Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A66329C57;
	Sun, 22 Mar 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774196841; cv=fail; b=a93+UfL2ZipBEJelQcZVkgPQpwVDc50W9ExF2RUW3AwDhlH2ffsX7d+yTfz8gmqDLT1B3mAcxVuQBd7u8bWEOlTJ5dYhfX8FISqTUiqM+dZsRahJzs09lO5YZtqUaTLtoEYwaKjb4yRnta7OzSpR3UzW4nAmEjV/83xWJ6I5HGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774196841; c=relaxed/simple;
	bh=cBtKDnmg/C3ShY6fd8pOhv6G3fVrX6KawADu30SB8TM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Osmv2pjwvcKD7Y4p8JtyAK2LcH2jgUBdpN4WRvC3r9GGvjOCAUKraLYjTz9kntDH8+mIk16aqvjuS11fNs0flkMU6qYVT0bQsC3riTWMKfz/AZw5se0Xjxjqo3vHF8ib9YC2qmaCAq0klV+aRftbEdljGlx+xCkHbm1TmOUu7I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VrbzETN8; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VrbzETN8"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MFnEuV4025358;
	Sun, 22 Mar 2026 12:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cBtKD
	nmg/C3ShY6fd8pOhv6G3fVrX6KawADu30SB8TM=; b=VrbzETN8iNcWSqpnW5OHq
	s8ngUOQxXlA1Qr51iOQeQFlApQkRU3GoVdi/VBPcwvhEB/0bZT2oarAUN9TelnFR
	Fy+EA2RFPmISP+QJCqq5Ph/ExlGrSv8t36srCo6fTLi+uwuyWu0BNA/CqRjcVYsi
	aBjIeKm1xhhPfI8G7eNOd8VLQDGQy7NcV7qEgD529IqLHtrqbfP/t0EqI/V8fwTH
	fQvIUjA5WQalVMNKasgkapTG6fSylugIWlVbfSKcK8dzQCNj+FbZaYD7iCDmJ7ya
	O67/CtYzvSC4FYHfJ5w+qQl2C5AGF+H9sxmlk7Tf4Sm+QJ2M6knXE8hKZ8XSi8xf
	A==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d1qy3b6w4-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Mar 2026 12:27:02 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqQ2oXoTPkJIT4isLSjvH6gQkL7PuQ+hDFENiAZeARSymQ4MYBAGFa8NjQ8hKI017wcZKbUp7N/v0tngFOpkR2ic1P+ZiJQ96Ce/jWaCXROHe5rQs1kWm1g5+/UkFGS5j75ZfA+sLHa8t8abSFccCbY7da2tXFJhs+9/zkmmyOGKUHmdMRAfffAAdZ+bFeupcuVQ1obMouViI0ytCR6Pi9RF+3SXfO8NGIP8AXmcJlepRQ2idJm/2beTPAnyLKRpMdjuZibrGa03bd5S9bZUbSA1F7zqUAhibjORLdhWvHbqhhYX+CB5oa01KgyJjMAFlpl27yVu1foays/WvLvs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBtKDnmg/C3ShY6fd8pOhv6G3fVrX6KawADu30SB8TM=;
 b=uTdriEm3YdNO0Vl9qA3ahQOXg88VXCt0t70MQTHiGiGtJ5BmpCyZ4U6aFbG6sOtu1vikqF6WRd0KGZomwVhAXYAH7XWIMcwCocUxFxOyB6jvrjfQdPWcmv/RBsyRkHvckMXFun9QinYAu0VYu9cwyQbHlIfS/j/8/QR8jNp+CJvy1gMQ8uyR1rmjcyT2RBM3xhNo4O41WVoqjeDR4aQnLoWlwlhDcIdZC6iZRDik3XeM/2f/HSAx8dGcX2fY+7YjGlosvzkSG5PBdMbondV2HezRRLwMowvTnlKKtHCD5fiMBM067NsFd/pk43Z94VyEfpDmTFLTMCe0Df1ajuNcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by LV3PR03MB7708.namprd03.prod.outlook.com (2603:10b6:408:286::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sun, 22 Mar
 2026 16:26:59 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%4]) with mapi id 15.20.9700.025; Sun, 22 Mar 2026
 16:26:58 +0000
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
Thread-Index: AQHcuRnoJmS7hrV6fUSTeyQYI8A0X7W451cAgAHLjfA=
Date: Sun, 22 Mar 2026 16:26:58 +0000
Message-ID:
 <CY4PR03MB339971AED25BA03A4E6947CC9B4AA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260321100154.1258-1-antoniu.miclaus@analog.com>
	<20260321100154.1258-5-antoniu.miclaus@analog.com>
 <20260321121806.3bc18f53@jic23-huawei>
In-Reply-To: <20260321121806.3bc18f53@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|LV3PR03MB7708:EE_
x-ms-office365-filtering-correlation-id: f1aecef3-8ac5-41f4-96a2-08de882fd73f
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 xcS0rKwepOq25SpOkES5Ex3SZtIGKUXnJM0InYk0Gap5pY3MHiLysqBr7NS/YgrX1vnphA10aP8a0qvhJw9jaj+4Ljc1WM8cSrXGseXudHTTjm1h6ocdpdgE00T8JeBjm0lvUpeepUvD3Hr9tFW4Rs8cfJ/QXJQv1alFSor554rJnKAmECNRyl2nzwuktxoib6OAGf4D301TMz0nZS+rrOowtFJDV9mVwUqN6L1lNzUlZy4MeIRqk9nXiMnJ4VwDCZBy4UvJbI3eydQOx25htudw4IZG+nXG9mY39LSrUxXugTD5uWyaphrtOHXmzeYP8kw9nXgsOfq0TiE0qnq5/cY1Kmelima/hKoMmKQxwcN38qNPhPL7xQpucrGq3xyCQcByYgsCOKPrgyAzCZmi9ldk/JFKrMUMzSDNpiQj9MaJUr7OYVJKmxdxZZokACXdHrR/hietcqIHRSDo+6HPIIznfKiQhs/94MG//+iJpNwMQ7KL2zzMuNeaOilC1u2HnGW50Wwk9JGiQXNLu255wjv/ipzCJ25iAoP1HIJkK/hBLzf5X1YlIaozQE7iDNIHj56yTosAAS5/cVoEUGW70Wba8Wj3E/yCs6a35bj0RoErGZKQN+fRNy+Mv8XVC0PsJcExexvrLdw4yMkj7YScKrh1CWyolaKBpyRuvCMMUaEmJaLDKDtV4U/S0sd9gTA61YGQgfvMjrtgGDtaVUGjOwGZjiAzt/YyU22KqtGn+JTZo33fXI8KTCfxtUZwHglcTyNpzJqnkQS8o+BWJaN4UbhccywV2c0GTjPSTXtLmD8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDRHZkRwMDR2SlI5ZU1RanRybDVGWEJZbzk3SUJJT1VYZVdSeUNhSzFiMmFP?=
 =?utf-8?B?bmdUV0hnbUxNUUd3RkRQRTJRM05RWk55b1ZtTS9rc01RRDNFQWlHaEdPUHpi?=
 =?utf-8?B?WVZuSjhIM282UmRYZmFGTGdhWEFuZGxQam5FSFAxOTV0aWc5YTBzWGhkSTR6?=
 =?utf-8?B?bzNSK2t5NndEN1RuRjFEMHUyTFFBOU9oK1pFblRLSXJQSGdCaU9Id3YrWW5J?=
 =?utf-8?B?QU9YUEk1SVA1NFF6WVJTYVBtY2pOakFKenFjeVE4MTNNQ1FjQUJRcjRCNU00?=
 =?utf-8?B?VHZ6c3hielo0eEdtVmp3ZTBLd04wTCtETndZakhOYzVmcFc4d01ZWS8rL2xv?=
 =?utf-8?B?U3R0QVBidnhPQnI5OHhpUDMrazVyQXNBamhoWTBvU1RDOWlqNjAwUmZISGJt?=
 =?utf-8?B?dzhuQ1NJUWlyVjBIekVJQ01XaFJtMVYxeDRGUFNqMUNBWXVYK2RZMUU4K0pT?=
 =?utf-8?B?WFpLOXNPTXFISDBTbTVFZEhIaGtLUXdiMWxzaFZxaGJxTzVBSkRxcDVHZm1j?=
 =?utf-8?B?aEpaNFhqQmd3ZDFjVDRoQzJQN3Fsbi8wS1lKQkY1d0l2UVJ4UlZoZXpSOEkz?=
 =?utf-8?B?Z1VaVm42UXJhVnJDMXJ4S3p2L2NBdTJYSUxjZmMwSVc3WlA1WjhiRWJaVkU2?=
 =?utf-8?B?Z25SbG5xR0hPUHgzK00wSmxNckV4NDNHQThDWW84WEVvYmViVzl4bFRPaXZw?=
 =?utf-8?B?OE00a256Y1lJbDhKSi95ODJjcnFIMFhWeWRxekkySFIzUVJLM2I3MUFzMzlz?=
 =?utf-8?B?NXpUTWZkRElFOU9taUdrUHAxUk41RlM4UExtb0w5Tmkyc0kwWVd0N0Q1R2d6?=
 =?utf-8?B?OFJvS2x2aGQ0TFJaTUZ2b3IwRzBPS3VTUDNKSnJMWVNoQ3hKUzRGemtrdVlJ?=
 =?utf-8?B?LzRDTEgzMUQ4b01iVU9GZ2praytiUTN0OWs0elcvSU8zUDhLcE42S0tydEFl?=
 =?utf-8?B?eFEyR2JxSVlod29KWXhSQTBqNzB3Ti9JbnFDdmU3M3IzS0draGl6OFcyOFNw?=
 =?utf-8?B?c2l5U0gxeVl1NjdLMHFQWG02cWdZQ0hVQTF2MGtnREZGZ1NlRUoxYXlHUnYz?=
 =?utf-8?B?NzNhV2U5dFRqaUhCWmN4N1N2MkxueEpIZzUzSUdwWmYwWlZyOCtEMEVUTXF3?=
 =?utf-8?B?N1JwMHdubU1sQjI4TTJIOWhYaFlzUTRYS3c5dVYyWFNRTHd6S2xreTMvK1Ba?=
 =?utf-8?B?ek0vNHdoR3ZwTGVWdlY5RFErMUN6ZndVbGszNWFpRE5uYmpZc2RsNStNQUFz?=
 =?utf-8?B?a3EyRS9EWldXQ2hrMGNUcGRIejZzV2xWajIvbkthLzBERkNUQkRFa3lHR3Y1?=
 =?utf-8?B?Q2RscGl3SlJWb2ZTZG05QW1wM055cWhOOXdUcENuQ05tRzZGbkQ2QUk1SFFT?=
 =?utf-8?B?UitjU1JNMlg3N0lqQUF5NWlkUzN6UGJuMDJNSFlMdXExZnIxRm9qTHRseTdN?=
 =?utf-8?B?UElvOFZkTGh2QmdRbkpWaEpPenVEeE9RbkxFaDNCeU8wVXNqeFVLeFM4UE1G?=
 =?utf-8?B?NHlpOGd1SGtrSVBZUEJDREVGOUZEdnl4UFljcG5Sdm5SMEJhcElqQi9XalNj?=
 =?utf-8?B?NHR0VmprNzhPMzhrVEtPU0tvQlkrRXlYRkZQbE9TYTgxeldJK285K0RiY1N5?=
 =?utf-8?B?N2dlYjJvN3puV2x1ZE9RaUtGZE4vSEs4NWdBdmlSUnJUQjBFNWdSYWVKOThX?=
 =?utf-8?B?ZFJYcDdUTXFKd0FVRVJXRnJrSk9rWXZjazhySmo5RDhNU2lJNlN3MTVlemh6?=
 =?utf-8?B?cHJjV1lLSDhiV3ppUXBvSlRwL0tBRXF0dzJrdUswRHlmNVlmNDd0dTcwUFky?=
 =?utf-8?B?eGp2cGRIRGwxMFoyV0l5ZlVWTmxHbW1GTWFiaTZJWFM4dnZqTW80M2FmUnJs?=
 =?utf-8?B?Umg5enBCaDRtckxGYWY5amp0TW5xTWxLTDQ1MDN1ZGlDeDdXNnNVR013bFVT?=
 =?utf-8?B?Zm5mbWFTaERETTFHRGxSejlXc1dxNmlVT2EwcktjUVN4TitBZzlqUlZUdmpr?=
 =?utf-8?B?S1g3ZVlNdEx1dXczdVVBWFZUencwL1JBUndTT0xuVS8zNlMrNHNjeFNxRFh1?=
 =?utf-8?B?MFFmSjdMZFo0d2N1R3N6SEROZkQvZzlNLzVKK0VMREdiN21SQXpxMGViYUJX?=
 =?utf-8?B?d0pGT2NIY2s0UFVCL1c0cHNiU0tFOTkyVWp0Rk9EeWtlUHFsdVp1SjRra1Fx?=
 =?utf-8?B?WUxKZFVNSlExVHhhdTVaYVBXTXd0Z1Z4Kzl1eDJoVDZmYjVlTWtuOEErMkxG?=
 =?utf-8?B?djBmZWRYNGVsK01wWWpFdjd1TEtuaU91NzN6Q1BpT3JKQTd0SGhTVFZ3NXUv?=
 =?utf-8?B?K2tXVEpTMHYvUFBRcE43eUxneVJleHFmUXRVOGt0dlN6eFcydzYvZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Tzb0/OffvcOR04YJAQQaH6AaPPfYYNXJC5nWj3WkUXdHq9up0MNj6/eEIVeclBCIwbL130PZCZzz4X07V5JJXHETGTBbFBzRKTQr+oywL3kadH6ru2vocqIXlRVl9ucCO/A5p3f8fvk/wA9O+U2p7+Yd/nATB+X2DHP3fVSqoBhgRhSLMKOF47CciIL/smbQsgzgGkPCm8vFCX/trky+Mcx4dSaJiBtJQpcBxth7kzzTz84Fp4l+SLJt75IjVmdmvg82qbgDWxHfpAf3Zn96W8I61z2ZeNfRTSGTalViN/p2TkZx43IXfbiHwGS7cQfvCCg2Yim2kBhz4eWUIUaV6g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aecef3-8ac5-41f4-96a2-08de882fd73f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2026 16:26:58.8983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WDIzcW49AU1HC/DBnrJRs330hVae2owTz7O9k1SyGG948y11YByVOmP723lKwZ1j0V7KwmxTBXLrqwiPkocW+qS5T9TSb640le+Q3Df+Ruw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7708
X-Authority-Analysis: v=2.4 cv=XqX3+FF9 c=1 sm=1 tr=0 ts=69c01856 cx=c_pps
 a=up4QpmAGzzRqrgyk5KT4IA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=8b9GpE9nAAAA:8 a=ElBtiY8l25raPWbOzugA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIyMDE0NCBTYWx0ZWRfXwCYeJIFHWefi
 KoKcFAygpHEdGfppAOnXayQ5o2sP/C3AQTawfQmGtvlczoGiEQ53wiBllecA/X54P5DkHKzx2Uw
 Lwcwz5v9IYy1PDn0Xrt/fBrz5yX009qsoKy8NTES6Vn//nRMOkjlh4hoItn2iCgZe/M8S+E5pLj
 kPuGU7ignPtAMcZb+O4jAaE0ehGSuEmbQbpd1hs+Y26e+g2vajKWpXMvmi88qzbqTP2LLEVGrlN
 kEcjjhJ6VFo3RvBNjvzwE99rKERZkDkAjUuqbsvANNOEBy2wEvbfZKc5npJski9wyfY9r5fwouK
 vsGVbOgCW2xI7nYVPy/cxfBmYJCO24c5u7aeTaSwn87th6bQI8mfl4xl//oM/GcX5RfTt5wgxh8
 m/9NakIx9WsIZTHUPMNSpjAxvyxkYDffGMYt/o+MTo/K9JKfTYCSA0wAHizL1pSTiVI7hCTK4Vj
 P1DHhmaAAVN52guDgqA==
X-Proofpoint-GUID: ZNqtp37aQj3Ua6a-3HsyARtyxdCimiuy
X-Proofpoint-ORIG-GUID: ZNqtp37aQj3Ua6a-3HsyARtyxdCimiuy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603220144

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMjEsIDIwMjYgMjoxOCBQ
TQ0KPiBUbzogTWljbGF1cywgQW50b25pdSA8QW50b25pdS5NaWNsYXVzQGFuYWxvZy5jb20+DQo+
IENjOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWlj
aGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IERhdmlkIExlY2huZXIgPGRs
ZWNobmVyQGJheWxpYnJlLmNvbT47DQo+IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+OyBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtvemxvd3NraSA8a3J6
aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsNCj4g
T2xpdmllciBNb3lzYW4gPG9saXZpZXIubW95c2FuQGZvc3Muc3QuY29tPjsgbGludXgtaWlvQHZn
ZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyA0LzRdIGlpbzogYWRj
OiBhZDQwODA6IGFkZCBzdXBwb3J0IGZvciBBRDQ4ODAgZHVhbC0NCj4gY2hhbm5lbCBBREMNCj4g
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFNhdCwgMjEgTWFyIDIwMjYgMTI6MDE6NTQgKzAyMDAN
Cj4gQW50b25pdSBNaWNsYXVzIDxhbnRvbml1Lm1pY2xhdXNAYW5hbG9nLmNvbT4gd3JvdGU6DQo+
IA0KPiA+IEFkZCBzdXBwb3J0IGZvciB0aGUgQUQ0ODgwLCBhIGR1YWwtY2hhbm5lbCAyMC1iaXQg
NDBNU1BTIFNBUiBBREMgd2l0aA0KPiA+IGludGVncmF0ZWQgZnVsbHkgZGlmZmVyZW50aWFsIGFt
cGxpZmllcnMgKEZEQSkuDQo+ID4NCj4gPiBUaGUgQUQ0ODgwIGhhcyB0d28gaW5kZXBlbmRlbnQg
QURDIGNoYW5uZWxzLCBlYWNoIHdpdGggaXRzIG93biBTUEkNCj4gPiBjb25maWd1cmF0aW9uIGlu
dGVyZmFjZS4gVGhlIGRyaXZlciB1c2VzIHNwaV9uZXdfYW5jaWxsYXJ5X2RldmljZSgpIHRvDQo+
ID4gY3JlYXRlIGFuIGFkZGl0aW9uYWwgU1BJIGRldmljZSBmb3IgdGhlIHNlY29uZCBjaGFubmVs
LCBhbGxvd2luZyBib3RoDQo+ID4gY2hhbm5lbHMgdG8gc2hhcmUgdGhlIHNhbWUgU1BJIGJ1cyB3
aXRoIGRpZmZlcmVudCBjaGlwIHNlbGVjdHMuDQo+IA0KPiBTaWxseSBxdWVzdGlvbiAtIGNhbiB3
ZSBiZSBzdXJlIHRoYXQgdGhleSBib3RoIGFyZSBvbiB0aGUgc2FtZSBTUEkgYnVzPw0KPiBJIHRo
aW5rIGl0J3MgcmVhc29uYWJsZSB0byBhc3N1bWUgbm8gb25lIHdvdWxkIGJ1cm4gcGlucyB0byB3
aXJlIHRoZQ0KPiBjb250cm9sIGludGVyZmFjZXMgdXAgdG8gc2VwYXJhdGUgYnVzc2VzLiBJJ20g
bm90IGV2ZW4gc3VyZSBob3cgd2UnZA0KPiBkbyBhIGJpbmRpbmcgaWYgdGhleSB3ZXJlIG9uIHNl
cGFyYXRlIGJ1c3Nlcy4NCj4gDQo+IE90aGVyd2lzZSwgYSBmb2xsb3cgb24gZnJvbSB0aGUgJ2lz
IGl0IG9uZSBiYWNrZW5kIG9yIHR3bycgcXVlc3Rpb24NCj4gb24gdGhlIGJpbmRpbmcuDQo+IA0K
PiBUaGF0IGxvbmcgZGlzY3Vzc2lvbiBiZXR3ZWVuIHlvdSBhbmQgQW5keSBoYXMgbWUgbG9va2lu
ZyBhdCB0aGlzIGEgbGl0dGxlDQo+IG1vcmUgY2xvc2VseS4NCg0KICBZZXMsIGJvdGggY2hhbm5l
bHMgYXJlIG9uIHRoZSBzYW1lIFNQSSBidXMgd2l0aCB0d28gY2hpcA0KICBzZWxlY3RzIOKAlCBv
bmUgcGVyIGludGVybmFsIEFEQyBkaWUuDQoNCiAgRm9yIHRoZSBiYWNrZW5kIHF1ZXN0aW9uIOKA
lCBhcyBleHBsYWluZWQgaW4gbXkgcmVwbHkgdG8gdGhlDQogIGJpbmRpbmcgcGF0Y2gsIHRoZSBG
UEdBIHVzZXMgdHdvIHNlcGFyYXRlIGF4aV9hZDQwOHggSVANCiAgaW5zdGFuY2VzLiBUaGUgYnVm
ZmVyIGlzIHJlcXVlc3RlZCBmcm9tIGJhY2tbMF0gYmVjYXVzZQ0KICB0aGUgcGFja2VyIG91dHB1
dCBmZWVkcyB0aGUgRE1BIHRocm91Z2ggYmFja2VuZCBBJ3MgY2xvY2sNCiAgZG9tYWluLg0KDQo+
IEpvbmF0aGFuDQo+IA0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IERhdmlkIExlY2huZXIgPGRsZWNo
bmVyQGJheWxpYnJlLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5h
bG9nLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnRvbml1IE1pY2xhdXMgPGFudG9uaXUubWlj
bGF1c0BhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjc6DQo+ID4gICAtIERy
b3AgZGVidWdmc19yZWdfYWNjZXNzIGZvciBkdWFsLWNoYW5uZWwgQUQ0ODgwIHZhcmlhbnQNCj4g
PiAgIC0gUGFzcyBzdHJ1Y3QgZGV2aWNlICogdG8gYWQ0MDgwX3Byb3BlcnRpZXNfcGFyc2UoKSBp
bnN0ZWFkIG9mDQo+ID4gICAgIHVzaW5nIHJlZ21hcF9nZXRfZGV2aWNlKHN0LT5yZWdtYXBbMF0p
DQo+ID4NCj4gPiAgZHJpdmVycy9paW8vYWRjL2FkNDA4MC5jIHwgMjMxICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tDQo+IC0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE4MSBp
bnNlcnRpb25zKCspLCA1MCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lpby9hZGMvYWQ0MDgwLmMgYi9kcml2ZXJzL2lpby9hZGMvYWQ0MDgwLmMNCj4gPiBpbmRl
eCA3Y2YzYjZlZDc5NDAuLjg3NjdlZWY0MThlOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lp
by9hZGMvYWQ0MDgwLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYWQ0MDgwLmMNCj4gDQo+
ID4gQEAgLTYzMiw5ICs3NTIsMTAgQEAgc3RhdGljIGludCBhZDQwODBfcHJvYmUoc3RydWN0IHNw
aV9kZXZpY2UgKnNwaSkNCj4gPiAgCWluZGlvX2Rldi0+bmFtZSA9IHN0LT5pbmZvLT5uYW1lOw0K
PiA+ICAJaW5kaW9fZGV2LT5jaGFubmVscyA9IHN0LT5pbmZvLT5jaGFubmVsczsNCj4gPiAgCWlu
ZGlvX2Rldi0+bnVtX2NoYW5uZWxzID0gc3QtPmluZm8tPm51bV9jaGFubmVsczsNCj4gPiAtCWlu
ZGlvX2Rldi0+aW5mbyA9ICZhZDQwODBfaWlvX2luZm87DQo+ID4gKwlpbmRpb19kZXYtPmluZm8g
PSBzdC0+aW5mby0+bnVtX2NoYW5uZWxzID4gMSA/DQo+ID4gKwkJCSAgJmFkNDg4MF9paW9faW5m
byA6ICZhZDQwODBfaWlvX2luZm87DQo+ID4NCj4gPiAtCXJldCA9IGFkNDA4MF9wcm9wZXJ0aWVz
X3BhcnNlKHN0KTsNCj4gPiArCXJldCA9IGFkNDA4MF9wcm9wZXJ0aWVzX3BhcnNlKHN0LCBkZXYp
Ow0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+DQo+ID4gQEAgLTY0NCwx
NSArNzY1LDIzIEBAIHN0YXRpYyBpbnQgYWQ0MDgwX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpz
cGkpDQo+ID4NCj4gPiAgCXN0LT5jbGtfcmF0ZSA9IGNsa19nZXRfcmF0ZShjbGspOw0KPiA+DQo+
ID4gLQlzdC0+YmFjayA9IGRldm1faWlvX2JhY2tlbmRfZ2V0KGRldiwgTlVMTCk7DQo+ID4gLQlp
ZiAoSVNfRVJSKHN0LT5iYWNrKSkNCj4gPiAtCQlyZXR1cm4gUFRSX0VSUihzdC0+YmFjayk7DQo+
ID4gKwkvKiBHZXQgYmFja2VuZHMgZm9yIGFsbCBjaGFubmVscyAqLw0KPiA+ICsJZm9yICh1bnNp
Z25lZCBpbnQgY2ggPSAwOyBjaCA8IHN0LT5pbmZvLT5udW1fY2hhbm5lbHM7IGNoKyspIHsNCj4g
PiArCQlzdC0+YmFja1tjaF0gPSBkZXZtX2lpb19iYWNrZW5kX2dldF9ieV9pbmRleChkZXYsIGNo
KTsNCj4gPiArCQlpZiAoSVNfRVJSKHN0LT5iYWNrW2NoXSkpDQo+ID4gKwkJCXJldHVybiBQVFJf
RVJSKHN0LT5iYWNrW2NoXSk7DQo+ID4NCj4gPiAtCXJldCA9IGRldm1faWlvX2JhY2tlbmRfcmVx
dWVzdF9idWZmZXIoZGV2LCBzdC0+YmFjaywgaW5kaW9fZGV2KTsNCj4gPiAtCWlmIChyZXQpDQo+
ID4gLQkJcmV0dXJuIHJldDsNCj4gPiArCQlyZXQgPSBkZXZtX2lpb19iYWNrZW5kX2VuYWJsZShk
ZXYsIHN0LT5iYWNrW2NoXSk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsN
Cj4gPiArCX0NCj4gPg0KPiA+IC0JcmV0ID0gZGV2bV9paW9fYmFja2VuZF9lbmFibGUoZGV2LCBz
dC0+YmFjayk7DQo+ID4gKwkvKg0KPiA+ICsJICogUmVxdWVzdCBidWZmZXIgZnJvbSB0aGUgZmly
c3QgYmFja2VuZCBvbmx5LiBGb3IgbXVsdGktY2hhbm5lbA0KPiA+ICsJICogZGV2aWNlcyAoZS5n
LiwgQUQ0ODgwKSwgYWxsIGJhY2tlbmRzIHNoYXJlIGEgc2luZ2xlIElJTyBidWZmZXINCj4gPiAr
CSAqIGFzIGRhdGEgZnJvbSBhbGwgQURDIGNoYW5uZWxzIGlzIGludGVybGVhdmVkIGludG8gb25l
IHN0cmVhbS4NCj4gPiArCSAqLw0KPiA+ICsJcmV0ID0gZGV2bV9paW9fYmFja2VuZF9yZXF1ZXN0
X2J1ZmZlcihkZXYsIHN0LT5iYWNrWzBdLCBpbmRpb19kZXYpOw0KPiANCj4gU28gdGhpcyBpcyB0
aGUgaW50ZXJsZWF2aW5nIGJpdC4gIEZvbGxvd3Mgb24gZnJvbSBteSBxdWVzdGlvbiBvbiB0aGUg
YmluZGluZw0KPiBhbmQgd2hldGhlciBpdCBpcyBhcHByb3ByaWF0ZSB0byByZXByZXNlbnQgaXQg
YXMgdHdvIHNlcGFyYXRlIGJhY2tlbmRzDQo+IHZzIGEgc2luZ2xlIG9uZS4gIFdpdGggYSBzaW5n
bGUgb25lIHdlJ2QgbmVlZCB0byBtYWtlIHRoZSBjb250cm9sIGludGVyZmFjZXMNCj4gdGFrZSBh
IHBhcmFtZXRlciB0byBzYXkgd2hpY2ggJ2Zyb250IGVuZCcgd2Ugd2VyZSBjb25maWd1cmluZyAt
IHRob3VnaCBpdA0KPiBraW5kIG9mIG1hcHMgdG8gY2hhbm5lbHMgaW4gdGhlIHBhcnRpY3VsYXIg
Y2FzZSBhbmQgd2UgYWxyZWFkeSBoYXZlDQo+IGEgcGFyYW1ldGVyIGZvciB0aGF0Lg0KPiANCj4g
VGhlIG90aGVyIG9wdGlvbiBtaWdodCBiZSB0byBtYWtlIHRoZSBkdC1iaW5kaW5nIHRha2UgYSBw
aGFuZGxlICsgaW5kZXggdG8NCj4gc2F5IHRoaXMgYmFja2VuZCwgd2l0aCB0aGlzIGZyb250IGVu
ZCBpbnRlcmZhY2UuDQo+IA0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KDQo=
