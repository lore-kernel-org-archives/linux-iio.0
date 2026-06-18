Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FF13D7D6A;
	Thu, 18 Jun 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789269; cv=none; b=gUjehCo+Ov8jqPf9gvJH6dfp5gLplNJknL/HqAlzuUVY8oHwZEphh37iPQHaIEYNpC2NWLUJLNCZBJ21j/A4vM/W8MZi2pIcMddXnyfH4Ryt+T4lppy+WE2t5Z4TXjgH8NzebPsz7GE0wl7OZaGp22vhUnLG+qClIKpMH+ULQjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789269; c=relaxed/simple;
	bh=WF+29eqNGoCWdDBknp4BsM7Q20S5YmRj6yvMd7vsEMg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nlUQJk2m2CQkiyUpGCKh8yY51ZSF8gfPodNtqz9ZOou8KZ+QzHUIXDTltPYbPmwJO1V3pDSEI3HVyY+qntKVA0tOV2CLEp3jhqrjSO658wkZT8aIdLtvs7fUBJpGtx9t2T2aq+R8pCamIHTQ43rjd+e/tYykooSnEWtxX/8A+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4diGiDq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4diGiDq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B6E5C2BCC7;
	Thu, 18 Jun 2026 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781789269;
	bh=WF+29eqNGoCWdDBknp4BsM7Q20S5YmRj6yvMd7vsEMg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=a4diGiDqqkQTsFne2tMWUMjdbpCclDVbEw5gdaO5JyTizUXRhUGSVpDk9Z3zzdNOK
	 eeYu+NVkHAJrLXxeDe9mbunGMPoyFeVKQ+rFrdSxfw5Cpgi44ypG/SrTeCh6Z++56w
	 qt/wsWYCux4cOh+wVV6qO1YP2AqJ/GBgTDm8noF8GzgEO4HIp9HMT5lraB9oFalaOS
	 Za1U5CKv5pp85exeLxbQ+dbtWDHtLFFhMH8fpkeWl4UfqvbSYykPXidHSeXp08rmHy
	 jGzx6dI+9L+wEJ5eaX7sUZGbBe2vdKZkwLP2LGUIKsD5OlZUX+f2CO2TmbhvmAavSc
	 9mVwpU3uPm7Rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4837CCD98F3;
	Thu, 18 Jun 2026 13:27:49 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v6 00/16] AD9910 Direct Digital Synthesizer
Date: Thu, 18 Jun 2026 14:27:16 +0100
Message-Id: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADXyM2oC/23Q3WrEIBAF4FdZvK7FGTXRXvU9ll74M+4KbVJMk
 S1L3r1mKaQlXp6B+eYwd7ZQybSwl9OdFap5yfPUwvB0YuHqpgvxHFtmKHAQCIa7aC0InvPMY8m
 VCrdeRgQVUENibe+zUMq3h3l+a/mal6+5fD9OVNimvxqKjlaBCy49Dso5ZRyIVze59/nyHOYPt
 nEVd0J2C1VsBI02WekpJIADIXdCwdgjZCPQeitHQIdoDoTaCS26LVQjIg4+RRREMh4I/Yfot9D
 bL0BbG4yRoNw/Yl3XH/hRlY2/AQAA
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
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781789267; l=7180;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=WF+29eqNGoCWdDBknp4BsM7Q20S5YmRj6yvMd7vsEMg=;
 b=y9g7jOMSmDTAx38demn5PBHyKZLD5vKB1VK3Rn16ey577RB7shd/9v4l0igeD5XTUV7HcceUi
 Y+/tbg41hXeDzXq8YIbLuJspz5umSCWrUrfxCVyfy1xJg2V2j+51esL
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
Rodrigo Alencar (16):
      iio: ABI: add attributes for altcurrent channels
      iio: ABI: scale and offset for frequency/phase channels
      iio: ABI: add parent entry for iio channels
      iio: add IIO_FREQUENCY channel type
      iio: core: support 64-bit register through debugfs
      iio: core: create local __iio_chan_prefix_emit() for reuse
      iio: core: add hierarchical channel relationships
      dt-bindings: iio: frequency: add ad9910
      iio: frequency: ad9910: initial driver implementation
      iio: frequency: ad9910: add basic parallel port support
      iio: frequency: ad9910: add digital ramp generator support
      iio: frequency: ad9910: add RAM mode support
      iio: frequency: ad9910: add output shift keying support
      iio: frequency: ad9910: show channel priority in debugfs
      iio: ABI: add docs for ad9910 sysfs entries
      docs: iio: add documentation for ad9910 driver

 Documentation/ABI/testing/sysfs-bus-iio            |   36 +
 .../ABI/testing/sysfs-bus-iio-frequency-ad9910     |   27 +
 .../bindings/iio/frequency/adi,ad9910.yaml         |  189 ++
 Documentation/iio/ad9910.rst                       |  759 +++++++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   10 +
 drivers/iio/frequency/Kconfig                      |   21 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/ad9910.c                     | 2288 ++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |  245 ++-
 include/linux/iio/iio-opaque.h                     |    2 +-
 include/linux/iio/iio.h                            |    9 +
 include/uapi/linux/iio/types.h                     |    1 +
 tools/iio/iio_event_monitor.c                      |    2 +
 14 files changed, 3482 insertions(+), 109 deletions(-)
---
base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
change-id: 20260218-ad9910-iio-driver-9b3d214c251f

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


