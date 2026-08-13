Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2037646C;
	Thu, 13 Aug 2026 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623433; cv=fail; b=QZSfLZnL+zxXsFPV/V7uGYtnadx5FAzrsPKZ6+VIOkGfoTB0Kjq0R39GfrwLvklg4psB2oUtaHhg4Gu+yh1iLtLvb38g/KfyiBwsYQd2ts2CQltr2YqPYOD8ruuRXori4RjG5I82zWgBPLk9kvtab9CCGt5ZDQnNzkEDQ2JU9Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623433; c=relaxed/simple;
	bh=rTEncdleC0vnVfvxN2lj6nJy9V0rXoCi+2vW4b3BUG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=To5qGKk6YmPjuGqFdPm8XBJ8ofd/PlafGIffgrd+EneothsANNe6olkbj1eWS60GMX0rcSNzIVzJbm4vqo+K09QHz1Z6pzBB37y1WO0EHynEADA1CgiixnFW26gjl7IAzq39Zm0daz0T7fJn/07/9mO0lh9atrbyb/uwpmTiJTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0KK7bVVP; arc=fail smtp.client-ip=52.101.85.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0KK7bVVP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvqrtzZMifhAUpVKnJlQHW5WMwUp9pHVaXMyNQB1yvlNsZ6SjqJblUPeSpl0VLNMW5gra+nwQv7S0HyiZCpU4cRPCg3Iat7cC0eh2FaBtSwP4WkVMAvYkSptD+gkeh4lQH6I/nsQ7IbEleAiirQk8XtoP6rpTY+BoOT8JlDXOFmtidyHDRk1BIe+5hcYvL2KxzmJpDDxCtuWHxYeyIlcHITI1kduU44BkWSdWNlj7VBJaN5vatreRtmLtqlL37j095qZfbX+Bva1OnuKjCDqKWgz8lU8FSSrc3HwrYyLxKmjL95Xeo8BDXXUC9WktXDdfW+9jBXHLbNUcjWlbj71nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTEncdleC0vnVfvxN2lj6nJy9V0rXoCi+2vW4b3BUG0=;
 b=chaIF1uRiKZ3xyAHpSOt4eWM8cC+lBJxDbw0qyUNCX3ztY+IUT/bc1V5mdbHnbhxOkPghtnIHCv6aERCJvdn/IVVkpUXO0ieZhPCeA1JlmCSWRnfd0HSK99m4tp1Z6NV8O+4l8jCM/e4izbulk+AE97Um1GWfBAbEFYhjn80LtbrEDCu1WBx0eyHPGDRymXghKMhOjaAn70rssN49GKer5yuX9Fpma+CmxBubWTCwkR+pD0tEN79y0BTq1srU9Kebdsw1kbH9KPfAS5eDYslEidk3ZEUa6WYM6Kx4viGQoaUaftRMXJJO3ieCNHIOnQY9uFsSC6JFO+aXaKvMOL+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTEncdleC0vnVfvxN2lj6nJy9V0rXoCi+2vW4b3BUG0=;
 b=0KK7bVVPqWdhAJkBJdw2T6HtOQYQRJ9yvSEGAbZFCw6nEcREioR9qAXS9b2+hmEtsE3NfrYbBaKOcR8JQwv3zuhEJe3VtN9o+5qPdV3UHUDHJK0fSwPTvWGQySQL2Ryj9pcUY+UXJADUmpo+BJMO4rUGLdMSb3XrZos/OzsYzJgEe/DA6AFzM4LJt7BGezM139dGkWmIM4JiPk3ssAxIPalWLnnouUMDZKcUJ0iWagSKbGu2mXjTQ287VXnBq+d4S0jqlx35g3bsDaTyUfyxE+DmXEYk9hUPqjSuMfJAIWRo0yV9hzyjFYNsnUUIaushxtyVQCagUUZrMywB6xO+Ag==
