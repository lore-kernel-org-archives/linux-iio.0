Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3440132AABC;
	Tue, 28 Apr 2026 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395739; cv=none; b=KNcSDc5akyRY8YEPdN0yiqzqYFsqrFzrZB9h6ggXUIhRcK8C+fModQxMiEcGMz9ulFiRJqQXgQxQSSr8vil2UdCRsAIgGWq71gN5b7wGVLTVfyXOSIfUaBR+Tdj7vb4shCNmzNwAK+GNI7TmWOXrYimTxDBR20y9QQmyIVwBC7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395739; c=relaxed/simple;
	bh=iC+jLgcW0AvwC9ouWBVN04n46mujk9CATg128LaosD8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uFSz1m7LaNcyWDQBHtwaoRbp4BoNVEkiZz4odkzdwmX6FWrBvozAxYE5WE6jArR9E+3697USxIWBTCOWGgJ77uFf8qRQXm1og5ZKHtGDPM3BKg9oVhjbtN+5ov3xz1PSz9Hoa8HbGOJ5G7CjrhwQxuzB348paA3ZzRZh6m/oD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NljQi3Wl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NljQi3Wl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CABF4C2BCAF;
	Tue, 28 Apr 2026 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777395738;
	bh=iC+jLgcW0AvwC9ouWBVN04n46mujk9CATg128LaosD8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NljQi3WlTHb4BskLTopmsTINnhvLewg3sauYKjybynPPahym4yFVrJ7cbQrlAka02
	 fV/GzNVTJdJlAXLqubLWTsWafyfOiWeUJgpqOq3pUsKASVy8KzaNksNi3h9dJaTNwr
	 NJMcL/Abi4gd54AyA1GtzlYGIPvLAt9QsbICbaGQNm9LCjQ1JLuok8vZxJe1hcfqyJ
	 7XT6vJIEjYzO+uZsxYjCTN/G6tiv7+Q6YGFguRSw3y9olLQOEe2urXOtsVveIVhLsY
	 H2DvT5Gb7SW/wrG9oVrgHojC0rCIUee0K/M+Q8VsSZ/mCasdnrX/pFv1/VZ8V7mRaH
	 a6HpcAYJZyewg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B508AFF886F;
	Tue, 28 Apr 2026 17:02:18 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v3 00/11] Fixes and cleanups for the AD5686 IIO driver
Date: Tue, 28 Apr 2026 18:02:15 +0100
Message-Id: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABfo8GkC/3XMQQ7CIBCF4as0sxYDtB3AlfcwLigdWxItBgzRN
 L27tCs1cflm8v0zJIqeEhyqGSJln3yYyqh3FbjRTgMx35cNkkvkjURm+xY1sot/UmJYk0Wthej
 6Dgq5R9oeRZzOZY8+PUJ8bfUs1uufUBaMM+VMg1YpZRo62slew7B34QZrKctPrX60LFpoTbwVx
 tSov/SyLG/seRoa5wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777395737; l=2153;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=iC+jLgcW0AvwC9ouWBVN04n46mujk9CATg128LaosD8=;
 b=Q4YHwj/hcxVe3+uDdslT6mZNt0yEJGQ4KPn1ik6h7rUttpbaQsliICsZhigXWHWsOhPm/Cnf9
 HCdxyEmd2hVBFZR+d4bfv8recleE4Bvr3s/wXKGiHVZP/mu0Z9gH1jC
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
Changes in v3:
- Misc changes like parenthesis removal and line breaks
- Link to v2: https://lore.kernel.org/r/20260427-ad5686-fixes-v2-0-188e05199368@analog.com

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
 drivers/iio/dac/ad5686.h     | 120 +++++-----
 drivers/iio/dac/ad5696-i2c.c |  80 ++++---
 4 files changed, 412 insertions(+), 382 deletions(-)
---
base-commit: d86db1905add39f905cf9f04252804b359914ed6
change-id: 20260426-ad5686-fixes-63ea68811bdb

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


