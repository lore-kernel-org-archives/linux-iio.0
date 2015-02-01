Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35256 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbbBAKKY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 Feb 2015 05:10:24 -0500
Message-ID: <54CDFB8E.4050407@kernel.org>
Date: Sun, 01 Feb 2015 10:10:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Devendra Naga <devendra.aaru@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH V2 2/2] iio: meter: ade7759: add error handling in _reset
 and _stop_device
References: <1420189375-19854-1-git-send-email-devendra.aaru@gmail.com> <1420189375-19854-2-git-send-email-devendra.aaru@gmail.com>
In-Reply-To: <1420189375-19854-2-git-send-email-devendra.aaru@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/01/15 09:02, Devendra Naga wrote:
> This patch adds the error handling for the value returned from
> ade7759_spi_read_reg_16. With this patch, the following randconfig
> warnings get fixed automatically.
> 
> drivers/staging/iio/meter/ade7759.c:224:6: warning: ‘val’ may be
> used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/staging/iio/meter/ade7759.c:309:6: warning: ‘val’ may be
> used uninitialized in this function [-Wmaybe-uninitialized]
> 
> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
applied to the togreg branch of iio.git - initially pushed out
as testing to let  the autobuilders play with it.

Again, this is now 3.21 material...
> ---
>  Hello, 
> 
>  Please see if this is the error message you wanted.
> 
>  Build tested on next-20141231 with randconfig sent to iio ml,
>  and with allmodconfig.
> 
>  drivers/staging/iio/meter/ade7759.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> index 7d21743..86b5145 100644
> --- a/drivers/staging/iio/meter/ade7759.c
> +++ b/drivers/staging/iio/meter/ade7759.c
> @@ -218,9 +218,12 @@ static int ade7759_reset(struct device *dev)
>  	int ret;
>  	u16 val;
>  
> -	ade7759_spi_read_reg_16(dev,
> +	ret = ade7759_spi_read_reg_16(dev,
>  			ADE7759_MODE,
>  			&val);
> +	if (ret < 0)
> +		return ret;
> +
>  	val |= 1 << 6; /* Software Chip Reset */
>  	ret = ade7759_spi_write_reg_16(dev,
>  			ADE7759_MODE,
> @@ -301,11 +304,18 @@ error_ret:
>  /* Power down the device */
>  static int ade7759_stop_device(struct device *dev)
>  {
> +	int ret;
>  	u16 val;
>  
> -	ade7759_spi_read_reg_16(dev,
> +	ret = ade7759_spi_read_reg_16(dev,
>  			ADE7759_MODE,
>  			&val);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to power down the device, error: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
>  	val |= 1 << 4;  /* AD converters can be turned off */
>  
>  	return ade7759_spi_write_reg_16(dev, ADE7759_MODE, val);
> 

