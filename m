Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934619AbeCGUAD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 15:00:03 -0500
Date: Wed, 7 Mar 2018 19:59:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: hariprasath.elango@gmail.com
Cc: lars@metafoo.de, Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: meter: Remove reduntant __func__ from
 debug print
Message-ID: <20180307195957.436c4c74@archlinux>
In-Reply-To: <20180307053804.13730-1-hariprasath.elango@gmail.com>
References: <20180307053804.13730-1-hariprasath.elango@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed,  7 Mar 2018 11:08:04 +0530
hariprasath.elango@gmail.com wrote:

> From: HariPrasath Elango <hariprasath.elango@gmail.com>
> 
> dev_dbg includes the function name & line number by default when dynamic
> debugging is enabled. Hence__func__ is reduntant here and removed.
> 
> Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Please note that, after discussions with Michael, I'm planning to send
out an email stating these meter drivers will be dropped next cycle
unless we have someone come forward who can test them.

We can't realistically do the work needed to move them out of testing
without a high risk of breaking them and they are 'not suitable
for new designs'.

Ah well, we'll see - someone might care and be able to help

Thanks

Jonathan

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

