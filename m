Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41282 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753806AbcK0LZL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 06:25:11 -0500
Subject: Re: [PATCH] iio: accel: mma8452: define unsigned return values where
 appropriate
To: Martin Kepplinger <martink@posteo.de>
References: <1479758034-19220-1-git-send-email-martink@posteo.de>
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c33b72b4-aaf3-da11-1cda-601f7a4f7d55@kernel.org>
Date: Sun, 27 Nov 2016 11:25:08 +0000
MIME-Version: 1.0
In-Reply-To: <1479758034-19220-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/11/16 19:53, Martin Kepplinger wrote:
> smatch warned:
> 	sval_binop_signed: invalid divide LLONG_MIN/-1
> 
> and this fixes it. It's actually good to have, in order to avoid accidental
> checking for negative return values here.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
I'm assuming the nasty case doesn't actually occur so applied to the togreg branch of iio.git
and pushed out as testing for the autobuilders to play with it.

thanks,

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 0e865a1..fba146f 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -248,7 +248,7 @@ static int mma8452_get_int_plus_micros_index(const int (*vals)[2], int n,
>  	return -EINVAL;
>  }
>  
> -static int mma8452_get_odr_index(struct mma8452_data *data)
> +static unsigned int mma8452_get_odr_index(struct mma8452_data *data)
>  {
>  	return (data->ctrl_reg1 & MMA8452_CTRL_DR_MASK) >>
>  			MMA8452_CTRL_DR_SHIFT;
> @@ -260,7 +260,7 @@ static const int mma8452_samp_freq[8][2] = {
>  };
>  
>  /* Datasheet table: step time "Relationship with the ODR" (sample frequency) */
> -static const int mma8452_transient_time_step_us[4][8] = {
> +static const unsigned int mma8452_transient_time_step_us[4][8] = {
>  	{ 1250, 2500, 5000, 10000, 20000, 20000, 20000, 20000 },  /* normal */
>  	{ 1250, 2500, 5000, 10000, 20000, 80000, 80000, 80000 },  /* l p l n */
>  	{ 1250, 2500, 2500, 2500, 2500, 2500, 2500, 2500 },	  /* high res*/
> 

