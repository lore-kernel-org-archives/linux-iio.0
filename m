Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EE31E832
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773602545; cv=none; b=pUDZPwGEFTKXLuJleq10QMM8xZSRGIgZYukSTdkb2Kx0ljtZJQaCAVtgLONHsYbymHB5aE8HZrUkk98KlLvc1J4PcwYXZ85N0vShmSFwqBMZQg+0Uk5lkOHdeo7tRSszqHchVWUX+Z31DCZy66SJZ5QJoTrDhNDI2WANcf2EZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773602545; c=relaxed/simple;
	bh=bfXyebqUVv+iZhbMKZokBlBxZwMEXvGPTmEwhUEkqxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jq6cv05V8PepPU1zALvRudts+cTwR7DTt2QXZ16JICYriUEJo65BmJkCKHXECkSzwPzkHzrWjdXEYhcUOqHPFpUrQS6tuBnq9ITAEy5tngmXaVFgZoi4EXOt5m8xn2ibNYm39mn1PZYoxXyc2j9iDeQuylbEWUxDq1gZxRrlys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BNXFrTe7; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BNXFrTe7"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-673ee2a98b1so2117635eaf.0
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773602541; x=1774207341; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVeBequuB1u10c4ABThk7aLTo8FvsspgZZZO3pQgd1s=;
        b=BNXFrTe7e/leetKsyOiGskMwn2QakdSRZBq2uaFUODD9r7vvdB47vgmYPRd51kdLGX
         qw91uzYYc3jCRKLMlRyzfydUNg9qRrifucfRdJfGaMuBM87UOBCq4sIe6rnT8E099Lyx
         WV1uIQkTelcWyC89ZpuolqWTlz84HN5gylV2QnURY86NNau27vEq1fgK2/EURHA3UT0a
         JsaMlOzVa2y20J3FLojqD2/6RRQEQp+ERL3MVHdMq2IW1yIL8/qbbeKlQGgvDDobh8rI
         aXvyCrupkbobf4e2/d2Qg7bx9ERJrwVELRxBp+dfmHHfEE46Ah9kcfhOLdhENutVh3ax
         MPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773602541; x=1774207341;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVeBequuB1u10c4ABThk7aLTo8FvsspgZZZO3pQgd1s=;
        b=lIbEtae+PF6cl9GKtybsFVSqAHZEitPn4ObaDVHGQ0e+CMMrOKKfNkHD8gD1n7fP1X
         r5uXJwWW4hkM6x+6yL4GJv/ZQK8lQoVhMH0yKZ6X1R5ETWxAnN/6s3WOWS3ntEAsrcBs
         yFWCrUaJPs+eBDISEVMMYp1pHDprxeffQvLR/XztFCluqWnlhWY/zSFA+TVDzlDMG6Gq
         9UHqwGurGCCmEiCTdRhY4TBes+pQssE663ASReACWidOcLxijmE/x7qdsRyLkUsOO7DY
         tPJiQlwPiV5HtvI9x6E6b+kC4LI8ynGmsVQ25/rJJmjzmmauU2Wbk+QeH6RNmCAOnZxC
         GV0Q==
X-Gm-Message-State: AOJu0YxRGF6U4Xyw+2U+WhvN6i5LQ4e8pezkNPzzzva4ox9gf3xJg1Co
	kHanURL2VjoNVA+8Yk1N63LAWmzPhgg00p1oT3p8o+RVDweiycLeWulpu0ryOuWvEXI=
