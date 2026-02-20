Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE2279DAD;
	Fri, 20 Feb 2026 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771605988; cv=none; b=C2QAhKoRFTKZDiC4EJ73+8IpBn6VZ0qXhc5Mj7sYd/QJBoT546L+IAvIbcOuftPq+ZUEHZOtbGiB24Ccc1VNvnhgzVpCC3YnwWqKo+/7iwcdTrZnuXIMZoZiDEJpZD3dhTXnyvhvdPDXTSGkGIvq+DZwEJjLj7akjHNS8OwbMSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771605988; c=relaxed/simple;
	bh=hkjgdvfchIl5Y6/yVJYHc2bds9N5SWFxNI92b6rmzeI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SYCrGNmdgTgjlQHxhmBTMBljkmJHz1eJwgUWxEpTBlveW/0emZ0uvwpjZMwJGntONt5PublcGh0O5krOSMHRuAfeMSugRsrIBXFh35+UuZ2f1+iYOQpZ2ZD+t8vV+PdwLAIVBpN2qkef4RUSG0E0b/+pJTl7+0DlVvl5EVH1cr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwhQrOJC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwhQrOJC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C272C116C6;
	Fri, 20 Feb 2026 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771605987;
	bh=hkjgdvfchIl5Y6/yVJYHc2bds9N5SWFxNI92b6rmzeI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pwhQrOJCFoEKYoPleL2ICbzviLFsDI77QdZBTT3M0uVj8bu8STAsJok0P+LFwP1C9
	 WSqLaM+eU+t3/XEwVSzqy523cYgwhEShXmUrXbcoI0jEB1jBBnq80VmZxmvE974pD2
	 B3EZlrcsbiDDJ/vgn4yD0SWqjyRO2KWKgYADT4jMcV6FdY8kxxs+vKjsKPq5r0+00y
	 RIs+2rx+yrQdQfUIWjfNZVeEG8grY91MPqftwNBcpWN0ewFZonQv7dRU1waSenu8qA
	 Qoe9Uoevu+NR/W6hYjSochK9LtaqrKeUKkeMtr0EnwSQhQlP+OfyQCaMZeykDg+KQm
	 uOuzD0mJ5jDnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B21EC54FD3;
	Fri, 20 Feb 2026 16:46:27 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH RFC 0/8] AD9910 Direct Digital Synthesizer
Date: Fri, 20 Feb 2026 16:46:04 +0000
Message-Id: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMyPmGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0ML3cQUS0tDA93MzHzdlKLMstQiXcsk4xQjQ5NkI1PDNCWgvoKi1LT
 MCrCZ0UpBbs5KsbW1AC7J5utoAAAA
X-Change-ID: 20260218-ad9910-iio-driver-9b3d214c251f
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771605986; l=8030;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=hkjgdvfchIl5Y6/yVJYHc2bds9N5SWFxNI92b6rmzeI=;
 b=YYReM6Fw/Ces9NdYBxYK9AKN6tFSo6Wqkk/afjVMDiWQvnjyXGEh7QT9QdnCj1HtoxwT42SR8
 oi2GGNZvhsNDUYcPv3YLMLY/9asgp+QVQg+Agzxuxw5wgGaIvvqpWaL
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This patch series adds support for the Analog Devices AD9910 DDS.
This is an RFC so that we can agree/discuss on the design that follows:

The AD9910 DDS core can be driven through several independent mechanisms:
single tone profiles, a digital ramp generator, an internal RAM playback
engine, a parallel data port, and output shift keying. Each of these
represents a distinct signal path into the DDS accumulator, so the driver
models them as separate IIO output channels (all IIO_ALTVOLTAGE type).
This per-channel separation allows userspace to configure each mode
independently through its own set of sysfs attributes, and to
enable/disable modes individually via IIO_CHAN_INFO_ENABLE, relying on
the hardware's own mode selection architecture.

The AD9910 register map is not suited for the regmap framework: register
widths vary across the map (16, 32, and 64 bits). The driver instead
implements direct SPI access helpers with a software register cache, using
type-specific read/write/update functions (ad9910_reg{16,32,64}_{read,
write,update}) that handle endianness conversion and cache coherency.

Registers are cached for several reasons. The control/function registers
(CFR1, CFR2) are frequently queried to determine the current operating
mode (e.g., checking RAM_ENABLE before every profile register access),
and caching avoids repeated SPI read transactions for what are
essentially state checks. The cache also enables efficient
read-modify-write updates on multi-byte registers: the update functions
merge new field values with the cached register content without issuing
a SPI read, and skip the write entirely when the value is unchanged.
Finally, the profile registers serve dual purposes depending on whether
RAM mode is active -- they hold single tone parameters (FTW, POW, ASF)
in normal operation but are repurposed for RAM playback configuration
(start/end address, step rate, operating mode) when RAM is enabled. A
shadow register array (reg_profile[]) preserves the inactive mode's
settings across transitions, so no state is lost when switching between
single tone and RAM operation.

