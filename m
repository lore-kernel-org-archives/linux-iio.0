Return-Path: <SRS0=hvMU=TT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0ABC04AB4
	for <linux-iio@archiver.kernel.org>; Sun, 19 May 2019 17:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13659204EC
	for <linux-iio@archiver.kernel.org>; Sun, 19 May 2019 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558287143;
	bh=dGR6N7ZvzuuGo8eoxHjIzbtxefptEKX/vxuvQYCPVdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Tp+a8cgjWuE0ryr+k/kH5uEFgBsl4fQ9iiOj1hefqPNN49jd5gO+nEKuTB7AMw5uL
	 8G/pKdRa70jz1yTAOj3irw0BupHBGbQUxvauqMIaiybne2F5adkoittLjJnxN/+4gC
	 0t79i+1FzHlKKYPnKxE2TyFvLtv0XG48u3HPLNq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfESRcW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 19 May 2019 13:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfESRcW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:32:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F882184E;
        Sun, 19 May 2019 11:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558265810;
        bh=dGR6N7ZvzuuGo8eoxHjIzbtxefptEKX/vxuvQYCPVdk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GRdleZAJ9gxdgTKz2jeJLdwCYju14otfLPfTyyv6sYThk3tFsx24QKJS1AjKgMEvy
         fatbh0vzTjQl1WxU/9PxN554VZXbTLXN6lGyysMGuSTbwrquSalCLkbgmKq196wmiS
         RBvurLKe1IBeZjgNreqpvvIm5l/p9VEIcGw4O1eE=
Date:   Sun, 19 May 2019 12:36:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix PM support for st_lsm6dsx i2c
 controller
Message-ID: <20190519123646.3b05a0b5@archlinux>
In-Reply-To: <a79978d7b8b9762954bf15cb205bada6dc66079a.1558256188.git.lorenzo@kernel.org>
References: <cover.1558256188.git.lorenzo@kernel.org>
        <a79978d7b8b9762954bf15cb205bada6dc66079a.1558256188.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 19 May 2019 10:58:23 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Properly suspend/resume i2c slaves connected to st_lsm6dsx master
> controller if the CPU goes in suspended state
> 
> Fixes: c91c1c844ebd ("imu: st_lsm6dsx: add i2c embedded controller support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 25 +++++++++++++-------
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 004a8a1a0027..6ef3577234a0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -271,6 +271,7 @@ struct st_lsm6dsx_sensor {
>   * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
>   * @page_lock: Mutex to prevent concurrent memory page configuration.
>   * @fifo_mode: FIFO operating mode supported by the device.
> + * @suspend_mask: Suspended sensor bitmask.
>   * @enable_mask: Enabled sensor bitmask.
>   * @ts_sip: Total number of timestamp samples in a given pattern.
>   * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
> @@ -288,6 +289,7 @@ struct st_lsm6dsx_hw {
>  	struct mutex page_lock;
>  
>  	enum st_lsm6dsx_fifo_mode fifo_mode;
> +	u8 suspend_mask;
>  	u8 enable_mask;
>  	u8 ts_sip;
>  	u8 sip;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index cf82c9049945..be5c87c8266d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1110,8 +1110,6 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
>  {
>  	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
>  	struct st_lsm6dsx_sensor *sensor;
> -	const struct st_lsm6dsx_reg *reg;
> -	unsigned int data;
>  	int i, err = 0;
>  
>  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> @@ -1122,12 +1120,16 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
>  		if (!(hw->enable_mask & BIT(sensor->id)))
>  			continue;
>  
> -		reg = &st_lsm6dsx_odr_table[sensor->id].reg;
> -		data = ST_LSM6DSX_SHIFT_VAL(0, reg->mask);
> -		err = st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask,
> -						    data);
> +		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
> +		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
> +		    sensor->id == ST_LSM6DSX_ID_EXT2)
> +			err = st_lsm6dsx_shub_set_enable(sensor, false);
> +		else
> +			err = st_lsm6dsx_sensor_set_enable(sensor, false);
>  		if (err < 0)
>  			return err;
> +
> +		hw->suspend_mask |= BIT(sensor->id);
>  	}
>  
>  	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
> @@ -1147,12 +1149,19 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
>  			continue;
>  
>  		sensor = iio_priv(hw->iio_devs[i]);
> -		if (!(hw->enable_mask & BIT(sensor->id)))
> +		if (!(hw->suspend_mask & BIT(sensor->id)))
>  			continue;
>  
> -		err = st_lsm6dsx_set_odr(sensor, sensor->odr);
> +		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
> +		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
> +		    sensor->id == ST_LSM6DSX_ID_EXT2)
> +			err = st_lsm6dsx_shub_set_enable(sensor, true);
> +		else
> +			err = st_lsm6dsx_sensor_set_enable(sensor, true);
>  		if (err < 0)
>  			return err;
> +
> +		hw->suspend_mask &= ~BIT(sensor->id);
>  	}
>  
>  	if (hw->enable_mask)

