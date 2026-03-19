Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010017.outbound.protection.outlook.com [52.103.20.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A93B4E83;
	Thu, 19 Mar 2026 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955918; cv=fail; b=jHn46pDzQlm50HRnndWvtThsxMZD1MfYh64bPfoTFudzoouYtviLz4Pe9lcI/BwyGkirQi/Tk2rjb6Kcq1pQitP0b7TPlIDHnQ5onH+14kV5w3XQSzlPDrRirw8XtsU5RYkWL8BreD5h6Tzb0zLckiTsVUliqj+noNesvMy2d+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955918; c=relaxed/simple;
	bh=alF1IRPuNVV6tILskGWyL3OM2MiLUFjuMOMScNdIiVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jn7b5e05fcJ1svfh3EbWgo23DqFUQifva/PZQHX6+8j2f1IDev5B8nNj4xZRdBLHR0pc8n8Grwtb8cdw2E3pOcwENWpfPxvVutV8gWBw1iLkD8wPTmF6Ej13wo88bA+Ta8abBYP2SReJtKOHFooOQBxz74R2Uubpmoo2FxVpvCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=jGALhFst; arc=fail smtp.client-ip=52.103.20.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="jGALhFst"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDAS4vsksEBtRy1ejCSSKxSPril8OilmuqDomAJi5JC/9y36DF4LQqZsGaHO/tJZAhDeqTWOnDClsJRKS7/VrcLw9A9H3eBO84amesYGCiC5aInd8dWQz+IRHsUe0uju8+MS+1HhN1WPL3mq6kqQ8C+Dp/8Usehy515EVy9o6xdjzZCjoAlVHqhthBeiBb8QXp0KuGEpZ2qqVYuN/3xkeOE1XFzg9QEqtjHEdk43wAFxhWtTiQTEvWqQDiNWwjbGpJ5wJEzRWMx8ip2m7oh+Zm5JwmyWHc0XnKzBX5eLPIpHR8gOHMr2ylnpt4MzzN1WvkE6V3NTgVfg/30EkZimLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZYIgU7DUucChD5Dg9JZHSe2+3z0A9kP4u/+OCFLMjU=;
 b=Xaz1QTUgSSFcQM7pkUFsXTIgIVGWNzk9fiEElcQuAyWzL4XdxR6PNTIqeYVWvD3rPqM6d2Sptf8a3DZMckwLaPZPtINjbdM9R9pYsKhtxp817Ljsl+2UcFTtZ2YahVWQ73PY1KeeERukxlz1GCo2Gkw5g+tkluY0ekF4u18RNNABMggJsAp4XBkxwwJ+eZlkychOk89e/hPV0hEvNC6ratE+aQTZKpBfJi6kQumASEHBwx9CwqtSpvN9ZlkX0aBPgvcmzFxMTIauWwYOcSgK19ObsBz4eoIHdqRU1kj4QJBQdRtN5vLP3a7b7j00iUe4cn+9M4Qp4wNd8iddbYzj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZYIgU7DUucChD5Dg9JZHSe2+3z0A9kP4u/+OCFLMjU=;
 b=jGALhFstb0xWE3Qh+ZvdkLu602klQ9J3GzGeHtQqdZpdELDQcDkH+jnBrwDPxcBVKN8EjsE/wN/9w08aQbCNGPr74cKAXON3qy5nuX4odR9HZIvSnedmb/moqxxqv2WJ0LISpGMIP3sdyNCp2QRNlI5QuwWrk0UVrGlHhAK1xgSCFlp9Oq2XL+zPkBhCjsU0WPQieveGQeuE2QA4h+I20oAQe1vsnEYniE80hGAguFyjX9NEWhib2fdc/5rlnbcFuwGCopINOuF6acACSw5maIUmzYBH6bCbsEu/LX4eIpLmWYIADX2qUtvdNjoWFHzdMdK7ws7HWNFMrzFCXxxt7Q==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by BN0PR19MB5264.namprd19.prod.outlook.com
 (2603:10b6:408:153::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Thu, 19 Mar
 2026 21:31:51 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%7]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 21:31:51 +0000
Date: Thu, 19 Mar 2026 16:31:47 -0500
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
 <PH0PR19MB9973383B1E6959992D365EA4B1A54FA@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260319182956.146976-1-macroalpha82@gmail.com>
 <FR3P281MB1437798EE08EADF674E42526CE4FA@FR3P281MB1437.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FR3P281MB1437798EE08EADF674E42526CE4FA@FR3P281MB1437.DEUP281.PROD.OUTLOOK.COM>
X-ClientProxiedBy: DS7PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:8:57::20) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <abxrQ7MUw4QXnYZG@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|BN0PR19MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: 408ea85a-30eb-4ccf-80d7-08de85feef2a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|461199028|19110799012|8060799015|23021999003|37011999003|12121999013|25031999004|15080799012|3412199025|440099028|52005399003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFB5dGVrWEM5KzNTTXM0MDFuRWVoc01LQkpueFEzY1J1QTRWVnp6dmh6OGxV?=
 =?utf-8?B?eTR5RXFtMzBRV25TRnJwbWJKSzFOMU00S0VvelZSbS91Q0JzU2NsOHdiSmdk?=
 =?utf-8?B?eHRYdCtNblNhc2dkNXE5RTkzU3J3ZEtqeUJhc0hyU1lCS2Z6d0gzemlyL3Fa?=
 =?utf-8?B?T0xNZ0RHVS82dDc5Y1ZxOWowUG9iOXJUZWsvL0dOVkdZVjVJRmZOYnVMYUNR?=
 =?utf-8?B?NHFyak4reURiNmcwdmdITkxoZkV2V3ZhTU9PMzJWNkRndGg4Wlk2N0lVR2Ft?=
 =?utf-8?B?Q1NvRzgwc3l1cG80UlBlMVN2aHpBTTViT3lZWXJVTDJVcnZmSEgwRVR2eWRs?=
 =?utf-8?B?bHpBR2VKUExsZlB4em1iNTJWMEEzZ0xhMzJ3TGZQeEZEemVWT05kVTkyaFZp?=
 =?utf-8?B?emR5aURDbkxLUHFiQit5SkpTNnhkSEx0U1B4ZGtCSUZxcmxhWTBFYXNQdjZn?=
 =?utf-8?B?SlRDdWdUN0hzUnhFb0Z2MEtWNWhTd0c4K2JzbGVLWk9IdUh4VHdmUFhyL3Fv?=
 =?utf-8?B?cTNwTmVnQlJvOUZ5dVRTZmdZM2hqUHZ2OHhmdW8xY3BxaXM1cGFPYnBoSDNp?=
 =?utf-8?B?Tk1IZlVMM0xnQkppOGtSalMwVEZaemhSdit3RTZ2WDVWckxUeTFuVVpscnpn?=
 =?utf-8?B?NzRiODVZdExqeDJRMURSaGpaaEFvUWMrMStqNkFuR2ZQUnVXdXMzMEVuSHBo?=
 =?utf-8?B?NENyY1dPZThSdnZOeTdseXVsNy9SNjRpUkxYb0ZGVHhwRTBydGJMR05acHZo?=
 =?utf-8?B?R2xTSEpmSmRLbFhJU1YyQTZkQTlUQjh2YkUwY29XU29qZ1IxS1UvbkpxSlZP?=
 =?utf-8?B?WXZPM0VBRnlHT0s3a1BBODczdG1NV0NBOFIxWTN6S0E0dGMyZ2RhT25pNytP?=
 =?utf-8?B?MXl0Z0NrSFYzWTJYSlRZdExZa3lFWnhMa1lwamxvQUdkcEEydnhHdDl0Lzk1?=
 =?utf-8?B?bFFIbWYzbmVhblFrSjh4eTdkT3dMVU1tcGcrcEIxcmlnT2FWUDhBa0I5N1pr?=
 =?utf-8?B?WVZWdWFQOWJjdXJ4d1NLbDMzNXRMaHAreWhHZ0ZYQSswZVZpNVdZNEZxZ0JG?=
 =?utf-8?B?dEFXVDA5VEJVbVk2elpCcm1KcTRMTFVSbEd3QUdCZWdPZUxrTVFZR3Z2Ry8z?=
 =?utf-8?B?MWZKdWxIZDB2eW5GeWkzajFVRlZaQzZIZVFrZ3FFV2p0OCtUZWRqL2hYOTYz?=
 =?utf-8?B?cTBXV1JMdzJEeXUzMVhuSCtpUTlTZUpvSGF5blViRFJpaUgvWTBDYlRNays4?=
 =?utf-8?B?VjNKajZydFFPTUttSnZyOXNOK0ZWM2ltTEZmUlk1VWdkdStDT0VEcmVOT2hE?=
 =?utf-8?B?dHJMMWk4Y1QrRDhkQmdCelJsYmd5SHh2c0lJaVNNS3prWGMyVWduS1RBWElq?=
 =?utf-8?Q?8MED3U6Y3bcRUwTMV4dAAmaPcX4ZVujI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUZrR1AvcjF4MzVJMjFzMXliRUZvajNWYWFTNVRBbExzaWt6VFNoOGgwZW8z?=
 =?utf-8?B?Zi9uUk41djNYRGhWam90SVFuTXdLY0tyM3IxdVFraGI2cEpOOUJvNUk5Tmln?=
 =?utf-8?B?bU9JZW5aWHJYSm9qZ040MEcxRDByRytKQ29qbkxRMWY5L2RhSjZUT2V2RU9p?=
 =?utf-8?B?ZEd5R1lGQ2pNa0pPWnhucnVWSXUvejhmdzgxQ3V5cmRub2hraUh5TGxhZkl5?=
 =?utf-8?B?UVA2cURkWHhTbmV3bm1vMkJSU1NKQXMvMVNFWU5Fa0cxakd2U1R4V2s1Y3lC?=
 =?utf-8?B?Uk04L1dQWXdkdllHT0ErRHpoZjdDQmRzcEtJYzRtQmJVSDZDL2g0ZGpHM0Fj?=
 =?utf-8?B?Rk5kL0JaVzJIMmdRUHVkT0pvUUhkdjNYUzk0VW5pc2Z4cnI4VW9mWnJVaVlD?=
 =?utf-8?B?WFdJSGZwZ3Y0YTY2T0wxSjc0R0V4Nzd3Uk55amNNbmd3L2RTRUlEWU1HWFRO?=
 =?utf-8?B?aVpMV0JVdUtsNTFpeEpFL1djVTJlZWgvcDc2TTRtSmZvZ0ZFaDB4NDhxdDdq?=
 =?utf-8?B?MmNQTDIyeUhzV1Arc3dVOEwwNm9mNVE5TDB6dDdwMUhqVGtjOVJ6ZHdjQnFM?=
 =?utf-8?B?bFRxMnVJdVdPVWRhWG1xOWNPdEtzcmd1bUE3TnVPRkNPL2ZCK2dLRWpPR2xE?=
 =?utf-8?B?QkNyaFZJM2xXMmpBSnhjVi9zYTlicjZWbnlCbFVRQWlpa3FmUDArenhVNllC?=
 =?utf-8?B?bXdrQ0gveFozNDJpYWFQcER5SCtNdU4vVmRKdE5yeG5yQnoxNVpyN2p6Q29L?=
 =?utf-8?B?MER5bVM4OEV5djVQS0NRZy9ucjJHR1B2NGdXL0hPQmF0dGQ4a3dTcjE4OXo3?=
 =?utf-8?B?ZkRFenIxa2g5OFJDQ1NOU2pPZGpKQUNNVytPamtlNFNSQ3BpR0N4cTZxVWt2?=
 =?utf-8?B?bUV6dzZNUEVhOXdnNG1LdXRpVld2ZmdsUmcyRmpDYVd4K2JlOHZ3b2haUXQ0?=
 =?utf-8?B?cHE2T0FrSVZrWExaNHBCQURqTW9PUWszZHFJYTFlTTZJYXYrYTdFZ0RkeGZF?=
 =?utf-8?B?NmlqZmdTRzhEY082WENQRGJtbXEyVi9CcnVScHdKcm1qR0hOamxxWndSVWxU?=
 =?utf-8?B?bk9VRXZlUVRZVVVPYVFzam1vcmZ2ajhuTUpXeUZYaXlVT0JyV2lVZG14QWhr?=
 =?utf-8?B?dmljdlBVTGdablpsLzkrdHBNaFBYZ3pBYktTd2tnR3ErU2ZicWlqdjhNYVlG?=
 =?utf-8?B?bnZLOGtvcnV3clVCUFJXMnNRVTA2UHJaUWh0SlpZRVpETjQrWjlTYmdmcGxj?=
 =?utf-8?B?ZFp0eXFOenZCZTJSd3RNcFZvaEdXTEJsS2lxU1ZYK1FJYThXQkdNdmMreXlx?=
 =?utf-8?B?d0tEU2R2UVlleG43SnRncFZoNTZubHF0WXdmVVROMHkwSTVvdjY5b1kza05o?=
 =?utf-8?B?Q2hNdWluRjVpQUNocTdod3ZQbWdETjZWRzVQb3dzWlYxc2JLV3FYTkZneFk1?=
 =?utf-8?B?T1ZlSW9HOEZya3BRMmV6UitzNThZTXJERWRNL3pqZHlOMGU1M29tY2hUYUNs?=
 =?utf-8?B?cWtGVmNSdW1PdEQyVEdSSEZ6WGp6RXJXWVdjUlJMcEtES041Y2FSdFFyRm1H?=
 =?utf-8?B?ZUgxVXVKKy9BSEpSVmh2TGV6N3NDQW40YzBubWFlMUMwMVp5RDBpR3lzQng5?=
 =?utf-8?B?WElLNWlJLzZ2Nm1Bbm1mQmxnYjdBNDZsUjdHVCtpMDZIaGQwK05YaVA1TWdK?=
 =?utf-8?B?QjFmWjNxc3hEUVZxTlg4ajJ1RUVxbWR0ZjdlTmdxUCtYajEvVzl6ZUIwc012?=
 =?utf-8?B?WXFhT0RJbUZsRmVoRlZZdVlIaGNoUy9GSGlVdlVoeTQ1cGJ6UEdTM3BPZUND?=
 =?utf-8?B?YkJ0TGRpRUEvZFp2ay9TRDZLdVZKUnVVUE5FUEJQbkZEd0kzS0VmU1BrN2Mz?=
 =?utf-8?B?enI1ZU56K2ZnYlhIWVBpbjBiNWxvZFlnVFAyTzFoUEFvYVE9PQ==?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 408ea85a-30eb-4ccf-80d7-08de85feef2a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 21:31:51.5967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR19MB5264

