Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010000.outbound.protection.outlook.com [52.103.12.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433454A1E0D;
	Tue, 15 Sep 2026 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492854; cv=fail; b=j0Ni+SeeW+HB7TY+mfhJkU2yuulaG4PmvqJ1F/COyC/qwvUN+DdK+o7eLBFp8SH8UQpQ6C0Z43U2MiX+QzqC94WG4MMKyAJS1RLf3aLvJBtm5pDF46jqaCpWlG6eltxmLhE4b2xEqvBXDp+4mWRd4ncDublVmXng7Kprawd0w2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492854; c=relaxed/simple;
	bh=IhFME5BnrE/6yA43ILXwQakGVR42fPuNJkt8ysm5D50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Djn0JR8z7rCD60kdDee/ybQ9EoRTh56SSi1NbIzFO3y1OrcFnx8/9lkew/tOXYl7uGCRmrdkVEMApnhtOyZfZFwkfVMAKgC8wMVZJdD+Du0Mc+Fn2VZqFEJKNfDulWehIHniu+2iHeS9Guq6wA+xkObNXYVZkMg6dysAvEPfasQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ckZIEPNm; arc=fail smtp.client-ip=52.103.12.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ckZIEPNm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVgZGmwtLGq/yjBF3n7fY21WFzZCtm5ia+abf7AYQXmKDEluRUxR3du74Q+c+yuDGqJ56AGIsLe3NzCGXYStiwEDwf/KvATqyeX6h01xF6u0mPo70uQX9SCPcSdR+mVlUY1OjxT3gxNCvxuzxg+dpn+53m7dH4baBXOoMPNvENrTqZgC+CAWRVNs/qF4MexH6Oi2zXGK4SAM4FzPmZ6wOGnN42MTQwT5yadTu3bcwG2zTC4e0fBAD4hbDp/7dKpckE4P5vAuP8/OOJIJrxMS9FwGUAF/ntZEJFmRV+14tP6z5ogkbzLUMFn9G/oi4wHf/BDloDB2vYbjga06ekp+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VsK6rrt3KK3iDF8OcQoPim76E+waAtKVXvqGDG6ecA=;
 b=hlzlOhvcXB0tRFAePFXCC7AWlrHzJ+yIU8omoyc+HRyGnOIEviKr5QrYQBSM8PYpU2+1GExFlLuryFbbgQapicyL8I7TKgg6W7EQBkPz+RJzyWo5UxpSmjH5qcf5l25ZpF4Ai1jiXjQDpysxExURO8uwAJi+ZTpopDYDqzf6rpc+ORsZdM04e/NSFjFQy5aJXhF3HDcy0E8GaDeWPH3DvnnByXrdsTRCTe3JPAUh74tlbw0+AYezF92krxktXsgmgRCFRkQ53IMsPlk08vsJ958XzuWzllntey02u4OGYtIMb9uCHMTlL82d8Ij1quC/f7n2YeBZXZPhTsuPLgRlEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VsK6rrt3KK3iDF8OcQoPim76E+waAtKVXvqGDG6ecA=;
 b=ckZIEPNmAzwTqzHjtsrUTpJTiLSJHurQttytPeqAw29V9E8KD9J5CCoPeQ2YqpcH1icUNZ0sc2AQKe4OhNDXW/Z2RRPtFf29rF6Ht9xIz5bjKxr7U/yA0S4CVcHhazSrCkf+iv0UU6nBpc0uh6kaiMDIUzbtp7RLjGPOGuaGtfHWElbraMcs9VNRkqHD0os4SvLAt3jP9W+SHjgPf98ByguUOx18cAfpSy5ve1FI9wzDDeX0NsdelVRvTiC2BWvi1MSgjQHDWLrHeV9isW83FKd5R/HQiJEqjKKk5NlsVy7ocrqwYM7V9u36tGlwJaGu0YI18p3ZWLN82yYbcSYAqQ==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SA1PR19MB7160.namprd19.prod.outlook.com
 (2603:10b6:806:2b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 17:20:49 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 17:20:49 +0000
Date: Tue, 15 Sep 2026 12:20:46 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kanak Shilledar <kanak.shilledar@axis.com>,
	Henrik Grimler <henrik.grimler@axis.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] iio: imu: inv_icm42607: Update _odr_to_period_us
 formatting
Message-ID:
 <PH0PR19MB997338A79A8E6DEE464AC775E3A5BA2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
 <20260901-b4-inv_icm42370p-v3-3-77cc31642115@axis.com>
 <178874609181.3402141.11177384276502703798.b4-review@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178874609181.3402141.11177384276502703798.b4-review@b4>
X-ClientProxiedBy: SA1PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::11) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <aql-bkycMo36Qr9h@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SA1PR19MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: a0292170-7e63-4dc7-c9b4-08df134daf9f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|21061999006|6090799003|5072599009|19110799012|24021099003|15080799012|25031999004|37011999003|51005399006|23021999003|25010399006|4140399003|8060799015|3412199025|440099028|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mwc8DDgQJBfWWwyPhEeMN6uBnOxEsQ7Qq6bGhkdBkrwYUfbb7GhmZwM0iU/y?=
 =?us-ascii?Q?xDGRbNU7jR5J+tPeZJ1E5fS3qfZC7EOXy7vUihju/th7cjIkvtAk2CnneudU?=
 =?us-ascii?Q?8vBPEIjEf43lM2Z8CLHSXfXNquw5ZCOTthUHGTSju3OgSZz2O5ragENiUmPf?=
 =?us-ascii?Q?35y/RbwI5JFdIXTldLQ78kcWRGLm/x6FPxQcyRtaozNVlyfKKVp7jPPxyX4w?=
 =?us-ascii?Q?v+xi3wbkG/xnR8BwWgQSbb/5IBu4n+RbKgCXGllf0D6m179G2F5zyZN0RIRV?=
 =?us-ascii?Q?FKXisH4YUNwqQ7zTzipWs1mcJgUdDC2Di8/cl1psVfzlfdOcxwpmLWqMEnMK?=
 =?us-ascii?Q?liNv9raIWgBuh6hDFGGWCmhcNz/0lgHkQulDD5MmDPpkUKR9ka/7dXUgEfrA?=
 =?us-ascii?Q?D4cgvDfG1SQffQXdLIqFdt0mZOO8w0G0T2nSXZG6w9fbWb08k+s4km/5N0jF?=
 =?us-ascii?Q?tOnjVk2cDymfJ/qEV7pRMrMFAd3GdwqPhU5mh7QmpCI6J42hShDDvyfnt6+f?=
 =?us-ascii?Q?WR9DnwE1/rurWFAXdxw03Kr+WQJFvQlBO8MJZncADcYWWDal4wYKhqpYHliZ?=
 =?us-ascii?Q?OxCu5KGGC/r2VzOQS5yiwYu/BzsiFVVo/m/MqfL4tvJx+3Vr3xsPzyUxsilK?=
 =?us-ascii?Q?lS7FlEUrDN1TsiG3WwRWBjH8MkAm+VrwMZlnAzS8IfkAmIvXbn8O3s4TPhmQ?=
 =?us-ascii?Q?F/Zwx/2+xQjNu+YyszK76c6xxMWbw0LjKGUmuarhf42zlJrU4/hmDe9pJNfK?=
 =?us-ascii?Q?tXT4TW4E7cct3vtOIdFk7XOHfo67BR8vLACbrcMM24ylNvNW6Ta4Ro8gwHyA?=
 =?us-ascii?Q?1+TUxODaODkhCuhABL3bt0p007RKZV581ZrMCYYBmBVvy6tbRPSOhaX8UZB4?=
 =?us-ascii?Q?a8tLrjApw67PLgVkHu/OoQcNOxil3JC4spZxSfATmwMYDJ7pLRW+LQNG3nx7?=
 =?us-ascii?Q?A2/OJcICOqwJHSXOY9BgBKb0mNdm007lOUx1HXc20PJx9zEj6Qjxjlk2FVMS?=
 =?us-ascii?Q?bs7lsNbBtWdMPzE1Iigz6ziLfPQ/u2SnMGQ748zyXOyWkAXhioypz8p0YCgP?=
 =?us-ascii?Q?AOzplArE?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lzb3k96XEoxh5D3mi6FrLvOP7XdH9Sbzr3wnmYadsH+ijMrLi+ySs+aK6dfl?=
 =?us-ascii?Q?mTk5vK9SRM1+jU3Yl7Sf998A+G0rDV5iKEWKvHXKGp+Zvt9tdXaKBw0awnoU?=
 =?us-ascii?Q?iI8G1TE9hIwuub2fGm9fIZ/BnORaIUjnhrT/ZvTJUMdjcTgq3a0v2hEMSlyv?=
 =?us-ascii?Q?RV9/N6JV1IrNYc182gKRgipX8INtqIrwJ6J9hp6UpQIG4S1MG95d4XzwcVQh?=
 =?us-ascii?Q?OjkH8wPLmE2NYPMdx82kehjgUx+3jVx8ALm2mWbtMCsXOs1091W4AXXdr3Gr?=
 =?us-ascii?Q?QYClyiUrXaM58VBqLUAw0dGrlc3wdMJycukksyZSzVD3v6l+hjpQsF2rMA2c?=
 =?us-ascii?Q?92tc7wYjgaqMR1slueJwSYHvLzvvXKhGxmL0vx/KAPUfBOONsBEj33lglXGH?=
 =?us-ascii?Q?WuMvQZJ42S2HPBJWG1yFnWTx9l3LofcgDeXOqMer5NduXfh24WEV7wlewd00?=
 =?us-ascii?Q?8jEWcjFdfgN4NuvmFfyk20oukSjo2insLiFQQ1Vy54CupUhvggUOpdvfwfGB?=
 =?us-ascii?Q?4ridUCOSCSVrXi+7Jk/Xu8KifZTPBrhYb5OHcuE4Y6tZVyBSMEVaA/mr6OH7?=
 =?us-ascii?Q?B62AAAJneBAYGwCafr8tYyx1OVWt9fBkrcW0zs9vRIR2DeugqcpptrQiAcfA?=
 =?us-ascii?Q?2UbLfaXdj7Ycb+XJZgwpNeNEsizDgXmRtyeLe/hW3M2JD9tVf95W6e4QczUD?=
 =?us-ascii?Q?2e7BU8Nw0KWXMiblAiMF+gZuml5szrF4pTincKQVeW0ggFtNHKINpjKSvUnh?=
 =?us-ascii?Q?6d3739gkhHaqLtWpXkG+uM8IjigWEqS+XiyNr9EOH2hPptpSIDxAXwsNo/8k?=
 =?us-ascii?Q?HpFeJzaCvekVQ0zpaepZGKE8q5O6stg3uEcTDTaKaQyacRIszZRTL2Q78zvF?=
 =?us-ascii?Q?ODgAuHiSaCazqmF+MM1z4E0H8toVwCQxFQybXn22qKAtDgLA4/BRyezWtO8v?=
 =?us-ascii?Q?fdVtUdIIYkysoNW+zsr+oP2GW93PCHLYtKJ0VPa2wjyiDB2x3stWMp5sgepq?=
 =?us-ascii?Q?1FjLj9Pn/16ivuDqeben2EbIswG+Qvirh7td8NSIEAsKgDiGxVhABqnxW3nL?=
 =?us-ascii?Q?CunfiHYCblTlMbI9tGqpx/Wn5Lj7nvSR4m2FCVPNgHPHN1tdwbGnz6cP9dAQ?=
 =?us-ascii?Q?UowE1g1IgkdsZe23HI2pBs3QEs/lu/QndF72Y0UfLw0UWUA/lCayeWQv/En/?=
 =?us-ascii?Q?yiMUWXyGEsUwVhzNqqwPXR2HPSmw/n9oDm25A0t5P4/EF4OrQiXUAR2ZmBkY?=
 =?us-ascii?Q?DVmznrVVdyvupJVU6Vv+uef3A/Z4R3fG2EomcqSRAfqp/wVovRK2ZOpDMqeJ?=
 =?us-ascii?Q?hMWxkNspASNmyIG3xo8e3cGIuAqk9Xj5wL6xTmaY+JnsdDvg9EM+TdAIW9EG?=
 =?us-ascii?Q?zHIMecn51vMSuzIVYaP8a7fitY1E?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a0292170-7e63-4dc7-c9b4-08df134daf9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 17:20:49.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB7160

