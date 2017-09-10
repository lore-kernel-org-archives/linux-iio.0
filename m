Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdIJPbC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 11:31:02 -0400
Date: Sun, 10 Sep 2017 16:30:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kepplinger <martink@posteo.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: dln2-adc: initialize local struct before
 using it
Message-ID: <20170910163058.0eefc6ae@archlinux>
In-Reply-To: <20170910124501.30829-1-martink@posteo.de>
References: <20170910124501.30829-1-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 10 Sep 2017 14:45:01 +0200
Martin Kepplinger <martink@posteo.de> wrote:

> struct data is defined and declared locally. Initiliazation has to be done
> manually, so let's add that.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
> 
> This is more of a question actually! Did you have in mind that data is
> not initialized here? If so, please drop this patch. This is just in case
> you implicitely expected data to be zero.
> 

I don't think it matters as the whole structure is filled by the later
code anyway..  Am I missing a path where it isn't?

Jonathan

> 
>  drivers/iio/adc/dln2-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index ab8d6aed5085..452330075b67 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -489,7 +489,7 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
>  	struct {
>  		__le16 values[DLN2_ADC_MAX_CHANNELS];
>  		int64_t timestamp_space;
> -	} data;
> +	} data = { 0 };
>  	struct dln2_adc_get_all_vals dev_data;
>  	struct dln2_adc *dln2 = iio_priv(indio_dev);
>  	const struct dln2_adc_demux_table *t;

