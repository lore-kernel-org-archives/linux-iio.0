Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A1225A35
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 01:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771463012; cv=none; b=q7PfKxOQkGHAnug4rTTeBrhr3lk6d0XE+1Aqu8wOXlirAW/TB8u7l7xZQGHwpDGnbx6GUxaiET+beCDvJdz/aGHIHulrWTQdAi9p5AwQlYBcI6zznOgzvu8K8LJouq5yjHlVGLNDqq50VkAXP1cJ5irFw5xnz9gJBwzza2vKPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771463012; c=relaxed/simple;
	bh=vsZtMHQ2ASJbwf0j2AAZePs7hvtaVUKaCCz26HKPPXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPMg9c+U4x6Wph9uZl+Wav8AxOJiLWdfssSTzrTkx24xqkLOmJA3J1iMtnEVUIMlnXX42lVr1N2OpNj8SGV4R0eBuIpUyIkFNIpO5GsYglvpyMbQWZxKgFP5pP30OLsw6TSh0bgYnkJ3jRL4eusWL3dWtH7jG3QF6kE3hPX0at4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3dhIWfC; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3dhIWfC"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c633984fbeeso632157a12.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 17:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771463010; x=1772067810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Enxu4ND3YVzsEgyqJuOJ+YNy17cYtrsF6BFeskG1YA=;
        b=X3dhIWfCI1El/GaoKZITD057z1zO3g+yu4ajIuFY+IL1Ylm1EetIB/4FaSeEANQZ6a
         Mvm2qOKRT+6Jes43vYoFlA4g5bqS8EK9c0Wg7lUO7lfhEBSY7jNoUP0zjltA91xnRhi8
         emJiIF6AExqaMuwWw/pcNCjalg75SjILQbUJXO1YZWF1jIdXM6DbazrWOzJRtGmqHqfx
         5MUky87g+tndsi8epDlhP/sE7XK8rKSTxq4nDXl6e1PEg4zjPiN9is0yZhy/rWd4wDHN
         B0k/fZ+DV1mnn38zti5vVjkuzXBvpKuZ1UAoLvdDtWfgfXpEY3lj68ykdsfBXJtG6o4z
         fiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771463010; x=1772067810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Enxu4ND3YVzsEgyqJuOJ+YNy17cYtrsF6BFeskG1YA=;
        b=u73riqsos+vkDzV3cbGul3NeGvH8WHfOhRmQR3eFtGHR57L7/VE/IFcqW63XIdmyI1
         6Z3pbPC+7ewQWHzZRbZ7EbvQG5K79DtM2y6MCHwKfdetxAPC3nsjpjzN2cgsxPLMHa5+
         1qfPqwDhhrG2WKRLm3LJDMaugKXBCXJ2Vzh2yjabUWS3XJIDtRzdOghB1rfNcva904nw
         Uq94AM10y3IPSxo4HAiK4WB4aXKCX15268oPjSo5F/Fat0J5YA7QzeZcVApMLTnGK8pp
         I2cHI7ZKw2l0tdN2SgpOdgq5vxEEXjQuLOu+euSlZuI389E00t6udl1CbdoOq+w4TUvK
         wFEw==
X-Forwarded-Encrypted: i=1; AJvYcCX/eVIQJ/bHu/hV3OInOZWmCYFBoROL0zOTzrlMUgg3ozwAWuElxYIUvakFATyDE+Ki2W7ySl4jPmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZtgB9js39MvrZmP5yFjY57Rqz0str4NBui1nv2bifvORTIkf5
	LY4qavc2aBPWQvY/lOMXhon0cYlfBBibQD5Oa5NNBFF4ihGsrSKJp/Mn
X-Gm-Gg: AZuq6aL4WNIr/mBMGjXg+4efqYPr6RinuwtkKgzO1zqByTBM+rC/817J0k8zOjH50rU
	E8b95tPoel2kPGo16rjrtZs3MUZhSIp2lYv9NqcIVAIjg1GTjXjEDCGLkMALNbqWNQm7coEbHRu
	FwnvmV176opSQFnLHA0DYD/P8rkrXsj89vt2ASDDGvWAg3rjRItMDg6HEFmI12kvHKvx7U0H//Y
	XWY9+Nk0A+jKw9MCSEpKj3yiVk+qwYBjjL+TyBC4Cgyc0da96KmuC92466fdInzsfeZDxWN0cLp
	HnrExBfxoyYAcjTNqCoMLQ98e/39f5oyyDl0Fbe9BL7rwndi7F8WNpdbxQiL6MnObMI9GkLWGw4
	4pKJMeyCeFAem8QvAq3gHjczL1KUIA2Pg+9YCgKQ7BBpSrl+uHPcEfBPkD+cjIaJPplxFwFxChe
	ESivOSl2IRO3bWKlWaJfSeE3TFkFPPfuzE9tc=
