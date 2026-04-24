Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723B3D6494;
	Fri, 24 Apr 2026 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037473; cv=fail; b=ZfmiIif2gcmf7ORtXjF9NRUkp9olQhdWNowGuCad6Xpe5c8bngBXl+kuesYpVWflnDXm4Hv01x/KN4yJxO9tNumbc8yps1p6u22rYE+G6DXSdTnjA+rgsoklj+dLSHet8tS+lhSkDoS2j1vQCh9rLNE1jDIrcxjq1h7ZUk8X8OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037473; c=relaxed/simple;
	bh=EXyGKHxPN4burkMCFyyHtgH3/H2bvN1G2ai9FlHQjuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GuaD1/H9IAgh4MFSHvDeyQR790w85Povak0MOGKTE//jzlPReXpcOvBzznwBbgT6Wo3jN1MBheq1DRyoL6vFNsj3YjO/lepI3W4i5oIW4fFxBqT6diSjR4BnUNjAhgHZ1+nyXDftsFI4CvquPsXX35Utk33aMqzV/pFNLrqYqb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Dzgn4zLA; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Dzgn4zLA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaPwEHrDUXOS1M/kUd4cIsrqeigiac71MOL+l2sjbznsx0JFhZ4JkaCODii8f36dqhsXRreNYeQmvgMZ8Vthbn5eTpq7UwikTDoEpef+n2ctt3Q26xyYZisnViAnZF0DEztiTTQTzwPHKyOm8UVfoGdaG3reUsXGdujKmL6+J6Ds6fEfxHoCR/60ZsABCJSeJPm5MTjrALKp8h9S+w9iW+rDh4Xf1J0+shahvfhCR51ZJLb7XxBT3Qdf3k3gxDBzB/dKy8mxjeWSLyudZFYaOlFkyb80kvDitSRsCCBOMB63f/aGndxS41whav5SvkWDwic/XMBOESCLwrqbyaPZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXyGKHxPN4burkMCFyyHtgH3/H2bvN1G2ai9FlHQjuw=;
 b=dn2ltIbluQtbmBDVR6yA0VPuFKTx2W1otNAdjq3MtNiGSNq7vECKvJvSepf6kH73jdU83wwTDJsGeLRI3kyX9RZZYjA/wehQFPP/ZRu0c5oIEUGQ17ici2jzT+O23bi4nPSF80E2EvOLF3KxmaAa707e6az70IqnaWCnwSJFccRGo32Vd7enA6s/RQ+4BxQbvrfbFwL4jp/EbIuzaAFJQxQtzWQKnCcRkPzyI9zDILb/w5YDDR8IPkox+kMdnTrx37y+S3elazHCTImUf9YAsCCV0ZPJ5Eq8EwgL5cy0yEvsLRiZ4E/ZimOJfNR/NxTyOBEFTty9zed4znbe6V61Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXyGKHxPN4burkMCFyyHtgH3/H2bvN1G2ai9FlHQjuw=;
 b=Dzgn4zLA9PYDbPyFFbUu3cK7or5tFyWgIjL4OnVMLwgTLj7Y6WcbAJ8yNB9DhfeBhhn1xnGBU5/wL2RpvZ2LIqn4ytdcRnPvfX5UzzKEuxjchsdShXzSZV+Hly8EBfEiYG/cDmJSB6gwSzgNF1DbX31vdNp6gLVWwVBPrkk4z35DibXNG/B9QBafeLsL9kImwJrkkJcofYkJniIE0mAdpiYIHD9d6n3oWLADxaI3bNUwGQuebKYf300W50DHDHdCZ6F2+uWnkmqOfuKyiaxPvTBLQ3XlsuHK7ksSWRFKxXZVbYEy1JFgV4b/izcTPkzsZAL8USKRdQ74xqe8cFGkrg==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by MW4PR11MB8266.namprd11.prod.outlook.com (2603:10b6:303:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 13:31:00 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 13:30:59 +0000
From: <Ariana.Lazar@microchip.com>
To: <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Thread-Topic: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Thread-Index: AQHcnB4CEkxJgPuKSkiQaY7LrEYHMrWEEUaAgGo3ioCAACaUAIAANYqA
Date: Fri, 24 Apr 2026 13:30:59 +0000
Message-ID: <3ecc683135c742e097ec6ba91f275cbf5d8202ce.camel@microchip.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
	 <20260212-mcp48feb02-v1-2-ce5843db65db@microchip.com>
	 <20260215175857.4085bc2c@jic23-huawei>
	 <f7f45b4327c9ce5c806cd878bd9b53e8fcbf7785.camel@microchip.com>
	 <20260424111920.61765602@jic23-huawei>
In-Reply-To: <20260424111920.61765602@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|MW4PR11MB8266:EE_
x-ms-office365-filtering-correlation-id: f7f1a43c-f018-4b99-0456-08dea205b922
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 g++u80jgylHfxfvnKmq6ALMdNz+esWXpLuk5x4NDFJRA0Cihlj/Q5ZHzKez/8A/MVOschvDG2GuFZRbVdIGo6CCDS7SKqgbghxOPbGEh7M2SDqkDoGS+LXQg2ceTC92Mx9cYGZDL7TQFukLmBObezNzhcCrcYlWbyQ45y8i4Ta/1dDiv6UGdcZ2nTK1DYksjAyva74Qd7h7nW0yCeTpbMi1AywDiJGxl/88C2yg9iezSzTn6LNnFmDJQUmDiF/wiivPbKBtg79UBXWmZIR2P5IVxJqx321D4ioRapHacQjzlw3Y0eNDwJxspd4kc4jRhSkZ6Q3BvIDOrnIsRCA1CcMGfE2Ocf8EFyG3CUl7mGJDlkdeLqdpMM0hwV3dz8AyGm1rkMc/jH9AJUT8G+bmRpkNeTAxNwoTu0QvEBqqS7tiINCo3kCMctKCaRTrIWGlQIBg42yh0qNPtnnKZfFEE/5YBX0JF0A6SUC4l1Kl76wiEDhhAw+eScWkJ2wX5fXs1zjLpOkbu4KBnKFtHGozsd/6ap9TPl5ix54QPyjC+rrMY6eOHxEtJ2bdVW/bzHrkh/Hwl5L7W87BgsPC050XEBtYMDQl3yOACg0R4KF//Abg9oBE3EvN59Qa4YegpZzRn+3Gg+SjIBell3uJOxl10yJv4KhfZVOw9QX29aJAh3IqV+Sq31ZA2kourzJuluJYx9tL2SFLln+2V+DXNQTEof2Vn6yWoQKUISIodhXrppLUcQAU1742gJrfcui0PMy7dp0LhLOTPFv1TkkO+JfW91Lhoq32zNNv36xpb7MUN/vs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmxQRWp4dzRUK3FiME9OSU4rVHJGc2gybHV6YVdndzFHalZ5SWF0UTArbDFx?=
 =?utf-8?B?WDhSQlVHU0l3aTd6Qlo0di9XaGZDZzJ1NmJRRlpRTmVwaVE0ZmVIM1A3YnhE?=
 =?utf-8?B?aFl4Uk1Sd3QrMnp5d2ZwNWpFU0o5MVVHNEdOd1RqYVQxVDZ1cGFvMDIvNUw3?=
 =?utf-8?B?R2thd1RhZnVvdFkvVEVxTTNOajJ4SmdEZkljdVVpdTlkRzhheTlDMXg3NmI2?=
 =?utf-8?B?MFJMbzBpK1VoRGUxVUpOS0VJd041R2lwMnJiY3pKeEtyaXpDaXFLTFViNENx?=
 =?utf-8?B?Ty9waFhKR2hKTTlqWDhGQzFiYnh2eXVMS05neEJqU0xIRFBGd2w3YWIvS0Mx?=
 =?utf-8?B?aFc0UXVpU0Y1VWJJUVRQNnZ0Tzc4NGdhbFJXc1oyVC9TVmtLT0RGaXdHaWlD?=
 =?utf-8?B?V3plTE5hRzVIa3NVMjFhbUFjaEFlS0w3NWFSL0xRR0Z6TnhPc0RHV2RLUWJC?=
 =?utf-8?B?aHBPMXlEd1dweFhqTDBYSHoxa2oxZWdPTFVmNGRkb0JCRkRuMzRDREltbjJ0?=
 =?utf-8?B?SS9ibm5GTDNVdmpqTnFKMFNON2dHVHd4dThhN0hlbGZJd2E2dm9zV0FlbUlO?=
 =?utf-8?B?WG1mbG9HRFYwRjBSeWFhU1BoTmpXUEZ6V01TWENuTTNURjlQV3Z2cTMwT2V0?=
 =?utf-8?B?QlN3Y21USWpkS3IzbDdQSzZUOTNjT2d4Mi9NbmdQbisxcGc2aXVxMWo2WDk3?=
 =?utf-8?B?NE1Hc0Nod0RhRGJsL3FNZUNzYzNWMkFESjBGeG5RYzFXNXJjQTJWT2tkR3JX?=
 =?utf-8?B?cXQxclFTalFwTUtCMnVZdW9GNzNpZENaQzZzbVNxWUhPRnd3WmVyTVJWd1VM?=
 =?utf-8?B?UWI3TnlvM2hIdWlTWmxuRHN2M0hJYy9xY25EU1VJUGpURWFUQmFSL25KNVFO?=
 =?utf-8?B?WFY1U0JEdjA3dlRiWS92WkRaZ3ZodkZoWXhESUZuSU52UW5tVWUvMHVtQXFy?=
 =?utf-8?B?T1YwYjdRa1lwZ3UxaHNnNXdzREhzVGxGSjVLWUc1UkJvU1pVT1Q3ZUJRRWhn?=
 =?utf-8?B?NW5BRTNZR29McDFKNEJhZHhOTDNzalpCKzdYK1VnNnNwVEZINDVRMkJ3V1hV?=
 =?utf-8?B?MldNSlhVRk00aGdtMU5ZU3dKc0tLUXFiMmNETU9Ca0t3QjdKLzJzdE5qdldM?=
 =?utf-8?B?VnVxRWJMUnh1QnVnUnZBOGFvaVRlR2xKd1BZVDlUTnN5cmdIVkdiRHlNa0wv?=
 =?utf-8?B?Wjc1cFhnMTlOSFpxKzlzbXlKUDByV3NySmMzTDc5eTluWG1aTDM1aksvTHAv?=
 =?utf-8?B?MW1wYzFiekYyWUN4MWhXKzZlT215cDhPMmhFalBWbzNhN1UvS2IxSmNyQnR5?=
 =?utf-8?B?bXl1SHpVUGYyUnBJa3hQY3d0cWtkOWJ0WFdSVGhadUE1SU8zR0cyakxKNjk3?=
 =?utf-8?B?c1pTOEsrZkNpejhqRklVTVVlaXRJT2Z2bGdwU1FZWi9hMXM1TFRzQWNVRUV3?=
 =?utf-8?B?UzExeXF1MmZ2Smk4MkxXeXhIRldXY3dZZUN1QVNxZVFsYlpGSkdOTkJPd0ZX?=
 =?utf-8?B?SXNMREdGbXgyN011OTI4U3pFWE9FRFQwWXZzQ3VyUjJEazFMYkJ3V0pvTThw?=
 =?utf-8?B?a0JxMDZiUzBQMjdiUHY2SzJ6Z1doSXBZcUlwZ28wVDNmZVppTlpSM3RQTkFQ?=
 =?utf-8?B?N0ZBZEJ0c3B2aGg3STM1dUJiNCtxL3o5QlkrWGU5aUI0R0pNbEszMG4zQ3Z4?=
 =?utf-8?B?R2NqODFUaFNJbVM0SUVQWk5ZMEVpMjBIWjByNmphVFVOVVJtb1pvYWZiN1NH?=
 =?utf-8?B?SXQrQjlUenU1RkdwTzhzd1k4bjAraWVBeWloRjRwRkg3QXhYeXgyekdhSERu?=
 =?utf-8?B?TElZcFpmM0FJbG43dmt3QWR5S0I4cnoyNnN2c2pnNUhiOUhicWVxRVR6TGlV?=
 =?utf-8?B?VVBJRlZNTE5LK3BrWEtxcnoyY0lUaTRnd2lyb201akN3R1dUTlhBM0xTWHNV?=
 =?utf-8?B?RFRFdy9JeGZ6ZFB6ZWU2bzdUTjd2SldHZ3pGSTNlK1V1azZEaGhoWEZPVXpw?=
 =?utf-8?B?QnZEbnM5cWNvVlR4ellNWlZsYUZhODcxSmhTSitPQ3BBNWVrY0hHeHBNY0Fx?=
 =?utf-8?B?VlE4cUx4UW1TcE1raWFZVFhsTTcxZnZGMzhDM3c1TkFrZENGVnh6WmlnbHFN?=
 =?utf-8?B?NGdGMldhL3BRMGw2b1BqdVpaVld3a2dkeGdEY3RNckZnMis0Zm1CWVFJWWNU?=
 =?utf-8?B?dWxzRUlpZ3RIRzBHYzhnakx1d1NiNVRLVG40cnNwNmJHQnVObUoySlJDcXc3?=
 =?utf-8?B?SlIwWE1hUnJncUE1ckhFNkpmM2lxQkh0MnRwNXFhVXdEaXhDTEJsQ2ovZ2Z2?=
 =?utf-8?B?eitFN3NCdUdpY0RveFkxRUV6aEE5NHJVQWtGL21XMDZTamFzSjB0R2hsa01G?=
 =?utf-8?Q?Y9rBVEuWtEqWFTMU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D172F66EAF79FD439FF7D69EB459771A@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f1a43c-f018-4b99-0456-08dea205b922
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 13:30:59.7277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6ze+Yomts0kKTQbRBSVNBFa8U+4ipd6tFWNs/R0QziEqCFwqkgy/ehN+S0s3H9P6BFMk3o84gxVduj8j+TK0JAE9Pbrs4dxPgssv9A2rCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8266

SGkgSm9uYXRoYW4sDQoNCj4gDQo+IFRoZSBzdGF0ZW1lbnQgYWJvdmUgYWJvdXQgaXQgbm90IGJl
aW5nIHBvc3NpYmxlIHRvIHVzZSB0aGUgaW50ZXJuYWwNCj4gYmFuZCBnYXANCj4gaWYgYSB2cmVm
IGlzIHdpcmVkIGxlYXZlcyBtZSB3aXRoIG1vcmUgcXVlc3Rpb25zIGFib3V0IHRoaXMuDQo+IA0K
PiBJJ20gYSBiaXQgY29uY2VybmVkIGFib3V0IGNhc2VzIGxpa2U6DQo+IA0KPiBWcmVmIGlzIHdp
cmVkIGFuZCBlZXByb20gaXMgc2V0IGZvciBpbnRlcm5hbCByZWZlcmVuY2UuwqDCoCBTaG91bGQg
d2UNCj4gYmUgdmVyeSBjYXJlZnVsIHRvIG5vdCBlbmFibGUgdnJlZiB1bnRpbCB0aGF0IHNpdHVh
dGlvbiBpcyByZXNvbHZlZD8NCj4gSXQgbWlnaHQgYmUgb24gYW55d2F5IGJ1dCB3ZSBjYW4gYXQg
bGVhc3QgbWFrZSBzdXJlIHdlIGFyZSByZXBvbnNpYmxlDQo+IGZvciB0dXJuaW5nIGl0IG9uLg0K
PiANCj4gTWF5YmUgdGhlIGNoaXAgaGFzIHN1ZmZpY2llbnQgcHJvdGVjdGl2ZSBlbGVtZW50cyB0
byBjb3BlIHdpdGggdGhhdA0KPiB0aG91Z2ggb2J2aW91c2x5IGl0IHdvbid0IGdpdmUgc2Vuc2li
bGUgb3V0cHV0IHdoaWxzdCB0aGlzIGlzIHRydWUuDQo+IA0KPiBJZiBhbGwgdGhvc2UgYXJlIGZp
bmUsIGRldl9pbmZvKCkgbWFrZXMgc2Vuc2UgdG8gbWUuDQo+IEkgd29uZGVyIGlmIHdlIHNob3Vs
ZCByZXR1cm4gLUVCVVNZIGZvciBhdHRlbXB0cyB0byByZWFkIHRoZSB2b2x0YWdlDQo+IGJhY2sg
d2hpbHN0IGluIHRoaXMgc3RhdGUgYXMgd2VsbD/CoCBNaWdodCBwcm92aWRlIHNvbWUgYWRkaXRp
b25hbA0KPiBpbmRpY2F0aW9uIHNvbWV0aGluZyBpcyBtaXNtYXRjaGVkIGFuZCB3ZSBkb24ndCBl
eHBlY3QgdGhlIGRldmljZSB0bw0KPiB3b3JrDQo+IGNvcnJlY3RseS4NCj4gDQoNClRoZXJlIGFy
ZSAyIHBvc3NpYmxlIHdheXMgdG8gaGFuZGxlIHRoaXM6DQoNCi0gS2VlcCB0aGUgY3VycmVudCBh
cHByb2FjaCwgc2luY2UgcmVzdG9yaW5nIGEgbWlzbWF0Y2hpbmcNCmNvbmZpZ3VyYXRpb24gYXQg
cG93ZXItdXAgc2hvdWxkIG5vdCBkYW1hZ2UgdGhlIGRldmljZS4NCi0gQXMgeW91IHN1Z2dlc3Rl
ZCwgb25seSByZWFkIHRoZSBleHRlcm5hbCByZWd1bGF0b3Igdm9sdGFnZSBhdCBwcm9iZQ0KdG8g
Y29tcHV0ZSB0aGUgcmVsYXRlZCBzY2FsZSBhbmQgZW5hYmxlIHRoZSByZWd1bGF0b3Igd2hlbiB1
c2VyIHNwYWNlDQpmaXJzdCBzZWxlY3RzIHRoYXQgc2NhbGUuDQoNCkluIGJvdGggY2FzZXMsIGlm
IHlvdSBhZ3JlZSwgSSBjYW4gcmV0dXJuIC1FQlVTWSBmb3IgUkFXIGFjY2VzcyB1bnRpbA0KdGhl
IGNvcnJlY3Qgc2NhbGUgaXMgd3JpdHRlbiBmcm9tIHVzZXIgc3BhY2UuDQoNCkkgd2lsbCBhbHNv
IGltcHJvdmUgdGhlIGN1cnJlbnQgbWVzc2FnZXMgaW4gb3JkZXIgdG8gZW5zdXJlIHRoZSB1c2Vy
DQpzZXRzIHRoZSBjb3JyZWN0IGNvbmZpZ3VyYXRpb24gYmVmb3JlIGF0dGVtcHRpbmcgdG8gcmVh
ZCB2b2x0YWdlLg0KDQpCZXN0IHJlZ2FyZHMsDQpBcmlhbmENCg0KDQoNCg0KDQoNCg0K
