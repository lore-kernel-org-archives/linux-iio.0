Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0884424D6E;
	Mon, 14 Sep 2026 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377816; cv=fail; b=fJVdlYNCTZXNxgxrT3tCy0IZzP4Kh78m3fJxY6vcCUBwhUA2kNw0oG1hjbDqz9fDb5J4Hz967AFTPzk8aLFlpmXdse/W2mIQlIJFgwx7Y4454WRfpVy2ZRNu5xKX7KcfAOuqOPoqtZme3YVLCRasFXfu1X9LoIFCEdRRie5yd18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377816; c=relaxed/simple;
	bh=CT9UCT7zUIDLuvqXWiXX/TPG3nyLue+QdIGDZkHWBQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uirPIzF40srqgZ0QfxHL0iGN7O1uB+30GNPTiJypFuqcG6sMkT1SHtRmiWIazuM+Wb9nQ2wbpMEAtx1j9MIbktRVds6rKzbPMbPbtc84ZpqOgd7RCKMxkELFEpO1QC7+jtBANTkdJGoKwNJYSeQd6+eGpGgz/cMT2Yk+48/kc8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=VOAsbGAl; arc=fail smtp.client-ip=40.107.159.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="VOAsbGAl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjJJxPYnnZK62rTVycW7QWdvM4hXkVLvDsRNf1Qn7X+Wvcr9JFvO2bNU8OY/faHPXLR79DT9B/Wfj1fQyhhe7yfhX+ZZx93BQftUiVaTNmXG+OBzu+wuSX5nrqOTYRAQXNAB+9Pu8VPkhvGt5aQJLWY3C2YGpEjG+dz701kk0M8e+tuNzRcyY9naneWfKYkpFEDPnpZHU4Gnrrfgvrl1aH+3kMQ8iSoAelA0J1nPfxgBFDcQz41GPMDlDCbnQPWs4a90CMxBnhjKsn0SmbBuANY+BlHwyEcTDAGpjKxUfRNlfyjtdOJegbZYOZG9K5ktFDDLR1DFo9a13M7RimogDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CT9UCT7zUIDLuvqXWiXX/TPG3nyLue+QdIGDZkHWBQ0=;
 b=KvfjOpkkcJpTrK3gY1IrQmuTi/equIBDb26SZxUZJ4LHw8SSxEjwcuv+7LiZeuDQnQ39oHRb/1JCTZekNPGOkKKQm5BlvAM9MB7f8aWI9oKT6lzDaxqWBuHiYIOg4yANJVzQyFS+41gd8LVhnaBC5w/3v/7CcsCZUYOVBqR+6ViR0wvNIHPMHQ0Te7/POT/E3xu2Kg3RSCpibu+4vVBSr+eMF99P5TAWtxawd0xwaSuYnVFdNd+8ouRUfcU43RW8pAdLRU9/9o9FSwqHcmVYs/1xtVhK7BV8W5fnSki0csg9/HngTAgOQR+740b8yqRpzhqqWhbZ/JeSGvjebBFOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT9UCT7zUIDLuvqXWiXX/TPG3nyLue+QdIGDZkHWBQ0=;
 b=VOAsbGAlyh9gNqHdG9kRbG7wht0K3hJHzmqCupPpPssx1Ux8GwcwgcNg6oNBnP4P22i/2JWdH2vXz6k2uNBp1ZrQlODB4X/wvRH6OzrwXlHvuBaTXEbx7EwZYdRpb0mFkxzjzaZHhzrPsbOjh+IwGg4W7dtL9HdftJrEe+hDuVA=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by DBAPR02MB6086.eurprd02.prod.outlook.com
 (2603:10a6:10:18a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:23:30 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:23:30 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>, "lilinmao@kylinos.cn"
	<lilinmao@kylinos.cn>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>, "dlechner@baylibre.com"
	<dlechner@baylibre.com>, "macromorgan@hotmail.com" <macromorgan@hotmail.com>,
	"andy@kernel.org" <andy@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH togreg v4 0/2] iio: imu: inv_icm42607: fix PM error
 handling
