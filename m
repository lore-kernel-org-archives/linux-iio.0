Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38172 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbbHVSAi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2015 14:00:38 -0400
Subject: Re: [PATCH 11/18] iio: adc: max1027: Set struct spi_driver
 .of_match_table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-12-git-send-email-javier@osg.samsung.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Masanari Iida <standby24x7@gmail.com>,
	linux-iio@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D8B8BE.8030602@kernel.org>
Date: Sat, 22 Aug 2015 19:00:30 +0100
MIME-Version: 1.0
In-Reply-To: <1440054451-1223-12-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/15 08:07, Javier Martinez Canillas wrote:
> The driver has an OF id table but the .of_match_table is not set so
> the SPI core can't do an OF style match and the table was unused.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Applied to the togreg branch of iio.git

Thanks,

Joanthan
> ---
> 
>  drivers/iio/adc/max1027.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 44bf815adb6c..54a8302aaace 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -508,6 +508,7 @@ static int max1027_remove(struct spi_device *spi)
>  static struct spi_driver max1027_driver = {
>  	.driver = {
>  		.name	= "max1027",
> +		.of_match_table = of_match_ptr(max1027_adc_dt_ids),
>  		.owner	= THIS_MODULE,
>  	},
>  	.probe		= max1027_probe,
> 

