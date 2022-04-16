Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1535EC433FE
	for <linux-iio@archiver.kernel.org>; Sat, 16 Apr 2022 13:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiDPN7s (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Apr 2022 09:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiDPN7r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2022 09:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801A4434B0;
        Sat, 16 Apr 2022 06:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A729C60F30;
        Sat, 16 Apr 2022 13:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2864FC385A3;
        Sat, 16 Apr 2022 13:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650117434;
        bh=U/naFN2M5Dm7AE42rdreYzpFrF0sNOtT7665JZA8vtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qt21WDAlOQkO2XmF19kAEe47JjyS2/UjL2Nod2VEI+eLCjD6jlPuG7auYFr/ZXm4c
         jEfnPKMnNd1oIEt3k53++HCdAg7Yl8QEEku5+1QZCREDBy9udwjVdEyUL+BH1HH24y
         SlXRWALWn8zTTSalcfZa0/fzPpdNrHbPrzxXc6OqDMp33Y+wpid901cP4Of5ln2XGQ
         Pkb8e4k390Oph35xuHQIozbVN5pznLk/98x6cJp8AvtZ0SU8ROHwq3obPbTiA1wHvk
         HnzqA8EJpTCeAK3aRJWUNBMHEuZwe+6h/0Z8Y1VYWpQWNL42anzricKkNL4GOR5fhi
         o95tRxlSczHHQ==
Date:   Sat, 16 Apr 2022 15:05:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
        Fawzi Khaber <fawzi.khaber@tdk.com>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v3] iio: imu: inv_icm42600: Fix I2C init possible nack
Message-ID: <20220416150511.219b3fee@jic23-huawei>
In-Reply-To: <20220411111533.5826-1-jmaneyrol@invensense.com>
References: <20220411111533.5826-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Apr 2022 13:15:33 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> From: Fawzi Khaber <fawzi.khaber@tdk.com>
> 
> This register write to REG_INTF_CONFIG6 enables a spike filter that
> is impacting the line and can prevent the I2C ACK to be seen by the
> controller. So we don't test the return value.
> 
> Fixes: 7297ef1e261672b8 ("iio: imu: inv_icm42600: add I2C driver")
> Signed-off-by: Fawzi Khaber <fawzi.khaber@tdk.com>
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied to the fixes-togreg branch of iio.git with a minor tweak +
marked for stable.

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> index 33d9afb1ba91..01fd883c8459 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -18,12 +18,15 @@ static int inv_icm42600_i2c_bus_setup(struct inv_icm42600_state *st)
>  	unsigned int mask, val;
>  	int ret;
>  
> -	/* setup interface registers */
> -	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
> +	/*
> +	 * setup interface registers
> +	 * This register write to REG_INTF_CONFIG6 enables a spike filter that
> +	 * is impacting the line and can prevent the I2C ACK to be seen by the
> +	 * controller. So we don't test the return value.
> +	 */
> +	regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,

The following two lines need a smaller indent after this change. I've
tweaked that whilst applying.

Thanks,

Jonathan

>  				 INV_ICM42600_INTF_CONFIG6_MASK,
>  				 INV_ICM42600_INTF_CONFIG6_I3C_EN);
> -	if (ret)
> -		return ret;
>  
>  	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
>  				 INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY, 0);

