Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A0238E5DF;
	Sun, 24 May 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779617842; cv=none; b=TZfQv+U+b/+kv6hcWL9S6fJmUhhXGRhPlrnXvi+jK+NFMyAlKqh4J6LUR2HRwTvlZpIVzPz3/MTxcNJVjUFe64JBVekv4lT5O9kKEooo7fZzxNc7vsGqdNNpb7gIgWmQqGbrVYOeMjHeNkCxy1+77Pu/smmO4lmE1L/e7fYaQFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779617842; c=relaxed/simple;
	bh=iLaDup/VAr36l8p281EDtTj0H41cn1wISQs1uP+345Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BQwvyK2+zOFUXp9ntQXixG1gVNwokqyODgXiC/IniLR6s+O2ia5ioGlG2Aw7yJN9DjLHttt0vC2i4msYBJGju/s4faNkqooNUfZ5OJCiLIB+s9kuhSHTwgV2Y4ahCZD33ZXaJOIXTBqK4zjSKgpH9GTS0ImrSGBUIi3jBAhOGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVAZpJtP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVAZpJtP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0448C2BCB4;
	Sun, 24 May 2026 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779617842;
	bh=iLaDup/VAr36l8p281EDtTj0H41cn1wISQs1uP+345Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RVAZpJtPLGpJUqAofO1T8p8E7aqV8u+liM6/se7GCZ8DqFjkl3bT5yr3wq/XEgqWs
	 DBmRgreBHvskBstd1Q+VZbZI5pOWOIjTizKQofMCoCYRkqwu/e8CVDfziBUZ4AYUxS
	 00JXvAPJi8mlQGPbS1+eqYpeIlW9KelJAbv28gaW9+zYDnnymegamPom8n4w78hrHA
	 FRhTnJZcqH9AtMBrvnRyZi2dboYQiAwGYco24mjcPTibgQ3wo5fUSVdZZfUK9tPZ1/
	 ugTKOueCKZX5fTKA1VkQ7RZB2+DXARM77y+pHA85W5g9ikboIaCDsiZ7E58f02KX8M
	 Q1k0fhpstSRMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71EBCD5BC6;
	Sun, 24 May 2026 10:17:21 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v7 0/8] Fixes and cleanups for the AD5686 IIO driver
Date: Sun, 24 May 2026 11:17:00 +0100
Message-Id: <20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzQEmoC/3XQTU7EMAwF4KuMsiYoThPHYcU9EIv8uDORoEUtq
 kCj3h3PbCitWD5b35Plq5p5ajyrp9NVTby0uY2DhPBwUuWShjPrViUraywaZ1Gn6pFQ9+2LZ40
 dJyQCyDUrIR8T3xciXl4lX9r8OU7f9/YFbtN/ihbQRocSHaYQQnT8nIb0Np4fy/iubk2L3eqw0
 1Y0ELHxEGOHdNDdVtNOd6Jj6fuQK4YE/qDdVseddqJzph6KcGI4aP+rvYGd9qJNtr3zjsjB8XL
 car/TKLrY6uV07mz++7V1XX8AMLaomt8BAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779617840; l=2669;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=iLaDup/VAr36l8p281EDtTj0H41cn1wISQs1uP+345Y=;
 b=pJkDXANbpV/nZm/XAprwdEdj9iuRo9KnSTg6gl4ASWxWVw62KWGqVmi+G5BiVTQAzTUqKhh87
 b5i8YuPrrKYCNLXFFIls7P9lsaCcBxdtsdipclUvkEa6hzxU3GRV1Ab
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
Changes in v7:
- Drop fixes (already accepted).
- Use named fields in device tables.
- Link to v6: https://lore.kernel.org/r/20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com

Changes in v6:
- Protect powerdown masks on read access too.
- Minor changes to power down handling and constants.
- Link to v5: https://lore.kernel.org/r/20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com

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
Rodrigo Alencar (8):
      iio: dac: ad5686: refactor include headers
      iio: dac: ad5686: remove redundant register definition
      iio: dac: ad5686: drop enum id
      iio: dac: ad5686: add of_match table to the spi driver
      iio: dac: ad5686: add helpers to handle powerdown masks
      iio: dac: ad5686: add control_sync() for single-channel devices
      iio: dac: ad5686: cleanup doc header of local structs
      iio: dac: ad5686: create bus ops struct

 drivers/iio/dac/ad5686-spi.c |  73 ++++--
 drivers/iio/dac/ad5686.c     | 528 +++++++++++++++++++++----------------------
 drivers/iio/dac/ad5686.h     | 133 +++++------
 drivers/iio/dac/ad5696-i2c.c |  80 ++++---
 4 files changed, 418 insertions(+), 396 deletions(-)
---
base-commit: bbc109ae655c8a5d4db117fea01947eb6bf51e71
change-id: 20260426-ad5686-fixes-63ea68811bdb

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


