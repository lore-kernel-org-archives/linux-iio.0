Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeICAqD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 20:46:03 -0400
Date: Sun, 2 Sep 2018 21:29:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: imu: st_lsm6dsx: make st_lsm6dsx_check_odr()
 non-static
Message-ID: <20180902212901.7112970d@archlinux>
In-Reply-To: <20180830205259.7029-3-lorenzo.bianconi@redhat.com>
References: <20180830205259.7029-3-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 30 Aug 2018 22:52:56 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Remove static qualifier from st_lsm6dsx_check_odr() definition in order to
> use it for the support of new devices
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Applied.  Thanks

Jonathan
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index a0a6c07aad62..6cf806f10787 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -180,5 +180,6 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
>  int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>  			     enum st_lsm6dsx_fifo_mode fifo_mode);
>  int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
> +int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val);
>  
>  #endif /* ST_LSM6DSX_H */
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 394bcd3719e0..5a43d8139950 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -398,8 +398,7 @@ static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
>  	return 0;
>  }
>  
> -static int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr,
> -				u8 *val)
> +int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
>  {
>  	int i;
>  
