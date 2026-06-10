Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6E21CC58
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079933; cv=none; b=ASVUh35bAxY49IARLbWcdwhZGtnzY2U1uOtf9Jy6P0a7wOn1k7evjWn9J3ayb/3aVQaKM1XC20Pu1kGLN/2FxHiUIMgsl16HqcUxU7XKE+HXsm9SV7Kx8gMeHNz3khugDwtrdKZNTZNGTtUeLvO45GLe9NogpyivhouXx4+5E/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079933; c=relaxed/simple;
	bh=XufgtRG46mdSA4Xe5u8SghU6O2aObVMltjAQFLvDA1A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoAjGUUdwwXqGT5OAIyIeqbH7d3o8Nntx9/E11LlmySid7N98fz8xtL8EC9ByyS+uerW4xtPEyjT7i9KaDGve+AB+9zeUiebTYeH+gtO+kHbkgOtL0Ix9Or1Rh43SiGpRQCOnlpmJ68erBcGIIakKPZek0sZNvA6XrZUVjxEKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCkl4X/a; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCkl4X/a"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bec450b950dso946003466b.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 01:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079931; x=1781684731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7t+E3OPQw+KHv8N8LE2/GMvZZqMpNz2+txgaF9YQSss=;
        b=jCkl4X/agg8S8HrqzM2iNkG4+pxFcg89/rJeuajaH6U7tMFr2fNejhgmWiXgcxumig
         QqxMmcKmraAbMQZ2wQC02vKL1e3G1XwsaQKfi1l5+o/kwvubO88vLEnxlfSP7LnvRPl0
         hZa1mE8VHdooy5T3K5TWJ/EV1MOy9cRtfu4dJHMyU7yCfzasLOJkrORG3kMDRJ2hwEhP
         v39A8bk/Jagchph8Ql3LeROrHL1f7AyBxY86fIvbJaLbElHUjfHEYiiQXIIPPcpSHo/e
         2z1Ec9RY5Bu61q5IV+ARN7bd770gFRxVn8F1GIB9qKHMaxHkkaq7/eTuyT4gRFVYiN0R
         3CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079931; x=1781684731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7t+E3OPQw+KHv8N8LE2/GMvZZqMpNz2+txgaF9YQSss=;
        b=TioTUEQR55/EYfJtP18v0xHntvcUD7C4LKdcnuXuv92pCDu/CPxRa4VhgivbTP1SOJ
         m/sF+P3OYggzydVavW9rTwTrSKuNNlh6e5nKiZcbUWSLUd08SpdMHT1j+wz4fXvVeR66
         nxfPts35T+LF8sncQRGU7SHhLgQ0dQlRYujIN1uPHFQ0pMPFfsdiM+s3MMjVRt4D0qyP
         pK0MJffdcVGrGukR0SGVc4e6kIAhost8O+uJCPvAvbGtFeyOk3Gcb9/5DZkb+s/MQ+n4
         ZOlSWgsU87hRgo/meqyi6tl9pqr1JHfUywHI97/GTcedQm8118dyte61rCJZIxC/SGcR
         g6Kg==
X-Forwarded-Encrypted: i=1; AFNElJ91p3rsTRQK6/u6N+PuRFep9LxmRTil4Lmo8h6DgS2e39ehf3o9TRmiaXU2lxozd4Y5n+rbfoBFjaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS8z7uVD6+znZkXgMK+3ssRpLxf3rltJbin56hYIiIbKbpAFGR
	QFGFiO3nLL9NfH7IeLIFlld/Q82A3axD+fGbnGlDGj3XUopCzsK1LneY
