Return-Path: <SRS0=rKOe=RG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED7C43381
	for <linux-iio@archiver.kernel.org>; Sun,  3 Mar 2019 16:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CDD20842
	for <linux-iio@archiver.kernel.org>; Sun,  3 Mar 2019 16:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551629495;
	bh=nKrfXSN2jONbHGLJ54RqBRfcVM8vFl4wmL+iB19+kv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Z12gPArVAbss9oIgXR7xlHby4Ru13OIOBuvat1hRbnOyJBsp8TW3Cm3k4rWW6pzru
	 FHBZKxH0cWn2fdgouWoCGOtJ+n+gOAfvZcoDg7NsVuWrnK1++a5Qyw1+kkNk0VB/yt
	 nIIjE99JkPV5ybRhJdQTth29X1BCHMIyAuwiCvuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfCCQLe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfCCQLe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Mar 2019 11:11:34 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B179D206DD;
        Sun,  3 Mar 2019 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551629492;
        bh=nKrfXSN2jONbHGLJ54RqBRfcVM8vFl4wmL+iB19+kv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ttekoufY06G4vgEYkIDR/gDv1QloH4GMgj6K/ezr3N8dXGv6ca91wgwpUKZxRylob
         voReMlY+DgOpHGTNws5PyzfJCTLR60HYQuxq1Sumv3Skpkl+M3cGHWqnKAFkVVI6N3
         K5G0K3IlIAJmoAiy7XwC33U6Iutuw1UKTl0BWU3w=
Date:   Sun, 3 Mar 2019 16:11:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        mario.tesi@st.com, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to ASM330LHH
Message-ID: <20190303161128.4418d3cc@archlinux>
In-Reply-To: <4eeb8888ba5572736cb26f4f6e2376d416e3b3fc.1550753006.git.lorenzo@kernel.org>
References: <cover.1550753006.git.lorenzo@kernel.org>
        <4eeb8888ba5572736cb26f4f6e2376d416e3b3fc.1550753006.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Feb 2019 16:20:20 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support to STM ASM330LHH 6-axis (acc + gyro) Mems sensor
> https://www.st.com/resource/en/datasheet/asm330lhh.pdf
> 
> Tested-by: Mario Tesi <mario.tesi@st.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig            |  2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  8 ++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 41 ++++++++++++++++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |  5 +++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |  5 +++
>  6 files changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index 094fd006b63d..36048bf0455a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -9,7 +9,7 @@ config IIO_ST_LSM6DSX
>  	help
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> -	  ism330dlc, lsm6dso
> +	  ism330dlc, lsm6dso, asm330lhh
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index d1d8d07a0714..de2a0dc39353 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -20,6 +20,7 @@
>  #define ST_LSM6DSM_DEV_NAME	"lsm6dsm"
>  #define ST_ISM330DLC_DEV_NAME	"ism330dlc"
>  #define ST_LSM6DSO_DEV_NAME	"lsm6dso"
> +#define ST_ASM330LHH_DEV_NAME	"asm330lhh"
>  
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,
> @@ -28,6 +29,7 @@ enum st_lsm6dsx_hw_id {
>  	ST_LSM6DSM_ID,
>  	ST_ISM330DLC_ID,
>  	ST_LSM6DSO_ID,
> +	ST_ASM330LHH_ID,
>  	ST_LSM6DSX_MAX_ID,
>  };
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 2c0d3763405a..8f443bdb5b51 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -13,9 +13,9 @@
>   * (e.g. Gx, Gy, Gz, Ax, Ay, Az), then data are repeated depending on the
>   * value of the decimation factor and ODR set for each FIFO data set.
>   *
> - * LSM6DSO: The FIFO buffer can be configured to store data from gyroscope and
> - * accelerometer. Each sample is queued with a tag (1B) indicating data source
> - * (gyroscope, accelerometer, hw timer).
> + * LSM6DSO/ASM330LHH: The FIFO buffer can be configured to store data
> + * from gyroscope and accelerometer. Each sample is queued with a tag (1B)
> + * indicating data source (gyroscope, accelerometer, hw timer).
>   *
>   * FIFO supported modes:
>   *  - BYPASS: FIFO disabled
> @@ -506,7 +506,7 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
>  }
>  
>  /**
> - * st_lsm6dsx_read_tagged_fifo() - LSM6DSO read FIFO routine
> + * st_lsm6dsx_read_tagged_fifo() - LSM6DSO/ASM330LHH read FIFO routine
>   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
>   *
>   * Read samples from the hw FIFO and push them to IIO buffers.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 12e29dda9b98..50cab3531b11 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -23,7 +23,7 @@
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
>   *   - FIFO size: 4KB
>   *
> - * - LSM6DSO
> + * - LSM6DSO/ASM330LHH
>   *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
> @@ -347,6 +347,45 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.batch_en = BIT(3),
>  		}
>  	},
> +	{
> +		.wai = 0x6b,
> +		.max_fifo_size = 512,
> +		.id = {
> +			[0] = ST_ASM330LHH_ID,
> +		},
> +		.batch = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.addr = 0x09,
> +				.mask = GENMASK(3, 0),
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.addr = 0x09,
> +				.mask = GENMASK(7, 4),
> +			},
> +		},
> +		.fifo_ops = {
> +			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> +			.fifo_th = {
> +				.addr = 0x07,
> +				.mask = GENMASK(8, 0),
> +			},
> +			.fifo_diff = {
> +				.addr = 0x3a,
> +				.mask = GENMASK(8, 0),
> +			},
> +			.th_wl = 1,
> +		},
> +		.ts_settings = {
> +			.timer_en = {
> +				.addr = 0x19,
> +				.mask = BIT(5),
> +			},
> +			.decimator = {
> +				.addr = 0x0a,
> +				.mask = GENMASK(7, 6),
> +			},
> +		},
> +	},
>  };
>  
>  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 448b7bc1e578..00b4b702645a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -65,6 +65,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>  		.compatible = "st,lsm6dso",
>  		.data = (void *)ST_LSM6DSO_ID,
>  	},
> +	{
> +		.compatible = "st,asm330lhh",
> +		.data = (void *)ST_ASM330LHH_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> @@ -76,6 +80,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>  	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
>  	{ ST_ISM330DLC_DEV_NAME, ST_ISM330DLC_ID },
>  	{ ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
> +	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index b1df8a6973e6..836256c2ac7d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -65,6 +65,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>  		.compatible = "st,lsm6dso",
>  		.data = (void *)ST_LSM6DSO_ID,
>  	},
> +	{
> +		.compatible = "st,asm330lhh",
> +		.data = (void *)ST_ASM330LHH_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> @@ -76,6 +80,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>  	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
>  	{ ST_ISM330DLC_DEV_NAME, ST_ISM330DLC_ID },
>  	{ ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
> +	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);

