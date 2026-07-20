Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046E42DA2D;
	Mon, 20 Jul 2026 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560041; cv=fail; b=aFfNxEtgwI+KBseQVne78uPw/UlKCeT7uJv6GlZxP9Yyk6rceUiBwr9xP409RCPmcLudLHWgC+4/GFTNWOZWI45Ou3mNxwXZW6bZS0TRyYwc3q0v3+5w9FxSjFmqW+XxMzdfkBpAVAOCnhGfoXD9uC2N1uFIem4BEZ3CwPeD0dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560041; c=relaxed/simple;
	bh=sUgK/Mvi4BZlpdj2pS+J+0urIxrPQ7AvPKWs3SACrvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fsiyTlUw4teiODy0ZORdIgktJppDZDT4IO5FYGhERrDY+A6ULfd6KH/OAEXfuitUgswLehbxbA7aRTiFqV+U1QAeQdrx8A72pwMFKCSogj8FR0SpEicDtepameA5t5d+9Dx1NUoLuzpyTgVSTKnoJ6nkUZfm4sv6ftxBxolANmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=S8BW7z/R; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="S8BW7z/R"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KDqBTo791061;
	Mon, 20 Jul 2026 15:07:12 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010051.outbound.protection.outlook.com [52.101.169.51])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4fg2a91dbn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 15:07:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaWR/oQs3Ikscn/Y+pwKRe60KYJWys/wPyKKvAXP7Enk+JD12cQfMETyRDwQsDx8A2+eEqcpXkfzpL+vLtNBsWN1WlZgAo/Zhn+6+vjVP/Vtd3c9M+4VjLK8bffYqzBOYns6NLWQWJyJPdLqVbgUtQYD7eu3/0Cd02IGvVzBKFb4Wre40Qoq8ghS/5pf4ztbRQ7FOkjuxALPR7e/rygcfxdeskLZ0U0tHnB2UScZ5rLmhd62q+yeAxhyBgO39+nm7ccOd195q9Z4WVU8XafTuw7iAeL0cSPxWcjDerg0nX08lnn5athB5qxb81SHyMMe0MBFsL2CUxKUjjTvf/vH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUgK/Mvi4BZlpdj2pS+J+0urIxrPQ7AvPKWs3SACrvA=;
 b=Eqrn1drOBDtq8kvydZbO4HjDZihaILqJaP2rLtXJXndkTxGVGulMuED2b06RDqbi4SqxaVKiM3JRz+P2PoNZLcZCqY20Dc0iPrDn/sOynNjzr8AY3TNc/tyd5WnRVZlQjkeZGco2EHMd6eefmQjBleUlIMEFgToeVaD36Ire1v4RnPnJMz7Vd0LuV8CX4WOOQEFc4FW2EXE1yZk/Pe24gO7+k3vp5ti/N9ynqApzuGaP4isZBt6Mb7gmD4r2atblbAZWQh1KclDMXr4bjNlIyiaNz8/KeYEqtHHm745uvkgd5Rr9BPAxDq0OH7o0fgddQrLAR/FUT9FUd1jiUyb9+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUgK/Mvi4BZlpdj2pS+J+0urIxrPQ7AvPKWs3SACrvA=;
 b=S8BW7z/RdHlefx37JKMWxGDIhziRW+eM9zDPB6fqvapEtaTUIgul4Xn0JZnj7RHUJlJPzwhHvAYPjKZY84W6VzBHNeywoi6wy7wKKckzafNGc7A5IYMuz+wPJx+nZDVdXA0s3bPBdzWWRcoxx7f8Eg37ne6rmt6VW9JvrQ7nq7pOBucIgxsBi4YlsUUloVvVXoIl1K4y3RG8CzGHy/a+fF2qHldeoGPVpwOc2HJEnZwH0hjTk9vMKC5owH+pOlMnMKoJEHOshM498n3vfNwHCQS47l8y16ZLT3HKv8HE/RBUgE75j4Lzo3Zr6HDnTvg5KiPLUh0FOoXaMcz+acXM/g==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FRYP281MB0190.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:07:06 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:07:05 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: inv_sensors: better timestamp alignment when
 using watermark
Thread-Topic: [PATCH v2 2/3] iio: inv_sensors: better timestamp alignment when
 using watermark
