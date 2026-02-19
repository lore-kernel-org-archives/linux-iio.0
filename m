Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534432AAB6
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537016; cv=none; b=JIVNb+D9Vhyi5MpMoW8Mvp6dleCUCvAEGxEq49wWz7YYkkCHHHu1n1UD5+s0AXOGPm+WxjeefDIDBKhs6HNuR1fxbuy1VNuG7mvRetD6dA9tdSbPigbuJiDHbDMlJSY76UAfxP/1F5w+LEH2LOiJA8tE++mGeQ8Clct3JDSah/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537016; c=relaxed/simple;
	bh=6M+XGC7yqyyv+3XDNyCsRg+HgWbHFVYQ0w+W77xeb18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCEykjIK+JPrfu4qNekR3pQq15jZxQ+8R+8TDcb+umPJpMDGGvcmbh1aMWKN2Y3E9WCFtVycu8q8uxm+qaCgbGPfmDtZngfs8b2p+rHsSVjt1LdikBs/iejuEfGP9FpccgzvUo7U9uIngOnOHW2df6OZkwBnWGZq+bFsIZ++DdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjCEaX8N; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjCEaX8N"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so12787025ad.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 13:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771537014; x=1772141814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zc96RPM8zuz0aUXS6dx1Rqoun9U6kSuSBbcKRBldkQs=;
        b=KjCEaX8NJn1VH/eoC6ecxtpZQh7rkcOfu9V3W0F19xRCDKUBKKEPq1OhYkN34yG2a4
         ersmOj0iYTkeQRWkCyTkndhOrDkKJb4xNjYQHUJDA95JGNOFAELUfN9VxWXPA4cm5JbY
         9kSiri+D7HLVd9q6Wz9Xb2PUgkhkenHVFmtWGm1vKuU8QHv+pHzvr5xsbvGasE1Y3Gto
         pAlq+JG/T0g+DyJIK2+zv3/3PA+w/BO2/C6bvYD7ZidYvP63EH4q8EeviIwVG6yRiB1B
         yn+9e1f8UdPG4kI4nBQ7eq3w5IZznausobEVIgBkcG8F/wYvotu7W95Htdim2mG8ZjDM
         6RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771537014; x=1772141814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zc96RPM8zuz0aUXS6dx1Rqoun9U6kSuSBbcKRBldkQs=;
        b=IV9juJqNM18jrSjUj+7CmHZcsbiIPnzP6V/Iu3KliBtq892MTyvcjHJl6pUoU7UZbK
         F4mTan75tDR/Q/mLccBRqB/TJLi3Lz2+njbTyX8beVms+1gTkQvUJCWGVdJyJG8tVu1K
         nicZIc3A2lF39nnEsAxlv9855B3Dl0qtplcS/7wXodvYESSYzsRTSdL9Ee+9xiYGvg5o
         6L7DxmFFrCrNqjYg88lcbl3G/RuYNqXXlnQJW9ZMWmMUHBTEE8jZEayYbWXwGgVYb/ox
         dORbS2n5ppK+o7GitB8LHVPZmrqJvmjOL95uLC8DCkzRAzh2X2USmDo578XA0k8y2Qmp
         DVAA==
X-Forwarded-Encrypted: i=1; AJvYcCVUmiCMMlk0wXUnht7jsAuUADFQDQrcWIhg6XJe8Rc7jKpAgC7P8/HSdDSR54UoulNFqp7WkPiJ8CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLLjZPIMC49eAYULQab+7+ngdEkW10SR6P3VJ34RL0OgLyP0Ym
	QBeaVeqRdWPTmWNawVtj3+iMKD4AIqVdWQpDGN12Q1CckA6pmUx6/crJRKP2MA==
X-Gm-Gg: AZuq6aLh/KJYRYRczSORrBWXXSPE4YLtR7HS/WuI9SHC23xRRtbY08OHQMRITWjXC0K
	kKoM1h4XxI+J6XvrlU1HIBkDHUCcHu4xOmRRgKQ8ODu82LVW4oMTcDJARbMBvAxZyPtuTFqXH0v
	IgKABZcosCJvw1M0kuH43NRB5L494Sm9SDbHjVeWBRX7oRUSW3y452qIPHE9FARmU/ciQMAvQiI
	bVHIbotQJvG0i6gcvHhB5/YqA1raWR6mxeI5StZHkyOBDIjZhUn95FkJWnZbkZf6T4aqG0uGoBt
	LX3dqCOIhPvsUR2HOnOhM4CqZqXcIW+fWMOAbFQ7oLmptDXQFz64Ho4tOoPOkDXHFM7bmUCZ/L3
	tiYqjCVpEzgW9Qkfurh9z0mpnKwwYvV3nR4I4itiGXpJTSazUU/z5rxLcpCGuPu1dTtuh5I2CF4
	d+uEg2tuXK2aubgiMeKLRx48xE
