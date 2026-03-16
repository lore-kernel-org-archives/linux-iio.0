Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022074.outbound.protection.outlook.com [52.101.126.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27CE30F92E;
	Mon, 16 Mar 2026 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773628910; cv=fail; b=lygkARJopwH4JxDJNlrpjbmIlmziHtudOt2P+GdPmvNISciFDMDXVtB5cjjo8DFbwZAH3V3X8N3F6RRxxudU75KdNFv8NyTsVm+xfbqviKXCATR1wGuPczsJYQlTJh7sf/s6W+xzdSdC8sha8FpM5Q2SE7cwafpWgXFx9k6cdR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773628910; c=relaxed/simple;
	bh=CmcxhEsznv4nJh4LYjZwYFd3a+0p1DtkhRQFxMNkkOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FlhQCZdYlnzYHp/SGVXbs3bg6t54xnKuE3zOYxi/+SJ6u2TJ5A4jHesrebDGBu5cHDSNDeC1ZKhP7SBW/G5+ZBt/lcHWhCW5iyRwruYBtEXdtzSaghBmT8XiDw6oF0Xs2j0f6ejJEEEttrXMdoEwY/rqnFPaYStLBFb8c790cBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=h7tjiWim; arc=fail smtp.client-ip=52.101.126.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="h7tjiWim"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgr5fJ+ewAfo36oNID9MdmmTYUkAwsNaQflsWdcF6l7Ykw6AQ0uDApt3mSJyJTUgUevLKpsrw0g1n7nhNRlkmD2QJ2z3+7YwHwXE0Ok/5GaYNZgU9Fn8PhCYjWSqRiblL6QSriZrUW+3WeyWrvhIiOLz2LqVewcHNvqFKIPL9jIVGtqPOKTxE18B1Lyd2VCV3nnmFnCO86ZGTszLnRqSdRVnqxJ2I4KOyXXSLS8NYaStIW/MnWlM8McGgkE5Poo6glzg7B+J7x1VpdL4i1p+hCmiqDAmVd3ZrDdxAfcZoci33evWJhUV+8sN2pXm1fnV3mHMPhLwJJ33v5o5faJZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5pxCeEhS098Z/O8u1iwvzT/wsKlQK7AfhevfsZvOMs=;
 b=AAqR9cFbNbdPbk4R5IZaAqV8yvUUM8UX6wGrRJztmzpMbZwCotsV2a2pdiAzDiLA1PINmTwFcUj7xjiT55MYw3kwJAUpIQUpwesDZdD3jQy/e6UvBeBt/jVLiWMuNwTV5jyoUxfsKJN0M1c5q/7xwJVB7f9gwV+NpjKYDGMOUF4MRL3T6U5aaNUx/2HsOkXURlZF/hy9U0axGOmISpn7a2FGLr4lNfTrWulnwbcYOfqhvzzwuCiNktJ+DIK8oBmypCmbG+RXZXb1LpV7aTeQtosWJyz0qtgnyFtfDT5sS9tBkbYZyfALwo0/diC6l4d5OVrz2YGcvl10lUrBI7QQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5pxCeEhS098Z/O8u1iwvzT/wsKlQK7AfhevfsZvOMs=;
 b=h7tjiWimwwOWruz4fasvyOuu2ZtAbpGzOE3HKYan7QiWihLnfrDJgZDcrxg5kGoZzEaTd5jvMVp2PjWC0whiUz69IJ+FJXe7bNJETC7nkSrrvpLsGDF/0T+vXd/TinJXxQhV/05EBHbLpNAE2nX50PURJ4w5AMbQEylUXDvVA/xVcXRyF+PU+YLqmvokI0sUEatBtpXg5WnsVda303ndYEl9IAApjpr3isn4Nm0MOGMWCntiArXvz1Zgga8Mtlrq1c4aK+HwiaTgqvobVVaNlFs7BYvtwj7xOD/VzPju5gKfR9+25o/kIXhw1bYjlGpNOs5IwCZPCFyazDB99zVK9w==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by TY2PPFAC281535F.apcprd06.prod.outlook.com (2603:1096:408::7a2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Mon, 16 Mar
 2026 02:41:43 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%4]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 02:41:42 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Morris Mao <morris_mao@aspeedtech.com>
Subject: Re: [PATCH] iio: adc: aspeed: Reserve battery sensing channel for
 on-demand use
Thread-Topic: [PATCH] iio: adc: aspeed: Reserve battery sensing channel for
 on-demand use
Thread-Index: AQHcstB/suvbgA5O906ENjKMGzWXRrWsPRUAgAQ5sLE=
Date: Mon, 16 Mar 2026 02:41:42 +0000
Message-ID:
 <OSQPR06MB7252DEEE7710BFA347A7E1E78B40A@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20260313-adc-v1-1-7a2edb4e5664@aspeedtech.com>
 <abPiJEOL40C5eR1k@ashevche-desk.local>
In-Reply-To: <abPiJEOL40C5eR1k@ashevche-desk.local>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|TY2PPFAC281535F:EE_
x-ms-office365-filtering-correlation-id: 3d23907f-f01a-4d5e-4333-08de83058ec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 240fjdhrEZgymeJ4HkfErcb5+IV0Kcx3pr4WY+d0vUF8kXmnjG4KD1WYsUS+HAyb3wvIWinDXmTVV2ZCWz1bcTLuB4MtyJvcFglus7nUwOqGLOzktHZGtoDUcF0UzsG1bMSBEzqeOEgAmrLIa70bPa4XtFbECL3J9cB7+kMgPSmSWeWLw84yKipOprRJzxb5pxFSHjjq9GuUtyCiuS6jLrWYxtOL2fYo93cRDbSHgbC9aNUWc/VKoT52vrdYQC4VRduXKTVrUga0GuDIyTIadpTvfXlpY/rRMeD6NXr1vcCvOcwgNULHikuZS7m+GLRLAx/lxq3WUfwTeojec161hsxfLiV4fFK/giftQY+YMO82l++CQ3eHSQLHEs6zuOkd+GujpcwrV40PEWbfYDnYhxmzrUTetDsn8tLAwRKQRgjjYpJhLqGnPrL+4YLEwa5FukglS+vX/ffDZX3ZPDeArwJ39FNLOMZ2hzexRjCsN9AlYt9Iklmq03NUbPI82+jZoviAlQAb5aqCIF44sLGFSnbG5bUA/KuJ5vrKE/PZANcTTrqCdwFYTHQ5nrF74b9OY1YSnJ4sAxiRBacAZeqko1wQeRG2vL05GNX2MlOOveOkzUA2ZlsWvKg3dSjHcfoPN18UGUv+jNMVqAsxZJ9Y4vcCJuK5u2oTZdqyGF7SdhS+BMWPZnWP2ZasrufMPBKLJc22BBddYuyxpktAIie+hpMQ4EbFxDExzBsWkm0mBPIoaKujYBtNGHa94TuiL2y1jjbLfgnC3Ds+UAOr4cz3ZJn1Fp0r189i/drZD/uCXUg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Hn8zHRs8wjGLq3tTG3kHwdCap0wekl3ZJD8JicP5nsJbJJlGhhunY70OmO?=
 =?iso-8859-1?Q?YKn7DQ25IvhFjhshuw7ObjkrYzhmJdrFXKDvFfnD6+v1n7Wh/Kq7WRLq+f?=
 =?iso-8859-1?Q?oN8qrDtUIoAdK9NGAxmNp5i7dz+LRX4QZ24wuiZznqUF/8i2EmiPOtKDUy?=
 =?iso-8859-1?Q?ADsum6RRli/ic/N05YYeOs061AYgi3Jwxlj9EeDhk3dU5RFfvPk2NhtQ5R?=
 =?iso-8859-1?Q?NrbyNY+mV8qrUXs9yfqdfNFqcLwU3gy27BQKnTHtz9ptJL2X7PxRN3xHJn?=
 =?iso-8859-1?Q?HeZAGM6l/6tR6O3Bmuk4XSI4U0EEX3HhE8SXsSHk7AW+hcP51wxLA1aeEf?=
 =?iso-8859-1?Q?qctlhOKzMAK0W3zjLErltlA3huauuG8Oed+VF0HOBOywNnwvX+fcMtMOKc?=
 =?iso-8859-1?Q?X7pWHi82GI1+aREGdZwTqfSir6EnXVDJNd5+H8jlmVyT9Prg4LZi///1YV?=
 =?iso-8859-1?Q?UWy7mQAoktcWXA9YchnLBdF9RXM0Jk1qQWJs0OcjSrucovISvz2R2jIbRt?=
 =?iso-8859-1?Q?f1hYr+eBj2RDZPtDvLqJlgGaNOpMrDDZ9hqTYoJrXSfgcagt0ZocnN1RXZ?=
 =?iso-8859-1?Q?OZxJd5ikXD1SBmULicw1t+GJkNbCAoO3R09RFo/pzN1xZqZlhUSysqxDlv?=
 =?iso-8859-1?Q?JkS369EQhgTfSSVZMlZ+lye2PO3cDx9dVGb+WKadne/yA/v0c9fB7k+xTx?=
 =?iso-8859-1?Q?4JxKYniQQAriSlz69qMY0ByZ/VbVirMkWgsApS3cgLV39WjoAIJA0dXnNa?=
 =?iso-8859-1?Q?lo9DPtoGCwIR6ia/zdspcB+fLN3/bORyvkerxB4RqNwNbQAjqMaX4RcYWr?=
 =?iso-8859-1?Q?8zKXOpdyG/9XHJ2YyH/A3ux1/PHuQ+atRWcHLGqL1yzcdO7vOq22ZoxA0W?=
 =?iso-8859-1?Q?YrMCTY8n6xtzgb/7rJOuAqQlVwR2dnJHObTKGwC3SSrils46lKR8t42wvb?=
 =?iso-8859-1?Q?ASHz8u2pmFxWwAlgkvQyXzm0Aa3rnE+aeWK6QRebEDaPU34G53xiduQQGA?=
 =?iso-8859-1?Q?we+j9ye3bUzGmAUP3GyShAamtXqzLIhXM4oLEsPHIfw9n3/fWf3+aK/wVJ?=
 =?iso-8859-1?Q?Zv2v1UTDrUXcjYiLMBaJs1YwgsD10vQatt78d9zMcqgQ9CG53G84P6MtbR?=
 =?iso-8859-1?Q?ThhDyULmD9OX92ePoFC7z/7Ryd9Vmfca9R6eAdzq2tdq3voZudGXQQ2HMV?=
 =?iso-8859-1?Q?0pZKzDsqMOpj5XSK8r6Pu1F1Q1LexoEEUsHF/sJmcILAZTV49fEyyiPrfj?=
 =?iso-8859-1?Q?oaMqKJw7OTY1T5ul4wu/G/i4pEd/TQIZcEIyI4ViWVJd0cVr45B2TYrq8K?=
 =?iso-8859-1?Q?2KRA76Y48a85ZNaMFiF7bSp63mVHZx4vURIDpEYZw9l9GwBSBFFl7ZD81r?=
 =?iso-8859-1?Q?BdEmtFuJKBBT5qBDMdYzC5KMwk1mzcWHfW8HM9XGiGdh3KXIiAGtYy6Xns?=
 =?iso-8859-1?Q?udKanak6suWE/Qr0tIgr/GFE5MgnkF4vzOUuRWPA0nF3UWvsWkWCgS33Dp?=
 =?iso-8859-1?Q?ThF3/X7/++NNI3qtbn8V1MhNG/vYf0uOiQ152kGSbawvEijlIzzkZf7G2/?=
 =?iso-8859-1?Q?ZErcR9a5gywjtnV8j9KPY2s4KEuWT3wTXFmH19wgM5YvN3+C+RZjvWVHy1?=
 =?iso-8859-1?Q?2I/ijOCgjgpaASV6S1wnHEHsoSW9lt7ApBgx7xRlEMIhAgb0sa2mHuqWV+?=
 =?iso-8859-1?Q?eCUivE6AWoJOGaP5o46O98WAJPWe41THwE4E76QvAI4JCOIMTu3AwG3tkc?=
 =?iso-8859-1?Q?NQXKiywlb9eBD1AjXFFhK4yDCtujFecsWD1coH6wvToMvFQh4t/hXev51H?=
 =?iso-8859-1?Q?co4Bi4WtfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d23907f-f01a-4d5e-4333-08de83058ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 02:41:42.6433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2lXjzc5T6RAfMd8b0eRKajty9AEa2kWP3SwPpSWDM/eGB4cEfQivVEFPI+CrslR4S3pt8KNSwstQUKdEoKcUXF0VM5WUfGX1vQD0o0kiOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFAC281535F

On Fri, Mar 13, 2026 at 06:02:16PM +0800, Billy Tsai wrote:=0A=
> > For controllers with battery sensing capability (AST2600/AST2700), the =
last=0A=
> > channel uses a different circuit design optimized for battery voltage=
=0A=
> > measurement. This channel should not be enabled by default along with o=
ther=0A=
> > channels to avoid potential interference and power efficiency issues.=
=0A=
> >=0A=
> > Changes made:=0A=
> > - Introduce aspeed_adc_get_active_channels() to return the number of=0A=
> >   channels that should be enabled by default=0A=
> > - For battery sensing capable controllers, exclude the last channel=0A=
> >   from the default channel enable mask=0A=
> > - Enable the battery sensing channel only when explicitly accessed=0A=
> >   via read_raw()=0A=
> > - Replace hardcoded channel numbers with ASPEED_ADC_BATTERY_CHANNEL mac=
ro=0A=
> > - Add helper functions for cleaner channel management=0A=
=0A=
> Why not series of patches each for the change made?=0A=
=0A=
Okay, I will split the changes into a series of patches for better clarity =
and=0A=
review for V2.=0A=
=0A=
Thanks=0A=
=0A=
Billy Tsai=0A=
=0A=
> This ensures optimal power efficiency for normal ADC operations while=0A=
> maintaining full functionality when battery sensing is needed.=
