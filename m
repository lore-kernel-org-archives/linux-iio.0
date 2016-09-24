Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59529 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754578AbcIXQMv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 12:12:51 -0400
Subject: Re: [PATCH v2] drivers: iio: max1027: Fix sparse warning: "dubious: x
 | !y"
To: Sandhya Bankar <bankarsandhya512@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <20160923200447.GA13617@localhost.localdomain>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ddb19c43-9994-e201-60a6-7195abce332a@kernel.org>
Date: Sat, 24 Sep 2016 17:12:49 +0100
MIME-Version: 1.0
In-Reply-To: <20160923200447.GA13617@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/09/16 21:04, Sandhya Bankar wrote:
> Fixing below warning:
> drivers/iio/adc/max1027.c:241:34: warning: dubious: x | !y .
> 
> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Changes in v2:
> * Using MAX1027_TEMP instead of number.
> 
>  drivers/iio/adc/max1027.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 712fbd2..d601818 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -238,7 +238,9 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
>  
>  	/* Configure conversion register with the requested chan */
>  	st->reg = MAX1027_CONV_REG | MAX1027_CHAN(chan->channel) |
> -		  MAX1027_NOSCAN | !!(chan->type == IIO_TEMP);
> +		  MAX1027_NOSCAN;
> +	if (chan->type == IIO_TEMP)
> +		st->reg |= MAX1027_TEMP;
>  	ret = spi_write(st->spi, &st->reg, 1);
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev,
> 

