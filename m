Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E5E37C108
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776322324; cv=none; b=iJJGdQL+6uWV4RtceZQfmwGP0gdBOvJwvLsy22fq2dk3EIHEuWad1XPuJmNBSbDG9kqHGgPieUXP0x9Z/cFh631wCk4amRPxnFhzr0wgw1G/2w0011Ee362NuWAsDKya42IUy/9nih0Z2f6CwBCZmcUYbkIOkv+M5SWwkGgsyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776322324; c=relaxed/simple;
	bh=iozzvJCB2xG9A07OQoUFW3jP0cPuyJDlaZfk/DDuFvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0+HDqPPSbPbQ9nj0tBMz3QfsKmqE3YDpJrSq7rWhPhoze1ek83BGNm85ovZHtf0Mo/6HNSXE4loqOkIaJ6If3D24XKTxgLK2U1tEpYMGDmE5q3HJqLxBzDsDGsiWk9AVCdJ5H6haqL7OuTqWtQ6l+oxZYkViA7xwQ/UIFPl0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbLwHrH2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbLwHrH2"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66f727d6849so11049649a12.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 23:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776322322; x=1776927122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8S3n19q846uz8sVg+/KoKXdBEBySJwoCqjluLQZul7E=;
        b=lbLwHrH292p+w2z2APekwGnkuRoLDSDcZZHWUbbJvuvT8dT4uMcf1D8iE4L4S/uMa9
         kJbmE0c1mr4+IgTObbYAei5Ih92327vgMKV3nfrnLXVG465hM+kHaxrLjQsoBFAl3A/J
         Kj/U9noYpcOp0sHB3yoynPfFMoeYX5wt5ayiNfzZ6/hIVhv+1SpsiwrtRECqmnALHoCg
         i9sj5GumnLgSu216NC3LIxXuCxxSCG03A/Z5GPwZ0AEdKL6ZqSKcuNJnTV8F4IK5d6yi
         goX5TyIlkBCrlWVWbRmU1g+yy4b/6Z4DWeKJbUYoUgNcuPNTdqX+oKL1nAT2XbQMzeSK
         K1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776322322; x=1776927122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8S3n19q846uz8sVg+/KoKXdBEBySJwoCqjluLQZul7E=;
        b=PDNqGC2fu7ybkAN9phsgWu/BDdjjgzhDt/C/uo/i8YJRjiY+gBw8xonzXQgSylK8Cb
         EPCbQH/xPXA5YsioEaHlTb7JMS1EEu7UB5lR7wT/pTv6ygs/q43YmvI8zFbgx48jhaqw
         VV413qnzQocYDKWZzxJ+Nkn65IndRGO8ibPQj1wIoOzQnMgq50dYQSocpQzV4H0f7Dea
         hDJLCQXXvdnFoRjL3TFpconbeFhGUBvAVhn+jAYxUSQQadEXuFUD0o8dTBo8cU21ulz+
         smxMYXgms/gLycMIn/MmjBANvhLoJGmkeUcTTMwhjl8p22MpCD781sVipdp2PcppqGJ3
         o2Vw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZkY+v8mKsLn1aRupRHTjRx8RjXIQujGaYEVBjfT70SPH+t+DK2KKExECnq2iEpUY8PeFtmrQGjjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhE9MzrtvL+8JOT+z9pMChTfOT+8QZlDjnaYlXnTMJAX+V6v+e
	iOx7SibXXk0eZlgNm7Eyh2yiuzBRMvP7l3eweKa0sdk2Ur4ywErcXjT5
X-Gm-Gg: AeBDieslddvjSWMCDKxGF1PN9QjcHHLGSYfuVTHg5oO7vf47GH/ruyqbWSVVtYwxupj
	olHyrHd/RXvJtbT28IOTI4+IzFMThc1QinVKPOGms2vL+oQNSDMnYj13emy8bViQNAWGIvgNj44
	NTHC9oF0VmSRzS+h8dxzosefIgAgW2qqiy79lpzH51gX/fZinhN6wF7EqzExWAoxIwBhditfsP0
	zrnVj/NiPNqFHKInQrdZp74Gx3/ysGlhh3ljT6D76/hcIeIDMvzkzb9QoJU4Mj7KqR913Oz6aaT
	m4QXTnK5UtLrLzbGjkCj4DbM0wHZwlxW3zlS83nE9ytda9yv4z+6IvUCgEAovJFRby/A/aSAruf
	b3CpZk9iaVc1pEx0vYXfSqBPdo3igdgjAkA8LaW/nT0fsL+V9XuV/rc5eVSFmAXL3FA3SucmH2C
	JDVNVtm+fiJs/+xCM7G/H8lZF/E1g5KInD1pU68mW1IBddfIcZCfJQB91lzg1MNQESELLqj1IYr
	Z/3S+gZqNZdLmHPrX02NUZLbT/RYEB26iA6fPyCx3aVkuUMBA7KYn94R3RV3xahg1UqkSLTL0fM
	YorLVRBl465B8K0Hl4YOal4E4pQd5bVcRl3/kBcJE7Zu/AU0tYE3T2CN3clGnSdnTeGYsPsdRQA
	f/MEZ6erat96iZsSZU3WHrqExgEl/qx1++XfmTKh985Yy1ydMNP4h/dHvZcbdhAXoVJQZCqIwLH
	uPggMxAx0=
X-Received: by 2002:a17:907:3909:b0:b9d:3a9b:a836 with SMTP id a640c23a62f3a-b9d7297e220mr1270489666b.30.1776322321150;
        Wed, 15 Apr 2026 23:52:01 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (119.230.32.34.bc.googleusercontent.com. [34.32.230.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba17341a8e3sm132530066b.6.2026.04.15.23.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 23:52:00 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v5 2/2] iio: frequency: ad9832: simplify bitwise math
Date: Thu, 16 Apr 2026 06:51:18 +0000
Message-ID: <20260416065118.1299-3-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416065118.1299-1-joshua.crofts1@gmail.com>
References: <20260416065118.1299-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor the ad9832_calc_freqreg by adding a BIT_ULL()
macro instead of manual bit shifting for better
readability.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/staging/iio/frequency/ad9832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index fbcfdbd398..cd7c7727f7 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -111,8 +111,8 @@ struct ad9832_state {
 
 static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
-	unsigned long long freqreg = (u64)fout *
-				     (u64)((u64)1L << AD9832_FREQ_BITS);
+	u64 freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS);
+
 	do_div(freqreg, mclk);
 	return freqreg;
 }
-- 
2.47.3

