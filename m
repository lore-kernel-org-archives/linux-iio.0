Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26A45D5F0;
	Thu, 20 Aug 2026 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234569; cv=fail; b=nyWH2mBg++SpBsMVAGWptEjXtWIBPH9v4LVNW3sTuOX8YvOjUIXkzhg80bhPwaNj0pQf8ppAQvbl7CFiJpLFB64EzkmaTqoXedkpjw8P1/GrAfOhrd9SmVYZExPz4a10Sf9LYSPJT+f8OwHwMMR3lmZx199h3SAqTG7287e0XI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234569; c=relaxed/simple;
	bh=vUk6wQT8evjqgmRMI5XxP3jn2Z6HW/oDF0d8qgpcwck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RTWsBQVeyeZt9sHgOZRV/5rrumYuRjm4teAv2cKnF652DdqC+rGd+M7AiGweuRraztEo5h+7EbvlEMSc9xlHB+t+MyG9bgXE9VOOOeYNQyHDI+j19CN9tMua8GNHdBS0Q6U5Z2iiXEGPISCc/g7PaxptG5lXYtAiuSHexOmh7pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=RJzOrhwY; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="RJzOrhwY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9Tjr9HE8EN4Ebz4qdJixT2coXMnCryEnrCk30y+USdbUiIB63wvkcvbU/j2f07HElzTkBhPLWyJtoxsi/zR1Lghyb+CLJY4bW29XTrQLwCqdQ8gxuT0tMSs9OYUtngTgzSwfWD6MQH9yQJjIaob2cPWgOerk9V7oXc9owNLRmeAGgtfR+yqLRzyf6sad/zsq42ynmkxXbGCgFKyDqdHtGkVwF/71sVa7OM5NeYu9Pxmi3Ur+EvXgocgaxiXRnkayT9nobd9tfGkuvF7h6+2DU0+2ms/qlwYx+1F21JPxI1lNnT3JzbujFVskj6/XSABVlfl8mO7vwQUiOhzy2fX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUk6wQT8evjqgmRMI5XxP3jn2Z6HW/oDF0d8qgpcwck=;
 b=xAKUqsK1z9Wjf9qx02cRISUABw+tx1DAEbUQle/R+USQvHq3uzjmZeR6SllwK2QwcQWzK/URKwRpI/61VmcVUV+17CDeUMH0dUinL1dZ4N+6Ff/yTzo/S0+KMtOcGupnKjJmngWFvksSDvyiDcqlxEoja8OuSUNTy1fj/l9OybwvOYUKBCovvWsLWRSYj0Af6S2a19XbHUXCs0Nq1f5yMynvbe24qKwy2RaGjFV53tVzgO9rhOQ1zCUqkpf6nm8ZjaHqVQvX9AfaNjMSaz0a9JsFAumW2FkAJ9l0rES6wWGfDVGWj8X4scJKTGsNhq3SACw1/uyQ9IX6X22A+ypEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUk6wQT8evjqgmRMI5XxP3jn2Z6HW/oDF0d8qgpcwck=;
 b=RJzOrhwY5vrmhEyHiRRA8fq1pKRWm/yHzYpxQWhkeNZIC3yzLrzuIZfCxDQRHqKE6rERDjFMZ0aEwlxPj68UFrBitUH0XBqTn0BP7OCIqF7iSP98SuPyLXsdDnXybjdaapxrZW2gQ8PrFZRNzlYAhmPcOVmKPkd+FEz4Ybi0Rfg=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by PA4PR02MB8237.eurprd02.prod.outlook.com
 (2603:10a6:102:26e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 14:02:44 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:02:44 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>, Henrik Grimler
	<Henrik.Grimler@axis.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
	"robh@kernel.org" <robh@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"andy@kernel.org" <andy@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Kernel <Kernel@axis.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Add driver for Invensense ICM42370P accelerometer
Thread-Topic: [PATCH v2 0/3] Add driver for Invensense ICM42370P accelerometer
Thread-Index: AQHdKx765lvaKnsrHkSCQy5bP8bVVrah2yGAgAUnu4A=
Date: Thu, 20 Aug 2026 14:02:44 +0000
Message-ID: <5aa3de1f2aa49a965113f24a785f23fc3c1e85c2.camel@axis.com>
References: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
	 <aoK16fva9ps8XNwb@ashevche-desk.local>
In-Reply-To: <aoK16fva9ps8XNwb@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|PA4PR02MB8237:EE_
x-ms-office365-filtering-correlation-id: 82805162-3679-4d1e-dfa4-08defec3b4f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|6049299003|366016|4053099003|38070700021|4013099003|6133799003|3023799007|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 KtRrgPMuLeTtRVNwm9F3e42tkaqBTXXTP3KJbHP5Bf63Ub6n1HaDd8N4Z2azfINVdilaefkdddTvQxpvA8IulEZh5xGkEIF3GmXrP2ed2FyL2nmFqrewlaJxGxCu5rfAUvvCwaRLGHg5hQiIvcB9OKnjIOzNkE7sV2KBpAV1fzqVaxmc3ylFMc9xad4WK5llL53UJWcS6Z1rfylLy4cpiaA0bRqy1O+0g/Yb/H6YBbEDkbKgnpd5xOp3MvnG15LMmIPxuuiq6BjA1DhUCWLLbQ2FTev7MF9+uQkwsXuE08Pw4Ry3EpT/OzV3PnpbuJ0YgwC3s2hFyD4/WJnu/1QABv1a3Khx8cibGoWl5mmLJLKn34aD/ipC7d5SiOqzH2EQRJXa+pCK4MC/Jw0WE76BZNmpl8qCfmv8lEsdRa3d6fFWZb8aDrJ2KRU9NVws8/VbzYpyqm31ghV1sqIa129t6RgyqRaWN5NL2TkTWMyxVLxKWVbq+1dDDf0sLAZU+YYY1BZtVP3/8iQ8jYToeaieIn+q9nseezd0DCHxGRZJg57zBgXKCetWoRg/c6EOtE2nifgIMJ+079BJf0FSIrp1CX2Ym+vnEvK5dln7A8whMnZn0tN/kyxUfXGZWO86QBF4r14KK+djw5j58s/hARkabchnup2ha+8/2DadFKi7HzE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(6049299003)(366016)(4053099003)(38070700021)(4013099003)(6133799003)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TklqTXVOclpzeXFOQXA0ZUZyTCtQVXZTWWs2WjRqQ042T1BGRnBad044VGtF?=
 =?utf-8?B?WlNhRkJPTmM0bnc3Z2IrbnZRVXBUWlkrd1Z4dkVmMEZIK1NYV2gxNnZYMmYy?=
 =?utf-8?B?ZHF0aXdyS25tL2lmSVFnaWxwTmthTWxyWVdrb0prc3lRbzFEcDFrV28wSXJZ?=
 =?utf-8?B?U0ZoWmQwcTQ3enhOWUh5MHpKNGdWcEU5QXM4ZXppekpMUEJGSmpnY2NpTGFY?=
 =?utf-8?B?R2tMdUpGK3RMK1BkclFiWldKM1g4NUl6cmx2TTNxZXN0cStEZjlha252Zm9y?=
 =?utf-8?B?eWtyMFB4T25QK2tlVk5LbFlFNUQ1eGNJSWJHZ2pnbys3dzZNekdoSC8rd3Fy?=
 =?utf-8?B?R0lvWDkzZkNHejJKaDZtczRFS01xOW0ycW9QRnpuOTRkcHpTclBlaXVOZjNn?=
 =?utf-8?B?Vk5WazNCeWU1QkRnRWJ1ZUtld3hRTysxSWlwRHY1U1g4TlB5SHUyOHc0dXk5?=
 =?utf-8?B?NHZtTjNORTJtV2lkWHpCUmRvcWY4YnhzRkVBSHZsUUZWaWw0STNEc1N1NTJ1?=
 =?utf-8?B?NXVOaGJDZmtndmNWZGZWWU1ma1dnWjdmQmhYUFZ3TWdEZmQ2M3VhUzJJUTdQ?=
 =?utf-8?B?RWNmcE1peE5IeFc0WXhvamwySUtUUzBhRjZiMzlBRFlkTzM2ZmR1QkdRR3Jh?=
 =?utf-8?B?SFF4YStaR1YvL3d3RzN5SnlITmhDaXRDblVLVTdJZ3ZQVlRvRGtSVzJILzdJ?=
 =?utf-8?B?dkZGNlVrZHZaZHRhOFhWMDZTazJqWXkyM3FERWlGNjEzWGtwRDN3a2lHVWlH?=
 =?utf-8?B?VEJBZWVvQlFuVUc1RDhqOE1XUVJEMEFRR1hOVitBU3p4Z3RKSm9ockF4ZWdR?=
 =?utf-8?B?S2hhTitvN0VTVGdvZ245T1J3d0l3eGV1MjJVeWk4YUVPYzJjNXFnZDlFK2RW?=
 =?utf-8?B?ck4zRDIzV1hvbDR0NkJkc2MxUjJMMjNQMk9jMFduS00zcEJSYzRaOGIyZElW?=
 =?utf-8?B?ZkxzNTZ6ZDdHT1ZjYk5kSFplRFhVRi9TTXFUWkZ2UW9DKzVudHpDSlA0NVVr?=
 =?utf-8?B?S2h0QnhqSzhnTlhqQ2Y1Y2pid2hDdXlhVUNmbkxzS2dvS2hrYlp5Um5BQ1ZG?=
 =?utf-8?B?MGErT2Ywci96NFRSeHNsVEh6WE1EWUFxSDhJaFE4ZXptQXZrbytBQlRGbzQv?=
 =?utf-8?B?eEpxUUQ4RnJ0NFUxUHNSUGtHVExYUzNJcDBRWlFGSTh2d1ZhVmV6c2EvSG5w?=
 =?utf-8?B?Y0FaMnBpODA3Y3ZRbzRSeFp1ZmhXVzM5aGVreGVpTS9TVUJ2OTRjZm1jUDA3?=
 =?utf-8?B?OHRDWktLd3JjU3hPb0l1a2RSWkVJUWg0bE4yVlYrVXU5ZE52Ty9UTWhTc0Y5?=
 =?utf-8?B?RkFsanRWQUxrQlJHc0x4RHB6SXN4ZnExRnFiNFV3bCtSMXgveGp0aTlZQ3kw?=
 =?utf-8?B?YjQ1bkw1bW5FTmtVSnBmMzlhKzk4YmpTUUxwTTk1REh1UmNKRkM3cWovMFkx?=
 =?utf-8?B?TThuWjVUeG1TWWJVWTdRenhMSHVFVHJVUVhXd2pZdzBTZmJwci8rRTV1QkFj?=
 =?utf-8?B?WUFtK0FIY2JRK0dnWHlBR3IzdW5CeStpRjg5amcwcVJ4R3d6UzZFSDdjdWoz?=
 =?utf-8?B?WFFjMGlQZmJOaVRBRVdlUnBsOHowOHNyWjE5Q3dRZE1FenFKcm5sbi96YjFE?=
 =?utf-8?B?eHZHS1RTRkVhdU85T21zMU5qR2M4MWdpTHRCcXNqY0MxTXZxMk16WFowUVM0?=
 =?utf-8?B?L2VERW9BS0JjS2svK2x5UnR1UEpQbDVNQXB4NVAyMGlVRmp5andDdlFkNDdJ?=
 =?utf-8?B?ajFSTis0cGQzYTlSa2tJbFJYS0NFY2QySSs2VjhNcFlrejlPQmo4bFNDeGhG?=
 =?utf-8?B?a2pjbVJWeWpSekYvaE9YY1NyYXNYN09vOW9rU3lybDd6VzgxYnJwckMzYVVR?=
 =?utf-8?B?ZnpNa0YvMVp0UjA1TTJCSzIvTWJMUXFKU25oSDkzVDF2dWl2VEx5NXV3YTdO?=
 =?utf-8?B?dE9YcTFHUnp4V3V5YUR2Vm9WME5uR0VTbUsrL0k0T3JPZ08xeTZwczYvbjN1?=
 =?utf-8?B?cDY3L0xyL2ZnL0lSOHhscUhuNmxXUXlNdmZpZ3pDK2x5aUdDSEM4ZEpJcjRl?=
 =?utf-8?B?bVliRjZFb0dCdjNmK0Qva1dlTERTdjVyS3pQaXpkTWltTDRnMS9za09JK2V1?=
 =?utf-8?B?czArUUZSK2JYYVVySE5yOFMwL1JvcnFVYzFHZDJrV1pHK1BuTHVWVHR4akRo?=
 =?utf-8?B?UkZIMXhzVkNXQlZuZjJvT0twVGp3b1AzOVE4TjRZV1U2Uy9BbnNQalh3OStJ?=
 =?utf-8?B?MGdwMGZKUktTVGUrcmJ2c05DN2hMVi8xV2Vmanp2RFM4c1p5N3ZMZWZocXRS?=
 =?utf-8?B?Q3lXOVFKVXZSL1FhT29qRTF0NERIbys4UkpTZ01neGpKVGpkdUJ3QT09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-3O/z2fZkKUZM7rUS+41F"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82805162-3679-4d1e-dfa4-08defec3b4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 14:02:44.1170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2swDf/NlZ92k6BRqWPKFR2BCxI92k7TGZKgYfPqyND0ONZVd4qCankqCWBwBkWi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB8237

--=-3O/z2fZkKUZM7rUS+41F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,
Thanks for the comments.

On Mon, 2026-08-17 at 10:19 +0300, Andy Shevchenko wrote:
> [Some people who received this message don't often get email from
> andriy.shevchenko@intel.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification=C2=A0]
>=20
> On Thu, Aug 13, 2026 at 02:26:09PM +0200, Kanak Shilledar wrote:
> > Invensense ICM42370P is a high performance MEMS MotionTracking 3-
> > axis
> > accelerometer. It supports I2C, I3C and SPI protocols. It has a
> > 2.25kB
> >=20
> > The driver is inspired from iio/imu/inv_icm42600.
> >=20
> > Thanks to the reviewers for all the time you spent going through
> > the
> > code and the comments. The changes for v2 are quite a lot and I
> > hope
> > that every important change is documented in the changelog. After
> > implementing the suggested changes, the driver is in a far better
> > state
> > than v1.
>=20
> > [1] https://uat.invensense.com/en-us/products/3-axis/icm-42370-p
>=20
> Can be added as a Datasheet tag here (and be spread by `b4` to all
> patches in
> the series, which I think is fine).

Thanks, for pointing that out. We will use "Datasheet:" in our next
version.
>=20
> Can you split the first patch to be based on the features
> implemented?
> Something like
>=20
> - patch 0: DT binding
> - patch 1: very basic (but working) driver
> - patch 2...n: Features 1...(n-1)

As @jonathan said to squash the two files (buffer.c and core.c into
just core.c), I split out the implementation in various commits. Here
is what I plan to split them into, let me know if you think anything
else should be split into multiple commits.

* patch 0: DT binding
* patch 1: basic working driver
* patch 2: implementing temperature sensor
* patch 3: implementation of accelerometer configuration and power
management
* patch 4: implementing user bank switching (mreg_read/write)
* patch 5: implemtation of timestamp related things
* patch 6: implementing advanced accelerometer parts
* patch 7: parsing of mount-matrix
* patch 8: add basic irq handler and parse devicetree interrupts
* patch 9: adding buffer support

The buffer functionality has a lot of dependent changes and thus
splitting them may cause "unused-functions/symbols" warnings. So, it is
better to have them in a single commit.

> --
> With Best Regards,
> Andy Shevchenko

Thanks and Regards,
Kanak Shilledar

--=-3O/z2fZkKUZM7rUS+41F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRZbIB7R61KYt5yWsuslrbqDH4eIAUCaocI+wAKCRCslrbqDH4e
IHyjAP44c5ZkKcfvTzszf6NkZXpy8ZTta+zjeWFq3rntVRSqzwD9G7YbBcmuKWeO
hLXLjuE5AbHvbR7q3F1JrQFXxSfYDQ4=
=mbx5
-----END PGP SIGNATURE-----

--=-3O/z2fZkKUZM7rUS+41F--
