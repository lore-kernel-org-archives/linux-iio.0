Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbdFTQsP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Jun 2017 12:48:15 -0400
Date: Tue, 20 Jun 2017 17:48:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michael Stecklein <m-stecklein@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: humidity: hdc100x: document compatible
 HDC10xx devices
Message-ID: <20170620174809.7c3bd480@kernel.org>
In-Reply-To: <1497888066-12652-2-git-send-email-m-stecklein@ti.com>
References: <1497888066-12652-1-git-send-email-m-stecklein@ti.com>
        <1497888066-12652-2-git-send-email-m-stecklein@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 19 Jun 2017 11:01:05 -0500
Michael Stecklein <m-stecklein@ti.com> wrote:

> Include datasheet links, add i2c_device_id entries, and update
> kconfig help for compatible HDC10xx devices: HDC1000, HDC1008,
> HDC1010, HDC1050, and HDC1080.
> 
> Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
Applied to the togreg branch of iio.git. Initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/humidity/Kconfig   |  3 ++-
>  drivers/iio/humidity/hdc100x.c | 11 +++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 14b9ce4..2c0fc9a 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -31,7 +31,8 @@ config HDC100X
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for the Texas Instruments
> -	  HDC1000 and HDC1008 relative humidity and temperature sensors.
> +	  HDC1000, HDC1008, HDC1010, HDC1050, and HDC1080 relative
> +	  humidity and temperature sensors.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called hdc100x.
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index aa17115..6778bc7 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -13,6 +13,12 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>   * GNU General Public License for more details.
>   *
> + * Datasheets:
> + * http://www.ti.com/product/HDC1000/datasheet
> + * http://www.ti.com/product/HDC1008/datasheet
> + * http://www.ti.com/product/HDC1010/datasheet
> + * http://www.ti.com/product/HDC1050/datasheet
> + * http://www.ti.com/product/HDC1080/datasheet
>   */
>  
>  #include <linux/delay.h>
> @@ -414,6 +420,11 @@ static int hdc100x_remove(struct i2c_client *client)
>  
>  static const struct i2c_device_id hdc100x_id[] = {
>  	{ "hdc100x", 0 },
> +	{ "hdc1000", 0 },
> +	{ "hdc1008", 0 },
> +	{ "hdc1010", 0 },
> +	{ "hdc1050", 0 },
> +	{ "hdc1080", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, hdc100x_id);

