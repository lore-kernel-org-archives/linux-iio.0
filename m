Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011042.outbound.protection.outlook.com [52.101.70.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00A49E5E5;
	Wed, 16 Sep 2026 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550913; cv=fail; b=pH1ChcprvwfYpSBNqAPy7luTUzm1RueYWff4by1Frf/S6P4y/YnxFx4i8O6p+aOupY6HEaB2kvLxcm5bbzNq5UnBWuKN5o6iYshXY0I3U3Q6hmid+DwFuXg82uExdUVqzMtLDMk8WqLoW9U/DIND+gy++VmlheRq+Uw4kNikL+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550913; c=relaxed/simple;
	bh=FEfAbHkncoEduSHjVbXLqeUEj4SQb6MGTxloQTcQCEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8f+X3qfm7cwBQRCy9qk/0AqtehPDp1zdpqjqPKWO+WROJdEQ52f9fPCU+voev4uF5tWRXl7ETK7am6zpDO/p6WZsXiowft9rTSFYHa76vI1/TOisPrFEA6EBRSqx6S0DBVqF8+GQNY70wr3VMWOw2Qe6lyjjFGtOF+3ZtUtFy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Lvr0Rv0s; arc=fail smtp.client-ip=52.101.70.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Lvr0Rv0s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct4+PrgoqV9/pFEmkU5Fy+Hsvmnzj3Eh3J+ucuqhUKo1MmlzQLr51MUltlk2Qb9onuvEGBrayozxyHg2PBQ7oXje68LTjCxqia64ixxLlaS4bMIx1+hm45j+ufBAFS/h951EzEjYvHefXeQP0Rt4YeFh/046zK4/A172DzYbiFRrK2J2CQ/lCFgqrkGJ0AAfKYI9c9WSJ7tWyMh7UNne2QBpul9IKp/IYUXOt3oEY1+/y68JIxox2+bCB8wy/4g5oxeMpwcaOuyBwGlOxeFJvcRkLRjfePRk3EFW598h8x1vpkAEwvqqIJkmCP21ynDP5SDdezuPfU2Yt5SeX8nBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8/H2bkZRD5MAzDCR5mbT87ZR84jXLJoDjpc1xWU+wI=;
 b=bX0O30ufQx8angpmlp4DQTc9rNnGWaNA89nbrt9emotuoSt5uaZfxzghbwZOjvGQkW9kPSLi7hFyiOZ6srK5ZW8s0q3OY5t8LSiWovwz9cyTOYJsEsjkNvgMW8hgs/pI+mEoZXd+4widz7/EgC5tDLD24Oft7MG41H3ZssVzc+L0i1D9rorHfMl9ar2jfaNDqCF9fFCOK5umHd29023HofsGTNes/Hjl9GMZNY5bO5F5FEGDhGUzYe+km/XnnDQ21EhAMfjxv28NHYTINQa03dhBgiD55Rbq8L8owUqRIgm+OXn5f1qNyTkC9npTCem1B5gY+lhB/9n+QB3PhzxXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8/H2bkZRD5MAzDCR5mbT87ZR84jXLJoDjpc1xWU+wI=;
 b=Lvr0Rv0sg4oTaLb48s09PhFS/ZbGSMMCwillvV3CNx4GoO7z8VGutktntPwGUrcQ70FG8Vw3FccTJJ3zXtuIW/VRsXG2noqrZ2FZPbig7HO53R7W+cjVMbqltFUrvOUmvKVan7vN03/kWH3BxeISA+UhWIVslOLw0Us8Rnn9J18=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by AM9PR02MB7011.eurprd02.prod.outlook.com
 (2603:10a6:20b:267::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 09:28:19 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%5]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 09:28:19 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>, Henrik Grimler
	<Henrik.Grimler@axis.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
	"robh@kernel.org" <robh@kernel.org>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "andy@kernel.org" <andy@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Kernel <Kernel@axis.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 5/8] iio: imu: inv_icm42607: Add support for
 ICM-42370-P
Thread-Topic: [PATCH v3 5/8] iio: imu: inv_icm42607: Add support for
 ICM-42370-P
