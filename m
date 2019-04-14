Return-Path: <SRS0=A0tK=SQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C995BC10F13
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 13:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872102084E
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 13:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555250353;
	bh=ZS33prMf10BAACx+FbrdG8Y03nNPZsYnRAnS7n+vmZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nECK7dA3rpLakgkH/ny8iFFQAOcdx9c/bY0CyeGL0arl72GRnqYhyMNIBrJcJyuyp
	 9cc1T5V0WVCZK3WwSP/i6UQ4um+6TIq/vE+yQ/RS8auh/jrQ9ClpGf1yaVWn9uUBcl
	 dU1kj8cQA8kFYpyEv0EYzIfHL8R+3Pi50s91eU+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfDNN7M (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfDNN7M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Apr 2019 09:59:12 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E4C2084E;
        Sun, 14 Apr 2019 13:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555250351;
        bh=ZS33prMf10BAACx+FbrdG8Y03nNPZsYnRAnS7n+vmZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xsmc0ugTAuXxh+1U9EApaJWi9YFs3azW/+ZSmb3yxavhHMt46ChZRG6ialsm8S6jR
         17K5LvHzJG5Xzs1UD+grv9kTYD1Tu+ovYfnb+xNM/aBWPJFoAoy5fOMF9Zh3KgJmTO
         CVYN5HuByC4zg4qkdP0iwOpiRyZ3lQxJSMcs3u7M=
Date:   Sun, 14 Apr 2019 14:59:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: inline per-sensor data
Message-ID: <20190414145841.509fa40a@archlinux>
In-Reply-To: <7a9445dce569870c70e4fabb1a4fcd8fb35a460e.1554842769.git.lorenzo@kernel.org>
References: <cover.1554842769.git.lorenzo@kernel.org>
        <7a9445dce569870c70e4fabb1a4fcd8fb35a460e.1554842769.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  9 Apr 2019 22:49:09 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> As it has been already done for other st sensors in 'commit 9049531c91b4
> ("iio: accel: st_accel: inline per-sensor data")', get rid of some
> defines and just open code the values into the appropriate struct
> elements since the semantic meaning is inherent in the name of the
> C99-addressable fields and there is no reason to duplicate the code
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Nice cleanup.
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

thanks,

Jonathan
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 50 +++++++-------------
>  1 file changed, 16 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 04124cc277dd..cf82c9049945 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -62,37 +62,19 @@
>  #define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
>  #define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
>  
> -#define ST_LSM6DSX_REG_ACC_ODR_ADDR		0x10
> -#define ST_LSM6DSX_REG_ACC_ODR_MASK		GENMASK(7, 4)
> -#define ST_LSM6DSX_REG_ACC_FS_ADDR		0x10
> -#define ST_LSM6DSX_REG_ACC_FS_MASK		GENMASK(3, 2)
>  #define ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR		0x28
>  #define ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR		0x2a
>  #define ST_LSM6DSX_REG_ACC_OUT_Z_L_ADDR		0x2c
>  
> -#define ST_LSM6DSX_REG_GYRO_ODR_ADDR		0x11
> -#define ST_LSM6DSX_REG_GYRO_ODR_MASK		GENMASK(7, 4)
> -#define ST_LSM6DSX_REG_GYRO_FS_ADDR		0x11
> -#define ST_LSM6DSX_REG_GYRO_FS_MASK		GENMASK(3, 2)
>  #define ST_LSM6DSX_REG_GYRO_OUT_X_L_ADDR	0x22
>  #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
>  #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
>  
> -#define ST_LSM6DSX_ACC_FS_2G_GAIN		IIO_G_TO_M_S_2(61)
> -#define ST_LSM6DSX_ACC_FS_4G_GAIN		IIO_G_TO_M_S_2(122)
> -#define ST_LSM6DSX_ACC_FS_8G_GAIN		IIO_G_TO_M_S_2(244)
> -#define ST_LSM6DSX_ACC_FS_16G_GAIN		IIO_G_TO_M_S_2(488)
> -
> -#define ST_LSM6DSX_GYRO_FS_245_GAIN		IIO_DEGREE_TO_RAD(8750)
> -#define ST_LSM6DSX_GYRO_FS_500_GAIN		IIO_DEGREE_TO_RAD(17500)
> -#define ST_LSM6DSX_GYRO_FS_1000_GAIN		IIO_DEGREE_TO_RAD(35000)
> -#define ST_LSM6DSX_GYRO_FS_2000_GAIN		IIO_DEGREE_TO_RAD(70000)
> -
>  static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
>  	[ST_LSM6DSX_ID_ACC] = {
>  		.reg = {
> -			.addr = ST_LSM6DSX_REG_ACC_ODR_ADDR,
> -			.mask = ST_LSM6DSX_REG_ACC_ODR_MASK,
> +			.addr = 0x10,
> +			.mask = GENMASK(7, 4),
>  		},
>  		.odr_avl[0] = {  13, 0x01 },
>  		.odr_avl[1] = {  26, 0x02 },
> @@ -103,8 +85,8 @@ static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
>  	},
>  	[ST_LSM6DSX_ID_GYRO] = {
>  		.reg = {
> -			.addr = ST_LSM6DSX_REG_GYRO_ODR_ADDR,
> -			.mask = ST_LSM6DSX_REG_GYRO_ODR_MASK,
> +			.addr = 0x11,
> +			.mask = GENMASK(7, 4),
>  		},
>  		.odr_avl[0] = {  13, 0x01 },
>  		.odr_avl[1] = {  26, 0x02 },
> @@ -118,23 +100,23 @@ static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
>  static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
>  	[ST_LSM6DSX_ID_ACC] = {
>  		.reg = {
> -			.addr = ST_LSM6DSX_REG_ACC_FS_ADDR,
> -			.mask = ST_LSM6DSX_REG_ACC_FS_MASK,
> +			.addr = 0x10,
> +			.mask = GENMASK(3, 2),
>  		},
> -		.fs_avl[0] = {  ST_LSM6DSX_ACC_FS_2G_GAIN, 0x0 },
> -		.fs_avl[1] = {  ST_LSM6DSX_ACC_FS_4G_GAIN, 0x2 },
> -		.fs_avl[2] = {  ST_LSM6DSX_ACC_FS_8G_GAIN, 0x3 },
> -		.fs_avl[3] = { ST_LSM6DSX_ACC_FS_16G_GAIN, 0x1 },
> +		.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
> +		.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
> +		.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
> +		.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
>  	},
>  	[ST_LSM6DSX_ID_GYRO] = {
>  		.reg = {
> -			.addr = ST_LSM6DSX_REG_GYRO_FS_ADDR,
> -			.mask = ST_LSM6DSX_REG_GYRO_FS_MASK,
> +			.addr = 0x11,
> +			.mask = GENMASK(3, 2),
>  		},
> -		.fs_avl[0] = {  ST_LSM6DSX_GYRO_FS_245_GAIN, 0x0 },
> -		.fs_avl[1] = {  ST_LSM6DSX_GYRO_FS_500_GAIN, 0x1 },
> -		.fs_avl[2] = { ST_LSM6DSX_GYRO_FS_1000_GAIN, 0x2 },
> -		.fs_avl[3] = { ST_LSM6DSX_GYRO_FS_2000_GAIN, 0x3 },
> +		.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
> +		.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
> +		.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
> +		.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
>  	}
>  };
>  

