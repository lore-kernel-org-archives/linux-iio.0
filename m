Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35938 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeCGFRX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Mar 2018 00:17:23 -0500
From: "<Hariprasath Elango>" <hariprasath.elango@gmail.com>
Date: Wed, 7 Mar 2018 10:47:10 +0530
To: hariprasath.elango@gmail.com
Cc: lars@metafoo.de, Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: Remove reduntant __func__ from debug
 print
Message-ID: <20180307051710.GA13147@hariprasath>
References: <20180307051005.13038-1-hariprasath.elango@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180307051005.13038-1-hariprasath.elango@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 07, 2018 at 10:40:05AM +0530, hariprasath.elango@gmail.com wrote:
> From: HariPrasath Elango <hariprasath.elango@gmail.com>
> 
> dev_dbg includes the function name & line number by default when dynamic
> debugging is enabled. Hence__func__ is reduntant here and removed.
> 
> Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7758_trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
> index 1f0d1a0..da489ae 100644
> --- a/drivers/staging/iio/meter/ade7758_trigger.c
> +++ b/drivers/staging/iio/meter/ade7758_trigger.c
> @@ -34,7 +34,7 @@ static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  
> -	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
> +	dev_dbg(&indio_dev->dev, "(%d)\n", state);
>  	return ade7758_set_irq(&indio_dev->dev, state);
>  }
>  
> -- 
> 2.10.0.GIT
> 

Please ignore this patch as the subject line is wrong. It should be
'meter' and not 'adc.
