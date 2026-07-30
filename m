Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4A436403B;
	Thu, 30 Jul 2026 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439924; cv=none; b=uWcdfK1vxm/wfqZSKpOUP9JQAaVgyKH3WPZIdrKC69NzcMUUnNrxKEWBgUB/QYK96kJTYU2teZCQovsMrpHLtbSMSRbr8PR6REO2nhsk5bm74+9p2++J7cU6/dn3sHJDqgNONl320s3x8vhIchpBO3NwRUn6GF/avSzAr74UQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439924; c=relaxed/simple;
	bh=q48LnUCYIDtXYky9veBTN8jko7ggpP3ulnNezNQmK9s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qZYd8G9xwPIQ8s+i/nadCGUOhH31HQpZUJKU0fC6pUBSNfg5UV7fHeHBWF3uybKS/W+GDJ3Zgshsrk8DM+qsyrvSAhY8WNTKpYe3FszFYYc61jKw/bgJzyhLPaO6lTJhEsNXfkNhtOPVms6ubnzC2FUI0wpfpuDY8/QkhyUVP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=LqMeG1Fe; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="LqMeG1Fe"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4DCE441B83;
	Thu, 30 Jul 2026 21:31:53 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nefCeLec1P_e; Thu, 30 Jul 2026 21:31:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785439912; bh=q48LnUCYIDtXYky9veBTN8jko7ggpP3ulnNezNQmK9s=;
	h=From:Subject:Date:To:Cc;
	b=LqMeG1FebUA2bPhk+pGOLz/6zsppvQ8YbBQC7auxdHVl3dbnKDkUlKJLWnYRyIMDI
	 8kuBEnKyfe44WJ8s5zU/n4zAaFGsEL5rVnN+w70Xec+fMh4Rr+MfTtJ+gQmu0992Pc
	 O+W/vyaOYi3Qo7F/Fzfz8YoqOcNrTtoUB1rV4zD8TsFp0zsa4dfTwS51cZ1X+bBvLt
	 JIXWfxFWhz7C9fBpQkwuDuIW7IZzNjImtuQN+bwR7Y+heks131+4iKW/up13bPo+Fb
	 Zeik5H5irzJz1LHGH0MVPvnE4yxFEHmucsc2h//kj35DUHwYxjJNALHKXhgB4nTnLx
	 iSESB6oDi+ldw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 0/3] Add Sharp GP2AP070S Proximity Driver and enable it
 in Galaxy J6 (j6lte)
Date: Fri, 31 Jul 2026 01:01:28 +0530
Message-Id: <20260731-gp2ap070s-v2-0-1bdfee07d5ea@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBAAv0L2bM22qFVO/sNwKO0C64GSLhIN6
 d8FvHqcZDKzgFBiEqiKBRLNLByHFcyhAN+7oSPFYWUwaC5oTam60bgRLYpqLaE2eLPozrD6Y6K
 W33vrUf9YXs2T/LQFNqNnmWL67LNZb96/7qwVqubqXelOXmMI98CSYpyOMXVQ55y/BUm1fbYAA
 AA=
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

 .../bindings/iio/proximity/sharp,gp2ap070s.yaml    |  59 +++
 arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts    |  55 ++-
 drivers/iio/proximity/Kconfig                      |  11 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/gp2ap070s.c                  | 502 +++++++++++++++++++++
 5 files changed, 626 insertions(+), 2 deletions(-)
---
base-commit: 290aaf24a551d5a0dce037e3fab30820f9113a10
change-id: 20260723-gp2ap070s-f7e0120970a5

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

