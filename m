Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC923382F4
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775897961; cv=none; b=nYwfhde4ukR4atrJErV0vXbcaODaaAGX3Tz7N9yu0R/4zHHoTHPleVOoDJC6E4v31F4JcGNra7legANEaRn3hGi+o3mgQoiick4G6JTPYDqCSKvsxd06+K5dRDSL8bIPCsTg6B4wS5653rm2RH56gSnoGhqVw2BWrdF3bI2BQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775897961; c=relaxed/simple;
	bh=7Q5mva72tlCTFYBzwEvO2ZFGsF1JnnlsFqj/wvcMAdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rE5Nwar6uqLmGDhGQBGoC6DEivzjJnVwQ03tB4AgiMOk2ye6Tgj6pdoPXFluErk9YCJaHhN/jEJbiqqhB7o1L3cD6eX4U6Oqq9e72WDGSDQMZjp/9tDPZ5NAuYlXVA67eGGW1ExRKu5HOOzvTPghLQuO++v5n2rOYuzCFJaoi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ8JvKUg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ8JvKUg"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so1672998f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775897959; x=1776502759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z9NrwlpQUG/cW4s7HQM8LOZblhF59Jnsa4w00A3aEw=;
        b=dJ8JvKUgHpRiKHM2cdpKDwLdwTk+d8LQiXDkbFoQxF0McJLP7Y0kpchbvGLt8xrvtm
         HMXltQDVK7/i5/wIgq5HZX88aoFGB0tEIt9dLb/DPyFhpCweQzDUesN90E4Moy90RM/p
         3w+M1JASSymFipFaHq87C4kJM+rozEqGzPGD9U/8plwj+fuDrjx5uGs8IhhyBXUN9gum
         blKGbyVlKeUPNlmQRlMiXETZLmaT1/fme0a5kDaaVBJLjGCjomiTZm92pjIH2QYtIbcs
         TLkp7etj26I4sY5fKUGOWdJrNqF5o2ToOYH3rEllzkQBQiBBWKUQBP2i72oXfhF0wnD6
         pfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775897959; x=1776502759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/z9NrwlpQUG/cW4s7HQM8LOZblhF59Jnsa4w00A3aEw=;
        b=CBczkspUFWW+eHAF3SVs5Yc/VgG1lcnB0juemfULEJ3HxV0TvReW3AxYXUhYtjehHO
         EobJuf5Am3TbhoIRMENehlrupADKowAj5sggi843JF372WxIhs4kPPKbZbK9Zhvulzzp
         y1HH5ZElmR913hzdfYWLXs2bnSlXVFwhVDM7rzudI78Hcv+PojI08ZevCdaJqv2F/zZH
         LDf4K0N9wllrTShlbWbDdpivNcb95Xu6w1phYDcxPQGiIIv6qUCUTc+kBAvIo6hXvm+R
         Fp6163v0O/CudTm3+q4LiD9s6SGYqYftCugsXxsiBtdK9/arjS+69lEAS9WU/N9sbun3
         M5wg==
X-Forwarded-Encrypted: i=1; AJvYcCUWIhO9GXFs6IEGPZ0OXv/aIzcUmphif9fOcNTFzYHtqvsj5PbSQPQg7kI0wk95XweRJ21jvFS7mLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyih6qz5CkrtPbQufG55jU7qnb7zSa8yal5Tslg67OHbL1lVqw
	kYWORO41oC12uJ1NLMPPLAX66vhLPWBwdk4LTNPFcXyTJqrJldyHaoXn
X-Gm-Gg: AeBDietvYmD2GzgOY/8yQ+oMRD1pEvVeM9MxrAzPhzvwOxoulZj4bnf0AcCNT9qk1Al
	q2ffOFVeryZLbsDnvBixzHLnPAnKBCk5sRKEE6eqERnVgku4MJSXfO/8iUCphzyNjAIkPP5R3CI
	g/BgA5EU6bVCldKxSgY0WXwazJsDMz4lkOeCPRt3cWHO6ouosx60BKa13KVvkmONHUL1QSkeTk9
	0tC6UGoCHhucOxczyVbBOVWAqCUoVnEs8cEN4q1rPxSyfqSs3/pb8EWQVxMart/kYRJxgTSIn00
	0EX/jghANVAU/kCTpHvifdAzfE5u3lA2y2DxvRCU6iOJr9u+Q9/4uhfDN+kwbgmVLRUO+KEayvC
	0udHxiVGlH4ZBD4qYehiHuDEfD/nwpSgjynIv2hMb4gp7dt0Rw86ljUezLQuLaXjvqOQEq4u4eP
	d40BOvEAJkUfyZK/UDGRrgT8wQVU10UwYiSOmuxwfG/BKwZq3sfk60a5qq9d7rJHs5BLZVlC1lN
	IXrShwyq4Y4rmRUSfZJ0i3AxLOxrTaOaua2e+e+3Pc/EBzUs3kulsZLlZLLCfjPObtlxCOwOiqi
	PDfgTH7sv40iMLXiYJI=
X-Received: by 2002:a05:6000:1a86:b0:43d:6e0:9458 with SMTP id ffacd0b85a97d-43d642c08b5mr9723343f8f.39.1775897958932;
        Sat, 11 Apr 2026 01:59:18 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-246-182.bb.vodafone.cz. [86.49.246.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a69sm14483593f8f.4.2026.04.11.01.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:59:18 -0700 (PDT)
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
Subject: [RESEND PATCH v2 2/2] iio: frequency: ad9832: simplify bitwise math
Date: Sat, 11 Apr 2026 10:58:48 +0200
Message-Id: <20260411085848.75381-3-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260411085848.75381-1-joshua.crofts1@gmail.com>
References: <20260411085848.75381-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the ad9832_calc_freqreg by adding a BIT_ULL()
macro instead of manual bit shifting for better
readability.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
v2:
 - changed ull to u64 type

 drivers/staging/iio/frequency/ad9832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 8873a6d11e..4221e51dc4 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -112,8 +112,8 @@ struct ad9832_state {
 
 static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
-	unsigned long long freqreg = (u64)fout *
-				     (u64)((u64)1L << AD9832_FREQ_BITS);
+	u64 freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS)i;
+
 	do_div(freqreg, mclk);
 	return freqreg;
 }
-- 
2.34.1

