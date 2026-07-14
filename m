Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D537C93F;
	Tue, 14 Jul 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026973; cv=none; b=hKY6SikipOZIHhcVArvS9NoPg1x9bwqy4ZRfiVEOGVBiIYv/0Zz0Uy4Lzaufvz91bWxHb+MHbBEGos2GILFfYtyiNSejQANSEQT5wzE1YeEZBJuuX2AU7XAcu4T8Svy5gVRkDo4Bb2QtVMFjgMJNNLVe/6VpP0ZpIcsuPLkX1OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026973; c=relaxed/simple;
	bh=YeJ95WhFiR9IeKl8uYvk+1Ue9DwGTckU3VaVUIF/LV0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eqzgHT7cCnQTNmDoJJxM6312B8C3BggBewg8P3D0nl+i3ekfz/b2Uo4JwD+X2RipEgh3AqcIgjftcgGqILSOnzXRbE0wPynQ2e4Gm/ovu911ZY/xGR5afUT6mjAkue3oVQmAFiAKbxsh2/EfxlOSfXcxwFJZ9lonFnxj9C/m/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLpCiQ81; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLpCiQ81"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96E20C2BCB8;
	Tue, 14 Jul 2026 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784026972;
	bh=YeJ95WhFiR9IeKl8uYvk+1Ue9DwGTckU3VaVUIF/LV0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TLpCiQ81P6RvMT6Oqzv+Durmvx3Nr8irAX+GYEH+51Z2vmcGkhy0eBzVC2b2DweiQ
	 PHM5Y7r3Y98u7o+pnxUwjovKYdebFVCk4nNg1JrC9dsHA9BSrRBmljSucR6rFYfgWH
	 55u6A1+gi+DYBYyCOfWvH9ffVKmVJcNn3ksrXkv2pFEhqW24/mLeDp2T9y/n8V/GjO
	 aPOR+HyOAfosuqqvmejQTSPLhuZ6WzH8zXgWLvyv3F7hvLB3Qx5+/A4j8lvDXSt99q
	 QSX+s9e1ff7pvgk/513OitVc685A7GRFMKL8SUK76XfJUNT/aMXn3QMaCnZY69HiCn
	 AXn3HjjJN9ZxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAAFC43458;
	Tue, 14 Jul 2026 11:02:52 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v8 00/17] AD9910 Direct Digital Synthesizer
Date: Tue, 14 Jul 2026 12:02:40 +0100
Message-Id: <20260714-ad9910-iio-driver-v8-0-36939c3c07d2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFAXVmoC/23Qy0oEMRAF0F8ZsjaSqsqj48r/EBd5zgR0WtISl
 KH/3fQgtNJZ3kBOXe6NLamWtLCn043V1MpS5msP08OJhYu7nhMvsWeGArVAmLiL1oLgpcw81tJ
 S5dZTRJABFWTW/33UlMvX3Xx57flSls+5ft9PNNhefzUUA60BF5w8aumcnByIZ3d1b/P5Mczvb
 OMa7gQNCzXsRDI2W/IpZIADQTshwYwI6gRab8kAOsTpQMidUGLYQnYiovY5okiJ4oFQf4hxC7V
 tAcraME0E0h0IvRN6vIXuhLGAKmefJB3nNDthxLCF6YSTKZDImoz4T6zr+gPGbdV8RQIAAA==
X-Change-ID: 20260218-ad9910-iio-driver-9b3d214c251f
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784026971; l=8196;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=YeJ95WhFiR9IeKl8uYvk+1Ue9DwGTckU3VaVUIF/LV0=;
 b=c30AvMqC39fYHjLv02J0NECdQ1EIYaQMthXezKuiFwfzXVbysCri7XT8+3t9+4uyzHyfkH3Tz
 xelMUdbVosLBTbLXj9QezhQI4zZUEwq2WCPIG021G02Semp/tIcktkF
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This patch series adds support for the Analog Devices AD9910 DDS.

This is a follow-up of the V3/V4/V5 discussion. For V1, we reached into
this channel composition agreement where physical channels may have
sub-channels. That adds the flexibility necessary for this design.
During V2, some feedback indicated that the ABI is too device-specific,
so DRG/RAM destination and operating modes are configured through
alternate paths and profile channels are created. In V3/V4/V5, there was
further discussion on the ABI and on mode priority debug.

The AD9910 DDS core can be driven through several independent mechanisms:
single tone profiles, a digital ramp generator, an internal RAM playback
engine, a parallel data port, and output shift keying. Each of these
represents a distinct signal path into the DDS accumulator, so the driver
models them as separate IIO output channels (IIO_ALTCURRENT, IIO_PHASE
and IIO_FREQUENCY). This per-channel separation allows userspace to
configure each mode independently through its own set of sysfs attributes,
and to enable/disable modes individually via IIO_CHAN_INFO_ENABLE, relying
on the hardware's own mode selection architecture.

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

