Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FD432E97;
	Tue, 21 Jul 2026 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618106; cv=fail; b=O+VZdtY2PvCQ6VLyvMt2BLRMXFuPOfS1FmUsHTpqYYkagbOE6rwYC4isTX0aLBCFnE6+XBWgQxNLap1FSO7Y4mR8ry7UZE8wkoIgkGXBT8iXkPCIpr3LGWOVfRrg+jeudhgYsEBOfSeX2RXVp297kZxBVIuejpb/vSKx1rvUlnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618106; c=relaxed/simple;
	bh=TdpJSue0A8M8qwxF5zH/xth2f7oasH5v/dElKELQgTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NSHb2UKzinksGS+kelX1oXru4BNRoI8zg8DWm1NdqQK+088kBeot7y0MJCbbfKsFmV1v9qXuAHLzvCfzkLyDjkAp5WLUjkZJMdMtCYhv8kL4mAyw/xNZs3RCf63zjg5lReSC1nXLL9wX3qydABTY7BPoLTqYPNgdbGFWIpDKnoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=jFlsBRVu; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="jFlsBRVu"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNGV9s1794441;
	Tue, 21 Jul 2026 07:14:55 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010061.outbound.protection.outlook.com [52.101.171.61])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4fg2a921ky-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 07:14:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lr/PsrA0GBDxEVU0yYEtADiZca5L4ahkzEfc/bj0G4G8uyH42/oBb8qqfwhFH5YmO+EhOQredGYXktR9J4LQZ4OI9hBgTThqQnvQEi8fpJ9uWmTpIPTbDwdfXB5rUqbPyKGtTt4hnlIbPkdnaV2OiRNsuvvBMPiUc6RwzImbg+nbrvOik9rqdh9imrJt9xkCyEVG6CpfuCz6GG+4m8gulKtoLMy6KR0iQN9smr59I2hs0qqc01HS4Lr/RhZKmCnhgWudQp7g327JgDkTAqitfUaWN5ZJUfCAOkxo0dAfHBqevakU/nbwJNtaSf6UNexePNL9lERAw+SgAaTWHni5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdpJSue0A8M8qwxF5zH/xth2f7oasH5v/dElKELQgTQ=;
 b=XpnslS40kPwkCmweg8oZHJ2H98KaW2cahAvD7ccxPAlMBGi8j13XQR/ZvSAsoXmBNp/Ii7yoiCiitvKe0LO1BCTPLX2oYamTTS1KDbD9SaRarBC/IOaivXZRGwMh98DYRjWoi/8fWlSF/jLDvCaywz8lybuVlrzzIDLxMw0/534BHiGREP78xCEkJyXleuHhclIjfn1TUMLjHQK8gKTEjXsouakhGY0ki4bAzH7EOc+GuKrrb43VNhH/0UxQyVWjYAe3Daos00B9iO6PsKdPFfMo+rvpdve2zO4c7tVFj0ejFVy17lZUTlUZc90gQ9s/DtBCfBzmzpUnws/dbLOl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdpJSue0A8M8qwxF5zH/xth2f7oasH5v/dElKELQgTQ=;
 b=jFlsBRVusHs9gSl5UMq07ydH21YJC71Bm/3RANrh4zAkFisV/ctRgktuVJjam63rj0ANgLslZ3c8CfxmhJpcHQ4UvJoLox/AyBZs6y9Zos5yKbHYy+o2E5Mh5xyikMVhK6ucI9TC+4jJBCL3bE8Lqk7WHhXrxpu/hn1LcazuA5JNIQYtwhVBoRinGbpzKG5IJbKEs/Ejy9RA8pyhTUzWQcpH1eGdzjpWb+mYywmhhFfjSzVkSi6ysZcNPymq0mzm/N7ph7Dx90qxOB7ozanOXzZHkKOOkdSRHj37vcoDqOP4dckICjpDFPCueF6uC5yh/rEpm8Jmu8PW1FnF98AvCQ==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by BE2P281MB4606.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 07:14:49 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 07:14:49 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
        Jonathan Cameron
	<jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Luca Weiss
	<luca.weiss@fairphone.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: icm42600: add icm42630
Thread-Topic: [PATCH 1/2] dt-bindings: iio: imu: icm42600: add icm42630
Thread-Index: AQHdGG4a85GsAJbCXUal1AseTOd1qrZ3j9c9
Date: Tue, 21 Jul 2026 07:14:49 +0000
Message-ID:
 <BE1P281MB1426FB10EA541F0AA56E0881CEC22@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
 <20260720173411.82979-2-jorijnvdgraaf@catcrafts.net>