On Mon, Sep 07, 2026 at 02:54:51AM +0100, Jonathan Cameron wrote:
> > Update the function formatting for the inv_icm42607_odr_to_period_us
> > function. This enhances the readability of the function and drop the
> > unnecessary comments in the array elements.
> The description doesn't mention the change I don't think is
> beneficial.  Which makes it even easier to drop that change.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> >
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > index 4d51b0da1aa1..fa85cf738cc0 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > @@ -62,16 +62,16 @@ enum inv_icm42607_accel_fs {
> >  /* ODR values  - Note Gyro does not support ODR less than 12.5Hz */
> >  enum inv_icm42607_odr {
> >  	INV_ICM42607_ODR_1600HZ = 5,
> > -	INV_ICM42607_ODR_800HZ = 6,
> > -	INV_ICM42607_ODR_400HZ = 7,
> > -	INV_ICM42607_ODR_200HZ = 8,
> > -	INV_ICM42607_ODR_100HZ = 9,
> > -	INV_ICM42607_ODR_50HZ = 10,
> > -	INV_ICM42607_ODR_25HZ = 11,
> > -	INV_ICM42607_ODR_12_5HZ = 12,
> > -	INV_ICM42607_ODR_6_25HZ_LP = 13,
> > -	INV_ICM42607_ODR_3_125HZ_LP = 14,
> > -	INV_ICM42607_ODR_1_5625HZ_LP = 15,
> 
> Why?  We often put all the values when they are mapping to hardware
> register values simply because it makes them easier to compare to
> a datasheet.
> 
> -- 
> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Just to provide context, the only reason I chose the byte order I did
is because that's how the existing icm42600 driver did it. I'm not
opposed to changing it especially if it simplifies things or makes
sense, but if we're going to do it now's the time (as the only current
consumer of this driver is the rk3568 based anbernic-rg-ds and the
rk3576 based anbernic-vita-pro).

Thank you,
Chris
