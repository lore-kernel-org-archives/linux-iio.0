Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744C3C277C
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965037; cv=none; b=JV50qUPiSXHCsPbct0Lv8peqf9xzmuk+IQRFmi+zgK3VynB8JrP/847PLBJ3RdEtdrQEs3fO8jOrxlzbxik8UOwiWNxVehJtL5+zic/7tHuPraHEHAx6eLV0qEXtuscQFW5QPNulE2ZIDVUqFs1lUwTZAFGaOmBLcimgZ7eMoRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965037; c=relaxed/simple;
	bh=IT40sORbf0ZQQhp9CFs1timHqHBAoiaj31IxLF3hF5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rll0lCMqr2QZybJftWVlak+qLa4Col5PYfaNeICgnjx+8J11D/FdiEw8tWAX/cK38Qjtoax41MWxHyTjQ6sR4rkqbFBUucvdMIN3C/4yMabSB83wbX1LyN9K5Z/UWscl3USl7zxpzE25jLMEAGk0UH9b8SlnTTefwbfyUMzhRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElmXZTX1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElmXZTX1"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so9706129a12.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 00:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965035; x=1778569835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b+pn5g5M036sGAJchvhAuWuNpnA6lbM70mHBhN/MonA=;
        b=ElmXZTX12A9emKddd4W7qM4/1HpGaS65aSIt1QVjZH7vRS073lZTCKs7y7UsUfEQjt
         ifX8YDqzdt8jbWQLUUObNPWCozJwqlNalR/DqBW12kxXuoy3PIt9f3Cw4Cuw8IXz3EeY
         rI4BSeqR9QlvH9nRafrHffhHSjcHfZFG0vSAr0Hrfi/juFwgNCrxzUFK0af+STtOYAX0
         yGICN+X66Y3PdG70oBa7yfzBzIAHyXj/+WOQsp84RPvpkHWbmzGWCGfnyr6Y31dlXj9y
         Mvk0R2Hq8xpWUg3cxnoQVN0JvIenstvP5Dz41Uafz17LXLnEDU5XvPBXyu0qXZPb/dPc
         nxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965035; x=1778569835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+pn5g5M036sGAJchvhAuWuNpnA6lbM70mHBhN/MonA=;
        b=ifhZbLu5468MwVdeYDhljh6s5bkDxOMVAyynIr0L0h2bNT87makZjFX/NCxR5JZKIv
         QTIZtqgKrS6HIK/bRWVkze6InHcnROgo/ww6SMr7OayDnVABMSLEEZsowD57Yo4KwpNV
         db9OMdxhYf3c3j17KSX4DwSFCgQd/mbfS4jAWvIKCfoi34+HWew22wRAe/eje00sXBnu
         2y3u3RoZLECC41yNH/52QnIZVevIgrsyMNVwNwtnAdwMoUP42PdSX/bo3S4/g9EnB7Vf
         oS4BPV1zrydZFr4sojOA64kQj10XS6QiljUQN6qLYoMw+DHkhb2GP/VMK+qjdg7G4uYJ
         wCIg==
X-Gm-Message-State: AOJu0YzxLcyXRFQk4WF1XtWDk7oBsxOTFxTfPFsrG3P+sfb39TEYLEHg
	LsqPiud8Gmo1Bg7tCnAPIn1P4uTy8DXUWcr7vEA4eTMWYX+bNNL6GIkO
X-Gm-Gg: AeBDietvN1r9bcoUurREplMCKaS6mXuthemb6gkuLlfMGiyFvh1Gx2gsw21NtNmABR/
	a9sohmKvCUWSUGjmA4OMn4DH6QPwEWVlgK7IJEm1/kg1Dv8NvjfYLcqAoJ7xKxu1vJbOXQkByGx
	qICCjdhHdWV504sP/g1svr8CoLeeXSck51zIIxoNuQezWB+E2hrhOPH4IpYA779lOEncFeDMvys
	knKhggoM/tldQaDKW8MM2CYKd5QrsaXVivh8hRElsJjEZjVf+SK6exElR6ip6pLW99z29ivrbfb
	Ao7R7n6xwnyAEYYVXh1K79zfqObrCfF878FXNcidzFEdTdbXN1v6aW2CetaLWxAbc+GNPRmsriu
	OrwAB7wMEdzEzH+krS54Y0dxFIw6rh7TqnwS1VP9hdrAAO5T7/NRaa+CABNbpGn5gm2+6rT3lUp
	qx0l9NdHJBEYrEDU03ycldNrUQj3Sw7wEPyqHkoZiolDMOmGHh
X-Received: by 2002:a17:906:9f87:b0:ba7:cc67:488b with SMTP id a640c23a62f3a-bbffab33111mr713406566b.5.1777965034265;
        Tue, 05 May 2026 00:10:34 -0700 (PDT)
Received: from localhost.localdomain ([196.235.252.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc13421bfe3sm254129966b.56.2026.05.05.00.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:10:33 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] iio: temperature: tsys01: fix broken PROM checksum validation
Date: Tue,  5 May 2026 08:10:24 +0100
Message-ID: <20260505071025.69221-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of tsys01_crc_valid() incorrectly sums the
first word (n_prom[0]) repeatedly instead of iterating over the 8 words
retrieved from the PROM. This leads to a checksum mismatch and probe
failure on hardware.

According to the TSYS01 datasheet, the PROM consists of 8 words. A valid
check must iterate through all 8 words to verify the integrity of the
calibration data. The current driver only checks the first word 8 times.

Note: This fix was identified during a code audit and is based on
datasheet specifications. It has not been tested on real hardware.

Fixes: 43e53407f680 ("Add tsys01 meas-spec driver support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
   - Update commit message to clarify that the fix is based on the
     datasheet analysis.
   - Add a note mentioning that it has not been tested on real hardware.

 drivers/iio/temperature/tsys01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 334bba6fdae6..104dd45598b0 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -119,7 +119,7 @@ static bool tsys01_crc_valid(u16 *n_prom)
 	u8 sum = 0;
 
 	for (cnt = 0; cnt < TSYS01_PROM_WORDS_NB; cnt++)
-		sum += ((n_prom[0] >> 8) + (n_prom[0] & 0xFF));
+		sum += ((n_prom[cnt] >> 8) + (n_prom[cnt] & 0xFF));
 
 	return (sum == 0);
 }
-- 
2.43.0

