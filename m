Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49046 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbcDCKXm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2016 06:23:42 -0400
Subject: Re: [PATCH 1/1] iio: gyro: bmg160: fix buffer read values
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org
References: <1459185346-18600-1-git-send-email-irina.tirdea@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Markus Pargmann <mpa@pengutronix.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5700EF2B.8070807@kernel.org>
Date: Sun, 3 Apr 2016 11:23:39 +0100
MIME-Version: 1.0
In-Reply-To: <1459185346-18600-1-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/16 18:15, Irina Tirdea wrote:
> When reading gyroscope axes using iio buffers, the values
> returned are always 0. In the interrupt handler, the return
> value of the read operation is returned to the user instead
> of the value read. Return the value read to the user.
> 
> This is also fixed in commit 82d8e5da1a33 ("iio:
> accel: bmg160: optimize transfers in trigger handler").
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Ouch.  Applied and marked for stable.

Jonathan
> ---
>  drivers/iio/gyro/bmg160_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 295cf1d..e165ce9 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -781,7 +781,7 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
>  			mutex_unlock(&data->mutex);
>  			goto err;
>  		}
> -		data->buffer[i++] = ret;
> +		data->buffer[i++] = val;
>  	}
>  	mutex_unlock(&data->mutex);
>  
> 