In-Reply-To: <20260720173411.82979-2-jorijnvdgraaf@catcrafts.net>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|BE2P281MB4606:EE_
x-ms-office365-filtering-correlation-id: 69319677-0203-46da-2515-08dee6f7c062
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|19092799006|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 GfUsDvkQfIGq7GLDtnjs6m1bAGq7DXQ3mY+NiPDTixySX0E0bglVDAtcHyzUuo0FEDLwXT5H4BPE8h9x26xnh+GYQVvyrKrGEoBFVWGCsDD7d+nHOXXtHLkdc1vzjPkl7ixG4+NBVf+GVjZnmxBN+eoDe425MBm/N4SFnZSfjF4Y16eHrMTMCbpXGqwiNORKLVyJI4rZnr5/EfdC5vtZwSYLmctxdOPhr7mOnLMGxOTYxpw9Rg6uYSsEjWizajAyU5i/YooaolRkFJE35po3JJCevXTz8OO2gDIjgHn4GXHhCc7ZIVmRXpNS1JW6v018ZqRkshE8wIf7BWEFH0la/R3OlEi8E1sx0vciLwHx2MfF6I9YT9NTaGsVaoV7EZKHhATRmbRw21J8NDXdyQqW4OIra1IGYWI2O60fhUqH66mLdj8Yyj2Qvcq4ZkfubUf3J5Puq1OaCZq6peSzjND4JC8XGrxP1HnQ5W+1MWdvuS9Ipy2VdD4O+SVT2+6Lr7U+5Jos0XEDzUR1yDAANWBFYJkW1id7m/ip3kPXGopRHLhATsUo4yROREf1zt7d9n/qtwOtmZxl3iwXzaAqBaoM+fnU6zIdDv8Rr2LXRsliCQ5ye391ECjn9LWQpRtSWIyiU/7t39ZidZVgnrn1ZH/WrOZEg1vT4w6pdkAN/WypaIetIGllPLa97rPvfNJToPFyTXy6S7Vs0bjdvdguv0hZ6w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(19092799006)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFJVdE1OSWR0UGo2d3dGY2YwSmdsejE3N1BZUVd4UzhCQko0MnRrTm5ieU5B?=
 =?utf-8?B?VHlTRDhYTktOOStBYnNZVy9CN2Z3cnBpTFVJdVVSUjJHNXVEcjBvZFdtZUht?=
 =?utf-8?B?cEZPSXNUZEYrZTdIejZuN2x2Y0U4Rmt4VEJnUENUMmJpTkJ2czFlNlJNT0Nl?=
 =?utf-8?B?dGV5OEhJY1VNeWtFMnZvOXJMT2RPZXdOR21NRVJsVlRVQldiYm8rQ3prMndU?=
 =?utf-8?B?aXA1QUdJQ3kxUDdmcnJMdlZHOHJvQk9lRUNwa3FGaTVxRnFTVTR2S3A4TnZX?=
 =?utf-8?B?T1MvRlZEa2pPRVZTdVIvUi9KdHlYVHN4V1FwaW1kaHM4ZkV0T2ZKcE8zampr?=
 =?utf-8?B?UC90cUFYRm85Q3Fwb0J2bzkyZnRBV1E5aEM5cy9aQzJvYll2UCtzb3JGdXRj?=
 =?utf-8?B?RUZqVG1rWkllN2lUb2VMeVZVaGp2M1VsNTgvQW16VGQxaTVNc3h2QTZWZWJj?=
 =?utf-8?B?SFFIbno1Z1pwUXpDRVJwTEhsWXZZTTduS0NrVjZoMDU2R3dubmViZ0VOL3M2?=
 =?utf-8?B?U3FlUEZpRW5kOW5tUmtQWU56LzJIZ05FZWZFVmJqS0JhUmtJQmNJbjkraXFG?=
 =?utf-8?B?dzVQMmFSSmlHbGpnZEw2TmlWNFYrVUVyOEhxOUtpWkRHVmcwM3B0Tnpaem90?=
 =?utf-8?B?QWVqY1ZGZkdKVG9NbTFBT0ZaTnhObkU0dWJaVnpoZmVwN0Y3YmtuYUlwTFRK?=
 =?utf-8?B?NEVhbGtYcCszaExuSDdxUmdqMUwzZ0gvZGlDTnduaE9uVjZ4YnBLaEVaUUNK?=
 =?utf-8?B?RUdZWUx5UXJKWFVQSGNMTmM4WGtydHF2YURodi9wN2JzS1hsMmVUV2dyMzNG?=
 =?utf-8?B?MWhZQUZBSWtlVjBaTHV3QmhMaXljNU5uY1NFbzNJc1ZCdFdCYm9KMW1sWGZP?=
 =?utf-8?B?OEc5dVprZExVelB5WGIwaUUyV3NOQjRiVVAxNEtER21BVHJjYmpyRWE3NWRz?=
 =?utf-8?B?YmwrV2N6RVdLYlB6Z05uUG1mVGN6TEhZZlcrYTU0R0NXK01uLzNzcENTajZZ?=
 =?utf-8?B?M0t1a2VhaE4vcGR2L09FYnYyN2JTSTNDdG1KSm5PejFaS0lJc0kxSU5UcXBX?=
 =?utf-8?B?K3VGRmZFcXMrMGlCc1grY1JqQmRxUGxWNExXSHFQc2htVHduNHhUbHMyWW9E?=
 =?utf-8?B?RHZlVWFDMmRXRUNFU2pCRVg3UHBBcElSekovS1N4QjBMWTBhS1lQc21nWEhJ?=
 =?utf-8?B?NkpxT3c5VGRtVG41Z1grZTVkbUxhazNpaVZTSGR3ZDdKV08wak5vYUM3cC9Z?=
 =?utf-8?B?UEhXeWlTSEtQbmxDNUVLbUM2elVqeVQrZy9VVW5YYk41Mm1FY0ZvbEp2cGpT?=
 =?utf-8?B?TDk3SkNpM2FIRzdOK1YzZ2lwTWxyNENQZHR0dzl4bXdiN09XWnMzckJFSFYx?=
 =?utf-8?B?dkk0eDZLVCsrYVpIVVNxTmZNYmVXSS9XalVCaXh6ZUIvT1p5Nkp4ZzlVSlR4?=
 =?utf-8?B?YVd5WkR1aWZCNUhxc3FIREVBTUV3dTNCRlY0bUEveWNYTGFYaWRBbnNGam1Z?=
 =?utf-8?B?ZXNoZUVSYkdxM3haWWsra2h3UlBJL0Y0dXlYaVNjYU5qdkdQSis1THM3b1BU?=
 =?utf-8?B?azhyY0VKY2t3OWVsYlh5T3BKSE4rSjFibGJ2YzJMNll6R3V4cWd4UzlZVzdp?=
 =?utf-8?B?dVp1SGpZT2ZVckZoS0JBekxGWmYrN3BHYXRBRzJLcGxFbmVZbkk5L21lbW5t?=
 =?utf-8?B?OVpxdEdTeXB3YmtFSjdyM2hYdUh1azdFNlNnSmZjQURjbTY3U2hVbnJjMjRB?=
 =?utf-8?B?YnFTczFTcVVObHM1eWRPKysrS3V3TWZ6VitJS0xCbnRVeWtGeGcyMmZIZVZD?=
 =?utf-8?B?RzdSTHFHcjgyWnQ5UmMxZGtodXh6ZkE3UUMxdmk4aUJQMVJndkY5Q2pGdHJr?=
 =?utf-8?B?MHBCT2xjZmEvT3Zod0ZxRWVxT3dBS0VsbjJDZ1N2S1hVU0Vpc05oditGdkNK?=
 =?utf-8?B?OS9Xc09BaWZmN2NRYzVlNVRwUmVyQlcwaUlKWnFqZW9SNE9BR3RNQklXaWht?=
 =?utf-8?B?VDJaWHJRd2ZWZS8vWXk5Y2hyaTNqY2E2bG5nQmxNTVRidXIzWmhzdndFbmg5?=
 =?utf-8?B?UmxLMDllalFuZTN4WGZTTDVWeUJrVmljaTJYQUpJQXhxOXlPZE4xR1k2R2VV?=
 =?utf-8?B?S0JTV0FHRUhQTmMxcFZDZGpITGJMUEY5ZWluOEllcU1waGVkOFdSL3YvSXF5?=
 =?utf-8?B?d1dYYVNIRkd4TktCQ0g4cVVaNU1pQm9nL1pVVkM2VWVOT281enZOZ0krcXNL?=
 =?utf-8?B?bU9JUGdvL2hkVkc2NnI5d3hzN0k2N09Oc1dyYTJncUNBKzdjRTIzdUtoUzBR?=
 =?utf-8?B?UXRESC8yMVhEUHBrL0NIYW1OZGFCSFlqVStJSXBZYkl1WnlkQnMrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	PgfHSOBElTdmLPD8RzXAVWdMxEhQb7iU8YMOWZ/JuTTqNnKU7jhZ1K06svomWRyQ+2MtSnBRq3ziw9rSFKEQeeuNH8NWuYFUqF/M8Irnfh/sA9//45f9bog43Bgj6Hw5gE2XTX4WFwQOUFZJ2733GawpfjWkx19zLrrDskV2x688aIx8FQDhMSaz/Ttr0NHvc4OGx/iIAmnrkog6pFOvVDXsdJz2c5X61VR37yNeXcIwuS7nLCn2KvglAwHvmeG8GynZOKshEytoHDGs2dqTBMrT1rAWRQ7w2EDkTBBqLbRZqxCjy7QIJK16SJTVHEMwqj1lZPBhMZ/h+TKZKD+o8g==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 69319677-0203-46da-2515-08dee6f7c062
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 07:14:49.1200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxNDYBCO4e4B5SgBJrOZsWm/qElDOhHHPUl0BcFX+lDWxwiTr1QbVYRs9REDlaKnygIayNJkr0iblX8+mmaozjhoAhb7IAxUVrCR0Do/Z+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE2P281MB4606
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA3NCBTYWx0ZWRfXzVAiHFVvF4mf
 oSil8pBAV8VWW+1AB0v93mUXMg/A0LSFs8b3oJw/go8SFgprWlq6TQ0S0OuuKzzoVbClK/te14J
 MfM9Ab8nIs9wxY51ChdBPtOIaprLF5Kv8nhXmfYLiJS1MjBLU1zZ
