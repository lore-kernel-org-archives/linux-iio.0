Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E502772D;
	Wed,  3 Jun 2026 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498365; cv=fail; b=bxO9bTSiUIqbqEjX5ZOICOpHk0dVQs8qIIvKHk9NFrB6sJh+bNJfEmDAtU7VBdXVdHbfhE4ZKLGMBnB5KaHUpDmlMTJ56Xi6ayhFaks8u+lxLlfasTUEfxQISjSIaW8QKCq7tDN8fybIZ5uem8s6hTUkmVtKpKlTgUg78ijZ3nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498365; c=relaxed/simple;
	bh=+wv2cBGJz1oE/9eJVgNncRnpBZX4WT2zQcNjp5kehkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CmyJ2UBMStIVI4m0WvqB5vawB5C8vLeZa2OgZiW27tXAZQuNqD/d/r3WVeUU4D5CrGwzOouIDYwxbD+oPJaINIeJqbwgEWT95fg+iqvVL5lp8UznL1RX+QAnb+A3lE3q4AowJYQ3uItqhAbJlH07o5XjiDbNHY538Sz5z8sIOjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z3HWchNp; arc=fail smtp.client-ip=52.101.48.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z3HWchNp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyIwIQfrxqpwVyvH2M+5CkOBCZ88z0qmzBFu45pNkizL+ADd7Ke9W2u2MwC7NgeCC87SGyz8DvMwz2luTwlm9fG43lThUNfBNvPZ1lic8I6YWqoCgvx7vQc2t+F4gvS4sFhKR0fB7cfEVuQAK81HUACjpUSOgrJBuSCcwqFUFU9HwLHqqAoxI3//esljkpNY0e/7tQOlA5UrRi05Lm82Tvt07UlY0+xf6f//Uoxv1mGkjF4Wow//y54fGyLieCCM4PpT5QEB/l/zC3QQnDbCZjYnEN/3nepkLHngGzq8DIBwSpPTxisE9HEtMDNIARucRFogUhiE9nEyGDD2qJXdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wv2cBGJz1oE/9eJVgNncRnpBZX4WT2zQcNjp5kehkI=;
 b=jRHLDK9TnZ4kTnQic4f5VkvgTDhXB97aJBMIvIwxP+hBo3kXK/CTrhQ5JtQ+1jWimMsb0Jt7yMDx/hT0D5sgTPoTYOCOmoY3n16jfZtce0HjWp8/foaWQ1qQlXjQLitwpCKXbCbxgY80mWvbZL/16VF1UjYa9CFWewEhF8hZKierPHxiQiabnsgMtE6Z93DLrLSZ1LqXCJM47SEhXFA66jTu4UY/ovzVObuhjpnKMdvDTC+w7RyPnWYDkbP0TeuSA6hFMB/MISyrT/zBjNfGEnHmAEsuvWIiS4tTOGB1DLfBovOzDT31dSfP2FNK1v42w27kkG7HNx2VM1XQAnJ2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wv2cBGJz1oE/9eJVgNncRnpBZX4WT2zQcNjp5kehkI=;
 b=z3HWchNplm27oefZeidsSBnTNU58grfFh2pXrNWDfRmBOc4zEhmbaIyLfe9ypgHznKAwWbmTFzpwfl4mmIL2FEoqUrwrNbnDthYBmmyesxqa9kqQwEFdrC0RBKZk8MDT+N4HB1t/qYCw2TSVJM4pYh5LnkpYWzzYaHFnYC/Qc8YxzFgk9gU+zQq4lYO5jAX8B+db6V1zhEBMnuwuU7VKSciPEI0KQhprXxFNdy6vkagGZBC6/LXSQqsX03vqs8xrldaQBMQAhysJ7M6vZd2CDNJq23v7Ye7dFOi+24mzAF5/kq35cOsOlxgy9wZ331lGJUvtoR2EIUCNVO5A3zzucw==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by SJ5PPF035FE4CB7.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::805) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 14:52:41 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:52:41 +0000
From: <Ariana.Lazar@microchip.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <nuno.sa@analog.com>,
	<dlechner@baylibre.com>, <linux-kernel@vger.kernel.org>, <andy@kernel.org>
Subject: Re: [PATCH v2] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver
 into two modules
Thread-Topic: [PATCH v2] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver
 into two modules
Thread-Index: AQHc7eg6QBFcH5N37EasbvgybeRasbYjVOAAgAmgjoA=
Date: Wed, 3 Jun 2026 14:52:41 +0000
Message-ID: <09f59aacb059342e2698b370af4536d4e7a90938.camel@microchip.com>
References: <20260527-mcp47feb02-fix2-v2-1-3e8946d7b3c4@microchip.com>
	 <20260528125140.16a8f173@jic23-huawei>
