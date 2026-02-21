Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD06368290
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771704993; cv=none; b=pmF9c4vZ04HdeUtmfahCdAXjOQ5y4lq7xOUwZgoFko/0z6C42QHpXEf5bT5NOBtU8V+hzDNZ3GbW+badtc60vBR/1dJ+Mp6Mf6bX2TPtxChzQLBNq4p1ntWBXHQy5uCHqMSwibwRaXxAWBxWxzXRVqw3baD9nRJnKa3GRRGAJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771704993; c=relaxed/simple;
	bh=zdcXgNKeKEfRKlOnRnW4Kgj5oyAcUTSPtMveGZzeAc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgepA6vyqHo/oEBAUBTFWxcP1mIqyDiPRRvakqO0YpoJQfYyyhaOFYF+UVoc1EFPEQ/n+T0Pk0YeElnVDUjeimjkyQtHnuwTdQBLtoVe4sR0gcp8FPw8xqpmzIvoqVlTXB9AQgbUuyWR3CbXGQd9N28ZiKcbdHAaiYLR6mjIp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zLJU7iNP; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zLJU7iNP"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-662f30d3f1fso2342068eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 12:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771704990; x=1772309790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRvVYIE/kEJ4fmfM87fkDRD4HKgLVo/aCg4EBjq67A0=;
        b=zLJU7iNP90EA33g12Q8nG4Wuzw1Fp4vKNHCsYV3fCCQLJtKm+5E0OL8NbA9wynYSlm
         lOhCQwWOka3w7FGBzprxWvyIWBVMO/hM5EX8/8LZV5Ta69a19KNlNV96xfyUHM6gW5lN
         ECwgAMTvO3fptRraemkj/K51jJCJ0slgE+vnf+08e3oWSUVbKiUwgEFgnCW7nYEYrU7j
         oNoVvSpyHHlKfBmviFZzSx6P3dtyU4taSCDz9UfVXy3Pz4MxSoK5qN4EYOHALdjTGW1v
         IeUrNvMPJAkvcNHI/djU5dboRgFbERLPEAFhKXi8G7nhmHUBG5mvXFPwmDQRwldQ+Ijd
         sSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771704990; x=1772309790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRvVYIE/kEJ4fmfM87fkDRD4HKgLVo/aCg4EBjq67A0=;
        b=qJrn9SnSWYw1e47fczuYp1x4iRcxzF3AbS0OyboswY93q6PgMJpwH76+DyY9JjaE9f
         9BYGrDkLVBXV+c5AvSteHhX9w6NAT+TWkTMkuCMlJ5NflJu3WGN8fy+MzlBZQe9YL76f
         ndopa51bFH0LPtSOBXU23XOj/7VM9DqZP7lDWwDZ7F6pW5p2Az3ReEeextgm/fsM5ORl
         ONlPvDKUSFEVShMGW9PE4LtW8FveiozDXVY65qQYpP0mTPNr7eell4U9UXs7lBzjY/TM
         m12Hje9s8qt4Ds4ZP457le8SvHCHbClGkqATdXAOh0v/lxQhMe/5iN3eAJ8wXMbsT9OW
         OWLg==
X-Forwarded-Encrypted: i=1; AJvYcCVXvocGbM/10SR4nnlW36GNlj2kHHGnbxsIA4xaymdQN3oKUYpfQ+pwyhuhnWxtHvS07K7ps8onRM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtSTpjO4Oak1DM2ql+0NWa5H1Q7hsIfXxXiBwrCUNdSklBSggB
	3FjatDpXiH9BvYGjmBhZ2ewivswLwww9ykvviRZ15Oc0dl7imaFP9/IXT9iPYZ9I1jJHxVzYWzN
	SPaJ1
X-Gm-Gg: AZuq6aKGnH29IpuB7n2sD/CigOGMKzz0oZDkhEnjE2NxyESeZ7SajZVHwbnfE9+HcKA
	f66iyf2kTx2QE5FVOJOt8uDFTrl/ST54NZcwstMPRj4hBdNKPE1co2o6fwuRtbyEepH/b0gLuJE
	PLSzqTyZ6yMGNzD4GrY4uoHs0CxkNyxtYDy7e5oLvZuMUCyhU+HYkrhqZFGUwx1Lo2iTWduFG4L
	Xkm/7GQGQL/Rxj6tzlL+CGeGNvpEISJxqMP3Zksxc+bHeNdOYyp/WDMlVmwDxwf27Vg3pq625lQ
	8+D/nLglLzqo79abIJM2hpVTvvp5q3qk8dcRHz7qIbf6XzIMk/suCZCAAZQ5LgdE6vmK9Gd/WK4
	lGvcOYKJf5UWQsGEGvB08Kf5d5pThkSxoojmrB848HK1xLAG+3GlFEBlvltonvKBgWkSdv19G6v
	+5xoPf7adrubGV2kP1fQW4LVWsVJIqNHH3mEapfVyaAgYsDnB0ffDIV2UdDqLfmhAE+coMAw==
