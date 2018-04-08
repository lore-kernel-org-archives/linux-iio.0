Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751770AbeDHPtQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Apr 2018 11:49:16 -0400
Date: Sun, 8 Apr 2018 16:49:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix FIFO threshold mask for
 LSM6DSM/LSM6DSL
Message-ID: <20180408164911.37b09b9a@archlinux>
In-Reply-To: <20180330184322.5455-1-lorenzo.bianconi@redhat.com>
References: <20180330184322.5455-1-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 30 Mar 2018 20:43:22 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> According to the latest datasheet, LSM6DSM and LSM6DSL imu sensors
> export GENMASK(10, 0) for FIFO threshold mask definition. Despite
> that is not an actual issue since write on fifo_th register is protected
> by max_fifo_size value, fix fifo_th and fifo_diff register definitions
> 
> Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 8656d72ef4ee..50d6491df484 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -266,11 +266,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.fifo_ops = {
>  			.fifo_th = {
>  				.addr = 0x06,
> -				.mask = GENMASK(11, 0),
> +				.mask = GENMASK(10, 0),
>  			},
>  			.fifo_diff = {
>  				.addr = 0x3a,
> -				.mask = GENMASK(11, 0),
> +				.mask = GENMASK(10, 0),
>  			},
>  			.th_wl = 3, /* 1LSB = 2B */
>  		},

