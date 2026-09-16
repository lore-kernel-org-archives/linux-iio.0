Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D94A260F;
	Wed, 16 Sep 2026 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551744; cv=fail; b=cXpXtLBb0e/qk2TEWj6AdlWdT800k3kunWDbez9h2C9KQBIhSZuRrw3WnJqOHKhG1tvef65z8tkurciNoltTXxohIRDOw8UzTtUm14jNG7dNvRULgFSZEjfUfTA0x/D+xXcdTgLY/oOwSs++6ADDtJEwpcb9loDbFLYMyUta3M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551744; c=relaxed/simple;
	bh=EC8xbnjnauBBkwWsb73aODaTlBS/cneg9CxIlD7rJ7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnME6tX0sEVHBO9ThLAXIqeXmzHdnPKUk2j4XJfmKxcUWgw6TlNZ8L4ZipYO6j7HVT+eNiSpRCWKGCPqnpsU1VDtHbXkRD3PpNFvNRF/oerzy6mg4N5T0QZq/ZZMxdDWL5S8hFtUbKbFZZJOC5mh02D+PGl/AKopZEvbTMa/Bes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=e38yfRd4; arc=fail smtp.client-ip=52.101.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="e38yfRd4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCeE6SQ6/Dy4Vzek0QTxyI1Pl6sQ4eqLMViaCCLpw3hWbnCMbsfm1fMJVLxYDdTo3yo6cgbCxC5+nMT+EvMlDL9GHepH2BGl6+0/zi/QqmAgOXVFiQjWInqER8cgget7CWwbwLJh7Imnv25AgYAwtreV0r9w2vOBrYv+hFdgYkPewnjt00Vx338tpnQ7gdmujDGVzapOp8i1ZwFxbKqw4SqNmyacuIeOBpDnjcoHEETXnVpnX18DiIWGcZ48rxeZP5POcNXrfq1rcFnlMTBeJiTIGUqmUwJb9xbuQq02lMYjg5Si4+UzWoSs2OUfKDg6atJWMDBdHhSoyrZMMIBV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC8xbnjnauBBkwWsb73aODaTlBS/cneg9CxIlD7rJ7k=;
 b=TFCId6c7LTmUf1FnV0gIn/F7pMqjTjUg1uKa74iQkdBiEApCaaX2j9XeVKc6y89OsTZ1S+N2PXPcmixUe+QOxfriBLykAYGGcbJZB6VZFw1I9p+5ItApIloIbhG84xHvgSUzcLUTZwZmzwkRdP9MuM4fjrvHaN4zFVxc7NYLBEHwQC4pQ87PA4id7pRFSmVIwC+lVKNamp6HN9qg057sFhF3etw+BYy6yzcRMNjFKBnOew0NIolnJfEOm/7Br4zWO/vD9r/pYXYri23w0FxSjR2H08GSIAjnkJqXmrRJtbmi24GXDyeWTqnFgbLWITf6S0FS+kv9COQzPFABFma5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC8xbnjnauBBkwWsb73aODaTlBS/cneg9CxIlD7rJ7k=;
 b=e38yfRd4NNK8cFDr/Kk1YGykx1RB35J6+nIdNMcWhcYNyfiTp1oqULy33AECgiqB7rTZb49RC1Ft8BEUw2xpCwEmAcomcU7Ud0oF1JAlT/F+fCXjAW4CDbyRVjooeSrxl9zC2HuLNoa4V3RR0kBZSZgY9yiroUWdKMvTNuI+5D8=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by GVX0PF157A2558B.eurprd02.prod.outlook.com
 (2603:10a6:158:401::b07) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 09:42:03 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%5]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 09:42:03 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "macromorgan@hotmail.com" <macromorgan@hotmail.com>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>, Kernel
	<Kernel@axis.com>, Henrik Grimler <Henrik.Grimler@axis.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>, "jean-baptiste.maneyrol@tdk.com"
	<jean-baptiste.maneyrol@tdk.com>, "robh@kernel.org" <robh@kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>, "andy@kernel.org" <andy@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Thread-Topic: [PATCH v3 7/8] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Thread-Index: AQHdOh88BMzhlSng1EGhR8lSUpATibbP+tqAgAEQJwA=
