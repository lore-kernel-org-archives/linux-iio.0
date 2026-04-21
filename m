Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159E2C2363;
	Tue, 21 Apr 2026 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780592; cv=fail; b=hL8W9ZSjLAMO8EbYnl9ZlUhgENUS1SvuQgrtfp9NM1/hMTfRkJkH+DcyJ5FzIPow0l8Jq3ZKgAILU/ZXElJUSnsxECHNOvWYCpQ70HLfCAZ6sxUsVq7tiuCVJSXO65mT/vPleoy0Q8JBiM/2As3+sqv/dSrdUpBTSsk0tvNrpyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780592; c=relaxed/simple;
	bh=LdVPb+6rUSIOWt5DP1jMpiaH11mqW6oYBKxAxqbLc6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AqZhtYO0vPyvt9v0EDLM4WmjBy9EEtafh5Y7nPDCnbvQXMULYvNyq/0pnv2HS6IwudQt25j1RRGJnAqQeCGa1kplp+nS7IAaRsQegAtrnHgKwBqn3kSvxvDOX2zs9k039ebxy5kwEn6IMBPA2IHiCIAGOhDHhG1mKpD/rHH+8GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eIf7Z5al; arc=fail smtp.client-ip=52.101.61.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eIf7Z5al"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrcpasyiLYRiWasz/M9LXtzJ4b6E2gIyippO43Jgbc+H36AO4Ctb8qxse/69yFNJBY3WKB8W+ErtjsHFB421GWT/+cPVuBFW8Jk/eE44qIO/oyc7dFXFje/m6xK8eLIcqGo3O0WmgPIP4xn+aBAs8EV1k8+gq/nyYrXcgTyoFo9lRSxivZoltQSJSxeM8XyPpg1pFOP4771vGmp+eJyY9i2t6PCbv0z2AL7lmq+wEylDNCAe7K0BcFoNZvU84tmpy0E7NdcmaN8ugYSN9feWqhQZ1ShZxGBT73CNOnO/gJYlgIqc1Di2Zgp3eOzSQ/TNpGALzzdQBI4QLe5zqJ0kqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdVPb+6rUSIOWt5DP1jMpiaH11mqW6oYBKxAxqbLc6c=;
 b=QwnO57qKRuu8azofvhp3AyXwoy90k0U2Xo5JAtSdJMpAvfiahh2NvuDuwHA9xLCTnYjLZFiysHh10GYBb3t7XBjH+EsJ3PkRraaFJux6hXeNVIQ21NvvHjcTUp0t9W0hZkpEH48BRMsAMbCvzMJCF71t2C7lXW6e9Pwg52vai+b3X4g0e/VgHeAzcsdmUsznC6y67UZ8WvjMrpORZE2a2fKkcoupz0Cp/EEIfWxwcTzc0QJ8MQzSLMi04dhmGt4mOT6DseqFmEazz5GMKWw33Efvc2xR93e2I5h1Zc+5CiCyDhhGEsgvD6s/8qlQV8PgEdmcnNywSIKzEoPp36gjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdVPb+6rUSIOWt5DP1jMpiaH11mqW6oYBKxAxqbLc6c=;
 b=eIf7Z5alGNeAI+MZnSoTh6A/sNb3Vj8wXzgfcb243GORGnQEPzRLKW4wBZ1/J0tyyCZoWpFavCmqsoM6yp5w3xdunDrFS/ejRR6gYM8bEitM15TEatb9l8Wx3W12BVrQSQtEplmrrhTondE0L3AU2WPM/UZmcSgbBukHrWvjSXdRWCPpde/z1uvGkrBKkxx2WRnDVxFfbpGUwgJqt/ukX2rxxBzfjpUJRkU8IH4+qLHPMouydBncPGM9uP/SEHhpTgd0QnyxiWR6jtj8AYfSIWt05AMzD1UKMM0ijzU2fjDmWB4gK1S13Rm/Qn0cHpOot/YAiqxsgTkfSzLlzp2Wlg==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by SA1PR11MB9636.namprd11.prod.outlook.com (2603:10b6:806:4dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:09:48 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%3]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 14:09:48 +0000
From: <Ariana.Lazar@microchip.com>
To: <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<Conor.Dooley@microchip.com>, <Jonathan.Cameron@huawei.com>,
	<robh@kernel.org>, <linux-iio@vger.kernel.org>, <andy@kernel.org>,
	<krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: dac: mcp47feb02: Fix I2C address in
 example
