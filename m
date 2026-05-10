Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC13859FA;
	Sun, 10 May 2026 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416955; cv=none; b=LonRPA3twyn/P4mHFBdhnwBQavq3ZGa5KDeYp28iyvZXsPxRlDXNfKk3Gz1gnTS9iW4QtTme3wLeZyLQvb2spUKPDh2yjqBlaZWI4xzjDrjxGPr5sVDTFB1L/lNDMoZW8cicY2lkeFOmLmBwHqm3ey3rrrayrbZKVH++Ks+LUVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416955; c=relaxed/simple;
	bh=7ZxmBI31tVNmqDynh/WxbVag+2UdL7v9GG5am+xfS7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQEV14JaO/l0l/WiOphp2pOv+dUfauqieeIyFMqyYRersq0oYHNANQgKgphGCd+ndBHrAj6n2/W1DRFRsby6OzMATmIwSZCjTrdooVHkjRZM++QFzAnSyf9LjuEmLh/8ZwF7VI+c8vtVszjCrSKsKp0XQdb2KDetnIFjK2uX8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpqBVsm3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpqBVsm3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F6F4C2BCB8;
	Sun, 10 May 2026 12:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778416955;
	bh=7ZxmBI31tVNmqDynh/WxbVag+2UdL7v9GG5am+xfS7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lpqBVsm3X6tGlyBOvyytsC8uStOOjzMqNZBychygEQrl1lg2meqiU9qyoYkDY7/HB
	 W4rvleWZ+T37SaHD0fkReiOx9NJpzMIIxhkoZ55V9I+Fo4ZHKC/e5bQrLwXf7o8Hio
	 t9DtoT+hly2QccGZhN++6mO7MBW8c7z9owBlFYa2QH26u+xAvuIibudJxCRSWE6AZk
	 /CyJn3gNesa8zWfk6oNPRDxveOTEtoapF973zyqV1NDQRikTDx78Z2HmdTr14fx1BO
	 I6Z4KwMIugmiaHqlLbEPUQE8FByb9529xFK28/KizTqoFToXuFeIp+Fmv/xTUXNEN2
	 nOFOceODFJdgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D25CD37B9;
	Sun, 10 May 2026 12:42:35 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 10 May 2026 13:42:26 +0100
Subject: [PATCH v12 08/11] iio: frequency: adf41513: handle LE
 synchronization feature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-adf41513-iio-driver-v12-8-34af2ed2779f@analog.com>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
In-Reply-To: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778416952; l=2627;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=MI4oXKG/9S67gARRXhXgSEG4lmLjEf89mrCLp3YmQ7I=;
 b=Z0TPov+FQK5rWmWu1JbqdqyZKN3B1pnmPbJJhUITf6fq1iyQWeUGBOjNCdgs4sL3kgrgL8L6j
 NvMtQyt6xZ/BVTqXPauOldCngCDKmtYf2EN2AguTObP/0nzLVps+nHA
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

When LE sync is enabled, it must be set after powering up and it must be
disabled when powering down. It is recommended when using the PLL as
a frequency synthesizer, where reference signal will always be present
while the device is being configured.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/adf41513.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf41513.c
index b8a8b9fb81d9..397e859170cc 100644
--- a/drivers/iio/frequency/adf41513.c
+++ b/drivers/iio/frequency/adf41513.c
@@ -218,6 +218,7 @@ struct adf41513_data {
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
-	return adf41513_sync_config(st, ADF41513_SYNC_ALL);
+	ret = adf41513_sync_config(st, ADF41513_SYNC_ALL);
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
 
 static ssize_t adf41513_read_resolution(struct iio_dev *indio_dev,
@@ -903,6 +918,8 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 				     "invalid lock detect count: %u\n", tmp);
 	st->data.lock_detect_count = tmp;
 
+	/* load enable sync */
+	st->data.le_sync_en = device_property_read_bool(dev, "adi,le-sync-enable");
 	st->data.freq_resolution_uhz = MICROHZ_PER_HZ;
 
 	return 0;
@@ -959,7 +976,18 @@ static int adf41513_setup(struct device *dev, struct adf41513_state *st)
 	if (ret)
 		return ret;
 
-	return devm_add_action_or_reset(dev, adf41513_close, st);
+	ret = devm_add_action_or_reset(dev, adf41513_close, st);
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
 
 static int adf41513_pm_suspend(struct device *dev)

-- 
2.43.0


