Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE12376488
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388412; cv=none; b=LzgEWBfFZJ8TmTVQjC52SkS8qTj+7RPw2sqe2xtt7nnWudIaLSqusa+Td3ax0vU86oVuI3/7CygoJSdChVsOafxyYuiCs5hGkb41ZPo5FirQKaWbkp1PbpQ2gAHdVa1HiTAXwbzoKctHmCESWdQmfrc9nBT8xgP0VJfnckwu9bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388412; c=relaxed/simple;
	bh=UpEsHBjbzaIXidhx5x6c5BSix3KihvIOkkNuLE5tq20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKUTtsSOw/Cwg1o1KaYUHhaHIgcEhNz2ruCJkPtr5k9uyWkw4w+1d8eIZ8BlQ1L4M2/O4Ovz42101Xt5sW9TRfCyRudt4DEk7GIW4CIAHN08rarzuwjFmvx1G5WEATK8kMP62fNfuT1sgDM7QH2uWQsAsYRtgSAFSx+8l1iroms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lQC4kqFM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQC4kqFM"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so19887665e9.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 06:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770388410; x=1770993210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LpPd/q2Wwhhxl2JhcWauxJQx2stpOFY37r2zvBo2ntc=;
        b=lQC4kqFM68B3lNSCeFHvvrKDed5Yb9As5+s36OvSERKCt1g8JnfjtPa+ZMXvBJp69k
         JPL/2zKqmdVcMHYIAoxt/sU0sJQYOBxurhLfB5N1NDm4eoZpsIuacx4RQyGVg6AfbEnK
         Xl1b0/uf3aXgyesn7GLZedFZ0ix2TYLiW8xcFMbGQ2/9FHgCn0kaFtxT/SEtgXI/20bs
         Xo4p0FUQ8YvCaox2UL1qGZ/S/scXRS/iaitbQwSbfo4DoGWHQUsAS7EcT7vOd+PyTi2z
         MILB3w7B9GEWH9M0Sg8XfNqS2zO/8wCV9f7HA+MBElKzYL3RnF/ifQvEoJLtO2J6l+UU
         5M5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770388410; x=1770993210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpPd/q2Wwhhxl2JhcWauxJQx2stpOFY37r2zvBo2ntc=;
        b=bm7EsLb2c9VckafdSsZ0snfh7+AvKnBR4NAADorw1Pz2IdhCnO32hWsHlKjKwlGqbI
         /6Hnl2cj+n+5nggVw1zLTx1DI5c2Al1mt1lvnJEVyjDtIQo6HjmlgHf+m7nAiWuqM+kE
         huuDBn25ACNuEvXG09nnyeM+FnR9mNh8lMLOy2brXSiANZ8Y9zslEK2ywwKCQfF2iG3H
         6Sivf/eYwb4sPZu+c6kEZX/kJIDG9Wz7WT3ym73Ny/U3dQJWCUHKSd9PnCkWo8R+JfAj
         1IOswmRCRDuHJ8cf32yzLR7/5P8pui516wsmvdkjOLIg9mF5FJUoJgqmxDoAzPqfoOCJ
         zkNw==
X-Forwarded-Encrypted: i=1; AJvYcCUXwDDlbQB/PbOJTNUx+vqoBEI6fnlnxLBtJUWDrL7FSzif50soeq27Z1bNpcF2D6HO81FX1kdfS/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YypcKshpsDhJHLcnH9wWmSA7zRoB/KNnAYw9B00stQjiYJLZjwf
	JwSbqDXHfBtgqIFv5IOpdvnPOqi55zGel3cC9otULaty3OlG88ArdtGaOQi1LBzjT3M=
X-Gm-Gg: AZuq6aLRtAvosuoOKt7yAF6u3o/s1IFaq215FnlaZaBD7ZXAB9OyuFWMmQhuh3w98ce
	9TbB88TQIV4VMU4me07vQlwVUHFh3cPy8O3YXICMX5FPd1k5H9eM4uTqFK8Qeqt0xPaPxbTnycm
	5IgHy3ZbS9eUWmiSYRi+m6aMVQhWWIMuoqt8byyw2vSVpZCjjWZB6pGaHZQDMkRq+xSjrNEy/fB
	VORSOtv9yz5dl9hdb6PCYAP8Kc8e05HBFtad+TM5rUsMsv9OuqGCxJxUFSlfsaC96PZnAil/ggE
	xwPUTg7ZCUzSKXj1xqypmNXhFP+CFkM7XjVxzmop67tRKTXeV9Ec4YUvkSObJ6+ZvBQj2t5qUOZ
	fF0MUME9db7pL6VxZXmHXK7BcHGw8nu3Dn/71aeyJzmf5sZf3Ok2TalynbydxS1RT8NUi8nEpMs
	/1RIQm0NoZU7MdfAwkz8aahAlJH8DZ
X-Received: by 2002:a05:600d:6451:10b0:480:6910:abd1 with SMTP id 5b1f17b1804b1-483202311c6mr32349825e9.18.1770388410196;
        Fri, 06 Feb 2026 06:33:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206cc543sm55739795e9.4.2026.02.06.06.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:33:29 -0800 (PST)
Date: Fri, 6 Feb 2026 17:33:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <aYX7tlJ593KBDGW0@stanley.mountain>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
 <aYXvP5FLA5BvkoVX@stanley.mountain>
 <aYX016NlTNkJzGdT@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYX016NlTNkJzGdT@smile.fi.intel.com>

On Fri, Feb 06, 2026 at 04:04:07PM +0200, Andy Shevchenko wrote:
> > drivers/iio/dac/mcp47feb02.c
> >     712 static int mcp47feb02_init_scales_avail(struct mcp47feb02_data *data, int vdd_mV,
> >     713                                         int vref_mV, int vref1_mV)
> >     714 {
> >     715         struct device *dev = regmap_get_device(data->regmap);
> >     716         int tmp_vref;
> >     717 
> >     718         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale);
> >     719 
> >     720         if (data->use_vref)
> >     721                 tmp_vref = vref_mV;
> >     722         else
> >     723                 tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_mV;
> >     724 
> >     725         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1, tmp_vref, data->scale);
> >     726         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X2, tmp_vref * 2, data->scale);
> >     727 
> >     728         if (data->phys_channels >= 4) {
> >     729                 mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale_1);
> >     730 
> >     731                 if (data->use_vref1 && vref1_mV <= 0)
> > --> 732                         return dev_err_probe(dev, vref1_mV, "Invalid voltage for Vref1\n");
> >                                                           ^^^^^^^^
> > vref1_mV is not a valid error code.
> 
> Why not? When it's negative I believe the above statement is not true.
> 

I saw this as just sanity checking the input.  vref1_mV is never
actually negative.  I don't know if devm_regulator_get_enable_read_voltage()
can return less than one millivolt.

regards,
dan carpenter

