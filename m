Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeKZA6M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Nov 2018 19:58:12 -0500
Date: Sun, 25 Nov 2018 14:06:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: do not use a fixed read len in
 read_oneshot
Message-ID: <20181125140659.39a542f7@archlinux>
In-Reply-To: <2eefd3a4e60701fef40f31eacd2e79c1cffe6311.1542477399.git.lorenzo.bianconi@redhat.com>
References: <cover.1542477399.git.lorenzo.bianconi@redhat.com>
        <2eefd3a4e60701fef40f31eacd2e79c1cffe6311.1542477399.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Nov 2018 19:04:27 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Generalize st_lsm6dsx_shub_read_oneshot in order to not use a fixed
> read length and take into account iio channel realbits for single
> read operations
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes since v1:
> - allocate data buffer on the stack instead of using kmalloc
> - stop the sensor even if the read operation fails
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index ee59b0cac84f..8e47dccdd40f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -432,8 +432,8 @@ st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>  			     struct iio_chan_spec const *ch,
>  			     int *val)
>  {
> -	int err, delay, len = ch->scan_type.realbits >> 3;
> -	__le16 data;
> +	int err, delay, len;
> +	u8 data[4];
>  
>  	err = st_lsm6dsx_shub_set_enable(sensor, true);
>  	if (err < 0)
> @@ -442,15 +442,17 @@ st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>  	delay = 1000000 / sensor->odr;
>  	usleep_range(delay, 2 * delay);
>  
> -	err = st_lsm6dsx_shub_read(sensor, ch->address, (u8 *)&data, len);
> -	if (err < 0)
> -		return err;
> +	len = min_t(int, sizeof(data), ch->scan_type.realbits >> 3);
> +	err = st_lsm6dsx_shub_read(sensor, ch->address, data, len);
>  
>  	st_lsm6dsx_shub_set_enable(sensor, false);
>  
> +	if (err < 0)
> +		return err;
> +
>  	switch (len) {
>  	case 2:
> -		*val = (s16)le16_to_cpu(data);
> +		*val = (s16)le16_to_cpu(*((__le16 *)data));
>  		break;
>  	default:
>  		return -EINVAL;
