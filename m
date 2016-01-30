Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52961 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756372AbcA3OWM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 09:22:12 -0500
Subject: Re: [PATCH] iio: ade7753: avoid uninitialized data
To: Arnd Bergmann <arnd@arndb.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
References: <1453737174-1959778-1-git-send-email-arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACC712.1020402@kernel.org>
Date: Sat, 30 Jan 2016 14:22:10 +0000
MIME-Version: 1.0
In-Reply-To: <1453737174-1959778-1-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/01/16 15:52, Arnd Bergmann wrote:
> The ade7753_spi_read_reg_16() will either successfully read a value
> from SPI, or return a failure code without delivering data. However,
> the ade7753_stop_device() and ade7753_reset() functions use the returned
> data without checking for an error condition first. Gcc detects this
> as a possible bug and warns about it:
> 
> drivers/staging/iio/meter/ade7753.c: In function 'ade7753_remove':
> drivers/staging/iio/meter/ade7753.c:348:6: error: 'val' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   val |= BIT(4);  /* AD converters can be turned off */
>       ^
> drivers/staging/iio/meter/ade7753.c:345:6: note: 'val' was declared here
>   u16 val;
>       ^
> drivers/staging/iio/meter/ade7753.c: In function 'ade7753_probe':
> drivers/staging/iio/meter/ade7753.c:222:6: error: 'val' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> In both cases, we can avoids the warning by checking the return code
> before using the data.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Thanks.

Applied to the togreg branch of iio.git - initially pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/meter/ade7753.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index f129039bece3..69287108f793 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -217,8 +217,12 @@ error_ret:
>  static int ade7753_reset(struct device *dev)
>  {
>  	u16 val;
> +	int ret;
> +
> +	ret = ade7753_spi_read_reg_16(dev, ADE7753_MODE, &val);
> +	if (ret)
> +		return ret;
>  
> -	ade7753_spi_read_reg_16(dev, ADE7753_MODE, &val);
>  	val |= BIT(6); /* Software Chip Reset */
>  
>  	return ade7753_spi_write_reg_16(dev, ADE7753_MODE, val);
> @@ -343,8 +347,12 @@ error_ret:
>  static int ade7753_stop_device(struct device *dev)
>  {
>  	u16 val;
> +	int ret;
> +
> +	ret = ade7753_spi_read_reg_16(dev, ADE7753_MODE, &val);
> +	if (ret)
> +		return ret;
>  
> -	ade7753_spi_read_reg_16(dev, ADE7753_MODE, &val);
>  	val |= BIT(4);  /* AD converters can be turned off */
>  
>  	return ade7753_spi_write_reg_16(dev, ADE7753_MODE, val);
> 