On Thu, Mar 19, 2026 at 07:55:19PM +0000, Jean-Baptiste Maneyrol wrote:
> >
> >________________________________________
> >From: Chris Morgan <macroalpha82@gmail.com>
> >Sent: Thursday, March 19, 2026 19:29
> >To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> >Cc: andy@kernel.org <andy@kernel.org>; nuno.sa@analog.com <nuno.sa@analog.com>; dlechner@baylibre.com <dlechner@baylibre.com>; jic23@kernel.org <jic23@kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; linux-rockchip@lists.infradead.org <linux-rockchip@lists.infradead.org>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>; heiko@sntech.de <heiko@sntech.de>; conor+dt@kernel.org <conor+dt@kernel.org>; krzk+dt@kernel.org <krzk+dt@kernel.org>; robh@kernel.org <robh@kernel.org>; andriy.shevchenko@intel.com <andriy.shevchenko@intel.com>; Chris Morgan <macromorgan@hotmail.com>
> >Subject: [PATCH v2 0/5] Add Invensense ICM42607
> > 
> >From: Chris Morgan <macromorgan@ hotmail. com> Add support for the ICM42607 IMU. This sensor shares the same functionality but a different register layout with the existing ICM42600. This driver should work with the ICM42607 and ICM42607P
> >ZjQcmQRYFpfptBannerStart
> >This Message Is From an Untrusted Sender
> >You have not previously corresponded with this sender.
> > 
> >ZjQcmQRYFpfptBannerEnd
> >From: Chris Morgan <macromorgan@hotmail.com>
> >
> >Add support for the ICM42607 IMU. This sensor shares the same
> >functionality but a different register layout with the existing
> >ICM42600.
> >
> >This driver should work with the ICM42607 and ICM42607P over both I2C
> >and SPI, however only the ICM42607P over I2C could be tested.
> >
> >Changes Since V1:
> > - Instead of creating a new driver, merged with the existing inv_icm42600
> >   driver. This necessitated adding some code to the existing driver to
> >   permit using a different register layout for the same functionality.
> > - Split changes up a bit more to decrease the size of the individual
> >   patches. Note that patch 0004 is still pretty hefty; if I need to split
> >   further I may need to create some temporary stub functions.
> > - Used guard() and PM_RUNTIME_ACQUIRE_AUTOSUSPEND() on the new functions
> >   per Jonathan's recommendations.
> >
> >Chris Morgan (5):
> >  dt-bindings: iio: imu: add icm42607
> >  iio: imu: inv_icm42600: Add support for using alternate registers
> >  iio: imu: inv_icm42600: Add registers for icm42607
> >  iio: imu: inv_icm42600: Add support for icm42607
> >  arm64: dts: rockchip: Add icm42607p IMU for RG-DS
> >
> > .../bindings/iio/imu/invensense,icm42600.yaml |   4 +
> > .../dts/rockchip/rk3568-anbernic-rg-ds.dts    |  20 +-
> > drivers/iio/imu/inv_icm42600/inv_icm42600.h   | 333 +++++++-
> > .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 497 ++++++++++-
> > .../imu/inv_icm42600/inv_icm42600_buffer.c    | 240 +++++-
> > .../imu/inv_icm42600/inv_icm42600_buffer.h    |   5 +
> > .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 795 +++++++++++++++---
> > .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 379 ++++++++-
> > .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |  53 +-
> > .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  59 +-
> > .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  64 ++
> > .../iio/imu/inv_icm42600/inv_icm42600_temp.h  |   4 +
> > 12 files changed, 2289 insertions(+), 164 deletions(-)
> >
> >-- 
> >2.43.0
> >
> >
> 
> Hello Chris,
> 
> thanks for the patch, but beware that there is a major difference between this
> chip and inv_icm42600 chips family that is preventing to have a common driver.
> 
> inv_icm42600 chips are using direct register access with bank while icm42607
> chip is using indirect register access using IREG specific registers. Some
> registers cannot be read/write directly and requires programming specific
> registers. The mechanism is similar to the one in inv_icm45600 driver, you can
> have a look in this driver.

I didn't see anything in the datasheet for the 42607P in regards to the IREG,
but I did see something in the 42607C. That said, near as I can tell from the
drivers that I used as a reference from the Rockchip and Lineage trees this driver
doesn't access anything from those registers.

Still, I'll defer to you on what you think is best. As long as I can use my
accelerometer that's all I care about.

> 
> Using the same driver is not possible I think, since register access is different.
> 
> And there are also more differences between the 2 chip families that is making
> a common driver quite difficult to do.
> 
> Thanks,
> JB

Chris
