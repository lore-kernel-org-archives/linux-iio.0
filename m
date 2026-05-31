Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9F3314B9
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780271977; cv=none; b=WK2sxmNnzUxXILBQflMknOpbSCDYdEvI+a95Cu4PtOU5iJ7qNA3bsSrZy0sf/QDoSKupNBAwDnznm1GlvZbzgn0rv2JLXP/gqXPJFFEPBBscI0lmmKKnXEZcNmTdvFXGkfFhexgNn7HEkpGQnYuALJweiLquR25j4r8KOrZk1wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780271977; c=relaxed/simple;
	bh=g5jy42hBp/hoNV//YEAgI+RIQwM6LSbOBEP4dyQoREs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ki6g854LRGvdemCj4OFe8oCEmLiUgnAvScRAVkqyoq7r9veB3DT6/I3Lu2YY7+4wufXitJSywNgqxJ/pHVDBUE7sgZhsihDr34IkADOcCbuBkQ36DPpouyz2RQVSCDeGhP5NBqn/w/C4LAcY4992fpjGsQC9FKYE2+r8ye49blA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdBpnZk8; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdBpnZk8"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43b6f782cfaso4048544fac.3
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 16:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780271974; x=1780876774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE4mCARgYwymCUjuCV4JjyAJstLarID3EgjEBx1+3V4=;
        b=DdBpnZk8754194IacjbkGuBL40eAMVOiRBa8OLi+GHgFuUAsc3gvOIUxtQEm+MYRiK
         ZCwVCJee6/5xySAN+DXSCog6htd+6bwEZXE/s1n6xa6rkhRfcY3KxtpC/XEfUP63XCxs
         87CjPP131FbB7CNnLwcvZtrWRBakuPlk/m1IrDiKUHMJ12jbhC0/Yx1/ovTiTZeWN9lq
         R6Kf1SA4Ykv0npcKaDe+gSFgFjdMcJP5lfOlVzrBrqrAuEg+Cnc2o7jpDe/n2ZWrXfOg
         W0o+mNSvDAabVkaKRDkFzT9NInoTmdBbta6u3WwxUJF+bclV5BQkAYARzJSRweqnyQuO
         OsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780271974; x=1780876774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jE4mCARgYwymCUjuCV4JjyAJstLarID3EgjEBx1+3V4=;
        b=HTUqQNVVinLcQmW3h8O04No9+VEXD779Us17Tbp34PY7Ee1798xEVoxZ5+E8xY3bM5
         RW0u+nuM3J9Z1ghien4IeA5YKuVxcQJ/T2rG3+iH9k3LmctgH750pFiPFDcqRwTDUeNj
         yE0MAmSWahGx5wg4k7hj9Lwryww+NgturmVTShZmkOYgyAFPsyhpm5TzuGX1Qs8kkNuY
         pG1aJ97yxFyK1pAEZfgZdpctcivXBYSC+OdLAFxhGRvTHRO6Jv/KaXZHSpFhGJJY+Y2J
         YTg5/GBo+rRnb0IxZ1074ZvXtCcvT3pEkcEQ8S22bcLLceGX4hZu9peI+OhAMZ3PucCt
         dVQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dyT28JHkh9Y0YbWtQSBQ8ivs3+nFLN7Xbg+yc8SkpcMhQzdE7EfoqARcUtruBSds5pBrxnBsu3IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywSst6mwVfmKne/xiZ1urUr77QxpE10Rwy3kGZkok4gTbtACv9
	mWMBf/VGWiGGxJB/gjgqO0YhyO25/TPlE7QpQ2czd3SRJw5CW57prZ9LzR1sIZT+X10=
X-Gm-Gg: Acq92OHR0BBDoPGj+Y7fvy/FKgci4JhnQOlUpqX3KQqyIJxtNphq8jDuMfGM3Ed+5lA
	BwRW9RknmEUN6NEBMQABpF3bIJVoJ+He0R2U32g48NNrH/JRCobYe6ulaFYQt5LPTdZQnXWc2+j
	v+PYXQF8y5s4zPQbNUA888n0kldbrZhwJ8GwqqFTwV41fXfTaxgxJAc/lqqvPmgujqfZMRXySvr
	KxIG5q51ndXLtt9Nq+B0kiXtPfjnV3bbzr1Clzc836RhU6MLWS2tEt49tnoENSSRsseSSW0JAvq
	jS4Xo6UB3eTW6vQSx2cSYLRPoObF3Rbtp/WBVKHEKDid1lpSMrMXMHJPX/TjnF/aEqq2xcivYQD
	QSWjh0bbMBzxD+6x44HfgVFOz3BBhmY09+wz2smz2fa1jdVQHF1OlqP6npxXWO98ouKS7CFRwhJ
	nMqX70PKs+BrW3Bj4SAND4wRvL2dk873awBLfgenBW4ZHS0ZI2dYOmOQoksCSctMw=
X-Received: by 2002:a05:6870:658e:b0:417:392e:4e67 with SMTP id 586e51a60fabf-43ca4247a42mr4605423fac.20.1780271974352;
        Sun, 31 May 2026 16:59:34 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c93ae5342sm6468385fac.7.2026.05.31.16.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:59:33 -0700 (PDT)
Date: Sun, 31 May 2026 18:59:31 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: flow: add Sensirion SLF3S liquid flow
 sensor driver
Message-ID: <20260531185931.1bcda47c@linuxescape>
In-Reply-To: <20260530205435.37326-4-wafgo01@gmail.com>
References: <20260530205435.37326-1-wafgo01@gmail.com>
	<20260530205435.37326-4-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Wadim,

