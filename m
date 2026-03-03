Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE6042E017;
	Tue,  3 Mar 2026 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544446; cv=none; b=YvY7pfIUNWlt+PgpqY3ile665YXlEWm4Ih8NrYZmU19VDWgk8Q15A8L0gkRBQpoXE/6OcvYyQAah3/F7s7815DPJEz2NQPx8UTyKfcS2x3PvH4ypbSIZ4PH0yVitHgf9yNlR5lkaT9hnU1CjYAE2sk25SwCguyvgK5AsjWjyTUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544446; c=relaxed/simple;
	bh=UUGqq6KuJ9zIG0X2o0ubuPGPMlCBeEdzgPCnCWv6v00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNu9P0xzPc3JuR4wC9h7AdN7YiSCWS05iEXnvYH/n6pbQxxKDbalj9rOhCq7Tq5W12tFUOBo5ShRsJmUX8MKVJw49aJrotzVkmlsTp36H2TuPqT2M1v2j26vHxUdc/+jh9clz1s583e/njVoaBF66MRncweF9HVJvW+AU2OKNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQyCQtV8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQyCQtV8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D466FC2BCB0;
	Tue,  3 Mar 2026 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772544445;
	bh=UUGqq6KuJ9zIG0X2o0ubuPGPMlCBeEdzgPCnCWv6v00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VQyCQtV8UMutcnevWwH4Mc9Ijoz4SsPoq+laa86NSpinJD1it9v5Y3RheZP6HvM3x
	 3W9CEdvIQM9aFmWKqf0P24UjezfgwIRoa+6oMLiHY/+skWnuTEju388cnTfDOytCTA
	 CbWvB8mPrIQT8z1pjGpsW9xdm9eFBwwdebtH8OWW1W86Svi0AJ83rcj70nLhsJPWt3
	 wZQhhyCIsm7NCYHECvyOYTx2b7w41/jzbVJ0U9Zr3Jlwpam1zKpdzyIjRC9xUGpcpc
	 wnQDrn/EW7HLZrEaZ1oDySkSeQsYidFG6an//tHuISn4MBj2i9MiCCjb7eCgyoakSr
	 LwUe5J5rUspPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA40BEC1446;
	Tue,  3 Mar 2026 13:27:25 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Mar 2026 13:27:12 +0000
Subject: [PATCH v8 07/10] iio: frequency: adf41513: handle LE
 synchronization feature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-adf41513-iio-driver-v8-7-8dd2417cc465@analog.com>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
In-Reply-To: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772544443; l=2998;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=La2NnbCEmWKuh8TItMnd816K8WFyfx5bTjA0xtRndnc=;
 b=t64EkkjlXr7ad+fhYHf+npon3wV0NG7srQARq1SSybHGSGcDbGPGcyohPRawCDZE6JHOA4Iz2
 hJPtsi3o8AtCL6AjreeqGlmvszPjO4OStRGnZvGNCkx7vYV6Yagxv6M
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

When LE sync is enabled, it is must be set after powering up and must be
disabled when powering down. It is recommended when using the PLL as
a frequency synthesizer, where reference signal will always be present
while the device is being configured.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/adf41513.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf41513.c
index 5a0682667d1f..caae9d53c3e2 100644
--- a/drivers/iio/frequency/adf41513.c
+++ b/drivers/iio/frequency/adf41513.c
@@ -222,6 +222,7 @@ struct adf41513_data {
 	bool phase_detector_polarity;
 
 	bool logic_lvl_1v8_en;
+	bool le_sync_en;
 };
 
 struct adf41513_pll_settings {
@@ -634,13 +635,27 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
 static int adf41513_suspend(struct adf41513_state *st)
 {
 	st->regs[ADF41513_REG6] |= FIELD_PREP(ADF41513_REG6_POWER_DOWN_MSK, 1);
+	st->regs[ADF41513_REG12] &= ~ADF41513_REG12_LE_SELECT_MSK;
 	return adf41513_sync_config(st, ADF41513_SYNC_DIFF);
 }
 
 static int adf41513_resume(struct adf41513_state *st)
 {
+	int ret;
+
 	st->regs[ADF41513_REG6] &= ~ADF41513_REG6_POWER_DOWN_MSK;
-	return adf41513_sync_config(st, ADF41513_SYNC_DIFF);
+	ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
+	if (ret)
+		return ret;
+
+	if (st->data.le_sync_en) {
+		st->regs[ADF41513_REG12] |= ADF41513_REG12_LE_SELECT_MSK;
+		ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
 }
 
 static ssize_t adf41513_read_uhz(struct iio_dev *indio_dev,
@@ -933,6 +948,8 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 				     "invalid lock detect count: %u\n", tmp);
 	st->data.lock_detect_count = tmp;
 
+	/* load enable sync */
+	st->data.le_sync_en = device_property_read_bool(dev, "adi,le-sync-enable");
 	st->data.freq_resolution_uhz = MICROHZ_PER_HZ;
 
 	return 0;
@@ -940,6 +957,7 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 
 static int adf41513_setup(struct adf41513_state *st)
 {
+	int ret;
 	u32 tmp;
 
 	memset(st->regs_hw, 0xFF, sizeof(st->regs_hw));
@@ -973,8 +991,19 @@ static int adf41513_setup(struct adf41513_state *st)
 					      st->data.logic_lvl_1v8_en ? 0 : 1);
 
 	/* perform initialization sequence with power-up frequency */
-	return adf41513_set_frequency(st, st->data.power_up_frequency_hz * MICRO,
-				      ADF41513_SYNC_ALL);
+	ret = adf41513_set_frequency(st, st->data.power_up_frequency_hz * MICRO,
+				     ADF41513_SYNC_ALL);
+	if (ret)
+		return ret;
+
+	if (st->data.le_sync_en) {
+		st->regs[ADF41513_REG12] |= ADF41513_REG12_LE_SELECT_MSK;
+		ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static void adf41513_power_down(void *data)

-- 
2.43.0


