Received: from out-zbxj-a91.jellyfish.systems (out-zbxj-a91.jellyfish.systems [198.54.127.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3C93644DE
	for <linux-iio@vger.kernel.org>; Wed, 26 Aug 2026 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767199; cv=none; b=Ujb/2gDkqyP7bG8E4F/JZXHyZAKpwC5hrxt21ymkjOenK9Mu1GlQVq01aTNtQJmaj8qtflG/LJWXUgA0JJqzs2b/DWB2afVCxlvmj8lhlRvvdewZNO62TCFy6cqzGJNiWCySYqhWD667ZvOcF2Ab3eDMg0PkDVXlMVsrkee0KIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767199; c=relaxed/simple;
	bh=qsjU4zGLsgR/tuhbMSGgvC5vLLNvsAWAVdlAVHl/CdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWAM2MbEHWrZ0HHE8xr/CvHkGHRlO3mC3E1aEXYozRvEmxFxcNLIVdia3xqU3+uFLf+2t9fzJlirBGLV853wlCm5+TlxDt4Y0wxhM3LPEXz6500T8i99dgIlsdQpcLRf44LUP3xlEcu9/qHyHN9LMcRlqpxRZjoX8Wq86bzsN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hVXMr3w0sz8sWT;
	Wed, 26 Aug 2026 17:54:16 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH v2 0/5] iio: light: stk3310: per-chip match data and STK36C61 support
Date: Wed, 26 Aug 2026 19:54:04 +0200
Message-ID: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
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
sensor/STK36C61". There is no public datasheet; the layout was probed
on the device: chip ID 0x95, the stk3310 STATE/FLAG bit layout, data
and threshold registers, gain steps that scale the ALS reading
accordingly, and an RGBC data block directly after the ALS data.

Since v1 the colour block's controls were located, confirming
Jonathan's guess on v1's patch 3 that they sit in a register we had
not found: the STK37660 datasheet, a documented sibling with the same
data register layout, places a clear-channel gain field in a GAINCTRL
register at 0x4E, split from the RGB gain in ALSCTRL, and stepping it
on the STK36C61 multiplies the clear count by ~4 per step while the
other channels hold still. The STK36C61 patch therefore now exposes
scale and integration time on the colour channels.

Tested on a Fairphone 6 running a 7.2-based tree: this series'
stk3310.c, byte-identical, built as a module against that tree (the
i2c core files the binding behaviour depends on are identical between
the trees). Verified there: DT boot instantiation, the colour
scale/integration-time interface, and the sysfs name behaviours this
series changes: a lower-case name selects the full profile through
the id table, capitals no longer bind, and a full-compatible-string
client now fails probe with the missing-driver-data error. A board
DTS node using the new compatible follows separately via
linux-arm-msm.

Changes in v2:
- new first patch lower-casing the i2c device ID names (Andy), and
  probe now fails on missing match data instead of falling back to
  the stk3310 profile (Andy)
- new precursor patch moving the data registers into the channel
  .address field (Jonathan), split out of the match-data patch; the
  bulk read gains a regmap local variable (Andy)
- the ACPI table entries use named initializers (Jonathan)
- the STK36C61 patch exposes scale and integration time on the colour
  channels (Jonathan's suggestion on v1 patch 3; the clear-gain
  register located via the STK37660 datasheet and verified on the
  device). With those branches of read_raw now handling the intensity
  channels, the ret = -EINVAL single-exit form promised on the v1
  thread (Andy) has no unreachable branch left to apply to
- picked up Krzysztof's Reviewed-by on the binding patch

v1: https://lore.kernel.org/all/20260810110423.41697-1-jorijnvdgraaf@catcrafts.net/

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

