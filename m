Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCAC1B6527
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771754476; cv=none; b=M+gH1/L+bO6EooZpEB4KN4xOia+ZezjLp5CfEXhoYwKx72DM002IbtW4FBJEqLgADdlmmJ/5Npf6Qpw4ZVwe54IJR5HxBfQ4Tz8rCcbElaYGPSjb34I9MHpfP0XZCoNePIgsQZbA8/EZorygp58zB7V7S3lDRzVjPD2lFJzo+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771754476; c=relaxed/simple;
	bh=UJ58ZtPtWKCa+LTOvGOjw26gzTFytJa7PejQgGVSY1A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3V1n1i29yFasYuxizy5tOi1hFpa9zh8xABFE47MTMXsskPEi+bu1I0PwW8cmDaq92xDDj0doVcRQJ221iTbO7x5KgJ1qUtetq18CGqjovWwGKjNF7nIrpksuQAdM1E/V7A58XaQFdd2pZnCkayi+n5AsobbHdbgvUBa3/JHaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTuWuP+B; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTuWuP+B"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4359a16a400so3153511f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 02:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771754473; x=1772359273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4BA9m7stgw+QUUpwZn/xgPy8Z/NcUc9HLfI6tL9Gcc=;
        b=PTuWuP+B29OjZ1jzV9DRI60iwq+HDw0rdYyXhsNZX9Nqz1qfx9WbbDHK7adgdRgSp/
         ZIIAPQCawvqlPGtPQR/OmyEkEe2vNa+b3kQ8/4o86ncuwLVMOdJhdQOf8qXS4RMKSwas
         6JAFAcahyIGQO/4dTVsyF6hm2PvAId1Iva6nDTAxzXs1RnJUntkGmhNSme8KRHA136Nw
         C5fbi1XDo1C/e7IbFQxYpz09SAGx0+3CZJSQqrxAS2jWtHlUYK8SPAZiICNCZ6hp3rKz
         Qx2xdz3chqF7910sBwJlu2x5HJdB30mHblnNBEv5Dpewohpqa9titi/E3SEuPc/G0uca
         q6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771754473; x=1772359273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4BA9m7stgw+QUUpwZn/xgPy8Z/NcUc9HLfI6tL9Gcc=;
        b=YLfmKA+ODE+b77cDlDpnj6KnQzG9p1N2d6CyizueY4jeqZomod/5Ygh+3v7PRpFEnM
         Uzjx58RpPZVtZPquug0UdpRb20rEy7Hituw/za0plrvv5PfSvN7i0MZ7wku2vkoLQ6bJ
         Ojh35DcMIQ5snaFJy8SwvMfl/J7Ls4r5cWtrcCcPQwAhlOCZBkLoQoGy7Mta0C7RZ0Ap
         tgANvikFkyPeP7bn9tVwjsEXaKu0AwyNfoisJV7VsDc/GUWJ5bp6F6Tm9c6BaInhl2z/
         zp93XJ7QmbsfMCwR3F8XWqBmbQT1Zb+PuWuG8VpXvg45mfEzyQre3EwLniQNecEZAOdP
         Nj7w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ2FBB5eJmqltlXXFsTcWFhCbVnPQtJNYnqtXhK/FnhvNCj0GnTL4v3gz93w9yuu8YMRqH8UnbrO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwX8DYLj2VApD9ztdsvl3EuG93AyZuGnZA+z/joDzN7p/kHvAS
	ZB5k+Q7VJVpwEkZdYFjtXqE5LPj4Cbh7wePyXAIPW15fFYYxv3nQ6AAcdAVNag==
X-Gm-Gg: AZuq6aLpSEytwdhC6bOg8UCkj+PYcNUFMul/JLZ7qlMxF5ifkf7N7RauT91zWyN16fa
	OvIZ6xLjoFU7JmESkWMvfjl6R7CCnuFSbN0EFigaxjxE+ysw85Rq+At58FP8quN2VgEUjvp5FRX
	4N8FbNlmkHe6/FmenAyVqpu414QQrVuQk2Z0Vo8CZCpsQD5TgWORryXQXYdHmG6SUL5aXbZH82m
	ljgv3PkUuM9KT9zgeUTJhmDD/zKt1TaiV3JHJ/glMtxX2FxweGbuHxiiVS8YGrkDtDlA84Pqyhh
	RjmFiA5TpTzHGQRB30P3gDCfiob5vf0VOYYHbe1Uayt709m4dqib3gdtwGcA2wU6/E7TEfmU947
	GfNH9LGO/VZDzwE7C18UrQuDnB7HkBw/BOFgcdvPLWgqd1+o03byhMI8M38xEnDsT05iuKSfOLy
	+k9QwQBoIVrcSjB+S3yJFjo3WAfRVSLNQiJHb9ReDE+3hfkYEJG0M9gjW1TCaBAAOwQ3m/eA76d
	PZkyWxt9fmCmidSe8kJA5WhMFQ4cLut6lBvLmKAEp9yTQiMzOQ=