RAM data is loaded through a write-only binary sysfs attribute
(ram_data). Userspace writes the waveform data as a raw binary buffer
(up to 4096 bytes for the full 1024x32-bit RAM), and the driver
transfers it to the device in a single SPI transaction. Per-profile
start/end addresses and playback parameters (operating mode, step rate,
no-dwell control) are configured through the RAM channel's ext_info
attributes.

Streaming data to the DDS core through the parallel data port at the
PD_CLK rate is not covered by this series. That functionality would
be added in a separate patch series, building on top of the IIO backend
infrastructure to provide a proper buffered data path.

As I am pushing implementation, as lot has been done already without much
supervision or agreement, still I would be interested on hearing about
the design choices discussed above. Here is the output for the iio_info
at this point:

5 channels found:
    altvoltage1:  (output)
    9 channel-specific attributes found:
        attr  0: en value: 0
        attr  1: frequency_offset value: 0.000000
        attr  2: frequency_scale value: 1
        attr  3: label value: parallel_port
        attr  4: phase_offset value: 0.000000
        attr  5: powerdown value: 0
        attr  6: profile value: 0
        attr  7: sampling_frequency value: 100000000.000000
        attr  8: scale_offset value: 0.000000
    altvoltage3:  (output)
    13 channel-specific attributes found:
        attr  0: address_end value: 1023
        attr  1: address_start value: 0
        attr  2: destination value: frequency
        attr  3: destination_available value:
          frequency phase amplitude polar
        attr  4: en value: 0
        attr  5: frequency value: 0.000000
        attr  6: label value: ram_control
        attr  7: operating_mode value: direct_switch
        attr  8: operating_mode_available value:
          direct_switch ramp_up bidirectional
          bidirectional_continuous ramp_up_continuous
          sequenced sequenced_continuous
        attr  9: phase value: 0.000000
        attr 10: powerdown value: 0
        attr 11: profile value: 0
        attr 12: sampling_frequency value: 100000000.000000
    altvoltage2:  (output)
    27 channel-specific attributes found:
        attr  0: burst_count value: 0
        attr  1: burst_delay value: 0.000000030
        attr  2: control_en value: 0
        attr  3: decrement_sampling_frequency value: 100000000.000000
        attr  4: destination value: frequency
        attr  5: destination_available value: frequency phase amplitude
        attr  6: en value: 0
        attr  7: frequency_decrement value: 0.000000
        attr  8: frequency_increment value: 0.000000
        attr  9: frequency_max value: 0.000000
        attr 10: frequency_min value: 0.000000
        attr 11: increment_sampling_frequency value: 100000000.000000
        attr 12: label value: digital_ramp_generator
        attr 13: operating_mode value: bidirectional_continuous
        attr 14: operating_mode_available value:
		  bidirectional ramp_down ramp_up bidirectional_continuous
        attr 15: phase_decrement value: 0.000000000
        attr 16: phase_increment value: 0.000000000
        attr 17: phase_max value: 0.000000000
        attr 18: phase_min value: 0.000000000
        attr 19: powerdown value: 0
        attr 20: profile value: 0
        attr 21: ramp_delay value: 0.000000020
        attr 22: scale_decrement value: 0.000000000
        attr 23: scale_increment value: 0.000000000
        attr 24: scale_max value: 0.000000000
        attr 25: scale_min value: 0.000000000
        attr 26: toggle_en value: 0
    altvoltage0:  (output)
    6 channel-specific attributes found:
        attr  0: frequency value: 0.000000
        attr  1: label value: single_tone
        attr  2: phase value: 0.000000
        attr  3: powerdown value: 0
        attr  4: profile value: 0
        attr  5: scale value: 0.000000
    altvoltage4:  (output)
    8 channel-specific attributes found:
        attr  0: en value: 0
        attr  1: label value: output_shift_keying
        attr  2: pinctrl_en value: 0
        attr  3: powerdown value: 0
        attr  4: profile value: 0
        attr  5: sampling_frequency value: 100000000.000000
        attr  6: scale value: 0.000000
        attr  7: scale_increment value: 0.000000
3 device-specific attributes found:
        attr  0: ram_data ERROR: Permission denied (13)
        attr  1: sysclk_frequency value: 400000000
        attr  2: waiting_for_supplier value: 0
1 debug attributes found:
        debug attr  0: direct_reg_access value: 0x2

Kind regards,

Rodrigo Alencar

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Rodrigo Alencar (8):
      dt-bindings: iio: frequency: add ad9910
      iio: frequency: ad9910: initial driver implementation
      iio: frequency: ad9910: add simple parallel port mode support
      iio: frequency: ad9910: expose sysclk_frequency device attribute
      iio: frequency: ad9910: add digital ramp generator support
      iio: frequency: ad9910: add RAM mode support
      iio: frequency: ad9910: add output shift keying support
      iio: frequency: ad9910: add channel labels

 .../bindings/iio/frequency/adi,ad9910.yaml         |  236 +++
 MAINTAINERS                                        |    8 +
 drivers/iio/frequency/Kconfig                      |   18 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/ad9910.c                     | 2153 ++++++++++++++++++++
 5 files changed, 2416 insertions(+)
---
base-commit: cce8de7f9744a210a4441ca8a667a9950515eea7
change-id: 20260218-ad9910-iio-driver-9b3d214c251f

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


