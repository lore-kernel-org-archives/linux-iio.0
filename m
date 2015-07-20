Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45568 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755553AbbGTRsc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2015 13:48:32 -0400
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"Dogaru, Vlad" <vlad.dogaru@intel.com>
Subject: RE: [PATCH 7/8] iio:magnetometer:bmc150_magn: expand mutex in
 trigger_handler
Date: Mon, 20 Jul 2015 17:48:06 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F06BBD6@irsmsx105.ger.corp.intel.com>
References: <cover.1437090791.git.knaack.h@gmx.de>
 <6b1b2b7f33cc5a9654f32785626a10c8276d73e6.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <6b1b2b7f33cc5a9654f32785626a10c8276d73e6.1437090791.git.knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> Sent: 17 July, 2015 11:53
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Tirdea, Irina; Dogaru, Vlad
> Subject: [PATCH 7/8] iio:magnetometer:bmc150_magn: expand mutex in trigger_handler
> 
> Keep the mutex locked, until the content of data->buffer has been pushed
> out.
> 

Looks good to me.

Acked-by: Irina Tirdea <irina.tirdea@intel.com>

> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index ac0cdbde813b..bdcf49ee75df 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -664,7 +664,6 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
> 
>  	mutex_lock(&data->mutex);
>  	ret = bmc150_magn_read_xyz(data, data->buffer);
> -	mutex_unlock(&data->mutex);
>  	if (ret < 0)
>  		goto err;
> 
> @@ -672,6 +671,7 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
>  					   pf->timestamp);
> 
>  err:
> +	mutex_unlock(&data->mutex);
>  	iio_trigger_notify_done(indio_dev->trig);
> 
>  	return IRQ_HANDLED;
> --
> 2.4.3

