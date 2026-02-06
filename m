Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72DB284B26
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391929; cv=none; b=TPx7TLs8QGs131CbgscdAJEnKLX0sKEr9I2wZ4URYjD33yZZVsQnDw0Xp8lsE5ee1O1rSGL4B86ZVjxkynoP3j8k4FopgsssUQzPX4DCR7sHXxXtYVwYNwhFtcijOUZcL3rpaNRWvHAOy9zZUQV5V3DO2ke/xnIQZ+eEZnMYuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391929; c=relaxed/simple;
	bh=GJUsbEyjYgYAMBqZiUQC4tN0BJBESTzqUrOQsHwFNsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxnQaCpH+qdqa9XBkK753jnr4scJX1O9smbRH+ldl1QkPAjCpzOFsy5AR5ClDcStXb6giFB25mE+WUDbSHOS9qAeDQQQTHG0iy23uOyl2eQQSizsYfVXGCxfmVV/0PMkbQZJuyquuMEYUztV8kyUtKCHcT36G2+mVZYV6qLHou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jpdgj8Ps; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpdgj8Ps"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so20536315e9.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770391927; x=1770996727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6Iwe5lFaK8wO5ecGyqSF9mV2cSHfdgCj+i6cKd1quw=;
        b=jpdgj8PsJA9/ng3y/rBQxe1a7F8VW1rfDZdf5Zab3qKRsJ2Jf5EScoL9jRcqKNhDfl
         yGv7jPK/bQYg5X7+03ywMLr7Dd2DvK+AIaXvFKSrMUSz0Bp7qTZPfgafIudP+i7XlRSN
         uas3wI05nni6K7T4tilqL0CXhMVGcBfsjbepi6mb0qgWqmIJVL76Fov0olg5YTMnriJE
         OFJaCT151sa8wX6wzDtVMALPTFVqNr0lW/RqHstWgO2vVFbzl5dXa+Qfyj6GiojWTFKh
         w2K5EXoiexCREj3Pu6m/loID0WwIpCAcURUD60Txu5fwUxGerUj0POX292ic17TAbVkQ
         6xHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770391927; x=1770996727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6Iwe5lFaK8wO5ecGyqSF9mV2cSHfdgCj+i6cKd1quw=;
        b=CPjB/eCw2QWSzv+bu2aA/+ASVadDaZEQXUegtXDJ/pyRGZ7sL5A0cN7gjN9+KE7olC
         wjmqJrjAw5md3+IBlfnqL3k17fm+JSWZmtGaOlxUS9+FRoh+HTo40Uo5h0IobOVY3mnZ
         9BSFMd9c2qXmu1i65l/DOEVp295kId4YB62BnCChbFEQ8Tv+JiUTvg5pPqJjX7DJh5lV
         zBmWh433kab2LVDWLmen5WDebgbrhZ+UaRr2MnRuRz4Yzgt4mZpCgi2qiUOKUWPZo3Jo
         EvXMRd/E/2QgbHRTZRY+9XKw5IhDfrJXcnKBkyjwOezxzQl3NpNvyZWQKnYULyJ2j3u3
         UjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5CVrZGHPKE4Dp8EBRFvptyqK19XxaQ5WNXFFi9c/oBAEOrGtYJsulWeAWZjOVUem6s389O+Ni0eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6F7+l+OkR9LkoDtaTLpLLjAWSgstPHNhWDhI/ttiA+g0RzT1
	aB+hHDuAgsXKElCw0SE09S6Hyj74Rd/6V2CprlF/rcexTr2tdO7/y8Ih/b+g+p/5zsE=
X-Gm-Gg: AZuq6aLx1iouLlaPdlMAPDfN0OZV3atLOjqFMsTthHjdssLN32T/xvET9fSS9SN6DdJ
	cWZASthJP/LHRd1gRXY0R7qGzkb25Y3Jlc08URLWdAUZqQKDYd2/LtdJmnR7BdO3pte9hPP+N1M
	nhjn2tDst19FXJu+0uy46U5+EYgcqG+nApqZiArUzg+TFNMq7q564qFoDN8YrZaZF9jlFOEi7a5
	5tUjFGnU6s1POBh0B6s5ph/Eu8DBG+MSpnjNoV3LkEqXf5GXxy7Hin37aiLYkLg8XfZ3ekNHnJQ
	13y9PcpOE4uoLMAcmtaNW8UUiFQYLuHX+PqtBgkUZ8m1iyhAjAw67vnHfagAXyY5AYZYTmvQ3vP
	TvAcPyz53F41oSazCey95OX/7u9ckO1cfXUYkmitaXR7ZR5hrotD8tEq8A6PTA7OFpuP4Me0fQi
	iwoRZT41FS5dFs9F67
