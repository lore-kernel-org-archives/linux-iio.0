Return-Path: <SRS0=MckS=ZX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4922EC432C3
	for <linux-iio@archiver.kernel.org>; Sun,  1 Dec 2019 21:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDC82082E
	for <linux-iio@archiver.kernel.org>; Sun,  1 Dec 2019 21:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575234117;
	bh=1uyA1V8C4ubUlATGvaMcyCobMXLCXsoI5SnZXBTkwuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=V6F1qzZzC7R7EwK7MMnHzwxMUUYtCa19S8gRfwecm6lklblHH/O91TbNR8caaomfV
	 h5Wa6yyxVHRYCvtIy0tWtCBb8T2rDzlXfcVGKIomt6ZjsGyDIincE3J6g5vL4Urin0
	 U2BOjxrdTKriRr2mcT6HGSajFy9bvCYWUvKCGn90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfLAVB4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 1 Dec 2019 16:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbfLAVB4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 16:01:56 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFEAD2146E;
        Sun,  1 Dec 2019 21:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575234115;
        bh=1uyA1V8C4ubUlATGvaMcyCobMXLCXsoI5SnZXBTkwuk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sJW8keh2VTlR2ZZdTClLAHs3nQsYvVQnNENrqZkZHXpLC57B2iKtNnEM2u6naNiEZ
         RxS6qED2B3+TQ1sKOZiKOntpFHM88GwvRooOp9WUTg8sutokdtiej7oI0NhDIWiNnP
         3sy+l9jWxEUiuus0W2LobNgO1SBHnpNHFnoplAj8=
Date:   Sun, 1 Dec 2019 21:01:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        sean@geanix.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: do not power-off accel if events
 are enabled
Message-ID: <20191201210151.5aa8c4c3@archlinux>
In-Reply-To: <f245c67b9eff976fbc264affb1f6135c51222b4d.1575019621.git.lorenzo@kernel.org>
References: <f245c67b9eff976fbc264affb1f6135c51222b4d.1575019621.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Nov 2019 11:37:24 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Do not power-off accel unconditionally if wake-up events are enabled
> powering off the hw FIFO. At the same time do not power-off the accel
> sensor if it is 'batched' in the hw FIFO disabling sensor events
> 
> Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> Tested-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Not applied as this seems to be dependent on one of the earlier patches.
Please put them in a series and resend.

Thanks,

Jonathan
> ---
> This patch is based on https://patchwork.kernel.org/patch/11266301/
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 +++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 13590c041d22..990643da9f4e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1447,8 +1447,9 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
>  	return st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
>  }
>  
> -int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> -				 bool enable)
> +static int
> +__st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> +			       bool enable)
>  {
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
>  	u32 odr = enable ? sensor->odr : 0;
> @@ -1466,6 +1467,26 @@ int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
>  	return 0;
>  }
>  
> +static int
> +st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor, bool enable)
> +{
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +
> +	if (sensor->id == ST_LSM6DSX_ID_GYRO || enable)
> +		return 0;
> +
> +	return hw->enable_event;
> +}
> +
> +int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> +				 bool enable)
> +{
> +	if (st_lsm6dsx_check_events(sensor, enable))
> +		return 0;
> +
> +	return __st_lsm6dsx_sensor_set_enable(sensor, enable);
> +}
> +
>  static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>  				   u8 addr, int *val)
>  {
> @@ -1662,7 +1683,7 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
>  	u8 enable_event;
> -	int err = 0;
> +	int err;
>  
>  	if (type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
> @@ -1690,7 +1711,8 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
>  		return err;
>  
>  	mutex_lock(&hw->conf_lock);
> -	err = st_lsm6dsx_sensor_set_enable(sensor, state);
> +	if (enable_event || !(hw->fifo_mask & BIT(sensor->id)))
> +		err = __st_lsm6dsx_sensor_set_enable(sensor, state);
>  	mutex_unlock(&hw->conf_lock);
>  	if (err < 0)
>  		return err;

