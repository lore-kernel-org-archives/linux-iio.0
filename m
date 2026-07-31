Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD36360EE2
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477653; cv=none; b=Y7+tUVN+L+aE4U9kWgJAafrT4GISDpna3IZQ30VNDuChqHDSMYBOP75lX+ozo4NUa4PlZG/vBv5+svT3l1dPmN8/XsevC6gPNpaaDVISmKrL31f+YmuAQhL/44XhDEf7Int5tYkA0XKIYLz6zT3ETb1fAIETwjMDkNwjSzfrSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477653; c=relaxed/simple;
	bh=NTznVSHSuISkxzuPy7fdk40UUaz/IICS7tkiyc0KWm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qnd23dGCOh7cASbzJ/xHXdOPdg3AygqkBdwXHVpu8M2A5hv9bGafRipk4gAllDW0NWDGUoxU2YO1Fr3h25r27d6l+jmkSGBKbRo3b0KRLD3cvkCDz8yluNKFIJwBQ4enONuzf3/uxJJL4yoGMBTzCA9YgOYNqZ74Pq8zwhNEUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fXy69GNG; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fXy69GNG"
Message-ID: <df3edbd24fe35ba8897efefa0af69c58ffc1a39d.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785477639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bi8pYGxOA4BhmQrdhbWsAAtgHe/9OU2yu3CWPfjgQ+A=;
	b=fXy69GNGgario6digWvIrdgBVaN/fd9SLCvIS1saiZwTtDz7Dt7iq/Mrf0Rjw78dPd1XIx
	zZ6Lmm6XQxvMHI6CtM6nImA5uYhBYC8FEwZd25eezCX9bL0HzSmyzCG9vAyyxBoQablM8w
	uxlC54mKk5AsHiC8aAfSa5qD1h8mQu0=
Subject: Re: [PATCH v6 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Stefan Popa <stefan.popa@analog.com>
Cc: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
 	andy@kernel.org, nuno.sa@analog.com, linux@roeck-us.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com, 
	ciprian.hegbeli@analog.com, u.kleine-koenig@baylibre.com, 
	joshua.crofts1@gmail.com
Date: Fri, 31 Jul 2026 12:00:06 +0600
In-Reply-To: <20260730131738.822405-3-stefan.popa@analog.com>
References: <20260730131738.822405-1-stefan.popa@analog.com>
	 <20260730131738.822405-3-stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Thu, 2026-07-30 at 16:17 +0300, Stefan Popa wrote:
> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
>=20
...
> +
> +#define MAX40080_REG_FIFO_CFG		0x0A
> +#define=C2=A0 MAX40080_FIFO_CFG_STORE_IV_MSK	GENMASK(1, 0)
> +
> +#define MAX40080_REG_IV			0x10
> +/* Current is a 13-bit two's-complement value (magnitude + sign bit). */
> +#define=C2=A0 MAX40080_IV_I_MSK		GENMASK(12, 0)
> +#define=C2=A0 MAX40080_IV_I_SIGN_BIT		12
> +#define=C2=A0 MAX40080_IV_V_MAG_MSK		GENMASK(27, 16)
> +#define=C2=A0 MAX40080_IV_VALID_MSK		BIT(31)
> +
> +/* CFG.mode field values. */
> +#define MAX40080_CFG_MODE_STDBY		0x00
> +#define MAX40080_CFG_MODE_SINGLE	0x02
> +
> +/* CFG.range field values. */
> +#define MAX40080_CFG_RANGE_50MV		0
> +#define MAX40080_CFG_RANGE_10MV		1
this and other "MV"s below should be mV(m lowercase) as=C2=A0
I suggested in the previous version.
> +
> +/* FIFO_CFG.store_iv field values. */
> +#define MAX40080_FIFO_CFG_STORE_I_V	0x02
I also had a question on why this is I_V and not IV like the rest of them?
> +
> +#define MAX40080_ADC_RES_BITS		12
> +#define MAX40080_INTER_VREF_MV		1250
> +#define MAX40080_V_BUFF_GAIN		30
> +#define MAX40080_CSA_50MV_GAIN		25
> +#define MAX40080_CSA_10MV_GAIN		125
...
Looks like you missed some of the reviews. If it was intentional,
please acknowledge that. It is a good idea to reply to emails
and discuss/confirm stuff before sending a new patch.

Also avoid sending --to mailing lists (linux-iio@vger.kernel.org).=C2=A0
Send to maintainers and Cc reviewers and lists.

--
Best regards,
Sirat
