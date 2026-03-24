Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013083.outbound.protection.outlook.com [52.103.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F83FE344;
	Tue, 24 Mar 2026 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365926; cv=fail; b=rvb049Y53LUY3SDUcgljUZO8JrIyeS8YL4YcazOl3pF/Yr2Yrj6LgX0OnWXo4vjbOCnBIac5xGX10dHTDasjR7xTKSh0KYfyqnRCLFWU9dmvtyuDCP0jkeA2UiYGHQxR51FxQkUGgPibtjOUYZF1C6xp4SpG7oTbK38C5P/NmgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365926; c=relaxed/simple;
	bh=aCz7czJcZJguhZtI4tCBpPNpQjFQ8FAJRDRTNo+i6VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eOvJI0sjR7zFUMkpXvq+bZIJjKgqEUBmXj0Rr3Bda0jc2HEs07owznlZxMXj2IBte9aE6/f1hPW8HWT6sVmLwPSy7hicCoinhoXhttud3VsXAtIWvVhiRnyfc9FIsAMsK31btmlQ5Bus6wbVKz6xyHRcnGGtv1tNPp/MCCXIQYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=r+A3hgGC; arc=fail smtp.client-ip=52.103.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="r+A3hgGC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGn2+YiygUKH6Dl7fe1vQeciN80F47Q7H+Me8bX5kEamHNYY+PsN+xeHXIiaw8jjOxITcCF8CbAxcFgNaF+khaXjpEAPg6ocGv0vGXu/8dzHu1GszpX11tBA6qfNxc9V0/DOjlgTHiFHaeJKia3BpBBmBgy/6eWI7KUTwxOgd+JO4aRJ2eie9FE8CKKtvHcTdw1QV2YOBBbR6cJB6+n7PSo+QJS3yHyyMQh1+0DLS7nuE9l+wbkUjTdeuQdK/gmVRcAH/ipqOfP5Z9L+uw6JTb+QXHO4cYAcPwglTvu6v071O7w9+Y5TRxp16NmWEVLkNq4fn2BnBf1kPQpD02WHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjFl6ZofEOE43CJCTjzXrMpzeoVO3dAyGChQnU+Dt2c=;
 b=OqQj87KofMvOHo7m2zVYR9MPJRrL+zr2ZnFekGYoO75dgodPsTD1X024yVJNfMhlGzW5lhdyzmpYcshkNgZ5vzgSuRQ3/lwHzNgm4Psr4zC9ZtswBXfFCW/JFVfQhRbBhl060QxNn1NBUxyCBMJM5hp+1WRubk01eAHV0WsVTgDMU+Bq2JEMOD7GQN67hcM66pPrxyT4LS4RDqxEfMHhAD2i1XnkvAshmXx6BgxgI57OcviJ02gvWTv5yQtc5V/fAzLpcel3SzQNFDWxH2P4wCKcgHt6xQK5met3yVNkLbX8qJ4I95dNupfiRhhd+dn4QTfDpCXgcnx8RjxRplQ07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjFl6ZofEOE43CJCTjzXrMpzeoVO3dAyGChQnU+Dt2c=;
 b=r+A3hgGC0Jad7y4m+p8X+9KLMKAe/K7yhBphzGzhtITKyxhWLm7DiF5vaXugiz80KCNyVIKEm8VwqHA2ojmJtaZ+nhPbbbTkkwk2ALZNjZSs3Yi7YkxVmfTHSqI7IVECjvNiwF9Xylu7EPoJHX+FbEru5emWtTMfaXaKfcYN1cllnafNSgTcwNO7VYUM+3gHQD/XWOzepWMcHdPJdVniBTpSzBYmcZ3rRshDN2fjlwl+5w6c7hRve9/u85ugeT/Zfx6Cw2IukFCfd/pAub9qh+V5W204jzs7mSjqqBXRMGLMvPrYgoVbjumrufO9htj+jS28L+1A9BiDIbeDQenxpw==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by CO1PR19MB5061.namprd19.prod.outlook.com
 (2603:10b6:303:f7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 15:25:21 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%7]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 15:25:21 +0000
Date: Tue, 24 Mar 2026 10:25:18 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Chris Morgan <macroalpha82@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"andy@kernel.org" <andy@kernel.org>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2 0/5] Add Invensense ICM42607
Message-ID:
 <PH0PR19MB997338F89E780686797B1D14A0A548A@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260319182956.146976-1-macroalpha82@gmail.com>
 <FR3P281MB1437798EE08EADF674E42526CE4FA@FR3P281MB1437.DEUP281.PROD.OUTLOOK.COM>
 <abxrQ7MUw4QXnYZG@wintermute.localhost.fail>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abxrQ7MUw4QXnYZG@wintermute.localhost.fail>
