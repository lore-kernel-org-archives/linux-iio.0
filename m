Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26483A3807
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141216; cv=none; b=f/0ptlmuzxhBHdu0NtkxQNO3l7tqBSzWK7TFBsuqpVWWPA+JTxtY95xeuPWMxGfVWKw3LFPHZ6SBmpaNG1gDgoxcZ4DzVa4ZgSvGHyMb+V1x3bTVNEYLQcw+mEm/RuVo6egNATRsYZgIlHmNxvNisUyzFtDGk3Yldzb1iFDfuoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141216; c=relaxed/simple;
	bh=Tjpk0UGo7UJkZtCc2AlC0a6mEIDVKO9WL9yPpEY8ksE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnX5ZJzJiEfwsz2jw/Dzh9yzp5aixqZAlOTVSBgBWGv/IwBfpU1eWMdeLDcw9vHGVViV0unVpl/P9Wq9DkKzoLj0EOc6hOBuaBHZ80GeyJYxVJ5KkXr91gPfsnSemuadjxD1FuE46F4t8VIHsh4nS7Z5MkAc/NqhEL5VRGJFvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRuP76H3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRuP76H3"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-842307472d4so64561b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 04:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780141215; x=1780746015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86sSBgbx9kKkCfgAmFq6bHEkr4eE6POT886tx7GLE3I=;
        b=IRuP76H3/79uhA4QYqjncsQyASgr0GE/xBJCMnNBlkETZ9GtQnmHQE/UBOne3THzVo
         LFexkT9jbvG4ZLUSZzU4vqUTUWhu46Nxwocx/GGIIroikqZg5BEs+XxFk4PKr8DR8WAx
         rQH+kZaisfaZcBuettStXDKTFiQJTUxO/Hvt50nJEmSS/Gyu6v/o1vT/WAwYr3wXQKtM
         AHebVrnZlRUkRLbQkt4JFFjhC0HF66PGxUrcNBrLdV/8aKVEkj2EM2/zakSyM4XJ6/pm
         Fu8pM0EDBwo23NGR0krsIFE5p7CPhE3ulNIvyaN6x+h/FG+aeZEtgoF5FMimXsJhokzm
         XgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780141215; x=1780746015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=86sSBgbx9kKkCfgAmFq6bHEkr4eE6POT886tx7GLE3I=;
        b=rO9Y/6n/WiKDV31FJNvslwzGwSVM9JTxA9RwUtDmeOKyXyoV5qQBcTwatooh3eGFWk
         9DJVxbVWgLJxEEPxy2yu/3rgUJUPLK6sLritpkDJBaEhn/G6KGBQhAn+D8wRcJK8Zjvr
         nkYBFrEK42x9Ediqp0WKLreKuniPNSvmdnef91vwRLh2vSbLMNhsL7kg1bFxhp6AzZCv
         07UFBYEvAFGzM7si6Ue3DvK6/Q1uUP68tQmY4l5zp6McwwRwZYnlMyfx/LZxEpe+Pnys
         O2fDLH0PeJMsMOw1jt+Brvbsc5/9arxpx2j7drs4c5OI2WHSdPS6zanBygWBVBNMuAAt
         ezVA==
X-Forwarded-Encrypted: i=1; AFNElJ805VdTpL8Mh2T95ALOPbH2RPHJ8DA2lT+K0nAJyn8eZQ+9VUDa6MIe8WtBsXeO8wX5WDa/R0u33Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKmcUKV9q/bZfxO0L40+D30cy4QdlWgYw+iWBVFwKevaazU8v7
	WA8iygA+acgEAGTdoIRncRdO+o8wsr3lN5NMmOet5zfwK8JZ//rmHPAV
