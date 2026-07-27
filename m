Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E154377AB7
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136112; cv=none; b=nPjSfazZgHcXVxU4w4WeqdstqACOggUsj9Rof1Lb42Dc82PHC47ZmO2lVeuipZjyjglEiff+wyWOUT1XduYoA/FKf6RlvFYBD3EnHn4hNxi/ycgShowzC/DmdkzAOBGkZqrks37Tmvk8UVMQJ0pfX6vOU/zWwX/V/1AtwpLLl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136112; c=relaxed/simple;
	bh=EDN6m9UbRexYtEIt+xOtSeMajMXy63+AcyGLlLrE32o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiDIhvnilC2nlQ7cvNSVAkUii1Rcq4pPDWZuijV8m1p+HWXbiaE4Rry1e7aypVdVq62Im+OT0+9LHXau1ThgDekZ57jwXsEmv/ovaMLPZJAmy31fl2/lmXEQwz9pPN67uRt/4wVq12bIlVqZFK3WQwoKWuQxZGE9y4OaU34Nlr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7/KhlUF; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7/KhlUF"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39c94d4fdb9so25631931fa.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785136108; x=1785740908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fzkqreeHngQxOokHF4otaMSkre0ILi8PbO6vbHpwRN8=;
        b=K7/KhlUFRVBOdU97uqOQHckt/Eu1rhkqMSoSWmQDNUEKFYg93b3wyBc4oR/sKUNA3h
         leYiOiyHVhp5b/jZrIUr13W+hVycIbZAu8Uz4NcNxSO9nxQSkJoi1fdcf63mCKjXLDW4
         PanGWLy/uEeGC0XvYkc8jBSHYnkR9b1v6BZVT/ET8q34bno/Ih9WuLizcjeITUolUPnT
         wAGS/fkYO4dx2TS2djY/3M9yWV2Qej69zR58w9DjlROG24G+fKVjbitu9Ic1mB1Wy0eA
         CvjWWhxOGmqFVKIfQnnbWlm7NW8geD95EsaKcMS/VscOnZFv/cwdmBRawkDKyPuX9871
         6eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785136108; x=1785740908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzkqreeHngQxOokHF4otaMSkre0ILi8PbO6vbHpwRN8=;
        b=FHGQoOYpUIuK4QFXkpHqN4N8TulAi2FgIQ9aBdpGmXigbPg/7ro3m2D0aoiE3PuMPe
         Qjb5PqCvIW7HXym+ZKJB1gF0kY9Rh9lhCoXmj59jXdx+tqPKpPU8dlGwFaZG6snxydJg
         b2casJxBWsNt3oMlKvQH17u7l7guQYc3iMcWRhXkznZOsn8gtBGaGWLi2cDkgSKnNnOM
         zJywMSwcb+uMlWUL9sUqMGf8ds/WjJp3Hw69O33J7fy3Vn+/slLYEYXd1/tGg51lUvhR
         UvtkY5C/De77/g/mb73Iu8gwPFXFL/RA5u7mp3FTsvF9lFyh/iWukkNIAwh2Js5hj2vI
         b70w==
X-Forwarded-Encrypted: i=1; AHgh+RqEt8xXTbbtq7Z9orIElsDhoqRE7ugziQVd/o274n6aQFieRxebKpLdJWKgO1ZMg+OAxkH/dLsu2tY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7O4USwOyUb+UoA4UwCQBlQ7i/zibotqyQyzKQ3owEErkGnGU+
	ll/52x28O19tJLhphiQe7CJGsNNtXrDw7kDLyPTKMQCLCzeGM+URa9yg
X-Gm-Gg: AR+sD13qsRZvaMC+DF1qalw+g0YfpmDk6MfcKSin8nqXMrnnKBn2H2nKhIK4DF7yD+f
	WEts8LUqj5TuXuYYc1hbIWRJJSk/X1VYEE+4re/BEN2K/8hHBB+2jRtD0EN/Ft32BVcxBOdQwqC
	zu8PiJm1XCuvqUu1XGA0swa/38v2637VRYjhq4uO5giQcWg50hdk9Hcq/PknnP2Pivh+hAmHEoK
	w7giLCSlCevGTaylb8iYdTDRt+5tAzIJUU9GIAOelQG3YLYIunSm4W6pC7O3joOr4BJuvUKAdxp
	2qi7wxdVNyKU1Eckpo8L+LaRzUXdOuPBVtu9CMww4i7bgP3gWdpbDm8WQYszDs753mXPTvwGUj1
	dSN1jFUvJdlpnwNO5B4JMuE9PjAmYMEJ1vwl+ak47amzlymUQ83z+/rWfMDvpqittjo6FQFG34e
	ThAFh36waS9/NvhJI/02HyXSG9dnMLk31/pbVmKW+u4WBHD1Oh/nK0CZ9apKwE9hXetxcY1x17U
	g==
X-Received: by 2002:a2e:bc84:0:b0:39c:f58e:5c8b with SMTP id 38308e7fff4ca-39f28561e46mr12241151fa.20.1785136108252;
        Mon, 27 Jul 2026 00:08:28 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f22173825sm13461301fa.1.2026.07.27.00.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:08:27 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>,
	stable@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pressure: dps310: fix pressure result shift bit definition
Date: Mon, 27 Jul 2026 10:05:46 +0300
Message-ID: <20260727070547.649074-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DPS310_PRS_SHIFT_EN is defined as BIT(4), but P_SHIFT is bit 2 of
CFG_REG. Bit 4 is INT_PRS, which enables the pressure measurement ready
interrupt on the SDO pin.

The datasheet requires the pressure result bit-shift to be enabled when
the oversampling rate is higher than 8 times, so
dps310_set_pres_precision() sets it for oversampling ratios of 16 and
above. With the wrong definition it leaves P_SHIFT clear and toggles the
pressure ready interrupt instead, so the result register is never shifted
and the pressure values read at those oversampling ratios are wrong.

Define the bit at its documented position. Temperature is not affected,
T_SHIFT is bit 3 and DPS310_TMP_SHIFT_EN already matches it.

Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
Cc: stable@vger.kernel.org
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Found by inspection while working on FIFO support, and checked against the
DPS310 datasheet V1.1 (2019-07-11), section 8.6 "Interrupt and FIFO
configuration (CFG_REG)", where the bit table reads INT_HL, INT_FIFO,
INT_TMP, INT_PRS, T_SHIFT, P_SHIFT, FIFO_EN, SPI_MODE for bits 7 down to 0.

Not tested on hardware yet: the driver probes and reads correctly under
qemu-system-arm -M rainier-bmc, but QEMU's DPS310 model does not implement
the shift bits, so it cannot show the difference. I have a DPS310 breakout
on order and can confirm the raw pressure values at oversampling >= 16 once
it arrives, if you would rather wait for that.

 drivers/iio/pressure/dps310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 45bdb8c7670f..473973dd0694 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -50,7 +50,7 @@
 #define DPS310_CFG_REG		0x09
 #define  DPS310_INT_HL		BIT(7)
 #define  DPS310_TMP_SHIFT_EN	BIT(3)
-#define  DPS310_PRS_SHIFT_EN	BIT(4)
+#define  DPS310_PRS_SHIFT_EN	BIT(2)
 #define  DPS310_FIFO_EN		BIT(5)
 #define  DPS310_SPI_EN		BIT(6)
 #define DPS310_RESET		0x0c
-- 
2.43.0