Received: from DS0PR11MB7624.namprd11.prod.outlook.com (2603:10b6:8:141::6) by
 PH0PR11MB5831.namprd11.prod.outlook.com (2603:10b6:510:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 12:17:06 +0000
Received: from DS0PR11MB7624.namprd11.prod.outlook.com
 ([fe80::33b1:3e53:2b94:9990]) by DS0PR11MB7624.namprd11.prod.outlook.com
 ([fe80::33b1:3e53:2b94:9990%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 12:17:05 +0000
From: <Marius.Cristea@microchip.com>
To: <andriy.shevchenko@linux.intel.com>, <jic23@kernel.org>,
	<maxwell@maxwelld.cc>, <linux-kernel@vger.kernel.org>,
	<sakari.ailus@linux.intel.com>, <linux-iio@vger.kernel.org>
CC: <tduszyns@gmail.com>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
	<jean-baptiste.maneyrol@tdk.com>, <andy@kernel.org>
Subject: Re: [PATCH v1 4/4] iio: adc: pac1934: Unshadow error codes in
 ->store()
Thread-Topic: [PATCH v1 4/4] iio: adc: pac1934: Unshadow error codes in
 ->store()
Thread-Index: AQHdKvQSixpbjgos00+dfhFKCqXRVLab5WUA
Date: Thu, 13 Aug 2026 12:17:05 +0000
Message-ID: <0e2d7ca13a094adad2ade12ef603deefb37cf0f9.camel@microchip.com>
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
	 <20260813071912.2465208-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260813071912.2465208-5-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7624:EE_|PH0PR11MB5831:EE_
x-ms-office365-filtering-correlation-id: d9c96816-4c42-4770-b190-08def934ca08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|56012099006|10067099003|11063799006|22082099003|4143699003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 lFzNhBZJO/uKvroOVVXd2WG1C23W1S1PH4JpH0YJxxRoDKFORcpTfGgXduYkABGG3a7PI4qQdxRSpuxisNcZzV4Vyr/xxyTpwX5l80Y8M7oTIu5p0D5A8tTurifPq0Gkxw1ouGfWK4/ObcHGBzVjVxH/K3t+LohlGs3dCN6czaItxPczeCd7yHxD6LPB1XFaiY9mevb5u8cJQHfoud08Uosnt0CRhD8b8U7spv7vscpzwndIJdIKhnxMuVzMpT4edPYs+kH+Jjq19M9GAggi6Cnc9HfluW4qDIY3Q5crH8yIMzvqDIpO3qty8ZgkFN5D/N+bWnUU2xOlLa3lFcI47Ras7ItbAGOV6ZtjZDOepKms+VRM5aV7yrFZS4kYbOlIBFY8n9SajdOsBtd1okGa/0ofppdcIwGGN9b7RW1T+lv4J+2mQ4nGGUUBEFQrr7PZdTJgcDTiaBnyXrF6LPxOcqpLe8S7yaHq1FmC3UdFU0TbcGpgyY9eX26K2r47OyKPOalYVhdKgvlljpTYVfViUIqZTyIEw2jyiEYo4why49lN+tQlepxVahrUVXyIvDvF91vDC1yUw209d+dSSW7xrEZ/+eqO5oZ0Jzm0ivFpofHTPiQ4yPkjr0gQMDL5QyVGNX+3K3mSJDsHvwEWkEVGOTjn0olzGEZcVCraW8ly3VvNG1+jjuiig+AqEtmJ20itGCPznB97M8eNE6W4ruGT9w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(4143699003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVp4SVRIWXlvdmR2WllKNUhSd20rSnlzVkU4OUZINTV6Y1RCZVhZTnJtSGt1?=
 =?utf-8?B?dk9iTkhjUCtQaFE0ZlBXSURTcVBlTlhBVlUwckRkcGptcy84R1NRbVMwUVNM?=
 =?utf-8?B?TE1Fc2hnWFY3R01XMDJNL2xjZGp6STNpc0pMUFZHYTBjTWczYktRbElOK3BL?=
 =?utf-8?B?MEJlbGtZR0VTQ01NM21lVWJvOXpnbVYvWVcvb2k3WjZHNTg2dkFHellMbyth?=
 =?utf-8?B?WW5RT01rbXNDYS9iWThvTmJrS0pYNXY4WVo1c1ZWMXdsU1QrL3lxYkovR2pw?=
 =?utf-8?B?ZjlvUURLRVRhYnFWSWk3WHR6dnZPRjZmOFhVWkFyaGM4RVdCN1RKYWRQY3BU?=
 =?utf-8?B?WUoxRUxZTHRuSEVJQU45UGZVZ2ZFdkVWalRqV2JBMVdSOHRZMElKWUg5QlZT?=
 =?utf-8?B?MW9FeXR2SklhbDBkeEg0NkVCR3IrUjI4K3FkdFR2UVgvb2lWdmpOeHJKVWxP?=
 =?utf-8?B?NWw5L0lTQk1rWVhVTlFaS3lhdStZNWtrTnpDWWQwVloyaEVrT2hpbUZwOTZl?=
 =?utf-8?B?VGNUMVVoNFJMNmJLZEs0dGR2SC9XT0NnQWN5MlZqSEVOYmpJeUlKbWtHQ3VD?=
 =?utf-8?B?TlNnRWN2aFVXdDNXVDFkaVVtSmE0K2hPRFVXTHZaazVJQ3Rpa1BJdlgwVmN3?=
 =?utf-8?B?Q28vWlo3M0pGQkJ4STE2MzUrV2dPZzNhYmVpd0ZoMnhzeVR6dm1NWjVIRmFT?=
 =?utf-8?B?WHBmK2VSTG8ybVVhZzZBZWpudHBMK3VFd3BCSW5OM3htZGkwcCtObjEvbElC?=
 =?utf-8?B?dlpHOU1UcHBPRk90MFI1MWJsM01jNU1QYkVBWUlvSW9DenR4blUxZkk3ZnRY?=
 =?utf-8?B?aVBjQmd1cm1GZnM4WnhxZ0lUZUFwVld5VHBsb0ZjV0U0S0RLOUJkZThTazEx?=
 =?utf-8?B?Si9Bek1XclFzR213VlNQY0o3WkhZcWI0d1ZMSUJmOXRVYnE5QVIxNXhvSmlZ?=
 =?utf-8?B?bDZDNEZKQjZMUFg1dzIvU1hYdlFNS1l1OHZnQ29Ob1E2NS9FTmV5SE1odmVq?=
 =?utf-8?B?bklxZ1k4cDBVa01YSFNOY0NGb2JBdzc1S2ltbGpReXV6TXFrR3FxTS9zNkdn?=
 =?utf-8?B?TFFUYWpxM1A5aXZVM3pObzZyTzI1R1RNRTAwNXRtWnBGMVFMalNZc3J1Zkg5?=
 =?utf-8?B?bXQ4TzBWYW1kMHgweEMrQUpoamVhbjZWd1l4QnR0bFdVU1BqNjFhWEsxdDdj?=
 =?utf-8?B?TFYrUkdRN09SRmw3OWltRlhFUTdiTk1xdDVXUWE5RjM5aDgyRmVjQy91TzBH?=
 =?utf-8?B?U1F6ejlzNjlCWExaUVE1OEpNSmx2ZEhSMEVkUWREQVF4UVhkbTlqRU1nNmdn?=
 =?utf-8?B?ZVBMbGhTYUlpTUdTOXBvSTUxUGViZGRjRDY3dGo4S0g0MjFoa0NabDZSdFhq?=
 =?utf-8?B?alN0SGR6YnlKUDBmenVoWER1THNpcUlmaElQSzFFQ1BHSk9OSDVacnJLWE9n?=
 =?utf-8?B?ak9LK0V1aGNDc200c2Y1TlpxRkZ5Q0plOHNFb2FHQ3N5RFhjSmx4emowMm9T?=
 =?utf-8?B?UjJKMzZYYVdRV3A4bmRQaEpnc2FBVWhzMU1YSWdSVkwyMlR1cXVSUVkxbGNn?=
 =?utf-8?B?NWYxUTdJRThwWWRaRHk3M1dFNDhwSVNVUFVtWS9sZlNIWTNaVWNnY1JxazVh?=
 =?utf-8?B?VE5HeHBDS29hNDVreUtvUHVUK2dOMkkzK3JtNVJvblpLUTRYSXNIenlDekYz?=
 =?utf-8?B?NHVrOGZoaGVhQmhYazFVZ0NIY2w2MGZla1lWcHBIMEovcVJsWEhadnNmbUxO?=
 =?utf-8?B?RDJIeEovREFlM2RLb2xOSHhNTHE1WENZb1RDMlR3V3JvRktBRy9zV0xrZ0Nk?=
 =?utf-8?B?MG5PR00wRDk1c3FmaEdyeVlMaXFaQUlvRVRrd1ZNWFBFa0VrRzgyWkh0Y3Jq?=
 =?utf-8?B?dFZOSEdvUzJUOHBmVmhwWjN1dC92VnRQYVFwR3pzMGtKM1NndlZwcUJUU3ZU?=
 =?utf-8?B?blo5SVA5b0VGUWZYVDJZdSs1MnUwVS90cTJ3Wkpsd3ZNWC8rRjZCL3RBZHZy?=
 =?utf-8?B?TTBuejJaaXJBMVZYV2FJRUtJd1F1bXJUS0dhOTFXVzlRdkV0d2xCZHJKeXN4?=
 =?utf-8?B?eHc5T29oQXp4UmdEMW5ERFJGMWEzemxTRmFIWTdUM1hIUWpkTmdXSCtQdXlP?=
 =?utf-8?B?M2xyczBFNXpCSDc4NlA3aitmY3o5Ly9ZUlJzQ1p3ZWtYRXNZK1U4MFhLRnFt?=
 =?utf-8?B?aHhpQ2RKZ3YyLzlOZm5uVTY5QXNzUWpEdWZaT2hBbWd4d0h2OGxYSlR3VDZt?=
 =?utf-8?B?VXYxWHBmLzBBd3Q0UFIwVjZkWVRFMDdZQ1VERWM0NkdMcHlsZFF5UTZpWndl?=
 =?utf-8?B?N0JRSCtZdHFWcmdCVEUzSEIzcTBiREJpTVFCVk9tTEgxcndoVVNGb3piKzUz?=
 =?utf-8?Q?v6wzKhy7T5lK9FyU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF9D2E53AEB5CC48BFAC02A244E73EEF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c96816-4c42-4770-b190-08def934ca08
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 12:17:05.5772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQfteno5rf+atGh2uEZ2YEYyVgHU2zXXJEJcrrWfJwOF8ntH4WsxYJuOv7avp5LOTXtyA4o6DXTk0BFNRe8NE25PNcnCKy69//KWLcwBXuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5831

T24gVGh1LCAyMDI2LTA4LTEzIGF0IDA5OjE2ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4ga3N0cnRveCgp
IG1heSByZXR1cm4gZGlmZmVyZW50IGVycm9yIGNvZGVzLg0KPiANCj4gVW5zaGFkb3cgdGhlbSBp
biB0aGUgLT5zdG9yZSgpIGNhbGxiYWNrIHRvIGdpdmUgYmV0dGVyIGVycm9yIHJlcG9ydC4NCj4g
DQo+IFdoaWxlIGF0IGl0LCBhZGQgbWlzc2luZyBrc3RydG94LmggaW5jbHVzaW9uLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5p
bnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvaWlvL2FkYy9wYWMxOTM0LmMgfCA5ICsrKysr
Ky0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL3BhYzE5MzQuYyBiL2RyaXZlcnMv
aWlvL2FkYy9wYWMxOTM0LmMNCj4gaW5kZXggMjMwNTU0MDVhNmUwLi4yZDkzNDQ1MmViMTEgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9wYWMxOTM0LmMNCj4gKysrIGIvZHJpdmVycy9p
aW8vYWRjL3BhYzE5MzQuYw0KPiBAQCAtMTksNiArMTksNyBAQA0KPiDCoCNpbmNsdWRlIDxsaW51
eC9pMmMuaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvaWlvL2lpby5oPg0KPiDCoCNpbmNsdWRlIDxs
aW51eC9paW8vc3lzZnMuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9rc3RydG94Lmg+DQo+IMKgI2lu
Y2x1ZGUgPGxpbnV4L3VuYWxpZ25lZC5oPg0KPiANCj4gwqAvKg0KPiBAQCAtNDk0LDExICs0OTUs
MTMgQEAgc3RhdGljIHNzaXplX3QgcGFjMTkzNF9zaHVudF92YWx1ZV9zdG9yZShzdHJ1Y3QNCj4g
ZGV2aWNlICpkZXYsDQo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYg
PSBkZXZfdG9faWlvX2RldihkZXYpOw0KPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGFjMTkzNF9j
aGlwX2luZm8gKmluZm8gPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgaWlvX2Rldl9hdHRyICp0aGlzX2F0dHIgPSB0b19paW9fZGV2X2F0dHIoYXR0cik7DQo+
IC3CoMKgwqDCoMKgwqAgaW50IHNoX3ZhbDsNCj4gK8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQg
c2hfdmFsOw0KPiArwqDCoMKgwqDCoMKgIGludCByZXQ7DQo+IA0KPiAtwqDCoMKgwqDCoMKgIGlm
IChrc3RydG91aW50KGJ1ZiwgMTAsICZzaF92YWwpKSB7DQo+ICvCoMKgwqDCoMKgwqAgcmV0ID0g
a3N0cnRvdWludChidWYsIDEwLCAmc2hfdmFsKTsNCj4gK8KgwqDCoMKgwqDCoCBpZiAocmV0KSB7
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGRldiwgIlNodW50IHZh
bHVlIGlzIG5vdCB2YWxpZFxuIik7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAtRUlOVkFMOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0
Ow0KPiDCoMKgwqDCoMKgwqDCoCB9DQo+IA0KPiDCoMKgwqDCoMKgwqDCoCBzY29wZWRfZ3VhcmQo
bXV0ZXgsICZpbmZvLT5sb2NrKQ0KPiAtLQ0KPiAyLjUwLjENCg0KUmV2aWV3ZWQtYnk6IE1hcml1
cyBDcmlzdGVhIDxtYXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29tPg0K
