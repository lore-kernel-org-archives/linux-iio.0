Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CA484228;
	Mon, 28 Sep 2026 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585720; cv=fail; b=ssWqKXfp8n+ASwM0szgAsAq3sT/Ut1wl/ls97QmHiiUe6carvyQ4hA6M57Ll59mC7cwS0LGmW/LfvF4Dx7HRgd1/ti3td2elw27+SupLq8nCfweAjVLme5XQ0utrpZrBj/8NJu3uZL7x+Ws6i5IgFAfzMIc+5zJdLBRiTKRqxNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585720; c=relaxed/simple;
	bh=EpfPZAolpL5eXhwCFzMzcXUziD25HpGLs2vW9TaJ/1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rGdHHX+bJoon6yxVCIKy3YFdNv2lk+7BFkFReaDUvI4QFV1i9ZU63Rh9OlN0NNVTDxGjrwmx9CCgVD2cQMtCCPQE2tgr2iuQlMuarZLsvFWggR14jYFSmKXevgY34A3u2LByASvgqqceAhWqKygBh6RM8tKAGn+3nb0SUDSzCPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=VMjuFjvh; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="VMjuFjvh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOCV0ePoZu+ouglXXdpt1/TPm2Jd8LYnWPcVJC68L39YtOOfWfiNuvaqrzKEBvOnmeEvhG+iBiK+QVInz7wqp6WktdXV3zk0Tu5eq92TTcTzJn2nshqI7Kdi4gyLkxLYTF+Alz+0CZXVQXbkqDDsG9Di9UC0fPYlVMhM+wKDsRDRVoEsAzPByEHHMJsOtvP8GSGl+KMBHU5P2Kma46PvKeRTBcY9YrWjAzK87VUi9O4ai3AIMulV19MEY4gnjNYZ/yMWzaN+Eu8BdCWsESv7IosTrVcgEr3Pegh3JFLHJhw2egObhnMigXNnuaeBi+FMPdidN1l3kfYiK6Lo4U9dJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpfPZAolpL5eXhwCFzMzcXUziD25HpGLs2vW9TaJ/1Y=;
 b=iLjx6/SzaYji5zuTcLTGaIb4/+DDLOKAhb8wMNGXhSoEdougVlyyMv0+3GZF+LGOojvsP2esGtY7J4jlfoJmF0pxRE/FZjftbAExLjPSGGa7dJmyvjNfReQh/6Mrc5qdDpPYMWk5H/8zJZ5dIYnCpT5p4Hl+HZTQLxyZuPP+oYzoNdW5/hbr0YDqgbSjJKXCm+3EDbHxey1/V4hwH0ntzoefvgubC4fcjpR6tGWwlOa681zxKWnqS9b54eooqpgwE7VeXUGGzvksobyTvKAiOAtP8ESE6wjbcsEUwv7Uxk16oGYrntbP3bsMGR0X7v+U2ZINwKWp0n8RaafxCs0y/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpfPZAolpL5eXhwCFzMzcXUziD25HpGLs2vW9TaJ/1Y=;
 b=VMjuFjvhKes/1e1wbnM0t1i2GTWbMSbCzN6X4U3EIrdWRgdKb5e2ugix+Ko8f+LULI+ha9vkLd0Vo731J5vusm7FJDlDUIeDXkxh29r0BhT9FugFJzKwAaN11KFz7yLD0TdKHiHGqbYDhPGZQ2yJgj6U4NonIcw7L1NEvu+21V4=
