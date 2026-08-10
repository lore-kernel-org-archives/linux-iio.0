Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626A3939C1
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786344163; cv=none; b=HiUBm9Ql+Mrchc+9RQZcQSfFtorYjsBK5Rz2u1KJGDeQbXqsy2S0WdSdaqPY8EH1fPVydKb8ZrlveyG3b8w7qxe6vBbgMOWwRjnxQ/33uY5KN1onaeAValjO444ncHxUpMvZnWSe9ew6/XBrZnQ+tqe4C9CJElury2108a36wCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786344163; c=relaxed/simple;
	bh=cdpz0h7C3OKumL0be6c2g+3rMM3vhRcq1Ia1fnXu0oA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hokEaZ04tE+NshOy9qhLugEMdLRZ8NE8hdYa86E3Av7c6K5LFB+19wzlR1f1BQyImlJis+NFx1FfyhqnYDFKosubXrsobDmjnAlnW4fI2ai27eapGITmsS++YFNiy65ZtalVT1YadY5aYuM5KOZDWeFIYrYPMvoWrGWCTrHstLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3VZpTTB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3VZpTTB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1359523a91.2
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2026 23:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786344161; x=1786948961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F8jEBE9QHGlloAt0vMeYtcsHxC6qpAYVWGP4wjQCzdc=;
        b=p3VZpTTBkovmiYJhGV08ShawlfpcJ/5iebSMCFC4QALbk0IgLJEbwffcb5930p62I9
         92LD2jg9wG+KAvmMCfMrJgB4K8Nuwomz/RJzRfSQ9gysMc+iAfoolXOgzvWM8HbQrzko
         bHp2S4AWBDauewlr8wjkm22hYqNf5y0hQJ65q4nNHfbuqtxldt322C5es0hI4zEVRPCf
         85kKZoFCSbzNmyHgJBKSTzstjWBczS5fIn8/WwaZBUBVGLYIlDpoMzU1GSG6M2gI92LK
         jzTrMdtSZCeLjFcNzpyiXC6VHF5yymcu4SxoLSqR9t5yriuaDnRjy/nSmRCQgyaXrZ6L
         VetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786344161; x=1786948961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8jEBE9QHGlloAt0vMeYtcsHxC6qpAYVWGP4wjQCzdc=;
        b=PUYv7GPwPmTkVIouDEQ8DSsUhshAl30+Nu0vYyWpWgiZieqNWGh624UjZMXKRbDB3T
         8avDGuiOAuvWIAgr7TRXDqPh3Wn3IIwC81z06chl86hn8bglPiQV+u8VhGKDa/NHIIlE
         ZIASeC/BXAQu5PypqMKDNuYC39mq4vlGqu3UDOPn6ku+8nDfCB9uXt7/GYQMjr45j/N0
         e6QsVd8w/HxjnzVVPReShPUugUFRVWvYsR4ntxZxs3UuKoDii2c1RT1PPVpdcBqymXnZ
         c/F1/abdLLXPq8K9dmb3eo8cSmyz3Fctt6LPvOBXLHMwoXmSgIzzhQRL50zrLl+1kXOp
         uDFA==
X-Forwarded-Encrypted: i=1; AHgh+RpoABxRLR46tmn4MFwJLfgxpdX+7FRdHKB8zayb1c8VRKuug3HOJYodmaCiBSQFz6ldM0bAICsHoq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD80eHcVT12oCT3A/UqLvUlpjWQFCuM7xaxfJjRdmk3Flx+ug7
	LR8ryW2wXzkdpi6BdShapnJ1aGwsJo5zLObUBLb5sjcUE+qzIrrX6YkW
X-Gm-Gg: AR+sD10yL+KDyRas+FppQ72zkdndcpY6jACOoy2+2PWQvJxs2lBVgQGu1jURpGZQFvM
	DMZDzpNTVB800fy1dDP5sQFPWfgkNFJYOlJBt42Y0M8J7snfAUo8+hZ9a0wYb1x2jAX/2Ss5nQe
	1OsBnGtcACZrLqrwlUUAbbA+lUn7HkR/XmbFrNy8MmnyCCuVjR/4XFp+II0EnnQ0lmQGOmfl71q
	R5ogHVm5GxURbcNP7wP+QdAxlnNBZVgldqxCw2r3l2GujlxbtdMEm9q6h/2+jiQwdSH8zj/b02I
	pVU2UCwnqlud6S4W7Eiyq3zRUtcEnX+3eJY7lsLtuPRS50romkubYqn1JyHscbv1C1H6Hk0W5dl
	HGkkut3kriApP/I36PeaI8nnvZijw3YgzUTBGecDFvtqmkZci8bGdKjqScVUgjhKfSGJ0JtPyV4
	E0JNLbTBawLs39obUlkqEyBOiakxx/dazkkbf313xjKkb20+ECsH1Jj5mB4C6YgkPWe8tCEWleY
	aPnOA==
X-Received: by 2002:a17:90a:d64f:b0:38f:caa2:5721 with SMTP id 98e67ed59e1d1-3903c5dc500mr39010781a91.17.1786344161101;
        Sun, 09 Aug 2026 23:42:41 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebee8d0sm37667662eec.24.2026.08.09.23.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 23:42:40 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: max1363: sign-extend bipolar differential channel reads
Date: Mon, 10 Aug 2026 13:42:34 +0700
Message-Id: <20260810064234.1850833-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX1363 differential channels are bipolar (scan_type.sign = 's') and
the device returns those samples in two's complement. However
max1363_read_single_chan() masks the raw value to the ADC resolution and
stores it as-is, without sign extension. A negative differential reading
is therefore reported to userspace as a large positive value (for a 12-bit
part, -1 reads back as 4095).

These channels expose only IIO_CHAN_INFO_RAW (no offset), so the raw sysfs
value is expected to be the signed result. Sign-extend the masked value
from the resolution bit for differential channels before returning it.
Single-ended channels are unipolar (sign = 'u') and are left unchanged.

Fixes: 168c9d95a940 ("iio:adc:max1363 move from staging.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
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

