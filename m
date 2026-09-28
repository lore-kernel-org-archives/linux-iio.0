Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1047729D;
	Mon, 28 Sep 2026 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584006; cv=none; b=LeQ2ZYN09qaYsTq/T1trrgcmHv/ZWSzSfGflgmNkPeGVq8I+JTiFidDh3melhUF/EWaSocG6/sBWZ4pRY8iZTaZ5XH0nsvuY01ak0KcWP3xHF3K3Xzz1dXMYROntF5mM5bUPWTqYkiQbKVSCX8KNNi2TlbKlp0NxO8On7NsmJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584006; c=relaxed/simple;
	bh=OKQ535GKjfWUhMwPz+MoNR0GVl2P4OFczFeAea+Xbtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+B8iGoSmq9gwp+l5GO8M+JXImaH5tgREtGKw1fdNvm7dhAMNor6c304JtiAf5Y8NElIUbjZeBZpEppTdAAlpPsg+5s0DoQDHP7gjRLWvH/bz3B3FVRCUSbuW3nAnw8JxbmM+SKyKh1F1q9Q/BJnCRPeTjg7W6/Fi409b6bOUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=JoLgnJcp; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="JoLgnJcp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1790583999; x=1790843199;
	bh=aDEVcEomKHwwxee1ZSmYMgQ8MLwj8ii2wd/is7mlRPY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JoLgnJcpZon6tm514acOQGT8uuPtSTIBMqy6ODQw50Ti1s5LErdr8KVtzgXy5ZOEg
	 BzM2dDETvQKEBYJP1HhbKBRn5UZiGD/aSKqcuEkiJYU/XR+gnv+ZHeBT4J8at1xEGP
	 uZWOkkeDeky9oCMUzaxm9wvI6vshhnzs64m2RD5eSgNu+eJQPCzh0kcUsfru+w79V9
	 WjWdiHTP5cdSPY2xOO7hygUatDF1UhzIQ1QLecxJlxcKmUawq4YKOSt/VS/uI7LLJz
	 sb8YJTyReEl9ti3hipt60N/cWZeAE3pXN9xXnjosEnogZsZBor5sXm+LkUhcXqEbWa
	 4Ekws9GdTWVag==
X-Pm-Submission-Id: 4htZCg0GPKz1DF4X
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 28 Sep 2026 10:26:23 +0200
Subject: [PATCH v10 07/10] iio: accel: mma8452: Add comment block for
 struct mma8452_data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mma8452-open-drain-v10-7-b906fb408386@geanix.com>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
In-Reply-To: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
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
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790583982; l=1365;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=OKQ535GKjfWUhMwPz+MoNR0GVl2P4OFczFeAea+Xbtk=;
 b=XM5ggP66R5GeFzefbqLif6Mj5snSEk3MY0fcMgmaw/8S1RkuQ02aqUBGwALzRk3dyJV/iInir
 0SQjoBiVZIJASzc/mR6HjB+0fDj+eFDZtANgcJFQ5d5J1HoAivdFn2e
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The struct mma8452_data is central for this driver, and it makes sense to
have a description of the fields in it to make it easier to work with the
driver.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index b70bc8638128..0c6ca6640f72 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -104,6 +104,21 @@
 
 #define MMA8452_AUTO_SUSPEND_DELAY_MS		2000
 
+/**
+ * struct mma8452_data - IIO device private data structure
+ * @client:			the I2C client object
+ * @lock:			mutex for synchronization of register
+ *				read-modify-write sequences and holding chip in
+ *				STANDBY mode while writing to registers
+ * @orientation:		mounting matrix, flipped axis etc.
+ * @chip_info:			chip specific data
+ * @regs:			reference to voltage regulators
+ * @buffer:			triggered buffer
+ * @sleep_val:			time in ms to sleep while waiting for drdy
+ * @ctrl_reg1:			CTRL_REG1 register shadow value
+ * @data_cfg:			DATA_CFG register shadow value
+ * @open_drain:			true for irq pin in open-drain mode
+ */
 struct mma8452_data {
 	struct i2c_client *client;
 	struct mutex lock;

-- 
2.55.0

