Return-Path: <SRS0=A0tK=SQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F10C10F13
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 10:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73581218D3
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 10:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555236349;
	bh=dMHar0ZXtyOLMSxeyp/vvvfGD/BOkg0m4o9YjMGuZBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=l8ndW531Ojh0dpmUXwCpZSIHSWjuXq9uadd2Zqo8VzkPCbQmIhxeCmsososz7Az+d
	 Gckc6+bRTuajrhXWyyvuDh4v9CB2LcJzTZ3t6mKhB89fyDK4AwTtITRsn1/5X5kwa7
	 wQFSit4prswVr/++EbQKkIe31C07Ytva+6NCFQhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbfDNKFt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfDNKFs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Apr 2019 06:05:48 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB0E2148E;
        Sun, 14 Apr 2019 10:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555236347;
        bh=dMHar0ZXtyOLMSxeyp/vvvfGD/BOkg0m4o9YjMGuZBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pTW2WArMYvT//+YuutSf4/8SHktSbyqD6YOznvIq0webl6gDT69KUB0i/Oa+mJjda
         nOcXZOcfiojHBd0EL4JW9uWnJyhb2a9QwsHD0Mj0NzIej8WDOiP5yvJzbxmU4HIqfB
         1vVf2bzQ051wc73QLFaPC0sQsGFTRsa1tjkPLFpM=
Date:   Sun, 14 Apr 2019 11:05:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 2/2] iio: accel: add support to LIS2DE12
Message-ID: <20190414110539.14b2cb92@archlinux>
In-Reply-To: <20190411001209.29488-3-rjones@gateworks.com>
References: <20190305203252.13647-1-rjones@gateworks.com>
        <20190411001209.29488-1-rjones@gateworks.com>
        <20190411001209.29488-3-rjones@gateworks.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Apr 2019 17:12:09 -0700
Robert Jones <rjones@gateworks.com> wrote:

> Add support to STMicroelectronics LIS2DE12 accelerometer in
> st_accel framework.
> 
> http://www.st.com/resource/en/datasheet/lis2de12.pdf
> 
> Signed-off-by: Robert Jones <rjones@gateworks.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/Kconfig         |  2 +-
>  drivers/iio/accel/st_accel.h      |  2 ++
>  drivers/iio/accel/st_accel_core.c | 76 +++++++++++++++++++++++++++++++++++++++
>  drivers/iio/accel/st_accel_i2c.c  |  5 +++
>  4 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 4a1f133..62a970a 100644
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
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index fd53258..9d25955 100644
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
> +#define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
>  
>  /**
>  * struct st_sensors_platform_data - default accel platform data
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 9930edf..5ff04d9 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -831,6 +831,82 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.multi_read_bit = false,
>  		.bootime = 2,
>  	},
> +	{
> +		.wai = 0x33,
> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +		.sensors_supported = {
> +			[0] = LIS2DE12_ACCEL_DEV_NAME,
> +		},
> +		.ch = (struct iio_chan_spec *)st_accel_8bit_channels,
> +		.odr = {
> +			.addr = 0x20,
> +			.mask = 0xf0,
> +			.odr_avl = {
> +				{ .hz = 1, .value = 0x01, },
> +				{ .hz = 10, .value = 0x02, },
> +				{ .hz = 25, .value = 0x03, },
> +				{ .hz = 50, .value = 0x04, },
> +				{ .hz = 100, .value = 0x05, },
> +				{ .hz = 200, .value = 0x06, },
> +				{ .hz = 400, .value = 0x07, },
> +				{ .hz = 1620, .value = 0x08, },
> +				{ .hz = 5376, .value = 0x09, },
> +			},
> +		},
> +		.pw = {
> +			.addr = 0x20,
> +			.mask = 0xf0,
> +			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> +		},
> +		.enable_axis = {
> +			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
> +			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
> +		},
> +		.fs = {
> +			.addr = 0x23,
> +			.mask = 0x30,
> +			.fs_avl = {
> +				[0] = {
> +					.num = ST_ACCEL_FS_AVL_2G,
> +					.value = 0x00,
> +					.gain = IIO_G_TO_M_S_2(15600),
> +				},
> +				[1] = {
> +					.num = ST_ACCEL_FS_AVL_4G,
> +					.value = 0x01,
> +					.gain = IIO_G_TO_M_S_2(31200),
> +				},
> +				[2] = {
> +					.num = ST_ACCEL_FS_AVL_8G,
> +					.value = 0x02,
> +					.gain = IIO_G_TO_M_S_2(62500),
> +				},
> +				[3] = {
> +					.num = ST_ACCEL_FS_AVL_16G,
> +					.value = 0x03,
> +					.gain = IIO_G_TO_M_S_2(187500),
> +				},
> +			},
> +		},
> +		.drdy_irq = {
> +			.int1 = {
> +				.addr = 0x22,
> +				.mask = 0x10,
> +			},
> +			.addr_ihl = 0x25,
> +			.mask_ihl = 0x02,
> +			.stat_drdy = {
> +				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
> +				.mask = 0x07,
> +			},
> +		},
> +		.sim = {
> +			.addr = 0x23,
> +			.value = BIT(0),
> +		},
> +		.multi_read_bit = true,
> +		.bootime = 2,
> +	},
>  };
>  
>  static int st_accel_read_raw(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index de8ae43..4e54477 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -102,6 +102,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lis3de",
>  		.data = LIS3DE_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lis2de12",
> +		.data = LIS2DE12_ACCEL_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> @@ -140,6 +144,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  	{ LIS3LV02DL_ACCEL_DEV_NAME },
>  	{ LIS2DW12_ACCEL_DEV_NAME },
>  	{ LIS3DE_ACCEL_DEV_NAME },
> +	{ LIS2DE12_ACCEL_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);

