Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722A625;
	Wed, 22 Jul 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739974; cv=fail; b=bBgGAN8QnLgkMNpVLhgEiBJSXSw18kG9Hep0jXrZT0LIhMw8CNbw2nSr87kc0DGH3T4y473vzSu5dCzkmBg3iyyavpPgIfcOm6vZhS20T+TM2dmMLS3HEeQK+58A7t1IlVhxPZBS/p+OxKm0chPzzEyja0BcNNJFpj7wrXu5aks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739974; c=relaxed/simple;
	bh=b11oinkQWRkDjtvsb4Lm1jy6D8hIYY/17RkFcMuukE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I05qOCqTaakq5Z/1cyhuYk521bAXNiC5kY7qGGWvFmAC99796OvUIWPj1r1nfiCGA1vq7cT1oMZa+xeDrOX9wWbvsDD+ltA7Z8ZaaOtB/RT2eEldQFekWkCz3PUkZExopbahXEvbgnrGxSRw0ohF8ymRxd0KDtNt3JfYoFCQ+C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fo5vFIRa; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fo5vFIRa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wh87U7MgwsxDaUCWHVlJWtaWtSkd9pcutezPXHbd8XQ84Uv7/VOEnzlT1XJTRQLN5u6pGkNkC963+flA1ihIvv/kxGP0D/fjLKvhU0fgNCYyfVNJHrjNQocTJjAYoP1gc2+P+kPEhwQJ48xlSmS6P3a8U+QLrP/OD7vE1gV44kpFMbLxHlnEZiQ+g9vH8Kl0ARa6mJ+uKbpNTL6zXm9yx2yS9njEMfalRItRSBHCLk1GIAq/GPktVF9vRBC+dFLo0PRbUse9zAgcZpBuaIG4C3zX1jMqJOijCmJ1Lcmg9MO+3U82zBcDrJfxuL4nKJVFGtDj405qX+suPPvK0snnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b11oinkQWRkDjtvsb4Lm1jy6D8hIYY/17RkFcMuukE8=;
 b=vB7YQz3HmPUFObq9pgDVUwOJNrrMxH462llgNqSqYu+79+09/0JoOYpB+QlElvNadxs5Q3nS2hznif6eub8wZIcGlPCQ6HmKSgC4Ls8ZZe+vG3WqQG+0ArVKUana+2mB3C3ZqCoVqGVEMdSU7qzDRfblned6ext2H8X6hCqFP6BnoXhXZEUOVURMtSlX20WKNZj2SYgIZsX3v19wohJCrlfWV0T4HzYAxTBcpH2ETWIIe2xn6og5h4Rz6yeL5xOfUvJdjYS6kaL9TH08xFPwG5jF88pwhd/Wc1ipVw55IdN7RzJWMduSzv9rBY9vrRhPpofsvaV/nhiDakiuBTfFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b11oinkQWRkDjtvsb4Lm1jy6D8hIYY/17RkFcMuukE8=;
 b=fo5vFIRa/Biqa+wHz3PVSBXZTmSYRLD+IGnqvy1uZ+62yC/YlJ9z2ggHT3icc6OPs7oGGGm6aqq1M7Vs0WuqTVXRoQ/Fs+tSAmF5Alpshin6SMxu4iyZc54Ig8iGfL02ItTyWScrVltj6Ci3MhhJwPiZniDE00FiXjQ5EWVIhVrzIXEOyZFohAb7HFeQ4ttC8NYdicgmuhi6HiQGBvxAvueic8nxWimaiyFG1698mSgMQWQRz+2lWLj1CsEOlR5k18BzbjlMkUqc5tIi2O9DHzSP0GKDkyrGtKrDniFkjUS7xjYMYfUs79crjHa2FD7jeGO1M2kXuRd0Su01EzH/1w==
