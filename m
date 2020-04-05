Return-Path: <SRS0=q/te=5V=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3DBC2D0F4
	for <linux-iio@archiver.kernel.org>; Sun,  5 Apr 2020 13:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46F2206F8
	for <linux-iio@archiver.kernel.org>; Sun,  5 Apr 2020 13:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586092554;
	bh=luofMKePdICQdxnr5S+b92mBZ5BNmanHLS9dHdqOAC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mihsb5JiiVe5GhgWKyGYuBgTsw0+FI4+5F1px1nEO6okHx0d/YZGtn4nUEHd+ND+4
	 21b2Z81vMS21oN0VKYJfbcrvPNVL0XSAvCFJgnfLn1zZi4gLOSgd7f0GGCQeWOPyUR
	 ld7MlxKPEho73j7utXQj47SPbRvTwlKp6RXzE5PY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgDENPy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Apr 2020 09:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgDENPx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 09:15:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3662206C3;
        Sun,  5 Apr 2020 13:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586092553;
        bh=luofMKePdICQdxnr5S+b92mBZ5BNmanHLS9dHdqOAC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ofmhmQ3dW9W9xMDIgzjdRr7mlpkrLMi4vvJ6LZqINzeNNM0u88waH81//R6GYXtEA
         7GGjAYYz48lUrVC+Isn6uToZ8XBE4vqdu1g6lQOan9dOblNZxChms6efC9ea/nxm1K
         FlHXkyFce5MrhdUlPRJ0OlZmz9DI5dRFeubTYPts=
Date:   Sun, 5 Apr 2020 14:15:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix suspend/resume with runtime
 power
Message-ID: <20200405141549.0f773f5f@archlinux>
In-Reply-To: <20200331133850.23757-1-jmaneyrol@invensense.com>
References: <20200331133850.23757-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Mar 2020 15:38:50 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Suspend/resume were not working correctly with pm runtime.

Need more info than that!
Anyhow, when you say "not working correctly" what is happening that
is wrong?

Jonathan


> Now suspend check if the chip is already suspended, and
> resume put runtime pm in the correct state.
> 
> Fixes: 4599cac84614 ("iio: imu: inv_mpu6050: use runtime pm with autosuspend")
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index e4b0d368c2f9..a58bab03f0b0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1636,6 +1636,10 @@ static int __maybe_unused inv_mpu_resume(struct device *dev)
>  	if (result)
>  		goto out_unlock;
>  
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +

Looking at the docs, we should do this if we were previously suspended and no longer
are.  Not sure we should do it we weren't previously in runtime suspend?

I guess it is idempotent anyway so if we were previously enabled we just set it again.
So probably fine.

Jonathan

>  	result = inv_mpu6050_switch_engine(st, true, st->suspended_sensors);
>  	if (result)
>  		goto out_unlock;
> @@ -1657,13 +1661,18 @@ static int __maybe_unused inv_mpu_suspend(struct device *dev)
>  
>  	mutex_lock(&st->lock);
>  
> +	st->suspended_sensors = 0;
> +	if (pm_runtime_suspended(dev)) {
> +		result = 0;
> +		goto out_unlock;
> +	}
> +
>  	if (iio_buffer_enabled(indio_dev)) {
>  		result = inv_mpu6050_prepare_fifo(st, false);
>  		if (result)
>  			goto out_unlock;
>  	}
>  
> -	st->suspended_sensors = 0;
>  	if (st->chip_config.accl_en)
>  		st->suspended_sensors |= INV_MPU6050_SENSOR_ACCL;
>  	if (st->chip_config.gyro_en)

