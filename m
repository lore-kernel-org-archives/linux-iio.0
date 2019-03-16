Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F68C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 15:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4ED21900
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 15:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552748799;
	bh=Z9GAQlCR4UMnM8SAZ2M2zW94XkVLQMxhntTIKge/uS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DD5NRYM4gYiAgrLBqhdq3se2bQYa+coXPQTUhrVZQ2fhGEq1gyrtSXAtobY28LLtA
	 IExHMZbQt8gCApBuzk0pveZGNrQRo2mmwGvNGsFt6BUH4K3dOxdxORHWtvF+x1dQ3I
	 WLg/o7UI5JtSeFfWB3ffgyNjLs+8ygQ0/G7npOFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfCPPGj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfCPPGi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Mar 2019 11:06:38 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822E4218E0;
        Sat, 16 Mar 2019 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552748797;
        bh=Z9GAQlCR4UMnM8SAZ2M2zW94XkVLQMxhntTIKge/uS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N4heyLV1I0tPykKJGsWM67s7ouW48xd8Hb06y7uEwpLjEKSH03QobfVysGeCIgszQ
         P+8GYHkJnrEJhVZmYLUCmFD1up5PmH4cZidA+Bg1geRxxbcFb1F1hc5SrqZx1m+Vn1
         X2+DIUKCT8uOFRbyj8w8TVTTGzw9Cic4vHI9lmeo=
Date:   Sat, 16 Mar 2019 15:06:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis CIOCCA <denis.ciocca@st.com>
Cc:     Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/2] iio: accel: add support to LIS2DE12
Message-ID: <20190316150632.716aedde@archlinux>
In-Reply-To: <4e7c32c8a3d74636a6bf5e82d8fa4b72@SFHDAG2NODE1.st.com>
References: <20190305203252.13647-1-rjones@gateworks.com>
        <20190305203252.13647-3-rjones@gateworks.com>
        <4e7c32c8a3d74636a6bf5e82d8fa4b72@SFHDAG2NODE1.st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 9 Mar 2019 01:14:21 +0000
Denis CIOCCA <denis.ciocca@st.com> wrote:

> Acked-by: Denis Ciocca <denis.ciocca@st.com>
Applied with the minor tweak to drop the -accel postfix.

Thanks,

Jonathan

> 
> Thanks,
> Denis
> 
> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> On Behalf Of Robert Jones
> Sent: Tuesday, March 5, 2019 12:33 PM
> To: Jonathan Cameron <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org; linux-iio@vger.kernel.org; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Robert Jones <rjones@gateworks.com>
> Subject: [PATCH 2/2] iio: accel: add support to LIS2DE12
> 
> Add support to STMicroelectronics LIS2DE12 accelerometer in st_accel framework.
> 
> http://www.st.com/resource/en/datasheet/lis2de12.pdf
> 
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  drivers/iio/accel/Kconfig         |  2 +-
>  drivers/iio/accel/st_accel.h      |  2 ++
>  drivers/iio/accel/st_accel_core.c | 76 +++++++++++++++++++++++++++++++++++++++
>  drivers/iio/accel/st_accel_i2c.c  |  5 +++
>  4 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig index 898839c..ffd0b4d 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -223,7 +223,7 @@ config IIO_ST_ACCEL_3AXIS
>  	  Say yes here to build support for STMicroelectronics accelerometers:
>  	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
>  	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL,
> -	  LNG2DM, LIS3DE
> +	  LNG2DM, LIS3DE, LIS2DE12
>  
>  	  This driver can also be built as a module. If so, these modules
>  	  will be created:
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h index fd53258..753a5671 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -34,6 +34,7 @@ enum st_accel_type {
>  	LIS3LV02DL,
>  	LIS2DW12,
>  	LIS3DHH,
> +	LIS2DE12,
>  	ST_ACCEL_MAX,
>  };
>  
> @@ -57,6 +58,7 @@ enum st_accel_type {
>  #define LIS2DW12_ACCEL_DEV_NAME		"lis2dw12"
>  #define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
>  #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
> +#define LIS2DE12_ACCEL_DEV_NAME		"lis2de12_accel"
>  
>  /**
>  * struct st_sensors_platform_data - default accel platform data diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 9930edf..aebd611 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -831,6 +831,82 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.multi_read_bit = false,
>  		.bootime = 2,
>  	},
> +	{
> +	.wai = 0x33,
> +	.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +	.sensors_supported = {
> +		[0] = LIS2DE12_ACCEL_DEV_NAME,
> +	},
> +	.ch = (struct iio_chan_spec *)st_accel_8bit_channels,
> +	.odr = {
> +		.addr = 0x20,
> +		.mask = 0xf0,
> +		.odr_avl = {
> +			{ .hz = 1, .value = 0x01, },
> +			{ .hz = 10, .value = 0x02, },
> +			{ .hz = 25, .value = 0x03, },
> +			{ .hz = 50, .value = 0x04, },
> +			{ .hz = 100, .value = 0x05, },
> +			{ .hz = 200, .value = 0x06, },
> +			{ .hz = 400, .value = 0x07, },
> +			{ .hz = 1600, .value = 0x08, },
> +			{ .hz = 5376, .value = 0x09, },
> +		},
> +	},
> +	.pw = {
> +		.addr = 0x20,
> +		.mask = 0xf0,
> +		.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> +	},
> +	.enable_axis = {
> +		.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
> +		.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
> +	},
> +	.fs = {
> +		.addr = 0x23,
> +		.mask = 0x30,
> +		.fs_avl = {
> +			[0] = {
> +				.num = ST_ACCEL_FS_AVL_2G,
> +				.value = 0x00,
> +				.gain = IIO_G_TO_M_S_2(15600),
> +			},
> +			[1] = {
> +				.num = ST_ACCEL_FS_AVL_4G,
> +				.value = 0x01,
> +				.gain = IIO_G_TO_M_S_2(31200),
> +			},
> +			[2] = {
> +				.num = ST_ACCEL_FS_AVL_8G,
> +				.value = 0x02,
> +				.gain = IIO_G_TO_M_S_2(62500),
> +			},
> +			[3] = {
> +				.num = ST_ACCEL_FS_AVL_16G,
> +				.value = 0x03,
> +				.gain = IIO_G_TO_M_S_2(187500),
> +			},
> +			},
> +	},
> +	.bdu = {
> +		.addr = 0x23,
> +		.mask = 0x80,
> +	},
> +	.drdy_irq = {
> +		.addr = 0x22,
> +		.mask_int1 = 0x10,
> +		.mask_int2 = 0x00,
> +		.addr_ihl = 0x25,
> +		.mask_ihl = 0x02,
> +		.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
> +	},
> +	.sim = {
> +		.addr = 0x23,
> +		.value = BIT(0),
> +	},
> +	.multi_read_bit = true,
> +	.bootime = 2,
> +	},
>  };
>  
>  static int st_accel_read_raw(struct iio_dev *indio_dev, diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index de8ae43..cb6eb6f 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -102,6 +102,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lis3de",
>  		.data = LIS3DE_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lis2de12-accel",
> +		.data = LIS2DE12_ACCEL_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_accel_of_match); @@ -140,6 +144,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  	{ LIS3LV02DL_ACCEL_DEV_NAME },
>  	{ LIS2DW12_ACCEL_DEV_NAME },
>  	{ LIS3DE_ACCEL_DEV_NAME },
> +	{ LIS2DE12_ACCEL_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> --
> 2.9.2
> 

