Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:60596 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643AbcEaOy0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 31 May 2016 10:54:26 -0400
Subject: Re: [PATCH] iio: as3935: improve error reporting in as3935_event_work
To: Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>
References: <1464619938-988956-1-git-send-email-arnd@arndb.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Brown <broonie@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <574DA582.50408@ti.com>
Date: Tue, 31 May 2016 09:53:54 -0500
MIME-Version: 1.0
In-Reply-To: <1464619938-988956-1-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/30/2016 09:52 AM, Arnd Bergmann wrote:
> gcc warns about a potentially uninitialized variable use
> in as3935_event_work:
> 
> drivers/iio/proximity/as3935.c: In function ‘as3935_event_work’:
> drivers/iio/proximity/as3935.c:231:6: error: ‘val’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This case specifically happens when spi_w8r8() fails with a
> negative return code. We check all other users of this function
> except this one.
> 
> As the error is rather unlikely to happen after the device
> has already been initialized, this just adds a dev_warn().
> Another warning already existst in the same function, but is

                            ^^ typo

> missing a trailing '\n' character, so I'm fixing that too.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iio/proximity/as3935.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index f4d29d5dbd5f..b49e3ab5730a 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -224,10 +224,16 @@ static void as3935_event_work(struct work_struct *work)
>  {
>  	struct as3935_state *st;
>  	int val;
> +	int ret;
>  
>  	st = container_of(work, struct as3935_state, work.work);
>  
> -	as3935_read(st, AS3935_INT, &val);
> +	ret = as3935_read(st, AS3935_INT, &val);
> +	if (ret) {
> +		dev_warn(&st->spi->dev, "read error\n");

Maybe I'm misunderstanding the commit message, why does this error not
use dev_err()? A read error here would be rather serious, it might even
be worth it to return a code and fail through the caller too.

> +		return;
> +	}
> +
>  	val &= AS3935_INT_MASK;
>  
>  	switch (val) {
> @@ -235,7 +241,7 @@ static void as3935_event_work(struct work_struct *work)
>  		iio_trigger_poll(st->trig);
>  		break;
>  	case AS3935_NOISE_INT:
> -		dev_warn(&st->spi->dev, "noise level is too high");
> +		dev_warn(&st->spi->dev, "noise level is too high\n");
>  		break;
>  	}
>  }
> 
