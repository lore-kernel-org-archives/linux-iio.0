Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7433ED5AC
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145053; cv=none; b=WP8+EQ30FTSRI9TNRzWmut+PM7v0WguM5Py5zIg0Nrw+IFYVlNddkfcgAzzYi08cV2ncGg8+3GRx/pcZM+tXRfTKv+b4yAKd7HgeDx+0YRitkDuVi+fXf3QdSTMGAfQhmzBS9QjRjsaLW+lWFS/w+D0xW53hw9e4wPvjiS4FCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145053; c=relaxed/simple;
	bh=Yt4WhkQ0bfNF3i+Bo8I3umUKuq7qDV0/dN0snQn+DvY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuZv6Kh7GvfQSw52WZVh24/MlATSKW/dtCsB8vyMs47zyThSd56V28Ax2CPOU63IPw0wi6gQayBT6apkH2qJIhtaR4KWAu/BoOf6tlBTP+x4SGfAIG1hk7QYiURaCtR5jaiEJt3l2Ge9qWv6eHAJaV0jAqKiFu7C16R3XkDq6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFIKNIr9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFIKNIr9"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c197e7e4e94so433983366b.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 02:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785145050; x=1785749850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uCfmC301HH+gxHVN5YqFyM0xtUcGcZEvjNT2gWZ/T7c=;
        b=NFIKNIr9gNX6hiLcxyJ1PnERyaIpcHyF4w1xYzgsAxoU+6NWOl2gkrvNE6SHH4e2hs
         cfCdye4jttAfg3z1Ak0YLi15xJf2F37g9j3/TKh5BZJx/K6O2kfnbGXTrPajnqbXfsw3
         gjY6AnR0qMSLN/YK5tFClUa9scK2AkUEh9hQzfveshvt3rohnqcB6KMr7oThXwE9X2ZU
         Aa3tP93nbjYoiako+NEUWCiLuXaNcCrj5RZkeilAoadat+tbPApcpKOqW/Qu0jA7+VlA
         qA7hYv7FGzZ7CG9x29KGEU1KU/P8qlfp0zDtKBDLTh+dyp1qkF8rFC2lKWltjAjLvU4C
         vyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785145050; x=1785749850;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uCfmC301HH+gxHVN5YqFyM0xtUcGcZEvjNT2gWZ/T7c=;
        b=j3lKHqDmHIeoxlWJPZKy8UwPezFJ3uTZxSn0O660CG5wUeA51B0x2k4XcEvKuTiAdB
         XQMFfXTFca54I2Yhk7CyaqHlubPgWCwBy8YF5UayhTT/HkT8BW53lDiicheTGaKFya37
         5Ip3DSPjskujZ4o427wMvl5ZLuxiGG/BzLw9S42ibjW7u0fDRG3tfDUf0PCq6kWRa9Ev
         0Mc12df+UMG+e0EdI5YP8Ngby8VlWMijFc/h7kB4sb3U59JesZaNPm7GzvkFgazJn0Kt
         Mctn/CrG5NX4Hhh/QrS1Fg7jZGsrcA4cqTDVuF+3eeCDeVYiJbiK+UZ8ONvtH3SUj4ai
         gl1A==
X-Gm-Message-State: AOJu0YwGcRo9kESdhIlZ3Vl8ZnHIKA0q1bFcLWdsACOROtfYFmFg3A77
	9vnNE5rt+cXRTGs1/UJWODSJObypAFUv74Cb5UrodS7FCDCMUzXHE6yN
X-Gm-Gg: AR+sD12iYHfJSjLIxgLsLg8aGDrw91NWjYK0YwKge4lo6JORxCfCc9BRPjmvndU/NCm
	6TkakBaTQQyiEpuvRpe6SVLpCsnoPJeiu29h4tYnNQSJPs9HZgDJ+iTQA5BPqo1kEMPyZyOCiwL
	/FTSy2CBHYEDUSkenQvS9OqpMFYG+/LbHhig2ZVUDCEo97USG392dxOHmNcRWQMaOP6t8EFttku
	5XCvIwZB+9bskvwqJ/uCLq2SxhBx+65XbXoo6AIjEmmhoViIDcdWLaZO51XP4ElD85jV8MP20Qr
	/sha2qTT7bIhbZOM59S9z/4SnueCGXF3i3hwc68KAZZF/tWYBPvUIwulwckeQus90F9QLJBiMur
	qitpl/jJLuC5Pk6i8bhcYDIi6FQDb9uiGYZ8eBKTt5ELKumw9IXYvLvo3TnoUfeKO2ykFOXmRCu
	X69vJ+L7Roc23t2cKLIyKZ65YK6tmVvlSsUmOpGpUQnFtWf7BMM8HveqlP8zA5/brL5FbXgcIuw
	5eyDg==
