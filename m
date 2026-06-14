Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192962882B6;
	Sun, 14 Jun 2026 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781458183; cv=none; b=H+mdv1005s0notZcsD92yAvD6zNR3BZpIgk/kIqN1aK4tNNV+Tt9JB2rhvCcMSU2qI0uhNWAd1JeKQ9t9CyhQge2yqjXNKANPvO5rm+cv4hioKSfknEhDMs+crYOGut4fYOcXgicDfWjaZEgcB9ZS3ibeV2tu6yrpf0l9x8jU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781458183; c=relaxed/simple;
	bh=W4RHr7CNzATJjksaVVMj0nBTfJTnQY74UrUpdl9EdAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMYAPUbOexC0elDlAA4QawNgZCMmcfAucuhJcBDJXPsA+vcjBxoCApJ6VEvZwWfoDJlYJ/lsJCoNiF/95aNVpCdJztLLeaa5Nt7c6PTchTm/ssL0McQ0cNwTiYw4PQpXQ0aE5R78vSXGYhhIEQ9ATXlxOXiqkdd4oATDTZDzUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7ufWW+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7ufWW+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9A01F000E9;
	Sun, 14 Jun 2026 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781458181;
	bh=IxmA6Nwbm3AhJX2C0fPqRWCFFQi1GB0sri3LY6rETAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V7ufWW+JPVlUnIqJdIJ0Spm1JR4ZqJ0QqhETI3GWoEiIQNwcx27XE6drVsonAl8Ph
	 xWyjdBhiiCYwskytXtP363da2AcAgGk4pIuW1KxqNX6/8P5SD7I8wK9+IQ1rFtY0b9
	 mMfD2kcDlb4qFpv/wJq2rQR/MudHWk3liD66FeqeC7P57/QnQSQoyJ0/6bXG5yBSqW
	 pYissOSYKMH4OXrIXmo6yDsiRWE5i5jT++Rw3isohhc9QfCFjSKeQjzFokNepo4Cy9
	 dBJpGjixAGZTdh5drQ/mcarsTayBsaH+M4ZqH+OYVQj7Pu6Aij0OkHbyLeOOqhe52e
	 fFt1v2mhvMZpA==
Date: Sun, 14 Jun 2026 18:29:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 05/12] iio: dac: ad5686: add support for missing
 power supplies
Message-ID: <20260614182930.51e35566@jic23-huawei>
In-Reply-To: <20260609-ad5686-new-features-v2-5-70b423f5c76d@analog.com>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
	<20260609-ad5686-new-features-v2-5-70b423f5c76d@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jun 2026 11:13:00 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Get and enable regulators for vdd, vlogic and vref input power pins. Vdd
> is the input power supply, while vlogic powers the digital side. vref is
> replacing vcc, which is being deprecated, but still supported. The value
> of vref_mv is checked so that a device without internal voltage reference
> cannot proceed without an explicit supply. For correct operation, vdd and
> vlogic are required, then devm_regulator_get_enable() is used so the
> driver can still work without them by using the stub/dummy regulators.
> Error report uses dev_err_probe(), which helps debugging an init issue.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Possibly the comment below falls into the bikeshed colour category.
I'm not really that fussed either way.

> ---
>  drivers/iio/dac/ad5686.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 5840fda4b011..fc3863274b29 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -8,6 +8,8 @@
>  #include <linux/array_size.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/kstrtox.h>
> @@ -484,12 +486,27 @@ int ad5686_probe(struct device *dev,
>  	st->ops = ops;
>  	st->chip_info = chip_info;
>  
> -	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vlogic");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vlogic supply\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (ret == -ENODEV) /* vcc-supply is deprecated, but supported still */
> +		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
>  	if (ret < 0 && ret != -ENODEV)
> -		return ret;
> +		return dev_err_probe(dev, ret, "failed to read vref voltage\n");
>  
>  	st->use_internal_vref = ret == -ENODEV;
I think I'd slightly prefer this as
	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
	if (ret == -ENODEV) /* vcc-supply is deprecated, but supported still */
		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
	if (ret == -ENODEV)
		st->use_internal_vref = true;
	else if (ret < 0)
		return dev_err_probe()...
(which I think is functionally the same).

But if you strongly prefer yours I guess it is readable enough.




>  	st->vref_mv = st->use_internal_vref ? st->chip_info->int_vref_mv : ret / 1000;
> +	if (!st->vref_mv)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "invalid or not provided vref voltage\n");
> +
> +	fsleep(5); /* power-up time */
>  
>  	/* Initialize masks to all ones */
>  	st->pwr_down_mask = ~0;
> 

