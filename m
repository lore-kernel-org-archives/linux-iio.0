Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D62F90E0;
	Wed, 19 Aug 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143288; cv=none; b=qO5SAv+cDfKO0UfkB9t7/ZU7iDqETu9RtBTc/sf0QKay/g5RUa8jCi9vcyaWIP3448Qc0ibYCc3otXv3A1Nhkcop7ra6D8O/wVmJ69OpZXbCOIW+2H+YpzSrICJdCcTL48YTJKpmuPHn9HvcOqRBearzfk+4fXXPao/YOmOGyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143288; c=relaxed/simple;
	bh=ULNX7XM/q3FMWCn7ukWYvqZEtM157eNtTtwlUSxrvxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t96vlWVts2n42T5SRAdLbq0Bt0gQ03mpjpRHHQ5kfBCI5LD1c0+hBD3dYrzvic4KLVkP5XKIzctfCcElD5LOeUQGzuYiiInjnL5kdZqAUvAoIWtai37k9Fba11NjnGpHlluvUJiQGmwyiYu2pLIHmDMx+pzA2O63aE2YyA9bjrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2rzcjv8F; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2rzcjv8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787143286; x=1818679286;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ULNX7XM/q3FMWCn7ukWYvqZEtM157eNtTtwlUSxrvxI=;
  b=2rzcjv8Fr/pE6fUWcIhGEDzVc53ghBx/myKeTwafelOmqafUx/oSZZHV
   Gbs8fiB/1aSOG7+Lh21ClN4EgOpYcfUgoeTDlg4MMMAjGci2zvdJEqFnq
   bYUgm3jDQVdGOVziTx5mUVsFkUEHpODtTMAAl+WH6lK5vbUvF1zr5fmEh
   GB6pXslnPkELal3f8A2j93o99ZBFE6/DIxMK9fRe0HL/DBFGl1neDepNq
   aWQPA0y9vqfKC6DmJ4nVyL4sDhg0ibImQbTddJ4wBrjtM+Wg8QCz2fMv+
   oUzg0cphL6YD8Hjs9yMoak2VuyeDBNUEzHTk2cIG0VkHcB9ljEk39U2iz
   A==;
X-CSE-ConnectionGUID: +loxUlRoS2SA2BHce8XrXQ==
X-CSE-MsgGUID: aLr1patSRT6jypUJtMGiKQ==
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="61462191"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 05:41:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 19 Aug 2026 05:41:26 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 19 Aug 2026 05:41:23 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 19 Aug 2026 15:41:09 +0300
Subject: [PATCH v4 5/9] iio: dac: mcp47feb02: correct typo from a comment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260819-mcp47feb02_refactor-v4-5-beb2aa3bfd09@microchip.com>
References: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
In-Reply-To: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787143269; l=876;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=ULNX7XM/q3FMWCn7ukWYvqZEtM157eNtTtwlUSxrvxI=;
 b=HMI0ZBkt4MTxsgWnvCSKl0qD1Sg7n6MXSt/87gqtXQFY5ucchYXPNIWPkNqrHLSf4/v8gA4HR
 3utPZwJn30uDTXg9D86YR6vFyzhNdcE5nTCCBnWX7c++X//d67GG24N
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Typo corrected to 'Register' in the comment regarding defined masks for the
gain register.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index e5533fa3c31c0006d170764791177879c1e794b0..6f084eb71240b475bf85763139ecfafc006da83d 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -54,7 +54,7 @@
 #define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
 #define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
 
-/* Gain Control and I2C Slave Address Reguster fields */
+/* Gain Control and I2C Slave Address Register fields */
 #define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
 #define DAC_GAIN_VAL(ch, val)				((val) << (8 + (ch)))
 

-- 
2.43.0

