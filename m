Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751021AbdJAKsS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Oct 2017 06:48:18 -0400
Date: Sun, 1 Oct 2017 11:40:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: Re: [PATCH 1/4] iio: imu: st_lsm6dsx: convert max_fifo_size in fifo
 words
Message-ID: <20171001114044.48521531@archlinux>
In-Reply-To: <20170927192928.16160-2-lorenzo.bianconi@st.com>
References: <20170927192928.16160-1-lorenzo.bianconi@st.com>
        <20170927192928.16160-2-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 27 Sep 2017 21:29:25 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Express max fifo depth in fifo words instead of in bytes.
> That change will be necessary to properly support more devices
> in st_lsm6dsx driver
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

I'm not sure the term words really applies here.  Fifo entries maybe?
We are talking about a set of sample I think?

Other than terminology the patch is fine.

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index debf4064f474..e6e0363cd1c2 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -156,21 +156,21 @@ static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  	{
>  		.wai = 0x69,
> -		.max_fifo_size = 8192,
> +		.max_fifo_size = 1365,
>  		.id = {
>  			[0] = ST_LSM6DS3_ID,
>  		},
>  	},
>  	{
>  		.wai = 0x69,
> -		.max_fifo_size = 4096,
> +		.max_fifo_size = 682,
>  		.id = {
>  			[0] = ST_LSM6DS3H_ID,
>  		},
>  	},
>  	{
>  		.wai = 0x6a,
> -		.max_fifo_size = 4096,
> +		.max_fifo_size = 682,
>  		.id = {
>  			[0] = ST_LSM6DSL_ID,
>  			[1] = ST_LSM6DSM_ID,
> @@ -462,10 +462,9 @@ static int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
> -	int err, max_fifo_len;
> +	int err;
>  
> -	max_fifo_len = hw->settings->max_fifo_size / ST_LSM6DSX_SAMPLE_SIZE;
> -	if (val < 1 || val > max_fifo_len)
> +	if (val < 1 || val > hw->settings->max_fifo_size)
>  		return -EINVAL;
>  
>  	err = st_lsm6dsx_update_watermark(sensor, val);