X-Proofpoint-GUID: jt7LojkdFiE6Ruo_k0Gc_4uYPAzOR8Kh
X-Proofpoint-ORIG-GUID: zymbUaSp4-_5iArgwzYAZqiwS4i_CvNz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA3NCBTYWx0ZWRfXyvaIi07oJnpf
 UHqJToIm9DjFGqvczc0/5TJ9R5Jus0T/CNXLCExiJzY4BwETRr2rjJCutW8eXwrS7h9KISppKPS
 sg26snQUVmOpWiBV7rt/Lq3gaIygsc5NJpQYdD37zLET5FKsweClD2FI7mxHx2atjlb2O9PP4dD
 1UMHB9ct+ZA2pWcFQCWD/0eAiViLO78GV+aOSA2Qql+NgM7BDj1aVkAMGZ20FK18ShUi1x/B7ip
 yNazHriARRhIwaorbpkMllkN/aT7apR4iQLv+0ijAFw/XRfcM9mwrNEf0cJWoImzCD7KsiXk4vX
 4tnEchIQBmdm54IouSz0iQhbv2AawDSJQ5ZC28IDScQDIOANhTNNH14TPeqCsRieE1KLlHJ9NIn
 o+x4pDz+061HnWH81ksEeqmUPMPn7m0Ut7QNOMWpI1ivPrhQ7GCVFexjEWFPZ31QjBTndZyXKZ9
 tmy4sfBO1X4eJoHjxyQ==