X-Gm-Gg: ATEYQzzYJQqXHm3yP/g66Y2v+0PQWxF3lj4gxJce20ZL5rPK3JQOSM9nK0asE5w/6oO
	d4y5tGBae/4pZljrkRZzo21PE+dQweQpQKqIB4qwpL2MTn2BwQiQGBrmEKkxl7bgmPXxYFTJRIi
	SSrMgK7peXWMBxZ6dQ57R7p6EUgCJxh68zY1PQ+C0oZZG+i8jt3giZnVF52U6HHd7NDYURwKwMc
	90nlG0VElXArlqcKXQ0cdMl/AFPHS4ba4MDcWAatiP5mMrSubb/CbBGtaDAzgzj6fCZVTE0Ynb4
	rynn6HkJ8RigW/F2dW7a8Uf93c5054NMfAjPj0bFeHgdUobl1y8Zz1Kno+I13mIfsxW4f5c0q6/
	vU7qxQkRlNU/Zj1TuEUNBCr4CLIwXyp+2AL3GTPNKFHbGZtBcTxDOGosCmWhdFwc4nP7vUA+Y2j
	vOIu8cnAhK8bZ1m1xKMNVyhFXamhmt
X-Received: by 2002:a05:6820:55c7:20b0:67b:e3cf:a40e with SMTP id 006d021491bc7-67be3cfa6d4mr3426610eaf.17.1773602541036;
        Sun, 15 Mar 2026 12:22:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f27f:adf2:8637:6bb9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bdd612b6esm4392512eaf.10.2026.03.15.12.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 12:22:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 15 Mar 2026 14:21:51 -0500
Subject: [PATCH] iio: light: as73211: remove duplicate zero init of
 scan.chan[3]
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260315-iio-light-ad73211-remove-dup-zero-init-v1-1-4785c876ed92@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNTQ6CMBBA4auQWTtJfwJEr2JcwHSAMdqSthAj4
 e4UXX6b9zZIHIUT3KoNIq+SJPgCfamAps6PjOKKwSjTKKtrFAn4knHK2LnWGq0x8jusjG6Z8cs
 xoHjJSGaw9bVV1CiCEpsjD/L5je6Pv9PSP5nyWYd9PwCOH9AIigAAAA==
X-Change-ID: 20260315-iio-light-ad73211-remove-dup-zero-init-c2f35970c60c
To: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=bfXyebqUVv+iZhbMKZokBlBxZwMEXvGPTmEwhUEkqxw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBptwbjjJj5yy8Bu42Iolald8sXQVLEZb5Q0/xtk
 YdWBcLdphKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabcG4wAKCRDCzCAB/wGP
 wLvQB/4yNPBCnVttH+OmoboMutx3p4CVb0ZeFxBWPl0GfWay4NkXjoVE8g5DxNPAnoKuY2CuiBB
 cJgY2gjFFVrC1c7gugZy7SgoGzPt8JMO/thLvwqINvCBpONzIlqs+LVIefoSIrrZcwiza9HUGc8
 TEpse318WX+4G89QKvHRHIZtieRW79qrZaxuw+wHZSjkA86NO9yVh/W8XcQecArObdAs52FmFI0
 fNb91jI+fQ5qdDO6dyOs+hlCKppZ536PQGDI2ewu5OSqEsrAtBoSn7CXPW+K+C5LxR1pMuv/ljS
 rKDKd3NaaDIQXfHtUJRkHumcDPk2ix4EmyVZPYTugMEd0R5t
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove setting scan.chan[3] to zero. Since commit 433b99e92294 ("iio:
light: as73211: Ensure buffer holes are zeroed"), the entire scan struct
is zeroed before being filled with data, so this is redundant.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/light/as73211.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 32719f584c47..9fe830dac679 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -677,9 +677,6 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 				(char *)&scan.chan[0], 3 * sizeof(scan.chan[0]));
 		if (ret < 0)
 			goto done;
-
-		/* Avoid pushing uninitialized data */
-		scan.chan[3] = 0;
 	}
 
 	if (data_result) {

---
base-commit: ff0843ceb1fb11a6b73e0e77b932ef7967aecd4b
change-id: 20260315-iio-light-ad73211-remove-dup-zero-init-c2f35970c60c

Best regards,
--  
David Lechner <dlechner@baylibre.com>

