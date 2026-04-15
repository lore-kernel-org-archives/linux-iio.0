Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62453CBE9B
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776240518; cv=none; b=dbsBHHRsXYBWfmh6R6R/WLWb8HJNJfg9ZgzfI+0dh1TNpUa98rkLOxFwn36MmpKDqBa96XG4DtWzpkEkTML3wC0okxXXYsd/mmqvAarhrKioGlhoZSlyccw984nh/wEbx0VxqELNGafZLYwAuAfQF+sKDDJ/QLSKB5Cm0CKLCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776240518; c=relaxed/simple;
	bh=f3Sav3+fI5mgc6eUxCrdoTC+ImTmZZ+KiY6sukwMp3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTIQChxIS0LuC3VLKK7I1njY1fCXD8DrYQfG/5Ig/wGQoZppZ8+hbMSUGBnRsL2SBeC5zFwRk7smSxifO/NsfKBuwwnpc2DEUlkVNlrAnd+qr/rFTLWsdClfa3Zpr6ruPPF21yEMR4XLcJ90ezz54/iXLhf91jkiRE5mrOIEQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhTjz3cY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhTjz3cY"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9b1df1a6b3so749953566b.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776240515; x=1776845315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mQ+bDBDc95NGWzUI9atKZuTpO1qC2/VErOShoToB9Q=;
        b=UhTjz3cYLz1QZQ3deDKefB8jGUS+hF2QkCyNRQp0n6SfGanZH4nM5n/MrdKbpGurwr
         EPzuiZNztPFywrNG76r2xJrm0bXJXJzE48wR4zmQIn9p8pN+7VUgxvB+I8GhlgaJMPwE
         fzywS1iRd3q1NGkI+/5iDDggQ4n5MCDbXk7a3vjKNb93/4+L6wJ2nX+NPwnODOtLIV5B
         65mif/Qxq94DBL9dndHgJd/Dty8PogLyFUjUqJNph5XxntLvNGAbdmJ8VGzlc5NNdhNs
         lTwZE7aHQVYJYubC4bilB+tXykvE1P74sB6KJJ2mwhu/kNJBO6bVw0KGcu6jbz3U/zUe
         DdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776240515; x=1776845315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4mQ+bDBDc95NGWzUI9atKZuTpO1qC2/VErOShoToB9Q=;
        b=oEE9i/ccrtEln+/i7Y0KsOFYy1to9R9kCl7ntFAiTM6JwG6jfevhjAXvfPXPFtaNgJ
         3R7qaKFC6c8qWc2iXzmcaLByagIFyvhvFPQUtvaZXu0cF2PtD/5pz/cMoB3ogidszpLy
         CRQT+u8DOKYqbk5YMo8D95/b/7N1vY8nUlMjs9Ier06OUMxINkcsmCq51YJDLKQSTNEP
         ojbyz/AFO4KF/8EKqvibYpZW/aawoxisziqI5ALY0c2LCq3/Q7pBd8pq3pprN0NDl/0V
         uBmDJAe/7btj+fRVYGT11PlX89TOuNGsNfa/mG+49wL+bWj1oMN5ovvHGwQr551K7rXK
         cHuw==
X-Forwarded-Encrypted: i=1; AFNElJ8bv6PGL9giUSlEDQyuPJgr7zvpC/b5sYOUco7HQ2G1sZEQw+n6S+s2/tO0lpQHvOLA8mUp1TF2ctw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHvj6H2uynBf7r5MYHLsnDvDJd/F0Y5hOxZ6CJvMEzN/AJqmf
	edVkcIrYAXsYKilWAfdG1nG1Y2rqn/1M0vrRO0NmVzl33bAy/+RkeUg5
X-Gm-Gg: AeBDievPfArmqdFlekXi3crDqDRcLIg7FfL+SydSyyAk8P72fV2k6jad9n5GsRh2hTV
	2JD4//nVMmJybYNU+EUi3Rlte1XvR1W8HiAAZui7q8yBU4YCAeepchGcdxcvt+zW4K9gR2S8sP/
	cGa77PwaFIuMFqIBNA35IDGG5arKLB+6JtYTZ4cDH7PQh9jxR/tKKBUVmgzk00KanhNyOZuoD23
	ImBluWCBWaNUBNdfw/1QDS6XqteKNzVlULxolGExABlRng7ayHFLIKKg/p6/90hjvHdlRqpdrTc
	G+DoHqmzJ/S3pumP9NQMxplhcjnxZYgeHreytLFujucu56piAWxvV8WOxK/c/16aJ4w/tkm97lM
	qGBcanWxAnRUytYW2teGgfedVxoIlYCn12XF8Z6DLWI9bMN8VWRRGLcOrBIzN81qTumMCbp4tsy
	iglItIEqiBtjmYM2iG9zHBKQMhsJo4Kf6MkOQ+AUNGKVxm48YpUsjY1FZzRM8KbQl0IiJCIaXgL
	Cyhmpn3t8rmblM7D/LC4gpbOm6yCPIOdyqgAIN5tF1Ps/j10d1uJREx/xrki80xvkf0hK6UbBSO
	ncc6AbyT2cw0GoONwuAaH65ssBGK8oppkbRLHWW27FcR9nQKmhXTILioMRCTXZP59RoGjwDVRQH
	acATiUhEk9kHR/xyayakN+nKP4N7ek2pGv8qqBnb1lBjz3E2jYEyHMxqADugnnu4G+iSRmkSjCb
	7Izj2KN3F1TB5fjq74TOvP
X-Received: by 2002:a17:907:e107:b0:b9b:5164:905c with SMTP id a640c23a62f3a-b9d72793041mr644068766b.14.1776240514847;
        Wed, 15 Apr 2026 01:08:34 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (239.185.141.34.bc.googleusercontent.com. [34.141.185.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba1773c2013sm29720066b.34.2026.04.15.01.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:08:34 -0700 (PDT)
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
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v4 2/2] iio: frequency: ad9832: simplify bitwise math
Date: Wed, 15 Apr 2026 08:08:12 +0000
Message-ID: <20260415080812.1284-3-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415080812.1284-1-joshua.crofts1@gmail.com>
References: <20260415080812.1284-1-joshua.crofts1@gmail.com>
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

