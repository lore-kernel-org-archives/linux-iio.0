Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E2420E9D;
	Wed, 16 Sep 2026 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546194; cv=none; b=szoJfEtPSBgwUQY3gFW321N2pypcG0y2LW5KwaUsnPZ4hJnTI1FnO1DGCgzQSjZWFQ8Af+gg7eMqa6Xx8QEoJJy/vSZse3ShGAPfZdBvWtIRKVACkTXlUJgiH42tDMTwtGn9HxyCV4sxRM592vkmOHxqLdewOBUwuQDEA+uXuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546194; c=relaxed/simple;
	bh=afe1n+Wf/XPJVThN6jURieB4LpbuLHGELAAR7V1RVb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGNS+LKHvuHaY77DoQy4sA4WwHCf2qfadULodsXrewx1CUEHxu6pbhgUpP081YckxNLJmKyZfrDpe27n5jFYQP+1A9VFHEMB7/Y6KRUEV7ISopqlL43QJV9KziZsa8SuyFVq5ze4y1PZrTBECf4H6M02Kn2noMijspnhZwO3wmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=sMC4c4fg; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="sMC4c4fg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789546174; x=1789805374;
	bh=+lNbw586DMMVtwI3LXF73zybAcTYv38dit0+gXZryTE=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=sMC4c4fgUvl1bQ7Hri+yfImYMJVsuXNACwghzTonGYJ9hey1Olyy6FGQryDaCC3FA
	 VF1bESWchAEd6ONS7wYxcPt0SYL3M/IHQF9EPl4cbHJcTC/P/cw9FUrwhEQasA16ap
	 1nvYZZx5zVQSz0z5gAIplHQqVcYRF9i0njWUohcnmIKS+2FchMp48Z2sKqDuIEGp9c
	 OEgdIdn0bKOYOA/WFo+nbGuMDy4qeCLFTMh9+vDtrcmvx2DfJZCyHksknSMh1Y3ioJ
	 4r7EEoNJ1oX3dcKtTtvzISXcYUj+87PI6PQikHyfStSztXHwH8rj4I163qG1ZYR8AL
	 qHXpVm0/50VQg==
X-Pm-Submission-Id: 4hlBPT1JSBz1DDrw
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 16 Sep 2026 10:08:03 +0200
Subject: [PATCH v9 07/10] iio: accel: mma8452: Add comment block for struct
 mma8452_data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mma8452-open-drain-v9-7-0dd24fa2f3d7@geanix.com>
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
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789546157; l=1365;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=afe1n+Wf/XPJVThN6jURieB4LpbuLHGELAAR7V1RVb0=;
 b=ZCTkhNTdnAvjzqMdj+xvLEQyb5025RxvLGkWY5KHni7E4RxvW2dNhrMQMluxO3DGHCI6R2szt
 c5Uk3XYnGz0CFWdY7rodBM8Uf3FKpdb5YJ1B1wl4K6IFWWNgRpKf/1v
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
index b70bc8638128..223bef4f7baf 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -104,6 +104,21 @@
 
 #define MMA8452_AUTO_SUSPEND_DELAY_MS		2000
 
+/**
+ * struct mma8452_data - IIO device private data structure
+ * @client:			the I2C client object
+ * @lock:			mutex for synchronziation of register
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

