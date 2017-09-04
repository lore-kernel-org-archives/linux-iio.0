Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:5958 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753751AbdIDP05 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Sep 2017 11:26:57 -0400
Date: Mon, 4 Sep 2017 16:26:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dragos Bogdan <dragos.bogdan@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio:ad7793: Fix the serial interface reset
Message-ID: <20170904162613.00003d47@huawei.com>
In-Reply-To: <20170904150048.12420-1-dragos.bogdan@analog.com>
References: <20170904150048.12420-1-dragos.bogdan@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 4 Sep 2017 18:00:48 +0300
Dragos Bogdan <dragos.bogdan@analog.com> wrote:

> The serial interface can be reset by writing 32 consecutive 1s to the device.
> The value of 'ret' is overwritten when ad7793_check_platform_data() is called,
> so it should be initialized to -1 only before doing the spi_write().
> 
> Fixes: commit 2edb769d246e ("iio:ad7793: Add support for the ad7798 and ad7799")
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>

Hi Dragos,

I'd prefer we introduced a separate variable.  Using ret for this
is what got us into trouble in the first place.

Would you mind respining with that change?

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7793.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index e6706a09e100..8680abf72dd2 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -257,7 +257,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
>  	unsigned int vref_mv)
>  {
>  	struct ad7793_state *st = iio_priv(indio_dev);
> -	int i, ret = -1;
> +	int i, ret;
>  	unsigned long long scale_uv;
>  	u32 id;
>  
> @@ -266,6 +266,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
>  		return ret;
>  
>  	/* reset the serial interface */
> +	ret = -1;
>  	ret = spi_write(st->sd.spi, (u8 *)&ret, sizeof(ret));
>  	if (ret < 0)
>  		goto out;

