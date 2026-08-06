Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB3418348;
	Thu,  6 Aug 2026 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045755; cv=none; b=Mbxq4ZdE3+YxeijEL/g08+XMu7VIh2gEpzrRYv1TUnr5Zsj4Zg9U2RhVJXbc0cpyV21Y0I3LglYolKU5WdqkReR+4WAH2TSNyQ8SAcXc6sjgSj0bx5x5oJdtGOuOUQwYedApBa0Tsa/j489e7hVTRf4omtSx7oc4doiTbMfOc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045755; c=relaxed/simple;
	bh=raI20MrYlOu6bLFM+HE81jC5KZTY1Ni31SmKyPR9uWk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P0C0lfvEZiBJKCm+PDvYPkp03LvQk8cJ/XeTusOkGuXyxWF6BLYxP6f7h2OPv6MFxUqmJ97TEFdKE4Kv6V7gHPEGVeGKOYqfqLiDT11SXB0exVLJXGckTQx415UAOSOFRetj2bi4CslMMKA5yOYeveaBMbtIjGWk9RipYHsvGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DcDvUe2M; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DcDvUe2M"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 62177424C0;
	Thu, 06 Aug 2026 21:48:56 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NoRJ2Hp6m-Kq; Thu,  6 Aug 2026 21:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1786045735; bh=raI20MrYlOu6bLFM+HE81jC5KZTY1Ni31SmKyPR9uWk=;
	h=From:Subject:Date:To:Cc;
	b=DcDvUe2M5V+ZrKuu9SETkKfZ/+xp4UH+QZhsw2cGbsqqKREIL4DNfcvSSksQUL2Zy
	 KJ9kVCgXawBBXKkSRGjswl24YKyUs3AAD5InSoOsn+/zKQPcRWuiFyHP4gF8eM+iwg
	 q0whXyEwkq5tww+Tzz1zyQXqpQejp7C9YTbwXUE019tOUvXnbBZ1yxQDTyYDuvOCbO
	 JL6R2DrfKa/jizTlhYwcn+L1PVWsLUiBSEYC0YMIOkvu7AJuJJtVxhzJO6zv2kv1aA
	 kl5z31eNF+UfJ0OrzJ/HJ5qJq6TpiJraVIPMajYczZm/pjtbNfqFPxvHf8KqHLiQZd
	 6//pw9IGPrsLQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v4 0/3] Add Sharp GP2AP070S Proximity Driver and enable it
 in Galaxy J6 (j6lte)
Date: Fri, 07 Aug 2026 01:18:40 +0530
Message-Id: <20260807-gp2ap070s-v4-0-74f6a67b6272@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ7CIBQFr9KwFvOBVqwr72FcUPi0uCgN1EbT9
 O5C3dSoy0nezJtJxOAwklMxk4CTi873CcpdQXSn+hapM4kJB34AyQVtB64GkBCplQiMQy1BVST
 th4DWPdbW5frmeG9uqMccyIvOxdGH53o2sbz71Z0YBdoctRKq1AyMORsXg/fj3oeW5PLEN65gW
 5cnlzXGIoI0FapvV/x1RXINs5VGbWuL8tNdluUFDkddWS4BAAA=
X-Change-ID: 20260723-gp2ap070s-f7e0120970a5
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org

Sharp GP2AP070S is a promixity sensor (NOT an ambient light sensor) in
mobile devices. This sensor chip is found in mobile devices, including
(but perhaps not limited to) Samsung Galaxy J6 (codename: j6lte).

To the best of my knowledge, there's no public documentation available
for this device. [1] is a downstream kernel implementation, which has
been the single source for developing this driver. Some bits have also
been stolen from existing GP2AP* drivers available in iio/light.

The last patch in this series touches the device tree sources to add the
light sensor node in j6lte. This needs to be accepted into next only
when the former patches are in next.

[1] https://github.com/Exynos7870/android_kernel_samsung_universal7870/blob/lineage-16.0/drivers/sensors/gp2ap070s.c

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v4:
- Clarify non-mandatory vled-supply commit message (Krzysztof Kozlowski)
- Simplify driver probe return paths (David Lechner)
- Rephrase fsleep() usage to use unit macros (David Lechner)
- Use regmap_reinit_cache() instead of regcache_mark_dirty() (David Lechner)
- Use regmap_assign_bits() instead on branch on regmap_{set,clear}_bits()
  (David Lechner)
- Drop redundant explicit cast to u16 (David Lechner)
- Replace (1 << 16) with macrofied BIT(16) (David Lechner)
- Add max_register to regmap config (David Lechner)
- Add upper byte register for proximity distance volatile registers (Sashiko)
- Return 0 instead of IIO_VAL_INT in iio config write calls (Sashiko)
- Add REGCACHE_FLAT to regmap (Sashiko)
- Link to v3: https://patch.msgid.link/20260731-gp2ap070s-v3-0-d1f5cecf9fe7@disroot.org

Changes in v3:
- Revoke stale patches sent erroneously, v2 changelog applies
- Link to v2: https://patch.msgid.link/20260731-gp2ap070s-v2-0-1bdfee07d5ea@disroot.org

Changes in v2:
- Reshuffle and add missing header inclusions (Joshua Crofts)
- Add missing regulators in driver and dt-schema
  (Joshua Crofts, Jonathan Cameron)
- Rename and rearrange register addresses, masks and values (Jonathan Cameron)
- Use regmap_get_device() for carrying dev pointer (Jonathan Cameron)
- Use FIELD_GET() instead of !! (Jonathan Cameron)
- Drop unused i2c_set_clientdata() (Jonathan Cameron)
- Use fsleep() instead of usleep_range() (Jonathan Cameron)
- Check if proximity-near-level is available before reading its value
  (Jonathan Cameron)
- Drop redundant dev_err_probe() from devm_request_threaded_irq()
  (Joshua Crofts)
- Use mutex guards for guarding concurrent read/write calls (Sashiko)
- Add reset chip action on removal (Sashiko)
- Ensure input value in iio_write_event_value() is 16-bit (Sashiko)
- Use regmap_bulk_*() instead of regmap_raw_*() (Jonathan Cameron)
- Hint volatile registers for regmap (Jonathan Cameron)
- Link to v1: https://patch.msgid.link/20260723-gp2ap070s-v1-0-b8ca3a4c10dd@disroot.org

---
Kaustabh Chakraborty (3):
      dt-bindings: iio: proximity: add Sharp GP2AP070S proximity sensor
      iio: proximity: add driver for Sharp GP2AP070S proximity sensor
      arm64: dts: exynos7870-j6lte: add Sharp GP2AP070S proximity sensor

 .../bindings/iio/proximity/sharp,gp2ap070s.yaml    |  60 +++
 arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts    |  55 ++-
 drivers/iio/proximity/Kconfig                      |  11 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/gp2ap070s.c                  | 491 +++++++++++++++++++++
 5 files changed, 616 insertions(+), 2 deletions(-)
---
base-commit: 290aaf24a551d5a0dce037e3fab30820f9113a10
change-id: 20260723-gp2ap070s-f7e0120970a5

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