Thread-Topic: [PATCH togreg v4 0/2] iio: imu: inv_icm42607: fix PM error
 handling
Thread-Index: AQHdQ/Xwy/3Ddj/A8UqydUz/6+Stl7bNzVWA
Date: Mon, 14 Sep 2026 09:23:30 +0000
Message-ID: <e22f347129cbd5ecebf93eca3a44541a1b740bdc.camel@axis.com>
References: <20260824035531.141429-1-lilinmao@kylinos.cn>
	 <20260901022243.740760aa@jic23-huawei>
	 <20260914040534.772a4aeb@jic23-hlaptop>
In-Reply-To: <20260914040534.772a4aeb@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|DBAPR02MB6086:EE_
x-ms-office365-filtering-correlation-id: c4ff8786-bad3-4165-4b30-08df1241d746
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|6049299003|366016|376014|22082099003|18002099003|4053099003|38070700021|3613699012|11063799006|5023799004|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 bBshYJUiEs2A4cN1l/+5Nb0fEWokgoAcB8N+0Lb5tq/xcFCQpKeL9vxjQi6Riuhb6A0F3vnLmt06SfRDK41j87NHfH2BQQQLMF4Mo4zC5i3Y9SBi/f1DBuR1qr6h4agurLkgGRb4gM6dIS0Us1dcbEut22INalpOVvm3X8rGYSXLkjLWjNY71UHuwP/9WdJB8CNDAuaWcEtNo4i2eTsCUnRAuJNJkNKTeMRGhjL7SsGr+kEaFtX9FkvyJGBbzuekwxh2RMA+79J0HKOXHCLEhTbZeHBZOAWdA+5nso871eCutYeeWXtob2ttSdGWHcTAZXyk+NImXGMYL+7rCd1l26PpHQUALLGIUlrGfBdDL02ipy9Rvgh77Wfz6I2qFtO/Q6EJQj/fgZk9cspvwNBsyrnhmtPw9xs8PVucAN3GzKe40FsnuqWUIyvWsOAN6jfLYX5Of3CKSsXgq5/InpVvJx3j7XJ+a76Q2yFVBV/oK1pAF9RYuZiQ0nmQxYmqESaexW1xKg6l9VsTawzNPgrWHMS8RJzboI7Hy1rRuYH7tiuSxAdp41pTsu7mAAuqjJwpVSsYdMv9QmjWVqMFh7DyiBLf8IYJHlX2cFJWw8bh3AdZ2nQAi1oYRx+qLHsUhOs1+Xemt/r3p3x48LOceYOHDj6jlLobY6OjpXhVRDhrw27VT4tOAGC4KcGY5f/LqNGKQpkxeyxVsFwK8aXEcY8pLoTrPK52LVuR6oXgz/AFzSsfMN2Z/mQQR/aOrXloOrbW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(6049299003)(366016)(376014)(22082099003)(18002099003)(4053099003)(38070700021)(3613699012)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blRidGttdERZSjFLRU43d0JZSXJSMXUvWVNydGYwUFlqRFlCNHFPOS9VK3Zq?=
 =?utf-8?B?NHk4S3RGano4L0FXb2RFcDVzaHZYYy83RTErK056cjh2WitEV0FvS0MzWERx?=
 =?utf-8?B?b2Zoa3FxVU9GTXdmZytvQjY5cnBSRUhRK2pvOGRzMGtreGZHTXppNytkemNo?=
 =?utf-8?B?MG5mdzJPL0xWV1hCWlpWcSswb0RBbEpiOGtYUVhDbHRXRWI5aWJWNG95YTVJ?=
 =?utf-8?B?WUQ0d2FNdEswTmQzRkd5bkF5UjBkM2xiLzBhSC90Mlh4WkczVnIxems0TVY2?=
 =?utf-8?B?K2NjSVd2Y25lTTNadUlXdURpcGxORjVjOXh5cXJGZ1BwY3h6RDlpMGUzek1Y?=
 =?utf-8?B?YmM2TWF3bFNSUG1Qc2dJcW54WjVPZ3VPRmxwVldCTi96aGM4K0M0WEFOQTdG?=
 =?utf-8?B?dWMvbGlOaDdpYzBnMGw2VEJ5VmRpY1YzaXpXcGN1L2xmRktVVk8xUll0cjRL?=
 =?utf-8?B?SVYySU1naHdGaktTQzhQeW50NWE4UTZoZS9Bem11RHllVTg1ZXZub01rNS9P?=
 =?utf-8?B?ZWlMTlpocnhoV0FwTlpGL2ptc25MVGZ1OVBUSUQ5KzNYYlFzbExseDErbTBv?=
 =?utf-8?B?cTBNZGdpS0tZVjVVRnM4d3Ewa2hUQzNGOWh2a1ZMYkZ6SkNKSHlIdS9yVTZY?=
 =?utf-8?B?RjFUM0tkUUNJR0hieUgyNUFFR3FRMjZxQkkvSDJlNms4MXlXRkRtZHFscWNv?=
 =?utf-8?B?d3lDTUdSK1lDSzNnNytaUllCZ2RRUlFoeXFqanZ5QjQ2STNYb0pnYU5RSlNq?=
 =?utf-8?B?S09sS2lLY044dzNIc0diQnNKTVhJbnRCekhTWjdqZWVGckR0b3FIYUg3SmRm?=
 =?utf-8?B?SitDNGtoSndOSUZsdFdNdmhCUU0yNmVna2dLMFJHMmpObDNQTkZrMzE5Z3VJ?=
 =?utf-8?B?MHJUNGVSOVk0eTN2aU5RNytEclB3ZGtlTlptM3h1bHpsTG1jZ3VSK3hKeHNJ?=
 =?utf-8?B?NXBVdkd4b250bmx5NWZUc3A4aXFiNkdnZG5HdnlOdFNvY2krazhIWnROZ29x?=
 =?utf-8?B?RW5BSFZORkxQMUk0MnVNem1pelJwNDFLSzZkcDgycHJ2WUp2NXNBcVFJNmMv?=
 =?utf-8?B?aXZUZmhxSXVpT0RFS1AwZFhXZFVNWHJUeDVqbnp0VWJMTGN6STZWYVNacndH?=
 =?utf-8?B?ekh2d0RFMjF1Z2h3dHpjMFVyLzl2NnAxMjBIb0wvUjYrZGxlUnJ2U0hMai9N?=
 =?utf-8?B?Umw3OElpenBoeU9FcGd0SSs5VVgxVW0vUkd2ZWxpaVVKeU5wV1F2SnNodGJx?=
 =?utf-8?B?aWdEM2xnQnpMd0MxZjI5UVdWQ2JjVTkxSEdNUytDbEFJNDNBQUNpUFBCWjNl?=
 =?utf-8?B?SG5rcS9EYlJCVjZHMDhlWTQxNzRsTUo5a3BYUkNLd0NKam1wbjdTclNCQXBR?=
 =?utf-8?B?UjVxZS8wY21pNzNKbGtkZHVEc0VsYTcrUlRoZHh6QXV3QmdORkFWKytnN2R3?=
 =?utf-8?B?eWJDWlMzVU9WN2x5cFN4UEVNZE9uNnRRbU9oMVNseG52QnplanFWRVdTdkRp?=
 =?utf-8?B?aDVlMlM4NmJJLzVDa2tuSGdXaFozUEZ1dkp2WjJUWXdBVll6MWVYOFc2VW1V?=
 =?utf-8?B?VVdDdnlEK2c5UUk2V0MyRzRLaDZKdTk1eEx4bDlXSW9rRXM5VElxVWozV25W?=
 =?utf-8?B?Mjc1bThSQUxFMmxMVzNDdnBQVzFaMmIvQXJPNlFoUmNrbnQ5em1MaGFaT0hs?=
 =?utf-8?B?WHBtcDFrOUZIdU15RjE1ek9neHEvTm9TSk1qL0k1QkZNR2dRcEtxS2RZWlZr?=
 =?utf-8?B?QmljM3l6SVdnWGFrZ0duZnpXZVlYTklORXdjeVhReDVGdndKYW56T3pWMzV2?=
 =?utf-8?B?SVNuL29xai9TeFR0TGtRQ3N3ZkhRWThJcEd3WmhNdWF6NGlreGJ5OGJVQUJ3?=
 =?utf-8?B?U3ZyRXRVSm1BQmZqT0tnMjJHaGZxZHZWaFRpNzJma21weG9FcVhLUCtJMEU1?=
 =?utf-8?B?SjRybmxEdER6Snd4SjVzQ1V5MlNoZUgwZkE3K0k0VFNGTkhTdGdIOG1icUxD?=
 =?utf-8?B?bENLb2IxTWJDZGIxS0sxdFFHRitvMTNMTFl3RkNWbjNid2RGazhHcVIrQnJU?=
 =?utf-8?B?dG9XSUlvVU5NUlFMbTFDeTFpaGFsRFZ5eE50REpnQ1ZOR3JlOTQ4TFBWbjE5?=
 =?utf-8?B?R2ZPSWZtTUJ2QllBODVYWFJWcmlUR3pHelp6cmZaNW9DOXhzSXZCZDAvTVRF?=
 =?utf-8?B?b1FWYmxUYk90TEdJRktyOUNzM1ZSOEN3bFhteWd5RkhEUVhLM1lDTkxYcVls?=
 =?utf-8?B?cExaQkk3VjhIZjJZTTVCbjlyc3hmbXcxN1BOOE96WVNRVEhMMnFXQ0hieEVy?=
 =?utf-8?B?VTZzcW5UbVZyZTVTWXFUUmtJWHpxeDhmQnA1ZE9hZ0p6U3htY2Y5dz09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-GBPDM45pVgC0slEP310k"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ff8786-bad3-4165-4b30-08df1241d746
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 09:23:30.3083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ELcaBfLfUlZAyIwpAioXA9b8VJsK6HcS2BxpIOwKnBUOlVT/fqcpCnLRtTQ5VYMO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6086

