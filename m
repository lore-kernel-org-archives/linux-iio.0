Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082245349A
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716440; cv=none; b=upmFGD5fTftJ7MGz+iubh5xO5bZrxss/690KkFahoG8a86TI7ffE4FPNXsq7mbyPs3rLB6IWLKQ0n6/0xH3HHWQ6abnCwhfBTZQZcMDFJcjhM+b1XFwhGVOS7KRmzVwLP89Bnf1SBmLiKYhk2j1w9448YNw+6ktxb8J5OO2O1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716440; c=relaxed/simple;
	bh=xIDciGkPDxl+GOsw0EvfaENOKwnEE8x3lxWp++1w/IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZoYp5rbJ5GUx7uDTM57mEihrD9dCNuQ/5Qtn5r40N7TMschydmEBDN1+JAD4RssdWDeKyeoGry43W/S8LbKf9LZ7t6Ki+QhWqHOSFAKgAYyGGiaXPoXgcLQ6Bn+hSO+7Cr1LAsdR/1d0bbIpYorwzCmuo+zrFp0D1+OaXFQVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJv7snLO; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJv7snLO"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1384ebe7a10so40269c88.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781716436; x=1782321236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zkK63x4tm8us5I2Vs4qjhcSV0srfiYOxRPUfwTWSlMI=;
        b=rJv7snLOJQuG8RPtb0+lWgqA3hRNON1a5lGuHZdHZCV5EA0DzdotyQ5lbkrl6ku/4N
         98vxakRQiEdf6uZKVXZy2fOpyR7oKVCoQGOwSafAOHUmd/lKkmBAjXG8zD/WzkjXAhkh
         9HtgTNwbLOJZZUp8OfWc3kVjD6mnf/tm6wrUhPT1/wcblLoLtlll4yBoFcsCVCaNEdKO
         gD+2wD5SSXKjFBIAaqtRf5zt/9dVNC5+i/9Ue0axjkj5gNMxXWTPeoQdDJJ8q5nCBZYR
         z5/6zzW6XWHSlDaUAuH2lYiRIvcjEMGClXrcU6WPp9hJ7H9mtKJnwcTQN1fSKLtYqdYQ
         CdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716436; x=1782321236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkK63x4tm8us5I2Vs4qjhcSV0srfiYOxRPUfwTWSlMI=;
        b=W4zNlersHXZI1wA6A+WNEwrwiM9dvXDuOkhRq9gb2Tlrn9cg8cGw1xg6/JmS6h8T0w
         5rYyk/XlfFnzxXOmF2vmkkM5TxyVM/28Nspw/axsUU6UdqgLxEtqGxQyeBCfuInY20Ol
         LS5OrUUe7KOyADbP+Z4d3iaTCHdnlCD6/juJ1OO52ADN8bzV/LjopBDPMOBN/PtiTnrg
         /ferfoiIMdw6xpqoQBy4OQr9iqTL9vyz4rGpTSJdWQEPbCrlwxTyJfSQTuiIEg4UHqEl
         8WEKLeymACUqai2CYO5JWTOIQvDIEwNasxj7vXaQ3MxysdMjV+6OkKsXULAbQB8lA7OV
         yCMA==
X-Forwarded-Encrypted: i=1; AFNElJ8xrDxSnQkDtnM58+L3R8oD9GOcK8RD0LTLY43m59E23xexmYBiO57RzSssd+GMBKcj9n0iuxvSFtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvBT/OC+d6Jk6fQx9zAUiJMDvz6FHTSbSu38anMCWSGZYhZsKG
	3ETm8L/gsHvCUGN1HhMTO3b9JAkt7VTdVd8BYaQbVqH7eCd7W0j3gXLr
X-Gm-Gg: Acq92OE1QUtSVSSfEeS12Rvw6sWoKYRXENlKLAv/CzA7ZJArX3zuBMhgpoep7nyp2cc
	z8TPm+vhQwD0l7g6w4Scb2RRBJoM75gXAU7xpwavueX3Xt/B4NjCySajUbA27JYzPByQSMki3k3
	SOY5RUbqapRpTCBxVCMJWJfdgblITzhfQ2Oqx6NZIT9iH6Qra1dlE74L1jQ5Addzob6oZ5N46Rb
	zOCZuA2wKS6Z5kDY2sfbnf+JlXn+k1sx/vOpUrccHKQiW/tDrOq98/kXRBPayWnUMgVIWFbGogP
	8StsBVECwd5PvnZmqM0xvLP+kgeoPrRsU/uF33omsxXPWsc1TkUTfOyj4r3enpoba7Pr5Tc9iFB
	JPngFFdUkU8dNuCm7WBYwnv9RJXxf0bU3FlIXoutc3Un3nZrVD8W+aCBqgkgzKx0tvLIX6aGCL3
	YRinGwsOES0d8LWjzfkCDirw==
X-Received: by 2002:a05:7022:f9a:b0:138:576:fd with SMTP id a92af1059eb24-1398f66aeafmr2117301c88.2.1781716436403;
        Wed, 17 Jun 2026 10:13:56 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97bf09sm17285359c88.14.2026.06.17.10.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:13:55 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:14:32 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, pop.ioan-daniel@analog.com