X-Received: by 2002:a05:6000:2283:b0:437:81b0:6650 with SMTP id ffacd0b85a97d-4396f189ffbmr10513863f8f.56.1771754473210;
        Sun, 22 Feb 2026 02:01:13 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00768sm11530327f8f.10.2026.02.22.02.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 02:01:12 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 22 Feb 2026 10:01:06 +0000
To: David Lechner <dlechner@baylibre.com>, rodrigo.alencar@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 0/8] AD9910 Direct Digital Synthesizer
Message-ID: <2k4ouimpaxjuhnk67qmrues2375zj43ehru7h5as6w6kf7yak3@2ndr72co5trh>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <a72b2d62-3b91-4789-a1b1-ff1429e80ed5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a72b2d62-3b91-4789-a1b1-ff1429e80ed5@baylibre.com>

On 26/02/21 02:16PM, David Lechner wrote:
> On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:
> > This patch series adds support for the Analog Devices AD9910 DDS.
> > This is an RFC so that we can agree/discuss on the design that follows:
> > 
> > The AD9910 DDS core can be driven through several independent mechanisms:
> > single tone profiles, a digital ramp generator, an internal RAM playback
> > engine, a parallel data port, and output shift keying. Each of these
> 
> This makes is sound more like a DAC than a frequency generator. altvoltage
> specifically means an AC voltage (sine wave), so these arbitrary outputs
> don't fit that.

Most applications for this part are in fact for frequency generation, like:
- Agile local oscillator (LO) frequency synthesis
- Programmable clock generators
- FM chirp source for radar and scanning systems
- Fast frequency hopping

The device has been made to be too flexible, so that its operation modes
have sub-operation modes that allows to handle frequency, scale and phase.
But at a specific timestamp, the output signal will always be a CW, i.e.
a sine or cosine wave.
 
> > represents a distinct signal path into the DDS accumulator, so the driver
> > models them as separate IIO output channels (all IIO_ALTVOLTAGE type).
> 
> Generally IIO channels represent the physical input/output, not the
> internal channels.

That is part of the reason for this RFC. Dividing those top-level modes
into channels allows for better organization, as they can operate together,
i.e., phase or scale can be provided by single-tone profile, while
frequency is controlled by the digital ramp generator (see Mode Priority
section in the datasheet). Also, it allows to explore the most of standard
ABIs like, scale, frequency, phase, sampling_frequency and enable.
Putting everything into a single channel would make things a lot messy
to interface with.

> Ideally we would just have the one channel here with a mode selection
> attribute. Documentation can tell us which modes use which attributes.
> 
> > This per-channel separation allows userspace to configure each mode
> > independently through its own set of sysfs attributes, and to
> > enable/disable modes individually via IIO_CHAN_INFO_ENABLE, relying on
> > the hardware's own mode selection architecture.
> > 
> > The AD9910 register map is not suited for the regmap framework: register
> > widths vary across the map (16, 32, and 64 bits). The driver instead
> 
> Does it break things if you read/write 64 bits from/to non-64-bit registers?

Yes, the exact amount of bytes needs to be sent when writing specific registers.

> In other drivers for chips like this, we've just created 2 regmaps, i.e.
> one for 16-bit regs and one for 32-bit regs. Seems better than
> re-implementing a reg cache.

I would have to have 3 configs, one of them for a single 16-bit register.
Also, regmap_spi does not seem to support 64-bit registers (maybe I am wrong).
Additionally, single tone modes and RAM control modes are profile based and
they share the same registers, so I suppose that having to control the
register cache manually would be beneficial to switch RAM mode ON/OFF.
I understand that the digital design of the chip is not one of the best,
and a lot of unneeded complications are pushed to be handled in software.

