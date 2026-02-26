Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EB394479
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147491; cv=none; b=KODIl6Ii8Iwtw08Dfhtgs1UrLVxfm0AwQDEm97/a1QJfnGVf5dfjjKJWbHWwk/W+BKZ4dOZP0kPJIyC/rWy+Np6ELgutbs5bLkdhy7yfB/IqyVEjOdJFwQ7WJON+ZHQ6tgdQ2D3ObCOWTD9zm66LhhHaY+nbGFA3SX5hmUzOhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147491; c=relaxed/simple;
	bh=RkrZxJAP4+3qGhNCW1sf2lWrU9hgyO4Rlok3ZUybGr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zhdmo1e43l9OydntK1bSBN9pH5DlqYRXz/Wpn9ZPd+1HVGPGGwTzsHIYAcgy+UbNH1iwc/O1vBXiYat1f9s1f8Ni8kGtEIbtBBudgW0uMnKl2WHy5ZQKDiH0TOg38GIFXhpv1B/XigsBIOBHOlkiqaQgOcklZhnhDxdkE+kmDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxWxmH0b; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxWxmH0b"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82746ed8cdcso534067b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 15:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772147490; x=1772752290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMkJsKGoP9koSrH1VBJBOqwpNxxFbXiwZhSMj9fjMu0=;
        b=lxWxmH0bMEHgMptKYkjPyvxeUtFUsM8VE9rE2fAaDt4HlSxkPAiJrYy6X+y9IkKQda
         B927LgOfjAEsHyeoqk6j6v7s8oFydq7tzhzik1NYxhYfuXM5BvFfv8l4Bbmxonwz4oQ9
         drwRdSZhuC5rpgx4OdA949bnur8P5uddLvOptGgg55m7d+TXJ3ErGFGFk6tBLGm/iJj7
         bNd0//qYoMyN31jHJcgzg5+3f5Ens9N6z37Vb04RhLD/spFykO6UaMLLLIYXN6gXw498
         TWcS5mV8u1XEVaj0TgtHjkfEH3ElgEx/00TkKQ4p6Z7sm1qoP2O+QrBTQphYyd00NBnV
         EcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772147490; x=1772752290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMkJsKGoP9koSrH1VBJBOqwpNxxFbXiwZhSMj9fjMu0=;
        b=C9XkACrMStJmk9byq6ajkvXxcwdaTNfvZDCcXYtzZ2P6P3ErcXKcNELwlYsbE2eWi/
         xEAYuPHkfvnHoyIWBWHDkHBHUJDkQvtU3vq+ZOmQeKEtYkF7GgNlH15YCWXvtpOoX2d9
         hhbWUhPJD9ocilRI8Ff+qO6EuOOSkWw2u5ByyZIKLtUFiohMiOrVfueTqMMwzE7b5F0L
         xAXz4ju9ywiM5fKCkwP/gLGvAAeRHt7E7bHuTH5UnmCbn0qkiSyg6y0PLSXohLKltFtS
         76xGZ9EMyrB5acLwwW/GqI1b+WMniNd+wH6CbVlTRU13dnAgiujSmcSlXiEpD3S835nm
         lGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVabU/6QvBXM+BV/JP2bRiTut2TmCBBtzUg0ouaj4zCTfLCWX4beuIf4BjiSFeFvYj+rfWLk77xxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70ZDxPZc1tIlk1ijSLjbpLm5Ddvwzjzjh6j7nBRn92ZeQFXYb
	55wTsHFriqvf2bS3CjGOaxXEHkJCPXrBL0GG3d1d3jKU+kTBtc5Lr1BG
X-Gm-Gg: ATEYQzy3rILeanyn2vidIgwLyfOj8v9CGLvQA+SNEkniiSSum83/zlslvTUVvwP4fkz
	o3bA5xNGBMHSo/OaD2Zac1tp5EbkJxaaFJcIGKldjOsFmTsBB1OC7rLYtri8cy6sz3owYOgRNI7
	8e398tI8vUuusPtjMGRkivDfSzaDN7wwDrLp0XSZf1E8RLHkCeizDGHrxbqcM2tUL3IecZzHePq
	91nwGnXpImgA9p+r0qUwxkifmStkALh/4qkS+4/khICisfY/tl5z4VvbuTXT6ylRAEGMTudmKWE
	LTCoUs+eVntCt4J2aeLieht+5gKFVhT256v4BnehEeTEi60frk9R5JvavPTYzoCcHo5J5QaGotO
	n4wVSYN3IyQLw1UyzlfHQLj606m2mD0d5xPyn8ssm7HGGHdMcomiQ0/aUDVRKNqUh95CiMKfOAi
	gA/Eg7Ct/rACsidHlFWi+uvAbe
X-Received: by 2002:a05:6a00:2e04:b0:81c:717b:9d39 with SMTP id d2e1a72fcca58-8274da568e3mr665119b3a.56.1772147489597;
        Thu, 26 Feb 2026 15:11:29 -0800 (PST)
Received: from arch ([2409:40c2:5006:5b06:f9ff:5cdf:1c23:a906])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01054dsm4238752b3a.43.2026.02.26.15.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:11:29 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v6 3/3] iio: frequency: ad9523: use octal permissions
Date: Fri, 27 Feb 2026 04:40:57 +0530
Message-ID: <20260226231057.20669-4-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226231057.20669-1-rougueprince47@gmail.com>
References: <20260226231057.20669-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently defines device attributes using symbolic permission
flags (S_IRUGO and S_IWUSR). Update these to use octal permissions (0444
and 0200) to resolve checkpatch warnings.

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v6:
- No changes. Resending because something went wrong with v5.

Changes in v5:
- Reflowed all commit messages to properly wrap near 72 characters as
  requested.
- Collected Reviewed-by tag.

Changes in v4:
- Used full name for SoB.

Changes in v3:
- Fixed vertical spacing and broken indentation.

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