X-Received: by 2002:a17:902:ce09:b0:2ab:1dad:e500 with SMTP id d9443c01a7336-2ad50e8dd66mr66367645ad.18.1771537014082;
        Thu, 19 Feb 2026 13:36:54 -0800 (PST)
Received: from arch ([2409:40c2:5415:8e16:49a5:aac1:3b74:3ed7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a7145cbsm238938475ad.30.2026.02.19.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:36:53 -0800 (PST)
From: bhargav <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com
Subject: [PATCH v3 3/3] iio: frequency: ad9523: fix checkpatch warnings for symbolic permissions
Date: Fri, 20 Feb 2026 03:05:49 +0530
Message-ID: <20260219213549.59645-4-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219213549.59645-1-rougueprince47@gmail.com>
References: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
 <20260219213549.59645-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently defines device attributes using
symbolic permission flags (S_IRUGO and S_IWUSR).
Update these to use octal permissions (0444 and 0200) to resolve
checkpatch warnings.

Signed-off-by: bhargav <rougueprince47@gmail.com>
---
Changes in v3:
-reduced unwanted vertical spacing 
-fixed broken indentation

 drivers/iio/frequency/ad9523.c | 78 +++++++++++++---------------------
 1 file changed, 29 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 6daa2ea354a8..ad32eb66edca 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -558,55 +558,35 @@ static ssize_t ad9523_show(struct device *dev,
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(pll1_locked, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_PLL1_LD);
-
-static IIO_DEVICE_ATTR(pll2_locked, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_PLL2_LD);
-
-static IIO_DEVICE_ATTR(pll1_reference_clk_a_present, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_REFA);
-
-static IIO_DEVICE_ATTR(pll1_reference_clk_b_present, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_REFB);
-
-static IIO_DEVICE_ATTR(pll1_reference_clk_test_present, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_REF_TEST);
-
-static IIO_DEVICE_ATTR(vcxo_clk_present, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_VCXO);
-
-static IIO_DEVICE_ATTR(pll2_feedback_clk_present, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_PLL2_FB_CLK);
-
-static IIO_DEVICE_ATTR(pll2_reference_clk_present, S_IRUGO,
-			ad9523_show,
-			NULL,
-			AD9523_STAT_PLL2_REF_CLK);
-
-static IIO_DEVICE_ATTR(sync_dividers, S_IWUSR,
-			NULL,
-			ad9523_store,
-			AD9523_SYNC);
-
-static IIO_DEVICE_ATTR(store_eeprom, S_IWUSR,
-			NULL,
-			ad9523_store,
-			AD9523_EEPROM);
+static IIO_DEVICE_ATTR(pll1_locked, 0444, ad9523_show, NULL,
+		       AD9523_STAT_PLL1_LD);
+
+static IIO_DEVICE_ATTR(pll2_locked, 0444, ad9523_show, NULL,
+		       AD9523_STAT_PLL2_LD);
+
+static IIO_DEVICE_ATTR(pll1_reference_clk_a_present, 0444, ad9523_show, NULL,
+		       AD9523_STAT_REFA);
+
+static IIO_DEVICE_ATTR(pll1_reference_clk_b_present, 0444, ad9523_show, NULL,
+		       AD9523_STAT_REFB);
+
+static IIO_DEVICE_ATTR(pll1_reference_clk_test_present, 0444, ad9523_show, NULL,
+		       AD9523_STAT_REF_TEST);
+
+static IIO_DEVICE_ATTR(vcxo_clk_present, 0444, ad9523_show, NULL,
+		       AD9523_STAT_VCXO);
+
+static IIO_DEVICE_ATTR(pll2_feedback_clk_present, 0444, ad9523_show, NULL,
+		       AD9523_STAT_PLL2_FB_CLK);
+
+static IIO_DEVICE_ATTR(pll2_reference_clk_present, 0444, ad9523_show, NULL,
+		       AD9523_STAT_PLL2_REF_CLK);
+
+static IIO_DEVICE_ATTR(sync_dividers, 0200, NULL, ad9523_store,
+		       AD9523_SYNC);
+
+static IIO_DEVICE_ATTR(store_eeprom, 0200, NULL, ad9523_store,
+		       AD9523_EEPROM);
 
 static struct attribute *ad9523_attributes[] = {
 	&iio_dev_attr_sync_dividers.dev_attr.attr,
-- 
2.53.0

