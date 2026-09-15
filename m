Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013042.outbound.protection.outlook.com [52.103.14.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F14398F2;
	Tue, 15 Sep 2026 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493288; cv=fail; b=BW9OukwaEPGiGnfPtXPmGi2ujfd6XCnrLwbcuUfChLoES9GqcZTGgpWV6sni7NHcq3QttVxHBqJCSNKClwtbz+h1s/LFLoZl0Msm2RyJYms58RDV6ACRlpg3Up81nSIoNs+HQ2/KiTEmcJK5cbjVjll5eEzulnIJshrqcCel0x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493288; c=relaxed/simple;
	bh=F3uKTxw9Gez1ipEONS2+VscOFVGx1/YXwcuBXyQKVmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QWKZXPjcsjn38PvTR5eaOx+FdWlgXCSRKjkxNmlOtgy7XiBxGfC/U6UuPidzn1RZXFIR/S4NxTe0Kl0eImhoVuD2jqL41dWPm3NuoQE+IVPPDfBptLHXeCwQrcHH0FLf3dYHbjj6flt7OtB0gs4f2uQzW8j1Pf0+9U+oaHXM460=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=fail (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=DDB9ihVI reason="signature verification failed"; arc=fail smtp.client-ip=52.103.14.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="DDB9ihVI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAZ1GvFnzUgF5qdK8uSOFw+srzLyJ7+2r1pCRdILEetITTRsSA7clQHDu436HZBsYdyDpHb5aryZ9wc8xWHrZQk61TH8rXskiTE1kGvD9qCHbCKcXWUEbfg+VenaZ0hIS/fXWRT7WqiONbsBEtPLiojJ8L1FV9346Zvn1UeebDJTeODD8jp2GVu2yU0Z0Q6yHmV5Vh8CJGeucKcZXKQgVLe4QAZls/5yn66nrdlP1p6JIgokq/0rd+boj2yt6yIWIGCpzfQ1FvoEcCPqrMuXCYYUfeWZjT4suFKzVTAOPdb8uNkb5chzU2XkHxEdFarXqIIFnMvaioWU+qGj6mwiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4mS64McIea7BSRofMSmZtItBDhZP9uh6E7XzTIYQmg=;
 b=Md4ctbMH2KtrIfQAl7eS/IyTB/+4/O5NjQ+GeUXDLVwm9niQcaBdBo7UaFpnhfTbwjBbFGrBBqGYwV1wqyr3el1kK5tERmO3saRbtPnlzodTvCJALj+PIyWeIwzAL+ZtyykFMZCrD5ZdloVBNszQjZpEh2MLfeoTBYMuBef8PYneibLD9nuT7SOZ/wNpXzsUD5ySWtSDqhEnkEA9mz4sEhZIHTWsU2gESfdLCQiMeOHaA9GW3+G9okJ9SopP1MAM7Ak8254FzLfAHmvb77KPRI90PsOQ90OwjMQaoBGIcQVS835NlifJn7XOS4Fwr+ZkOOOF8TUIbBqx2td4T85yHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4mS64McIea7BSRofMSmZtItBDhZP9uh6E7XzTIYQmg=;
 b=DDB9ihVI+OE5rPrRxwJfYItdMOIr2VBlJ9wduIwoYPBgtMBkNsl+cf7ZOzs6d1xECYsVt/j5WrfELXw3z+Zh1MmRGJNPcxLoAw0++ZaxhgnbAUA69Ft33QmHGcyEEQO5R9ingMxnHs2gMnqt7p2wQLCqbAyKy58G2TkqL80kRo9FlHHcOzZoh8+CneGLIMItKLg2tkKKFTJuJU0Br74BaSGfdRTH+g+K+Z/iCw/nVl+9s4Fe/DTkIHDAZR/R4Y8V9SdcobrVf34eSlUjFzVlyT2zlo88DaycZKCwcbnYWk4TeBUgNd681IIaovJUT/nU82IPRoEYFEUlqeCofw8wdg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SN7PR19MB8142.namprd19.prod.outlook.com
 (2603:10b6:806:260::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 17:28:01 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 17:28:01 +0000
Date: Tue, 15 Sep 2026 12:27:57 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
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
Subject: Re: [PATCH v3 7/8] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Message-ID:
 <PH0PR19MB9973387A54F1734E51312C4C92A5BA2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
 <20260901-b4-inv_icm42370p-v3-7-77cc31642115@axis.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901-b4-inv_icm42370p-v3-7-77cc31642115@axis.com>
X-ClientProxiedBy: SN7PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:806:121::21) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <aqmAHZaeZGCwjY3t@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SN7PR19MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f69881-fbd4-4d37-15cc-08df134eb11d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|19110799012|23021999003|8060799015|5072599009|6090799003|4140399003|25010399006|51005399006|37011999003|24021099003|41001999006|25031999004|3412199025|4302099013|440099028|1602099012|10035399007|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Eq4el5zbzc8Hkj6FcLd1d2IZy1DwQwz1jQRFPgb7D2Y85/jgHQZLnJ3BQr?=
 =?iso-8859-1?Q?UPF54n6Prn4pYaw+Xvc0CfLXM5c01/xoR4doJBVOn6HRUSiBdhBD+W9QAF?=
 =?iso-8859-1?Q?qqjVgH089cvDW3CtV17J+p2SEDGT3vbo1DMv7WN4Lm22Kl/C0aVV3YbrdO?=
 =?iso-8859-1?Q?sWnqklZtxl85OfhTSGXY8enWHQqDcbdAD5oc2BZ1fq5PqP3VAkh0oSp/7r?=
 =?iso-8859-1?Q?+xaWDZe1RVeoadjoUouIEIaWy2QcdKQAGsv0b8E3qdl+saKbjVHop3ta4G?=
 =?iso-8859-1?Q?WGdwHWQAtzHBkawrk3q4+ztxQvtmEocJCB7JGtPXakQVjV7xM5icp2qKE6?=
 =?iso-8859-1?Q?L6+BqB0GcdfqiKu17lXSwllSR5hWZSJNqkwbN2PPfrQgIxC7OC2uZR53kk?=
 =?iso-8859-1?Q?KRn74VH1bUS/vQJb089p35vsh6YhM+lxfpSPpcWSdYWzahmB1hihi2Yr3X?=
 =?iso-8859-1?Q?Q6c/MsOcmkgogzAxXVlpnIlAUJrm/z/kicPBv8gYL/LSi6ySmCmXQ1Jzuc?=
 =?iso-8859-1?Q?6jrW/o0le56j4iGUb6EZR2SLRDBBeX/WHu4DfFbJocX3gO6HBub+EpkI/8?=
 =?iso-8859-1?Q?O3Ql/VRdWSg7sYI4dWoQ3nOdr5FlVUl0URFxnaLhYkuHWqActS2pr25213?=
 =?iso-8859-1?Q?QQssI3E2BLnD9DfBvMi1xwE8koWdey9ZkZBXFg2UYpppCnJ5KX1RrVexZo?=
 =?iso-8859-1?Q?CWiNsdEd2VcEcCz/g7N9AG7MrAVZ8oxuQSv8wnKIjEz9T22pOo4U0IuOuK?=
 =?iso-8859-1?Q?PvcAd5mVMP3ry5xTwa6Ek7ItoJUq1IWw671wGdLrMi2Tlm5k5OxfeZuNeQ?=
 =?iso-8859-1?Q?ikOfb7f9pUK/ndGvhNpnNtdzalcoBeWkWWD7EIVK8Q6oFK9U58IiEWPBpn?=
 =?iso-8859-1?Q?KuFMyFKBNUOYsIVWaIOgdNYHo0AC0bumfASVIvH30w4WiJ8w2kFAYuwhwJ?=
 =?iso-8859-1?Q?CaY4mVWgDXl+MQ9S0B+buqUHqHcAks/y7D8RbmwyF4k1GwcGNXKOgRVEfv?=
 =?iso-8859-1?Q?B74bt5akOmek3T9BBz8ZKA3+iPvnZEqHmCXdWV9tn9BCleX008l9u8IeTQ?=
 =?iso-8859-1?Q?A2wzmvK0yQpmEzc//qIo09vkx5GdHZq4RNmwnth6lwW4R7Tf0Co46z0n6u?=
 =?iso-8859-1?Q?s5i0WrgDAmQaQkCbvAwFSinj8OC7Q=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?4TYqSXVxGRcVcOEV14tgT4KkBWSwDBJZfUovMZlpLlexf9WFg2m0Qx7zwy?=
 =?iso-8859-1?Q?2FHnTiHPToyPDmTphmCVbTLwAQBQ2BvC85WQSQ8wtafhtmt6KjrO0dBegB?=
 =?iso-8859-1?Q?hv/YAWSNZwk90F50LSrvbvED0MNfyhurLP6FLIbFWTIXL8tdR/7KM+cXns?=
 =?iso-8859-1?Q?b3ZyLQl49sdImIle4fpS9yR+Ov6eY1yuNwT8dkWzvJPoc1lKUoA9q6HYMJ?=
 =?iso-8859-1?Q?4/LUnBEtwJMIp2AgObPr25hbyotUd6Ptz2OD48L0ApapTVKgM63NVo8T3D?=
 =?iso-8859-1?Q?4mJ6LJgu6CQ4qbcfF4usF/HX8UOBGkHLeFDiiN9jmfL2ORvrcerPm83UcW?=
 =?iso-8859-1?Q?iA8+yN7J+EdXnxPTmdZw4iut/yH0QB0+0h4njlCwXK5x66NP1FBPhMwZzT?=
 =?iso-8859-1?Q?iQKXIJexUmV+00RAQKjIM10LmWeOmiHBn2RNhiaURDSGzrGd5gXdlVcoz9?=
 =?iso-8859-1?Q?aIZE6r/y389dHmXrSXU+v4AU3Bl5t6LZhqhhaYwNpVeJW/oquOPweFelmI?=
 =?iso-8859-1?Q?vvG0h7R8Jj3iQ99mwQ6lDZTmFMkOpY2Afn8CATUncBOHzG7GpdpSLh99CL?=
 =?iso-8859-1?Q?HNdmAoRebDzeGsiU554fBI+6Wm0/fAcAHOyFp9/GwwdZSiO80jEUFb6raO?=
 =?iso-8859-1?Q?MlXHJk1n1G5/1CB9G5V54vdpF5csoK6rwDRCGkaVpR46v9BshmzI3njZ+K?=
 =?iso-8859-1?Q?P3cF8r6XPPpMxKU0R+ejWfFK1Vm733291zORLqUnvXnrR2L6w2Y/TI7BxZ?=
 =?iso-8859-1?Q?fJ0nLir8ihnga7sfaAzybtPkyZK2CyRi4WmqVAOvbZEdVQs8mD0x0JzTr2?=
 =?iso-8859-1?Q?Wkk4SOz2BFCVh16ImeVdlU90RMFZMz0JEzSlXsJkOsWwU+PlAps1VyJcuj?=
 =?iso-8859-1?Q?ehzMLuMm+QYv6HLVnwU+/xprpuMywCdtTcmhy/3R5zkWrOnpSqXge7kz/0?=
 =?iso-8859-1?Q?r0wMz+hF70zITmSUSgDnsOsmamZPuzhgr2T1IoPyge1JztEUIEi/XBfpe/?=
 =?iso-8859-1?Q?SaVcrhyJ+v72jzMmKY2Q14N8IllbH4oBfw3NXJxrEN2jCEBEIt37gST/ZI?=
 =?iso-8859-1?Q?oWGLcByPPa4dUkL4qLNTkRt412/QtobXZZLm73CS/Sf4t2l3jVzMKN6nI+?=
 =?iso-8859-1?Q?EJeVPqXN5BpC6w2lzDJyxDgrvMx9qQDL2IVfBTjG1Pr6SjibCIqOebywF9?=
 =?iso-8859-1?Q?Y0kWs9iMqgTbSkTPRAyDFUUAbf7tsmYS41EULXPUSBgT1IASHYsRxXB6dh?=
 =?iso-8859-1?Q?Cfye0+rZ42tWL1Tp0dJ9HTA/BvZJOvNv182QvuWCVbf+j8UCroajWbbQ9s?=
 =?iso-8859-1?Q?CxmKOI60ERKYy192nFdCnSdiw68R3nzFDCXZZy8u5n9WAiKmgowx1E+9bJ?=
 =?iso-8859-1?Q?ZlecmlLighKNCvMquB+2w04iR/kimQ1i/qfdAGEYhKhuz6L5rh9uwMQm8s?=
 =?iso-8859-1?Q?8UxL+hVOzwI9jIu0?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f69881-fbd4-4d37-15cc-08df134eb11d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 17:28:01.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB8142

On Tue, Sep 01, 2026 at 04:36:00PM +0200, Kanak Shilledar wrote:
> Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
> registers are stored in MREG1, which can be accessed by the mreg_read
> and mreg_write routines. The calibration bias is written to OFFSET_USER4
> to OFFSET_USER8 registers in MREG1.
> 
> Note: The accelerometer functionality is tested with Invensense,
> ICM42370-P development board.
> 
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c | 238 +++++++++++++++++++++-
>  1 file changed, 236 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> index 318373efeb9e..af2ac9d6a47c 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> @@ -13,6 +13,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/types.h>
> +#include <linux/units.h>
>  
>  #include "inv_icm42607.h"
>  #include "inv_icm42607_temp.h"
> @@ -22,9 +23,11 @@
>  	.type = IIO_ACCEL,							\
>  	.modified = 1,								\
>  	.channel2 = _modifier,							\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS),					\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
> -	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |	\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS),					\
>  	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
>  	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>  	.scan_index = _index,							\
> @@ -56,6 +59,16 @@ static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
>  	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
>  };
>  
> +/*
> + * Calibration bias values, IIO range format int + micro.
> + * Value is limited to +/-1g coded on 12 bits signed. Step is 0.5mg.
> + */
> +static int inv_icm42607_accel_calibbias[] = {
> +	-10, 42010, /* Min : -2^11 * 0.0005 * 9.80665	   = -10.042010 m/s²	*/
> +	  0,  4903, /* Step: 0.5 * 0.00980655		   = 0.004903 m/s²	*/
> +	 10, 37106, /* Max : (2^11 - 1) * 0.0005 * 9.80665 = 10.037106 m/s²	*/
> +};
> +

