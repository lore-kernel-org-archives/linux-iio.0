Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752178AbdI3R4n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 13:56:43 -0400
Date: Sat, 30 Sep 2017 18:56:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Harinath Nampally <harinath922@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, amsfield22@gmail.com,
        martink@posteo.de
Subject: Re: [PATCH] iio: accel: mma8452: Rename structs holding event
 configuration registers to more appropriate names.
Message-ID: <20170930185638.289ff0bf@archlinux>
In-Reply-To: <1506275376-5037-1-git-send-email-harinath922@gmail.com>
References: <1506275376-5037-1-git-send-email-harinath922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 24 Sep 2017 13:49:36 -0400
Harinath Nampally <harinath922@gmail.com> wrote:

> Improves code readability, no impact on functionality.
> 
> Signed-off-by: Harinath Nampally <harinath922@gmail.com>

I'm unconvinced by this one.  At some point we have to map from the
devices own description to that of IIO. The naming currently does
this when the structures are created - all this rename does is
push this remapping of naming down into the functions.

If others thing this helps then I don't really care either way..

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 6194169..3472e7e 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -135,7 +135,7 @@ struct mma8452_event_regs {
>  		u8 ev_count;
>  };
>  
> -static const struct mma8452_event_regs ev_regs_accel_falling = {
> +static const struct mma8452_event_regs ff_mt_ev_regs = {
>  		.ev_cfg = MMA8452_FF_MT_CFG,
>  		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
>  		.ev_cfg_chan_shift = MMA8452_FF_MT_CHAN_SHIFT,
> @@ -145,7 +145,7 @@ static const struct mma8452_event_regs ev_regs_accel_falling = {
>  		.ev_count = MMA8452_FF_MT_COUNT
>  };
>  
> -static const struct mma8452_event_regs ev_regs_accel_rising = {
> +static const struct mma8452_event_regs trans_ev_regs = {
>  		.ev_cfg = MMA8452_TRANSIENT_CFG,
>  		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
>  		.ev_cfg_chan_shift = MMA8452_TRANSIENT_CHAN_SHIFT,
> @@ -777,12 +777,12 @@ static int mma8452_get_event_regs(struct mma8452_data *data,
>  					& MMA8452_INT_TRANS) &&
>  				(data->chip_info->enabled_events
>  					& MMA8452_INT_TRANS))
> -				*ev_reg = &ev_regs_accel_rising;
> +				*ev_reg = &trans_ev_regs;
>  			else
> -				*ev_reg = &ev_regs_accel_falling;
> +				*ev_reg = &ff_mt_ev_regs;
>  			return 0;
>  		case IIO_EV_DIR_FALLING:
> -			*ev_reg = &ev_regs_accel_falling;
> +			*ev_reg = &ff_mt_ev_regs;
>  			return 0;
>  		default:
>  			return -EINVAL;