> > implements direct SPI access helpers with a software register cache, using
> > type-specific read/write/update functions (ad9910_reg{16,32,64}_{read,
> > write,update}) that handle endianness conversion and cache coherency.
> > 
> > Registers are cached for several reasons. The control/function registers
> > (CFR1, CFR2) are frequently queried to determine the current operating
> > mode (e.g., checking RAM_ENABLE before every profile register access),
> > and caching avoids repeated SPI read transactions for what are
> > essentially state checks. The cache also enables efficient
> > read-modify-write updates on multi-byte registers: the update functions
> > merge new field values with the cached register content without issuing
> > a SPI read, and skip the write entirely when the value is unchanged.
> > Finally, the profile registers serve dual purposes depending on whether
> > RAM mode is active -- they hold single tone parameters (FTW, POW, ASF)
> > in normal operation but are repurposed for RAM playback configuration
> > (start/end address, step rate, operating mode) when RAM is enabled. A
> > shadow register array (reg_profile[]) preserves the inactive mode's
> > settings across transitions, so no state is lost when switching between
> > single tone and RAM operation.
> > 
> > RAM data is loaded through a write-only binary sysfs attribute
> > (ram_data). Userspace writes the waveform data as a raw binary buffer
> > (up to 4096 bytes for the full 1024x32-bit RAM), and the driver
> > transfers it to the device in a single SPI transaction. Per-profile
> > start/end addresses and playback parameters (operating mode, step rate,
> > no-dwell control) are configured through the RAM channel's ext_info
> > attributes.
> > 
> > Streaming data to the DDS core through the parallel data port at the
> > PD_CLK rate is not covered by this series. That functionality would
> > be added in a separate patch series, building on top of the IIO backend
> > infrastructure to provide a proper buffered data path.
> > 
> > As I am pushing implementation, as lot has been done already without much
> > supervision or agreement, still I would be interested on hearing about
> > the design choices discussed above. Here is the output for the iio_info
> > at this point:
> > 
> > 5 channels found:
> >     altvoltage1:  (output)
> >     9 channel-specific attributes found:
> >         attr  0: en value: 0
> >         attr  1: frequency_offset value: 0.000000
> >         attr  2: frequency_scale value: 1
> >         attr  3: label value: parallel_port
> >         attr  4: phase_offset value: 0.000000
> >         attr  7: sampling_frequency value: 100000000.000000
> >         attr  8: scale_offset value: 0.000000
> >     altvoltage3:  (output)
> >     13 channel-specific attributes found:
> >         attr  0: address_end value: 1023
> >         attr  1: address_start value: 0
> >         attr  2: destination value: frequency
> >         attr  3: destination_available value:
> >           frequency phase amplitude polar
> >         attr  4: en value: 0
> >         attr  5: frequency value: 0.000000
> >         attr  6: label value: ram_control
> >         attr  7: operating_mode value: direct_switch
> >         attr  8: operating_mode_available value:
> >           direct_switch ramp_up bidirectional
> >           bidirectional_continuous ramp_up_continuous
> >           sequenced sequenced_continuous
> >         attr  9: phase value: 0.000000
> >         attr 12: sampling_frequency value: 100000000.000000
> >     altvoltage2:  (output)
> >     27 channel-specific attributes found:
> >         attr  3: decrement_sampling_frequency value: 100000000.000000
> >         attr  4: destination value: frequency
> >         attr  5: destination_available value: frequency phase amplitude
> >         attr  6: en value: 0
> >         attr  7: frequency_decrement value: 0.000000
> >         attr  8: frequency_increment value: 0.000000
> >         attr  9: frequency_max value: 0.000000
> >         attr 10: frequency_min value: 0.000000
> >         attr 11: increment_sampling_frequency value: 100000000.000000
> >         attr 12: label value: digital_ramp_generator
> >         attr 13: operating_mode value: bidirectional_continuous
> >         attr 14: operating_mode_available value:
> > 		  bidirectional ramp_down ramp_up bidirectional_continuous
> >         attr 15: phase_decrement value: 0.000000000
> >         attr 16: phase_increment value: 0.000000000
> >         attr 17: phase_max value: 0.000000000
> >         attr 18: phase_min value: 0.000000000
> >         attr 22: scale_decrement value: 0.000000000
> >         attr 23: scale_increment value: 0.000000000
> >         attr 24: scale_max value: 0.000000000
> >         attr 25: scale_min value: 0.000000000
> >     altvoltage0:  (output)
> >     6 channel-specific attributes found:
> >         attr  0: frequency value: 0.000000
> >         attr  1: label value: single_tone
> >         attr  2: phase value: 0.000000
> >         attr  5: scale value: 0.000000
> >     altvoltage4:  (output)
> >     8 channel-specific attributes found:
> >         attr  0: en value: 0
> >         attr  1: label value: output_shift_keying
> >         attr  2: pinctrl_en value: 0
> >         attr  5: sampling_frequency value: 100000000.000000
> >         attr  6: scale value: 0.000000
> >         attr  7: scale_increment value: 0.000000
> > 3 device-specific attributes found:
> >         attr  0: ram_data ERROR: Permission denied (13)
> >         attr  1: sysclk_frequency value: 400000000
> > 1 debug attributes found:
> >         debug attr  0: direct_reg_access value: 0x2
> 
> 
> This is a lot of custom attributes!

yes, specially for the digital ramp generator, where we have range
sets of increment, decrement, min and max for each DDS parameter:
scale, phase, frequency.

> It looks like a lot of these are just exposing registers directly, which
> usually isn't the best if we want something that can be reused. However,
> this looks pretty complex so coming up with something generic is probably
> not worth the effort. 

Not directly, there is often a conversion whenever we are dealing
with scale, phase, frequency or sampling frequency.

> Instead, I would suggest to create a firmware file format that
> describes how the chip should be programmed. And in the driver call
> firmware_upload_register() to create a sysfs interface where the
> firmware can be loaded/replaced at runtime. This way, there is just
> one attribute write needed to set all of the parameters at once.
> 
> This could probably be as simple as something that just contains
> the value of each register to be programmed and the driver can
> write all of the registers just before enabling the output.

Not sure, if that makes things simpler, specially for the application
the would interface with this. I think having the attributes as is
would be the whole point of using the IIO subsystem.

-- 
Kind regards,

Rodrigo Alencar