X-Received: by 2002:a17:907:3cc3:b0:c16:2dc0:e1ef with SMTP id a640c23a62f3a-c1f1ebe59c1mr303138166b.14.1785145049847;
        Mon, 27 Jul 2026 02:37:29 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac8c4bsm622684366b.18.2026.07.27.02.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:37:29 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 27 Jul 2026 10:37:26 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v9 10/17] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <k5gfkzynht4d2hqaqhoqbrszah352dblvbopgaxwgwx26maeue@nv3hjwplqqv4>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
 <20260722-ad9910-iio-driver-v9-10-459d1df5ac56@analog.com>
 <20260725233354.369b3fa2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725233354.369b3fa2@jic23-huawei>

On 25/07/26 23:33, Jonathan Cameron wrote:
> On Wed, 22 Jul 2026 16:50:19 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add the core AD9910 DDS driver infrastructure with single tone mode
> > support. This includes SPI register access, profile management via GPIO
> > pins, PLL/DAC configuration from firmware properties, and single tone
> > frequency/phase/amplitude control through IIO attributes.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> ...
> 
> > diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> > new file mode 100644
> > index 000000000000..b41b011af281
> > --- /dev/null
> > +++ b/drivers/iio/frequency/ad9910.c
> 
> ...
> 
> > +static int ad9910_parse_fw(struct ad9910_state *st)
> > +{
> > +	static const char * const refclk_out_drv0[] = {
> > +		"disabled", "low", "medium", "high",
> > +	};
> > +	struct device *dev = &st->spi->dev;
> > +	const char *prop;
> > +	u32 tmp;
> > +	int ret;
> > +
> > +	st->data.pll_enabled = device_property_read_bool(dev, "adi,pll-enable");
> > +	if (st->data.pll_enabled) {
> > +		prop = "adi,charge-pump-current-microamp";
> > +		if (device_property_present(dev, prop)) {
> > +			ret = device_property_read_u32(dev, prop, &tmp);
> > +			if (ret)
> > +				return dev_err_probe(dev, ret, "property read: %s\n", prop);
> > +
> > +			if (tmp < AD9910_ICP_MIN_uA || tmp > AD9910_ICP_MAX_uA)
> > +				return dev_err_probe(dev, -ERANGE,
> > +						     "invalid charge pump current %u\n", tmp);
> > +		} else {
> > +			tmp = AD9910_ICP_MIN_uA;
> > +		}
> > +		st->data.pll_charge_pump_current = tmp;
> > +
> > +		prop = "adi,refclk-out-drive-strength";
> 
> Sashiko did have a question about this.  I didn't care enough about the particular
> combination restrictions on the clock being output, but please have a quick check.
> https://sashiko.dev/#/patchset/20260722-ad9910-iio-driver-v9-0-459d1df5ac56%40analog.com
> 
> If it is possible but nonsensical, add a comment here.

The datasheet states:

	When the PLL is enabled, a buffered clock signal is available at 
	the REFCLK_OUT pin. This clock signal is the same frequency 
	as the REF_CLK input. This is especially useful when a crystal 
	is connected because it gives the user a replica of the crystal 
	clock for driving other external devices

REFCLK_OUT is basically the input to the PLL added some gain. So that is only
applicable when PLL is enabled. By default, st->data.refclk_out_drv is zero
so it is disabled when PLL is not being used.

This DT-property (adi,refclk-out-drive-strength) is also dependent on the
adi,pll-enable property in the bindings.

> > +		if (device_property_present(dev, prop)) {
> > +			ret = device_property_match_property_string(dev, prop,
> > +								    refclk_out_drv0,
> > +								    ARRAY_SIZE(refclk_out_drv0));
> > +			if (ret < 0)
> > +				return dev_err_probe(dev, ret, "property read: %s\n", prop);
> > +
> > +			st->data.refclk_out_drv = ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}

-- 
Kind regards,

Rodrigo Alencar