X-Gm-Gg: Acq92OGJ+YyqaBfoPjqYAt2yUWaCeArSLnTfQ/M0tXf5ZHneduh4P3z3HQDZD+6zhVk
	Utc4Yp8KCfhe96YfuaPYKe9BQe5CPMRcUGUXkDnxmJkbE7s3GUYB7V3Vqz/HcrPuc16UkKWl90w
	6YlqciRpzt9U7l8mB7gJc1vHqlyDSowHndVS2LhWjUKuD/cyBnqk1l9oaDrutEslxjJZ67UyFNW
	vdnkB3f9LAKcHo+MvJQYx+kTM362Qf8SdAzN3gkXxEdUYdXFwjHpdidREuaCegHt6UZlmWTpR+O
	zrqMQyDZbKDkTjIENgaguyCpb0iYNu4xqhPaZZN+V8mYRAd5+p2CuSQ20TNGTWwRAunpohv0tdc
	kJ8xNq8Rn5X8u733kREyBYT58n1EPytOTsdAuhYNGHZ8AXBXPU7pbYsW7U9deewH7w1KYEkWxtL
	HSdGC/EUwXDXed8jPFSoq85K4YH3B4AgzMuqecgqMQqUe+oYr9CRYaLAAJNN4n75iB8FxjTHjzn
	bI9GwUAvRxEBcY58nR8sKDzirYfqshKs/dsXgjEesSEOoA5XA==
X-Received: by 2002:a17:907:e113:b0:bfa:f563:929c with SMTP id a640c23a62f3a-bfaf5639aacmr42627266b.17.1781079931011;
        Wed, 10 Jun 2026 01:25:31 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e0280asm1148630966b.33.2026.06.10.01.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:25:30 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 10 Jun 2026 09:25:25 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 12/12] iio: dac: ad5686: add gain control support
Message-ID: <kzfu37rchq7zjus7jpsy745zfvw3zvpz57l7yqvddolwhb4yth@c7qx3pdq7tjy>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
 <20260609-ad5686-new-features-v2-12-70b423f5c76d@analog.com>
 <aihYO_X9YEqabaFi@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aihYO_X9YEqabaFi@ashevche-desk.local>

On 09/06/26 21:15, Andy Shevchenko wrote:
> On Tue, Jun 09, 2026 at 11:13:07AM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Most of the supported devices rely on a GAIN pin to control a 2x
> > multiplier applied to the output voltage. Other devices, e.g. the
> > single-channel ones, provides a gain control through a bit field in the
> > control register. Some designs might have the GAIN pin hardwired to
> > VDD/VLOGIC or GND, which would still be fine for this patch, that allows
> > the scale property to be configurable with two available options.
> > vref_mv field is moved down in the ad5686_state struct, so that
> 
> Slightly better to use same terminology as in C and documentation, id est
> 
> "...the struct ad5686_state, ..."
> 
> > overall size increase is reduced.
> 
> ...
> 
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (val == st->scale_avail[0] && val2 == st->scale_avail[1])
> > +			st->double_scale = false;
> > +		else if (val == st->scale_avail[2] && val2 == st->scale_avail[3])
> > +			st->double_scale = true;
> > +		else
> > +			return -EINVAL;
> > +
> > +		switch (st->chip_info->regmap_type) {
> > +		case AD5310_REGMAP:
> > +			return ad5310_control_sync(st);
> > +		case AD5683_REGMAP:
> > +			return ad5683_control_sync(st);
> > +		case AD5686_REGMAP:
> > +			/*
> > +			 * Even if the gain pin is hardwired on the board, the
> > +			 * user is able to control the scale such that it
> > +			 * matches the actual gain setting.
> 
> Rebalance the line lengths to
> 
> 			 * Even if the gain pin is hardwired on the board,
> 			 * the user is able to control the scale such that
> 			 * it matches the actual gain setting.
> 
> makes it more consistent.

Thanks for looking into this one. I will address sashiko's concern here
as userspace might not be fully aware of hardwired signals.
Will drop this commment. 
 
> > +			 */
> > +			gpiod_set_value_cansleep(st->gain_gpio,
> > +						 st->double_scale ? 1 : 0);
> > +			return 0;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> ...
> 
> > +	unsigned short			vref_mv;
> 
> _mV

Renaming would need to be a separate refactoring patch. I'll just keep
as is and just have the field moved down.

-- 
Kind regards,

Rodrigo Alencar