Thread-Index: AQHdGDP/8j1zap7400mefoWd4mIGkLZ2RswAgAA6Knc=
Date: Mon, 20 Jul 2026 15:07:05 +0000
Message-ID:
 <BE1P281MB14263FC8209148C6147866A2CEC32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References:
 <20260720-iio-common-inv-sensors-timestamp-rework-v2-0-aec31446809c@tdk.com>
 <20260720-iio-common-inv-sensors-timestamp-rework-v2-2-aec31446809c@tdk.com>
 <al4HkNK8kxxqUY0V@ashevche-desk.local>
In-Reply-To: <al4HkNK8kxxqUY0V@ashevche-desk.local>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FRYP281MB0190:EE_
x-ms-office365-filtering-correlation-id: 660a9813-ee01-4072-6ef4-08dee6708fb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|19092799006|1800799024|366016|11063799006|4143699003|56012099006|10067099003|6133799003|3613699012|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 nN9t04M+tmQHeYmu2AfiS3wStxNvvOG5bNVdWawev0CTwj7pFvkUQ5jkxHZ+fPTb2mN3Vh1g3s8XjjvqCRxyi8pHbxtFaFP4vSIDhqIXHLf3UwjTRl8NVHlRH1WC0ccP5+tkSgsNyztjanFq9CrlrKHVZXUptOs8Tws7dIXvQFJOHLwpEPMYpTbH2OOGNimnitFYxlNhASmo66YsHVxBg+FTAU9jSgPlFhfp85exkjhorvU46s8GeojSeSilNPmkzireQjnrHokj5oNbNgval+RoTPHfhNnABtbBAU8ZMdFwfE0W723mjmLaVwkG/xr1zeHxkJzDLTWqXewhUz3AGnsE0tflFNGHXuyL6730V7ib0ZMH/+NMdwap4vno/pVtLpjH3UTRDEuG5MmW39cBjoQ/A0DdUWgBEytS/oEs8umD7/E0VaV4fvryhe6LxpIGEdYiK3JzUwhhXBRh+bpJVVkogaqmnM86jI8N10aQ8jibcJjnjWE1GdJkzqAnWLFQSoLeIzVtIXZE0j/R0k845Sqj6xLF4gxKTlvhxr+KBN/ooHnu2z7dpxihq6xZ5cvcr7I3gPYTC2hKST/TmquCzCS/+fkGjrp8rKG5TgIMKMS4OktjBinmQh118vYSZ+69XGuG6yyxVSTCmgwKKF/aUgAOJpd48R45oCbK40dyEJpU+CxrfyRZvWITh5kYAO6qiq8kCEI6Yg/PXl1XdvAEK7hdZhsztcfUiQZsQVqvQYg5N0JBk2mvtlSSWtxiXGTr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(6133799003)(3613699012)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHhiVEgvaHlaVk9LczVNenpLUG8zMElUazh6aG9McUo4ZTJLQXFRbEswZVB4?=
 =?utf-8?B?UWx0d0dJM0ZGbnZ6ZkovREJPNG91WDNpOVd3a0o1OWo5SitsVzVyaVQ1T0Vt?=
 =?utf-8?B?S2xWOU9nbGhVVUJBM0NjQ0dKVjRBRjFvalk5a24vM0NOeFdUdk5TbHlYaHhJ?=
 =?utf-8?B?ZVFhNDJqZjlOdzdEbmJjZlF1UzNKdzNkOFBlRmljYjcwaWZNUkZUdXFYMDY0?=
 =?utf-8?B?QTNpZDhjWEhTMDlwNVU0MXB5SkRBYjFNWlVwdjRzTzRQbXFqUXRSQXNRWWJx?=
 =?utf-8?B?RFlDcG1uZkRjVk5MYVhiYlJhdnJ6Y3ZNckxoYUczRXlDZW1LRDJVa0ZyQU1x?=
 =?utf-8?B?ampPZVJYSmdnTG8xa1RrRFlKWkhvSEd1SVU2bWtzRWdqK3hhZGVpcEhlWk5P?=
 =?utf-8?B?OVh3UU9QZ1RENmRMcVF4ZVI1dUw2U04wbkI2MGloQkRaMkxFTEhGMGpqS1JL?=
 =?utf-8?B?ZmhBM2lwVEtjZG5ERGdtTjExL2JJa1l4cVhURm5yTkNJZ0ZKZE93QkZ3cTA3?=
 =?utf-8?B?S0ZGN1JtREZHaG5hRW9IRDBPWmIxdHZWQ3QvLytsMjBxR3kzMmFMSmFuTHhE?=
 =?utf-8?B?T1hjNmZzbng5RHBBcmZCYWFnTzV5bUJrdWZTOS9sNTZudEpFUVZ5SmovUS9s?=
 =?utf-8?B?Y0NGbjdMN3JaU0JvN0Ixa1FuU1EvZkxFNXREa2FYam1IaHpvRHpJMHk5Z1FR?=
 =?utf-8?B?cThBQW5Cd2swV1hsdXYvcGdPVURPZ0NYMGhCa0xsa1F4Z0RKdmxTL2JJeXZD?=
 =?utf-8?B?YytoQmUwM2p4R21iWWk3aGw0bnRZamxhLzJTMXNLUkVncVBUQ0Z5RFNxc09F?=
 =?utf-8?B?anRnai9VMU1ya3lzeEtRU3R4c0dOU0MzOHRObWR4MHpPUDhsWS9jVGxKN2FR?=
 =?utf-8?B?L3h3TGNzbFE2ZmJNTzZYRXNZaWRtTWdzUFd3VElDSnQ5ajBybXRhUFlyd0hV?=
 =?utf-8?B?QkVEbGVGN1RwMEZucGRpSERhc2g5dThhSW05NE4wTHBpVldkcisraktzRzhK?=
 =?utf-8?B?RERvQU1kYzZUS0RQdzJSS1p2OEoyeTFxV2FDT2N4ZmdTaXdTTG1iS0xJa0hn?=
 =?utf-8?B?L3JSeTd4VnV1TUxkWDN2dkJ5M1VWbVFrZHRnQ1NjOWVOWURQVnBqOFZLWUVP?=
 =?utf-8?B?WHBIc1ZLeERwK1lBYTkreHFYdTVveFZOYi9kaFRvcmdkbld5RHZjY0J6Z2hV?=
 =?utf-8?B?VW9BZlBHRnNqNjVvSDNaZklPU2V1L21OTFZhY2JVSXFrVGRPV3d1VzFZTmQ3?=
 =?utf-8?B?R0dudkdJU2xoNHp4KysxWDVkZnBBQmFqWURlTVVxSE1UbUkyaEN3Z2ZpWTc4?=
 =?utf-8?B?Q0JoTHh2ZWtzTWMxeVcyWThOMGVrRTcwWW8wU1pXaGxxVVdxeXU4RFZid1o0?=
 =?utf-8?B?U2JXck1FOEd1T0JXR2VUaU1ldEEvWVdFTVh0ZEF5cHB3MUdaUVdxa2xMYWU5?=
 =?utf-8?B?RlVXalhtTFhob3BXcTg2dzBLZmdGbjhhZURaOWRUNmZKb3QxTVZ6ci8vWEVr?=
 =?utf-8?B?L0xWZWlRZVc0QVZXS2JvL2hjem0rRXZMNnI3aVVwbUZTcnhDR3NZNUJRZTZT?=
 =?utf-8?B?QVRYQ25IU1dvWVJOcW1lZ0FrN0g2b3lGMXdrcWt5SEdKSlFnWFQzdm8xNTlo?=
 =?utf-8?B?ekxWMnZCZk9obTVQOFVXVjlrZkNTVENtbzM5S3ltcThFNUNoUWJyTFZvY1Fn?=
 =?utf-8?B?NVpoQlRmbWZveDh3VEp5Q05BemRHdHpwN01Vc3JGSTMrZmNnQU1OMkZyNmV4?=
 =?utf-8?B?c1M2aXl5TWMydTlHNU5EQmhNNms5Sk1vcEhRMk9BNDQ0dUZvbmpJdGhiOVdY?=
 =?utf-8?B?ZXVUTlVjNnRGYnBVbGJDOVVzZ04xVjc1bGNTdkphZ0Z2WjN2SENRSFZoWjdL?=
 =?utf-8?B?SjFwcFVnazZQL0dVMC92R2dISENBNlJjMHhtT210SVBnNUR0Q2QvbTAxWCs0?=
 =?utf-8?B?SU8xUStPZkhqcWFqaUVhM3l6cFNoQWNNdGZOWmxIMzdSa0pSVzV2SWM0T0hn?=
 =?utf-8?B?Q0IzaDNFVGdVODVTQnJmV0NFbVpsYnJJWkVZRk43SlhIS3MzdFJPVGE4T2Vw?=
 =?utf-8?B?VGV1S1NWQlRjeE9ueWsvc2IrclltT29hL1NCY25OS1hwTy82WlI5MW93QXVN?=
 =?utf-8?B?NG93Y2NQNm84ME95L0gwUy9aOU1KNmdHSnBBcUR0RU1JUGt6SnM5ZkpkWFBr?=
 =?utf-8?B?aG9pcWw0ejdPU3E2TW1udEFyeUM1Y1kyemVTL3ExNTlMMlhpK0pHQVEwbVZV?=
 =?utf-8?B?UmtiM0VjZjhkN3FSN3RWaXNMZk1YTlEvcTExeHZiOFZCVEhlb2JWc0sxaGhN?=
 =?utf-8?B?SVYzY3g5QTRpN0Ruam5UbjlBcDhRckNWeVBvSGwvUEYrelpSSGdidkEvaEEy?=
 =?utf-8?Q?6IW0BcK45AeQlJjI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	SErLlkx4gu06B8eu9t+Wx4FVBOQvtA/r3SDpAT60aPVU7VzRSPTytLp2wkkfgtv5L+Bp3fzSJKZK5T1cXyQ1ejd+jUsjL6HL4nHJ+625qdkD3kWrVj9BppPHXohtOLLxlm7HTpsZTO2RdEtf4UaUMK21iXfHSYbHjZmJdY8VuKnoVlX6tFKzyRjh+Vsua76M+g6snO1M6rvvOZB+e+fK+YPfLlfKpAXp3d7kWp/7FkjoeyJoil0a+rGhR0mSBGLHva0Ql/v2LLN6lXZvMS0yIdb8mYsIbyvefSBAr2m2JTbFQO9d/wGGiqkwHkgVTkwhHXTqGZvi/ViI6Y6kAgD5Dg==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 660a9813-ee01-4072-6ef4-08dee6708fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 15:07:05.4454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJQ5u1n73QuXrZwug4wBwQXiE7p0GL5gqZ6N4fao8a1zVWGymauv18CDzE9JIskjRXCmWS23cAq5xsGLRFOf7rFP13DYRh2mwgvxuVxXMvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0190
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2OCBTYWx0ZWRfXxLLDyRSiRsyo
 bYKNByFwMjQ4z1fCbdtYjMjwFllpazS00uqZvE4wG43qAjQvqc4YJMH2NvtqLA3UTBjo6R8fwd9
 qG+EuuKa+HhuRIiff54bc/nRrQ3BnraRrbLfGRyU9TbvUYwG5oX4
