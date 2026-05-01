Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4537FF65;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626921; cv=none; b=HDRLV4/i/R91MMBRetzIAKiDJIue0zIvPlU04xzu11HONCMru7ftjp4rC72H9gzwi0bBMvP+cN78/FVBf0111TPVksKfGizjv4QUiUbbAmie+f549FVHh623ix8kJxoOsuTaacqI0iBLvMlfMMqJm4esobc4jkxokZkiEnnlDW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626921; c=relaxed/simple;
	bh=cmSeLtpdK8sBLV8JfrstZZeDMUoyRzYR7/Dd7zdGNMc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oICVaFOayEn505Qa8Jfee2nofVz2vumeVyVfAytQ7Cr979OH1OIN97GJxZ4rL6pP1Lipe21dNXykxx4tEuuBMVzEjE874Ug9rZfxNblWboTkku7xjNHzEc+/A8X8TarZjwF6u4SlXTQoDra2VJmPoS2VLgk5asUacKDKSnPV4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOdxI2iq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOdxI2iq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86BA6C2BCB4;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777626921;
	bh=cmSeLtpdK8sBLV8JfrstZZeDMUoyRzYR7/Dd7zdGNMc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hOdxI2iqhG7y1ppU+PQH5K4IonlHccGgSt24XyHdtUIwJr0M4VHroY+Aa9VrtUsR1
	 mflhF/X341Pk+XkdPYenopLYZiwluJof6ImvqUdfgEVsXhOAW2Kl0Mg39cQ5Xpip/Y
	 HBxGkmENGMPMBe2L4uBI8l3m2WAD9jSiKKN4NSMwIxumJF3AjFVvVry1fa+txwCuMw
	 22MDrj7p/6raZxe1U23zs3qH2UMHNLz6lG1YI7pykukWJ11X8c1hkQYS7BNO2QdhLN
	 DRLhpwRV9l2WIEshIYWqnLfj6YCQUf8rdFnugFaELxkCg6zex1hoAEJzuTa96cGp26
	 oiVUjXNb8ZJ/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FF2CD13DF;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v5 00/12] Fixes and cleanups for the AD5686 IIO driver
Date: Fri, 01 May 2026 10:14:53 +0100
Message-Id: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA1v9GkC/3XMwW6DMAzG8Vepcl4mHILj7LT3qHpIgmkjbVCRC
 rWqePe6nBhox8/W7/9UhcfMRX0dnmrkKZc89DKaj4NKl9CfWedWtjKVwcoa1KFtkFB3+c5FY80
 BiQBiG5WQ68jLQ8TxJPuSy20YH0t9gvf1n9AEutIueYvBOectf4c+/AznzzT8qndpMmvtNtqIB
 iKuGvC+Rtrpeq1po2vRPnWdiy26AM1O27X2G21Fx0gdJOHE8EfP8/wCEcDeZmMBAAA=
X-Change-ID: 20260426-ad5686-fixes-63ea68811bdb
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777626920; l=2541;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=cmSeLtpdK8sBLV8JfrstZZeDMUoyRzYR7/Dd7zdGNMc=;
 b=q+4qqila/0f4fr2RZszZl6nC3mlZuFBZuKTSKgk3Tg99DBiaaj117drxNN1T4z5LUe/yLcFOF
 iRtjXhCks+WD8oWLiVGmU+IAvMcFdIqYCX7hDWDChTLZdZ55my2CRmE
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This is the first series of three on updating the AD5686 driver.

A bigger patch series was sent before ("Extend device support for AD5686 driver"):

https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com

This one adds a number of cleanups and fixes, like:
- Refactor include headers (IWYU);
- Remove redundant register definition;
- Drop enum chip id in favor of per-device chip_info structs;
- Fix internal voltage reference control for single-channel devices;
- Acquire lock when doing power down control;
- Fix powerdown control for dual-channel devices;

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v5:
- Drop I2C read operation changes.
- Create helpers for reading and writing powerdown mask bits
- Link to v4: https://lore.kernel.org/r/20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com

Changes in v4:
- Address issues spotted by sashiko.
- Link to v3: https://lore.kernel.org/r/20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com

Changes in v3:
- Misc changes like parenthesis removal and line breaks
- Link to v2: https://lore.kernel.org/r/20260427-ad5686-fixes-v2-0-188e05199368@analog.com

Changes in v2:
- Bring fixes first and cleanups later
- Link to v1: https://lore.kernel.org/r/20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com

---
Rodrigo Alencar (12):
      iio: dac: ad5686: fix ref bit initialization for single-channel parts
      iio: dac: ad5686: fix input raw value check
      iio: dac: ad5686: acquire lock when doing powerdown control
      iio: dac: ad5686: fix powerdown control on dual-channel devices
      iio: dac: ad5686: refactor include headers
      iio: dac: ad5686: remove redundant register definition
      iio: dac: ad5686: drop enum id
      iio: dac: ad5686: add of_match table to the spi driver
      iio: dac: ad5686: add helpers to handle powerdown masks
      iio: dac: ad5686: add control_sync() for single-channel devices
      iio: dac: ad5686: cleanup doc header of local structs
      iio: dac: ad5686: create bus ops struct

 drivers/iio/dac/ad5686-spi.c |  73 ++++--
 drivers/iio/dac/ad5686.c     | 539 ++++++++++++++++++++++---------------------
 drivers/iio/dac/ad5686.h     | 124 +++++-----
 drivers/iio/dac/ad5696-i2c.c |  80 ++++---
 4 files changed, 432 insertions(+), 384 deletions(-)
---
base-commit: 39b80c5c9830d12d2d6531059001301c4265322a
change-id: 20260426-ad5686-fixes-63ea68811bdb

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


