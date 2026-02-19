Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C0307AF0
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533242; cv=none; b=XbL1TWWKomZSfbWc40QrWddIZUFgS19WISrPJeEBDjJIKlqS4wjHjxBKArit38NqItqvEfm59D7raZHb0ohlC/iznncApseBbkvjIJqM5xuZuL8ytsOhJoRKMStke23ewifjvmeHucznS0aS6WoQq8niZZaC7klaxuEbF//3kWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533242; c=relaxed/simple;
	bh=MFsqeaI3f9penNDTUHKZULsatT4hpvovywGhQC/KZAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGAPEUDBNaceyOrUaww/X0jYF28j/hDPw2CHDMSOH8jTW+3Z6i3R93K5NPhLoTDXmNdHVOINiQK3zCWGlsNGhl+e+4oXl8D9wKxS4Ewf8iJCHb4KD6emNUmA2RK1omuNwK5pFikbQ9rsm3Ouh2kmM5/ymW7DZyxxQ3QPJexf5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esdiTmJK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esdiTmJK"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8249cb73792so1221734b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 12:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771533241; x=1772138041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26gzJtloJijZDesoemSh9i7X2im5JgocENjBucao4eA=;
        b=esdiTmJK5gYXxj8bxNtiE/H8L8V/jKrmw8d2dfOUeZLt4X+xZKCnriiml5fVblYktf
         54X2paXYs/CFAN5XtQz7Ua1dhueEX4JVYCUaLDqk9F8PSq/GpNi7zmNcbLg08W1eztxn
         NIjaKVqXykSxQRsnlRTS8L9rYLqX/zda56+B29DwX0RSO5KPOEynrVSTz++XcRLUz+pa
         WdirOKZY1HL8xlc4B2al7+SWK3pqUJLuI9ZqwU2JM4grMcBGHEyNeTmNMmVRMsxAdEIJ
         zz79fwRHTw8BTdu6WhBEfbbgkSDQABcT9f6wlRI7UPeSBifk7ccTt689in61IB/Ogml1
         j+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771533241; x=1772138041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26gzJtloJijZDesoemSh9i7X2im5JgocENjBucao4eA=;
        b=X4zad9EGmgLnfYa0nSwGsuzebU2ZB/0j3dxjcjVm4xaL+GwzU0rQpzbTg0mQsBb1Du
         HFI3dL3nkrYHcPLAqKoobUBgSphiGdV5JcnNg2TL27J3uFx0UjZfFox10YeIzhel/s0s
         0hqX/iPdvJnvjjKvlohzWoZGv5+xq5LKdDySVIc8Zw+hneRyT0lwO+uX0ddfWNiflEkP
         cZQPVfqFDc0NaiNO+zthBodhiiQd+p1iI+Gw5U3EiPDd6I/e+knMBBNB6lBeeClGx8+k
         UFQ88cOiQNXgB3uHe8VU3ctOAdAzEAic0RPJQOL3TWvZabLTRkS3Vl04AQwzZQ68Nq7l
         e63A==
X-Forwarded-Encrypted: i=1; AJvYcCVP/+fHVxI2h6l9rpar5wLqcfRjP8bBUWjrwnG0xO+85TX/WEeumZXDqXALuG+ztAeORa93q2c6I7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xP9h+RkUJ5hb2xapCOCZlMrgm/O/9+xXypGFH9zeMuyJs1pn
	9GFJJknCUFGZZwzlbZ7in1PQuv1FXm4mtqZn17Lqllu8eIMvioS0rRox
X-Gm-Gg: AZuq6aIE7kVnHpFlT+eoiGeDlKgrrNUkvSZJlat0qRU7M92dOwcXUvkiG0f5ZmP/jmw
	rt4E16qaCgdfKZm+cvasjmaroqQHKVcagrFwKkk0EXswtMGGVLiAVFoYllqlz9ZAj5bkOCwBzDR
	JlaD0vKZAUodtZeaSKBi1yeFl0lmo8yWIaFvCe2cEIt0Gx24lX+pbzbRT9XSY0VrrxR3gKCkQmy
	APxnhSnpofnP/4YfkZwDcqc2k68KOC8e83gIJSmqIDWgls3m6VrScSPX8bdoCuI08TZnXDMwdCp
	L4fe9FbA4agPZREP2IUKFsrhWPrrLQj5aN+2lNBoNECC2BmfjvhitGHD3jdEZQOexZ5U8MF7yLp
	v2yM3b0WWahjHahcxEOXyzlcLEbQepVVp9UPgL5Nd8IKHgHPULADw/OISGK4riVV3Js0NDs3dBG
	NwY4YCGCMVOoy4PrjJz2hdJGSh
