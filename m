Return-Path: <SRS0=1XrH=32=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42CEC2D0B1
	for <linux-iio@archiver.kernel.org>; Thu,  6 Feb 2020 12:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A713521741
	for <linux-iio@archiver.kernel.org>; Thu,  6 Feb 2020 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580991372;
	bh=XLUktnRDdc8FXM2MPpBgiSsDeXaoym+rvo/lv7oBKME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PctlX5Fz9h5rHvp9UXIkPkCnbo00GCPlukZj7A//U2+O9w2vwWA0dz9KHdkN1WNTQ
	 WXdcoAsK3w9E0GdB6s/17bLs0JZ7Mkdms0Ml0eumTMNdtGP+NT2d1scErV9OkLZ+yu
	 8Jo+fz0njg6T5ojDD7QFgZf/RWrlayMJO5dU3tn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBFMQM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 6 Feb 2020 07:16:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBFMQM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 07:16:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA91E20730;
        Thu,  6 Feb 2020 12:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580991370;
        bh=XLUktnRDdc8FXM2MPpBgiSsDeXaoym+rvo/lv7oBKME=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dZmQ8vifvaePEpQsIMZWXSglP9RvYUtjGGlHQGUo34EIYJrRtV2tc/SqTccCcD6oZ
         +dmUiFoxjuxK/mPp9RqGXbaEscLk+5eq6CzXos0teJReFjlcs4byaT/g7s7jcCNv2e
         F7q5LPglZ8xZ2VkG2p2ewzIj4/KIj/UOwGXkevnE=
Date:   Thu, 6 Feb 2020 12:16:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/6] iio: imu: inv_mpu6050: update LPF bandwidth
 settings
Message-ID: <20200206121607.576051dd@archlinux>
In-Reply-To: <20200206103105.23666-6-jmaneyrol@invensense.com>
References: <20200206103105.23666-1-jmaneyrol@invensense.com>
        <20200206103105.23666-6-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  6 Feb 2020 11:31:04 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> As every chip has some little variant in LPF bandwidth values,
> use common values that are working for all chips.
> Simplify the LPF setting function.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied, thanks
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 30 ++++++++++++----------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 10 ++++----
>  2 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 9ecc667debbe..c4db9086775c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -707,30 +707,32 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>  /**
>   *  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
>   *
> - *                  Based on the Nyquist principle, the sampling rate must
> - *                  exceed twice of the bandwidth of the signal, or there
> - *                  would be alising. This function basically search for the
> - *                  correct low pass parameters based on the fifo rate, e.g,
> - *                  sampling frequency.
> + *                  Based on the Nyquist principle, the bandwidth of the low
> + *                  pass filter must not exceed the signal sampling rate divided
> + *                  by 2, or there would be aliasing.
> + *                  This function basically search for the correct low pass
> + *                  parameters based on the fifo rate, e.g, sampling frequency.
>   *
>   *  lpf is set automatically when setting sampling rate to avoid any aliases.
>   */
>  static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
>  {
> -	static const int hz[] = {188, 98, 42, 20, 10, 5};
> +	static const int hz[] = {400, 200, 90, 40, 20, 10};
>  	static const int d[] = {
> -		INV_MPU6050_FILTER_188HZ, INV_MPU6050_FILTER_98HZ,
> -		INV_MPU6050_FILTER_42HZ, INV_MPU6050_FILTER_20HZ,
> +		INV_MPU6050_FILTER_200HZ, INV_MPU6050_FILTER_100HZ,
> +		INV_MPU6050_FILTER_45HZ, INV_MPU6050_FILTER_20HZ,
>  		INV_MPU6050_FILTER_10HZ, INV_MPU6050_FILTER_5HZ
>  	};
> -	int i, h, result;
> +	int i, result;
>  	u8 data;
>  
> -	h = (rate >> 1);
> -	i = 0;
> -	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
> -		i++;
> -	data = d[i];
> +	data = INV_MPU6050_FILTER_5HZ;
> +	for (i = 0; i < ARRAY_SIZE(hz); ++i) {
> +		if (rate >= hz[i]) {
> +			data = d[i];
> +			break;
> +		}
> +	}
>  	result = inv_mpu6050_set_lpf_regs(st, data);
>  	if (result)
>  		return result;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 7ae614052210..9a81098a8b4d 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -370,14 +370,14 @@ enum inv_mpu6050_scan {
>  };
>  
>  enum inv_mpu6050_filter_e {
> -	INV_MPU6050_FILTER_256HZ_NOLPF2 = 0,
> -	INV_MPU6050_FILTER_188HZ,
> -	INV_MPU6050_FILTER_98HZ,
> -	INV_MPU6050_FILTER_42HZ,
> +	INV_MPU6050_FILTER_NOLPF2 = 0,
> +	INV_MPU6050_FILTER_200HZ,
> +	INV_MPU6050_FILTER_100HZ,
> +	INV_MPU6050_FILTER_45HZ,
>  	INV_MPU6050_FILTER_20HZ,
>  	INV_MPU6050_FILTER_10HZ,
>  	INV_MPU6050_FILTER_5HZ,
> -	INV_MPU6050_FILTER_2100HZ_NOLPF,
> +	INV_MPU6050_FILTER_NOLPF,
>  	NUM_MPU6050_FILTER
>  };
>  

