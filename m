Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E15370D41;
	Thu, 23 Jul 2026 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827735; cv=none; b=psLdntnOPqPV6bV69285BAOF5c3SHPs7++h8onA/PIlhFcUH44m/hkseWD6rqOVPRiV/xzM4TvBa4RZhWJPAEGUyvdBfFu4NvirHgcghKwvgSgbg+9idDN/LGFZBzyNTpO3wGuZvGq6BQ0tUAti8UgcvUiBeqQyi8Mq+XNt+/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827735; c=relaxed/simple;
	bh=ZOm1CUFG2zTNpg9nFY6xska/JOIUFcW8kvB1OU0zRw0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Py4hS86ZATCOMRWgIDy462nwL5GTKs06Y16n+boihLxJbFhHJ4XiRhmBki1923SYZG8Su9W2H8zuTp2z748ZMqtthksPfvfSWjVQN/Yc0OVtrH0qk0j2M1SVTXaZ2cEK54yy465tkedKMXGFVVEpc3hplXNgHg35chR/b/rIdic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JLkA2Bz9; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JLkA2Bz9"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 634DB88254;
	Thu, 23 Jul 2026 19:28:49 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xBHW57MMBbBa; Thu, 23 Jul 2026 19:28:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1784827728; bh=ZOm1CUFG2zTNpg9nFY6xska/JOIUFcW8kvB1OU0zRw0=;
	h=From:Subject:Date:To:Cc;
	b=JLkA2Bz9sj5geTmL1XiLYYQ6p/JjRIChIcfSEjROsbZqj8Rv3eMLHGL6rZzliCSa/
	 /BV9Kk7sMnRCkwOtiQqQwp/IsLKifB/lJKO4YyirGNs/TlCWgnADLDw5E0wPsW+nm0
	 sCfkuzECIGBEOzo2KBe2emDyYWQFwuK1ZrdMH0IbbdOvzyS7tMlDe32R7WAfuEGFK1
	 GJa9pcKTh1uBU/UDb1uNDC1wi4IA/H7BueXXQckc6ax0pcuwF/UTaWdhw6VZvQYPR8
	 aLb2jtL/VeoUMbNEYSh3hojMtF6vCOFfIVbcI4mundIoSi/JvLCYZfqJJLJNDN/3wA
	 y1fh0dNK7F0Yw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/3] Add Sharp GP2AP070S Proximity Driver and enable it in
 Galaxy J6 (j6lte)
Date: Thu, 23 Jul 2026 22:58:32 +0530
Message-Id: <20260723-gp2ap070s-v1-0-b8ca3a4c10dd@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNj3fQCo8QCA3ODYt0081QDQyMDS3ODRFMloPqCotS0zAqwWdGxEH5
 xaVJWanIJyACl2loASkmqTW0AAAA=
X-Change-ID: 20260723-gp2ap070s-f7e0120970a5
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

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

