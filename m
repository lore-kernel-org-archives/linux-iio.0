Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55F2F49F1;
	Sat, 21 Mar 2026 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774117639; cv=none; b=ZiPG9OOVcGVNbkVR/Ppb1yfook8FkGqpcUU5F61sYhJFihC3+BZblxFuxVjNfv/kvXMC46CQ6TI30W2qAj/ELRANP/hvdrB+xsjDLzZk/2cpN4cIgHYzwezeyx51sfGeOz5HSExKAGJA7RvAgQg69YEFlYN57FPoqCn6vly1C+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774117639; c=relaxed/simple;
	bh=stbw9ZdEHYAcDyURfuCbdUl0v0vM/YgHTMYwJJ5midU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAFk8cbAwgtKHBXfQtbBNmcocJib7Q/mcVjdcYG45fXSaMZQ+4u2EB2p3iB+Izhhv7D2NgGe1yooIe4CuS9R5TG9tdT2KEX5vTMA/hhEyvOBr/FGDhr6yArSOZ5kBAXaLRdb8vanFe13N6aOATM/oqFCp7IGf5f3KM9KRfnjmG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9Er3M82; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9Er3M82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7DFC19421;
	Sat, 21 Mar 2026 18:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774117639;
	bh=stbw9ZdEHYAcDyURfuCbdUl0v0vM/YgHTMYwJJ5midU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W9Er3M82ln3VlxezKe65sXLEyFLriOJ+nwA87+0gwBm+62Cj6pymLULypKfd7fU0q
	 WyrnSv6qrZetz/ZzDEhGnue/nT8vwc7GHrtN+3mbeun2vVdzaX7kh71eX+YX3Eh/Fa
	 bVmKbRsiSCF52xGSVmxxutslo/o5toukEiWqo6rDKrOnF9DDtad3nHIOldAti0O5ly
	 39ho8Jed/7vzeb4FLwq8o4PXGAr8Mq/2iZdjUyaHLqavYI3ELgu9HSC/y40/cDy6Qr
	 6wc9hT6XtjAb/oU93wc9ns91X3nPEqrwMD0moFwE3uUZ8/VRm9Az8pACx0NDX1A9Hq
	 JNAcQRs69wBeg==
Date: Sat, 21 Mar 2026 18:27:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Archit Anant <architanant5@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: adc: ad799x: cache regulator voltages
 during probe
Message-ID: <20260321182710.1621d1aa@jic23-huawei>
In-Reply-To: <20260318092715.42538-4-architanant5@gmail.com>
References: <20260318092715.42538-1-architanant5@gmail.com>
	<20260318092715.42538-4-architanant5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 14:57:14 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Reading the regulator voltage via regulator_get_voltage() can be a slow
> operation.

Whilst that might be true, it isn't a reason for this change.
Sysfs reads that would cause it to be read are never a particularly
fast path anyway. So drop this first sentence.

> Since the reference voltages for this ADC are not expected to
> change at runtime, it is inefficient to query the regulator API every
> time userspace reads the IIO_CHAN_INFO_SCALE attribute.
> 
> Determine the active reference voltage (either VREF or VCC) during
> probe() and cache it in the state structure. This improves the
> performance of ad799x_read_raw() and removes the dependency on the
> regulator pointers during fast-path reads.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Archit Anant <architanant5@gmail.com>

A suggested alternative approach inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad799x.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 7504bcf627da..ae2ad4bd37cc 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -30,6 +30,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/bitops.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -135,6 +136,9 @@ struct ad799x_state {
>  	u16				config;
>  
>  	unsigned int			transfer_size;
> +
> +	int				vref_uV;
> +
>  	IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
>  };
>  
> @@ -302,14 +306,7 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
>  			GENMASK(chan->scan_type.realbits - 1, 0);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		if (st->vref)
> -			ret = regulator_get_voltage(st->vref);
> -		else
> -			ret = regulator_get_voltage(st->reg);
> -
> -		if (ret < 0)
> -			return ret;
> -		*val = ret / 1000;
> +		*val = st->vref_uV / MILLI;
>  		*val2 = chan->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	}
> @@ -828,9 +825,20 @@ static int ad799x_probe(struct i2c_client *client)
>  			ret = regulator_enable(st->vref);
>  			if (ret)
>  				goto error_disable_reg;
> +			ret = regulator_get_voltage(st->vref);

For vref I don't think we need to keep the regulator around, so you should
be able to use devm_regulator_get_enable_read_voltage() with checking
for -ENODEV to identify it simply isn't there.

It would need a tiny bit of reordering though or a custom
devm_add_action_or_reset() registered callback to ensure that regulator
disable for vcc happens in reverse sequence of what happens on setup.

Anyone think there are actually ordering constraints on these regulators?
Would be fairly unusual for this sort of device, but not impossible.
If not, cleanest option might be;

	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
	if (ret < 0 && ret != -ENODEV){ //get the actual error out the way first.
		return ret;

	if (ret == -ENODEV) {
		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
		if (ret < 0)
			return ret;

		st->vref_uv = ret;
	} else {
		st->vref_uv = ret;
		ret = devm_regulator_get_enabled(dev, "vcc);
		if (ret)
			return ret;
	}

Then no need to undo anything by hand in remove() and no need to keep
a pointer to any regulators around for later.


> +			if (ret < 0)
> +				goto error_disable_vref;
> +			st->vref_uV = ret;
>  		}
>  	}
>  
> +	if (!st->vref) {
> +		ret = regulator_get_voltage(st->reg);
> +		if (ret < 0)
> +			goto error_disable_reg;
> +		st->vref_uV = ret;
> +	}
> +
>  	st->client = client;
>  
>  	indio_dev->name = id->name;

