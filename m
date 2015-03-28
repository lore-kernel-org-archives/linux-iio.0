Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59861 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbC1MNI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 08:13:08 -0400
Message-ID: <55169AD2.3080400@kernel.org>
Date: Sat, 28 Mar 2015 12:13:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Cristina Opriceana <cristina.opriceana@gmail.com>,
	outreachy-kernel@googlegroups.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/2] Staging: iio: Place driver in sleep mode on error
References: <cover.1426981797.git.cristina.opriceana@gmail.com> <ac0d5b2399b00fe9763c7844c726ffad0a65df99.1426981797.git.cristina.opriceana@gmail.com>
In-Reply-To: <ac0d5b2399b00fe9763c7844c726ffad0a65df99.1426981797.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/03/15 00:26, Cristina Opriceana wrote:
> Put device in sleep mode if an error is encountered after
> initialization in order to avoid wasting power.
The patch title should definitely include the name of the driver in question!
Otherwise you'll not generally get reviews from the relevant people.
Staging:iio:hmc5843 Place driver in sleep mode on error during probe.

Also try to cc relevant people and the relevant list.
See MAINTAINERS and you'll notice we have both a list and a
set of designated reviewers who would like to be cc'd on IIO patches.
They may not respond, but if you don't send it to them then they
definitely won't!



Jonathan

> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
> ---
>  drivers/staging/iio/magnetometer/hmc5843_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843_core.c b/drivers/staging/iio/magnetometer/hmc5843_core.c
> index 0074af2..7de19c2 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843_core.c
> @@ -611,7 +611,7 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>  					 hmc5843_trigger_handler, NULL);
>  	if (ret < 0)
> -		return ret;
> +		goto buffer_setup_err;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
> @@ -619,8 +619,12 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
>  
>  	return 0;
>  
> +buffer_setup_err:
> +	hmc5843_set_mode(iio_priv(indio_dev), HMC5843_MODE_SLEEP);
> +	return ret;
>  buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
> +	hmc5843_set_mode(iio_priv(indio_dev), HMC5843_MODE_SLEEP);
>  	return ret;
Single exit path that reverses the ordering of creation.

e.g.
buffer_setup_err:
	hmc_set_mode(iio_priv(indio_dev), HMC5843_MODE_SLEEP);
buffer_cleanup:
	iio_triggered_buffer_cleanup(indio_dev);
	return ret;
>  }
>  EXPORT_SYMBOL(hmc5843_common_probe);
> 