X-Proofpoint-GUID: YnASMPfVG8F1QcxfQluXRelKvyD3zFGC
X-Proofpoint-ORIG-GUID: YnASMPfVG8F1QcxfQluXRelKvyD3zFGC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2OCBTYWx0ZWRfX6Z/58H/7WvTA
 ba183y3amlyV46Pn5YJ351AiaQqeNH/K9YbmsWhCTL5LtgU2a/WCwuwMhpQ22bPV6o+plRxZuki
 QG630WY60FmzZPPFD5THJgZyycgYF/znl5fiy52bIZ7InN6tzskkhkV+MQQSADl9CMhs2IeBQWU
 rDf0VhDpVr0UL/OpsviF5f3yfLD+F7EIjXO7K/ZMZATI4gzpsmvsBXmjJlwkXV8xPntHPX0b7Qa
 12tx4RNrUgz7MdbP0abbMy0gLL3l0jtCgbNHy+0Hg59mrblDu7bLkFlSL1LIDvJc46t5f4jSY9u
 NN1Xi2Lw3oZj2tQ6i4+gcoqPZI16p5VAXZSxB75ih6NeXsnkOiNhpvKKnBHDwpWAP7yRwqMaDju
 ek+V5RbspF3UxfiU+MXqvfS48RzI9Yn64QTXgVdU4+E34OSZItdYtzL1RWo19dX5NjxnS23Aejp
 12rqp1QRDCUGsJqn7DQ==
