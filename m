Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BBC473C64;
	Thu, 24 Sep 2026 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255022; cv=none; b=MbggQ9fToxlp30QpTaEksudGguXXkdocOpXGUoaDBF2GZ4BIYreMZVssONTu37awUTJzVIjF5247Oe+jPcDsrjWl60UdbJk6TqC9uyqYXUaoVldA9eJpzbBc1teZnhfKHiSsv0G+m+2R/0Uw7aRPl7A9ea+mpo5LP4cKLZ6tp0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255022; c=relaxed/simple;
	bh=yaEI7bUkT2kPbqMJzYaqqlf866wGtg97g7OCrkKhcZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPkqtxtZswGGzAq4zlmktEY8vCanUTTg0xrBKxbzpJ3eYUZ9z51+Ou6cfv+kuPd+89JgWvEmI0CgooXozBQ1mS9fBlE9zg7ZS1VQzE147LvssM9de7opvSYuaAkwkOtT3H6ixrHm93eBFx1bmukIJT+6rsmPBxpz4zZIyFAg2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsqS479B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsqS479B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD091F000FF;
	Thu, 24 Sep 2026 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790255017;
	bh=Am7+MiZmIsSuyEa1RB59QI6cb2yHg7tmLMNWzm1b5LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DsqS479B+enA9wts2BNbRFQ12rEWCl9+jtRfsV+yCzfFDgJsChlmpYk5JNvlPgGlv
	 aY/S4E7JP3SRNgQUp++BVUL2Nj/+Meeftem9WaJrB/8vJfeI4QxQKBG9/BacPURw3X
	 T3ldTgOYmW7S1H6N9ylvQDnH+A9EcpWxwc7gQhMkRqo9fzEtGE69L7g2SqrcOGkw5D
	 Tbfo1NUfeAnuzqKRRHEfZFd0G+LfTirdXMCgfu0L9FfppzxlFOtoE0XW1vuWmGKeEY
	 kRb+WdlFh5RFXJp0ffjeQZKt18kN9v+kRDAEHZGLL4lb9kyoabCBadjKRLKhRNnIZr
	 p0IoNYOoo52DA==
Date: Thu, 24 Sep 2026 15:03:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: pressure: add Sensirion SDP31 driver
Message-ID: <20260924-gleeful-macho-seahorse-e4bdc2@quoll>
References: <20260920164724.32019-1-m.abubakar365.ref@yahoo.com>
 <20260920164724.32019-1-m.abubakar365@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920164724.32019-1-m.abubakar365@yahoo.com>

On Sun, Sep 20, 2026 at 09:47:22PM +0500, Muhammad Abu Bakar wrote:
> This series adds support for the Sensirion SDP31 differential pressure
> sensor, an I2C device that also reports temperature.
> 
> The SDP31 uses a completely different I2C command protocol from the
> already supported SDP500 (command-triggered measurements with a per-word
> CRC-8), so extending the sdp500 driver does not make sense. No compatible
> parts from other vendors were found.
> 
> Patch 1 adds the device tree binding.
> Patch 2 adds the IIO driver, which exposes differential pressure and
> temperature channels and validates each measurement using the sensor's
> CRC-8 checksum.
> 
> The driver was developed and tested on an SDP31 wired to the I2C bus of
> a Raspberry Pi 4.
> 
> Changes since v1:
> - Explain in this cover letter why a new driver is added instead of
>   extending the sdp500 driver.
> - dt-bindings: make vdd-supply required, and enable the regulator in the
>   driver using devm_regulator_get_enable().
> - Move the MAINTAINERS entry into the dt-bindings patch; the driver patch
>   only adds its own file.
> - Populate the CRC-8 table with DO_ONCE() to avoid a race between
>   concurrent probes.
> - Use devm_mutex_init() and take the lock inside sdp31_measure() using
>   guard(mutex).
> - Build the command with __be16/cpu_to_be16() and parse the reply with
>   get_unaligned_be16().
> - Use a named initializer in the i2c_device_id table.
> - Minor cleanups: local struct device *dev, single-line dev_err_probe(),
>   and a comment on the mutex.
> 
> v1: https://lore.kernel.org/linux-iio/20260919223650.13396-1-m.abubakar365@yahoo.com/

Link does not work.

Best regards,
Krzysztof

