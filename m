Received: from mail.kernel-space.org (v2202511311555398556.powersrv.de [46.38.245.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698B238C1A;
	Mon,  4 May 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.245.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915025; cv=none; b=e9yJCNgJkCCO1TwSXgLnrIstNpZkCQxC9yztHrRiurBPbMEtXdKEl+mrSXCA1bQg5rQK8LEcCf+xyE0usngAcWS53b9ooKUOtPZ7d9tKlnXV8LCf4i8LHBdv9rbTfjhTfc7ULKOUwkq4WImqxHjj6PwAl/bDN1d2GS4kQFkLTFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915025; c=relaxed/simple;
	bh=C39A5GzHPy/IadAwT1z67GCMqgdM+YROTPNzlHxZdRc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fdXNyZ88XB3thfPr6jBTjXUIttRfbFh/VjcFlUPMj4zNdFKJYhmH0Ti3Lma8qAPPpjS2SEQbguxXAIUGmjYOweGMY0wSHR/HKC3GBHdqAVrHHxd8TT0wG+aVZ/NofZIh+eOwgIjgccD+0gzLva2TH+U6VWO0hm5Qologntm5Ltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=JbGZhkTy; arc=none smtp.client-ip=46.38.245.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="JbGZhkTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1777915001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PQ378d9o7H5N1+8GUuYPcKWrb4gn5Q8tcRcYZqt311w=;
	b=JbGZhkTyI5QdiCnqPvVVTRsIwbEU2Rv4g183GN2CbnSjqkYob2OY+DS9Ra05iYKpCo5VMg
	33X2+1xpCU+hFvr8GEQZA8rVhcZpmqTLdQT1KmKTVEpW5SYbqYCjY12odieJHz1mSJWfj6
	wlMGAtOtVQdlt0HnzsfgSq8b6GF2ZCM=
Received: from [192.168.0.2] (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
	by oreshnik (OpenSMTPD) with ESMTPSA id 1d6530be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 May 2026 17:16:41 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 00/10] add mcf54415 DAC driver
Date: Mon, 04 May 2026 19:16:38 +0200
Message-Id: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNyQ6CMBgE4FchPVvzdwHBk+9hPJQuUpUlLVYJ4
 d1t8WCi8TjJzDcz8tpZ7dE+m5HTwXrbdzGQTYZkI7qzxlbFjCjQAjgD/LAD9mMr3JViJSTeQQG
 GV0pV3KC4Gpw29rmKx9M7+3t90XJMTGo01o+9m9bLQFPvvx4oBqyZMGVRSg6CHGox3Wzt9Fb2L
 UoHgX2IHPgvwSIBOeWCGEkk+yaWZXkBsVi6XwYBAAA=
X-Change-ID: 20260430-wip-stmark2-dac-7060f49dd94f
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

This patchset adds a minimalistic DAC driver for the NXP mcf54415/6/7/8
builtin DACs.

Currently the driver enables the raw write only. Feature as dma, sync, or
format are not supoprted for this version.

Additional options suppoerted by the DAC module will be added to the driver
later on, as needed.

The same patchset prepares the m68k/coldfire architecture to support
the driver.

---
Angelo Dureghello (10):
      m68k: mcf5441x: fix clocks numbering
      m68k: mcf5441x: add clock for DAC channel 1
      m68k: mcf5441x: setup DAC clock name as per driver name
      m68k: defconfig: update stmark2 defconfig
      m68k: add DAC modules base addresses
      m68k: mcf5441x: add CCM registers
      m68k: mcf5441x: add CCR MISCCR2 bitfields
      m68k: stmark2: add mcf5441x DAC platform devices
      m68k: stmark2: enable DACs outputs
      iio: dac: add mcf54415 DAC

 arch/m68k/coldfire/m5441x.c         |  21 ++--
 arch/m68k/coldfire/stmark2.c        |  42 ++++++++
 arch/m68k/configs/stmark2_defconfig |   2 +
 arch/m68k/include/asm/m5441xsim.h   |  40 ++++++++
 drivers/iio/dac/Kconfig             |  10 ++
 drivers/iio/dac/Makefile            |   1 +
 drivers/iio/dac/mcf54415_dac.c      | 200 ++++++++++++++++++++++++++++++++++++
 7 files changed, 307 insertions(+), 9 deletions(-)
---
base-commit: 8b4b975922f607411217c81942e82f1d206ebc61
change-id: 20260430-wip-stmark2-dac-7060f49dd94f

Best regards,
--  
Angelo Dureghello <adureghello@baylibre.com>

