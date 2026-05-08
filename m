Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B413101A7;
	Fri,  8 May 2026 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259634; cv=none; b=cLD/L5rQrWps2suq+c/c7Vmd5p0oQs9On/jtSJrD6Ckp2wGTgYLn1EjFnPyqcnq7wK7pWGjqyGtLrvJeXBDu4gVB0/lNPCPkfhSYLeqDnW2WEzoHaul1zhNAOu+Rhx+z0KJsa4LSVUUWPC1YezCtOMD4AqRH2q7GV9AjxZ0E54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259634; c=relaxed/simple;
	bh=fufvz3D3Ed+0Vx3B7r+7ZrpCMU/irXf5wqRVZ6Rm4uk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=icMLIT+Ox+bFbiyPk1Tftab1UWJRA6q/F9Njoqc6OQ45YYL4ji6nuXah3bXaqGfhDofxY67tW70K3mYILCj/L7orKsycp0x5K805Z1e0ySSjf7hi7XeaV2kQ/BUbvZq84MRCSPUWPhjb3Km1VJo6jtqvT8DneH5jWgNWuWoOLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDHZiJLy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDHZiJLy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62ECDC2BCB0;
	Fri,  8 May 2026 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778259634;
	bh=fufvz3D3Ed+0Vx3B7r+7ZrpCMU/irXf5wqRVZ6Rm4uk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kDHZiJLyjuzNsKRpE2m4nGNcFcnVhPj8rNegYNbjcviGKTHnnks93NMrpTE7ns2Lk
	 pZsudzjSnpXn3qktbs6O3ydR8RHIwZvyzcG6w/f3fvxKTRVRw4ZCOopDVmtJGnA1Ys
	 bs3WwGfuyKxVOK9XFMmEKhP/YNw/pLjjs3MmRdSkrJC6tbPHeKrQjkyU2nj8AiDuyz
	 yGygllBJ2tEvstRZ7ti5sHPm4gDekFhhtxPG7xhrmMYBSKyvG+4KHhishvvNxUtzKQ
	 Ukg54dp83fVjKQIUXHIGpjjO+SOXT96Ly+1QvLMB4wwdAaXyutXSZc1Cz80+B/T1s7
	 vL3ujsgNMP7rQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEA4CD3445;
	Fri,  8 May 2026 17:00:34 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH RFC v4 00/10] AD9910 Direct Digital Synthesizer
Date: Fri, 08 May 2026 18:00:16 +0100
Message-Id: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKAW/mkC/23OwQrCMAwG4FcZPVtp0rqtngTBB/AqHrqt2wK6S
 itFGXt3yzwMccc/4f+SkQXryQa2z0bmbaRAbkhBbTJW92boLKcmZYYCc4FQctNoDYITOd54itZ
 zXckGQdW4g5al3sPbll6zeWHn05Fd07Cn8HT+Pd+JMK++JIoVMgIXXFaYK2NUaUAczGBurtvW7
 j5zERdCrn4VMRG20K2Wla1bgD9CLoSCYo2QiUBdaVkAGsTyh5im6QMKQJetPgEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778259632; l=6178;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=fufvz3D3Ed+0Vx3B7r+7ZrpCMU/irXf5wqRVZ6Rm4uk=;
 b=wIkMQtQcYZN0KDHnFvW3yjOLjt5CiSp9nvYy0Zw5lJrN0JaQPtSqeE2l+m9AyqHun3ynRWsoV
 CL3HlcpOP07Ckn2TrGazpsBlHnqxX5gQlimyzCxfi+h6f94OlE+H+Em
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This patch series adds support for the Analog Devices AD9910 DDS.
This is a RFC so that we can agree/discuss on the design that follows:

This is a follow-up of the V3 discussion. For V1, we reached into
this channel composition agreement where physical channels may have
sub-channels. That adds the flexibility necessary for this design.
During V2, some feedback indicated that the ABI is too device-specific,
so DRG/RAM destination and operating modes are configured through
alternate paths and profile channels are created. In V3, there was
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

As I am pushing implementation, as lot has been done already without much
supervision or agreement, still I would be interested on hearing about
the design choices discussed above.

Kind regards,

Rodrigo Alencar

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
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
Rodrigo Alencar (10):
      dt-bindings: iio: frequency: add ad9910
      iio: core: support 64-bit register through debugfs
      iio: frequency: ad9910: initial driver implementation
      iio: frequency: ad9910: add basic parallel port support
      iio: frequency: ad9910: add digital ramp generator support
      iio: frequency: ad9910: add RAM mode support
      iio: frequency: ad9910: add output shift keying support
      iio: frequency: ad9910: show channel priority in debugfs
      Documentation: ABI: testing: add docs for ad9910 sysfs entries
      docs: iio: add documentation for ad9910 driver

 .../ABI/testing/sysfs-bus-iio-frequency-ad9910     |   73 +
 .../bindings/iio/frequency/adi,ad9910.yaml         |  198 ++
 Documentation/iio/ad9910.rst                       |  607 +++++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   10 +
 drivers/iio/frequency/Kconfig                      |   20 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/ad9910.c                     | 2398 ++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   33 +-
 include/linux/iio/iio.h                            |    4 +
 10 files changed, 3336 insertions(+), 9 deletions(-)
---
base-commit: 9e62a5d329f8f0f07c4d5f80a691e3f16dcb957c
change-id: 20260218-ad9910-iio-driver-9b3d214c251f

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