Thread-Index: AQHdOh9BPh9OL1eREEOLL+sfXGnts7bCY36AgA6jqwA=
Date: Wed, 16 Sep 2026 09:28:19 +0000
Message-ID: <d5502abac64a6a6f177e251e8ec514bc346e1a08.camel@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
	 <20260901-b4-inv_icm42370p-v3-5-77cc31642115@axis.com>
	 <178874609182.3402141.7546313507051426644.b4-review@b4>
In-Reply-To: <178874609182.3402141.7546313507051426644.b4-review@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|AM9PR02MB7011:EE_
x-ms-office365-filtering-correlation-id: f472d188-b481-4bb9-5962-08df13d4d871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|6049299003|366016|22082099003|18002099003|3613699012|38070700021|4053099003|4143699003|10067099003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info:
 laHbge7+gmIv3Ew2Xlew6ByMHIEtkTmp/ZLW1bJAtR/75ElQCsl1jpKNCY5BaJ05Gp3s/D8gI4OYaqLh/j5QRISRbZJQ6B+BRdDBZYuFyOvlMhu5EW6EL4NrFKOdZLIZCZ6KF07sNNCdVLiWnkaGI4H92yJ17eEc35+DwblQcfjwE9Zbo4xSV4Lk408yN16zf0FwIyY+Obwopyx4YjtpFzSfbICl+qHsL71wKWXHp+KcJdQ6t5dHGAuZ3aTeJLYy4V9w4ME4UTF4Sy0VYPYYjONfU2LeiFoNGp/ufWmD8f0ptcoaUR+MrVkHj3g/aNkaDNbPJcMu9THDZCTs3sm5/03BkLqCIeLuEbblsEg5JfIFq16kuHkZ3BCuwGR5Eq78ojZyQe+goIGQ5+2vs6/7B22mNPIVA5Yq2s3CHuaEANEBgMTdVGT+IGa+7Y2vRsO0ZLYOLLDvv/kEandkkLxJ7+/tX6BuKchgrJKVjPWvb4bdqElNh6VKTFSLJ0lf052CHi8SEUv/ssJlIA87g0GgiFzRzv2TF//Gdp6ImtXhmtsMzXv66jTOPTSbjjAVH8yrO1S/Gf+HFbcpx33wcU5HGOuxmC5UvTBNCijZsLHPtgBmFzVfCzGPhGKh9w7GglI5WkKjajZgdz1Ijkw2zBqhazoEu3IgbctaFZTLA66hI/pRx3DAkZH8f5w2+KVrA7WC9KaTiXPDgjsee+tSFtcEkQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(6049299003)(366016)(22082099003)(18002099003)(3613699012)(38070700021)(4053099003)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDMxZEFvRkVDOVNFb1ZjcTZicWtpNDcvTHVIM2Z5dCtsRUNPTWdyMm9FTDRR?=
 =?utf-8?B?V1F0WWUrN05tRGJLZFordEVVOVBnQldDUm5TeitCbjhBOGVWNHUrdW5HNUFC?=
 =?utf-8?B?R24vcUVRcDR1UjU2NUNOeVVWVi90d2RTU2tZVnByWWNhMlJIWGIwZ3VFVjVI?=
 =?utf-8?B?WHlIeVRJdW5UVEJZVVNodGdML1lGc21BUUNRcEFxY0RMejJXOHhuOFNSTnAy?=
 =?utf-8?B?VHZ3Q2xoTllYcVpFSmx2eFJmR1paZmJsUnhCRXNGY2kzb095aXhwSFFReUhz?=
 =?utf-8?B?M2tZRDVMRDZQZGdEdERrRGN0VnJ1dERWeUdtaFNIVnUvTHlLT3ovZVNjd2VM?=
 =?utf-8?B?MUJNUmRTV1d3SkUwT0dyOWYvZm1UZ1h5RWNHOEE1dmM5MTduUS9iQUk1bkJh?=
 =?utf-8?B?ZTZtZXh6UEN0SzVIYTB1Rlk1ZC9mNEIyR2Rhb1FVa3N1aWVjSDdyVkNIeGMv?=
 =?utf-8?B?NXRtRDQyU256Si8zS09FSmxVZDJXREtIeTdLODh3alZLOFdFaFZxeUpBTCs4?=
 =?utf-8?B?c29lT2RVZklqdXMwTFR0ZFR2NDI4a1BEa2RzMUl5YndtZzJvZzN2c2s1R2RM?=
 =?utf-8?B?bTNzSVg1N3ZQb2pVUC9FbStqRCtPS2MySEhlbGJzN2hlOG5uMnEydnVYbEdY?=
 =?utf-8?B?bE1SbXJ0dno1T1A0dXVURzA0c3YrYmVsNEk5M3IrcXE1Z2RxVE9VbEJHM0lO?=
 =?utf-8?B?M0lIZ0NBdWpQY2pxNElpQWxTVGpiZXlicVBKTnhTak1lM0VzQ1VDUS8wdEV2?=
 =?utf-8?B?L1IxZG4rT3NqTXp6NDU2U29xRGdPN3NzbGZRSU9HWGIzc2EwMG5XYUxzTGtz?=
 =?utf-8?B?dUhjZ0xLbjUyN3luRndYOGpPMDZwVFpXbHRTNG52S0RDelMzMVMzV3IreGNh?=
 =?utf-8?B?SmdKSHpwQWw2NFBKSlNNWEluNER3c2lDU0Z1alNadmpLTEJjSm5ITTdpeEZ0?=
 =?utf-8?B?Y0FlZjg4eW02Um1ZTDBLbkdnK0R1enFZWFEwcG8vVkVFSWppZ2lnNlJ5MEZh?=
 =?utf-8?B?ck44bXhYK05zajNjeTVpYlJCTEFzWEpSaGJ4QnVTekd0TitoK2ZwaG56eWNw?=
 =?utf-8?B?dW9xVnVFY3pOaWJ3KzcycHo1Zlp6eHM0bGNXbkpkM1lObS9UQWZXMXk4SzNC?=
 =?utf-8?B?ZXB4NGtRSkJDa2xQWEFuNExhM3Flb3pNYXVZS3NOZFRNS0dOVXZqOHV5Qk9J?=
 =?utf-8?B?NlZEcmVYeHJlMFBvYVJFOWtzdlB2MlFPQmt6NnlKYnpHdWRoNkpQbFcwZ0pL?=
 =?utf-8?B?bG5pNEgvZmpWVXpzTmtyQisxR0UxMWJmRGJSVWVOd1lXUjFLYmVNOGIycDAr?=
 =?utf-8?B?ekdvV2RkU01jWXlLd0ZTclFZMzFBZ1RaK1NiWjhRb25rNVFjNHY5OUVpTjV2?=
 =?utf-8?B?MjB0SFFQcUkyUHliNjZYYjk5SEZ0K1RpNjhIWHVlY1FCMHNSMnB6OG5RTm96?=
 =?utf-8?B?SkViajk0ZDJ0UWdycENUeGlXSUtFRUR2c2JFVndYWjU3TXZDU3d2eTRPcnlC?=
 =?utf-8?B?b3Vqd01RRE0wck54Tm1UcExrb0lBb3BEdnRoMGk0d1N3VUxSVGZIWnNGcTRP?=
 =?utf-8?B?OThLQWlTUk1FL1diNjQyM3g1THZzeWh5TGlKemhBZGxDSHBiRUlLVUlDbDBQ?=
 =?utf-8?B?OHVZMm5XQ3V1YUx2WS9ZNkNyVHlkMmsrWHRaT0hjaW1QT3VpbDNEc1VXZzlS?=
 =?utf-8?B?OWNBc0JURWcwa1RTOStvWHdtTElxN2psTWEwczdnRzBJY0lRaVFlY2RIamJM?=
 =?utf-8?B?OXlQY1hLYkhidU9aTldqR2E5ZmxWOUNxZ3BiL2NMOE0zNDJKeTFCVUZtamJj?=
 =?utf-8?B?K0tVVkdQZXdKaEo4NCs4WDJ4Y2g3NkptVW1pdjNqdDhVUmV5ekdnMTFZYmRt?=
 =?utf-8?B?bjlmMS9mcFJTRkRld05mVk1tSmhEOStJeWdVQ0ZkQnN4WTRMTnlXd2VwYUxn?=
 =?utf-8?B?a1VJZUs5d045bmozN3R3dmZnWmlnT3grUm5pMm1qUU5NSjhWZU1jZ2lQNzVT?=
 =?utf-8?B?Q1Qxam9NUGJ1aGk3d1dsV0dRV0F5bExTNjVIWW9wVU9sdjhWSjFRRVltVTBJ?=
 =?utf-8?B?ekFJamtVV2FGTXBpdFVoV1U2eEhPdEFRVjJKZHkybmljZWpHMnljZEkwYTZL?=
 =?utf-8?B?M1dsWkxyMFp4Rm5LWGJhT0kwWE45am1LVHpKRmFUWmxBQTZYVUpPckNKNGVo?=
 =?utf-8?B?TUlpN1NJdEJ3Z2pzTzM5STB1ZlpFcGJvU2g2c2JtWmJmc2tGcmhwMGRDekx1?=
 =?utf-8?B?WlRZWFFxczkrOTNrNlBpckRNODRvK2FpVG9tYlgxTmlaTytPODN6bVZBQldH?=
 =?utf-8?B?b0NMQVZWTUJmM3ZmSTQrdkdPZjVjUUtxZkR5bDhrM3VmSi9hTmY2Zz09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-YJrI7CYgOGAy1rh2io17"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f472d188-b481-4bb9-5962-08df13d4d871
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:28:19.4783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wk5hXw2LrnJsSs0qRRLv6inHAV7KYJ1iO7I1S9TeQ0GTjkNtpjpzKXAKBzyVRrPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7011