For whatever it's worth, when I read the calibbias values for my board
from sysfs after applying this patch I get 0.000000 for
in_accel_x_calibbias (or y or z) and in_accel_calibbias_available gives
me an -EINVAL.

But the accelerometer still seems to output data corresponding to the
correct orientation.

Thank you,
Chris

>  static const int inv_icm42607_accel_scale_nano[][2] = {
>  	[INV_ICM42607_ACCEL_FS_16G] = { 0, 4788403 },
>  	[INV_ICM42607_ACCEL_FS_8G] = { 0, 2394202 },
> @@ -176,6 +189,221 @@ static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
>  	return inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);
>  }
>  
> +static int inv_icm42607_accel_read_offset(struct inv_icm42607_state *st,
> +		struct iio_chan_spec const *chan, int *val, int *val2)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	u8 buffer_data[2];
> +	unsigned int reg;
> +	s16 offset;
> +	s64 val64;
> +	s32 bias;
> +	int ret;
> +
> +	if (chan->type != IIO_ACCEL)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg = INV_ICM42607_REG_OFFSET_USER4;
> +		break;
> +	case IIO_MOD_Y:
> +		reg = INV_ICM42607_REG_OFFSET_USER6;
> +		break;
> +	case IIO_MOD_Z:
> +		reg = INV_ICM42607_REG_OFFSET_USER7;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1, reg, &buffer_data[0]);
> +	if (ret)
> +		return ret;
> +
> +	ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1, reg + 1,
> +				     &buffer_data[1]);
> +	if (ret)
> +		return ret;
> +
> +	/* 12 bits signed value */
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		offset = sign_extend32(((buffer_data[0] & 0xF0) << 4) | buffer_data[1], 11);
> +		break;
> +	case IIO_MOD_Y:
> +		offset = sign_extend32(((buffer_data[1] & 0x0F) << 8) | buffer_data[0], 11);
> +		break;
> +	case IIO_MOD_Z:
> +		offset = sign_extend32(((buffer_data[0] & 0xF0) << 4) | buffer_data[1], 11);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Convert raw offset to g then to m/s²
> +	 * 12 bits signed raw step 0.5mg to g: 5 / 10000
> +	 * g to m/s²: 9.806650
> +	 * Result in micro (1000000)
> +	 * (offset * 5 * 9.806650 * 1000000) / 10000
> +	 */
> +	val64 = (s64)offset * 5LL * 9806650LL;
> +	/* For rounding, add + or - divisor (10000) divided by 2 */
> +	if (val64 >= 0)
> +		val64 += 10000LL / 2LL;
> +	else
> +		val64 -= 10000LL / 2LL;
> +
> +	bias = div_s64(val64, 10000L);
> +	*val = bias / (long)MEGA;
> +	*val2 = bias % (long)MEGA;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int inv_icm42607_accel_write_offset(struct iio_dev *indio_dev,
> +					   struct iio_chan_spec const *chan,
> +					   int val, int val2)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	u8 hi, lo, regval;
> +	s32 min, max;
> +	s16 offset;
> +	s64 val64;
> +	int ret;
> +
> +	if (chan->type != IIO_ACCEL)
> +		return -EINVAL;
> +
> +	/* inv_icm42607_accel_calibbias: min - step - max in micro */
> +	min = inv_icm42607_accel_calibbias[0] * (long)MEGA -
> +	      inv_icm42607_accel_calibbias[1];
> +	max = inv_icm42607_accel_calibbias[4] * (long)MEGA +
> +	      inv_icm42607_accel_calibbias[5];
> +
> +	val64 = (s64)val * (s64)MEGA;
> +	if (val >= 0)
> +		val64 += (s64)val2;
> +	else
> +		val64 -= (s64)val2;
> +
> +	if (val64 < min || val64 > max)
> +		return -EINVAL;
> +
> +	/*
> +	 * Convert m/s² to g then to raw value
> +	 * m/s² to g: 1 / 9.806650
> +	 * g to raw 12 bits signed, step 0.5mg: 10000 / 5
> +	 * val in micro (1000000)
> +	 * val * 10000 / (9.806650 * 1000000 * 5)
> +	 */
> +	val64 = val64 * 10000LL;
> +
> +	/* For rounding, add + or - divisor (9806650 * 5) divided by 2 */
> +	if (val64 >= 0)
> +		val64 += 9806650 * 5 / 2;
> +	else
> +		val64 -= 9806650 * 5 / 2;
> +	offset = div_s64(val64, 9806650 * 5);
> +
> +	/* Clamp value limited to 12 bits signed */
> +	if (offset < -2048)
> +		offset = -2048;
> +	else if (offset > 2047)
> +		offset = 2047;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		/* OFFSET_USER4 register is shared */
> +		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
> +				INV_ICM42607_REG_OFFSET_USER4, &regval);
> +		if (ret)
> +			return ret;
> +
> +		hi = ((offset & 0xF00) >> 4) | (regval & 0x0F);
> +		lo = offset & 0xFF;
> +
> +		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
> +				INV_ICM42607_REG_OFFSET_USER4, hi);
> +		if (ret)
> +			return ret;
> +
> +		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
> +					      INV_ICM42607_REG_OFFSET_USER5, lo);
> +
> +		if (ret)
> +			return ret;
> +		break;
> +
> +	case IIO_MOD_Y:
> +		/* OFFSET_USER7 register is shared */
> +		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
> +					     INV_ICM42607_REG_OFFSET_USER7,
> +					     &regval);
> +		if (ret)
> +			return ret;
> +
> +		lo = offset & 0xFF;
> +		hi = ((offset & 0xF00) >> 8) | (regval & 0xF0);
> +
> +		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
> +					      INV_ICM42607_REG_OFFSET_USER7,
> +					      hi);
> +		if (ret)
> +			return ret;
> +
> +		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
> +					      INV_ICM42607_REG_OFFSET_USER6,
> +					      lo);
> +		if (ret)
> +			return ret;
> +		break;
> +
> +	case IIO_MOD_Z:
> +		/* OFFSET_USER7 register is shared */
> +		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
> +					     INV_ICM42607_REG_OFFSET_USER7,
> +					     &regval);
> +		if (ret)
> +			return ret;
> +
> +		hi = ((offset & 0xF00) >> 4) | (regval & 0x0F);
> +		lo = offset & 0xFF;
> +
> +		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
> +					      INV_ICM42607_REG_OFFSET_USER7, hi);
> +		if (ret)
> +			return ret;
> +
> +		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
> +					      INV_ICM42607_REG_OFFSET_USER8, lo);
> +		if (ret)
> +			return ret;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
>  				       struct iio_chan_spec const *chan,
>  				       int *val, int *val2, long mask)
> @@ -207,6 +435,8 @@ static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
>  		return inv_icm42607_accel_read_scale(indio_dev, val, val2);
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		return inv_icm42607_accel_read_odr(st, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return inv_icm42607_accel_read_offset(st, chan, val, val2);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -250,6 +480,8 @@ static int inv_icm42607_accel_write_raw(struct iio_dev *indio_dev,
>  		return ret;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		return inv_icm42607_accel_write_odr(indio_dev, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return inv_icm42607_accel_write_offset(indio_dev, chan, val, val2);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -266,6 +498,8 @@ static int inv_icm42607_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT_PLUS_NANO;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
> 
> -- 
> 2.43.0
> 
