Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222722370A
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502677; cv=none; b=J+Dwg8NaGHN97VEPIBcKkSHcrF6XlHLwE4/wV8h93v/UScS/HvVLvFsVUZP+lcygH+7juetDl8cFLhvI49muqpUa0qLPLQYSe3WRrrYVgVkY/RK1TM0TakpQUMVVQmP3MozBP7sy5nBFpOKIccuj6i51vxLwJ61q8AgCgRtxuvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502677; c=relaxed/simple;
	bh=nSOPhqcT/NAtbaBhrBUQ5V69ZCNX7h1OIMNZ6hOhjFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFNZMOMkbanyWCmKDwM8SY/zsOfjbuaWOQDYYbvdR9OQcsYoiHpoAEdAUhTt8Wxo48RHTMuXaIkCG6d5ntMv9uMLiCHkakTYuUebh77g3UM5qrTjysyZcl6XfecFIQVjue92WFPczdEeDszrW1EcaeCBGIuN3xy5zUtN+mVpHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=nP/o+dU1; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="nP/o+dU1"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso372461eec.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 15:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777502674; x=1778107474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lo5IRhJ5rjXDPV0VxmReQK3RRuofi/KlxxkwHg6k/Is=;
        b=nP/o+dU16Yo3D4vTL8wxu9EACD/AYObNvH+pXn3XvIeomZb7ONa5YkhVjjR2fealFq
         9Kh9RbDsjXOzl+RdRGLEMZy6a7F9w0L86Yh6YECrFy+S4iayB+99Ua4/Wzpj/Dl6PxhT
         l5GS5rxdkcGfm6A7HKUDIa9nCGTZLjwHsCvNY5j9hXPxbqIO1srDXbCPhka63MUQCbJ4
         VB3fk9zSxs/Q3vQRgbti5c5mpdKwQVgDPOvSlJQmjIratDTNJGtcNspATwotvvlGQm27
         JoKdwawAe5ZhO/5QTXQ7a8INlfxPQsvA222uPSIr38Xq+qqsNjKqdIZgOgrhhrUHrTLp
         50QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777502674; x=1778107474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lo5IRhJ5rjXDPV0VxmReQK3RRuofi/KlxxkwHg6k/Is=;
        b=c9ap4Ep1YDqr+dBgHx8fQ/vKu6gCSm6SzfWlpNv0MCLYEH+czp8WhIw2uGkJ+6W8oR
         g9X7iiOXXMH/XFr8acNysQB7oTUQ/X4dIGc3ZvhhNa2VTpAa3HDdzKy6lFU8VhphiGxL
         oDEmVl/6/o2qmU0U+EQTn3PLAt0+Ha5kDe+jQ7TUBIv3JCQ1q/WongGJF4bJt6QHm4xf
         vap8uuUYxNF2M4/CcgorCmIErRs4FM69XzPfww8OZ5JCBPzsHugpMfeh8NRcbaMy17z3
         QWQIlhpew64JiROaattSXuBpFlWp0tEpSwoBJgfhdgEvBVoloEFRL2w8XXj7HjDJqYKd
         O3qA==
X-Forwarded-Encrypted: i=1; AFNElJ/mG9InnLsgJqFsJQCooiKsNPlPsxgwy7Eq7e1ISNgbCMxIUdZ3F8R1Cx4+i5P9hpyIz+rj+cHenBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59Dm63Sv0AJU2wCDfiLXXy4kFlhYpaAxvmvMTD2fcpKRbVmGw
	zM64yMhFGfHiUwBLKsyV6fpF5Y+yixLA6jqdwwqJIsSwiQrRANtiambp5Gn49QKgVEI=
