Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE892463B80;
	Wed, 16 Sep 2026 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546194; cv=none; b=gMMMUyqeXtk3VvqFpjIWa8jE62g6p7XQA8SKojUy8DcohWL6/749jMB7rbwEjWFKUm2iLL7eXy1f9EKok0cFRswArTdcJ1st8YcCWFO2OZ3LWNH/dH56XlKpJOp7oOA9UHlGF5+RwBrA5C9A3LzaXg/9y+sOxjPp/2O2PuK0Vuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546194; c=relaxed/simple;
	bh=ZsRWQ2cy4/2MshimBga9KEvo5MqZ+GDpAPXPf+c/Lk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDTezpz6jikrD8gzOyLnr0dlnRY3cUrnJJPZHQSKoeHIdAdofMbtIiVJMw7ex3VlOIIyzwBJy6OfxUekjPYrtUt+miOT63Bzu9OD67ZhYSwmQIS27TsyoAoeKCxc79BOAZ+ezWM9RKeq0mkAOs7g2SNRg2DUDDGV8CKk4lG/tpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=iKRJVMCg; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="iKRJVMCg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789546169; x=1789805369;
	bh=hvvSu4jQNAlUbHyw4OnEn6UGVnkOGTmR1TTHMd7EAHk=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iKRJVMCgLTaG7NSEf8bOMJq2FzEkeQbV+JLSM/de/jY9dn9n3iyTnOpEpdT+QOtkW
	 l1CXEhyxARA8LSAyGZ7ka4ztDy1eu8wZZP/N0bO6NoQ4/PXQgzpaszcoLc1CMzDp38
	 e7UwPTOAlHEKcdMG/Ma28Zn6zaamqJ25c9G8tfbwu0TNfk0NF8zC56RNsOlP99BzUM
	 S/AHpxXP6NXpm4pvehnWcJFBDHGjA9b8/lDkgGMte5UFQVGOqfDRqiscpRaqQbWrqS
	 B0yH3e9PKfq+wOLRlcqprz3aXjRtfJRWMZf1nntghNvU/WsNzuHWnOn+KaPWVK18Ug
	 VHQUQbISOEyQA==
X-Pm-Submission-Id: 4hlBPM1gX7z1DDrw
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 16 Sep 2026 10:08:00 +0200
Subject: [PATCH v9 04/10] iio: accel: mma8452: Optimize struct mma8452_data
 member orders
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mma8452-open-drain-v9-4-0dd24fa2f3d7@geanix.com>
References: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
In-Reply-To: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789546157; l=1020;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ZsRWQ2cy4/2MshimBga9KEvo5MqZ+GDpAPXPf+c/Lk0=;
 b=h9A/jONCw59QohxPmYqJ1iFujwRSIKP+1OMzziKWOZ8Je3CTZmSvDC1hznNXITT+2Sw+6d0MQ
 07Selm0J5TeBYwN+meBXB0RVnmFBnWpRWp9LiynQ5TePd6zFNxsj8ZT
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Reorder struct mma8452_data members to avoid holes.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index a77c4b88b61d..8d70fe89110c 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -108,10 +108,7 @@ struct mma8452_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	struct iio_mount_matrix orientation;
-	u8 ctrl_reg1;
-	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
-	int sleep_val;
 	struct regulator_bulk_data regs[2];
 
 	/* Ensure correct alignment of time stamp when present */
@@ -119,6 +116,10 @@ struct mma8452_data {
 		__be16 channels[3];
 		aligned_s64 ts;
 	} buffer;
+
+	int sleep_val;
+	u8 ctrl_reg1;
+	u8 data_cfg;
 };
 
  /**

-- 
2.55.0

