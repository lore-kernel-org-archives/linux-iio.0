Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951BF3A8756;
	Fri, 17 Apr 2026 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413869; cv=none; b=ujCKNcqx5zjmRlR6+MUt3MMIbeSdUvvzIwPJAwA3droUiheTekH5FubwYwEkZAseNuRcRzejE7EhTYIdRd+vIhbzUMCCw0VR2b3Y898n7y6+KGb5zjYo3tN3dR2ttoqeTk4B6kwcTz90Dy9oAH7dIsLCTtWcTjqqogdrL5rLZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413869; c=relaxed/simple;
	bh=qDl6b8j+50GWnqXWqLLHZmRGl2hcm+uogC6+5zx4iYk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T2OBhd3PAOGc8zHAUWrrUr5T8VQGBe++MmZVh3zZqM3x3G1iOaJa8Vz9LSXlp4ur2dU2F8LipAlT11bumHqgGK72L87R5Mf7sh90T2dABdxDOZ4t4a+tvRZejd5qPl5KC6o4qqu0h2dXibS53gisSjDjFxag+yid3ZCTbQPf0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnST3SMO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnST3SMO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 333C1C19425;
	Fri, 17 Apr 2026 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776413869;
	bh=qDl6b8j+50GWnqXWqLLHZmRGl2hcm+uogC6+5zx4iYk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZnST3SMO3rvWqLl74IdmK5Xwncjhc47N1QGl4U2/wPYQSd/4SOI/mYXZ+nUQvSjJx
	 deX1WIW1YqSatUDfE2pSjnkKsfUzfGPo0d9ahB/VmJBe8k7TSOzKVKbg6QsVxlfks2
	 vUr6eP1M+zjTA8TBUNxe7HDqwlvOlrXuH38LTJR+yegxutdppr65qrCacJhbKop5sY
	 xkAGMOE+Yi4+vW2ZLXOVKL1ZXxzG4f7WcXv8EEjqoWIrxgq6lPK3aMHKBJF2w6YQAc
	 K3jdoUS5LpGEsi3ficnl8OIZ47w2L/sIhk5MzI/pErEia6iAqVf58DFiPXyTFhY8P+
	 ZTZ8cTxRo3bEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259D0F8E4B2;
	Fri, 17 Apr 2026 08:17:49 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH RFC v3 0/9] AD9910 Direct Digital Synthesizer
Date: Fri, 17 Apr 2026 09:17:29 +0100
Message-Id: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJns4WkC/23OwQrCMAwG4FcZPVtp0jlXT4LgA3gVD13bzYCu0
 kpRxt7dUg8i7Pgn/F8ysegCuch21cSCSxTJjznIVcXMVY+D42RzZiiwEQgt11YpEJzIcxsoucB
 VJy1CbXADPcu9R3A9vYp5ZqfjgV3y8Erx6cO73ElQVl8SxQKZgAsuO2xqretWg9jrUd/8sDb+X
 riEP0IufpUwE26reiU7Z3qAP2Ke5w99Sqal+wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776413867; l=5487;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=qDl6b8j+50GWnqXWqLLHZmRGl2hcm+uogC6+5zx4iYk=;
 b=Voa/RBJsJokhMpm7/iaji4iGD8KYu19TZHf1Sjq7PqLdGtBRZIcHnP36LHj1mtT03rCvsrYoi
 SsNKPyLl6c7APqMYWGxXgQzUpTyC4EH58PKQhrR/d1Z6jtOfE4Qy4Sr
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This patch series adds support for the Analog Devices AD9910 DDS.
This is a RFC so that we can agree/discuss on the design that follows:

This is a follow-up of the V2 discussion. For V1, we reached into
this channel composition agreement where physical channels may have
sub-channels. That adds the flexibility necessary for this design.
During V2, some feedback indicated that the ABI is too device-specific,
so DRG/RAM destination and operating modes are configured through
alternate paths and profile channels are created.

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
Rodrigo Alencar (9):
      dt-bindings: iio: frequency: add ad9910
      iio: frequency: ad9910: initial driver implementation
      iio: frequency: ad9910: add simple parallel port mode support
      iio: frequency: ad9910: add digital ramp generator support
      iio: frequency: ad9910: add RAM mode support
      iio: frequency: ad9910: add output shift keying support
      iio: frequency: ad9910: add channel labels
      Documentation: ABI: testing: add docs for ad9910 sysfs entries
      docs: iio: add documentation for ad9910 driver

 .../ABI/testing/sysfs-bus-iio-frequency-ad9910     |   62 +
 .../bindings/iio/frequency/adi,ad9910.yaml         |  189 ++
 Documentation/iio/ad9910.rst                       |  586 ++++++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   10 +
 drivers/iio/frequency/Kconfig                      |   20 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/ad9910.c                     | 2118 ++++++++++++++++++++
 8 files changed, 2987 insertions(+)
---
base-commit: ff0843ceb1fb11a6b73e0e77b932ef7967aecd4b
change-id: 20260218-ad9910-iio-driver-9b3d214c251f

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