Date: Wed, 16 Sep 2026 09:42:03 +0000
Message-ID: <e2e6b3b8bcfc841d15241e54eeb18a13ec10994a.camel@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
	 <20260901-b4-inv_icm42370p-v3-7-77cc31642115@axis.com>
	 <PH0PR19MB9973387A54F1734E51312C4C92A5BA2@PH0PR19MB997338.namprd19.prod.outlook.com>
In-Reply-To:
 <PH0PR19MB9973387A54F1734E51312C4C92A5BA2@PH0PR19MB997338.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|GVX0PF157A2558B:EE_
x-ms-office365-filtering-correlation-id: 26b9c7ca-dbdc-447b-9304-08df13d6c380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|6049299003|4053099003|4013099003|3613699012|38070700021|6133799003|3023799007|22082099003|10067099003|4143699003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info:
 8OL7V5igNaK34IooZprglUzYWXwghJvAW8fkMKNXlgV/20Bo5olUnMjbjZEqANJNKiNkPjdDorq701VGvINWlRVytVe8qyrB5y4rfVEtIXsOM8gWVgyg4v6FpNAp7lEzSSjczPB6AnxLp/MhdEYykV3SSd9YkBU+Lo7PJOxmFq5KGVX0Krh/OojP3oDGfYUfyZSqxBlNFELYjAOO7BVRiiKQnsVsp0MUQyPvCxKxru1wg1dumz5iNsU+74iUTUQmdE1eVWiHoT1Yh8zDhgsh9cT8/eX0mnNAVisJqE8Q7yLVTLoXN3tN4DHC7k8hewokpTd2UgDLajcJt7NDLfU7EOPELdd+GRSmPKUaD9UHJVIhZLbxt0/2syFPVPqYidCYWFlpH2CIK45KGXFTBEPQ5njZk2Ca8Fv8b7IlFu0U0KIgWZOeJyIi+q8Y77PF0dU6sSnzcPUmkAI21n0nXmG2og+tA9HaNOFbNqJCHswQVE+Sa80Ocvzt8f+IoxSsO7/DKM7ah7KkRFqO1IZly1MOLgyNY7Eja7XjWySuB+pfFps4wLyNbQrAHXnHZprgIB3aSBNG4ExffsY49NswY4GKhrK0gd4QvVeOLjGT4NkPNtNVc+4eclP0x2gTcoErP/cnizqNGqrKqo/cKqAauG3QjeWRJOhDEixji99kLG23kixAhwnb4biZbPOe79rGyjsqrSnKRn7eiE+LP7hMxqhg2g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(6049299003)(4053099003)(4013099003)(3613699012)(38070700021)(6133799003)(3023799007)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTNXaHo4SFZVVGZXaERoRE5RSURxRGNEMk0xYlgrcnp0YTVHbFllTDIybGx3?=
 =?utf-8?B?VlZxVDBIb09YL05rZE1scWc5dU5pMHRNWWY3VHFsSWVBbHRJM2N0T0tTeDRS?=
 =?utf-8?B?dFNIT0k4aTVacTFYQlhQZG8yNHNLejRhYzI5dVlURThBZHNIcFpyMEljSmZh?=
 =?utf-8?B?ZUhyNGQwWFFnTkQ1c0s5V2VBYXQzRXZYNitPY1dtNWZxNmdLNHFrNVVVYmd6?=
 =?utf-8?B?R1VBNDNUQmhaSkdBZkFwSlF4U3JiR0dvM1pkNlF1YUFlTWZqOXlEYksrYW9J?=
 =?utf-8?B?eXM4dXp0eHdWSEZVMFhiUkJ4Sm8vWDJuM1NPNko2b3dTZXNPNlFHODhhSm5k?=
 =?utf-8?B?RXRYRWdteVpxdFc3YnIxclFFMjAwMVpEamZKaVM2aytQNHU4WjdSS2tFMWt0?=
 =?utf-8?B?enlMbTY2SXE4c3BVT3FBdkNyemZjMU5CZzJ2eGtiRUdDd096TE1WdUhlV0pz?=
 =?utf-8?B?bkJtY0VmQ1dtdjdacjBDN2I4bDB6V0dVMmlUT3dnRi83eDdMbWMrcExib003?=
 =?utf-8?B?WG9pN0VtTUoxVmRONFNhTk1qVW1UYVV1TjNkUEF1cEUrYUVkcUhZbC9vWmlC?=
 =?utf-8?B?QzFCc3NwdXlteE5FLzUxS09qWE0wMTVSRExzYWFEb1V3VUVZT0ovMXQyWUEr?=
 =?utf-8?B?RUZvWm9FV21LMCttdnB5UXkrdGhxZmJYV3QvZkFFRFF3VW44YllJYlBLSjhY?=
 =?utf-8?B?bE1EMld4cWdXRDNmMWJPZGNqdm1sbHhmZE1jY2ltSVJJU0pHeGs0ZldpOGRE?=
 =?utf-8?B?cWl6UmVUT2pHVVY3cU5kNlUwQWNkNWMvY0RaZE1SVkdWdmlhZjlvZXZib2xq?=
 =?utf-8?B?UHZFZFVvZDhNTWtpL3kxSU0wT1F4RllLb0Jwa0lvNWZtR21NelZab0pQQmsv?=
 =?utf-8?B?RzlCRzZzUkhpbHE0Rkl3RGREc1dZMXRqbXBVWG1JekgvdUtvUmRWeFJBSmlC?=
 =?utf-8?B?Umx0RW01VEUyOEZzTjVSWDNlT0ZsaEFwM0FFSVg1K2c3NGkyNGxGT1FqV0NO?=
 =?utf-8?B?THJYd2VvK1Y3MGJBN0dZUStqbGRTeGZsR09UdWxBVzhSN0R2eWc1TDFibXZi?=
 =?utf-8?B?NE1sL3JjS1JyS3Nzbk5CS1RuOHpoZ3FaaFBCNTBCejlYdVhmT1oxTGp0V0Rz?=
 =?utf-8?B?YVNjazVTcmdmaUJRNkRZWmlrVEJyWjU4QkNqYUN1cjNHKzA4S1IwZzZNV0hl?=
 =?utf-8?B?aURFeGVzLzJSUGJaQS9pQkgyV3p6T2dnc2w1T2tUc1FzUGV3T2QyZ3hxdGJO?=
 =?utf-8?B?clNhbjZXbWxaVk1zeGVrc3llNlAxM0F4eWJYcG5VbnI2VG04Ynp6VFgycWJm?=
 =?utf-8?B?RlowSFlid2NnRXEySU5PM1VjQ3NLN096OXp4YnA3TVgveUFFaGhDQytjM0RX?=
 =?utf-8?B?NEZxaUpnT3UzdmJsZWg5U09EeFh0M1JFMnRkR3dQWnlMUFpSNVVYcm0vc1o1?=
 =?utf-8?B?VlRwclY1cFRYK2t2RFNGM3owNVVoQVhBMGV4b2ZiK0IyQnJoMCtBRU1hYldD?=
 =?utf-8?B?SVRsNElqaUZ0Ymx4SkJZSHliUTZDeEZhTy9VTER6OWZEemJmUitVNDRNbGlB?=
 =?utf-8?B?alBZeFBYb3lXVEJUZXVlOGdNdjArOTY5N2doRlFUSUVIL0prZWowc0NuUGJ3?=
 =?utf-8?B?SDdnaUYvTHJPRm53QmlDTVdDWGZiZUNpNlNod2V4QzR3K0hQUmtMejRhMTd5?=
 =?utf-8?B?WjVPUnFidmw0Vk9JaEhDaWM4aitzTkxLdkl5R3VIS2lOdkdkZ0RNTmJKQi9z?=
 =?utf-8?B?ZVJuSkc0dS9tRWFGaUxNcGFQdmFNVXZ3R3c2YXl0ZVc2dS84OXl6VFdaUCsr?=
 =?utf-8?B?MWk3eGt6akdmL2l1bHNDMjJleS9CZmdMbjE5Mi9BTWRySFlteitJYmJuejVK?=
 =?utf-8?B?Y1BTWkZWTFdHSC8vaVdIQm5IdDUyK0lCTU1jUkhmcUxVTkY4T0tVejBoV0ZW?=
 =?utf-8?B?c2dnNTlVa1RTM1hUaXQ1RytCWG5TUmFEekRYZmI1eXR1bHU5eVZXb2c0TFJa?=
 =?utf-8?B?bUF4dmd1QTJrc2xrUXlheFFySVk4d3ZHRm5VNDhodU5kTzVMRTdWelZRUmxk?=
 =?utf-8?B?YkxCQ1krdkJlL2VlUWRtdDQxcjJnMlJ1Y1oxWDN5MVd0YTBTSlZaRmxwRnBk?=
 =?utf-8?B?OGRMNEhTaUpZN2JDRFNQNTdpcFRUTS9XdW11Q1RSMmJkdzkxUDVOWXNwZ0hW?=
 =?utf-8?B?QldUdkpqZTNEV3BUcFhNRlNiU2g5Yi9hTHpOSlVjQ3dMMEptWkRPQTZxc3Rl?=
 =?utf-8?B?TERtQ2tUZCtPRFY1Z3RmUnhVZTVmTXlxWHFVRUREYm9nb1RFRXJmdE5sdTZu?=
 =?utf-8?B?bTg3eEV3U2RzYlNiakhFOXNUODFXRHZSdnRyRTZYdHluK0ZwanAvZz09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-zBSJXs2+PQXrYdZxSZTD"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b9c7ca-dbdc-447b-9304-08df13d6c380
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:42:03.3299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlf87cN93/yd7iy1/YmLRznNK2+WOpTIonAxsJHGJncnrloVM6jUdGLppsriB+by
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVX0PF157A2558B

