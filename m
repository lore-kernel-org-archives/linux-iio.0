Return-Path: <SRS0=70H6=4J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8174C35646
	for <linux-iio@archiver.kernel.org>; Fri, 21 Feb 2020 11:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF907222C4
	for <linux-iio@archiver.kernel.org>; Fri, 21 Feb 2020 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582285128;
	bh=RSMXqVcGin1yqLClW26qzEGob5OcGyIIeUPKo30/GbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uXY2KDdkjbHx70v50cdOLTc92R5e8jB7Nq3aXWdIEl9+BYiGWn4GwZiuxmpeoYLoX
	 FX2vZDzZRKguQe9fHs6SFSDBeM5ExtiqbqmorI1tym2oHOU9N4jyAuE/9OZsoOGZtQ
	 w4VGyiG9ITqaF117hZgNdz3tb7JskN6N61DZhYcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgBULis (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:38:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbgBULis (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 06:38:48 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBE0F24650;
        Fri, 21 Feb 2020 11:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285127;
        bh=RSMXqVcGin1yqLClW26qzEGob5OcGyIIeUPKo30/GbY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HLv60fzlj4OdZLgW5FfEiVmdH6jvSr4q6yFm4ZcFBSA3Q8PZ0mZfJeo1hYNX9/NHm
         i+EYEHwA9wxRJANNDOglhcS1QJ4E+5XXFzvduSLWTqpjdxe9w4Sepfn4t5JkvXPDBw
         v/PfmMP6zwiXP+p1Ktsktq9VDj+UHxErKaRRn9eo=
Date:   Fri, 21 Feb 2020 11:38:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 11/13] iio: imu: inv_mpu6050: dynamic sampling rate
 change
Message-ID: <20200221113843.07374e4d@archlinux>
In-Reply-To: <20200219143958.3548-12-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
        <20200219143958.3548-12-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Feb 2020 15:39:56 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Sampling rate can be changed while the chip is running. It can
> be useful thus do not prevent it.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index aeee39696d3a..9076b6bb099c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -910,10 +910,6 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  	    fifo_rate > INV_MPU6050_MAX_FIFO_RATE)
>  		return -EINVAL;
>  
> -	result = iio_device_claim_direct_mode(indio_dev);
> -	if (result)
> -		return result;
> -
>  	/* compute the chip sample rate divider */
>  	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(fifo_rate);
>  	/* compute back the fifo rate to handle truncation cases */
> @@ -946,7 +942,6 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  	result |= inv_mpu6050_set_power_itg(st, false);
>  fifo_rate_fail_unlock:
>  	mutex_unlock(&st->lock);
> -	iio_device_release_direct_mode(indio_dev);
>  	if (result)
>  		return result;
>  

