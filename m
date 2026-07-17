Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541F3B71D3
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297035; cv=none; b=fAIxS4m7oV0JGlUxLFvHvcgzrlmA66fNoVx0d0ea3Ksvf/aLksgjBRafl7FZUsu23GfNMjfcZD7oezTbDKZy0R91e/uSXeM2OxnbM0Zj6xR+FfYwHu9tsNuEFY1txoyUh1RWFl5p7YNawQjkQQF8tJPkxPy/lsE6zApWjECq2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297035; c=relaxed/simple;
	bh=skLfCDy11TiauSQNSDWPhDw88faje0em6NYTYSP6tNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Grk0htGMTP6ekNp7Nw/rcWAz+yl/MQpTHri5GcvEM4f4Tm79Qn1G4lB1KdVpbe0QhVh88vdPK0FsDrK5ZOoydk9XXUB9qZuKyVM8XeZR25OJeJp7jdIF+IBzkpbhzElR+93W65uGxj6MPCobBEA2fxQn0XAJ708yFo74YmF/RTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YqhUveRW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YqhUveRW"
Message-ID: <61b1f4de5a756d5176c5d388f92082a29e3f489f.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784297032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skLfCDy11TiauSQNSDWPhDw88faje0em6NYTYSP6tNY=;
	b=YqhUveRWlqnGPuexi/rNaOXV3LgBQOx8fG9RPKQ7r5Aa87RolMIEHxKUYS9BLUJf84FFO0
	64DdD/JDHII8Q/YQIut607EY5oQ9Vljjg2ZJAXJQBtgICgLjRyK5ZRTIKIa4FQsabI3km1
	Qwj3vNVrFV1Xm+XZaO9uB/5TC4XlRpc=
Subject: Re: [PATCH v4 0/2] iio: adc: add MAX40080 current-sense amplifier
 driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, andriy.shevchenko@linux.intel.com, nuno.sa@analog.com,
 	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Date: Fri, 17 Jul 2026 20:03:33 +0600
In-Reply-To: <20260717123852.1140893-1-stefan.popa@analog.com>
References: <20260717123852.1140893-1-stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Fri, 2026-07-17 at 15:38 +0300, Stefan Popa wrote:
> This series adds support for the Maxim MAX40080, a bidirectional
> current-sense amplifier with an integrated 12-bit ADC and an I2C/SMBus
> interface. It measures the voltage across an external shunt resistor and
> the input bus voltage.
>=20
> The driver operates in direct (INDIO_DIRECT_MODE) mode. Each raw read
> triggers a single on-demand conversion (SMBus Quick Command) and reads
> back the matched current/voltage pair, so results are always fresh. It
> exposes the current and voltage channels with raw and scale attributes,
> a configurable oversampling (digital averaging) ratio, and PEC-protected
> register access. The two selectable current-sense ranges are exposed
> through scale/scale_available; the current scale is derived from the
> shunt-resistor-micro-ohms device-tree property.
>=20
> Tested on hardware with four MAX40080 devices on an I2C bus.
>=20
> Regarding regmap: it does not support SMBus PEC or Quick Command, both of
> which are required by this device. The mlx90614 driver uses the same raw
> i2c_smbus approach for similar reasons.
>=20
> Changes in v4:
>=20
...
>=20
...
> --
> 2.53.0

Was it intentional to drop people from your Cc list who
were present / engaged in previous versions? Please try to keep it consiste=
nt.
Also, it helps to include the links to the previous versions.

--
Best regards,
Sirat
