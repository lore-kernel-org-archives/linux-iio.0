Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A13E3159
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380295; cv=none; b=iKNh+3+tkkvIIjPXh+A/kgsA1f5ZZPjG7K8Q8GKa5t72wMwe6p5w/BcMMfJ6YM62Nt4Wupxil58Gvfw6/nkffhfB4DsXSmJRaDdLM5KJs4mE3bG/u1oWhQ1R0ANA+jqnYfDsNfnKH6hJ7jOtbgf4JecgkzIcVOOEt4F1kigeh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380295; c=relaxed/simple;
	bh=1rm/dhdmEPnR1DxvivQLnoBWuBxLJrgf0lBNxX+Xen8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gt47BZzXrnVr9qwLTE/UIolGAL/QBr/b7T2jWaX2O878oxC+eSYzIROZ5iOUGIkqEEa7G1hymQzCZwnmuYUiJRrFpOtPm223T1TuSKr1RdTLuvY1f1hTeQWciZfDbAWNVh5B7gkjf553e882MBlTZdtbNm6IvuvPp12umWUrWdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sq9UBZ3I; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sq9UBZ3I"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so2669561a91.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380293; x=1786985093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0O/c+uKFNEkPwJGpeY8nCMiIIfom2XBBnkKY3AbM95I=;
        b=sq9UBZ3IjraWharJ+ubY66FCihjHe0+6XE1hV1qqnqLTusyO4r2WO9sv1DomvcI5pM
         xoB+Yjqr7svvNcxj2qKEy5Vr0zXolg5VRs2QbjTXoSlTH4kC09Te0PI5A1hVk5Shv9AV
         V5B9LhcWPFvD/T+mTEWq/e9kfKNCtxxs2Tlj5UilOoxEY9nBAgE5J15+nGaxUKuQWyTD
         H7PoNPgL9qNYNanV0U6WmedwKLSSyS4HAYDS9Kd1F1asqv/j5+j0m0ogKlnyKO7u9HIh
         hTukc8dIP53mMGD3Unxg3fWvQ/1kzPaCdmHfVDJOAV9H4YIDkRghSN1BF7cE/3O1Yt/h
         iLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380293; x=1786985093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0O/c+uKFNEkPwJGpeY8nCMiIIfom2XBBnkKY3AbM95I=;
        b=KnCmCLGuZ7ooZJMUi6IAEDr1mCBfo75z3YPdXfebwn5b3MICdeGsBVWb5x8QEAG2Dc
         /e/CkWwCjetXUq8vwesTt/OyzHjLEmmtFd4cDin5UpO4tHO3T1NtyZhockDHlMhRNdL8
         SRk7N4ynxsrn/yK6mmom+Qs0kQJtbVfNcLunigWErtHhGTH3W+XRBocJ80oL3+W9dnvJ
         6f0csF37So0eG0aNsRHL9eyY/hYHwpzPTLaZln9ljd7V87hB3+KOphQvsixWd+ELVDEa
         VnPq5os95uJxYCvAv1jME8dcnFPRtt2KvaJPS2DyHV0U66L5TK6kOn5WVyWdwup4Nshl
         p/Ew==
X-Forwarded-Encrypted: i=1; AHgh+RpLk/WvV5liGFZemlIprQTWMKOlKlFFX4AAQCwiTrg9SF7REQLXBwnhsalHYd5oXq8aA5vB8ox18Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3QXD0e8LeoNSzz5/iZxtNQWTHjCAjZcf733fbebaPMWsg1/E4
	nA/T3qhUl/GeC/jmHAyX6uRyl/qyVnpTw0XZejAhNX+uk6YuW1yFIYF+
X-Gm-Gg: AR+sD12XwvltL4rmj0jSjzIFqwmP5w1pDwGHUSAqTsLzrGJXdMosajYUFhX64MTnmDR
	wvM0iobfHTfS3X/jjzzFj8bw36FJBe804JCpz7+ohgEU/AdxfrOi2imNOyfr+M+LsPy7l4wbWz1
	sKa1PV+PyOok3uevAkF+ZWZgrNENXcjVpp5f09UgGMwuKK/G7Py0veywuBgHMKAtvywNDRJTMPh
	r/moUaE0UZ8yyFf3UKIx8/55grEuq1xkRx6wTbCq9JEDZPNuKLOrJmeXcRxG6Jch7VNDuQBf/dd
	6o/3OouOpHmmVST80x59cek9UlL9Yq9prLPM/LtPxpzUPEFkkQlLk7k/7ZfFAlUpeeFK9saKL8h
	YTTyU99BC2FwQE40pxjCf9E2p+kInm/xjAbHGYfg9ooe4fl6gu7cSvgf+faABzVwlcJBde1LLYa
	yggVSFCvs02swvqIQulzCVIEtCg7f8Z6s/Ok++nlvNdJxFBS+mdCsiFzzUAxovyic3DoefzcWFk
	+ul93I=
X-Received: by 2002:a05:6a21:7482:b0:3cb:b741:2924 with SMTP id adf61e73a8af0-3cc1a3e120cmr4276768637.29.1786380293409;
        Mon, 10 Aug 2026 09:44:53 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b95b20sm36702240c88.15.2026.08.10.09.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:44:53 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: max1363: sign-extend bipolar differential channel reads
Date: Mon, 10 Aug 2026 23:44:46 +0700
Message-Id: <20260810164446.2555239-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MAX1363 differential channels are bipolar (scan_type.sign = 's'), but
max1363_read_single_chan() masks the raw value to the ADC resolution
without sign-extending it. Negative differential readings are therefore
reported to userspace as large positive values (e.g. -1 as 4095 on a
12-bit part).

Sign-extend the masked value from the resolution bit for differential
channels. Single-ended channels are unipolar and are left unchanged.

Fixes: d1325cf45077 ("Staging: IIO: max1363 ADC driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
Changes in v2:
- Condense the commit message (Andy Shevchenko).
- Fix the Fixes: tag to the original driver commit d1325cf45077 rather than
  the staging->iio move; the bug has been present since the driver was added
  in staging (Andy Shevchenko).

 drivers/iio/adc/max1363.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 4d0b79cfeb27..497f5daadcea 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -405,6 +405,14 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 
 		data = rxbuf[0];
 	}
+
+	/*
+	 * Differential channels are bipolar and the device returns the sample
+	 * in two's complement, so sign-extend it from the resolution bit.
+	 */
+	if (chan->differential)
+		data = sign_extend32(data, st->chip_info->bits - 1);
+
 	*val = data;
 
 	return 0;
-- 
2.25.1