Thread-Topic: [PATCH] dt-bindings: iio: dac: mcp47feb02: Fix I2C address in
 example
Thread-Index: AQHc0LGDgLzLphmZ90a/ZfWqU9OBILXn32kAgAGwNwA=
Date: Tue, 21 Apr 2026 14:09:48 +0000
Message-ID: <3b12b49f8dfa8bbdd4d19eed8718a2f10a294ecf.camel@microchip.com>
References: <20260420-mcp47feb02-fix6-v1-1-ae1808fea11d@microchip.com>
	 <20260420132248.466cdc84@jic23-huawei>
In-Reply-To: <20260420132248.466cdc84@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|SA1PR11MB9636:EE_
x-ms-office365-filtering-correlation-id: 001ff5f6-005e-48af-3d08-08de9fafa5d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|22082099003|56012099003|38070700021|18002099003;
x-microsoft-antispam-message-info:
 vpg2uJCqJbLBzyOjSRsdvH6HcGaVwp7bEk/b2/p1sRBhnlVDcrln3bbGVSLPxNbcMAiTztqBguyyP/oXd7DUjtr2YCcB3o69KVYQiCogDUM1wi7RjrMA7e4Fp4qiOx6yPvxTiXIgayK5X97OrpfFzA3dbRCkuSFODkU8apoOwg5YxZ2N7e7VaIp6n/rCjJmVxzE+TgWKToaCuIHwDsC7mcnokkKDFyEOIitZvegBzOMQf+ytnyZA17UHlKt5u/FlgPh8+82qq4vnJqmUsZdU0vLPDxY2drVLCS/ER+SkkYkYxwxmzNzhAjckybCIaOmQBjcTuKEZ5TnL7o3w/yddgD0aH2TsMHcoFBuCFMrIzMr2nayvev/v0l4/4aipyAmJTRbISEAUXci4WXi9zIWtdVaHZnPSdqmgJoo3QZOkOEoS2Hs5sk975X1yuxA/fGp3fOI42Pph1CvDoJUl45tVDBXvIXcdUa5wlIQ66aLrFj0Okvnm4eGwNMHcvcYR358U5SfSeiLg5xPxGEAsgeFRHmddkEht25vX+Fg/ixhsxP4HdchFXqBmSnPtsF1izVoLNH6QoT4x8vlQ+TM6Eyc+1q1h+lxquJdRNl8BkjmReSNg+iKF25rs1W6OVDOFiNhbKOl+qJKfy/xeIfcYUwSfKYKrI6A9e8kUxWBmptczGnzV6tekHgoVADWxGUDfKKfYoI+i3PmFqTG0JJ5bVroHPX88YZRVavENXajMP868BO+3bJgkTkAWQJ1L5GVbdL9vOLUOmmj2MVOJII5kDk5wHNnT5vEBTciwOfMEMYTIhGA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(22082099003)(56012099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eExnUWJRTDZzN1BYKzhmQnZiWlBiaGRxT3ZHREFLNFY0QVkzWnV1Y0ptUGlP?=
 =?utf-8?B?YWZnU3BlQVo0U0pzNktOMHdzUDB0akI1UEdJaDJWdkVtSGJlOE1FblZWUjhs?=
 =?utf-8?B?UFh5bGExNjkrS3djQ2FIaGlhYVdmdkJrOWFibmVBMmFIYlJpU0J1UFRJcnIx?=
 =?utf-8?B?RndxRkhveUlVbzUvaGJHandzWGJrSjVoR0tTUWthT3lJZ3BtMHJPVzdsaHZO?=
 =?utf-8?B?UE5pYjFUTkptRGpRcGVSUWlOKzVhbXVPS0QyWGVMR3docGJHN0hZYW80eXEz?=
 =?utf-8?B?cHdRdHVGdzR5ZHNpMjZNK3ZtQ3hvTUJGVS9wYll0cno4MElUbWNad044SnFC?=
 =?utf-8?B?WmRaRldSN3JtZFUvNUJRRXN6UktTS0lOQ2x3L2tWMXFmbUwzKzQvSjUySWYy?=
 =?utf-8?B?Nm15K3NHSWFqR3RVbENGdHRuMlg2ZHczZmdyN1ArSDU1aUNBRmRTMjJpbmxG?=
 =?utf-8?B?TmNxTmVIa29EY2hFVTh1b1c2akVMdTE1M0F2SVVXelh0OW5TLzNXU0MyWWEx?=
 =?utf-8?B?TVJKbmtPWEJaN0dCVkZFdEZXZWk3NHhydHFld2FGZ3NpR1d2UzdJNC9icWVh?=
 =?utf-8?B?dkdHWWNTVmhEYUh5THBSUEJGV2R4c0JEcjNMQmU5TTloZXdwcjZLK3BOaE9G?=
 =?utf-8?B?YzV1YTRUaVQ0YkRnSUZSZHZNZTNEdmlzVXRTZ3hzdWdBcm9XWWRDTmNhNGJF?=
 =?utf-8?B?TkdQeG1zSm5MdFhHTkgzd0h0dklHRDVDQmVQeVYzYlZ5UmM4Z3BQbkNJSkV5?=
 =?utf-8?B?UkNsa1BWS2Z4dEZQV1UxamJLUUlqb21wUGNIMG85RHN3M3BJSzBIQlNZb0Rr?=
 =?utf-8?B?ZlViUUh6MW1KYWxGMW5DakhsOVBJVjUwQWs3TERWY2hKQXpXZGZHemxVck5N?=
 =?utf-8?B?c1lyUXBuQkE1UDNNMDBJMUwrOG9PRnJudDlxQ0s4RmpHekVickJ1dnVqOXFq?=
 =?utf-8?B?RGxsbU0rc0Qvc2xlTTRodE9FT3kwZ0YwbGdSSE1BS2JjSUhYV08zdHRwUDJX?=
 =?utf-8?B?bjY3VGw0ckJjQzMrVnNSYjBJLzdvYjh3b2kvS3J3a0dVR1k4SGRzZ1laVmV3?=
 =?utf-8?B?SmtUbDlYVzY4ZnJlVVh5MUhsaUN2VW1CWmp0NDR3U0xMMHU4L3dOUFRKYWVZ?=
 =?utf-8?B?K3RWVXM4dzVaRnV3RlF0YXRrN3V5OHVvcWV6VzR3aktVZzhlWmZhd3VYVkNt?=
 =?utf-8?B?RDY1ZDYyY3lUaGVMcDRYbDBaSDBQeEZYUTNRMmpNSzJ1Q3hUcUZFczNOeXZh?=
 =?utf-8?B?bW1ENzFObDFML3FFM25kK2RKMjByTkYvWmdmc2tlMVZudXlQOHN4L2RFRith?=
 =?utf-8?B?aHJDSHJOOVZ5Q2ZyS09OQWMvc3RicklGNjcxTFBMajlSYUN0bG1RMG5XUGYx?=
 =?utf-8?B?RkFiejRxbFZaSVg2aEdtLzBsc2UzTy9KUHpuM3JGeG0wbWZQb01Ub1VXdnY4?=
 =?utf-8?B?V1dVZDZoRFhzM01QYXV3VklyUE1HY3habGVhd3l6aElDWUNVSXZ0MU1oaE9H?=
 =?utf-8?B?eDlPd3JjTnFCKzlUVFNVK3p0WVRiRzI5SVdLbTNNLzFSSzZJLzJtMnViWlpP?=
 =?utf-8?B?UUR0dmZOUnVwdlpudzE1dVI0aG0wZzkwTGRZaUdVSDRCZUsydTZWOXlmaXUr?=
 =?utf-8?B?NSs5REJ2QWZlRGJ3cDdYOXp2MkQrQTFLM0pRb29aVjhONjlIOE1tQ01NMUNP?=
 =?utf-8?B?ajhRSzlUa25uQnl5ZnpqWkovTXEzeS9SWjA3eWdFTjk4VHludjVRMU45NDk0?=
 =?utf-8?B?VmgwYmNKZ1ZWSE9QT3RORERWNjdXd0VicC84OVFRd1pjSzNCUVg0a2NTMzVk?=
 =?utf-8?B?Z3Q0VGJwQWo1eDF2eFB6Ni9OKy9uMVRuQU9wY3d1R05xL2FrdnVsZjcvWjlw?=
 =?utf-8?B?K3JFekdCaE5wa0Y3L0U0RGFRSENIWE1vd284eWJnZlhic0g2bjFsNTNST1dP?=
 =?utf-8?B?K2xNQUdlWlo3bXF2UmpqWlBEKzNNZTdDK0RZZ0dCVW9JWXU3UUoxVDBhLzJ3?=
 =?utf-8?B?Wll6T2syMG84MG5Rbng4c1R3VW1zcjN3VU4vSWFoQzZMNDFUWDRHTVFEOENv?=
 =?utf-8?B?WmdTUjdLSVdIcm9hYW9URE8rVksvbWpvdnNLWHI0aUc4THRFYnNwL3N5bXJs?=
 =?utf-8?B?U3l2ODUzYk4wZmdSNjIwbnZIUlVHYTdYZEN2aVJmY1lsVE1kK0tFVDNZWVNh?=
 =?utf-8?B?Vjl5cWhpRi9pN3JKNkFwTFRpbHo5Y0JnUXRFNjFYUGcwRGt5YjV0OUlCWUtV?=
 =?utf-8?B?UE1mbHVOUTR6Mk9wZm0vUW1EbUF5U0tzZ1lHSUtXNXNHZWpaMElRQk8vSXJj?=
 =?utf-8?B?WWNXc1d5bUN2OFE2a1dPZUVYUXVqdisrb2lBMGhrMm95eCs1RC93Uzl0cENj?=
 =?utf-8?Q?+T8xQ6tP/K+vgQUE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF1DCBD98325F64F8CDE65D8CBD1CAD2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8251.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001ff5f6-005e-48af-3d08-08de9fafa5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 14:09:48.3258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SmxozcRqASryAa24bH530cAU5oCUU2CdLHsm8ibUnlZ4yj0kCwHxG3YPe1qz+IOzv/gLFK7CQtV4VInAxAWiWyNzLOf2AH3TYm/U5DqWAJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9636

SGVsbG8gSm9uYXRoYW4sCgo+ID4gQEAgLTI4MCwyMyArMjgwLDIzIEBAIGV4YW1wbGVzOgo+ID4g
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDE+Owo+ID4gwqDCoMKgwqDC
oMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsKPiA+IC3CoMKgwqDCoMKgwqDCoCBkYWNAMCB7Cj4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLG1jcDQ3ZmViMDIi
Owo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MD47Cj4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgIHZkZC1zdXBwbHkgPSA8JnZkYWNfdmRkPjsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqAgdnJl
Zi1zdXBwbHkgPSA8JnZyZWZfcmVnPjsKPiA+ICvCoMKgwqDCoMKgwqDCoCBkYWNANjAgewo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbWNwNDdmZWIw
MiI7Cj4gV2h5IGlzIHRoaXMgaW5kZW50IGNoYW5naW5nPwo+IAo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmVnID0gPDB4NjA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmRkLXN1
cHBseSA9IDwmdmRhY192ZGQ+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdnJlZi1zdXBw
bHkgPSA8JnZyZWZfcmVnPjsKPiA+IAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1j
ZWxscyA9IDwxPjsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqAgI3NpemUtY2VsbHMgPSA8MD47Cj4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgIGNoYW5uZWxAMCB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZWcgPSA8MD47Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsYWJlbCA9ICJBZGp1
c3RhYmxlX3ZvbHRhZ2VfY2gwIjsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDE+Owo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgI3NpemUtY2VsbHMgPSA8MD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjaGFubmVsQDAgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8
MD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxhYmVsID0gIkFkanVzdGFi
bGVfdm9sdGFnZV9jaDAiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+IAo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoCBjaGFubmVsQDEgewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmVnID0gPDB4MT47Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsYWJlbCA9ICJBZGp1
c3RhYmxlX3ZvbHRhZ2VfY2gxIjsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+IC3CoMKg
wqDCoMKgIH07Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFubmVsQDEgewo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgxPjsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbGFiZWwgPSAiQWRqdXN0YWJsZV92b2x0YWdlX2NoMSI7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+ID4gK8KgwqDCoMKgwqDCoMKgIH07Cj4gPiDC
oMKgwqDCoCB9Owo+ID4gwqAuLi4KPiAKClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4KCiAgIDEu
IEkgdXBkYXRlZCB0aGUgZXhhbXBsZSBpbmRlbnRhdGlvbiBpbiBvcmRlciB0byB1c2UgY29uc2lz
dGVudCA0LQogICAgICBzcGFjZSBpbmRlbnRhdGlvbiwgaW5zdGVhZCBvZiBtaXhpbmcgd2l0aCAy
LXNwYWNlIGFzIGluIHRoZQogICAgICBwcmV2aW91cyB2ZXJzaW9uLgoKQmVzdCByZWdhcmRzLApB
cmlhbmEKCg==
