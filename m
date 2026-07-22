Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A51411F89;
	Wed, 22 Jul 2026 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740763; cv=fail; b=Q6j3Dnk2d/4iqnVET92h1V3rizcrFhgV6AjLxO1per+VfXfsQyx0nVd2RM24udwx+znRGYltE7q5JSrAtrSSBrQAGlZyXqmoSQrS8NICXA58BxxZmjBQnys3sz40y8XKK+IB6zzLjSMf+AAo/TsBSnPsOWx+/gHdshhkelEs37Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740763; c=relaxed/simple;
	bh=jboYZ3dWTcvVMw1yJb4vSu2XunulmZE7dQgSrZLBDzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mLVGqapOWUDGrzq6Qwhc5ypbvLiXcumFIPCmrxr0gA2jZ2CJaET/YtZeE4QVlRpC6TmpzKN/r9vdgnp6YE23kEq1yNqdIVJ3zP56lGaXvyynihTmEIVOWrw2dSZhYbCkgZTA2h3JGDMJAaDrRP8Mp38zZ2ZKfIF0e9JgnNW33DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YDP83Wnu; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YDP83Wnu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvZtWCiGzzzKA2vqyyrI/Msh5mz8t9SzKxuPOXBlHHTIyatvlSqlaeowHyO6gERT3F/o2kBQE9uG0WwgDdLRXs4SIpbsFf2uJJwT3YIVl1WHCx6TQxbyXfRvXK4LAMmNuKvInIXKWeWPIeuGYdxNtZmHDqL3+x4c7VFlL9z2eiANDl6AC661g+8L10eO3+fUpO+WjREPIsQfQdFLNA3+qIJiTuDbfZoK3VrcP0wTLbilyTLwp1loKOvby7IIdEuYfJqBTLBK1SZJ4d/FzLAvvLAD1j99Qt0FaJXvykfBZMPq4SuMqQ0y0YpmqP0qcO0qolh7u3+6CyZWKieJG59cvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jboYZ3dWTcvVMw1yJb4vSu2XunulmZE7dQgSrZLBDzA=;
 b=l5joRkHsWO0yk+UafZRvhYJMjcJ8gCBbwhywME9SXMavGLrB/SkMXKKQOAXGhfYpx/a9Sdk/M7fObdTP04TaN/qCBMiRO0bB9IBXkSKPBz0nvVLaGT7mFYRK90t9cDcL78qTON4/Q/w1+CKoIelBtbo+aKOn3Cuvxa0FkOl73Y6HsuoTwjBnZb+szfjpRGawnkAU8mIiDt99XE8+V/8MgDsvX/pQ3ccGbGo+qgp9c9zGECBE8n1eZ9rZzv1QKgTlc1GhwKmeNPW/lPysArk+D5o+28MGLTULPlAdBMl74viq9yuwVZZEiQ7u7bLusxjtGpLQGQqtb9D1r5bdBj6fKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jboYZ3dWTcvVMw1yJb4vSu2XunulmZE7dQgSrZLBDzA=;
 b=YDP83WnuV54lTekCXB65eRdQHaBCHKWHJlYa2e1C3YkH1jARuEBRyKgznFpUpaXz/WFkULzk/0qVOnbcxyyclkrk6UahIfmxvYJhJEKDT/gA82eoHqEk+g18QpBHpdW05SrQ2ED52ejSJSbPnsYlO/xDqcnVtQ8K/h2z18rDEkP8Sh315Qfj25qVtnXlFCX72SYDGQIJYdD1tUGxWoSUR1HDKd+WNp6SdcaViKilnUbRr1pim336VG5k41ZTiRQ5ia8+xxgMIDyLyGqchfD2i9Be3DiAPD7dERT0aT653GrlgQvZEicmpN2qU3gYV8Z+EVHDHVc9Wx3WJB5pOHMr2g==
Received: from DS0PR11MB7624.namprd11.prod.outlook.com (2603:10b6:8:141::6) by
 DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 17:19:17 +0000