On Sat, 30 May 2026 22:54:32 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> Add a driver for the Sensirion SLF3S family of digital
> liquid-flow sensors on I2C.  Currently supported variants are
> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B; they share the same
> register map and differ only in flow-scale factor and calibrated
> measurement range.  The variant (and therefore the scale) is
> auto-detected from the product-information register at probe time.
> 
> Each measurement frame returns a 16-bit signed flow value, a
> 16-bit signed temperature reading and a status word, each
> protected by a CRC-8 byte.  The driver exposes the flow rate as
> IIO_VOLUMEFLOW and the temperature as IIO_TEMP via the standard
> IIO read_raw / read_scale interface.
> 
> The active calibration medium can be switched at runtime between
> the factory-calibrated water and isopropyl-alcohol modes via the
> in_volumeflow_medium sysfs attribute; the sensor starts in water
> mode after probe.
> 
> This driver also creates the drivers/iio/flow/ subdirectory and
> the corresponding Kconfig/Makefile glue.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  drivers/iio/Kconfig       |   1 +
>  drivers/iio/Makefile      |   1 +
>  drivers/iio/flow/Kconfig  |  27 +++
>  drivers/iio/flow/Makefile |   7 +
>  drivers/iio/flow/slf3s.c  | 406 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 442 insertions(+)
>  create mode 100644 drivers/iio/flow/Kconfig
>  create mode 100644 drivers/iio/flow/Makefile
>  create mode 100644 drivers/iio/flow/slf3s.c
>

Nice code. Just have a couple of questions (+sashiko has some concerns
as well).

[snip]
> +/*
> + * Read the product-info block and pick the matching variant.  The
> + * sub-type byte returned by the sensor is the source of truth; a
> + * DT-supplied compatible only seeds an initial guess and is overridden
> + * on mismatch (with an informational message so misconfigured device
> + * trees are easy to spot).
> + *
> + * Bus / CRC failures are real errors and fail probe.  An unknown
> + * sub-type byte fails probe too: we cannot publish a meaningful scale
> + * without a matching entry in slf3s_variants[].
> + */
> +static int slf3s_detect_variant(struct slf3s_data *sf)
> +{
> +	struct i2c_client *client = sf->client;
> +	u8 buf[SLF3S_PRODUCT_ID_LEN];
> +	int ret;
> +
> +	ret = slf3s_send_cmd(client, slf3s_cmd_prep_pid);
> +	if (ret)
> +		return ret;

Here sashiko said:

"If the system goes through a warm reboot or kexec, won't the sensor
still be running in continuous measurement mode since there is no
.shutdown callback? If the sensor is actively measuring, will it NACK
the 'read product ID' command sent here and cause the probe to
unconditionally fail? Should a stop measurement command be sent before
trying to read the product ID?"

Was looking and didn't find a shutdown callback, so you'll probably
want to add that.

> +     ret = slf3s_send_cmd(client, slf3s_cmd_read_pid);
> +     if (ret)
> +             return ret;
> +
> +     ret = i2c_master_recv(client, buf, sizeof(buf));
> +     if (ret < 0)
> +             return ret;
> +     if (ret != sizeof(buf))
> +             return -EIO;
> +
> +     for (unsigned int i = 0; i < SLF3S_PRODUCT_ID_LEN; i += 3) {
> +             if (!slf3s_crc_valid(sf, &buf[i]))
> +                     return -EIO;
> +     }
> +
> +     if (buf[SLF3S_PRODUCT_FAMILY_BYTE] != SLF3S_PRODUCT_FAMILY_ID)
> +             dev_info(&client->dev,
> +                      "unexpected family byte 0x%02x (expected 0x%02x)\n",
> +                      buf[SLF3S_PRODUCT_FAMILY_BYTE],
> +                      SLF3S_PRODUCT_FAMILY_ID);

This feels like something that could be dev_warn() to me (if it's
unexpected then it means it probably shouldn't happen!)

> +
> +     for (unsigned int i = 0; i < ARRAY_SIZE(slf3s_variants); i++) {
> +             if (buf[SLF3S_PRODUCT_SUBTYPE_BYTE] !=
> +                 slf3s_variants[i].sub_type)
> +                     continue;
> +
> +             if (sf->variant && sf->variant != &slf3s_variants[i])
> +                     dev_info(&client->dev,
> +                              "DT compatible says %s but sensor reports %s; using %s\n",
> +                              sf->variant->name,
> +                              slf3s_variants[i].name,
> +                              slf3s_variants[i].name);

Same here, if the DT says it should be x and we get y, then that also
feels like something that shouldn't have happened.

> +
> +             sf->variant = &slf3s_variants[i];
> +
> +             return 0;
> +     }
> +
> +     dev_err(&client->dev, "unknown SLF3S sub-type 0x%02x\n",
> +             buf[SLF3S_PRODUCT_SUBTYPE_BYTE]);
> +
> +     return -ENODEV;
> +}

[snip]

> +
> +static struct i2c_driver slf3s_driver = {
> +	.driver = {
> +		.name		= "slf3s",
> +		.of_match_table	= slf3s_of_match,
> +	},
> +	.probe		= slf3s_probe,
> +	.id_table	= slf3s_id,
> +};

Sashiko said:

"Since the driver lacks power management operations, what happens when
the system suspends and resumes?
If power is cut to the sensor during suspend, won't it reset to the IDLE
state and cause subsequent IIO reads to fail because the driver never
re-issues the start command? Or if power isn't cut, will leaving it
actively measuring waste power?"

Which it has some good points, you'll just have to issue a start
command once the system is back from suspend.

I'd say it's very close, but please address those comments from
sashiko (also you don't have to take my advice on the dev_warn()
stuff, I'll be honest I haven't written a driver from scratch yet!)

-- 
best regards,
max
