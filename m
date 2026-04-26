Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F6231A3B;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192699; cv=none; b=EHqMXlE6i/0+qI7hNNG9izON++OjLLQfyhAZCaY5An4eFgY4sYUIfJMWlwXwHFPPZf6kuM1ACa+zmHe4vBX6AwrDrg9mZCat8XKxcWN8GXGjh7HIVCK+j9kBmuVJAQVCrMd5u/2+aTVaoOE+J9+xSSxbYHsRGBgWjCMdSGfyJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192699; c=relaxed/simple;
	bh=LQUP9898wr+TDLdGQyNyptl+LdbtzAP0k0IbiNxlfeg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qyrxVg1mu/x9gTpHJRa4O+Mr07W/lckfvJCPbhG03tVa+FtSv3bkw+dvW8iqeLWYqDjLK2snlbd2p+g3G5VdHPE5Hujg7QKyGbDfUQJWr/uYL9lzZ5Olk/VmsGR8AwTzjRAhEZBdO7SKa7xSGpk6JDMkIGvtxVaJ63GHihnvVb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5y5ju+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5y5ju+f"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AABFC2BCAF;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777192699;
	bh=LQUP9898wr+TDLdGQyNyptl+LdbtzAP0k0IbiNxlfeg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=b5y5ju+f0KZ4PVz02rMIw3hyG5SYnMkywOVp7PCNYV86BJwdh9qyCKyzswKPJvJoG
	 e5hqDGREgwvMbtpPoVMEr5fOZWLJK+AaE5T3ZzWKYSEsIfaw1baf1qCuO86llaYZ8Y
	 9m9OBResnJ/J3SHtdQ4QVtoLgxTiOJUayUikqcukTEs789zpO5dW8v78y9S0tU6o/k
	 IsNAmgTOafrv4R+MRvcovQAKOf+0jVy3jc+TEN6neQy0zIfaVOHn30VWC/D7mKkdvu
	 SxoD8X4rVRNvGQL/HXUY9pZVzFFyAL/UQZsvv1dmlGGs72wSLMaO+LlmFe8U2UlTuO
	 qKelqWWyTZH5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE63FF885D;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH 00/10] Fixes and cleanups for the AD5686 IIO driver
Date: Sun, 26 Apr 2026 09:38:01 +0100
Message-Id: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOnO7WkC/x3LQQqAIBBA0avErBPUapCuEi00p5qNhQMRiHdPW
 j4+v4BQZhKYuwKZHha+UoPpO9hOnw5SHJvBaot6tKh8nNCh2vklUTiQR+eMCTFAW+5Mf2jHstb
 6AfPlyQpeAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777192698; l=1759;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=LQUP9898wr+TDLdGQyNyptl+LdbtzAP0k0IbiNxlfeg=;
 b=A8Tqf5wBfZyecpVBPN9Z4EaFRPXgqNaplIVPb/7TeXSTPEGSl0uwIHBQfgeuybQGKqGkPpJK8
 2cYys8EYP2GBDYwidTHcEHZSxVSnZ76pd8N5sV6tChV/LDRbKTIjcGe
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This is the first series of three on updating the AD5686 driver.

A bigger patch series was sent before ("Extend device support for AD5686 driver"),
but this is not exactly a v2:

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
Rodrigo Alencar (10):
      iio: dac: ad5686: refactor include headers
      iio: dac: ad5686: remove redundant register definition
      iio: dac: ad5686: drop enum id
      iio: dac: ad5686: add of_match table to the spi driver
      iio: dac: ad5686: fix ref bit initialization for single-channel parts
      iio: dac: ad5686: acquire lock when doing powerdown control
      iio: dac: ad5686: fix powerdown control on dual-channel devices
      iio: dac: ad5686: fix input raw value check
      iio: dac: ad5686: cleanup doc header of local structs
      iio: dac: ad5686: create bus ops struct

 drivers/iio/dac/ad5686-spi.c |  73 ++++--
 drivers/iio/dac/ad5686.c     | 544 +++++++++++++++++++++----------------------
 drivers/iio/dac/ad5686.h     | 116 ++++-----
 drivers/iio/dac/ad5696-i2c.c |  80 ++++---
 4 files changed, 418 insertions(+), 395 deletions(-)
---
base-commit: d1b86ecd0b377b36aa6581d2bcf73ba43a9e3c8d
change-id: 20260426-ad5686-fixes-63ea68811bdb

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