X-Gm-Gg: AeBDievVSpcTCqrjHM/uEDunot8NEox9/CegDF7Wgq7EQJ8+gCJ8Qf7G3QRbKN+WnCk
	/CmAzIgAukrdbt+blMHEPYhyxQIGKfVOomD6yCaF+vmWwr0KjE4iYvhYO9RCbfFAhN/00wu82xt
	AlEVQYqtspoDHgryh5Lz9/6gJxEJjU7x9u3uwBeamOuwzJUTzoj5bvofYFXyHvZkwiCVZX9QJ1F
	eRsWkh8buRzKYjRqQtSm1dEmr26VpUQPoD4Lt0d/wr252vSwVMnPlFl9Y+ZFM8d1eiV1l8wYYk1
	ChVFA/W/vikzuYUknQP3he6jZWQfC98sIJMy/66ZWMn66xDduinH1ME0vYHkKmBB40qdwya47cf
	9ZfM+0ZBZlMBQ378huZ+mqecKBkiq8i7OOONepT8Z8eRN60diTUn7LJiLqVAGyXUPBV45JtuVq2
	5O8HG4Nx1wVUoGzh6hHamyxdwmDS125ctsn0YV2EklsSvrY0kQt1nLaybOykZO
X-Received: by 2002:a05:7300:4341:b0:2da:d4b4:c85a with SMTP id 5a478bee46e88-2ed3d8b85a3mr98277eec.11.1777502673741;
        Wed, 29 Apr 2026 15:44:33 -0700 (PDT)
Received: from avocado.. (mvx-177-92-77-170.mundivox.com. [177.92.77.170])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf6d263sm4238222eec.5.2026.04.29.15.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:44:33 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	Vinicius Lira <vinilira@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 1/2] iio: adc: mcp3422: rewrite mask macros with help of bits.h APIs
Date: Wed, 29 Apr 2026 19:44:00 -0300
Message-Id: <20260429224401.11818-2-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429224401.11818-1-marcelomlage@usp.br>
References: <20260429224401.11818-1-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite MCP3422_CHANNEL_MASK, MCP3422_SRATE_MASK, MCP3422_PGA_MASK
and MCP3422_CONT_SAMPLING using GENMASK() and BIT() macros from
bits.h.

The other macros MCP3422_SRATE_{240, 60, 15, 3} were not changed
because they are also used as array indices.

Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
Co-developed-by: Vinicius Lira <vinilira@usp.br>
Signed-off-by: Vinicius Lira <vinilira@usp.br>
---

v1 -> v2:
 - Split this change from the rest of the patch, following a request by Andy Shevchenko
v2 -> v3:
 - Sort marks in logical order, following a request by David Lechner
 - Delete the "/* Masks */" comment to avoid confusion, following a request by Jonathan Cameron
v3 -> v4:
 - Correct a typo in the commit message, following a request by Jonathan Cameron
 - Rephrase the Subject, following a request by Andy Shevchenko

v1: https://lore.kernel.org/linux-iio/20260417005041.484742-1-marcelomlage@usp.br/
v2: https://lore.kernel.org/linux-iio/20260417165747.507487-1-marcelomlage@usp.br/
v3: https://lore.kernel.org/linux-iio/20260420191455.529923-1-marcelomlage@usp.br/

 drivers/iio/adc/mcp3422.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 50834fdcf738..0cd0e7d39e39 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -13,6 +13,7 @@
  * voltage unit is nV.
  */
 
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -24,10 +25,10 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-/* Masks */
-#define MCP3422_CHANNEL_MASK	0x60
-#define MCP3422_PGA_MASK	0x03
-#define MCP3422_SRATE_MASK	0x0C
+#define MCP3422_CHANNEL_MASK	GENMASK(6, 5)
+#define MCP3422_SRATE_MASK	GENMASK(3, 2)
+#define MCP3422_PGA_MASK	GENMASK(1, 0)
+
 #define MCP3422_SRATE_240	0x0
 #define MCP3422_SRATE_60	0x1
 #define MCP3422_SRATE_15	0x2
@@ -36,7 +37,7 @@
 #define MCP3422_PGA_2	1
 #define MCP3422_PGA_4	2
 #define MCP3422_PGA_8	3
-#define MCP3422_CONT_SAMPLING	0x10
+#define MCP3422_CONT_SAMPLING	BIT(4)
 
 #define MCP3422_CHANNEL(config)	(((config) & MCP3422_CHANNEL_MASK) >> 5)
 #define MCP3422_PGA(config)	((config) & MCP3422_PGA_MASK)
-- 
2.34.1