--=-GBPDM45pVgC0slEP310k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2026-09-14 at 04:05 +0100, Jonathan Cameron wrote:
> On Tue, 1 Sep 2026 02:22:43 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Mon, 24 Aug 2026 11:55:29 +0800
> > Linmao Li <lilinmao@kylinos.cn> wrote:
> >=20
> > > The recently queued ICM-42607 PM support has two error paths that
> > > can leave
> > > the PM core's state inconsistent with the device.
> > >=20
> > > Patch 1 propagates sensor shutdown failures from runtime
> > > suspend.=C2=A0 Patch 2
> > > ensures that system resume restores runtime PM management on both
> > > of its
> > > error paths, so that a failed resume does not leave runtime PM
> > > disabled for
> > > good.=C2=A0=20
> >=20
> > These look fine to me, but I want input from Chris (and ideally
> > some sanity
> > check testing) before picking them up.=C2=A0 The dead chicken test that
> > they
> > don't active break operation when we don't see errors is probably
> > enough
> > given the analysis seems fine to me for what happens on error.
>=20
> Kanak, given you are looking at this driver perhaps you could take
> a look at this series as well?

Sure, I will have a look at this.

Thanks and Regards,
Kanak Shilledar


--=-GBPDM45pVgC0slEP310k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCaqe88QAKCRDEY9j7t8Ka
ZyhOAP99XonTcCegJ8o9dlrXWEFc86TAIme8rulTDBLtBC6pjwD+LST+RuCgnr3M
okfDgQZ4OXeurHogWIsDfN+6gOLgSQo=
=5gTl
-----END PGP SIGNATURE-----

--=-GBPDM45pVgC0slEP310k--
