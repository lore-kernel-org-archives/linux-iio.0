Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4A3C0A03
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178176; cv=none; b=sgNLoUnXWxxLrul+U6w9U8L9TpE+tMf5jj3AHqZSoKvovY7qnJ/9sgc6C0GGzbT2scpyGiAR3g/lm+ls884jkN8He+OK76DFvtEe6ZZCkJpxSXjPCIB7gx9EY+XkF1Qb3r3/tmDUuDxWbuAkFqU7gx8s2rqyRXzyVtUBpccdezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178176; c=relaxed/simple;
	bh=Z6rvelAnuLkf15OCzNHVaRrwgqXqFtcVV1VknuIOAxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFSMSt1ouuBKgAxRa6JTUkW1MO4uNS1hekKRBhwwW+dGofKPKzgUorkNgDR1Yqx+i0b17E16cOH4DYVn0RnFQBn9W0pSTQEzb390mUf2lSu5Ild3TdusRTvaa2vXcNIaGzpP5AbMBHgzp8fDatdZeaVqVHMFboHbbK1yksD9P9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jmp/d0Zf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmp/d0Zf"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf27856f9cso40006265ad.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785178171; x=1785782971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AiFsA8ChqETYp4ahiT72Bvd6dmx+H0ni1OlvY83HRc0=;
        b=Jmp/d0ZfxClPZqY331NUtx1qJ8R3EZFEYB97oRerWoTAlvilAqnWd42kz4LurlEUDQ
         EF+bAhZbC4qA9En3CGQwag5eNgZPmV+FmDIbAtgm/iIzvuaq7phsgTeZ3CZUsFv9CIw4
         aQ0VHwZs4yHydo+9bFAnURl2v1NaCZboVNNC3cGNx+ZLJseEuVoiHK3T4cCdS/GZ79h0
         ahsDKVmoiyzhaDMLCRxNpxO5ycG8XJJM+QmJBUd7MB7URmkr7nHqzPZFqaJbCp+0JNDE
         Ym2iXzrmc66NzsiwfCFh4bf4B2iGxHRP88H5k1Tp9fAIBAFs07YC747B1S2lJKDdHFpM
         V8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178171; x=1785782971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AiFsA8ChqETYp4ahiT72Bvd6dmx+H0ni1OlvY83HRc0=;
        b=eZO6g71/OErWgMDCYJ0+yRMq0gx5hBbwNC/19jABetAENtBmDVfPFC6JLF7X/G0Wr4
         w+MFXnHdZ9vxUrU9bBHnaZyNDvxmHDgAG28oyVtaOpObH1OjMlDd+FoF/SMAt7kBOopm
         LAwhCG7sg0G5CZO2eH0h/0VoV/4N3hEogTEUHye6ISpd7oYi97EzMS/bqdrDdnrFJLur
         puyWOOxXY1wgFnHze61gPwodMtAsyHfDBQRbrzP3sypl0Y6qOfN4j60a5LDy+iRUo6Nq
         BYsazvGxsWfHM/IJeoE7ERhs7QDjt6asLdEStCIaUzyQnojp1ZS36bOSQREK4u73pdCy
         xNLA==
X-Forwarded-Encrypted: i=1; AHgh+Rqr6Gtw2rKCyTofk5uGj9RA0FFLV/E1GBUJybFKpCAfXyxc27l9c9Nf5yUGUBYZExSCbgQt485iNLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVLUu8zYQ5YiT4X/aa3/B/vn5TzmZ1F90gWSRwuiRlcbB4zbA
	RqKMMf1Xj1PkfuyKBG2M9b1XVm771M/uHKL2+/1zr2WVJn27rCWdrVJV
X-Gm-Gg: AR+sD1059IjaFFSjtjGT4vwRn3rNWh3xBnH56xLcN7/GBWXE2sNSXTTYOS5/t7JagV1
	tkx+kEY5NOIsX3ojVn02kiBX7k7anSfHeomhIIdpaCddvpCp0WSNwxBOkSvaB+5fBmhy3g0bElu
	SzW2jcUHkRk+GwpWM2cu0E8DbYuBN+0JtqFCz/mJbs1pLxGfQ+8Ki2JxaOGE5RmN3/4TU7trBBK
	+zZKM/cuEPitPi/7cBOVbEMweGlh2i0DP/RzyAghc+5QYwR+Dm38IPhnnv7ovwaz6ZlJpqA/AXq
	4cG7XgNrLEG0gFhxOM3DNmhGhwb1shEQmdtgxfDhwjUxnsX1lc3iAQDBCpia6Vp3i9SKxGhiiur
	rQjhyDyCjA1E8vxmbdfJjtDgYUDT3NRbwMIuNV+qW2hKXYWe06zPYHYhuHfiR2rlT8a4nu4HZn4
	IIj/2MX4k=
X-Received: by 2002:a17:903:1b07:b0:2ca:feb:303b with SMTP id d9443c01a7336-2d00f380561mr5131475ad.25.1785178171382;
        Mon, 27 Jul 2026 11:49:31 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d7b87sm40186245ad.57.2026.07.27.11.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:49:30 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 9/9] iio: magnetometer: ak8974: remove conditional return with no effect
Date: Tue, 28 Jul 2026 03:47:46 +0900
Message-ID: <20260727184755.2055414-10-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727184755.2055414-1-ekffu200098@gmail.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has no
effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8974.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index c7fdb7c2f543..c988d0e40cea 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -379,11 +379,7 @@ static int ak8974_getresult(struct ak8974 *ak8974, __le16 *result)
 		return -ERANGE;
 	}
 
-	ret = regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
-	if (ret)
-		return ret;
-
-	return ret;
+	return regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
 }
 
 static irqreturn_t ak8974_drdy_irq(int irq, void *d)
-- 
2.43.0

