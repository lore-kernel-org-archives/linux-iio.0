Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752250AbdGBJ1e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Jul 2017 05:27:34 -0400
Date: Sun, 2 Jul 2017 10:27:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Reno Farnesi <nfarnesi4@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adis16400: Change unsigned to unsigned int
Message-ID: <20170702102730.59895cb8@kernel.org>
In-Reply-To: <20170701215408.27600-1-nfarnesi4@gmail.com>
References: <20170701215408.27600-1-nfarnesi4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  1 Jul 2017 17:54:08 -0400
Reno Farnesi <nfarnesi4@gmail.com> wrote:

> This patch fixes the following checkpatch warnings:
> 
> Prefer 'unsigned int' to bare use of 'unsigned
> 
> Signed-off-by: Reno Farnesi <nfarnesi4@gmail.com>
Applied to the togreg branch of iio.git - initially pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/adis16400_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index fb7c0dbed51c..9b697d35dbef 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -217,7 +217,7 @@ static int adis16400_set_freq(struct adis16400_state *st, unsigned int freq)
>  	return adis_write_reg_8(&st->adis, ADIS16400_SMPL_PRD, val);
>  }
>  
> -static const unsigned adis16400_3db_divisors[] = {
> +static const unsigned int adis16400_3db_divisors[] = {
>  	[0] = 2, /* Special case */
>  	[1] = 6,
>  	[2] = 12,
> @@ -890,7 +890,7 @@ static const struct adis_data adis16400_data = {
>  static void adis16400_setup_chan_mask(struct adis16400_state *st)
>  {
>  	const struct adis16400_chip_info *chip_info = st->variant;
> -	unsigned i;
> +	unsigned int i;
>  
>  	for (i = 0; i < chip_info->num_channels; i++) {
>  		const struct iio_chan_spec *ch = &chip_info->channels[i];