Subject: Re: [PATCH v3 1/5] dt-bindings: iio: adc: Add ltc2378
Message-ID: <ajLV-O60lCdlIbXR@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
 <f9e88abdbd23df8039282497a81d3c8698a10665.1781661028.git.marcelo.schmitt@analog.com>
 <20260617-bok-gains-9a1af41cf0de@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-bok-gains-9a1af41cf0de@spud>

On 06/17, Conor Dooley wrote:
> On Tue, Jun 16, 2026 at 11:03:11PM -0300, Marcelo Schmitt wrote:
> > Document how to describe LTC2378-20 and similar ADCs in device tree.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Change log v2 -> v3:
> > - Re-added device tree fallback compatibles for LTC2378 chips, now with options
> >   to provide a single compatible string or a pair of single compatible string
> >   plus a fallback string to a slower sample rate spec in case a driver for the
> >   specific part is not found.
> > 
> >  .../bindings/iio/adc/adi,ltc2378.yaml         | 160 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 167 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> > new file mode 100644
> > index 000000000000..7d30a2cade8f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> > @@ -0,0 +1,160 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ltc2378.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices LTC2378 and similar Analog to Digital Converters
> > +
> > +maintainers:
> > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > +
> > +description: |
> > +  Analog Devices LTC2378 series of ADCs.
> > +  Specifications can be found at:
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/233818fa.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/236416fa.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/236418f.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/236716fa.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/236718f.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/236816f.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/236818f.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/236918fa.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/237016fa.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/237616fa.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/237618fa.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/237620fb.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/237716fa.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/237718fa.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/237720fb.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/237816fa.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/237818fa.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/237820fb.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/237918fb.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/238016fb.pdf
> > +
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      # Single compatible string match.
> > +      - enum:
> > +          - adi,ltc2338-18
> > +          - adi,ltc2364-16
> > +          - adi,ltc2364-18
> > +          - adi,ltc2367-16
> > +          - adi,ltc2367-18
> > +          - adi,ltc2368-16
> > +          - adi,ltc2368-18
> > +          - adi,ltc2369-18
> > +          - adi,ltc2370-16
> > +          - adi,ltc2376-16
> > +          - adi,ltc2376-18
> > +          - adi,ltc2376-20
> > +          - adi,ltc2377-16
> > +          - adi,ltc2377-18
> > +          - adi,ltc2377-20
> > +          - adi,ltc2378-16
> > +          - adi,ltc2378-18
> > +          - adi,ltc2378-20
> > +          - adi,ltc2379-18
> > +          - adi,ltc2380-16
> > +
> > +      # Low sample rate fallback for 16-bit unipolar sensors.
> > +      - items:
> > +          - enum:
> > +              - adi,ltc2370-16 # 2 MSPS
> > +              - adi,ltc2368-16 # 1 MSPS
> > +              - adi,ltc2367-16 # 500 kSPS
> > +          - const: adi,ltc2364-16 # fallback (250 kSPS)
> 
> Your driver still matches on ltc2370-16, which makes me question the
> value of these fallbacks. That said, the chip info struct contains no
> information about sampling rate.
The info about sample rate is added in patch 4.

> What actually is the impact of the sample rate on the programming model?
If the user tries to set a sample rate beyond the maximum supported, software
can throw an error to indicate that.

> Is there actually a benefit to matching on ltc2370-16, or can you just
> match on the fallback?
The benefit is telling software that it is safe to go up to 2 MSPS. It is also
okay to match on the fallback, but software may restrain operation to a slower
sample rate.

With the code being proposed in this patch set, there is no benefit in matching
the ltc2364-16 fallback if there is a faster ltc2370-16 device connected because
device driver supports that. Though, other operating systems and/or platforms
might not support all device variants and so the fallback might be useful.

> +static const struct ltc2378_chip_info ltc2370_16_chip_info = {
> +	.name = "ltc2370-16",
> +	.resolution = 16,
In a later patch ...
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
+	.tconv_ns = 322,
> +	.bipolar = false,
> +};
> 
> +static const struct ltc2378_chip_info ltc2368_16_chip_info = {
> +	.name = "ltc2368-16",
> +	.resolution = 16,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 527
> +	.bipolar = false,
> +};
> 
> +static const struct ltc2378_chip_info ltc2367_16_chip_info = {
> +	.name = "ltc2367-16",
> +	.resolution = 16,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
> +	.bipolar = false,
> +};
> 
> +static const struct ltc2378_chip_info ltc2364_16_chip_info = {
> +	.name = "ltc2364-16",
> +	.resolution = 16,
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
> +	.bipolar = false,
> +};
> 
...
> > +      # Low sample rate fallback for 20-bit bipolar sensors.
> > +      - items:
> > +          - enum:
> > +              - adi,ltc2378-20 # 1 MSPS
> > +              - adi,ltc2377-20 # 500 kSPS
> > +          - const: adi,ltc2376-20 # fallback (250 kSPS)
> 
> I didn't check these, but I assume they are the same.

Yes, except for small variations on input (unipolar/bipolar) and precision bits,
these devices are pretty much equal.

