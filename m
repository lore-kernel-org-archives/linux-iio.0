Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B0372B26;
	Thu, 30 Jul 2026 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442036; cv=none; b=Mmj2bYia+gdlHB050C66yePCbxeDRp6MIeX9PIkpIZxGnmY/HoAeLfGY+Iw9/WNwmYlydJhxbPz4dL8c25NxqfC2bkrd8l0Nmk/HENabJFMq3OVLx3/cUQmYb4leABR4HArHgk87RFhVxzm2ynqKLBlR9keuXS4JWHNHlLpWtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442036; c=relaxed/simple;
	bh=pbP1Mw0hqJriVsJNj78DV1NDIDK6RHyzUByOUzW4gcQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z6l+NkMHMMRtincPbbL7gWijRrQRAwHASLdDV7OGwsBZIvO06RxTHVubGqy8NE+I3QCHly1XJsggvj08/EYk+YmGz5hsgxx41BkkvtAIAYR30qMEojY0Fnpsl2uIF1sU8k/7E+IYV/LDqOWtds9+L0UyxXN0l/2n70h2/kjoQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JRNNL+Xz; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JRNNL+Xz"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7662F847ED;
	Thu, 30 Jul 2026 22:07:11 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGyFMOuAgvrF; Thu, 30 Jul 2026 22:07:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785442030; bh=pbP1Mw0hqJriVsJNj78DV1NDIDK6RHyzUByOUzW4gcQ=;
	h=From:Subject:Date:To:Cc;
	b=JRNNL+Xzb5wzfm1TLJH7CzauBNoKJ9NuilMq8fqqBxRGgjnSUv7C/FIUHJx1+sBTF
	 7c6lrXTv8QK0r9ppZk0whl5UtDsbPNj3H6jOZUKTqD3hR8/5J7Rdsi/hokRVVIEPtt
	 lJ7FJg+hj+RKrg2cvqEVcPQeuwgRmQ+zLuwHQSZuftZDpSWSJu44PFyR7/qQ2Sdvzx
	 KNUacVYc2sMN1gx7TQjPhPgfQXqjLzj1QyN51p/j8Rh66U8+upxVAdAqcZwpe/yR2O
	 E9o1GwrRvtbHuTv8MQQEGkNvdOKDsLKBxZFoEDRxw93/tZQ1111t5hc0BVciiwWQ9H
	 A5dIZf/A+2jFg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v3 0/3] Add Sharp GP2AP070S Proximity Driver and enable it
 in Galaxy J6 (j6lte)
Date: Fri, 31 Jul 2026 01:36:59 +0530
Message-Id: <20260731-gp2ap070s-v3-0-d1f5cecf9fe7@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ7CIBAFf6XZs5gFrKgn/8N4oLBt8VAaqETT9
 N+FeqmJx0nezJshUnAU4VLNECi56PyQQe4qML0eOmLOZgaB4ohKSNaNQo+oMLJWEXKBZ4W6hrw
 fA7XutbZu9y/HZ/MgM5VAWfQuTj6817PEy+5fN3GGrDkZLfXBcLT2al0M3k97Hzoo5SQ2ruRbV
 2SXN7YlQmVr0r/usiwfH+Pf+PIAAAA=
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
 drivers/iio/proximity/gp2ap070s.c                  | 505 +++++++++++++++++++++
 5 files changed, 630 insertions(+), 2 deletions(-)
---
base-commit: 290aaf24a551d5a0dce037e3fab30820f9113a10
change-id: 20260723-gp2ap070s-f7e0120970a5

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

