Received: from out-2z4y-a154.jellyfish.systems (out-2z4y-a154.jellyfish.systems [198.54.127.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469BD37E5C1
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223913; cv=none; b=ufXHFSLRLaRFQLjuiqxwiRsfWLrQe7s01nonwBvgjuP8C8VTp8xYA08DO2pK85neEuff/FPAKsEEbTDOFn7SH/eVfpsg5ugQjXGAXGBu0jwbeAZvzXYly1yoDJpEPhEcX6sLDauR/+XtcByPOnxYWWMsunDipxqAJ6NzZWNVe4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223913; c=relaxed/simple;
	bh=pDHNs5tzOnSgGhVMJwsbSK33nJ4lCp8YGpCMQIp8Z88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SukIplAoIlXD0qhoxNtKDBbkmrts9jxB0u0kTFn3KgbjDGI+13Iy2AfYqS/KO4+x35iQQmByJXuPJrzP157YgfmX7XjpSduD7VaLmFnWauOizEEg34NjRnp8Wc02W1JQQzCyYUT2vuEW3bG2SVH4ktWwa4DSlBjWbRgQ8HLgbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hYnP53ZSnz2x9C;
	Tue, 01 Sep 2026 00:51:37 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH v3 0/5] iio: light: stk3310: per-chip match data and STK36C61 support
Date: Tue,  1 Sep 2026 02:51:09 +0200
Message-ID: <20260901005114.203062-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

The Sensortek STK36C61 is a 3-in-1 ambient light / proximity / RGB
colour sensor whose register interface is compatible with the stk3310
across the ALS and proximity data, threshold, gain and
integration-time registers this driver uses. The part name comes from
the Fairphone 6 manual, which lists the component as "3IN1 ALPS/RGB
sensor/STK36C61". The layout was probed on the device: chip ID 0x95,
the stk3310 STATE/FLAG bit layout, data and threshold registers
(thresholds written through the event interface read back from the
chip, and the FLAG near/far bit crosses with them), gain and
integration-time fields the ALS and proximity readings scale with,
and an RGBC data block directly after the ALS data, the red, green
and blue assignments each confirmed by the matching channel
dominating under the matching illumination and clear by its broadband
response.

The colour controls: R, G and B share the illuminance channel's gain.
Clear is gained by its own field in a GAINCTRL register at 0x4E,
originally located via the datasheet of the STK37660 (a documented
sibling with the same data register layout) and verified on the
device: stepping it multiplies the clear count by ~4 per step while
the other channels hold still. The STK36C61 patch exposes scale and
integration time on the colour channels.

A public datasheet exists: the STK36C61-A preliminary datasheet,
version 0.9, hosted by LCSC [1]. It agrees with the device on the
colour-engine layout (RGBC data at 0x15-0x1C, the clear gain in
GAINCTRL 0x4E, the shared RGB-gain and integration-time fields in
ALSCTRL1), but it documents the -A variant and gives the product ID
as 0x93 where this part reports 0x95. Luca Weiss reports a newer
revision (0.9.2) gives 0x95 and different mLux-per-count figures for
the ALSCTRL1 gain settings. I could not find a published copy of
that revision.

Tested on a Fairphone 6 running a 7.2-based tree: this series'
stk3310.c, byte-identical, built as a module against that tree (the
i2c core files the binding behaviour depends on are identical between
the trees). Verified there: DT boot instantiation, the colour
scale/integration-time interface, and the sysfs name behaviours this
series changes: a lower-case name reaches the id table's match data,
capitals no longer bind, and a full-compatible-string client now
fails probe with the missing-driver-data error. A board DTS node
using the new compatible follows separately via linux-arm-msm.

Patch 5 carries no Datasheet: tag since the sheet at [1] is a
preliminary for the -A variant: the published revision's product ID
mismatches this part's, the register map omits the ALS data
registers, and the later revision disagrees on the mLux-per-count
figures. I am unable to find specifics for the Datasheet: tag,
whether it must be the exact sheet for the part or if a "good
enough" sheet is accepted.

Changes in v3:
- patch 4: drop the tab alignment of the chip_info members, take the
  probe failure through a struct device local, and return -ENODATA
  instead of -ENODEV on missing match data, commit message
  wording tightened (Andy)
- patch 5: commit message squeezed to the point, the verification and
  colour-assignment detail moved into this letter, the scale
  rationale trimmed to its load-bearing constraint (Andy, Jonathan)
- cover letter: the "no public datasheet" claim corrected (Marcelo)
- picked up Andy's Reviewed-by on patches 1 and 3

v2: https://lore.kernel.org/all/20260826175409.326131-1-jorijnvdgraaf@catcrafts.net/
v1: https://lore.kernel.org/all/20260810110423.41697-1-jorijnvdgraaf@catcrafts.net/

[1] https://www.lcsc.com/datasheet/C49230205.pdf

Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>

Jorijn van der Graaf (5):
  iio: light: stk3310: lower-case the i2c device ID names
  dt-bindings: iio: light: stk33xx: document the Sensortek STK36C61
  iio: light: stk3310: move the data registers into the channel address
  iio: light: stk3310: add per-chip match data
  iio: light: stk3310: support the Sensortek STK36C61

 Documentation/ABI/testing/sysfs-bus-iio       |   1 +
 .../bindings/iio/light/stk33xx.yaml           |   9 +-
 drivers/iio/light/stk3310.c                   | 203 +++++++++++++-----
 3 files changed, 156 insertions(+), 57 deletions(-)


base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
-- 
2.55.0

