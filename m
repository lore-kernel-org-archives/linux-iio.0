Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55775 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbcCEOgM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 09:36:12 -0500
Subject: Re: [PATCH v4 1/3] iio:pressure:ms5611: fix oops when probing
 regulator
To: Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1456828051.git.gregor.boirie@parrot.com>
 <3c096730728684f1ce127602179c3ba73cd66cb4.1456828051.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DAEED8.2000009@kernel.org>
Date: Sat, 5 Mar 2016 14:36:08 +0000
MIME-Version: 1.0
In-Reply-To: <3c096730728684f1ce127602179c3ba73cd66cb4.1456828051.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/03/16 10:31, Gregor Boirie wrote:
> When not compiled-in, regulator layer will return a NULL pointer when
> trying to get a reference to any regulator using devm_regulator_get().  As
> IS_ERR() does not consider this an error, the ms5611 probing operation will
> try to enable a NULL regulator, which will invariably cause a kernel
> crash.
> This patch fixes this situation by using devm_regulator_get_optional()
> instead of devm_regulator_get().
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Ideally include a fixes tag with a patch like this...  It makes it easy for those
maintaining stable trees to figure out whether it is 'supposed' to apply to their
trees or not.
> ---
>  drivers/iio/pressure/ms5611_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index 992ad8d..a9c4d49 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -291,8 +291,8 @@ static const struct iio_info ms5611_info = {
>  static int ms5611_init(struct iio_dev *indio_dev)
>  {
>  	int ret;
> -	struct regulator *vdd = devm_regulator_get(indio_dev->dev.parent,
> -	                                           "vdd");
> +	struct regulator *vdd =
> +		devm_regulator_get_optional(indio_dev->dev.parent, "vdd");
Shouldn't have a white space change like this in here.  This doesn't want to
get applied in a hurry unlike the below.  It'll probably be a post merge window
fix now...
>  
>  	/* Enable attached regulator if any. */
>  	if (!IS_ERR(vdd)) {
> @@ -302,6 +302,10 @@ static int ms5611_init(struct iio_dev *indio_dev)
>  			        "failed to enable Vdd supply: %d\n", ret);
>  			return ret;
>  		}
> +	} else {
> +		ret = PTR_ERR(vdd);
> +		if (ret != -ENODEV)
> +			return ret;
>  	}
>  
>  	ret = ms5611_reset(indio_dev);
> 

