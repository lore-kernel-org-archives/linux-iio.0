Return-Path: <SRS0=zhpx=Y2=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD3CCA9EC7
	for <linux-iio@archiver.kernel.org>; Sat,  2 Nov 2019 15:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F5F217D9
	for <linux-iio@archiver.kernel.org>; Sat,  2 Nov 2019 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572710306;
	bh=T6m1UkajXitnwCXENVIC9e6Xgw0SuI7lqN1Ew+w8kV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ftKtrKGT8s+uUYinnQdaipu4DdgfKK+oobmqEN9UwoQOMarjOnSJDPIgy+3vyZkGV
	 NQvWLsUsyrJmW2z7WKp2wVjmRKbkBpWmswpdB72IEk9wYJVyl4+A3RqDsA5WwBOCY9
	 6n6EoSykvMopsqnK8LDbRb+RachyqP1TFQtgvpR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfKBP6Z (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Nov 2019 11:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfKBP6Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Nov 2019 11:58:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D1C217D9;
        Sat,  2 Nov 2019 15:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572710304;
        bh=T6m1UkajXitnwCXENVIC9e6Xgw0SuI7lqN1Ew+w8kV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tGX14JAkjfRQ3aQlh/eDZDewPG7T9R3IL3MzWycM9IQ5fxo6duIi6NSpygJm++ZKz
         SpblczQTHX+rrybyc35bpLnay5lxgMOsaZzStN/mkyNtI4JWZtshL/daI21KkcOk1n
         ycxRHiUm7te7fyH74m6OFGsa0XrFtI09wHmkyrfw=
Date:   Sat, 2 Nov 2019 15:58:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix ODR check in
 st_lsm6dsx_write_raw
Message-ID: <20191102155820.7186f1f6@archlinux>
In-Reply-To: <eda7fb795fb47c41b6c6d617255cb8eec486c355.1572199100.git.lorenzo@kernel.org>
References: <eda7fb795fb47c41b6c6d617255cb8eec486c355.1572199100.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Oct 2019 19:02:30 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Since st_lsm6dsx i2c master controller relies on accel device as trigger
> and slave devices can run at different ODRs we must select an accel_odr >=
> slave_odr. Report real accel ODR in st_lsm6dsx_check_odr() in order to
> properly set sensor frequency in st_lsm6dsx_write_raw and avoid to
> report unsupported frequency
> 
> Fixes: 6ffb55e5009ff ("iio: imu: st_lsm6dsx: introduce ST_LSM6DSX_ID_EXT sensor ids")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Applied to the fixes-togreg branch of iio.git and marked for stable.
Given time in cycle I 'might' shift this into togreg to go in during the
merge window. 

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 1f28a7733fc0..c53c03ec2423 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1362,8 +1362,7 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
>  		return -EINVAL;
>  
>  	*val = odr_table->odr_avl[i].val;
> -
> -	return 0;
> +	return odr_table->odr_avl[i].hz;
>  }
>  
>  static u16 st_lsm6dsx_check_odr_dependency(struct st_lsm6dsx_hw *hw, u16 odr,
> @@ -1527,8 +1526,10 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ: {
>  		u8 data;
>  
> -		err = st_lsm6dsx_check_odr(sensor, val, &data);
> -		if (!err)
> +		val = st_lsm6dsx_check_odr(sensor, val, &data);
> +		if (val < 0)
> +			err = val;
> +		else
>  			sensor->odr = val;
>  		break;
>  	}

