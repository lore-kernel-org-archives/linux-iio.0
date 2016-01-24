Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45544 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbcAXQdQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2016 11:33:16 -0500
Subject: Re: [PATCH] iio: pressure: mpl115: fix temperature offset sign
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org
References: <1453306051-8817-1-git-send-email-akinobu.mita@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A4FCCA.80500@kernel.org>
Date: Sun, 24 Jan 2016 16:33:14 +0000
MIME-Version: 1.0
In-Reply-To: <1453306051-8817-1-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/01/16 16:07, Akinobu Mita wrote:
> According to the datasheet, the resolusion of temperature sensor is
> -5.35 counts/C. Temperature ADC is 472 counts at 25C.
> (https://www.sparkfun.com/datasheets/Sensors/Pressure/MPL115A1.pdf
> NOTE: This is older revision, but this information is removed from the
> latest datasheet from nxp somehow)
> 
> Temp [C] = (Tadc - 472) / -5.35 + 25
>          = (Tadc - 605.750000) * -0.186915888
> 
> So the correct offset is -605.750000.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org
Peter,

I'd like your Ack on this given it is your driver.  That way
I can be lazy and not cross check the datasheet myself.

Jonathan
> ---
>  drivers/iio/pressure/mpl115.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> index 138344c..73f2f0c 100644
> --- a/drivers/iio/pressure/mpl115.c
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -118,7 +118,7 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
>  		*val = ret >> 6;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = 605;
> +		*val = -605;
>  		*val2 = 750000;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SCALE:
> 

