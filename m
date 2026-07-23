Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86F34DB41;
	Thu, 23 Jul 2026 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778207; cv=none; b=bnwS2E8FnkTre0DjyGUhlDXGTeT37hPpTAzRL/qAkJ4zfj1/uCdn5grq954A9hMFyv4/ac7PchUqQI5H9co8EkyQF8Ui8wVyR4NPZEA2sZruiftiMWLypg4262qXt2+i3rql9lKJhhd06LNsXZhqHeP29Xvis9A3Fm/8yOZT+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778207; c=relaxed/simple;
	bh=jxTtmT0MyaiHNlcNTGezbFY8S/0k2yAaWGDNXOYaD84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKL4ndszuKOQ98jt2obt/XgzaaQ0tm/yOXaufxXZaFCRdNZZD3Bk7Ko7K2KXwHhn4H4N9I5dbz8CIQeljHdH/fzGwn7VlxnkHAuzKrUZbr8taDB+YUe1qBRbBo7RCn/lBCD+7+cee0dA1psJpjkhLD8vHqc/mOs9abZhKda2b9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TMusY7tn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TMusY7tn"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66N3h0L91179581, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784778181; bh=4J7kE3uhf8ifNvTJgZrsy1K3BpfHx2FxL1nQhdFEz/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TMusY7tnszYANaST73kSjLYtqpCl5E+KG0zosato86O019SSyytXAUX/HwydDTpID
	 Mj6OREJuadO60Z23fBGuWwR60u8UrWfgMTYzNIl9u6L968Z9XpvoHRi5fVipt1GlTm
	 pWooWQ/zG2/zfAqWXJO5s0MLwRlGmEA361VaUJz416Tt7e38IGpJz4mvSKyM6Eh0Fs
	 srqEKStxCeUnI+eLn6xpR12+yXSpmgzcNi3kTLC9qeEu/ZiXNbiQ/eurnt7/8HYwfI
	 xjwANtGq+YsVi5FpIx3l+QylGAfvZ3NE4FbzyW0vDxfDBAvHFUYROAmINqppUOqJU6
	 eymcKNnu6bUfw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66N3h0L91179581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 11:43:00 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 11:43:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 11:42:39 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Jul 2026 11:42:39 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <linusw@kernel.org>, <andriy.shevchenko@intel.com>, <mwalle@kernel.org>,
	<brgl@kernel.org>, <tychang@realtek.com>, <wbg@kernel.org>,
	<mathieu.dubois-briand@bootlin.com>, <nuno.sa@analog.com>,
	<Michael.Hennerich@analog.com>, <jic23@kernel.org>, <andy@kernel.org>,
	<u.kleine-koenig@baylibre.com>, <dakr@kernel.org>, <bhelgaas@google.com>,
	<o-takashi@sakamocchi.jp>
CC: <eleanor.lin@realtek.com>, <dlechner@baylibre.com>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux@analog.com>, <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
	<james.tai@realtek.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v7 4/9] gpio: regmap: Order kernel-doc descriptions with the actual appearance
Date: Thu, 23 Jul 2026 11:42:21 +0800
Message-ID: <20260723034237.2501507-5-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260723034237.2501507-1-eleanor.lin@realtek.com>
References: <20260723034237.2501507-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Order kernel-doc descriptions with the actual appearance.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v7:
- Add Reviewed-by tag from Michael.
- Fix indentation by replacing spaces with a tab.
---
 include/linux/gpio/regmap.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index e939709fde8d..eb3931fbbad0 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -34,10 +34,6 @@ struct regmap;
  * @ngpio_per_reg:	(Optional) Number of GPIOs per register
  * @irq_domain:		(Optional) IRQ domain if the controller is
  *			interrupt-capable
- * @reg_mask_xlate:     (Optional) Translates base address and GPIO
- *			offset to a register/bitmask pair. If not
- *			given the default gpio_regmap_simple_xlate()
- *			is used.
  * @fixed_direction_mask:
  *			(Optional) Bitmap representing the GPIO lines that
  *			make use of the @fixed_direction_output list to
@@ -48,16 +44,20 @@ struct regmap;
  *			(Optional) Bitmap representing the fixed direction of
  *			the GPIO lines. Useful when there are GPIO lines with a
  *			fixed direction mixed together in the same register.
- * @drvdata:		(Optional) Pointer to driver specific data which is
- *			not used by gpio-remap but is provided "as is" to the
- *			driver callback(s).
- * @init_valid_mask:	(Optional) Routine to initialize @valid_mask, to be used
- *			if not all GPIOs are valid.
  * @regmap_irq_chip:	(Optional) Pointer on an regmap_irq_chip structure. If
  *			set, a regmap-irq device will be created and the IRQ
  *			domain will be set accordingly.
  * @regmap_irq_line:	(Optional) The IRQ the device uses to signal interrupts.
  * @regmap_irq_flags:	(Optional) The IRQF_ flags to use for the interrupt.
+ * @reg_mask_xlate:	(Optional) Translates base address and GPIO
+ *			offset to a register/bitmask pair. If not
+ *			given the default gpio_regmap_simple_xlate()
+ *			is used.
+ * @init_valid_mask:	(Optional) Routine to initialize @valid_mask, to be used
+ *			if not all GPIOs are valid.
+ * @drvdata:		(Optional) Pointer to driver specific data which is
+ *			not used by gpio-remap but is provided "as is" to the
+ *			driver callback(s).
  *
  * The ->reg_mask_xlate translates a given base address and GPIO offset to
  * register and mask pair. The base address is one of the given register
-- 
2.43.0

