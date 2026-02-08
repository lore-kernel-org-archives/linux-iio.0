Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4414A22154B;
	Sun,  8 Feb 2026 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770579044; cv=none; b=EsQokgYf2xFGRqhMEneD93LqwZH7TW5Ov+gOV4bXR167Lgw17l4MvlvYAGmKEJUr1Rzg07B5jelhStR0XX/6+ysoBdVCe2H+750KLHCueW18/Ym5W9YTpevCPqLSar555nhvjxnTHTXgfpFcL7nr7Lp3sukH+xVED956e0o7/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770579044; c=relaxed/simple;
	bh=lpvhvi+Dl7vLZAGqjMjtZIiGObqGttalcfkjxgZpNcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuEwTBuUSabu+1j0wGWq5AixbfmVofR6FGn2BVARv9aqbbZchowhUNX8tjM3fEANjPmnYtSvG+bdOdfTPYzzApc9lF60LHmDcGqHxRnpDqtSH/1To9eAxkPoYDT6j4SfwGZJHb3wK1E3zxbmf7l8Z3b2gQaI5djQDbQ6Apj7LIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYWNYc8S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYWNYc8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DC5C4CEF7;
	Sun,  8 Feb 2026 19:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770579043;
	bh=lpvhvi+Dl7vLZAGqjMjtZIiGObqGttalcfkjxgZpNcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oYWNYc8SUZTi5ttnCcrpyR5DgZoskKHtFPki+h6pPoGR0n8gD/cABsf7NetHAz2DM
	 HfktywoaIDcfvIWa6hffKkUV1Yb9gS5LdTX+iCZU6mMW5Bx82A1136cn0zY5Po80rw
	 9TCG2LxyRlVNba99NrTFaTznCZHT4xw16AlDvddhSP+hNBRdXLghiGPtwG0pQi+HLH
	 3YAe4/tLyR9nv9y0mqESWyL26iFR+7bYd6yNb7R+tB8DhJTdzcxbRBX8uQD0YYBEuX
	 mvMNMMxf6/CBDgLhbcS1C0WMwc9P0KGJfARMYWibX6YpIfjAi3S5T1W/xTs9CK8dUX
	 nUjQ9zlW7H/UA==
Date: Sun, 8 Feb 2026 19:30:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chris Mason <clm@meta.com>
Subject: Re: [PATCH v6 5/5] iio: adc: ad9467: check for backend capabilities
Message-ID: <20260208193034.7c780426@jic23-huawei>
In-Reply-To: <20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
	<20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Feb 2026 12:24:11 +0000
Tomas Melin <tomas.melin@vaisala.com> wrote:

> Add capability checks for operation with backends that do not necessarily
> support full set of features, but are otherwise compatible with the device.
> This ensures a fully functional device, but with limited capabilities.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
I've mentioned before that I've started messing around with Chris Mason's
set of Claude Code prompts and today I was trying out the new stuff mentioned in:
https://lore.kernel.org/all/b187e0c1-1df8-4529-bfe4-0a1d65221adc@meta.com/


Given this patch set is pretty much ready to merge I asked it to take a look
and it came up with something that certainly merited me taking a look.

 Issue: In ad9467_chan_test_mode_write(), the testmode_on path is guarded
  by IIO_BACKEND_CAP_CALIBRATION but the matching testmode_off path is not.
  On backends without that capability, entering PN test mode succeeds but
  exiting fails with -EOPNOTSUPP, leaving the ADC stuck in test mode.

I may be missing some protection path, but I think it is right and if you
were to set up the test modes with a backend that doesn't support the
relevant functionality you would indeed be able to turn them on but never
off again.

So this might be the first bug in IIO that the LLM found and human's, including
me, missed!  

Thanks Chris! I won't +CC you every time but wanted to acknowledge that your
hard work taming these tools is very useful to me.

Jonathan




> ---
>  drivers/iio/adc/ad9467.c | 67 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 41 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 59c3fa3bcc9b..7a3db36121b0 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -913,7 +913,9 @@ static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
>  		return ret;
>  
>  	guard(mutex)(&st->lock);
> -	return ad9467_calibrate(st);
> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
> +		return ad9467_calibrate(st);
> +	return 0;
>  }
>  
>  static int ad9467_write_raw(struct iio_dev *indio_dev,
> @@ -1119,12 +1121,15 @@ static ssize_t ad9467_chan_test_mode_read(struct file *file,
>  		len = scnprintf(buf, sizeof(buf), "Running \"%s\" Test:\n\t",
>  				ad9467_test_modes[chan->mode]);
>  
> -		ret = iio_backend_debugfs_print_chan_status(st->back, chan->idx,
> -							    buf + len,
> -							    sizeof(buf) - len);
> -		if (ret < 0)
> -			return ret;
> -		len += ret;
> +		if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
> +			ret = iio_backend_debugfs_print_chan_status(st->back,
> +								    chan->idx,
> +								    buf + len,
> +								    sizeof(buf) - len);
> +			if (ret < 0)
> +				return ret;
> +			len += ret;
> +		}
>  	} else if (chan->mode == AN877_ADC_TESTMODE_OFF) {
>  		len = scnprintf(buf, sizeof(buf), "No test Running...\n");
>  	} else {
> @@ -1188,16 +1193,18 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
>  			return ret;
>  
>  		/*  some patterns have a backend matching monitoring block */
> -		if (mode == AN877_ADC_TESTMODE_PN9_SEQ) {
> -			ret = ad9467_backend_testmode_on(st, chan->idx,
> +		if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
> +			if (mode == AN877_ADC_TESTMODE_PN9_SEQ) {
> +				ret = ad9467_backend_testmode_on(st, chan->idx,
>  							 IIO_BACKEND_ADI_PRBS_9A);
> -			if (ret)
> -				return ret;
> -		} else if (mode == AN877_ADC_TESTMODE_PN23_SEQ) {
> -			ret = ad9467_backend_testmode_on(st, chan->idx,
> +				if (ret)
> +					return ret;
> +			} else if (mode == AN877_ADC_TESTMODE_PN23_SEQ) {
> +				ret = ad9467_backend_testmode_on(st, chan->idx,
>  							 IIO_BACKEND_ADI_PRBS_23A);
> -			if (ret)
> -				return ret;
> +				if (ret)
> +					return ret;
> +			}
>  		}
>  	}
>  
> @@ -1263,8 +1270,9 @@ static void ad9467_debugfs_init(struct iio_dev *indio_dev)
>  	if (!st->chan_test)
>  		return;
>  
> -	debugfs_create_file("calibration_table_dump", 0400, d, st,
> -			    &ad9467_calib_table_fops);
> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
> +		debugfs_create_file("calibration_table_dump", 0400, d, st,
> +				    &ad9467_calib_table_fops);
>  
>  	for (chan = 0; chan < st->info->num_channels; chan++) {
>  		snprintf(attr_name, sizeof(attr_name), "in_voltage%u_test_mode",
> @@ -1339,17 +1347,24 @@ static int ad9467_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
> -	if (ret)
> -		return ret;
> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_BUFFER)) {
> +		ret = devm_iio_backend_request_buffer(&spi->dev, st->back,
> +						      indio_dev);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	ret = devm_iio_backend_enable(&spi->dev, st->back);
> -	if (ret)
> -		return ret;
> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_ENABLE)) {
> +		ret = devm_iio_backend_enable(&spi->dev, st->back);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	ret = ad9467_calibrate(st);
> -	if (ret)
> -		return ret;
> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
> +		ret = ad9467_calibrate(st);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)
> 

