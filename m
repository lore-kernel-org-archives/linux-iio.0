Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60660 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbcBUUxw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 15:53:52 -0500
Subject: Re: [PATCH v3 3/6] iio:pressure:ms5611: power regulator support
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1455731233.git.gregor.boirie@parrot.com>
 <62baa1cc0a865049bdd23e03b24a6051463ccc7b.1455731233.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, "Andrew F. Davis" <afd@ti.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CA23DE.80301@kernel.org>
Date: Sun, 21 Feb 2016 20:53:50 +0000
MIME-Version: 1.0
In-Reply-To: <62baa1cc0a865049bdd23e03b24a6051463ccc7b.1455731233.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/02/16 17:52, Gregor Boirie wrote:
> From: Grégor Boirie <gregor.boirie@parrot.com>
> 
> Add support for an optional regulator which, if found into device-tree,
> will power on device at probing time.
> The regulator is declared into ms5611 DTS entry as a "vdd-supply" property.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
This usually only gets done when it first matters to someone. Guessing it
matters to you!

Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/ms5611_core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index acd8e37..992ad8d 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/iio/iio.h>
>  #include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
> @@ -290,6 +291,18 @@ static const struct iio_info ms5611_info = {
>  static int ms5611_init(struct iio_dev *indio_dev)
>  {
>  	int ret;
> +	struct regulator *vdd = devm_regulator_get(indio_dev->dev.parent,
> +	                                           "vdd");
> +
> +	/* Enable attached regulator if any. */
> +	if (!IS_ERR(vdd)) {
> +		ret = regulator_enable(vdd);
> +		if (ret) {
> +			dev_err(indio_dev->dev.parent,
> +			        "failed to enable Vdd supply: %d\n", ret);
> +			return ret;
> +		}
> +	}
>  
>  	ret = ms5611_reset(indio_dev);
>  	if (ret < 0)
> 