X-Received: by 2002:a05:6a00:992:b0:7f1:4:66b with SMTP id d2e1a72fcca58-824d95e6759mr20544408b3a.44.1771533241192;
        Thu, 19 Feb 2026 12:34:01 -0800 (PST)
Received: from arch ([2409:40c2:5415:8e16:49a5:aac1:3b74:3ed7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b94b80sm20339278b3a.55.2026.02.19.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:34:00 -0800 (PST)
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
Subject: [PATCH v2 3/3] iio: frequency: ad9523: fix checkpatch warnings for symbolic permissions
Date: Fri, 20 Feb 2026 02:02:15 +0530
Message-ID: <20260219203215.15566-4-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219203215.15566-1-rougueprince47@gmail.com>
References: <aZa_QbwCumULvTf7@smile.fi.intel.com>
 <20260219203215.15566-1-rougueprince47@gmail.com>
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
Changes in v2:
- It was suggested in v1 to convert these to 
  IIO_DEVICE_ATTR_RO() and _WO(). However, those helper macros 
  expect uniquely named callbacks (e.g. pll1_locked_show), 
  whereas this driver uses shared multiplexed callbacks 
  (eg. ad9523_show). Converting to the helpers would require 
  generating wrapper functions. 
  Therefore, this v2 keeps IIO_DEVICE_ATTR but updates the 
  permissions to standard octal format.

 drivers/iio/frequency/ad9523.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 4d0556ff5601..2a075d09ab83 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -558,52 +558,52 @@ static ssize_t ad9523_show(struct device *dev,
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(pll1_locked, S_IRUGO,
+static IIO_DEVICE_ATTR(pll1_locked, 0444,
 			ad9523_show,
 			NULL,
 			AD9523_STAT_PLL1_LD);
 
-static IIO_DEVICE_ATTR(pll2_locked, S_IRUGO,
+static IIO_DEVICE_ATTR(pll2_locked, 0444,
 			ad9523_show,
 			NULL,
 			AD9523_STAT_PLL2_LD);
 
-static IIO_DEVICE_ATTR(pll1_reference_clk_a_present, S_IRUGO,
+static IIO_DEVICE_ATTR(pll1_reference_clk_a_present, 0444,
 			ad9523_show,
 			NULL,
 			AD9523_STAT_REFA);
 
-static IIO_DEVICE_ATTR(pll1_reference_clk_b_present, S_IRUGO,
+static IIO_DEVICE_ATTR(pll1_reference_clk_b_present, 0444,
 			ad9523_show,
 			NULL,
 			AD9523_STAT_REFB);
 
-static IIO_DEVICE_ATTR(pll1_reference_clk_test_present, S_IRUGO,
+static IIO_DEVICE_ATTR(pll1_reference_clk_test_present, 0444,
 			ad9523_show,
 			NULL,
 			AD9523_STAT_REF_TEST);
 
-static IIO_DEVICE_ATTR(vcxo_clk_present, S_IRUGO,
+static IIO_DEVICE_ATTR(vcxo_clk_present, 0444,
 			ad9523_show,
 			NULL,
 			AD9523_STAT_VCXO);
 
-static IIO_DEVICE_ATTR(pll2_feedback_clk_present, S_IRUGO,
+static IIO_DEVICE_ATTR(pll2_feedback_clk_present, 0444,
 			ad9523_show,
 			NULL,
 			AD9523_STAT_PLL2_FB_CLK);
 
-static IIO_DEVICE_ATTR(pll2_reference_clk_present, S_IRUGO,
+static IIO_DEVICE_ATTR(pll2_reference_clk_present, 0444,
 			ad9523_show,
 			NULL,
 			AD9523_STAT_PLL2_REF_CLK);
 
-static IIO_DEVICE_ATTR(sync_dividers, S_IWUSR,
+static IIO_DEVICE_ATTR(sync_dividers, 0200,
 			NULL,
 			ad9523_store,
 			AD9523_SYNC);
 
-static IIO_DEVICE_ATTR(store_eeprom, S_IWUSR,
+static IIO_DEVICE_ATTR(store_eeprom, 0200,
 			NULL,
 			ad9523_store,
 			AD9523_EEPROM);
-- 
2.53.0