X-ClientProxiedBy: SA1PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::14) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <acKs3hV9Q4COyeMC@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|CO1PR19MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa12630-336a-4b4d-3f94-08de89b9903a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|6090799003|19110799012|23021999003|51005399006|5072599009|37011999003|15080799012|461199028|8060799015|25031999004|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akxKN2kzYVN5MVA1MVJjQm16dTRSNUswOEJXTVVIYk5xcnFMWDVsd2pURDlF?=
 =?utf-8?B?Y1VBM3JUdzE0RllQZ1dteStMWWVkT0VjZ3podG1HZUV2bUxTVDE5bzBBWndU?=
 =?utf-8?B?YVNyVGZBc213aW80N3IrWitscVVtTTJMVDRKOE9WVUhlNUxVWGlScUEyYjVi?=
 =?utf-8?B?M0Q2WlMrSksyanNZcWNVYWdGTWRCano3eHRqaUNGZGF2QlN1bXhmWm9OdTVy?=
 =?utf-8?B?L2V2YlpzaHVaeUl6aXhpemx5U2xwS1RCODFaWTc5TGsyUXcxa2xGL3hlYXRs?=
 =?utf-8?B?ejRiZnVNaElnb1hMSFpJVjNuQTMzWUJIRVptRXpmcThLbnRadUJUSVN1VHgw?=
 =?utf-8?B?aDNTZjhxSGwvRGNRcU44NVR2KzJyNlRJWkpWZlBteWtOZ3JNeHNSNmVRdGVN?=
 =?utf-8?B?L1dLSVhXSmtqUXdseTlKS0Q0SUx2MW4zVXRqaCtyRWlKa01mVzltYkMzODdC?=
 =?utf-8?B?aXluc1lONDRzNFMxM0haZDhGV1lhbFhqeTJ4TGZRb3hFbVgzenJYeE5uZ1Rv?=
 =?utf-8?B?OVFGS1BzZkhGeDVZckxMYXArSVlUdUJFeTFzVFMyYjVoaXFIY3pEM1RCTkxD?=
 =?utf-8?B?UTAvTlREY3oxdlBzcVNwUE5yeVl6WU1lMVFNWGN3SzlrYXpjVzZFSnY2bDla?=
 =?utf-8?B?YUxTNnhzWGRCNVhVWUppUithMXFmeUM5elVJRnVBMjNHRjZMOG1XeWFsRmpJ?=
 =?utf-8?B?dTFMMkVVQTNER1k3Q3dyOFdRZE15MjlIWXNINjBHY1kzUVU3RUI3ZFpxSE5j?=
 =?utf-8?B?MnRSeDMxVm5sbjRaZkJvaTV1MGxVT1N0U1JsdnV3UEV5NEU5TU5zVXBkd29w?=
 =?utf-8?B?WHJvanZrcUY3d3VoUTVucmY0b0gwT3p4Y01sOFNhSVhPWTRHMDJ2RzhSVW9G?=
 =?utf-8?B?WjdVc0ZHVXVNNTNrbnpCQlZaMVBzZERvSCtGSFNzOGk4OGlGNFZBLzBLbFhX?=
 =?utf-8?B?UmgwVW9uZGlwQ2ZtRW5PcTltS21NOE9nOUhpRU55OHBkay9NK1pTTmtyQWdj?=
 =?utf-8?B?dU9yeVZaalRYSmRmdjA5M3l6Um1CN2gvT2o3MExHM1hoUDFkNm5YVGQvZ2ts?=
 =?utf-8?B?TmliZEZpRk5qanhybmJLRk1WVVZ2dHhDUGcxVFp5S0NLaS80dUpub3Q3dGho?=
 =?utf-8?B?dnNFVU9HSEI1bVpGWHR0NUEzVUpPRDJpY3l5WW52bG1DZ1VVSVVTS25jYWo1?=
 =?utf-8?B?WmlsQ1M4b1dRZ1Bhb1FjeFBQamtqZmtJM1dBVnBYZGx3aW02Mm9KSmxMeWdY?=
 =?utf-8?B?Y0I3MlBheFIrTm50RlE0M2txVEhmVFU4ZnhmRzVCdVVTWWxGMkVVa2RpNlhN?=
 =?utf-8?B?bjlrWEtvczZGdW5qRGdBd21WY2ZVWUVCS1FDVlVmK3BmOWZnY2w3SUpGQWpl?=
 =?utf-8?Q?sNSoGpO/rUn6MXV/vZzgbkTzJb50N6xE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUxDamhnQ1Q0OWMxa3pBeld1V1lRVjJXK1VlQ3ZVM3h0Ync1WnBZeWFzbXRq?=
 =?utf-8?B?SEJnWndiRzZjNjh0dTBEZ0YvQ3V4ZGZ6WmdrZ0IwbUI4YmY4eEtpUEJRWTZ0?=
 =?utf-8?B?dWZaMnUzR1lRVmwyclpPWjc3RnNPL05TaVgrY3BWT010cytjazNsVDZiL1ll?=
 =?utf-8?B?WXpZWlkzTytJamlIRG5yWExrdlVSUjRWQXBCWG1QeFFpK1NrbHNjRW95dWh0?=
 =?utf-8?B?YUpRaEpUQXd0ZUR2S1hIZkVIZW43bjBtSERoTlptOWt0Z2VHZjdqSys4Z2kv?=
 =?utf-8?B?cm5WZXFBNkMrZWpjQVlqNXBHZWJuYlJMek9hTTZtNDdUODhhM25HNHVHYWFH?=
 =?utf-8?B?dHFwSHRrUnN2emxaazRIeStBYnpGWFNvWXZnWiszTXJMVE1odmJOMUlLUHVi?=
 =?utf-8?B?KzBFZ05WZ08yc3V4M2ZLM2hWTHJET0hldmtrQ3pBRlNxMU9QWE1NT0p3Vitv?=
 =?utf-8?B?cFVTeFdoRENkQUJHbTJzVWc4U2MvSFRDNFZ3SVVFM3J5S0UvWk5RUUxzMjMv?=
 =?utf-8?B?NGlrTktLNWJmS3FLeUJNVUMvL2k4Smc4TVJsMzRLS1B3K2luU3VQMWJwR2FL?=
 =?utf-8?B?QjM1SS80YmR3bzAwQjIzdXNDZWdhZE9URkszWko0VEVGOGx2aXhvbkczRkRC?=
 =?utf-8?B?ZVlWb3NIa2dPYmRUbUlQRkptQy9hWGxPNVBta1AvVFp5R29BeEw5YUtrMy9C?=
 =?utf-8?B?RjlvV2U2Q0U0UXdrY2pveFR5ektvYWxldG1rWjM3cGcxYmtTaDI0QUhmU0sr?=
 =?utf-8?B?QWhSeEs2TUNVTnE2WklEYVA4SkwzU3MzeGxxRVZ0MkNBcGRpNjJRemRPZkF5?=
 =?utf-8?B?TXFreXZKM3NhWTNrZ0g4SGpHT3VSbXdxdHFNWTl0ZjlyUVExdFdodDhnVW1p?=
 =?utf-8?B?aFR3ZDR2b0RidXpkajBZVHp5QUtrYlI1ZURyQ2JqM3Zla0xReHJlMllLSjBs?=
 =?utf-8?B?cW0yZ05MTzUyOEtGS29BaUpRSVZvaXJDT1JUNG9VZHREdFpPYU9ESmJsM2JI?=
 =?utf-8?B?QmZWbnFmRVV6N09jYkZiaWx3bXp3TXJXR0FBSkdRZmlqOWxmcDllL1lZaFF4?=
 =?utf-8?B?MkpwQkEyRStubUhZZnBQZFR3Yk9RbE10Ykw2QnNoQnpMT3VzaDdTbzZieXlm?=
 =?utf-8?B?TXBkekovK0JmakFpdEFRYzViZmU4WkFpK3lybkdkcDRsRmx5TXZxenRydEN3?=
 =?utf-8?B?TE5qdGpFM1l3b2JzcWNIZjVqcUpnL1JOQ29Ca0lOa0w4dDVMY1hYZGFIM1ll?=
 =?utf-8?B?dU5NNVNNZWVSbkNXUjBVUVc0cjFEb1ljVU01UDh4SlBtWmNyU0NSUDFUVDE5?=
 =?utf-8?B?L2d5dmtoelIvRXpTOTBkN05LVmFzRkVGRU5VUEVZZEd2Zm9uVTlkWkdZTDFQ?=
 =?utf-8?B?ZTZBRzdBZ1BBeCtRci92RG9wMlM4cVA5eVJadnVxemw1YTAxNDFvaEwwQmdT?=
 =?utf-8?B?NTA2SGZUbWU0REpoNjYxQXE5Y0NvbTdsRXljY0UrN1pTaGZORHF5WTUyUmtS?=
 =?utf-8?B?Z3RUbUlZaEVRcDJZb3YvRGZlT2dGdk1KaUdRNnN5bDVYMG1QSlYzZmR2L0RT?=
 =?utf-8?B?SUFBUFFOSzNEN2tyRkg3Z1VWcGoxVXR5QlVBUnhHRXZ6TTdzanBBUzYzZHdU?=
 =?utf-8?B?QWhFWVJjRXIyaXNUVlBzU3VBbTFjMGlZSW9OQjVFNEFYWHk2L3FNdzdPbG12?=
 =?utf-8?B?Q3VseDlTc2FBK1JVU04vU2VNcGcxc1pTcHNPaXEzbEVFd1l3Z3I3bnU2WXlD?=
 =?utf-8?B?UCs2ZzN1RDMrNTh5YW5CdisySUxxb0lIYTVaclYvM0tUYnZlMVExWFdvaWFq?=
 =?utf-8?B?cEpQZEY2THV1d2xGSFc5d0VhSUc5MWF1bys3M0txRjZvMDFlaUgwUE5XRnpt?=
 =?utf-8?B?dUdhdG00WDYyQ2cvc0ZSV0hCRk1RM1RuOXowT3ZidGUvMHFDQUZScjQyckw3?=
 =?utf-8?Q?l7yyGWLDIpk2mYOzZCtP9g/tyUznvyWj?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa12630-336a-4b4d-3f94-08de89b9903a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:25:21.7106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5061