In-Reply-To: <20260528125140.16a8f173@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|SJ5PPF035FE4CB7:EE_
x-ms-office365-filtering-correlation-id: 8abcbe38-d86d-4f79-6d4e-08dec17fc361
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 6juQzE8kznGBWmd4IPqVqnQdYAV6GpRvmWhhD8p6FFPFuNxNwcJuUjWUYAsIEh5OdWgTI+FuxdALhkyeuTEOzHlQgHqaq0i7rDH2GHodQPUuqCsO8AZLMGIipT5CFqRe3Su9zxhx+k2bEVY2HQWSTe6Uy4JkY8psJ/YCgTU5D8pbGSqszXCp9xazc9vt8Jsslk8T96wJOtKLuSPd3zfDiO4xzbEiDeeLFAW514TSal6+ezUHG6GWa4ATSLJF+jNO7BHZpaba6CphOMmPhU3pkdJU9iUZKQep1tg5z0LpcGkL0OTMFy+lN4uiUe4W63fEwuYGluj6J0DhioFrdELfDWTD4Rr/ZMbCpMi7NVSnTlnXqFsD0z44y5XdT/MI+g/OWA43AgTOuStDBc1QzNcWgx0wpBlpQhK9BcoRFRKl9L7OeiNRvOqT6tGK5a/tiOf/ZMIjiRITAXLaXh8ILmMHraJSK8xyhYdEI7vYtC4dNlhRXU5Jyate1++6HfA7xdc0EV35eW+s/BSewleVDuG+tYWdubhjLqoSn2sz7q40WtUegrDAZCfrGgurrsQwoqgTwZxrWeVST0x+6hrcFyay24kSP0edHos/q+OPlygWIDbqgyx8ViARsNqKMVgWUEkHgCVvQ+tUCas8JRi7iC0ckLiIn7dh/b4MXzBKsVIDOVpqfSzwN45iVR4wJiLaLUPbUKmgc5UemDyUhPaY2YxUlYGHKv4sWYpukJ5O1oYlRwm3/DScIgAQ5BKowvyMv8Oe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWdId0pzdCtzNUFTSDl4amVJRFpIYWNOM1JObHNQd1llTXh0TS94aXpEQ1dq?=
 =?utf-8?B?QXBaYzJxUjNQNmg5QnpqM2ZPTXZoNTM2MmY2N2ZQc1dyb0JMMWJoTE1sRVVD?=
 =?utf-8?B?end0b3dzSUNNU25vREhrWk04a05xRC8rYzc0SmEzNVh5RTVoZnVxL1NxTm5a?=
 =?utf-8?B?REp3cXIzR3JPdU42LzVDbGRnOU5mQmgxeE96YXkrK0JoWURFWXpHcFp0TTVn?=
 =?utf-8?B?ZGdMakVDMHpuVUpWcHFTcm1PeU5YUXNUaSs5WCthak5kbUVjSDZTa1piSGVo?=
 =?utf-8?B?d1hJS3NBQVVibkFaaFNCS3dOMDE0UDVHN0NReWQrVzlsdS9mK1BrNFBjTnoy?=
 =?utf-8?B?eWo3OVErVWpVK1V5c1dGUUNPQmVKOGhweS9jSXRjYktLODg2UXMzQ3REcFFt?=
 =?utf-8?B?RTFoaUdrZU1ONDhMQU1wbEdBamNoaUVuZE5aVy8zdDNIbVFlVTliSCtCU3A1?=
 =?utf-8?B?VmxqbkFVRUYxejBLa01WN1lRMVB4bVRLSTY4VjJNaXBYYmdHaWRaMzJQTTl1?=
 =?utf-8?B?aFFvSU1FaGVPY0VnT0RobUIxUjJPbjV5SzZxZWhvMnFGNDk5aXl2eTQ5aC9D?=
 =?utf-8?B?ZDlsMXJZcE1neHVhYkdUVVR4Q3NFVERjREdqMHlXRkpNdVVmNkRZc291MWNE?=
 =?utf-8?B?eGFwNWo3Z01ZK2lBUkhXRjA3Nk9lRndycmxNYlRTRUVnZ0NtaUd0Nm5CcW14?=
 =?utf-8?B?THEvWkthN3ZKTFpIcDUyY29UUEVybCt3WTNWUDR5eVBlMWR5Snd3UWdaN3N0?=
 =?utf-8?B?d2tyOUx0ZjBqK2JRZ2kvdUdYMDNqZXl3ZUhjazFibEJady9Qb2pUd1RoWjFL?=
 =?utf-8?B?ZjlNUVAxTHE5ZkR5V0c4NGczZVkrVlVlQ1laTC9DRjRneGl6a0c5dTlBZWZk?=
 =?utf-8?B?a1o4M056UERDRDNsSzNqMkluY0JqUktKZG9mNi82RmFGdFN4MmxsUCtkQVpC?=
 =?utf-8?B?cDFjQUozRlkvd3pISzgyTGJ4K3VRU0tWSEI4YnNPTUVXWFFiY043c21xMy81?=
 =?utf-8?B?UFl0QnRacHVMRVdndGEvYWY1cmN2OFVnRFU4MUQxRXB0TkIxS09ZVkdZSVRT?=
 =?utf-8?B?MXlpWTY1Wnc4UENMbDVyd1l6Wnh3dXEvTVBNOVhCc2pMT0FRbi9VWkFWelVB?=
 =?utf-8?B?M2NYYUJuUGNhYlMrUVc2WkZvajFKUVFiazVIcEFPQzlodHE1ZXVKWDJKdlh0?=
 =?utf-8?B?UEo0UzliM25nQ0xTeVl3TElGSGxTZXlMVEpKbzhiMGV4ajlkdGt2Y0xYRGhO?=
 =?utf-8?B?d3laUi80ZXcxMzN2bmNFeXNsR1dRTHdmbVlrcThLZ21kcFloeTFiaE5iQWVo?=
 =?utf-8?B?aEdxQzlzY0FBTHozdzlObGdsSmVuNkF2QVJLdER6RjBramdpSWF3TlpqSDJD?=
 =?utf-8?B?bE5VM0s1RXJRejI1RHJWekp4ZnM5bVlXeWFFL3RxSjRVZ3BkeWJRSU1sYVhG?=
 =?utf-8?B?ejEzSGNDRWRkNVViZ2FRL2pJMFg4d2dKNUxzaGJOaWFSbTBrZVBrQlgwZVlQ?=
 =?utf-8?B?VTJQVkFaUXkzcUNGMEwzR09NSjNnWGFqNlloVVNtdlU1cGVMSEgvL2NGL1g3?=
 =?utf-8?B?YW04b1llYnVUa3hPeEV0K0dUWWwyWThDSDN5MGJSUDNhSkR2R1VGeXFkUU1T?=
 =?utf-8?B?S25uZ3N0ZHVQWkI3WXYwQlBQNzN3cjdtYzJjTnBzcUs1dTZTR3MzNXcrb2VQ?=
 =?utf-8?B?Y2VlczNqR2tHdUdvMjNNKzZLbG1xQ3BDdXQ4bjFjc2RhdmtrUmdneUtKdkxs?=
 =?utf-8?B?YU5OaTZ3R1F2QWhwL2FQd2J4WHVaaDlUUzYvQjFOa3NBV0pYL1VLRFh5R1NV?=
 =?utf-8?B?M3orRUhqdHZ6VUExK2FmNzA2QTJBVnZIamNkOTkyNGNWVnJrYWRMUWpRb09x?=
 =?utf-8?B?dWM3eXd4VEs2YTlBRk1NRlM5SURjeG1ZNFJ0aklBOGp5Rm8veDF6Ykl4a3Jh?=
 =?utf-8?B?M0lOcEVaYktkYjZONStRLzR5K0cxVk9zaSs3bE1hcUJUa0MxeHh4WTEyVEE3?=
 =?utf-8?B?QWg5STNxT29vWmY4SDZoZDNlOUk4cDVVMnJQQkNPOE5QVkY1Smw2VkFia3Bl?=
 =?utf-8?B?Zm5zSlJrcEp6b3BpUHdLUm1VRWFoRWRpVzlRUWFrWWlFbWF2NjcrY1FYbjR3?=
 =?utf-8?B?Rmp6Q1g5ZXdCakxGaWdOTnF2dFh3eHE2b3BhcS9PV3Y0U2VoZkQ2MDBxQUdX?=
 =?utf-8?B?TjVpYWJqSGFzQm8wMkhKN282UjJIWVZ4VDVINElURU1qUmd3WVYxaW1iTm1P?=
 =?utf-8?B?eDQ3V1o3eVVZdGwvM3M0TSs3VUlvZnNwM214M2tQeG1BYlNHa1VsV2JyWDVi?=
 =?utf-8?B?WjBtYWpYU1Q3UVd6ejVxcDMxY2JUSzJUOUdJYmE4bFNJcDZ0Wk5vWjlTTWJC?=
 =?utf-8?Q?xHJMMDdjGAxW/yVI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <057EA07E26463C43884B1989AA62E9B0@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abcbe38-d86d-4f79-6d4e-08dec17fc361
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 14:52:41.5943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qq9QooE42rkWDc7LnAf8BYpbLAUSVNb74ZvcIZl0tBzS/KX5CCcqIWMWqY3DcTlghXkZ8HgAl5wNelE5nNm4RQTsLJMN5pBbm9U/681NixI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF035FE4CB7