--=-YJrI7CYgOGAy1rh2io17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Mon, 2026-09-07 at 02:54 +0100, Jonathan Cameron wrote:
> > Add support for the Invensense ICM-42370-P MEMS MotionTracking 3-
> > axis
> > accelerometer with built-in temperature sensor. This device is
> > almost
> > identical to the existing Invensense ICM-42607-P IMU, but lacks
> > gyroscope. The device supports I2C, SPI and I3C, implement only I2C
> > support. Provide basic support for raw sensor reads via sysfs.
> > There is
> > also a built-in temperature sensor but it can not be turned off.
> >=20
> > Datasheet:
> > https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> > Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> > Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> >=20
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > index fa85cf738cc0..a183a8566617 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > @@ -368,6 +368,7 @@ struct inv_icm42607_sensor_state {
> > =C2=A0#define
> > INV_ICM42607_REG_WHOAMI				0x75
> > =C2=A0#define INV_ICM42607P_WHOAMI				0x60
> > =C2=A0#define INV_ICM42607_WHOAMI				0x67
> > +#define INV_ICM42370P_WHOAMI				0x0D
>=20
> I'd put this in alpha numeric order.=C2=A0 Either that or by WHOAMI value=
.
> Neither is true currently.

Will fix it

>=20
> > =C2=A0
> > =C2=A0/*
> > =C2=A0 * Timings as listed in section 3 of datasheet, all values listed
> > in datasheet
> > @@ -392,6 +393,7 @@ typedef int (*inv_icm42607_bus_setup)(struct
> > inv_icm42607_state *);
> > =C2=A0extern const struct regmap_config inv_icm42607_regmap_config;
> > =C2=A0extern const struct inv_icm42607_hw inv_icm42607_hw_data;
> > =C2=A0extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
> > +extern const struct inv_icm42607_hw inv_icm42370p_hw_data;
> > =C2=A0extern const struct dev_pm_ops inv_icm42607_pm_ops;
> > =C2=A0
> > =C2=A0const struct iio_mount_matrix *
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > index 7eb486ff673b..e77d72e0f7bc 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > @@ -92,6 +92,17 @@ static const struct inv_icm42607_conf
> > inv_icm42607_default_conf =3D {
> > =C2=A0	},
> > =C2=A0};
> > =C2=A0
> > +/* Chip initial default configuration */
> > +static const struct inv_icm42607_conf inv_icm42370_default_conf =3D
> > {
> > +	.gyro =3D { },
>=20
> Don't specificy it.=C2=A0 C will fill it in anyway with 0s.

Will fix it


> > +	.accel =3D {
> > +		.mode =3D INV_ICM42607_SENSOR_MODE_OFF,
> > +		.fs =3D INV_ICM42607_ACCEL_FS_4G,
> > +		.odr =3D INV_ICM42607_ODR_100HZ,
> > +		.filter =3D INV_ICM42607_FILTER_BW_25HZ,
> > +	},
> > +};
> > +
> > =C2=A0const struct inv_icm42607_hw inv_icm42607_hw_data =3D {
> > =C2=A0	.whoami =3D INV_ICM42607_WHOAMI,
> > =C2=A0	.name =3D "icm42607",
>=20
>=20
> > @@ -617,16 +635,38 @@ int inv_icm42607_core_probe(struct regmap
> > *regmap,
> > =C2=A0	pm_runtime_set_autosuspend_delay(dev,
> > INV_ICM42607_SUSPEND_DELAY_MS);
> > =C2=A0	pm_runtime_use_autosuspend(dev);
> > =C2=A0
> > -	/* Initialize IIO device for Accel */
> > -	st->indio_accel =3D inv_icm42607_accel_init(st);
> > -	if (IS_ERR(st->indio_accel))
> > -		return PTR_ERR(st->indio_accel);
> > +	switch (st->hw->whoami) {
> > +	case INV_ICM42607_WHOAMI:
> > +	case INV_ICM42607P_WHOAMI:
>=20
> It is almost never good design to match against whoami values.
> Doing so scales really badly as a driver ends up supporting more and
> more devices.
>=20
> Instead encode what they mean in additional properties in the chip
> info structure.

Will modify to sue the chip info struct.

>=20
> > +		/*
> > +		 * Invensense, ICM42607 and ICM42607P both have
> > accelerometer
> > +		 * and gyroscope functionality.
> > +		 */
> > +		st->indio_accel =3D inv_icm42607_accel_init(st);
> > +		if (IS_ERR(st->indio_accel))
> > +			return PTR_ERR(st->indio_accel);
>=20
> This first bit is in btoh paths, so drop it out of this switch.
>=20
> > +
> > +		st->indio_gyro =3D inv_icm42607_gyro_init(st);
>=20
> Add a has_gyro flag or something like that to chip_info.
>=20
> > +		if (IS_ERR(st->indio_gyro))
> > +			return PTR_ERR(st->indio_gyro);
> > +
> > +		break;
> > +	case INV_ICM42370P_WHOAMI:
> > +		/*
> > +		 * Invensense, ICM42370P has only accelerometer
> > functionality.
> > +		 * Thus, set the gryo property to NULL.
> > +		 */
> > +		st->indio_accel =3D inv_icm42607_accel_init(st);
> > +		if (IS_ERR(st->indio_accel))
> > +			return PTR_ERR(st->indio_accel);
> > =C2=A0
> > -	/* Initialize IIO device for Gyro */
> > -	st->indio_gyro =3D inv_icm42607_gyro_init(st);
> > -	if (IS_ERR(st->indio_gyro))
> > -		return PTR_ERR(st->indio_gyro);
> > +		st->indio_gyro =3D NULL;
>=20
> st should be zeroed anyway so shouldn't be any reason to do this.

Will fix this.

>=20
> > =C2=A0
> > +		break;
> > +	default:
> > +		/* No WHOAMI value matched */
> > +		return dev_err_probe(dev, -ENODEV, "Failed to find
> > a matching WHO_AM_I value\n");
> > +	}
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");

Thanks and Regards,
Kanak Shilledar

--=-YJrI7CYgOGAy1rh2io17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCaqphMAAKCRDEY9j7t8Ka
Z2DaAP0VBHL2O9e7kNDgTHNA9MFnEsI/CBq4lKPJSTNiDiqZhAD/TQhyi5TRkhU3
cdXgsNauEaMiba9JZird1q+1++vk/wA=
=zkQx
-----END PGP SIGNATURE-----

--=-YJrI7CYgOGAy1rh2io17--