On Thu, Mar 19, 2026 at 04:31:50PM -0500, Chris Morgan wrote:
> On Thu, Mar 19, 2026 at 07:55:19PM +0000, Jean-Baptiste Maneyrol wrote:
> > >
> > >________________________________________
> > >From: Chris Morgan <macroalpha82@gmail.com>
> > >Sent: Thursday, March 19, 2026 19:29
> > >To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> > >Cc: andy@kernel.org <andy@kernel.org>; nuno.sa@analog.com <nuno.sa@analog.com>; dlechner@baylibre.com <dlechner@baylibre.com>; jic23@kernel.org <jic23@kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; linux-rockchip@lists.infradead.org <linux-rockchip@lists.infradead.org>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>; heiko@sntech.de <heiko@sntech.de>; conor+dt@kernel.org <conor+dt@kernel.org>; krzk+dt@kernel.org <krzk+dt@kernel.org>; robh@kernel.org <robh@kernel.org>; andriy.shevchenko@intel.com <andriy.shevchenko@intel.com>; Chris Morgan <macromorgan@hotmail.com>
> > >Subject: [PATCH v2 0/5] Add Invensense ICM42607
> > > 
> > >From: Chris Morgan <macromorgan@ hotmail. com> Add support for the ICM42607 IMU. This sensor shares the same functionality but a different register layout with the existing ICM42600. This driver should work with the ICM42607 and ICM42607P
> > >ZjQcmQRYFpfptBannerStart
> > >This Message Is From an Untrusted Sender
> > >You have not previously corresponded with this sender.
> > > 
> > >ZjQcmQRYFpfptBannerEnd
> > >From: Chris Morgan <macromorgan@hotmail.com>
> > >
> > >Add support for the ICM42607 IMU. This sensor shares the same
> > >functionality but a different register layout with the existing
> > >ICM42600.
> > >
> > >This driver should work with the ICM42607 and ICM42607P over both I2C
> > >and SPI, however only the ICM42607P over I2C could be tested.
> > >
> > >Changes Since V1:
> > > - Instead of creating a new driver, merged with the existing inv_icm42600
> > >   driver. This necessitated adding some code to the existing driver to
> > >   permit using a different register layout for the same functionality.
> > > - Split changes up a bit more to decrease the size of the individual
> > >   patches. Note that patch 0004 is still pretty hefty; if I need to split
> > >   further I may need to create some temporary stub functions.
> > > - Used guard() and PM_RUNTIME_ACQUIRE_AUTOSUSPEND() on the new functions
> > >   per Jonathan's recommendations.
> > >
> > >Chris Morgan (5):
> > >  dt-bindings: iio: imu: add icm42607
> > >  iio: imu: inv_icm42600: Add support for using alternate registers
> > >  iio: imu: inv_icm42600: Add registers for icm42607
> > >  iio: imu: inv_icm42600: Add support for icm42607
> > >  arm64: dts: rockchip: Add icm42607p IMU for RG-DS
> > >
> > > .../bindings/iio/imu/invensense,icm42600.yaml |   4 +
> > > .../dts/rockchip/rk3568-anbernic-rg-ds.dts    |  20 +-
> > > drivers/iio/imu/inv_icm42600/inv_icm42600.h   | 333 +++++++-
> > > .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 497 ++++++++++-
> > > .../imu/inv_icm42600/inv_icm42600_buffer.c    | 240 +++++-
> > > .../imu/inv_icm42600/inv_icm42600_buffer.h    |   5 +
> > > .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 795 +++++++++++++++---
> > > .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 379 ++++++++-
> > > .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |  53 +-
> > > .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  59 +-
> > > .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  64 ++
> > > .../iio/imu/inv_icm42600/inv_icm42600_temp.h  |   4 +
> > > 12 files changed, 2289 insertions(+), 164 deletions(-)
> > >
> > >-- 
> > >2.43.0
> > >
> > >
> > 
> > Hello Chris,
> > 
> > thanks for the patch, but beware that there is a major difference between this
> > chip and inv_icm42600 chips family that is preventing to have a common driver.
> > 
> > inv_icm42600 chips are using direct register access with bank while icm42607
> > chip is using indirect register access using IREG specific registers. Some
> > registers cannot be read/write directly and requires programming specific
> > registers. The mechanism is similar to the one in inv_icm45600 driver, you can
> > have a look in this driver.
> 
> I didn't see anything in the datasheet for the 42607P in regards to the IREG,
> but I did see something in the 42607C. That said, near as I can tell from the
> drivers that I used as a reference from the Rockchip and Lineage trees this driver
> doesn't access anything from those registers.
> 
> Still, I'll defer to you on what you think is best. As long as I can use my
> accelerometer that's all I care about.

So closer looking at the 42607-C datasheet, it looks like they have MREG banks, is
that what you're talking about?

If so I can either remove this and create a new driver (as I did with V1),
or I can just keep the 42607P in this driver since it does appear to use only
direct register access.

Let me know what you think so I can rewrite and resubmit it. I'll try to better
break it up this time too by seeing if I can make temp, gyro, and accel functions
all with different commits.

Thank you,
Chris

> 
> > 
> > Using the same driver is not possible I think, since register access is different.
> > 
> > And there are also more differences between the 2 chip families that is making
> > a common driver quite difficult to do.
> > 
> > Thanks,
> > JB
> 
> Chris