SGkgSm9uYXRoYW4sDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KDQo+IEkgZG9uJ3Qg
bWluZCByZXZpZXdpbmcgdGhpcyBvbiBpdCdzIG93biBidXQgd29uJ3QgbWVyZ2UgaXQgdW50aWwN
Cj4gd2UgaGF2ZSBhIHJlYXNvbiAoaS5lLiB0aGF0IFNQSSBwYXJ0KQ0KPiANCg0KSW4gdGhlIGZp
cnN0IHZlcnNpb24gb2YgdGhpcyBwYXRjaCBzZXJpZXMgdGhlIFNQSSBmaWxlIHdhcyBpbmNsdWRl
ZA0KdG9vLCBidXQgaXQgd2FzIHJlY29tbWVuZGVkIG5vdCB0byBmb3IgYmV0dGVyIGNsYXJpdHk6
DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA0MTkxNzE2NTguMmRiYjk4ODRAamlj
MjMtaHVhd2VpLw0KDQpNeSB1bmRlcnN0YW5kaW5nIHdhcyB0byBzdWJtaXQgYSBkcml2ZXIgcmVm
YWN0b3JpbmcgKHNwbGl0dGluZyB0aGUNCmRyaXZlciBpbnRvIGNvcmUgYW5kIEkyQyBtb2R1bGVz
KSBhbmQgc3VibWl0IGxhdGVyIGFub3RoZXIgcGF0Y2ggdG8gYWRkDQp0aGUgU1BJIHBhcnQgKHRo
ZSBTUEkgbW9kdWxlIGFuZCBtb2RpZmllZCBkdCBiaW5kaW5nKS4gUGxlYXNlIHRlbGwgbWUNCmlm
IHRoaXMgaXMgYWxyaWdodCBvciBJIHNob3VsZCBkbyBpdCBkaWZmZXJlbnRseS4NCg0KDQo+IA0K
PiANCj4gQWxsIG9mIHRoZXNlIGJlbG9uZyBpbiBzZXBhcmF0ZSBwYXRjaGVzIGZyb20gdGhlIGZ1
bmRhbWVudGFsIGNvZGUNCj4gbW92ZS4gUHJvYmFibHkgYmVmb3JlIGl0IGdpdmVuIHRoZXkgc2Vl
bSBsaWtlIGEgZ29vZCBpZGVhIGFueXdheS4uDQo+IA0KDQpBZnRlciBtY3A0N2ZlYjAyIEkyQyBk
cml2ZXIgd2FzIGFjY2VwdGVkIGluIHVwc3RyZWFtIEkndmUgc3VibWl0dGVkIGENCm5ldyBwYXRj
aCBzZXJpZXMgZm9yIG1jcDQ4ZmViMDIgU1BJIGRyaXZlci4gQ2hhbmdlcyBJIGRpZCBhbW9uZyB0
aGUNCnJlZmFjdG9yIHdlcmUgZnJvbSB0aGUgcmV2aWV3IGZvciB0aGF0IGRyaXZlcjoNCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC9hWTNtNVYwNUZPSDVzdXQ2QHNtaWxlLmZpLmludGVsLmNv
bS8NCg0KSSB3aWxsIHJlbW92ZSB0aGUgcmVmZXJlbmNlIG1pc21hdGNoIHBhcnQsIHdoaWNoIGlz
IGEgZml4IGZvcg0KbWNwNDdmZWIwMiwgYW5kIEkgd2lsbCBzdWJtaXQgaXQgaW4gdjMgZm9yIHRo
ZSBzZXJpZXM6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA0MTQtbWNwNDdmZWIw
Mi1maXg0LXYxLTEtOWQ3MWJhZGZkMjVlQG1pY3JvY2hpcC5jb20vDQppbiBvcmRlciB0byBhZGQg
dGhlIGZpeGVzIGZyb20gbGF0ZXIgcmV2aWV3cyAoZXZlbiBpZiB0aG9zZSBwYXRjaGVzDQp3aWxs
IG5vdCBiZSBjb250aW51ZWQpLg0KDQpCZXN0IHJlZ2FyZHMsDQpBcmlhbmENCg==
