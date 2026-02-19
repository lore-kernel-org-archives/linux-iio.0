Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6A2F3C22
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771504740; cv=none; b=UshmSLoZrLOIbefqtpC0pnTii/KAkucHwpTa060T/s29yj+TGsVpfIVkBClLYtu18cwtxJAxB1ncfkUyB1Hz6DKU2e5qVOITNZN3+adZtrX9xUnfLxYkg3oUAHXNA3UD4pGecoErTRDgwyb3RNDlaovv8HFMLfW6qU1gehhLksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771504740; c=relaxed/simple;
	bh=zaEyoKufr8kJjMPlauNC6hFcaNXmh0VL7nMLWJY7Dms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=il7hePE+AzLp53fFiaxxsKzAgsQzT3VOuLpHhWA+2unOePy8wHngRIYceQrVwmQoTypw8/YMqRjsb/UbHpDwBR6oPernqNwsHPHGRECozDCjo/M97f9FcAMvLiX9tjX3KiD8FWF066Wmxjt7yKCSn7sJjNUNsqwQG5DGGqRpFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIZSOYoD; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIZSOYoD"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56641200d6eso1098466e0c.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 04:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771504738; x=1772109538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b/Yeq/h1sK2QWMwvAHMWW/0uWsIY9PKo2xaxo2nKMJU=;
        b=OIZSOYoDia7EmFVoG/umYjRoJBDojJiGAhfJ2qIV0YfcFtDj2LOzj7355Y9RyCy06+
         6R1e0lQpXVUktj6MSO0XosuRbH3vD6/ymlv5R2erRNRish3i8SUtPYfB0GQgHR10t71T
         ctai1O588nyTR+igdUDogAr1KWcBG8UQqhZbwT4HrumZjPnoW66YYEWpSKujmFGsNNwx
         h+a44NyBcqdFQUgl71rMn5ZPylsTHkoxAkpKOSDzDYmuEnvkHIhwtRjdho3dpjG1s7O3
         ADspgEDvZDyT0Lq4A3QGMjfeCaxTtyZuwcf8RBqipgZjIm+0dZP70Stx9q1aHD+us2XI
         +W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771504738; x=1772109538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/Yeq/h1sK2QWMwvAHMWW/0uWsIY9PKo2xaxo2nKMJU=;
        b=RTYSFk8Q8mgPU8YtHLTqtdmKzhAC2TSfzsRgHJtAORlWzE7YzGTnYF5dmtFMhCeBlv
         5GdUtdxOWIcvyA/I4VMDUVCoVmofNxRnP5Bg3M7dfAKtyUMxLAiQJdTu4LyNtXaY2MQo
         fxmhOEmtDXKgELQuOt06qEqlVwQ1tzb+uB+pxoJsAWfsRwGiWXzJ0lEwhvyMWJ+e6n3f
         xBpozmHNjhrsFRNg3c/5ejFfSEigaP0aPpCk+vmYJfna3ThSa6qUn+Ph2sBYKcwvXP9F
         FdXM+ygnD6CpV8bzHqWi/RNqiO/O7LUGrJaKG/k4gMMW9JUhB3sXC6DipnvU+JZtHLTV
         1lEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrou9c46W73dT2UxHwZJUJs8AlnXFwFlm7LcwA5AKqzzlxgtvjeEKrZBlFUkCIwkccb4hqdR89ZPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgK5EyZPdb+9DTgh/R36qQhVXSc7ADZpcNj93p/PVDGSUSJG1
	xkpOvIBzG02lG0k8Bb0G9TzHFgxUR6a3zgfTqALVOLn98K0Km8cvafay
