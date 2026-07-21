Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D019426D0B;
	Tue, 21 Jul 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617118; cv=none; b=E1NGByPCRuOIIzZBFB4DAfaiKIWUO0OcQZflqSM7dkt7ZvpvkTVRQnbJe8Uj94W/slPRfqgwHMCNYQotgdf+TCuAYj2h3eR8gA2Wc83SnvrWpZ9fNK2LsSNKFlSVcebaotx2mvwrDr3R/WmvZHzcsn+/licxLVY7OQEQE+FeRRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617118; c=relaxed/simple;
	bh=Vqz+nVCANrmG0nBPiQCae3LnVy/TVJREPgG7CMvvBjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaP6ZC+B/bVwG/WoBUCWkFp6WhiaZ5+w94XYZE+OlpOgelsNKsIraOTn+vfSxEfJKvgdOVuAKL4ZPHEnIfO/y5vjYRZZXmL/6FYRkddokNkIMPh3J8p2o6X3HlIo34YzidmnzkFmGzTSzrnIIUmcuUvlCdy9dB7zW2tIE4LMCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aaY55ElL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aaY55ElL"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L6w5kgD3014050, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784617086; bh=eWlRWLs1pdVm5B63t53C0fv+dfzkTbgn606FaZxMG/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aaY55ElLRQ0v2OYhFNqbDhp/D2/hhPb4kHQYwXPUlOXjXdllOXoNKoconW14u7WRa
	 omPUNkAjWKu3sIs5rSRoIs/XoPsubimD1hc0JNRGl4TOCCA66BtZD6oXuWvIJhhJnx
	 6dbMowfCZ5LlMpmuMDBW0oF7JJm7r5wIpIY7/ooyJxiUNNtW/brWfSwfBePhdTQjBU
	 w4he0ncBlBUR/jqlgxRA7vZRE++nr9Fr1M+V1ASCQaqeCXW/VsONinHDtp3rTX2LI2
	 V1MVna7Vq9w2WgJQB4Q0ca1Bv9bDK7UwXBt9wng6bNg3MoW4ngbCrPL4NRKYVsNZMU
	 8OT5ylmIrUyOw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L6w5kgD3014050
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 14:58:05 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 14:58:06 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Jul 2026 14:58:06 +0800
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
Subject: [PATCH v6 4/8] gpio: regmap: Order kernel-doc descriptions with the actual appearance
Date: Tue, 21 Jul 2026 14:57:58 +0800
Message-ID: <20260721065802.689530-5-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260721065802.689530-1-eleanor.lin@realtek.com>
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
 include/linux/gpio/regmap.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index e939709fde8d..a3ba8242c353 100644
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
+ * @reg_mask_xlate:     (Optional) Translates base address and GPIO
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

