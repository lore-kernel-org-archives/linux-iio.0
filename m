Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45324 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754325AbcICQlV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 12:41:21 -0400
Subject: Re: [PATCH] iio: imu: inv_mpu6050: inform the i2c mux core about how
 it is used
To: Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org
References: <1472630560-4905-1-git-send-email-peda@axentia.se>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org,
        Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8a4804d5-3d92-fff0-e48e-beebfb8ba1e2@kernel.org>
Date: Sat, 3 Sep 2016 17:30:45 +0100
MIME-Version: 1.0
In-Reply-To: <1472630560-4905-1-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/08/16 09:02, Peter Rosin wrote:
> The i2c mux core can then take appropriate action depending on if it is
> used for an actual i2c mux, or for an arbitrator or gate. In this case
> it is used as a gate.
> 
> This will make devicetree bindings simpler when they are eventually
> added.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> So, this depends on the i2c-mux-dt-3 branch [1] that Jonathan
> pulled to support the new mpu-3050 gyroscope driver. I had
> planned to submit this post 4.9-rc1, but since the iio tree
> got the prerequisite already, I'm sending it right away.
It's not there yet as the mpu-3050 has to go round again
for other reasons.  As such I haven't yet pulled your branch.
This patch isn't going to justify the pull on it's own.

I'll try and remember to pick it up when Linus gets back with
the final mpu-3050 and I pull your tree in.

If not give me a poke!

Jonathan
> 
> Cheers,
> Peter
> 
> [1] https://github.com/peda-r/i2c-mux.git i2c-mux-dt-3
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 19580d1db597..2c3f8964a3ea 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -126,7 +126,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>  
>  	st = iio_priv(dev_get_drvdata(&client->dev));
>  	st->muxc = i2c_mux_alloc(client->adapter, &client->dev,
> -				 1, 0, I2C_MUX_LOCKED,
> +				 1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
>  				 inv_mpu6050_select_bypass,
>  				 inv_mpu6050_deselect_bypass);
>  	if (!st->muxc) {
> 

