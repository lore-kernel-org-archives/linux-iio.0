Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49591 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755016AbcIRLAW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 07:00:22 -0400
Subject: Re: [PATCH 3/3] iio: common: ssp_sensors: gyro: constify iio_info
 structures
To: Julia Lawall <Julia.Lawall@lip6.fr>
References: <1474023326-24645-1-git-send-email-Julia.Lawall@lip6.fr>
 <1474023326-24645-4-git-send-email-Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <aedf0bb0-e9f0-52e3-9068-d9fbc4181cbe@kernel.org>
Date: Sun, 18 Sep 2016 12:00:20 +0100
MIME-Version: 1.0
In-Reply-To: <1474023326-24645-4-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/09/16 11:55, Julia Lawall wrote:
> Check for iio_info structures that are only stored in the info field of a
> iio_dev structure.  This field is declared const, so iio_info structures
> that have this property can be declared as const also.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct iio_info i@p = { ... };
> 
> @ok@
> identifier r.i;
> struct iio_dev e;
> position p;
> @@
> e.info = &i@p;
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct iio_info e;
> @@
> e@i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct iio_info i = { ... };
> // </smpl>
> 
> The result of size on this file before the change is:
>    text	      data     bss     dec         hex	  filename
>    1245        344       0    1589         635
>    drivers/iio/gyro/ssp_gyro_sensor.o
> 
> and after the change it is:
>    text	     data        bss	    dec	    hex	filename
>    1397       192          0       1589     635
>    drivers/iio/gyro/ssp_gyro_sensor.o
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Applied to the togreg branch of iio.git. Initially pushed out
as testing for the autobuilders to play with them.

Thanks,

Jonathan
> 
> ---
>  drivers/iio/gyro/ssp_gyro_sensor.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/ssp_gyro_sensor.c b/drivers/iio/gyro/ssp_gyro_sensor.c
> index 0a8afdd..1f25f40 100644
> --- a/drivers/iio/gyro/ssp_gyro_sensor.c
> +++ b/drivers/iio/gyro/ssp_gyro_sensor.c
> @@ -74,7 +74,7 @@ static int ssp_gyro_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> -static struct iio_info ssp_gyro_iio_info = {
> +static const struct iio_info ssp_gyro_iio_info = {
>  	.read_raw = &ssp_gyro_read_raw,
>  	.write_raw = &ssp_gyro_write_raw,
>  };
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

