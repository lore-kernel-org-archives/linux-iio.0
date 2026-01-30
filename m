Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B68346784;
	Fri, 30 Jan 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769767617; cv=none; b=LTo6BQgyK89hPOg1Bw7uVW5hkrmVoHt8XQQ+pljyB/Ucd8YpShJs6rdNSTU3ziIfOOVGnYQ+fuO9m4ytIErFt4HfIxzBmXcNOWwwkWGdbLPlAY2K3wSDZgs08GTbZiU1vhKMDT6qNhc86wrI0keGCVq0c1sSE95HTTCVKVPs8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769767617; c=relaxed/simple;
	bh=sUU2F4vITRgm2zjOvIuUgxfrAq1HXgFe+Ixvv1RUoCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cs4fFt1dTixjwkDKtJ1CWhFTJOO6xkSSazpBGRZdK8H3bi4tESAB2vozyMBJmQT6ggxYT0CKBMpSZrYZpwcFr09hppFzoIhALhFQ0Pc6YTRf53Ww3+XZG9B1V1QOvhq5/FJ/QoFUHnBqHm8Pds0R2LjudTp+K9YTO42GTGEvcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWD/ala3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWD/ala3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12CA0C2BC9E;
	Fri, 30 Jan 2026 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769767617;
	bh=sUU2F4vITRgm2zjOvIuUgxfrAq1HXgFe+Ixvv1RUoCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZWD/ala3ffVpDl3fw27ecM6AErCwCBYV13Q3WuZWA/qKkgA3IL53NKCS3vcaLnIPf
	 /jsGExhwGe+JNj3VId1ZbxlmtggYQrY+A1VCSskXoAPOYgiX1hrYON+sS/gkzAUfn9
	 22+CB5yPM2sOcvIf4Qd5RWvlkLpV3i8KnsbNM+WGdySF6f12bEROHdMQfSzC8vn7AO
	 1qyPK75r8+fxQsO965MyMOzGjuL7TCGXJOn34ZYeiTpwoVcNPQTfsi9p5gepDwewR3
	 I5KuzKshAoS6aTHBcwp4K29AaO+w+VokU6/G7ftAbzogsgmHphH4tiTRK4oX7FIQvt
	 4OEDz0Et9oTbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08258D49C76;
	Fri, 30 Jan 2026 10:06:57 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 30 Jan 2026 10:06:46 +0000
Subject: [PATCH v6 5/8] iio: frequency: adf41513: handle LE synchronization
 feature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-adf41513-iio-driver-v6-5-cf46239026bc@analog.com>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
In-Reply-To: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769767615; l=2998;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=7PWCc+kWI/VpsoPPUmqky10EYHvCMPsgsZ1c3vbPiko=;
 b=yYxkpd3K/cWnvV/iU3CKeToY5WGaVLgHlEseQM0b4pYBV+Qnc075WEjzLpyPsPhNc9d3+o4A7
 vkCuqBl93qwBQPYIZafGB/Hj0Ri109UpegvS7/rmFNLPweBUrF9GrJ3
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
index b2efd545c885..0741aeb5fa3d 100644
--- a/drivers/iio/frequency/adf41513.c
+++ b/drivers/iio/frequency/adf41513.c
@@ -221,6 +221,7 @@ struct adf41513_data {
 	bool phase_detector_polarity;
 
 	bool logic_lvl_1v8_en;
+	bool le_sync_en;
 };
 
 struct adf41513_pll_settings {
@@ -639,13 +640,27 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
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
@@ -938,6 +953,8 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 				     "invalid lock detect count: %u\n", tmp);
 	st->data.lock_detect_count = tmp;
 
+	/* load enable sync */
+	st->data.le_sync_en = device_property_read_bool(dev, "adi,le-sync-enable");
 	st->data.freq_resolution_uhz = MICROHZ_PER_HZ;
 
 	return 0;
@@ -945,6 +962,7 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 
 static int adf41513_setup(struct adf41513_state *st)
 {
+	int ret;
 	u32 tmp;
 
 	memset(st->regs_hw, 0xFF, sizeof(st->regs_hw));
@@ -978,8 +996,19 @@ static int adf41513_setup(struct adf41513_state *st)
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


