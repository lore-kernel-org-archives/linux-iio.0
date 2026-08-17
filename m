Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4743BADAA
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986497; cv=none; b=rpbLpRJ0S7rXkoPcNwnPhptIDCmQsBrzrOXDm4caC/WSyU8RMuGuzVjTowkFb/ob74r48vldREC9B9A23gqLFQWMpvIA0lwH5jCOdqYXzUKL294sqb5s9Fzzm6yVcV/k+wGtD8Nzvb7QL9Tu1SZXjmZNINEMQb+inTpBW7O4n+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986497; c=relaxed/simple;
	bh=NlqrtaF1jvx4fxtT+Rln6rcHZtm9m2tvcwizoBcGjAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuRwVPeK3cVoSB1vjyusSrw2QYltuzJrJOLbTqqPDYVlptSP+kqHXAbt3OTBpKtRwARJoG7cJkvJDD5AdUwf8p8VBqCcjuRppXIRyozg37y0Kzz5HIKEQLxrFDXJ30F/689cZrqU677piUt7zO6YRrAUd1eLcQ6UBRBsKFMoLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+0zKY8R; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+0zKY8R"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a12ffc112cso1050351fa.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786986494; x=1787591294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dnqUISuF1GqxCyfBU21SiazIrKDqoxo6IB2fRQd9Di0=;
        b=Y+0zKY8RnZ6dgFF4KdgKr/rQa4DpiHD+fKERC8vpJ4r3biQq3AgQRaHxocojLYmFj+
         YstU3/5JumLztO4F+Dsuez8E4BJSZfa8rcq08aYEdmQPJaA5otqzba0zfdCh/+sU267s
         XtlpQ4f7YyDRRzRRYRg+C6n61RNSzfEuuVul4FEHtj0iDq477YKfB1+4Gu+5oStD4tWK
         OJsM+VQrCOyHFkymk3baekKNg/nQyI5+ZXKBVCUPj3bDLW5a5KAtFmq74Gh8JmerPLrn
         oCUXyYE9GATRlhVr06d0M4px//GR+Nl60Ho6VtXF1mr8ALSlgW6k+NrauNtgqbLID3Ni
         I7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986494; x=1787591294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dnqUISuF1GqxCyfBU21SiazIrKDqoxo6IB2fRQd9Di0=;
        b=leo4XZxuGJnSsTxe5QX/nWW9sdtdINZEDSWgBmGlSVEycPx1bCR0tZaGW37nkV2+Su
         SJxolS76QhJe3/g4GrAHaQ1Jxiq2Ok+qqhPRzYRirtN57nS2QW8e2UfgjOSQVIYC91KC
         Y/nd4zBym5zaDiwNUXNHLVxoWScltjjzLYBXBhBuumNuBJNK6HT7BZMPwFxLzuIO0YyR
         lrqhCMPiCyViXVT+TIWq4k35KreDHy0cZ7HD5/p4RKSmVzp5+aeoVRfQ5AyOIZtdlfg3
         gz0nRmoSqYz1y6d86pcedX0iYeNzRytUkhqfXoYmUYXzH3l3vHWZWKMuvt/FjpwM0WSj
         Lf3Q==
X-Gm-Message-State: AOJu0YwSElUOwro4lMGgGXveWmnBvuOq0Gu2lm9KgWeKSTWsJXnmLC/q
	tUC3RRoLArMqx9tuajZ+tXpMWwW7y8giBF7ZqXKEmvkj8rkaW0TPQ/79
X-Gm-Gg: AR+sD10lEB5uqWbENMeicBMSE7jdeVLiitCkpSNhJeiKaRT3+oo2r4N30gk3sJ35vKQ
	kugZ4yyxl7M2CTRRjytvLWNMI7As9EPb8LrCjc0BnfKRxjucmBep9neRj2LBu+kP2PYneitg94K
	vjjl90LrkjO8vU+2p/PToJKxooj6jULLBZ7KzW8U0uAdqsSHEXjYWhf8om0/qd+kH6sYbQStsnw
	bbLxlb6ijIzveCpA5+dqzjm4Q+vQnMyKwB6xCtn2kYQuT2C3ATD3S/oUbhbyZcsD34W1vP8KtER
	t8voX31DOiCf5cte+Ej3KGpKGYqHTExCIn13uCvS57I43TqlMLYYN5bdfxNez5uYhDGRy5dGcnv
	XAqNtuAcA/XbLG3GEX6mnIvnyOC+2uHEZ9RN8vW155aR2p5chiA6PtjSjW5gQXuiq64uZF+Ald6
	9Bis5bIqzftYcA0FC10CNmAa46KGYNTx8EpVhWgaiMpd27p+CFSR7ApKnEAuisafnO0nUVPQFJ/
	ehGY/dVIn7mDXnlA0U5LFEfcYKyHkW1M+leoq2m+Gjm1tZ1g2CHtlvDIuXls+vDHu1orQ==
X-Received: by 2002:a05:651c:a210:10b0:39f:af21:75b0 with SMTP id 38308e7fff4ca-3a176a18d7amr746881fa.8.1786986493427;
        Mon, 17 Aug 2026 10:08:13 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b0e54casm6053841fa.15.2026.08.17.10.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:08:12 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/3] iio: pressure: dps310: fix CFG_REG bit definitions
Date: Mon, 17 Aug 2026 20:07:23 +0300
Message-ID: <20260817170725.1074078-2-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817170725.1074078-1-zoone.rupert@gmail.com>
References: <20260817170725.1074078-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three of the CFG_REG bit defines do not match the datasheet. P_SHIFT is
bit 2, FIFO_EN is bit 1 and SPI_MODE is bit 0, but the driver defines them
as BIT(4), BIT(5) and BIT(6). Those three positions are INT_PRS, INT_TMP
and INT_FIFO, the measurement ready and FIFO full interrupt enables for the
SDO pin. All three have had the wrong value since the driver was added,
when only the temperature shift bit had a user.

DPS310_PRS_SHIFT_EN got its first user when pressure support was added, and
there it is a real bug. The datasheet requires the pressure result
bit-shift to be enabled when the oversampling rate is higher than 8 times,
so dps310_set_pres_precision() sets it for oversampling ratios of 16 and
above. With the wrong definition it leaves P_SHIFT clear and toggles the
pressure ready interrupt instead. The result register is then never
shifted, so it no longer matches the scale factor the compensation divides
by. On a DPS310 breakout, reading in_pressure_input at oversampling 16, 32
and 64 returns -ERANGE, because dps310_calculate_pressure() ends up
negative. Oversampling 128 was not observed to be affected.

DPS310_FIFO_EN and DPS310_SPI_EN still have no users, so correcting them
changes nothing on its own, but the FIFO enable is needed by the hardware
FIFO support later in this series.

Temperature is not affected, T_SHIFT is bit 3 and DPS310_TMP_SHIFT_EN
already matches it.

Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
Cc: stable@vger.kernel.org
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index f45af72a0554..68382960382f 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -50,9 +50,9 @@
 #define DPS310_CFG_REG		0x09
 #define  DPS310_INT_HL		BIT(7)
 #define  DPS310_TMP_SHIFT_EN	BIT(3)
-#define  DPS310_PRS_SHIFT_EN	BIT(4)
-#define  DPS310_FIFO_EN		BIT(5)
-#define  DPS310_SPI_EN		BIT(6)
+#define  DPS310_PRS_SHIFT_EN	BIT(2)
+#define  DPS310_FIFO_EN		BIT(1)
+#define  DPS310_SPI_EN		BIT(0)
 #define DPS310_RESET		0x0c
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
-- 
2.43.0