Received: from GV2PR02MB8434.eurprd02.prod.outlook.com (2603:10a6:150:ab::8)
 by VI1PR02MB6349.eurprd02.prod.outlook.com (2603:10a6:800:198::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 08:55:13 +0000
Received: from GV2PR02MB8434.eurprd02.prod.outlook.com
 ([fe80::a2fa:a7a3:b6ad:9e4d]) by GV2PR02MB8434.eurprd02.prod.outlook.com
 ([fe80::a2fa:a7a3:b6ad:9e4d%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:55:13 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>, Henrik Grimler
	<Henrik.Grimler@axis.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
	"robh@kernel.org" <robh@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"andy@kernel.org" <andy@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "macromorgan@hotmail.com" <macromorgan@hotmail.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel <Kernel@axis.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Thread-Topic: [PATCH v4 1/5] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Thread-Index: AQHdRqnUrxOUwV+GnkCI62/RU5CWVbbXgVuAgAw/bgA=
Date: Mon, 28 Sep 2026 08:55:12 +0000
Message-ID: <3ab2ba81a38d4da84d4e3ebc147aa956728e96bc.camel@axis.com>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
	 <20260917-b4-inv_icm42370p-v4-1-fd9373f123c9@axis.com>
	 <aq_lObgrI7uAi0K1@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aq_lObgrI7uAi0K1@debian-BULLSEYE-live-builder-AMD64>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR02MB8434:EE_|VI1PR02MB6349:EE_
x-ms-office365-filtering-correlation-id: a74ce492-b26d-497a-9103-08df1d3e356d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|6049299003|23010399003|4053099003|38070700021|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 M46bEAtQrmRusoPQpAKEF9juZFznyX9FJsxsCzmU1PglC6cUkMkvMBnqo6eJeoT75Phk8FatLDcs5QZol4azglokBwueJxhpDTwqo1qgtJwrP79s2YgFUPF1yUaJ9KnHnfjfJltO6yB1XYnfT3u+NPcmMkx8GbPFUKbbR+5aKTG6jO0tgYNZVkmrh3lpIxM0Qb7OmbrPf6OjrVCySwhDJJDEMHhtaSNh1v+r8x7ukz6LjnBUA4GWUu9Bu6NQCV6SUftOOX7WKQlUshbQmbJmNMACVMA8YxnyAH75Ir0BaMFcSw7BylCCFNaWbk/OCj7mKFoZDXQxZF9mDsB31nSsHntuwjBeS0dpNIGanCRPF7CA//rls44rQylxbvMniTMXaHlAt+yO6wQ/5x54chqDZqgGOz+38xXhCC1q7NgIntfqTNU4qFuQ6eKxNs+RNPRG0brKDtaqctgKPqjGBS4VKIZnOLHVvuYYMzZkmsECpzsp/qKG9oUOPdbPWk7gh+Tonsg2zxp35n1yzEMIKgbG0MirpU5PqYJflc8dvw2JRuIn5efRPaImr7MsQM1pUu021P5rzTnJL9eKzLjmWrrCXkqfanm+JGYPHr4GRJfNP0xsnUUKqMaZQ8Se+GYjQlatZr7+RU3CWhdRX3goDuiW6zGbb2gP0HLJBsW2TuR6iFTpkTSfkFAfe1Mhbs+KE+fsr+BJwXe44luhEcqdF4wRTUgozIFotnymlgX3Ktx83JE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR02MB8434.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(6049299003)(23010399003)(4053099003)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3FMUHVJVzJrdnkwTEZmckliYW14STQyL2pra0dtV3VrVGRHTVAyTHIyS21i?=
 =?utf-8?B?dTJ1Z3Zsb3h4eUhxOUY3NG9OU25sUmNjUVlObHo1RVF5enk1SGFqR2M1eDN1?=
 =?utf-8?B?dUJsUlBCT3hyb3dyVFNRYW0rblpwSkliM0N4bUdrRDlUOWI2QmhNSUsxUlJT?=
 =?utf-8?B?ZG9wUmhYV0d3ZG9vSEhENmxIcm9ueTV1MTg1dDIvV2NEdUtlcUJaNFU1MnBK?=
 =?utf-8?B?THZBOUJKaGVtTVlIT1BOWkc3bWJrZ09wZGNXaUtPTURlMTZhQjkyQ1ozeXdJ?=
 =?utf-8?B?SE4rYXpSNFhqVGhyQ3YxNHBKRVU0OTFoVGtSd21EOExhdUw4R0pYZkttUnA5?=
 =?utf-8?B?OEJsUmdUaUNWVEcwdGt0TmVjODNaZloxbTRQL01YRi9HdmNUc0x0QS9UZFc0?=
 =?utf-8?B?ZHlyNGhJcEJHZmlueUdwT25HOXFZTTlsR0Y1Sjg1NEovR1JheXpFZUJUTWQv?=
 =?utf-8?B?RFFpMCtwaVZObEIrVzJQcDcvU1N3R2FNZzBtR3BvK3dtWm8rdVdMNXJlQ3Rv?=
 =?utf-8?B?YkNmeS9taVJmN3kyTTZEQjY1R3JRZy9XU2JnUVpzKzcvN04wbjlBV3NJcmJC?=
 =?utf-8?B?Tko3NFFBQlZQcGtDdlVDR2crVWo0WUYyS25aa2YzbGpia3pnRk10ZkZpZUth?=
 =?utf-8?B?eTZ1N2tOc3RIc1VGTGQ5dGdlVkdjdXF0a2lmMCtHRkZqQU5jNUkxa05MNjJX?=
 =?utf-8?B?ZzBSWVZxSUlDb2QzcTVGTXh1YTVleUZlcW1YOGxuL2NvdlVkcFAvZHRCbmk1?=
 =?utf-8?B?SUdOM1NNL1loYk8vckRCWEJnaExYb1RSZytySmlEcG1uMTBTTExKUU1HcitP?=
 =?utf-8?B?ZUFzWVFvYTE5dk1ualNEU1AyVmhITzcveXRNWFVsL3JHdzN4dXZhT3pjS3ZR?=
 =?utf-8?B?V1diYWxVYWxnYW1iSlZNQzNGMXFaVFBsSzhFWGtSdEkzWUZ6Q3dyK2V4YS9L?=
 =?utf-8?B?MDZnVWwxalRPL3FyTUlsNjI3ODVVdVhVZnFORnhiM0xlNS9xcmoyWVpBNmRm?=
 =?utf-8?B?RE9sbTFDZjlTWDRKN2xFL1JtTlVuY2FpMjlIK1dvMDN4SWpjQ3JxSUVtb1ZG?=
 =?utf-8?B?OFZXRHlBSEdYaFpiekJ4NnRLT1hLeTB2WkNSVWJqRGlnSEVOcndVTUZsOUgw?=
 =?utf-8?B?aTRpQTFFOUt3a0NJYXREQi81ZUZDTG9DSnA4Vkt4YmRONXFHVWVqS0FyOWtB?=
 =?utf-8?B?MkhSMXFkTG5xZjNvWjZ3NVFkNlFWalQzYjRXUWR5ZTNvUzhRbVpKY1lsV2Js?=
 =?utf-8?B?ZHZQL1RuTkMzRlBVZVgxTnZmbWhxUkdVOGFoN0FYN1N0UXJ4ZWxiYzVza0w2?=
 =?utf-8?B?ZVVDeHhFNlF1ak5aWjRCN0VYTktLRzRpejlNeUhGdW1nV281UDFSemMwQ0x1?=
 =?utf-8?B?M2E4V2xqWHFTTUVvYUs0NUZwK09yL1RNcHlBMXlDYksvRFExVUM1WkdoRVJ4?=
 =?utf-8?B?T1h1WHN4cWJqMUhXWDI1bXFFYzZCTy9mRERsdUdDQUF2SDVSTklMdzZHVUt2?=
 =?utf-8?B?MFhUS011UE9sTStFTHJxN0xuQ3ZncGVlS0RoOXpSdnNsZmVIaENvdWdCQ3NH?=
 =?utf-8?B?eW5IbjV3YzhKeEg0ZG1UU2djTVR0VDJlUFJ4K1J6WFdCYVZmT3dmS2YvNmpa?=
 =?utf-8?B?TE45Y1lqK3N4T3ZOTmovZVFSaURjVHg3QnNVcWp1dDQ3d0RDL29XRzVPcjFt?=
 =?utf-8?B?cWhBOWp1NzFUcGQzSDEvNktWbDF3Ry9MU0pmNElETXBEZ3VHYkMxQWdzakdu?=
 =?utf-8?B?dnQ0Y2Z4em9kTllEdk1WNGs0OWhyWWpPZktOV3dPRThWSFg3QVljRUIxYnJm?=
 =?utf-8?B?bE8xMEI1STlkc2ZJSnM4cWxtdHVpOWtPeEdjR1k3bStWUmJwZ3ROZHpWZkxS?=
 =?utf-8?B?WlpVS1F0cGJCNlRYdzZOWjVGeDNaY0hBNEx3ZkNKZ2h3bDBFVVRWSDFZTWt2?=
 =?utf-8?B?dkdBWmo3ektsalBQWGJYM1l2enlqRTZSNDFkZ3ExRnhSNmVLemc2eFlUY2hG?=
 =?utf-8?B?SkxMM3RSNE5OUHYrOVRJS294QUE1KzFUKzFZSkdSR0d2U0JEWmFpNkhYNVRZ?=
 =?utf-8?B?cjlZQ29JV2lhQXBqeFgyMi8rdkQrUzd1VmpJTStCcmdMWmVHajB2TWQvTnUw?=
 =?utf-8?B?RzlFdGdSR0Zoc1hBSEZ0OTlOeG1weWl0L3pINHF3M1BNMEFwV3NPU29GOWNB?=
 =?utf-8?B?U055Yzg0bDdIdndITm96a1JlaVNESHd5N1hJQmpjdzRPSWsvRnhZeVBobXVR?=
 =?utf-8?B?Y25Gd0gxVVZHT1BybjZnWXhDbFU1ckRmdXVLVW8zbjBMTFYxaStsNjF1c09S?=
 =?utf-8?B?ZkFBVzBodnZrUTNJSnFMSittVHhKK0pKWXliVFd6TXRVOTdiK1o2QT09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-jJt87xtu365NV58mqTCt"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR02MB8434.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74ce492-b26d-497a-9103-08df1d3e356d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 08:55:13.1256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YxLEAtvwYYfTmrW88YxtHcEqB8li3z8kp5vZWy/wjYF+/IYee9nYIXPFCGa1r9v3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6349

--=-jJt87xtu365NV58mqTCt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

On Sun, 2026-09-20 at 10:52 -0300, Marcelo Schmitt wrote:
> Hello Kanak,
>=20
> On 09/17, Kanak Shilledar wrote:
> > ICM42370P is a 3-axis accelerometer. The device can support I2C,
> > SPI
> > and I3C. Add the supporting devicetree documentation for the
> > device.
> > The device supports VDD and VDDIO operating range of 1.71V to 3.6V.
> >=20
> Patch 3 says ICM-42370-P is almost identical to the existing
> Invensense ICM-42607-P.
> Instead of creating a new doc, could we have similar properties for
> ICM-42370-P
> by extending
> Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml?
> The updates on the other patches keep supporting both ICM-42370-P and
> ICM-42370-P with the same device driver.

ICM-42370-P is very similar to ICM-42607-P but it's an accelerometer as
it does not have gyro. As dt-bindings should describe the hardware I
think it should be inside the iio/accel/ directory although it is using
the same driver of IMU. If you think it should be in the same file, I
will move it and update the binding description.

Thanks and Regards,
Kanak Shilledar


--=-jJt87xtu365NV58mqTCt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCaroragAKCRDEY9j7t8Ka
Z/XfAQCUszRM2vDSx8Vp34qXAKxRJAsP00xFl7FEF01e6tL1bwD/X//G1i32si28
rUIdrPlm9glPfVLsgfexKUru4BgnDgw=
=dlA6
-----END PGP SIGNATURE-----

--=-jJt87xtu365NV58mqTCt--