Received: from DS0PR11MB7624.namprd11.prod.outlook.com (2603:10b6:8:141::6) by
 CY5PR11MB6092.namprd11.prod.outlook.com (2603:10b6:930:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.14; Wed, 22 Jul 2026 17:06:08 +0000
Received: from DS0PR11MB7624.namprd11.prod.outlook.com
 ([fe80::33b1:3e53:2b94:9990]) by DS0PR11MB7624.namprd11.prod.outlook.com
 ([fe80::33b1:3e53:2b94:9990%7]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:06:07 +0000
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
Subject: Re: [PATCH v7 3/7] iio: adc: mcp3564: Add support for spi-device-addr
Thread-Topic: [PATCH v7 3/7] iio: adc: mcp3564: Add support for
 spi-device-addr
Thread-Index: AQHdGa9vZSBX56/xs0etMzmGWafakLZ5xWUA
Date: Wed, 22 Jul 2026 17:06:07 +0000
Message-ID: <c6c344e8bc09d49c23bc6bc37b70edb319b37955.camel@microchip.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
	 <20260722-ad5529r-driver-v7-3-7781cd74ad75@analog.com>
In-Reply-To: <20260722-ad5529r-driver-v7-3-7781cd74ad75@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7624:EE_|CY5PR11MB6092:EE_
x-ms-office365-filtering-correlation-id: b178f426-6b10-4958-512b-08dee81385ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info:
 A0aCOWeDpiJacx2T8CjK0TZTa3n3hsmB0ajDrbKnOOGBr8KbTJwW/YcIGrKrJGZgkkBZMV/Kv+f6aPGbASCY2pwo+dFpvTTSUwE7vC2VvxA0llUq4Kf9zLY9w2Kyw1GG2xTok/FR5SETdoEe0qC65MrempdmohNmPYvNbeo6Zlio4oKgpSulS1FLR5wy9C1rKdub1Ty3C8bgpF1UJamOR1LRX31J3f09LugMIwEtWl9n2QsN8z5zC5TudlrlarEXG4WcSc3YwEBujq1aiTiB3eUPVMHQYFRL8KMpKQWVA3jkWjGXCNmOtNwBoL/rRmnaPvv8LNyJrJyd/f4NVKw8cGG8dO0rsx9Znddr5GsMZU6eSEzkwXsDxDL5nGTZJi3A1s2dLKbI/chF9NIrW7ZP0OpykDesVbkRTHhVOiUe+9IpilDnBUMYGgI3YXkFl2XRB4p2w52Ow0NhC3zUkwFM9jIi2XYtY0rh8BIJmdv36dms5fHDytCPQe0H4HEZhGunhrxkMPh4c0APyJKCN4Rqj2nvOHSDQWhKynA9fho5Qrv2MqCN5GQUVM+vwdMzvB773P8gS9FKK9m1KnbE5k8x2NPVv46ccfBLsWGQZhOyX7Y7+yPukIFymq3ZoAcaavY/czPieWGW5mSX3r+stB/e8aQzW3EGa5CxQiBAAifdN3x2q0AVZMPJvxFUmZAOqq/4UUu1LwEXkaRljUFjXeAhGRlo4f0ImlLB7VaDdM4//kY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3VYYy9lZ2NCdTZPbWdoVDZPbWN5NUJ3WCtOV25KdHpWU1M5N2Z2akdWNjd2?=
 =?utf-8?B?WFh5bWdCemtFRFRtRW0wQVdqcjdYQTJPNUVrd1BRTFh3MVR4emp1MEVoT0hj?=
 =?utf-8?B?TWV3elF6K1lIY3dwRDNVRDVMZG5KNXVvdDF6eVcwanlrZFR1b2ZBVjRCbGRT?=
 =?utf-8?B?QXR2MVhVdDdwMXFubG92SEhsSUhHaHhLTHQ5QVhVaHBIOUw0aWJJbXUrN2Fp?=
 =?utf-8?B?dGdhaGllNWVKUXJUL0hvSTJxc3hhM1RwajZzeHQzYVZFSy9aTmw3c1hKdVkz?=
 =?utf-8?B?bnNTRHRCYmJJUndoZkgwQkNGWnZTT0NTcTFQbEtCY2Y1eDM1QllqYkZJUjhE?=
 =?utf-8?B?UXJaUGZEQ1diYXNyZTQzaE1JQkFuM2ZIZHV0OURreGhDNmROZUZQVEpjVUNi?=
 =?utf-8?B?OEx1dTJIdFh3d2tMSllIRlhGeGRwTWdURjYxeVEzMjY4bWRESTNmcmJUU2gx?=
 =?utf-8?B?Y0pKTkR4dXRaT21FNzFHNnpqdGJsZGk2a3lFWU9zUU1aSW0rcnc4RWhLbS96?=
 =?utf-8?B?Z1Uzc01ZbWYyYnJwc3JUcnlBMlFPYm5nWWVFdzRCaU9ydlVrNHhzQTZoUTJz?=
 =?utf-8?B?TEpKT0xKYTlReDd2VVowbGI1UzRjVzZ6dGlVTnpzWFpUZ01yWmZwSStlSExn?=
 =?utf-8?B?T1NsanlXVTlRU2ZYYWFlcm42YmpkazB1bHdLRzZ0K05CdU5OZFZ3azR6aElC?=
 =?utf-8?B?YVRJdFByeUtndG9PMUlBWjR3M1ZQaGFYTWVacmYzbERZSFZaaS9PVXNMazl3?=
 =?utf-8?B?azhuSk5kS2hnV0VVMGZxbmlDNkFqOHFhY0orTXBxRVpMYTYrVkZWOUM2NVlD?=
 =?utf-8?B?dGNnUWVkdGM1dGh5V2gzWnlBK2g3RmZaWGtJUWx4blRxRVppV1d4aURJODda?=
 =?utf-8?B?Nk5zRmFaQjM3SkxZeTZQWWRhcXV4bzZ3RUtEbU12WU02OHpab2l4UFhPRld3?=
 =?utf-8?B?Q052eW9YOTJ5VUdNaFEvUkRTb2FwSnFHT1d0a0pJNjlqQjQ1SUZCWWFMSGdI?=
 =?utf-8?B?MjNlRUEvRzkxeGpsZUY3Qms5SlgwdlQ1QmE0N3FLY0Nha0hLYzZCWVlJbGRV?=
 =?utf-8?B?VktzeC8xU1lNbWx1d0s4aTFIWUIrdDhDZHh2YkhHWGlMSWpsS2cxazE1d3Ni?=
 =?utf-8?B?cnVMUTkwVlJVL2xKRUl1RGNXb3RRMWlIcGpoOC95VG8wYUhrUjdIdjJ5ck84?=
 =?utf-8?B?TmxLbWhXZXFKZ0J2RmtHMU9zSFd1ZnVhaDgyV3RaMUM4TWhwOE1mMUorUENt?=
 =?utf-8?B?MVRxM2ZxMDZKTk9GQTlOcWhJKzRSMndkd0lIOXk2OTBpT2hUVkF2VGRVY1pt?=
 =?utf-8?B?d2owV0xIOGhTUGEycTlXczlYY0wreVN1MlI0eGNQMk1mWm1ySmJMSVdCSmRp?=
 =?utf-8?B?NHgxck5wampCa3M0TnRnakFiT1RjSXhsTFNES3pWNzBSSzVEcW5LQ3ZPMFpu?=
 =?utf-8?B?am1GYnhheWV6QzZ3SEp4SzJiZTdzNDh2NTdEcW5CNWhnK0V1c2FLTGszSE1E?=
 =?utf-8?B?anZNdks4UGxsOUNuclZteW5HdmlFU3RvK3BZWHY0cUEvaUZpUENnUHliOVdw?=
 =?utf-8?B?R3dYNHBTSGdlaTNBSHFqcWNJcUk5QjZnQ1I2dCtkUzV4RlUvRVBhOXoyM1Bp?=
 =?utf-8?B?NXcxL1M1NmhMYVpPeWVzUFIzeUViZ0hvUk1DaTg2TkJJSDN4Um52cU5rbkpq?=
 =?utf-8?B?Y0tzOXZKMGtGZXN3dHB6RjFjdUNhR1JsSUNWcWVtNGVrNFh0L1lob2ptanpw?=
 =?utf-8?B?anJla3hvYUFrOWJyOVNvcTEvc0dKU1pOeE5ISTFrT1BxcjVrbzd2aFREdkY0?=
 =?utf-8?B?QktUcGE2WHVQYk80VGhNa1JDZ0huWVk0STd6MWhXTC9iNnlGR3VZRVczZE9y?=
 =?utf-8?B?N2RVWGZZalRuQjcxYnRxeUxiWitWOVl3dmNEMEU3VEt3dThLT0pTWVJiVncy?=
 =?utf-8?B?T1c4WjFtUUUxeVRBSnAzS2VNTjdDTDR0cVk2WkNURFd5NGVzSTh1dEk5Qlhk?=
 =?utf-8?B?UFdSK1pCTlFBSzA3WmhzeHJxeXNGQXN3elJMaGg2a0RpMUU3UXkzV1o4MGlr?=
 =?utf-8?B?dTRKYkZaR1VpdUV0dzlybGxkSzZhek5yck1uR3dVUE5teE4yUis2TTJhTVhF?=
 =?utf-8?B?ckkzYk91am03Z3dQUjh0UjFvd00vSGxtcmVDK2ZCT0RpQnZ3Z3lOSG9OTW51?=
 =?utf-8?B?bXdNUTN2cjZsRURQYXdpWlFOTHpaUXhZUndIYmVoY29nekYySGEveCtMczFw?=
 =?utf-8?B?Uy9JTzBvRkJhdTJycmQrbHg3TmQwV2tQMmNmK1d3NFNkQlJENkVGSmE1RmpP?=
 =?utf-8?B?MkEzUitLUnoybjhzWi8vbk55SDF4NGpRbFJpT1YwZ0ZWeGpYdVVTSVFrazRw?=
 =?utf-8?Q?3NP3pfCRZj0ruCm0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <725051082C425B40881F28AC48B796B7@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b178f426-6b10-4958-512b-08dee81385ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 17:06:07.7189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPgmrvsDXtCjPy5HCmPciXt7NTLMS7N9ul24etyRfKxLNy6PHcxvrhEyZlPwVlfkH4AFqAI0UuXP3LpogTkbGI/eawrS/Gd5fkvHNs53+nE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6092

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDA5OjU0ICswMjAwLCBKYW5hbmkgU3VuaWwgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gUmVhZCB0aGUgZ2Vu
ZXJpYyBzcGktZGV2aWNlLWFkZHIgcHJvcGVydHkgd2hlbiBkZXRlcm1pbmluZyB0aGUNCj4gaGFy
ZHdhcmUNCj4gZGV2aWNlIGFkZHJlc3MuIEZhbGwgYmFjayB0byB0aGUgZGVwcmVjYXRlZCBtaWNy
b2NoaXAsaHctZGV2aWNlLQ0KPiBhZGRyZXNzDQo+IHByb3BlcnR5IHRvIHByZXNlcnZlIGNvbXBh
dGliaWxpdHkgd2l0aCBleGlzdGluZyBkZXZpY2UgdHJlZXMuDQo+IA0KPiBUaGUgZGV2aWNlIGFk
ZHJlc3MgcmVtYWlucyAxIHdoZW4gbmVpdGhlciBwcm9wZXJ0eSBpcyBwcmVzZW50Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSmFuYW5pIFN1bmlsIDxqYW5hbmkuc3VuaWxAYW5hbG9nLmNvbT4NCj4g
LS0tDQo+IMKgZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYyB8IDQgKysrLQ0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2lpby9hZGMvbWNwMzU2NC5jIGIvZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYw0K
PiBpbmRleCAzNjY3NTU2MzgyOWUuLjcxZGViMDVlODc4ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9paW8vYWRjL21jcDM1NjQuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvbWNwMzU2NC5jDQo+
IEBAIC0xMTIyLDcgKzExMjIsOSBAQCBzdGF0aWMgaW50IG1jcDM1NjRfY29uZmlnKHN0cnVjdCBp
aW9fZGV2DQo+ICppbmRpb19kZXYsIGJvb2wgKnVzZV9pbnRlcm5hbF92cmVmX2F0dA0KPiDCoMKg
wqDCoMKgwqDCoMKgICogYWRkcmVzc2VzIGFyZSBhdmFpbGFibGUgd2hlbiBtdWx0aXBsZSBkZXZp
Y2VzIGFyZSBwcmVzZW50DQo+IG9uIHRoZSBzYW1lDQo+IMKgwqDCoMKgwqDCoMKgwqAgKiBTUEkg
YnVzIHdpdGggb25seSBvbmUgQ2hpcCBTZWxlY3QgbGluZSBmb3IgYWxsIGRldmljZXMuDQo+IMKg
wqDCoMKgwqDCoMKgwqAgKi8NCj4gLcKgwqDCoMKgwqDCoCBkZXZpY2VfcHJvcGVydHlfcmVhZF91
MzIoZGV2LCAibWljcm9jaGlwLGh3LWRldmljZS1hZGRyZXNzIiwNCj4gJnRtcCk7DQo+ICvCoMKg
wqDCoMKgwqAgcmV0ID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRldiwgInNwaS1kZXZpY2Ut
YWRkciIsICZ0bXApOw0KPiArwqDCoMKgwqDCoMKgIGlmIChyZXQpDQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJtaWNyb2NoaXAs
aHctZGV2aWNlLQ0KPiBhZGRyZXNzIiwgJnRtcCk7DQo+IA0KPiDCoMKgwqDCoMKgwqDCoCBpZiAo
dG1wID4gMykgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2Vycl9wcm9i
ZShkZXYsIHRtcCwNCj4gDQo+IC0tDQo+IDIuNDMuMA0KDQpSZXZpZXdlZC1ieTogTWFyaXVzIENy
aXN0ZWEgPG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5jb20+DQoNCg==
