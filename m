Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45696 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbcC1Oh4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 10:37:56 -0400
Subject: Re: [PATCH] Staging: iio: Fix sparse endian warning
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	gregkh@linuxfoundation.org
References: <1458731194-11597-1-git-send-email-ksenija.stanojevic@gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F941C2.7020609@kernel.org>
Date: Mon, 28 Mar 2016 15:37:54 +0100
MIME-Version: 1.0
In-Reply-To: <1458731194-11597-1-git-send-email-ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/03/16 11:06, Ksenija Stanojevic wrote:
> Fix following sparse warning:
> warning: cast to restricted __be16
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject amended to include the driver name.  I do tend to let some through
without whilst being lazy, but it really should give a hint of the scope
of the patch.  I'll be more vigorous about this in future!

Applied to the togreg branch of iio.git, initially pushed out as staging
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7606_spi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
> index d873a51..825da07 100644
> --- a/drivers/staging/iio/adc/ad7606_spi.c
> +++ b/drivers/staging/iio/adc/ad7606_spi.c
> @@ -21,7 +21,8 @@ static int ad7606_spi_read_block(struct device *dev,
>  {
>  	struct spi_device *spi = to_spi_device(dev);
>  	int i, ret;
> -	unsigned short *data = buf;
> +	unsigned short *data;
> +	__be16 *bdata = buf;
>  
>  	ret = spi_read(spi, buf, count * 2);
>  	if (ret < 0) {
> @@ -30,7 +31,7 @@ static int ad7606_spi_read_block(struct device *dev,
>  	}
>  
>  	for (i = 0; i < count; i++)
> -		data[i] = be16_to_cpu(data[i]);
> +		data[i] = be16_to_cpu(bdata[i]);
>  
>  	return 0;
>  }
> 

