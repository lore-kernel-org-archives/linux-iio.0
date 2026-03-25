Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1643914EF;
	Wed, 25 Mar 2026 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425306; cv=none; b=hFMP0cbFx1pPjNFBpjWsD6EKzVBNwTRVgKgQ9KFZaPngRe7ZcPNEjMQPbZlHTn1qdgXAkqXGpuOBRoYNSM0sqMB3U5sWGSThQv2nvpEi60z6GyNBPGHgcKSEu5RM7Lso8gyCafs0hHxLv6rbm4R0zx6/XpAq0OFiF2N5nQe1HwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425306; c=relaxed/simple;
	bh=l2DQVYyY4szPwj0xCKM1593pQzgiFuVnY+64oqSHVBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWFA6v94cahHkKxB82nlG6+mLj9a6zEaXhb2UThGXt3R8YhYEkG2B1FFqW+JQzSj/LbWxUUZmS6/tUvLvhw2WhX+nj5u4OqFsn7ZiPfYZ33i4bze6/oSy8yRyh9nRrGOtGvEXezOt9p3HMYZ7RlQUmji0JkhLUE0KjJBPPv+Kh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5pWatf8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5pWatf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B45C4CEF7;
	Wed, 25 Mar 2026 07:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774425306;
	bh=l2DQVYyY4szPwj0xCKM1593pQzgiFuVnY+64oqSHVBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5pWatf82dWusuQ4Kf/4KoQhxpZOnGDYsuWUrj+/wU5BP0Qcgu8MK7YGjSYX9W8X7
	 ZDyCm5tTWCQWOrnxqYe7pdTlBnxfA84My6k2KEEv5uUQCD+AQHK+xv3NQrCpO1Qtu+
	 NQdNF2oI1WHO8m9VuwV6JQAx/MyHgWoLXKaPfdAWH7CbkkBZUG5hmaz7gVbSybGY54
	 zR5YbYh0Kh8uR+NwG7aOBzShsGSJhRo9iy3FVIcIBZn6vIBwt92FVaNd65t9fJ8qa+
	 PVd7Hj4YIF9KfTItzUBdYxJhdbMEnVEvBgNWMIUOVhslaRYYILQz66vm5NgSlPUTGl
	 dioDlSd4yGHjA==
Date: Wed, 25 Mar 2026 08:55:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <20260325-perfect-locust-of-serendipity-b0cdfc@quoll>
References: <20260325063254.18062-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325063254.18062-1-email@sirat.me>

On Wed, Mar 25, 2026 at 12:32:21PM +0600, Siratul Islam wrote:
> This series adds support for the STMicroelectronics VL53L1X
> Time-of-Flight ranging sensor.
> 
> The VL53L1X is a ToF laser-ranging sensor with I2C interface,
> capable of measuring distances up to 4 meters. The driver
> supports both interrupt-driven and polled operation.
> 
> Why a separate driver is needed (instead of extending vl53l0x-i2c.c):
> The VL53L1X is fundamentally different from the VL53L0X despite the
> similar naming. Extending the existing driver would require rewriting
> the majority of it.
> 
> Key differences include:
> - A different register map (16-bit addresses vs. 8-bit addresses).
> - Requires a 91-byte firmware configuration blob to be loaded at boot.
> - Requires a VHV calibration cycle.
> - Has distance mode and timing budget configurations.
> - Uses the regmap API rather than raw i2c_smbus calls.
> 
> I also reviewed other drivers in drivers/iio/proximity/ and can
> confirm this IP block does not appear to be shared by any other
> existing driver.
> 
> Tested on Raspberry Pi 5 with a VL53L1X breakout board.
> 
> Note on vdd-supply:
> vdd-supply is now required. The VL53L0X required a physical
> regulator, but it did not specify the requirement in the binding.
> It should have always been there. The VL53L1X also requires it.
> Hence I added the requirement.
> 
> ---
> Changes in v7:
> - Add VL53L1X_REG_ prefix for register defines.
> - Use iio_push_to_buffers_with_ts().
> - Use continuous ranging and drop postenable/predisable.
> - Add comments for XSHUT reset, default config values.
> - Drop vdd-supply description in binding and comment in driver.
> - Add ABI rationale for vdd-supply to commit message (per Krzysztof, Jonathan).
> 
> 
> Changes in v6:
> - Make vdd-supply required. Add descriptions to vdd-supply and reset-gpios (per Jonathan).
> - Check reset_control_deassert() return value (per Andy).
> - Use volatile table for result registers and caching for the rest. Also mark write-only registers.

So where did you explain dropping tag as I requested? Did you read the
exact paragraph I asked you to read?

Best regards,
Krzysztof

