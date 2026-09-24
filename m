Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A244078C6
	for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287362; cv=none; b=cNiMCepU9P980JcNMZ7cwAxzbH4tGJNr2nZhRXNLeLtpI3mz/jzEeOSBLKWzyHdR0inbv3auJ3sYVhD6QjbR0tCtsbmu6hXkYSBvtsEi+Ls+jHS3ZufuaXTf+sqRIlwBmFHXHrdFhDdleKy5PzvFJIv/jNkSmJLgM+wU6Rqpbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287362; c=relaxed/simple;
	bh=q9Q38rfwg+ndLuv/SnmRyYC3yPpGM/HR1YdJVhzn990=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvD2glxBn23weP40NQxYvs0CM3b60Ycoq6pkMexAsKp7KI+lGmDHPonX46GjxO5JwIgO8psqMpe5DYP7b3C7Gm4oIXlVQE8JxA7hmaj3sswFKZtiZxBy5+kTuxOOAV6yjEKViUHASMTaFqwCpACGXEsg4GlW8+H4Ir6V/K7RaWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqI+X8F/; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqI+X8F/"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so1580425e9.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 15:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790287360; x=1790892160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FxovyPH3Np+Hc1hy5wmf+7gNJx0ZGtqWMTp+L5wj2dg=;
        b=bqI+X8F/fyJDveM3Xvepmg2A9EfwVsQcJ1tL21cPB+8suevU2IfBnNyqKB63QKmqPG
         iLjKYCKMVM1zMS1PLI7dzQHRAEcItMoo96aiZGb73XJB3ihyEZhIeqFtJeCEzFgpx5QZ
         MPEnClbBcDLU+G/UBXYK100F/hlfxSe4otpLOnv2e+3nc4iMme40+I2g0oC3+OZJfdj3
         +ccUm1b71WPlsGsnnlvSxx1iiicJbbfk6MUAWN2192laisQfrTGus5VZdH5eVXYa7V4B
         1e56AjdsYqxgDu7jLDYAv3uXGMIuOOXeptGcxlZE4Zr9f1ZCyLX844us/fn0LgGdKB73
         5VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790287360; x=1790892160;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FxovyPH3Np+Hc1hy5wmf+7gNJx0ZGtqWMTp+L5wj2dg=;
        b=0szumV0jfCXxA+b5JKTWQsKs3OO9lgp9077zviCapQAsxlZzRA077kIId1zFI9jOO+
         WX6mJ1BXq99JZAN4tUS9TMOqSwoiusHo9UfGrzoXaB2tjo3rHBYNqt9AovSB6M8/Hswh
         kantcTTcByAn9w6sdes5ZEuUH229HikDF28oDsp7NpZbl2vauVXtH2ojby9SFsRTV/xt
         WQL91NnTesHOrTydPdBdCsO+5p0ZvTZJCOAgncob8tWLgVa2sPBIcf0k6f706+ZVj9L/
         c5sPTNID1riVFZUyJvvkO9WaS0kdceVCIVOZzff56xNmUIirUCKHlk4a+l5O6HsPvgcB
         pNKA==
X-Forwarded-Encrypted: i=1; AKwUvBxOJtgJOavKYD/6H19We2njaO9c0BtAV+gph7oEzkPbAEpDzB2o/kMw8iYsx5O0SFJ/aIlgqTAF2cI=@vger.kernel.org
X-Gm-Message-State: AFuF++mXjWAj90geNtuzJVJ0PqEztcAd9s2m+3zu7NgqvF9ORN3JnKhq
	PyMXK7DlDpZXWrNkNH54ORoFwTtXTyDoIh1otj/ltttEOPyzYsSbgfNp
X-Gm-Gg: AYBFou2xWqHMSsSzah++itxkzRgF0Llb2LhJyV80F1uSJ9hkkmBWS1kFdQsPYxQZ03N
	EvJfOTG+ViTZTGUbyMFkxJdklwOatfk1yBieXw4lxb/UuBvjPwlcuzD8yn93WoYLRSuYbCga6YQ
	Z8XdSQY8uRcYPMlBzwq043756gR7Z0OKGhtGduV6a+ddx0enWG1ZoQ+EPBOtPPhwqgZkKe+WU03
	2aQj63FOsY2jbKi+z8ZD1W5INajXAkJ/+A+Ev9BzmZ5DsStAnZIA3sSC2qbvZEghcz1urUND+/t
	8GlRLAMT1J8NpNPCRwjW6oQgVQgno3PLTiWImDsbV418XgIX5RXBnqD2LGm2SA9FZPUU1U8IaP4
	FlkBk2Y9WgRX0axqmo+JvNTH/VMNJV8FMP9o7zM+YRjTa2jvEAPIByvTdS9CIyWYnYdNS0ehgEr
	u5X0qn5IgVmlNFNfGbaNbO2CN4VAFfyfupitiTtEioH6b8YcMBz8aTnbof5yg=
X-Received: by 2002:a05:600c:698e:b0:49c:fc6e:a3dc with SMTP id 5b1f17b1804b1-49fe66f1491mr70434555e9.27.1790287359476;
        Thu, 24 Sep 2026 15:02:39 -0700 (PDT)
Received: from gmail.com ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm154421105e9.12.2026.09.24.15.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:02:36 -0700 (PDT)
Date: Fri, 25 Sep 2026 00:02:34 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shi Hao <i.shihao.999@gmail.com>, Joshua Crofts <joshua.crofts1@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <arWccqy8YlLJxeWA@gmail.com>
References: <20260919235145.48273-1-marcus.yu.56@gmail.com>
 <20260919235145.48273-3-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919235145.48273-3-marcus.yu.56@gmail.com>

On Sat, Sep 19, 2026 at 04:51:45PM -0700, Chang Yu wrote:
> +static int as7343_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct as7343_data *data = iio_priv(indio_dev);
> +	struct regmap *map = data->regmap;
> +	struct device *dev = regmap_get_device(map);
> +	unsigned int unused;
> +	__le16 result;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		/* Wait until integration time passes for all 3 cycles. */
> +		msleep(160);

three integration periods hardcoded next to a hardcoded integration
time, so nothing keeps them in sync. make ATIME/ASTEP writable and the
fixed wait no longer covers a readout. as73211, which this is based on,
computes the timeout and polls NDATA. STATUS2 (0x90) bit 6 is AVALID is
defined and never read, does it cover all three cycles? the datasheet
does not say.

> +
> +		/*
> +		 * Reading ASTATUS latches all data registers to this read.
> +		 * We don't care about the returned saturation/gain status for
> +		 * now.
> +		 */
> +		guard(mutex)(&data->mutex);
> +
> +		ret = regmap_read(map, AS7343_ASTATUS_REG, &unused);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_bulk_read(map, chan->address,
> +				       &result, sizeof(result));
> +		if (ret)
> +			return ret;
> +
> +		*val = le16_to_cpu(result);
> +		return IIO_VAL_INT;
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
--
cheers, jose a. p-a