Received: from DS0PR11MB7624.namprd11.prod.outlook.com
 ([fe80::33b1:3e53:2b94:9990]) by DS0PR11MB7624.namprd11.prod.outlook.com
 ([fe80::33b1:3e53:2b94:9990%7]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:19:17 +0000
From: <Marius.Cristea@microchip.com>
To: <corbet@lwn.net>, <robh@kernel.org>, <andy@kernel.org>, <kent@minoris.se>,
	<Michael.Hennerich@analog.com>, <lars@metafoo.de>, <conor+dt@kernel.org>,
	<skhan@linuxfoundation.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<janani.sunil@analog.com>, <krzk+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<jic23@kernel.org>, <marcus.folkesson@gmail.com>, <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <nedo80@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<jan.sun97@gmail.com>
Subject: Re: [PATCH v7 5/7] iio: adc: mcp3911: Add support for spi-device-addr
Thread-Topic: [PATCH v7 5/7] iio: adc: mcp3911: Add support for
 spi-device-addr
Thread-Index: AQHdGa9ziGn+f+JRUUCCa6MbjsLkeLZ5yRGA
Date: Wed, 22 Jul 2026 17:19:17 +0000
Message-ID: <a163cb529a2faefdd7465565e24105910e99b773.camel@microchip.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
	 <20260722-ad5529r-driver-v7-5-7781cd74ad75@analog.com>
In-Reply-To: <20260722-ad5529r-driver-v7-5-7781cd74ad75@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7624:EE_|DS0PR11MB6541:EE_
x-ms-office365-filtering-correlation-id: 329bf325-5872-491f-ed64-08dee8155c1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|38070700021|10067099003|4143699003|11063799006|56012099006|921020;
x-microsoft-antispam-message-info:
 JDMDaSgLhS3sWmOZqkV7GpD+1DEP4CBNebZxbGZjyduWNY3vAbmet6VcD0e72Xi6ag8a7hfReo/q+F+iNJw5ft2ytvfkgn7pZEjwi2XChLvLdb0P+/Ghk2xhIi+oY3KLIWXBz+9N3l97Po9WYWOE1n9nomks4omR1O9+zMk5vQpJyCcIg3gbNg7e2ojaSYjMlA2ViPHKXw7q1Q7Mqs7P0pL4V/JTQOSAyvCrxnI562xzW38D3Nt/FEmgMBMJcBxuvnU/Do1lcRentbXSi2p8qO18BeXls/qGQSpJTDPUJgyD4lNF1JY0e9amARopCyLO/Wg0v33CYCvIEvnRic/+ZH3m98iBg7Kq+F3l+oozmCK9dUEWd8qWDNr4x+Gri/0HL2biVQKiRUIDSMysnoutDaAsAeOAW2Qpf79PWMle0pv8xhcvXo1IjQyRhRLjojRHfiWdFgji9BSC6QLnCG0KwIL18IBkGaLJaLAOuGQWXGPbKkHj/cCTHIZ92q6lNQjMbCnMqCRZTtcm1El340p3Kp+xwGLsUJ46vnG55NXqC+kH2YsKM7/OLTm94PmrnK8UBBlHlm9Ms6huHzJlaikc5WHmb4D8r02BubP/C8FkfIfkLYbvoig+U6dgOlX4AodMSkRGPIE/l/7fqh2WDaNohNwu8S2+wa7auO4HWp3ULYMxuxSF4RhX4pd16gvn//UnpyZnncc1ING1A61Ns6KSAYOUdtWpU6iMA/EOCPFlHRM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djkwSWR1dkRDa3VhR1ZsQzgvbHlVU3k5L3I4V2VENFhpSG1TREt0bzFTZmMv?=
 =?utf-8?B?a0pIMWc2WjJwSUhlanZvRnBtdVNibEdocUEvWUZ4UU93ajNQZzBJL05mTkll?=
 =?utf-8?B?KzEwZjVMOURnVC81SVRsdnhZZzMxYlFpVEN2bTJTSVhCYU41eXM5eVVPbzMw?=
 =?utf-8?B?V0xJRkpaTmpEaVRta2VjSDBsRmlxcU41RzA4eHhIeEoxa0hiQnpSV3V2K01S?=
 =?utf-8?B?SHd5bWd2bmFDdGtnTFgzR0tYR1E4emZSZ2Q4RkpmeVFoTzdIR2l6blVHZ0NK?=
 =?utf-8?B?ZGtyc3M3Q2JvdVFFY0lvVFUzSXJsUGxiekk2TE1XeVIrLzloTklYVmxBbE9q?=
 =?utf-8?B?NnVaSjNaTmRmUmJKL0NLc3FFa3c3TFFLUDZVbzZDMnNPaTJyVHpIS0FLV3k0?=
 =?utf-8?B?aXNGdEx0M21iREJKekpPRHV3cnoyWENkcUpKcHNrbllaajFMN3gwdnVHTUdu?=
 =?utf-8?B?MmNIc1U1N0s0bWUvZDU0dXRaT1RuNXcyK2l0bjlrallkdjhqKzhlMzNQT1Qr?=
 =?utf-8?B?aHhRcDdtMGNDQ2RoTldnQWltYmpBWU5pWkFDa3ptN3dZd1krY3k2YmMzeXNp?=
 =?utf-8?B?SVJYMHRSREoyeDYrL0VSb05ydkVOY2Z4T05MbGNadkNkeTR0KytyR2ZKTWli?=
 =?utf-8?B?NnlBTFg0eW9ZTWhQN25ZNkRmUEE4aTluUWc1dGhpOURpS0FXb0dtQUpqaW5O?=
 =?utf-8?B?NGh0dVZEQng5UWFPV1hkcGpJMis0djFwUnFheUJ0Q3ZEa2JxcGlSQ2JTc1ov?=
 =?utf-8?B?Y0hIdXYrTHdHVkxXQzg2L1orS08yV05jc1N2aDJQNnFNT2NLRUNRRzVuc1Qx?=
 =?utf-8?B?c0J5aTcydjVHN3NFSXZJaFVGcG9HWmdRM2JkTjl1UjRKS3NxdmwvYm0zKzJU?=
 =?utf-8?B?c2Q3aHgvMUF1RTFhTFRxVzVXSnJpZklhYWh2RkpZK2JxZEowWXh6a0ZWaytS?=
 =?utf-8?B?ZFBZUThyMHdOeGNGREFwNlljYmM0bFFvRHBpL25PMElWNWNCNTYwL1QxYUd5?=
 =?utf-8?B?dEE1aDRlZFV0L3RTUVIwdDJoaHd5R3NlaHI0S25JTUpWcWZnbEdSSzRUemhh?=
 =?utf-8?B?MzFOM2ZPRVZMb3kxM2ZvbmRjTVU5dHJBbXFXeDRmSHIrL0ZtdkFnY1Awa2J6?=
 =?utf-8?B?cmxPZUxESWZEQzZEQXB0aklOVy8zRllCbVM0amZPd1ZhZFpRcVRyakdrbkRs?=
 =?utf-8?B?bDI3ZE82Vkg4VmdVY1VDQUZtblM5S2F5K2FoRG5rRTVtdkNSeDIxUFFFdm5h?=
 =?utf-8?B?R2d3QUZad3VjSDI0dG9hb1ZzdnE1S0xwOFdsOGpZSHVWVHlKaXdDeXZoelNi?=
 =?utf-8?B?NmFxK2tRTEJMZUVGalN4ZEtmWktkVmtqK1g1cVFnbTBYbW9iTFExTzljcHp4?=
 =?utf-8?B?UkdhQXJ1UG40YjJhL1dRellScysxV1JwUTdGZ0xGWVNTclhGQkd2cTFUYm83?=
 =?utf-8?B?MStxdXBOaWFhdyt5UGRycmFyYVJTc2JFaEFnd1NhL1A0aU13bmd1ZkVjYXFz?=
 =?utf-8?B?RUcyUmJ0d3NLSUxOcFg1aUhTOFN2bERFWWdmL2ZMSkpKaHNORHI3NURUQ0ZX?=
 =?utf-8?B?S1BDRFVjWWtkNEdTTXFKM3A2Q0owbjRrenUyTTlkVytGTVI3RFZJQTN5QjIv?=
 =?utf-8?B?THpOeG9jcUF2blVWM3BWUEhtVmgvOTBqQXJYcjhycUp6SkVYREY5NDdrZU1J?=
 =?utf-8?B?bTgzN1lVMjlnck1mVk1PRUd1WW9EZDdYQ0szRlhjL1NRb2FrZEF3MER6eFIr?=
 =?utf-8?B?SzVBODJhMHc0OXcxWnBGY295R0FiaTJ3cUd3bmFmZ0FOM0Z2Tno5QzVRUU9Q?=
 =?utf-8?B?SG9sUVd0QmhYWDFUc2dKeDh4UmpBQUlHYUNsNnZOWGlBR29SaTAvUTdUaGRQ?=
 =?utf-8?B?U2RHTFF1UTc2dzlRT0VBdzdGZ1ZKN2xJNHJHN1AwQ2Fjd0hrbEJINnB6NlZN?=
 =?utf-8?B?WUNZc2xEYytJMUZOZmtQWndPS2xFN2ppaVNBcTdkd0hBU1A2YkZoNXhEN2hl?=
 =?utf-8?B?dWkvVjI3R3VYaXpKMldaK0dYVFJYaVN5QStLeFBFZUFucVFINmhKMWhZTXhR?=
 =?utf-8?B?OUJzNE8yNzB0Y0l0cHhnYUhieEp3K0JMT3ZXdEI5Uk9WUUFJSjJ6N2NwbGwy?=
 =?utf-8?B?bzREeU9oQ3FzU0o1NGJ5QkFHUjhGaGMxWnRRVG1rcksyYWFSKzJpWE9MSHNm?=
 =?utf-8?B?cUszT1dXbUNXTk1xeGxmb095MWJQb3Y4UERBcFZ3TWduTmJWdjBuMVJ4ak4y?=
 =?utf-8?B?Yk0vMGk3TWh1dFY4WmlLNjI1ak1oeHN0bnNYYlBEaEgxMkQyU0hubmkvWkVr?=
 =?utf-8?B?VitydlRQUGpRSGE0aXdrK09lc3AzL1FXc3dmbUdVNDlQRE9vRHVnNFVFYzdq?=
 =?utf-8?Q?kUxFMloDg6phvHso=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2179B61E3341F4D91B119C3049C7962@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 329bf325-5872-491f-ed64-08dee8155c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 17:19:17.0292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkh+8ubN0LTzERliy1xlKtpsEwJ/c+X2VIvuViTraQmmwAJ5V5wzByAiVhwRQIaVASNSLb6/i/Jt04051emlnTUoeJrR+Az/AeKuMQbHE98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDA5OjU0ICswMjAwLCBKYW5hbmkgU3VuaWwgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gUmVhZCB0aGUgZ2Vu
ZXJpYyBzcGktZGV2aWNlLWFkZHIgcHJvcGVydHkgd2hlbiBkZXRlcm1pbmluZyB0aGUNCj4gaGFy
ZHdhcmUNCj4gZGV2aWNlIGFkZHJlc3MuIEZhbGwgYmFjayB0byB0aGUgZGVwcmVjYXRlZCBtaWNy
b2NoaXAsZGV2aWNlLWFkZHINCj4gcHJvcGVydHkgYW5kIHRoZW4gdG8gdGhlIGhpc3RvcmljYWwg
ZGV2aWNlLWFkZHIgcHJvcGVydHkgdG8gcHJlc2VydmUNCj4gY29tcGF0aWJpbGl0eSB3aXRoIGV4
aXN0aW5nIGRldmljZXRyZWVzLg0KPiANCj4gVGhlIGRldmljZSBhZGRyZXNzIHJlbWFpbnMgMCB3
aGVuIG5vbmUgb2YgdGhlIHByb3BlcnRpZXMgYXJlIHByZXNlbnQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBKYW5hbmkgU3VuaWwgPGphbmFuaS5zdW5pbEBhbmFsb2cuY29tPg0KPiAtLS0NCj4gwqBk
cml2ZXJzL2lpby9hZGMvbWNwMzkxMS5jIHwgOSArKysrKystLS0NCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2FkYy9tY3AzOTExLmMgYi9kcml2ZXJzL2lpby9hZGMvbWNwMzkxMS5jDQo+IGlu
ZGV4IGRkYzM3MjFmM2Y2OC4uMzkxOWEzMjZiNGRiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lp
by9hZGMvbWNwMzkxMS5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9tY3AzOTExLmMNCj4gQEAg
LTc0MCwxMCArNzQwLDEzIEBAIHN0YXRpYyBpbnQgbWNwMzkxMV9wcm9iZShzdHJ1Y3Qgc3BpX2Rl
dmljZQ0KPiAqc3BpKQ0KPiDCoMKgwqDCoMKgwqDCoCB9DQo+IA0KPiDCoMKgwqDCoMKgwqDCoCAv
Kg0KPiAtwqDCoMKgwqDCoMKgwqAgKiBGYWxsYmFjayB0byAiZGV2aWNlLWFkZHIiIGR1ZSB0byBo
aXN0b3JpY2FsIG1pc21hdGNoDQo+IGJldHdlZW4NCj4gLcKgwqDCoMKgwqDCoMKgICogZHQtYmlu
ZGluZ3MgYW5kIGltcGxlbWVudGF0aW9uLg0KPiArwqDCoMKgwqDCoMKgwqAgKiBGYWxsIGJhY2sg
dG8gdGhlIHZlbmRvci1zcGVjaWZpYyBwcm9wZXJ0eSwgdGhlbiB0bw0KPiAiZGV2aWNlLWFkZHIi
DQo+ICvCoMKgwqDCoMKgwqDCoCAqIGR1ZSB0byBhIGhpc3RvcmljYWwgbWlzbWF0Y2ggYmV0d2Vl
biB0aGUgYmluZGluZyBhbmQNCj4gaW1wbGVtZW50YXRpb24uDQo+IMKgwqDCoMKgwqDCoMKgwqAg
Ki8NCj4gLcKgwqDCoMKgwqDCoCByZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LCAi
bWljcm9jaGlwLGRldmljZS1hZGRyIiwNCj4gJmFkYy0+ZGV2X2FkZHIpOw0KPiArwqDCoMKgwqDC
oMKgIHJldCA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJzcGktZGV2aWNlLWFkZHIi
LCAmYWRjLQ0KPiA+ZGV2X2FkZHIpOw0KPiArwqDCoMKgwqDCoMKgIGlmIChyZXQpDQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihk
ZXYsDQo+ICJtaWNyb2NoaXAsZGV2aWNlLWFkZHIiLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICZhZGMtPmRldl9hZGRyKTsNCj4gwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldmljZV9wcm9wZXJ0eV9yZWFkX3Uz
MihkZXYsICJkZXZpY2UtYWRkciIsICZhZGMtDQo+ID5kZXZfYWRkcik7DQo+IMKgwqDCoMKgwqDC
oMKgIGlmIChhZGMtPmRldl9hZGRyID4gMykgew0KPiANCj4gLS0NCj4gMi40My4wDQoNClJldmll
d2VkLWJ5OiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbT4NCg0K