--=-zBSJXs2+PQXrYdZxSZTD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgQ2hyaXMsCgpPbiBUdWUsIDIwMjYtMDktMTUgYXQgMTI6MjcgLTA1MDAsIENocmlzIE1vcmdh
biB3cm90ZToKPiBbU29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBv
ZnRlbiBnZXQgZW1haWwgZnJvbQo+IG1hY3JvbW9yZ2FuQGhvdG1haWwuY29tLiBMZWFybiB3aHkg
dGhpcyBpcyBpbXBvcnRhbnQgYXQKPiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRl
bnRpZmljYXRpb27CoF0KPiAKPiBPbiBUdWUsIFNlcCAwMSwgMjAyNiBhdCAwNDozNjowMFBNICsw
MjAwLCBLYW5hayBTaGlsbGVkYXIgd3JvdGU6Cj4gPiBFeHBvc2UgSUlPX0NIQU5fSU5GT19DQUxJ
QkJJQVMgb24gdGhlIGFjY2VsZXJvbWV0ZXIgY2hhbm5lbHMuIFRoZQo+ID4gcmVnaXN0ZXJzIGFy
ZSBzdG9yZWQgaW4gTVJFRzEsIHdoaWNoIGNhbiBiZSBhY2Nlc3NlZCBieSB0aGUKPiA+IG1yZWdf
cmVhZAo+ID4gYW5kIG1yZWdfd3JpdGUgcm91dGluZXMuIFRoZSBjYWxpYnJhdGlvbiBiaWFzIGlz
IHdyaXR0ZW4gdG8KPiA+IE9GRlNFVF9VU0VSNAo+ID4gdG8gT0ZGU0VUX1VTRVI4IHJlZ2lzdGVy
cyBpbiBNUkVHMS4KPiA+IAo+ID4gTm90ZTogVGhlIGFjY2VsZXJvbWV0ZXIgZnVuY3Rpb25hbGl0
eSBpcyB0ZXN0ZWQgd2l0aCBJbnZlbnNlbnNlLAo+ID4gSUNNNDIzNzAtUCBkZXZlbG9wbWVudCBi
b2FyZC4KPiA+IAo+ID4gRGF0YXNoZWV0Ogo+ID4gaHR0cHM6Ly93d3cuaW52ZW5zZW5zZS50ZGsu
Y29tL2VuLXVzL3Byb2R1Y3RzLzMtYXhpcy9pY20tNDIzNzAtcAo+ID4gRGF0YXNoZWV0OiBodHRw
czovL3d3dy5sY3NjLmNvbS9wcm9kdWN0LWRldGFpbC9DNTEyOTk2Ny5odG1sCj4gPiBTaWduZWQt
b2ZmLWJ5OiBLYW5hayBTaGlsbGVkYXIgPGthbmFrLnNoaWxsZWRhckBheGlzLmNvbT4KPiA+IC0t
LQo+ID4gwqBkcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjA3L2ludl9pY200MjYwN19hY2NlbC5j
IHwgMjM4Cj4gPiArKysrKysrKysrKysrKysrKysrKystCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAy
MzYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDcvaW52X2ljbTQyNjA3X2FjY2VsLmMKPiA+IGIvZHJp
dmVycy9paW8vaW11L2ludl9pY200MjYwNy9pbnZfaWNtNDI2MDdfYWNjZWwuYwo+ID4gaW5kZXgg
MzE4MzczZWZlYjllLi5hZjJhYzlkNmE0N2MgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2lpby9p
bXUvaW52X2ljbTQyNjA3L2ludl9pY200MjYwN19hY2NlbC5jCj4gPiArKysgYi9kcml2ZXJzL2lp
by9pbXUvaW52X2ljbTQyNjA3L2ludl9pY200MjYwN19hY2NlbC5jCj4gPiBAQCAtMTMsNiArMTMs
NyBAQAo+ID4gwqAjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPgo+ID4gwqAjaW5jbHVkZSA8
bGludXgvcmVnbWFwLmg+Cj4gPiDCoCNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgo+ID4gKyNpbmNs
dWRlIDxsaW51eC91bml0cy5oPgo+ID4gCj4gPiDCoCNpbmNsdWRlICJpbnZfaWNtNDI2MDcuaCIK
PiA+IMKgI2luY2x1ZGUgImludl9pY200MjYwN190ZW1wLmgiCj4gPiBAQCAtMjIsOSArMjMsMTEg
QEAKPiA+IMKgwqDCoMKgwqAgLnR5cGUgPQo+ID4gSUlPX0FDQ0VMLMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gwqDCoMKgwqDCoCAubW9kaWZp
ZWQgPQo+ID4gMSzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgXAo+ID4gwqDCoMKgwqDCoCAuY2hhbm5lbDIgPQo+ID4gX21vZGlmaWVyLMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+IC3CoMKgwqDCoCAu
aW5mb19tYXNrX3NlcGFyYXRlID0KPiA+IEJJVChJSU9fQ0hBTl9JTkZPX1JBVykswqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKg
wqAgLmluZm9fbWFza19zZXBhcmF0ZSA9IEJJVChJSU9fQ0hBTl9JTkZPX1JBVykKPiA+IHzCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiBCSVQoSUlPX0NIQU5fSU5GT19DQUxJQkJJQVMpLMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFwKPiA+IMKgwqDCoMKgwqAgLmluZm9fbWFza19zaGFyZWRfYnlfdHlwZSA9Cj4g
PiBCSVQoSUlPX0NIQU5fSU5GT19TQ0FMRSkswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFwKPiA+IC3CoMKgwqDCoCAuaW5mb19tYXNrX3NoYXJlZF9ieV90eXBlX2F2YWlsYWJs
ZSA9Cj4gPiBCSVQoSUlPX0NIQU5fSU5GT19TQ0FMRSkswqDCoMKgwqDCoMKgwqDCoCBcCj4gPiAr
wqDCoMKgwqAgLmluZm9fbWFza19zaGFyZWRfYnlfdHlwZV9hdmFpbGFibGUgPQo+ID4gQklUKElJ
T19DSEFOX0lORk9fU0NBTEUpIHzCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgCj4gPiBCSVQoSUlPX0NIQU5fSU5GT19DQUxJQkJJQVMpLMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwK
PiA+IMKgwqDCoMKgwqAgLmluZm9fbWFza19zaGFyZWRfYnlfYWxsID0KPiA+IEJJVChJSU9fQ0hB
Tl9JTkZPX1NBTVBfRlJFUSkswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+IMKg
wqDCoMKgwqAgLmluZm9fbWFza19zaGFyZWRfYnlfYWxsX2F2YWlsYWJsZSA9Cj4gPiBCSVQoSUlP
X0NIQU5fSU5GT19TQU1QX0ZSRVEpLMKgwqDCoMKgwqAgXAo+ID4gwqDCoMKgwqDCoCAuc2Nhbl9p
bmRleCA9Cj4gPiBfaW5kZXgswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBcCj4gPiBAQCAtNTYsNiArNTksMTYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fY2hh
bl9zcGVjCj4gPiBpbnZfaWNtNDI2MDdfYWNjZWxfY2hhbm5lbHNbXSA9IHsKPiA+IMKgwqDCoMKg
wqAgSU5WX0lDTTQyNjA3X1RFTVBfQ0hBTihJTlZfSUNNNDI2MDdfQUNDRUxfU0NBTl9URU1QKSwK
PiA+IMKgfTsKPiA+IAo+ID4gKy8qCj4gPiArICogQ2FsaWJyYXRpb24gYmlhcyB2YWx1ZXMsIElJ
TyByYW5nZSBmb3JtYXQgaW50ICsgbWljcm8uCj4gPiArICogVmFsdWUgaXMgbGltaXRlZCB0byAr
Ly0xZyBjb2RlZCBvbiAxMiBiaXRzIHNpZ25lZC4gU3RlcCBpcwo+ID4gMC41bWcuCj4gPiArICov
Cj4gPiArc3RhdGljIGludCBpbnZfaWNtNDI2MDdfYWNjZWxfY2FsaWJiaWFzW10gPSB7Cj4gPiAr
wqDCoMKgwqAgLTEwLCA0MjAxMCwgLyogTWluIDogLTJeMTEgKiAwLjAwMDUgKiA5LjgwNjY1wqDC
oMKgwqDCoCA9IC0KPiA+IDEwLjA0MjAxMCBtL3PCssKgwqDCoCAqLwo+ID4gK8KgwqDCoMKgwqDC
oCAwLMKgIDQ5MDMsIC8qIFN0ZXA6IDAuNSAqIDAuMDA5ODA2NTXCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCA9IDAuMDA0OTAzCj4gPiBtL3PCssKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDCoMKg
IDEwLCAzNzEwNiwgLyogTWF4IDogKDJeMTEgLSAxKSAqIDAuMDAwNSAqIDkuODA2NjUgPQo+ID4g
MTAuMDM3MTA2IG0vc8KywqDCoMKgwqAgKi8KPiA+ICt9Owo+ID4gKwo+IAo+IEZvciB3aGF0ZXZl
ciBpdCdzIHdvcnRoLCB3aGVuIEkgcmVhZCB0aGUgY2FsaWJiaWFzIHZhbHVlcyBmb3IgbXkKPiBi
b2FyZAo+IGZyb20gc3lzZnMgYWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaCBJIGdldCAwLjAwMDAw
MCBmb3IKPiBpbl9hY2NlbF94X2NhbGliYmlhcyAob3IgeSBvciB6KSBhbmQgaW5fYWNjZWxfY2Fs
aWJiaWFzX2F2YWlsYWJsZQo+IGdpdmVzCj4gbWUgYW4gLUVJTlZBTC4KPiAKPiBCdXQgdGhlIGFj
Y2VsZXJvbWV0ZXIgc3RpbGwgc2VlbXMgdG8gb3V0cHV0IGRhdGEgY29ycmVzcG9uZGluZyB0byB0
aGUKPiBjb3JyZWN0IG9yaWVudGF0aW9uLgo+IAo+IFRoYW5rIHlvdSwKPiBDaHJpcwoKVGhhbmtz
IGZvciB0ZXN0aW5nIHRoZSBwYXRjaC4gSSBoYXZlIGZpeGVkIHRoZQppbl9hY2NlbF9jYWxpYmJp
YXNfYXZhaWxhYmxlIHJldHVybmluZyAtRUlOVkFMIGFuZCBzaG91bGQgbm90IGJlIGdpdmluZwp0
aGUgZXJyb3IgaW4gdGhlIHY0LiAKCkJlc3QgUmVnYXJkcywKS2FuYWsgU2hpbGxlZGFyCg==


--=-zBSJXs2+PQXrYdZxSZTD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCaqpkagAKCRDEY9j7t8Ka
Z87PAQCXp8b2MjhwOmdPGK5DbkbUYoAgG+ujfca75ODLFgMV2QD/QAzThPTO4CTY
dkJYSmobVrsonwzEQZGMqtJoSEm22Ag=
=2iM4
-----END PGP SIGNATURE-----

--=-zBSJXs2+PQXrYdZxSZTD--