X-Received: by 2002:a05:600c:3b20:b0:47a:9560:ec28 with SMTP id 5b1f17b1804b1-4832020df6amr43330755e9.13.1770391926971;
        Fri, 06 Feb 2026 07:32:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b20fasm7140617f8f.6.2026.02.06.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:32:06 -0800 (PST)
Date: Fri, 6 Feb 2026 18:32:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <aYYJc2d5AwJbc_vV@stanley.mountain>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
 <aYXvP5FLA5BvkoVX@stanley.mountain>
 <aYX016NlTNkJzGdT@smile.fi.intel.com>
 <aYX7tlJ593KBDGW0@stanley.mountain>
 <aYYFba5-ZV8VuZHM@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYYFba5-ZV8VuZHM@smile.fi.intel.com>

On Fri, Feb 06, 2026 at 05:14:53PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 06, 2026 at 05:33:26PM +0300, Dan Carpenter wrote:
> > On Fri, Feb 06, 2026 at 04:04:07PM +0200, Andy Shevchenko wrote:
> > > > drivers/iio/dac/mcp47feb02.c
> > > >     712 static int mcp47feb02_init_scales_avail(struct mcp47feb02_data *data, int vdd_mV,
> > > >     713                                         int vref_mV, int vref1_mV)
> > > >     714 {
> > > >     715         struct device *dev = regmap_get_device(data->regmap);
> > > >     716         int tmp_vref;
> > > >     717 
> > > >     718         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale);
> > > >     719 
> > > >     720         if (data->use_vref)
> > > >     721                 tmp_vref = vref_mV;
> > > >     722         else
> > > >     723                 tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_mV;
> > > >     724 
> > > >     725         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1, tmp_vref, data->scale);
> > > >     726         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X2, tmp_vref * 2, data->scale);
> > > >     727 
> > > >     728         if (data->phys_channels >= 4) {
> > > >     729                 mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale_1);
> > > >     730 
> > > >     731                 if (data->use_vref1 && vref1_mV <= 0)
> > > > --> 732                         return dev_err_probe(dev, vref1_mV, "Invalid voltage for Vref1\n");
> > > >                                                           ^^^^^^^^
> > > > vref1_mV is not a valid error code.
> > > 
> > > Why not? When it's negative I believe the above statement is not true.
> > 
> > I saw this as just sanity checking the input.  vref1_mV is never
> > actually negative.  I don't know if devm_regulator_get_enable_read_voltage()
> > can return less than one millivolt.
> 
>  * In cases where the supply is not strictly required, callers can check for
>  * -ENODEV error and handle it accordingly.
>  *
>  * Returns: voltage in microvolts on success, or an negative error number on failure.
> 
> What did I miss?
> 

drivers/iio/dac/mcp47feb02.c
  1157          if (chip_features->have_ext_vref1) {
  1158                  ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
  1159                  if (ret > 0) {
  1160                          vref1_mV = ret / MILLI;

Potentially, if ret is in the 1-999 range then vref1_mV could be zero,
but it can't be negative.

  1161                          data->use_vref1 = true;
  1162                  } else {
  1163                          dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
  1164                          dev_dbg(dev, "Vref1 is unavailable.\n");
  1165                  }
  1166          }
  1167  
  1168          ret = mcp47feb02_init_ctrl_regs(data);
  1169          if (ret)
  1170                  return dev_err_probe(dev, ret, "Error initialising vref register\n");
  1171  
  1172          ret = mcp47feb02_init_ch_scales(data, vdd_mV, vref_mV, vref1_mV);
                                                                       ^^^^^^^^

  1173          if (ret)
  1174                  return ret;

regards,
dan carpenter