X-Authority-Analysis: v=2.4 cv=W6oIkxWk c=1 sm=1 tr=0 ts=6a5f1c6e cx=c_pps
 a=S9uFRJX110uq3YNHEk4XXw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=GYSh3LzNAAAA:8
 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=A16mEtM0hU8byi8iKB4A:9 a=QEXdDO2ut3YA:10
 a=lWcdFasyL5yHfcDTNXXo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210074

Pl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPkZyb206IEpvcmlqbiB2
YW4gZGVyIEdyYWFmIDxqb3Jpam52ZGdyYWFmQGNhdGNyYWZ0cy5uZXQ+Cj5TZW50OiBNb25kYXks
IEp1bHkgMjAsIDIwMjYgMTk6MzQKPlRvOiBKb25hdGhhbiBDYW1lcm9uOyBKZWFuLUJhcHRpc3Rl
IE1hbmV5cm9sCj5DYzogSm9yaWpuIHZhbiBkZXIgR3JhYWY7IERhdmlkIExlY2huZXI7IE51bm8g
U8OhOyBBbmR5IFNoZXZjaGVua287IFJvYiBIZXJyaW5nOyBLcnp5c3p0b2YgS296bG93c2tpOyBD
b25vciBEb29sZXk7IENocmlzIE1vcmdhbjsgTHVjYSBXZWlzczsgbGludXgtaWlvQHZnZXIua2Vy
bmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcKPlN1YmplY3Q6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBpaW86IGltdTogaWNt
NDI2MDA6IGFkZCBpY200MjYzMAo+Cj5UaGUgVERLIEludmVuU2Vuc2UgSUNNLTQyNjMwIGlzIGEg
Ni1heGlzIElNVSBvZiB0aGUgSUNNLTQyNjAwIGZhbWlseSwgZm91bmQgZS7igIpnLiBpbiB0aGUg
RmFpcnBob25lIDYuIERvY3VtZW50IGl0cyBjb21wYXRpYmxlLiBBIGZhbGxiYWNrIGNvbXBhdGli
bGUgdG8gYSBzaWJsaW5nIGlzIG5vdCB1c2FibGU6IHRoZSBwYXJ0IHJlcG9ydHMgaXRzIG93biBX
SE9BTUkgcmVnaXN0ZXIgdmFsdWUsIHdoaWNoIHNvZnR3YXJlIHZhbGlkYXRlcwo+WmpRY21RUllG
cGZwdEJhbm5lclN0YXJ0Cj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXIK
PlRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4KPgo+WmpR
Y21RUllGcGZwdEJhbm5lckVuZAo+Cj5UaGUgVERLIEludmVuU2Vuc2UgSUNNLTQyNjMwIGlzIGEg
Ni1heGlzIElNVSBvZiB0aGUgSUNNLTQyNjAwIGZhbWlseSwKPmZvdW5kIGUuZy4gaW4gdGhlIEZh
aXJwaG9uZSA2LiBEb2N1bWVudCBpdHMgY29tcGF0aWJsZS4KPgo+QSBmYWxsYmFjayBjb21wYXRp
YmxlIHRvIGEgc2libGluZyBpcyBub3QgdXNhYmxlOiB0aGUgcGFydCByZXBvcnRzIGl0cwo+b3du
IFdIT0FNSSByZWdpc3RlciB2YWx1ZSwgd2hpY2ggc29mdHdhcmUgdmFsaWRhdGVzIGFnYWluc3Qg
dGhlCj5jb21wYXRpYmxlLgo+Cj5Bc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1mYWJsZS01Cj5T
aWduZWQtb2ZmLWJ5OiBKb3Jpam4gdmFuIGRlciBHcmFhZiA8am9yaWpudmRncmFhZkBjYXRjcmFm
dHMubmV0Pgo+LS0tCj4gLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ltdS9pbnZlbnNlbnNl
LGljbTQyNjAwLnlhbWwgICAgICAgICB8IDEgKwo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQo+Cj5kaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lp
by9pbXUvaW52ZW5zZW5zZSxpY200MjYwMC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lpby9pbXUvaW52ZW5zZW5zZSxpY200MjYwMC55YW1sCj5pbmRleCAxMTllMjhh
ODMzZmQuLmFkZDNhN2ZlZjA5ZCAxMDA2NDQKPi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9paW8vaW11L2ludmVuc2Vuc2UsaWNtNDI2MDAueWFtbAo+KysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9pbXUvaW52ZW5zZW5zZSxpY200MjYwMC55
YW1sCj5AQCAtMzEsNiArMzEsNyBAQCBwcm9wZXJ0aWVzOgo+ICAgICAgIC0gaW52ZW5zZW5zZSxp
Y200MjYwMgo+ICAgICAgIC0gaW52ZW5zZW5zZSxpY200MjYwNQo+ICAgICAgIC0gaW52ZW5zZW5z
ZSxpY200MjYyMgo+KyAgICAgIC0gaW52ZW5zZW5zZSxpY200MjYzMAo+ICAgICAgIC0gaW52ZW5z
ZW5zZSxpY200MjYzMQo+ICAgICAgIC0gaW52ZW5zZW5zZSxpY200MjY4Ngo+ICAgICAgIC0gaW52
ZW5zZW5zZSxpY200MjY4OAo+LS0KPjIuNTUuMAo+Cj4KCkhlbGxvIEpvcmlqbiwKCml0IGlzIE9L
IGZvciBtZSwgdGhhbmtzIGZvciB0aGUgcGF0Y2guCgpBY2tlZC1ieTogSmVhbi1CYXB0aXN0ZSBN
YW5leXJvbCA8amVhbi1iYXB0aXN0ZS5tYW5leXJvbEB0ZGsuY29tPgoKVGhhbmtzLApKQg==
