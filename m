Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC22471404
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251570; cv=none; b=GmXBVNgWd7AFjC2abU/gEATD8O9ejRaA2IJ1SyxDLNO3jEXNQKNMnukg06xQBMAdzgd6ua9TyPIqnOjIAFoEnUfFyPtio6nLC3onf7w2Ih7BaxcDRfkif49SL/kgiqfaaHrkI54kPYWnok4AXtxgzNuwQmNddU6BAUaKmBEGBaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251570; c=relaxed/simple;
	bh=RrPl7dCiUycOLp0LCBLAk3hdLlVcoJ1t5j40j8XlpjU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAUlWMVbBHCu9fXKbOOBP8NmueFsem0riwmJHDWL83tLmBMeL5xeDpg7HKBJ8Sth4pxMPV1Cz3wM6Y5NA9hThG8ExR0V0gwT/B2AT2q3dgkS75M4NbibpEB1M6pyHU8KCqgJwIIhMZNMmHBKU1Dr6hi8LUV9glVhJnLdsASp8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVa6z28r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVa6z28r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF0B1F01558
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 08:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788251568;
	bh=qq1rmE8lsmjr0A6aGD2+pkRtPOpgod01PD4Er9pyYaw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=OVa6z28rOk+qjfhctieU+3yNFjF/Fn9NEB5Q+gSDjf0BTtZUs4jiwikcxsY9mg+UQ
	 1Rk3Pr5icQi0gDkVggSHQBf7NEPGnx7Iwh101xOPQXR9yRT5P75lPKk2Lfft4kb9HV
	 G6nD+nr9l/lRFDxG6DITtQ3l1GmxhBYBXmVhvogYZGm/FO3bC3FBiO8wJL03zoMDOH
	 97KyJekKlkwa+LT9dFo5PyHpZ/THvJ7hyEI+h53Jw9gy3HJxl+EUWAkwoNtsEB3k4s
	 MMVfzbN+RFkhcXwx9IGDZAvIqVkkPYIN87A/zkSThRq9L1puG1cUJJnBkp5pNB5PAG
	 djDrx5ozpcpoQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a1981228f8so40556081fa.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 01:32:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByGfn0v6tv9Gm+wLRDOxE5v208IU77hQKk1EBsTwmLYW/qohuC4FMbuzYxU4KdKqTwDiX1d9WSoSR8=@vger.kernel.org
X-Gm-Message-State: AFuF++m+k05KJ08x40qUXD4OZf3HBxXbC5k4TCP2lbFBXI72ANNC448x
	8HTbDplyzE1OM6WOn1zp+s6yBmwLZMN9zNP6k37sJywYS87mlQZ/ZXSaqQHM1S1EuYiVrHVecuc
	ZwyHx8aJYWVUKVb+o5LEiy3BuAwQyaW9djM5NJUMQwg==
X-Received: by 2002:a05:6512:4053:b0:5b5:e71a:d333 with SMTP id
 2adb3069b0e04-5b5e71ad482mr10315062e87.7.1788251567281; Tue, 01 Sep 2026
 01:32:47 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 01:32:45 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 01:32:45 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
Date: Tue, 1 Sep 2026 01:32:45 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdLmCqSfxtwQcv+gHVpAUV7hJB8UQRF_aE8i60wf6mVbg@mail.gmail.com>
X-Gm-Features: AcwNN1WxhcfpA1hDYJT3FEtguPkonETgggJq0ObhDUrF0j3KDbgm0FudVVOrJLM
Message-ID: <CAMRc=MdLmCqSfxtwQcv+gHVpAUV7hJB8UQRF_aE8i60wf6mVbg@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] iio: adc: Add AD7768/AD7768-4 ADC driver support
To: Janani Sunil <janani.sunil@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Aug 2026 17:30:23 +0200, Janani Sunil <janani.sunil@analog.com> said:
> Add support for Analog Devices AD7768 and AD7768-4, 24-bit simultaneous
> sampling Sigma-Delta ADCs with automatic power mode selection.
>
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-ad7768-4.pdf
>
> **Device Overview:**
> The AD7768 is an 8-channel, 24-bit simultaneous sampling ADC. The
> AD7768-4 is a 4-channel variant. Both support configurable power modes,
> programmable decimation filters, and a high-speed serial interface with
> 1, 2, 4, or 8 data output lines. Per-channel offset, gain, and phase
> calibration registers are available.
>
> **Features Implemented:**
> - Support for AD7768 (8-channel) and AD7768-4 (4-channel) via device
>   match data.
> - Automatic low-noise power mode selection (fast, median, low power)
>   with associated decimation rate and output data rate tables.
> - Per-channel offset, gain, and conversion delay via IIO attributes.
> - SPI communication with custom regmap bus for the device's protocol.
> - IIO backend integration with adi-axi-adc for high-speed data capture.
> - CRC data integrity verification over the serial interface.
> - GPIO auxiliary driver to expose the 5 on-chip GPIO pins.
> - VCM common-mode output exposed through the regulator framework, with
>   runtime PM management while the output is enabled.
>
> **Patch Summary:**
> 1. Initialize the AXI ADC state mutex.
> 2. Add the AD7768 and AD7768-4 devicetree binding.
> 3. Add the IIO backend CRC operation.
> 4. Implement CRC control in the AXI ADC backend.
> 5. Add core AD7768 and AD7768-4 capture support.
> 6. Validate the master clock rate.
> 7. Add the power-mode configuration helper.
> 8. Derive output data rates and the data-clock divider.
> 9. Configure enabled channels across two sampling profiles.
> 10. Expose per-channel sampling-frequency controls.
> 11. Expose per-channel filter controls.
> 12. Wait for active digital filters to settle.
> 13. Add per-channel offset and gain calibration controls.
> 14. Add per-channel conversion delay.
> 15. Expose the VCM output through the regulator framework.
> 16. Register the GPIO auxiliary device from the parent driver.
> 17. Use regmap_test_bits() for single-bit gpio-regmap reads.
> 18. Add optional runtime PM support to gpio-regmap.
> 19. Add the AD7768 GPIO auxiliary driver.
> 20. Add driver documentation.

What is the merge strategy here between iio and GPIO trees? Can patches
17-18 go through an immutable branch in the GPIO tree that would be merged
into the iio tree?

Bart