X-Received: by 2002:a05:6820:16aa:b0:674:db9f:2e2a with SMTP id 006d021491bc7-679c4aecd20mr2273215eaf.35.1771704990051;
        Sat, 21 Feb 2026 12:16:30 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:611:96af:f385:64bf? ([2600:8803:e7e4:500:611:96af:f385:64bf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d2d77e3sm3423233fac.13.2026.02.21.12.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 12:16:29 -0800 (PST)
Message-ID: <a72b2d62-3b91-4789-a1b1-ff1429e80ed5@baylibre.com>
Date: Sat, 21 Feb 2026 14:16:28 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/8] AD9910 Direct Digital Synthesizer
To: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:
> This patch series adds support for the Analog Devices AD9910 DDS.
> This is an RFC so that we can agree/discuss on the design that follows:
> 
> The AD9910 DDS core can be driven through several independent mechanisms:
> single tone profiles, a digital ramp generator, an internal RAM playback
> engine, a parallel data port, and output shift keying. Each of these

This makes is sound more like a DAC than a frequency generator. altvoltage
specifically means an AC voltage (sine wave), so these arbitrary outputs
don't fit that.

> represents a distinct signal path into the DDS accumulator, so the driver
> models them as separate IIO output channels (all IIO_ALTVOLTAGE type).

Generally IIO channels represent the physical input/output, not the
internal channels.

Ideally we would just have the one channel here with a mode selection
attribute. Documentation can tell us which modes use which attributes.

> This per-channel separation allows userspace to configure each mode
> independently through its own set of sysfs attributes, and to
> enable/disable modes individually via IIO_CHAN_INFO_ENABLE, relying on
> the hardware's own mode selection architecture.
> 
> The AD9910 register map is not suited for the regmap framework: register
> widths vary across the map (16, 32, and 64 bits). The driver instead

Does it break things if you read/write 64 bits from/to non-64-bit registers?

In other drivers for chips like this, we've just created 2 regmaps, i.e.
one for 16-bit regs and one for 32-bit regs. Seems better than
re-implementing a reg cache.

> implements direct SPI access helpers with a software register cache, using
> type-specific read/write/update functions (ad9910_reg{16,32,64}_{read,
> write,update}) that handle endianness conversion and cache coherency.
> 
> Registers are cached for several reasons. The control/function registers
> (CFR1, CFR2) are frequently queried to determine the current operating
> mode (e.g., checking RAM_ENABLE before every profile register access),
> and caching avoids repeated SPI read transactions for what are
> essentially state checks. The cache also enables efficient
> read-modify-write updates on multi-byte registers: the update functions
> merge new field values with the cached register content without issuing
> a SPI read, and skip the write entirely when the value is unchanged.
> Finally, the profile registers serve dual purposes depending on whether
> RAM mode is active -- they hold single tone parameters (FTW, POW, ASF)
> in normal operation but are repurposed for RAM playback configuration
> (start/end address, step rate, operating mode) when RAM is enabled. A
> shadow register array (reg_profile[]) preserves the inactive mode's
> settings across transitions, so no state is lost when switching between
> single tone and RAM operation.
> 
> RAM data is loaded through a write-only binary sysfs attribute
> (ram_data). Userspace writes the waveform data as a raw binary buffer
> (up to 4096 bytes for the full 1024x32-bit RAM), and the driver
> transfers it to the device in a single SPI transaction. Per-profile
> start/end addresses and playback parameters (operating mode, step rate,
> no-dwell control) are configured through the RAM channel's ext_info
> attributes.
> 
> Streaming data to the DDS core through the parallel data port at the
> PD_CLK rate is not covered by this series. That functionality would
> be added in a separate patch series, building on top of the IIO backend
> infrastructure to provide a proper buffered data path.
> 
> As I am pushing implementation, as lot has been done already without much
> supervision or agreement, still I would be interested on hearing about
> the design choices discussed above. Here is the output for the iio_info
> at this point:
> 
> 5 channels found:
>     altvoltage1:  (output)
>     9 channel-specific attributes found:
>         attr  0: en value: 0
>         attr  1: frequency_offset value: 0.000000
>         attr  2: frequency_scale value: 1
>         attr  3: label value: parallel_port
>         attr  4: phase_offset value: 0.000000
>         attr  5: powerdown value: 0
>         attr  6: profile value: 0
>         attr  7: sampling_frequency value: 100000000.000000
>         attr  8: scale_offset value: 0.000000
>     altvoltage3:  (output)
>     13 channel-specific attributes found:
>         attr  0: address_end value: 1023
>         attr  1: address_start value: 0
>         attr  2: destination value: frequency
>         attr  3: destination_available value:
>           frequency phase amplitude polar
>         attr  4: en value: 0
>         attr  5: frequency value: 0.000000
>         attr  6: label value: ram_control
>         attr  7: operating_mode value: direct_switch
>         attr  8: operating_mode_available value:
>           direct_switch ramp_up bidirectional
>           bidirectional_continuous ramp_up_continuous
>           sequenced sequenced_continuous
>         attr  9: phase value: 0.000000
>         attr 10: powerdown value: 0
>         attr 11: profile value: 0
>         attr 12: sampling_frequency value: 100000000.000000
>     altvoltage2:  (output)
>     27 channel-specific attributes found:
>         attr  0: burst_count value: 0
>         attr  1: burst_delay value: 0.000000030
>         attr  2: control_en value: 0
>         attr  3: decrement_sampling_frequency value: 100000000.000000
>         attr  4: destination value: frequency
>         attr  5: destination_available value: frequency phase amplitude
>         attr  6: en value: 0
>         attr  7: frequency_decrement value: 0.000000
>         attr  8: frequency_increment value: 0.000000
>         attr  9: frequency_max value: 0.000000
>         attr 10: frequency_min value: 0.000000
>         attr 11: increment_sampling_frequency value: 100000000.000000
>         attr 12: label value: digital_ramp_generator
>         attr 13: operating_mode value: bidirectional_continuous
>         attr 14: operating_mode_available value:
> 		  bidirectional ramp_down ramp_up bidirectional_continuous
>         attr 15: phase_decrement value: 0.000000000
>         attr 16: phase_increment value: 0.000000000
>         attr 17: phase_max value: 0.000000000
>         attr 18: phase_min value: 0.000000000
>         attr 19: powerdown value: 0
>         attr 20: profile value: 0
>         attr 21: ramp_delay value: 0.000000020
>         attr 22: scale_decrement value: 0.000000000
>         attr 23: scale_increment value: 0.000000000
>         attr 24: scale_max value: 0.000000000
>         attr 25: scale_min value: 0.000000000
>         attr 26: toggle_en value: 0
>     altvoltage0:  (output)
>     6 channel-specific attributes found:
>         attr  0: frequency value: 0.000000
>         attr  1: label value: single_tone
>         attr  2: phase value: 0.000000
>         attr  3: powerdown value: 0
>         attr  4: profile value: 0
>         attr  5: scale value: 0.000000
>     altvoltage4:  (output)
>     8 channel-specific attributes found:
>         attr  0: en value: 0
>         attr  1: label value: output_shift_keying
>         attr  2: pinctrl_en value: 0
>         attr  3: powerdown value: 0
>         attr  4: profile value: 0
>         attr  5: sampling_frequency value: 100000000.000000
>         attr  6: scale value: 0.000000
>         attr  7: scale_increment value: 0.000000
> 3 device-specific attributes found:
>         attr  0: ram_data ERROR: Permission denied (13)
>         attr  1: sysclk_frequency value: 400000000
>         attr  2: waiting_for_supplier value: 0
> 1 debug attributes found:
>         debug attr  0: direct_reg_access value: 0x2


This is a lot of custom attributes!

It looks like a lot of these are just exposing registers directly, which
usually isn't the best if we want something that can be reused. However,
this looks pretty complex so coming up with something generic is probably
not worth the effort. 

Instead, I would suggest to create a firmware file format that
describes how the chip should be programmed. And in the driver call
firmware_upload_register() to create a sysfs interface where the
firmware can be loaded/replaced at runtime. This way, there is just
one attribute write needed to set all of the parameters at once.

This could probably be as simple as something that just contains
the value of each register to be programmed and the driver can
write all of the registers just before enabling the output.

> 
> Kind regards,
> 
> Rodrigo Alencar
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
> Rodrigo Alencar (8):
>       dt-bindings: iio: frequency: add ad9910
>       iio: frequency: ad9910: initial driver implementation
>       iio: frequency: ad9910: add simple parallel port mode support
>       iio: frequency: ad9910: expose sysclk_frequency device attribute
>       iio: frequency: ad9910: add digital ramp generator support
>       iio: frequency: ad9910: add RAM mode support
>       iio: frequency: ad9910: add output shift keying support
>       iio: frequency: ad9910: add channel labels
> 
>  .../bindings/iio/frequency/adi,ad9910.yaml         |  236 +++
>  MAINTAINERS                                        |    8 +
>  drivers/iio/frequency/Kconfig                      |   18 +
>  drivers/iio/frequency/Makefile                     |    1 +
>  drivers/iio/frequency/ad9910.c                     | 2153 ++++++++++++++++++++
>  5 files changed, 2416 insertions(+)
> ---
> base-commit: cce8de7f9744a210a4441ca8a667a9950515eea7
> change-id: 20260218-ad9910-iio-driver-9b3d214c251f
> 
> Best regards,

