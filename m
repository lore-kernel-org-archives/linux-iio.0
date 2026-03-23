Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B47230BF4E
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308803; cv=none; b=EGLVTqDnh6NvwboxMuzyrmcqDZ5WaolBxxtOHGIqXKWT3VOTtvvWInpWGZcWyAcyhv2O2WqwDI0+YXAFz/5LiYcUd1/dnbn66nwQTNxHUyW2cpn+Tp8PV2edwcj7tOBBdJGwdRhLCstqbAs/ZFsA19gBck/oz8USKxJdDm1C38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308803; c=relaxed/simple;
	bh=O5MFjb+Ao1hDoNz0FnKc5jNPOHTRIFVWCiUjBQz0MQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eh+SE2ynLsY6lHgUULtnOBgvsK7s6MWl+YRhHJup9FjFVX++h9TKNOtJaUPpEtoPt0oPEUtYmFv7Gun/gRyBbLN/haY14/NakTKwj0m4o3jjGNW244n695i97qoCQtJbXQDCpMWRgScnElavbnvkBejKBK1yk3D2Z78p3x6+UCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cpo9wSZB; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpo9wSZB"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cfc085395fso329685285a.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 16:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774308800; x=1774913600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/v5iJ2MRi/6fZNrjwCSXmIsYUmpQSRYVVF7Dj+y1co=;
        b=Cpo9wSZB9l9hq/e3zCHlNp/rpAq/Ax5RYgeNgNoJ3NWc1WRo5HI8Rz/mDVtapAVopZ
         k7l93ibFaVSC8Fhk8fiEc8one9zyCOTB8xpP8m7Mr10bxyursep3oOjf3QmjduVcTP1G
         A7d3zkUHFoTAyWmRyR5TbKjY/gAAy/tgr1KXAU2yz7w9MJ5Jm4NqBIUTEL0dFVlLTTe5
         uvvxH1kMrALqZeUVOact58HdGL4PsS62JhJ6lLWF1XTLXRHrvPMOapq+3YIMUO+tHUFG
         u9+9An3+KZKddWtksm6gFYpUD0rYA3RIMWa9joS8K81J9wfGXg+FueQnbfao9535F4Ft
         05Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774308800; x=1774913600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/v5iJ2MRi/6fZNrjwCSXmIsYUmpQSRYVVF7Dj+y1co=;
        b=Z05BNbg94jkZFkwLO8iPt3fJPQL3ii8phgMS9jMj8Mktu4382vWk+aqTW5D8H30QoC
         tL4pUek/ZMX/OzRyzT2I1LdI0ihBg/g4kCQsTVFEOuuyDKcT98DOOqp8agucqNKRuwfA
         MTF4aTbIIgLvMLhf/O1rudCT9FdPzY+sUlpwvPOBQyDDd9qANKBaOvJpd6phe8WVhr48
         LCvi/f0nmdB4waGS5GDn7u6yfzlB2C05KX0PkKR47V+993ro2BzweNKcUvfFLmywqfRV
         Apn8BCRk5V3CnX31zqfM4MUq59qSsDqp57ry5lKF9IgM7J0iP2+kVM0y7kRIHzbnes+w
         pktA==
X-Forwarded-Encrypted: i=1; AJvYcCUoDPWSGggjIBarx90VgW/BRPS4gRR6hm64J8Rb7KGzzxFBKIG5RUeeYHFWMNnJoe5D+pLymrcOASs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN3nLMAfp6fg+AM1iQk+Y7ULvDdJMgKI1ywweG0ZUVMXQKRvtI
	c5vcACRIKi3+qSCgfWwyhphPwBCQQUsDDqr51HVVbpXNKxbgyfVK9k61
X-Gm-Gg: ATEYQzxlfo7X1e4K/Jy56bOI8wIvKYlzovu39H29uiSGlDtDWFvg3/Nl33FWzU6Gq6y
	cQ+0qPEKPwvBuoQP5kBj/0tpj7N2/ZO7KQcWcduaxHP//XDscWGBDCwWmOhrsXFrrIyK8yLVsMF
	alMFbVAbAPN7uU12pQnw+6hVLjyusJQMKAyeT3VFcCMw5ZNJ0J6m7hkrv2/mazIiGAnDMdDuLgB
	eDtBIxDLgWTEdxG5zQL0cyIdw7j3FrR7p+N74Mvq7lo+BRAt1+zcjg7WiVVpbjjFwJjv1rBGNOG
	85a9FXrP8gq7ZJBhOlZhP5iqeiShfQhjPPD/oekLw8QrIkFXIUv/3w1nhZ0TE8ywvpsQcVSv68l
	uI8iISodjaHxXxmf9LwZQzqa+BynvYEX2c62eJSZ+xedNbvtevrsqKbzAfM0ApUVDgmezrPvIlJ
	Ou5JcEe/WF3Uu8syY4aCg4tx3afkEiu+Qy0Paw1FK40w==
X-Received: by 2002:a05:620a:4050:b0:8cf:c08e:5f43 with SMTP id af79cd13be357-8cfc8097225mr2098170285a.63.1774308800011;
        Mon, 23 Mar 2026 16:33:20 -0700 (PDT)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfd47c9226sm896593985a.23.2026.03.23.16.33.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Mar 2026 16:33:19 -0700 (PDT)
From: Neel Bullywon <neelb2403@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v3] iio: frequency: adf4350: replace TODO with NOTE in adf4350_set_freq()
Date: Mon, 23 Mar 2026 19:33:16 -0400
Message-ID: <20260323233316.40047-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the TODO comment in adf4350_set_freq() with a NOTE explaining
that a constant-time approach using fls_long() was attempted but deemed
more complex without meaningful benefit for initialization code.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
Changes in v3:
  - Drop fls_long() replacement, keep original while loop (Andy Shevchenko,
    David Laight, Jonathan Cameron)
  - Simply replace TODO with NOTE explaining the prior attempt

Changes in v2:
  - Use fls_long() instead of order_base_2(DIV_ROUND_UP_ULL()) to avoid
    unnecessary 64-bit division (Andy Shevchenko)

Link: https://lore.kernel.org/linux-iio/20260314172006.69744-1-neelb2403@gmail.com/

 drivers/iio/frequency/adf4350.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 3883b63dcc3c..6bbb6a8dd9d0 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -152,10 +152,10 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 	st->r4_rf_div_sel = 0;
 
 	/*
-	 * !\TODO: The below computation is making sure we get a power of 2
-	 * shift (st->r4_rf_div_sel) so that freq becomes higher or equal to
-	 * ADF4350_MIN_VCO_FREQ. This might be simplified with fls()/fls_long()
-	 * and friends.
+	 * NOTE: This iteratively shifts freq by a power of 2
+	 * (st->r4_rf_div_sel) to meet or exceed ADF4350_MIN_VCO_FREQ.
+	 * A constant-time approach using fls_long() was attempted but
+	 * deemed more complex without meaningful benefit for init code.
 	 */
 	while (freq < ADF4350_MIN_VCO_FREQ) {
 		freq <<= 1;
-- 
2.44.0