X-Gm-Gg: AZuq6aL+dIlxzi9j591znyVW3cMnHbYKXnsxSeXF9QPhe7oku+G94HMqiVK8GXVh4bG
	re2UUTMWvA8hJIP0U2cZ76KE6jN6kWDQWkQoPT1zjKOxB5Y9J0JFu+o363Yg7YmaZjYppXHnd/m
	QJRY/2MVkYH/O4ZGR9DXoEdbH81U/4VjwUaEO3WvPnTpdByCnqYUrPPIIQwcWfCd/1v9IgC2gHj
	b4HbnCMZW70uiUCVJ8A7MU2epX0ysX9rCpISMvY+Av5zBvFPkjoOJ0Vvh7B6TQX1bBYj/e7uRXp
	zBLYiCYlD9UcW6oa7Pe1/V2wW6V3QtaZDpBrELKVw1b/Z5k/Jo+iJh9VvzLVbtvtXlKLbQjJVZ2
	iOXQfqupERr31vbpxlOZkMt80b1fDS/Xu87RQuSRgC145gV7vxMbkEL5huAs1J/76NpSXqLnPCo
	RQUhREqV3whs+23itS9yElkPt7PFldgGI=
X-Received: by 2002:a05:6122:3214:b0:566:271c:b48d with SMTP id 71dfb90a1353d-56889d4a600mr7345546e0c.18.1771504737800;
        Thu, 19 Feb 2026 04:38:57 -0800 (PST)
Received: from localhost ([2804:30c:942:5700:6773:2626:ab8c:582e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674bfe5ec0sm13742463e0c.5.2026.02.19.04.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 04:38:56 -0800 (PST)
Date: Thu, 19 Feb 2026 09:39:27 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v9 7/8] iio: adc: ad4030: Add support for ADAQ4216 and
 ADAQ4224
Message-ID: <aZcEf75cOHXLKvNm@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1771253601.git.marcelo.schmitt@analog.com>
 <39ebbb49619d5d588efe590560046d747dd46ad5.1771253601.git.marcelo.schmitt@analog.com>
 <aZRikNMXKxW0JjTC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZRikNMXKxW0JjTC@smile.fi.intel.com>

Hi Andy,

On 02/17, Andy Shevchenko wrote:
> On Mon, Feb 16, 2026 at 12:01:12PM -0300, Marcelo Schmitt wrote:
> > ADAQ4216 and ADAQ4224 are similar to AD4030, but feature a PGA circuitry
> > that scales the analog input signal prior to it reaching the ADC. The PGA
> > is controlled through a pair of pins (A0 and A1) whose state define the
> > gain that is applied to the input signal.
> > 
> > Add support for ADAQ4216 and ADAQ4224. Provide a list of PGA options
> > through the IIO device channel scale available interface and enable control
> > of the PGA through the channel scale interface.
> 
...
> > +static int ad4030_setup_pga(struct device *dev, struct iio_dev *indio_dev,
> > +			    struct ad4030_state *st)
> > +{
> > +	unsigned int i;
> > +	int pga_gain_dB;
> > +	int ret;
> > +
> > +	ret = device_property_read_u32(dev, "adi,pga-gain-db", &pga_gain_dB);
> > +	if (ret == -EINVAL) {
> 
> Actually instead of custom error hunting, this should be rather

Sorry, I messed up when preparing the patches. "adi,pga-gain-db" is not going
to be a dt property and this should have been just the 'GPIOs for PGA control'
below. Anyway, thanks for reviewing this. I'll hopefully recall this error
handling pattern in future contributions.

The other suggestions look good but I'll wait a bit more before sending v10.
> 
> 	if (device_property_present(dev, "adi,pga-gain-db")) {
> 		ret = device_property_read_u32(dev, "adi,pga-gain-db", &pga_gain_dB);
> 		if (ret)
> 			return dev_err_probe(dev, ret, "Failed to get PGA value.\n");
> 	} else {
> 
> > +		/* Setup GPIOs for PGA control */
> > +		st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
> > +		if (IS_ERR(st->pga_gpios))
> > +			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
> > +					     "Failed to get PGA gpios.\n");
> > +
> > +		if (st->pga_gpios->ndescs != ADAQ4616_PGA_PINS)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "Expected 2 GPIOs for PGA control.\n");
> > +
> > +		st->scale_avail_size = ARRAY_SIZE(adaq4216_hw_gains_db);
> > +		st->pga_index = 0;
> > +		return 0;
> 
> > +	} else if (ret) {
> > +		return dev_err_probe(dev, ret, "Failed to get PGA value.\n");
> > +	}
> 
... 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
Thanks,
Marcelo
