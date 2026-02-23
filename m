Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CD37998F
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883864; cv=none; b=Wg0xPiA+JKyWGkaHkomkQxH52iuE/n/RYQUdxITQSoov+P/4+IngpjQYmc70kqA+qXgOM3ZxbORwF3K3ZnwWP9Ux9YORNY9trHZymLLzQBm/x/GMikfOKA6Euxf1plWx8WE2oqCgtYWCl+vMmS/Dmnk9++oNhOL17d/+oUdnJO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883864; c=relaxed/simple;
	bh=7oo9T8B+FeTgiTuGE51KQBYrxr/r6RR5TDgp6mMWUEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duOuJ27m10kNsTcJKd4sTrV8kWR3rMPg2fwOjf/BWGlfnJCnqmGfbxoaPSlx4CncYOIjkl/oaxamfSstDOk7xfS3ZornKnFHywGkIZ5HFoTZHlfa+do5UVnh3xcDQSSn1+DnaHt5HBY+YDha9kkkvd4orfSU/l4fzccMKOXKQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YatqPKnz; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YatqPKnz"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c6e1e748dc1so1346493a12.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771883863; x=1772488663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zd8TDmTMVMgTxvBQpe26DMVz8nZYPD6skY/6JxqF5/M=;
        b=YatqPKnzP+WYsN+WDmf2+7XbUUp2NCtgiU5ayD7EZhDH8PCOwP66lMLTWYoWSCXTyG
         bj2M4JNp10BlKBeEOWvFhIqIincneZztklwKcNXUFDPc00xNxCJds9MTkUjsmcPmxsk1
         hPf0Xy8N/XhCq3cN8wxk7iqSrOWCrPwk+P2znDhYGB3RFE/TC94xVsIo43wIYUP3os2k
         9uHVNssbZPoKHw45mUBU9/TpZNhi2gnByTXinDijIHIJMEOMVtN6iajG2IYFcVJQvq61
         sSjkYfpA0HRbkxyFfI2rmkqkD2i31ypEzGSahsbIVFP56k/cUEzHB+wBPJCEUQOAPULW
         NUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771883863; x=1772488663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zd8TDmTMVMgTxvBQpe26DMVz8nZYPD6skY/6JxqF5/M=;
        b=c1SdZxqiTpM0bsmgggaoge5rQ4ikUFRYbCV1zhC7Gj0ZgUTvubWPBPxSn3XIlo4sJX
         YGpBzT7/3U3VWrI/Z4jbG/Uxe04QjJdOu7OXY/HZvZsg0zakKb37ywU/Sd5hujVFvdzm
         JvdP70+Q7MEJ979Di6PT6f7+bZkn4M6kkHd8banhtu6LNJGZGh1ULmfJXjRGe6R9yDmV
         4JnsNkxbwVeoagWxUWLJlLBtXiWo+1vbzttCnvpGa+Vc8EWYtCYC6cIvozY9VH9Nrm3V
         95X153cVYE2eqjkIaF826m7o+YJkQkPYVorlFRVbF/StHFhHYZ1UEwAoNQRfNQUkEFqB
         uWFw==
X-Forwarded-Encrypted: i=1; AJvYcCUZhvQ/WQbLfx6BnvbXoPbEOmLYxk+Um3HW+CXTJz6TPJ7bj4U8JkOiFwc62frB7WTSLnl+rE2IH1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxidyxuO/iTm+iqxMRXpW3CC3QF9xyhwh297kt3G+3iZOxNHIVi
	5fhdszjtfDBOh6DdxjLPCAkLtj0FG9ay/cFfCgAh583RGqYqKR0fvW1h
X-Gm-Gg: ATEYQzzXaVCesnMN3ZjuciyX7j9ZmWoNQcKvA0f8SlgmSQ1Ze37XdnODE6zWsmmgsCr
	zyotcZ3rD7kUbKlhS66SwtyqZKD/yYe/g+xCdq3Ud/1yHE12nfDtjXuG32CcwxWnl6CHNCQHSdS
	35JcfTlE0/K+I3kDEsbSPhxXlNGCVQaERvoHZL+WyiWZxT2w/lL1aGPfIR34QVFXdFQoW8NNwW1
	r6Tx12fKkw8aR/uxZHFjIkodUVvIIR9ecZGk6asGV2FZAStMlJXuH6WbjqrTkr2DJY8PbikqlN1
	ipy3aTiqcozGK5j9xCVmt4upBhF5B/9FMGbrF6aJGl3HALEFdDPlnjrwgmFsDb8XhloF+agf6Qx
	6zzuPnu9nk2a1dBJAxwZrdWx1NFiE+56QZEgkJmz2yXB5FlwFF9KcUkB+SnYZ3TzKHbSxdy55+o
	Wby4hHpSu+6Av2nLxoeK+k+Q==
X-Received: by 2002:a17:90a:d888:b0:354:c3a4:3a6 with SMTP id 98e67ed59e1d1-358aeab3addmr7740458a91.3.1771883862730;
        Mon, 23 Feb 2026 13:57:42 -0800 (PST)
Received: from arch ([2409:40c2:5428:afe:6feb:bc4:5ef7:1700])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358dc0092d1sm352772a91.5.2026.02.23.13.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:57:42 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com
Subject: [PATCH v4 3/3] iio: frequency: ad9523: fix checkpatch warnings for symbolic permissions
Date: Tue, 24 Feb 2026 03:26:36 +0530
Message-ID: <20260223215636.18606-4-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223215636.18606-1-rougueprince47@gmail.com>
References: <20260223215636.18606-1-rougueprince47@gmail.com>
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

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
---
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