RAM data is loaded through firmware upload infrastructure. Userspace
writes the waveform data as a raw binary buffer (up to 4096 bytes for
the full 1024x32-bit RAM), and the driver reverses the byte array and
transfers it to the device in a single SPI transaction. Per-profile
start/end addresses and playback parameters (operating mode, step rate,
no-dwell control) are also configured through firmware update, using
metadata in the header.

Streaming data to the DDS core through the parallel data port at the
PD_CLK rate is not covered by this series. That functionality would
be added in a separate patch series, building on top of the IIO backend
infrastructure to provide a proper buffered data path.

Kind regards,

Rodrigo Alencar

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v8:
- Adjust channel prefix kunit test.
- Include raw attribute ABI for frequency channels.
- SW powerdown split into two steps.
- Address some of sashiko's feedback and other minor changes.
- Link to v7: https://lore.kernel.org/r/20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com

Changes in v7:
- Use seq_buf instead of scnprintf() in __iio_chan_prefix_emit().
- Add tests for __iio_chan_prefix_emit().
- #clock-cells as required in the dt-binding.
- Add drctl as pwm in the dt-binding.
- Check refclk freq range when pll is disabled.
- Address other minor feedback (e.g. sashiko's ones) 
- Link to v6: https://lore.kernel.org/r/20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com

Changes in v6:
- Introduce IIO_FREQUENCY channel type.
- Replace altvoltage channels for altcurrent.
- DRG and Parallel Port destination handled with different channel types.
- Parent attribute shows channel prefix rather than label.
- Link to v5: https://lore.kernel.org/r/20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com

Changes in v5:
- Drop RFC tag to the patch series.
- Address sashiko's comments.
- Add parent-child relationship between iio channels.
- List vs Table changes in documentation.
- Add crc and version check to RAM mode firmware update.
- Link to v4: https://lore.kernel.org/r/20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com

Changes in v4:
- Digital Ramp step exposed as a rate of change.
- Dwell modes of Digital Ramp are controlled with dwell_en attribute. 
- Disable of active profile behaves as a software powerdown.
- Expose debugfs attributes to show mode priority.
- Add 64-bit debugfs reg access support into iio core.
- Link to v3: https://lore.kernel.org/r/20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com

Changes in v3:
- RAM custom configs (address range, destination, modes) loaded during firmware write.
- DRG destination defined when attrs are written.
- DRG modes broken down into enable attrs for ramp up/down channels.
- Add separate profile channels, switching done through enable attr
- Link to v2: https://lore.kernel.org/r/20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com

Changes in v2:
- Device-tree bindings changes.
- RAM loading to use firmware update interface.
- Rearrange of channels into a hierarchy.
- Link to v1: https://lore.kernel.org/r/20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com

---
Rodrigo Alencar (17):
      iio: ABI: add attributes for altcurrent channels
      iio: ABI: raw, scale and offset for frequency/phase channels
      iio: ABI: add parent entry for iio channels
      iio: add IIO_FREQUENCY channel type
      iio: core: support 64-bit register through debugfs
      iio: core: create local __iio_chan_prefix_emit() for reuse
      iio: test: add kunit tests for channel prefix naming generation
      iio: core: add hierarchical channel relationships
      dt-bindings: iio: frequency: add ad9910
      iio: frequency: ad9910: initial driver implementation
      iio: frequency: ad9910: add basic parallel port support
      iio: frequency: ad9910: add digital ramp generator support
      iio: frequency: ad9910: add RAM mode support
      iio: frequency: ad9910: add output shift keying support
      iio: frequency: ad9910: show channel priority in debugfs
      iio: ABI: add docs for ad9910 sysfs and debugfs entries
      docs: iio: add documentation for ad9910 driver

 Documentation/ABI/testing/debugfs-iio-ad9910       |   23 +
 Documentation/ABI/testing/sysfs-bus-iio            |   56 +
 .../ABI/testing/sysfs-bus-iio-frequency-ad9910     |   31 +
 .../bindings/iio/frequency/adi,ad9910.yaml         |  209 ++
 Documentation/iio/ad9910.rst                       |  792 +++++++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   18 +
 drivers/iio/frequency/Kconfig                      |   21 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/ad9910.c                     | 2386 ++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |  245 +-
 drivers/iio/test/Kconfig                           |   14 +
 drivers/iio/test/iio-test-channel-prefix.c         |  299 +++
 include/linux/iio/iio-opaque.h                     |    2 +-
 include/linux/iio/iio.h                            |   12 +
 include/uapi/linux/iio/types.h                     |    1 +
 tools/iio/iio_event_monitor.c                      |    2 +
 17 files changed, 4002 insertions(+), 111 deletions(-)
---
base-commit: aa58ecc73466d0cb8c418de98e2225490bf600e3
change-id: 20260218-ad9910-iio-driver-9b3d214c251f

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


