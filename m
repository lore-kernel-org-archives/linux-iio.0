Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:44554 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035079AbcIWPWz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2016 11:22:55 -0400
Subject: Re: [PATCH] drivers: iio: max1027: Fix sparse warning: "dubious: x |
 !y"
To: Sandhya Bankar <bankarsandhya512@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <20160923061312.GA5050@localhost.localdomain>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <cdae23c1-66de-6ad7-6f4a-059a78c652f3@metafoo.de>
Date: Fri, 23 Sep 2016 17:22:52 +0200
MIME-Version: 1.0
In-Reply-To: <20160923061312.GA5050@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/23/2016 08:13 AM, Sandhya Bankar wrote:
> Fixing below warning:
> drivers/iio/adc/max1027.c:241:34: warning: dubious: x | !y .
> 
> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>

Hi,

Thanks for the patch. Looks good in general, just one minor detail

> ---
>  drivers/iio/adc/max1027.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 712fbd2..b1fee47 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -238,7 +238,9 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
>  
>  	/* Configure conversion register with the requested chan */
>  	st->reg = MAX1027_CONV_REG | MAX1027_CHAN(chan->channel) |
> -		  MAX1027_NOSCAN | !!(chan->type == IIO_TEMP);
> +		  MAX1027_NOSCAN;
> +	if (chan->type == IIO_TEMP)
> +		st->reg |= 1;

The driver has a symbolic constant defined for this 'MAX1027_TEMP'. Using
this instead of the number makes it clear what the semantic meaning of the
value is.

