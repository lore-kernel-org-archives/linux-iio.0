Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C740DFD6;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289411; cv=none; b=bBprOi6a6WCd9u6i3Dzc7QyuVqEinj4z0mYlfiHUdZwg/z7oMjiLDj/xl2qjPdSgCkbQYD4ra+M8/sjDE8hdbEW2aIIUufLvzyjRDI3GC34ZARY2sxjyNetI9zCM+cdJ9ZuEYH3j/UnL1bKwADmSGWOgJJmZZz69TSxUaqeeEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289411; c=relaxed/simple;
	bh=FU47icc8xWRwMiP7j8yRR3TjrZtfwFeEVK2tkPTLzC0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OyRpiXM5fcgcEP+kXI4wxv7w23DxAuvRxcZUM6e3CMJcInVtn87S/nUMFpCMRmTZF2srquBB7hS/Z7278Q5hYhN2Wegn+XZDdHVIFNMc3u7YUaskXL84P0e4inVm0nyiAfsnx8/601rgb6LHTItSnN/a4nuQtHwoZlaAgg0B8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1LQvd2a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1LQvd2a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF7F1C2BCB8;
	Mon, 27 Apr 2026 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777289411;
	bh=FU47icc8xWRwMiP7j8yRR3TjrZtfwFeEVK2tkPTLzC0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=W1LQvd2aVGghg6jIty7k7WZKt7+m5zV5zwEBxuJ3SIY5ZoAKxZnaeQAl199au7Ng1
	 DJPd9QjX5KRSXbMtmAUAqEDbwn5ULirczOoP/E+vzdIuKCnWZr6jVIuwmpVEnwuUmQ
	 sIf2IZURps2XWk2tlVdJkvrCEfQGPTny5/NhihGGfw6L3mjacfvW0RkMae2MquKxsn
	 AQde9jimy9rhRFW9ykXNX7aoMH2ACapcvvsvkJklpj00qQVEM31XiG6R0vAxPx+645
	 Wd6jdt06JFe/gq20N/nfmhhY6JLPRxWmqLVqRziD5hKf9o7PIogoEB6YVWoghkxbM0
	 Id18tC2fwB6qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2EFFF8860;
	Mon, 27 Apr 2026 11:30:10 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v2 00/11] Fixes and cleanups for the AD5686 IIO driver
Date: Mon, 27 Apr 2026 12:30:07 +0100
Message-Id: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL9I72kC/3WMwQ7CIBAFf6XZsxhAXKgn/8P0QGFtSbQ0YIim4
 d/F3j3Oe5nZIFMKlOHSbZCohBzi0kAeOnCzXSZiwTcGySVyJZFZf0aD7B7elBmeyKIxQox+hKa
 sifajGbeh8RzyK6bPXi/it/4JFcE4065XaLXWvaKrXewjTkcXnzDUWr/ceN4LqQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777289409; l=1986;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=FU47icc8xWRwMiP7j8yRR3TjrZtfwFeEVK2tkPTLzC0=;
 b=APTRVDGVmPNtfHS813U3LydidIykxD8VrF19rPHhrwUwCg/DRoB7mO7FsGSVRtqfJZmLMHYOA
 7gs+kZfWgb6D5r+1oVROqyazxezhgC3r7FpQGJi2Q51qsDE+SIFp/3L
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
Changes in v2:
- Bring fixes first and cleanups later
- Link to v1: https://lore.kernel.org/r/20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com

---
Rodrigo Alencar (11):
      iio: dac: ad5686: fix ref bit initialization for single-channel parts
      iio: dac: ad5686: fix input raw value check
      iio: dac: ad5686: acquire lock when doing powerdown control
      iio: dac: ad5686: fix powerdown control on dual-channel devices
      iio: dac: ad5686: refactor include headers
      iio: dac: ad5686: remove redundant register definition
      iio: dac: ad5686: drop enum id
      iio: dac: ad5686: add of_match table to the spi driver
      iio: dac: ad5686: add control_sync() for single-channel devices
      iio: dac: ad5686: cleanup doc header of local structs
      iio: dac: ad5686: create bus ops struct

 drivers/iio/dac/ad5686-spi.c |  73 ++++--
 drivers/iio/dac/ad5686.c     | 521 +++++++++++++++++++++----------------------
 drivers/iio/dac/ad5686.h     | 116 +++++-----
 drivers/iio/dac/ad5696-i2c.c |  80 ++++---
 4 files changed, 409 insertions(+), 381 deletions(-)
---
base-commit: d86db1905add39f905cf9f04252804b359914ed6
change-id: 20260426-ad5686-fixes-63ea68811bdb

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