X-Gm-Gg: Acq92OGKah6zGE667u3H3qQX+dZz3IuxQPsmkC29gGPSs3n6rB0eoSX98XKg6H7AYWi
	6W4wy4BulnvGuWlvC+Uzsa6VmWfcYVR8kLSRQFM0RBm/UdBrjXO8E7W+6iv6GNIjnZ9oneAtfV3
	0rllti3RT79UXlZ8EtesL+SDaIIJzqtHcALv1JOgzPvG1beanB733Fzc4rq100NP0ipnmnGu/HT
	DOrIzAA9Korna7H81qYY1WGxOIdhxOuXBQNGaDpSp4Yca4OZGggO4jtZPFp+JTIsq8Y+S2uiHaY
	nOmSea0WrnmFgQvQSzEOIaxoPPMlB/sPdXAOM9g8uYsLnuSMX7jdstGHxfoNsZ/b84CHf9Gso3A
	M9g2mHJqqDaTlzS6vc3jvjPBjpD7RMr8h7oaeEKlrKeSdNajwOdvhIHOu1WSsx5tm4oQxfsbpJF
	TwshzKytR382HkJ07dpCjaL/JFsuD95pTbrZ34NQdiSsoyKNJpkVJfVMc9Ow==
X-Received: by 2002:aa7:8889:0:b0:823:9b7:9c0e with SMTP id d2e1a72fcca58-84225493ba1mr3250783b3a.34.1780141215015;
        Sat, 30 May 2026 04:40:15 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b6797esm5467518b3a.26.2026.05.30.04.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 04:40:14 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	apokusinski01@gmail.com,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH 2/4] iio: pressure: mpl3115: clean up interrupt handling and locking
Date: Sat, 30 May 2026 20:39:36 +0900
Message-ID: <20260530113938.171540-3-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260530113938.171540-1-suunj1331@gmail.com>
References: <20260530113938.171540-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return IRQ_NONE instead of IRQ_HANDLED when reading
INT_SOURCE fails.

On shared interrupt lines, returning IRQ_HANDLED after a
failed register read may prevent other handlers from being
invoked.

Switch the trigger handler from explicit mutex_lock/unlock
to scoped_guard() for consistency with the locking style
used elsewhere in the driver.

Move mpl3115_config_interrupt() above the interrupt handler
in preparation for the FIFO support added in a subsequent
patch.

No functional change intended.

Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 59 +++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index befb6d48efa9..52a3d0d59769 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -308,9 +308,8 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	u8 buffer[16] __aligned(8) = { };
 	int ret;
 
-	mutex_lock(&data->lock);
-	ret = mpl3115_fill_trig_buffer(indio_dev, buffer);
-	mutex_unlock(&data->lock);
+	scoped_guard(mutex, &data->lock)
+		ret = mpl3115_fill_trig_buffer(indio_dev, buffer);
 	if (ret)
 		goto done;
 
@@ -322,6 +321,32 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int mpl3115_config_interrupt(struct mpl3115_data *data,
+				    u8 ctrl_reg1, u8 ctrl_reg4)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
+					ctrl_reg1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4,
+					ctrl_reg4);
+	if (ret < 0)
+		goto reg1_cleanup;
+
+	data->ctrl_reg1 = ctrl_reg1;
+	data->ctrl_reg4 = ctrl_reg4;
+
+	return 0;
+
+reg1_cleanup:
+	i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
+				  data->ctrl_reg1);
+	return ret;
+}
+
 static const struct iio_event_spec mpl3115_temp_press_event[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -381,7 +406,7 @@ static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
 
 	ret = i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
 	if (ret < 0)
-		return IRQ_HANDLED;
+		return IRQ_NONE;
 
 	if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
 		     MPL3115_INT_SRC_DRDY)))
@@ -420,32 +445,6 @@ static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static int mpl3115_config_interrupt(struct mpl3115_data *data,
-				    u8 ctrl_reg1, u8 ctrl_reg4)
-{
-	int ret;
-
-	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
-					ctrl_reg1);
-	if (ret < 0)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4,
-					ctrl_reg4);
-	if (ret < 0)
-		goto reg1_cleanup;
-
-	data->ctrl_reg1 = ctrl_reg1;
-	data->ctrl_reg4 = ctrl_reg4;
-
-	return 0;
-
-reg1_cleanup:
-	i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
-				  data->ctrl_reg1);
-	return ret;
-}
-
 static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
-- 
2.52.0

