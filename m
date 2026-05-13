Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AECA3E9C1F
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663694; cv=none; b=b7BqmjdasJh5JGsCK+5E+V3uYbk+ao6snOp0Gmd0jpUmCxsq8TDjkbThgMHFsD1QThdqrxuKLJ4pFTQDFjUOXeCjasMl3WJ6BnBhEf/iqngMlhpnFCQ4jSgJQuMvtZJdtgJVkfMeZPDRRJsJjbh612I47Xg43bTakSEWWITokAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663694; c=relaxed/simple;
	bh=PhOGHoqIR+95vDa+GqpGQ1+YUZVXpYd7uC8GldUe3mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0TficMmjxgpWuDcvGQ92WIC+it62P9ksbAE/qSX59vuVhsQYXG4lUM79yEoFcqudvkFebiYlGYpZtwFOiGFnqRaEEdOEkOVIMThnFwO+1dn2rmEhhvmmZppTdHgY20K7tzvE1o6B5f4LK8cE3mC+bDItgWZP2ZG0OjP97oHJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=eMrwCOis; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="eMrwCOis"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so4810005f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778663690; x=1779268490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+hb+If9DDOuBqGG4gKbfaGWqC3O5Z3rJt8yF28vSsQ=;
        b=eMrwCOisZzx8CbMd3hpiPc5NIXJcB2QZF8e5OB0p9pAHmHqK+vVmFzhcWDOlSastlw
         eP5Nb+iaLD7EcAsr8NBTqpPxCetwZnJIt7hhqD0wXlERN7xLqVwwGeZdb84qFTXlfODp
         7CZLnjPhADc8b/NZ4xNwkNu81ps7FLG0iOfpyhC/HZW9o7di1NsBU5Mi6hxk2W1XDcMO
         U+HRHp90hJNIW5Hp57FPwKush9LhPP0Dd6JZutDoui3MCcJlPgZFIZcR2mv+EcMMnybi
         jEVi/NjeA8nxS0GaLJxdEyVtAhttx+qOZtLNPVuZa3M7DJu3n9l1IQlx/LKhah7f10CO
         bdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663690; x=1779268490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J+hb+If9DDOuBqGG4gKbfaGWqC3O5Z3rJt8yF28vSsQ=;
        b=hM/fNAv1l7Rm9ExMuToryLx2AnXZVXP9od4Y+QQPbU5rMrMn1d759Gw5LKdQAEvkYX
         Y7pmnv7xSbnoEy0WYxV+nZksOCnA66TFAloAbg1NByi0RpoUtNM+nleBgGtQYxuVBBsD
         LvgCv/sGGFy/A86vjWbaeQknoNhuW2CWzVXBzk20GCeaEaAPIw/bhanopP2DkRNfObdG
         glF74Z7Tw9a+pl4NFMadndJ+AmKAPljMUOAf/Yrb7s3Mq0vOOcNPaqlb5BOjh4a9gIBP
         cp5uMDVJTjjdyJEktvvMvTnIFMmPmYLzVEIdlrSi16YmowXW1ow816fCP9F0/BvlrkBw
         xqIA==
X-Forwarded-Encrypted: i=1; AFNElJ+mLvP+mirR1MTAU+h/1mYKuh3YJhAHrXowq4qKSfOdL9V40AddBj6WnMlb7nYpgvOHWlZER01Lyhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVuY+n7kMBmzuD5a3yqjv5VgN84oUxJtrbXGO5gICc+LkCjkC7
	ZwUv+9M/O+QAEiGnKvG92tTl5yetQXNeDNIyu5S5afx5Wlw1johF4Mkan7tmoKylKZU=
X-Gm-Gg: Acq92OG088Pw2pjom+8leB+xO3yQnCE6z5j3m6/qHCp5v9my9gIdoyC9MbFXU517xwg
	/ad+XYDcn7iPKoDvK84Wy4raDvYnJhyLH/YdXMzrIZuPkopKX1Tl7CccOJdCMZQEwX9Kn0/vScg
	y6J9V5/Msat1sXt3HH5oKaMH0gkIwQMgtDy0XC/qKNIugy7ElZOY2F9+NawFqXIfRSgBB9ypTSG
	hEjFC6CQcCe68lTu299OYzjFW644eoKiAbiRftPpxYvPAUo2e3zExWICU0QLvKLMS6djJxQihl7
	HkTp0L6BcjaY9ih29cVztDH/BX7KCYPesusriudfuRAYbk0VNzA6L4DqOhEvFgqSapNzHrndBNY
	m7kyH5ufLCGL/KNRe91mEJ9LlR307Gbxv3M1HnkJNWtxfLRgDzAGTFgcYulvrcWpSdHA510gMue
	/GWBoP6Cd5JTeCxxELENV34FAh9xbp/os=
X-Received: by 2002:a05:6000:26cf:b0:451:259d:83fc with SMTP id ffacd0b85a97d-45c4683b616mr4191754f8f.17.1778663690514;
        Wed, 13 May 2026 02:14:50 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm34590821f8f.4.2026.05.13.02.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:14:50 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 13 May 2026 11:14:34 +0200
Subject: [PATCH v2 10/11] m68k: stmark2: enable DACs outputs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-stmark2-dac-v2-10-fcdae50cf51a@baylibre.com>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
In-Reply-To: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

From: Angelo Dureghello <adureghello@baylibre.com>

Enabled DAC0 and DAC1 outpus disabling shared ADC inputs on ADC3 and ADC7.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- using mcf_read16/mcf_write16
- remove unuseful comment
---
 arch/m68k/coldfire/stmark2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
index a5b36af8e70a..a82e1b286770 100644
--- a/arch/m68k/coldfire/stmark2.c
+++ b/arch/m68k/coldfire/stmark2.c
@@ -117,6 +117,8 @@ static struct platform_device *stmark2_devices[] __initdata = {
  */
 static int __init init_stmark2(void)
 {
+	u16 val;
+
 	/* DSPI0, all pins as DSPI, and using CS1 */
 	mcf_write8(0x80, MCFGPIO_PAR_DSPIOWL);
 	mcf_write8(0xfc, MCFGPIO_PAR_DSPIOWH);
@@ -129,6 +131,11 @@ static int __init init_stmark2(void)
 	/* CAN pads */
 	mcf_write8(0x50, MCFGPIO_PAR_CANI2C);
 
+	val = mcf_read16(MCF_CCM_MISCCR2);
+	val &= ~(MCF_CCM_MISCCR2_ADC3_EN | MCF_CCM_MISCCR2_ADC7_EN);
+	val |= MCF_CCM_MISCCR2_DAC0_SEL | MCF_CCM_MISCCR2_DAC1_SEL;
+	mcf_write16(val, MCF_CCM_MISCCR2);
+
 	platform_add_devices(stmark2_devices, ARRAY_SIZE(stmark2_devices));
 
 	spi_register_board_info(stmark2_board_info,

-- 
2.54.0