X-Received: by 2002:a17:903:2bcb:b0:2aa:e3d1:1430 with SMTP id d9443c01a7336-2ad5f970533mr763625ad.23.1771463009884;
        Wed, 18 Feb 2026 17:03:29 -0800 (PST)
Received: from arch ([2409:40c2:5404:5d47:7f61:3625:f2fb:6df4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aadca84sm144265035ad.70.2026.02.18.17.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 17:03:29 -0800 (PST)
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
Subject: [PATCH] iio:frequency:ad9523:convert symbolic permissions to octal and remove unwanted arguments in macro
Date: Thu, 19 Feb 2026 06:32:44 +0530
Message-ID: <20260219010244.191668-1-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

this fixes following warnings in checkpatch

WARNING: Argument 'x' is not used in function-like macro
WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
WARNING: Avoid multiple line dereference - prefer 'pdata->pll1_charge_pump_current_nA'
WARNING: Avoid multiple line dereference - prefer 'pdata->pll2_charge_pump_current_nA'

Signed-off-by: bhargav <rougueprince47@gmail.com>
---
 drivers/iio/frequency/ad9523.c | 38 ++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 63c485e9e44c..a445b775191b 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -167,9 +167,9 @@
 
 /* AD9523_CHANNEL_CLOCK_DIST */
 #define AD9523_CLK_DIST_DIV_PHASE(x)		(((x) & 0x3F) << 18)
-#define AD9523_CLK_DIST_DIV_PHASE_REV(x)	((ret >> 18) & 0x3F)
+#define AD9523_CLK_DIST_DIV_PHASE_REV	((ret >> 18) & 0x3F)
 #define AD9523_CLK_DIST_DIV(x)			((((x) - 1) & 0x3FF) << 8)
-#define AD9523_CLK_DIST_DIV_REV(x)		(((ret >> 8) & 0x3FF) + 1)
+#define AD9523_CLK_DIST_DIV_REV		(((ret >> 8) & 0x3FF) + 1)
 #define AD9523_CLK_DIST_INV_DIV_OUTPUT_EN	(1 << 7)
 #define AD9523_CLK_DIST_IGNORE_SYNC_EN		(1 << 6)
 #define AD9523_CLK_DIST_PWR_DOWN_EN		(1 << 5)
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
@@ -649,11 +649,11 @@ static int ad9523_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_FREQUENCY:
 		*val = st->vco_out_freq[st->vco_out_map[chan->channel]] /
-			AD9523_CLK_DIST_DIV_REV(ret);
+			AD9523_CLK_DIST_DIV_REV;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PHASE:
-		code = (AD9523_CLK_DIST_DIV_PHASE_REV(ret) * 3141592) /
-			AD9523_CLK_DIST_DIV_REV(ret);
+		code = (AD9523_CLK_DIST_DIV_PHASE_REV * 3141592) /
+			AD9523_CLK_DIST_DIV_REV;
 		*val = code / 1000000;
 		*val2 = code % 1000000;
 		return IIO_VAL_INT_PLUS_MICRO;
@@ -701,7 +701,7 @@ static int ad9523_write_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_PHASE:
 		code = val * 1000000 + val2 % 1000000;
-		tmp = (code * AD9523_CLK_DIST_DIV_REV(ret)) / 3141592;
+		tmp = (code * AD9523_CLK_DIST_DIV_REV) / 3141592;
 		tmp = clamp(tmp, 0, 63);
 		reg &= ~AD9523_CLK_DIST_DIV_PHASE(~0);
 		reg |= AD9523_CLK_DIST_DIV_PHASE(tmp);
@@ -797,8 +797,7 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	ret = ad9523_write(indio_dev, AD9523_PLL1_CHARGE_PUMP_CTRL,
-		AD9523_PLL1_CHARGE_PUMP_CURRENT_nA(pdata->
-			pll1_charge_pump_current_nA) |
+		AD9523_PLL1_CHARGE_PUMP_CURRENT_nA(pdata->pll1_charge_pump_current_nA) |
 		AD9523_PLL1_CHARGE_PUMP_MODE_NORMAL |
 		AD9523_PLL1_BACKLASH_PW_MIN);
 	if (ret < 0)
@@ -842,8 +841,7 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 	 */
 
 	ret = ad9523_write(indio_dev, AD9523_PLL2_CHARGE_PUMP,
-		AD9523_PLL2_CHARGE_PUMP_CURRENT_nA(pdata->
-			pll2_charge_pump_current_nA));
+		AD9523_PLL2_CHARGE_PUMP_CURRENT_nA(pdata->pll2_charge_pump_current_nA));
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0