X-Authority-Analysis: v=2.4 cv=W6oIkxWk c=1 sm=1 tr=0 ts=6a5e39a0 cx=c_pps
 a=RICKUj9TD3gDrSgn81YamA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=L-H7trVE6zFOMxMCXYQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200168

Pl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPkZyb206IEFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPgo+U2VudDogTW9uZGF5LCBKdWx5
IDIwLCAyMDI2IDEzOjMzCj5UbzogSmVhbi1CYXB0aXN0ZSBNYW5leXJvbAo+Q2M6IEpvbmF0aGFu
IENhbWVyb247IERhdmlkIExlY2huZXI7IE51bm8gU8OhOyBBbmR5IFNoZXZjaGVua287IGxpbnV4
LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjIgMi8zXSBpaW86IGludl9zZW5zb3JzOiBiZXR0ZXIgdGltZXN0YW1w
IGFsaWdubWVudCB3aGVuIHVzaW5nIHdhdGVybWFyawo+Cj5PbiBNb24sIEp1bCAyMCwgMjAyNiBh
dCAxMjrigIozODrigIozM1BNICswMjAwLCBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBS
ZWxheSB3cm90ZTogPiBDdXJyZW50IGludGVycnVwdCB0aW1lc3RhbXAgYWxpZ25tZW50IG9ubHkg
Y2hhbmdlcyB0aGUgZmluYWwgdGltZXN0YW1wLiA+IFdoZW4gdGhlIHdhdGVybWFyayBpcyBpbiB1
c2UsIHdlIGhhdmUgYSBiYXRjaCBvZiBzYW1wbGVzIGZvciBlYWNoID4gaW50ZXJydXB0LuKAigo+
WmpRY21RUllGcGZwdEJhbm5lclN0YXJ0Cj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5h
bCBTZW5kZXIKPlRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlv
bi4KPgo+WmpRY21RUllGcGZwdEJhbm5lckVuZAo+Cj5PbiBNb24sIEp1bCAyMCwgMjAyNiBhdCAx
MjozODozM1BNICswMjAwLCBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBSZWxheSB3cm90
ZToKPgo+PiBDdXJyZW50IGludGVycnVwdCB0aW1lc3RhbXAgYWxpZ25tZW50IG9ubHkgY2hhbmdl
cyB0aGUgZmluYWwgdGltZXN0YW1wLgo+PiBXaGVuIHRoZSB3YXRlcm1hcmsgaXMgaW4gdXNlLCB3
ZSBoYXZlIGEgYmF0Y2ggb2Ygc2FtcGxlcyBmb3IgZWFjaAo+PiBpbnRlcnJ1cHQuIFRoZSBjdXJy
ZW50IGNvZGUgZG9lc24ndCBtYW5hZ2UgdG8gYWxpZ24gdGhlIHRpbWVzdGFtcAo+PiBiZWNhdXNl
IHRoZSBqaXR0ZXIgaXMgdG9vIGhpZ2guCj4+Cj4+IEluc3RlYWQgbW9kaWZ5IHRoZSBlc3RpbWF0
ZWQgaW50ZXIgaW50ZXJydXB0IHBlcmlvZCBhbmQgdXNlIHRoYXQgdG8KPj4gYWRqdXN0IHRoZSB0
aW1lc3RhbXAgYWxpZ25tZW50IG92ZXIgdGhlIGJhdGNoIGluIGEgbGluZWFyIGZhc2hpb24uCj4K
Pi4uLgo+Cj4+ICB2b2lkIGludl9zZW5zb3JzX3RpbWVzdGFtcF9pbnRlcnJ1cHQoc3RydWN0IGlu
dl9zZW5zb3JzX3RpbWVzdGFtcCAqdHMsCj4KPj4gICAgICAgaWYgKHNhbXBsZV9uYiA9PSAwKQo+
PiAgICAgICAgICAgICAgIHJldHVybjsKPj4KPj4gKyAgICAgLyogbm8gcHJldmlvdXMgZGF0YSwg
Y29tcHV0ZSB0aGVvcmV0aWNhbCB2YWx1ZSBmcm9tIGludGVycnVwdCAqLwo+PiArICAgICBpZiAo
dHMtPnRpbWVzdGFtcCA9PSAwKSB7Cj4+ICsgICAgICAgICAgICAgLyogZWxhcHNlZCB0aW1lOiBz
ZW5zb3IgcGVyaW9kICogc2Vuc29yIHNhbXBsZXMgbnVtYmVyICovCj4+ICsgICAgICAgICAgICAg
aW50ZXJ2YWwgPSAoczY0KXRzLT5wZXJpb2QgKiAoczY0KXNhbXBsZV9uYjsKPgo+VGhlIGJvdGgg
dmFyaWFibGVzIGFyZSB1bnNpZ25lZC4gV2h5IGRvIHdlIGNhc3QgdGhlbSB0byB0aGUgc2lnbmVk
IHR5cGU/Cj4KSGVsbG8gQW5keSwKCnRoZSBpZGVhIGhlcmUgaXMgdG8gaGF2ZSBhICh0aW1lc3Rh
bXAgLSBpbnRlcnZhbCkgZG9pbmcgdGhlIGRpZmZlcmVuY2Ugb24KdmFyaWFibGVzIG9mIHRoZSBz
YW1lIHR5cGUsIHM2NC4gSSB0cmllZCB0byBhdm9pZCBkaWZmZXJlbmNlIGJldHdlZW4gc2lnbmVk
CmFuZCB1bnNpZ25lZCB2YWx1ZXMgdGhhdCBjYW4gYmUgcHJvYmxlbWF0aWMuCgpJbnRlcnZhbCBp
cyBzNjQgZm9yIHRoaXMgcmVhc29uLCBhbmQgdGhhdCdzIHdoeSBJIGNhc3QgdGhlIDIgdTMyIHZh
bHVlcyB0bwpzNjQgKHdoaWNoIHNob3VsZCBub3QgYmUgYSBwcm9ibGVtKS4KCklzIHRoYXQgT0sg
bGlrZSB0aGlzIG9yIGRvIHlvdSBwcmVmZXIgSSBjaGFuZ2UgdG8gdTY0ICh3aXRoIGltcGxpY2l0
CmNvbnZlcnNpb24gdG8gczY0IHdoZW4gYXNzaWduaW5nIHRvIGludGVydmFsKT8KCj4+ICsgICAg
ICAgICAgICAgdHMtPnRpbWVzdGFtcCA9IHRpbWVzdGFtcCAtIGludGVydmFsOwo+PiArICAgICB9
Cj4KPi4uLgo+Cj4+IC0gICAgIC8qIG5vIHByZXZpb3VzIGRhdGEsIGNvbXB1dGUgdGhlb3JldGlj
YWwgdmFsdWUgZnJvbSBpbnRlcnJ1cHQgKi8KPj4gLSAgICAgaWYgKHRzLT50aW1lc3RhbXAgPT0g
MCkgewo+PiAtICAgICAgICAgICAgIC8qIGVsYXBzZWQgdGltZTogc2Vuc29yIHBlcmlvZCAqIHNl
bnNvciBzYW1wbGVzIG51bWJlciAqLwo+PiAtICAgICAgICAgICAgIGludGVydmFsID0gKHM2NCl0
cy0+cGVyaW9kICogKHM2NClzYW1wbGVfbmI7Cj4KPlllYWgsIEkgc2VlIHRoaXMgaXMgdGhlIG9y
aWdpbmFsIGNvZGUsIGJ1dCBjb25zaWRlciByZXZpc2l0aW5nLgo+Cj4+IC0gICAgICAgICAgICAg
dHMtPnRpbWVzdGFtcCA9IGl0LT51cCAtIGludGVydmFsOwo+PiAtICAgICAgICAgICAgIHJldHVy
bjsKPj4gLSAgICAgfQo+Cj4tLQo+V2l0aCBCZXN0IFJlZ2FyZHMsCj5BbmR5IFNoZXZjaGVua28K
PgoKVGhhbmtzLApKQg==
