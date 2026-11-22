Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795333653;
	b=zevakK35xgR1oFPse7qDOvEGOxoNTDopHFiPhFtgHM4NQt+C9r1H9Ajqo3O/ktOu1Jib
	 FgpnsPEzR+lOa8/0aojwHi0ZvdEgGnh+Y6ZAark8jFgplNI38ArH/u5tCsXfntD9Vp9vr
	 a4dOr/10IRCQEDkdu7ue64NlahoJfC0QJZhTWtHLSJ49FCLkQCSg39H4SJvePnQp1hS92
	 EWrRhAJuRYZ5jfe0f3qsm4BgOadSbRhLL3FA1AcpCDusffJnINdPKW5BuDUibjHXXDebH
	 YKhns680XEHw0nb004nHlAXTOFbySGI/OQ/cLeF/zPuwFKfjlzwS7yQv8O13kG+x97A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795333653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zI8vPiLTwHtdZngpQB3OIEkAQH2ZOP0Pmpcm3gPefek=;
	b=g2EOePFlkKsVvBDFzNaYo9IvINnd6Hl8d1Ta8laq/2MERTW9uCgYVBm+6v7ozEk4XAkH
	 eIuc7Npao3SxG3PaajpVBjJWRzLfCJTPQl4z537Kc6ZAjAFf9RRD1SqnLXoijUHF2WR8J
	 O5mumeOPeZVJxROTOvSKMM7FKTfeMKiBXnVb4XV9zP6PhtOxRffJH4Y8UfkBP9YMM3Od5
	 hMjuezn7rr2/4wDoyLjEb+3Qyc3ojfUKJ3KkHrHXrqpCTI1581u/joSYO8tAemNkLuRcF
	 Ubpuc9SbhMxQ0UkPaMHIAINZxY0//ymWJ46Naw4U+HJC8lhMygHEW8x1LbICyXhIX3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNAUv3Le;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3935606A332
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 07:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3935606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNAUv3Le
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3863db981d4so2827178eec.0
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 23:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795333652; x=1795938452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zI8vPiLTwHtdZngpQB3OIEkAQH2ZOP0Pmpcm3gPefek=;
        b=WNAUv3LelgOxGXGudcc5Qm9VIXAdloA7GqSsWgQB+7/gzkdzKypnh0ByZYPVA++AbJ
         iTOOqu4QRQ9ywhZlfJlHD8Ab+JXgjUT8GJ+G0BNVur/i3p8pH2wE5eKJJ1Q/32PoI8yN
         3nl9BcK50q1tNRHnSOkm4TDB/L6uJVTLPk0r75rcizepTcuFtov6iRlejdsIuhad2R3U
         zDd93VNehKMGl80WbEpJowV2NIbbNyrilZFEubsHjFaZcIKreyL/JpdSIBFFkaxIUll/
         D04m+aezRh4bQvh7pD7LzPHAu8/EKi6jvC8DYuBnt+SEkYVpNgiKcazNnq7b46TETDQk
         8oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795333652; x=1795938452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zI8vPiLTwHtdZngpQB3OIEkAQH2ZOP0Pmpcm3gPefek=;
        b=KKj4kvAN0C4/mwg2m4mOfEuj+IRgIcN4+2Yv1Kmt83Jgwwi1ijrcTOyxxuMB6st3O9
         sOjVQaU4QCOxWIJ+CFYPoeaMQmRjSSJ3vmuP3PxxRfFvg8LdN/PPO+FYmbY4HCrON49I
         gtxNTQ2+uHSj3dTnVq6bTloT0YDWe+vqAlQ+Gbr1DprBQD9w5pIHu06I18azrzZOlwVH
         E/XdWO3sqZqZM9D5eztbvZvgQet7i7wVkBJXE9BD37WOqCIblYOE7XtIsNa8EGxUA4fz
         kJ3P7SwXFaIWJduQYhCPU6z/kv1W7glDrFmOExtY1ETbCtr5v7iXdpPMotk5ij5Q2lfn
         BLeg==
X-Forwarded-Encrypted: i=1; AL+hErEueUTFCCVh0j8iNRmNZBLumxTXppfZngrC/OC4zPXKVCwyOWf4Kjju6bMzeUr8BxaCL8jHmj92r9g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Pcu1fiGKJfjqPyjhuVviIQyekqCpV3J6LeOyNuRg+F7tSLRo1
	LF30B3zhHgaKuG6AILGyNK1o1U3urxS1OsZnUi23Hvwh3Kwf7KswyvVD
X-Gm-Gg: AZFdTZfqOmRq2rvwLJF5uoqbsLqnyfab8CsKokujSKI3HLPnvCni4coORf5H93kPuyG
	1fH4SOTWTu7eDOP3PyggW8E77+AWdyINnjaizuDQxD4M9NlVvKDzNcrBNGXJLp3uVrF0xu3hqD8
	bQ8eJF9yCQZgYNzZEpv/E0b1Zsb2bvmqjfwqNltTlq4oxcq0UrajCTV/LZwsUCbv89NdiDwSUZJ
	0WLQrtRcN7UOViyJIKsMu+fMqppOs48cNRNVyHjore8KHR9hPpNSAWsFbcPg1srP4tt253mlA/y
	j5YL/ifJ4O17X+AW/+szVFTnqk2dLu0HAgo8Bg3dlkku35ZkWlwNR3W2zHzuFTU8zvWYKSv7TA8
	PhmfagdRcSjDLGOjl/tZ82wOuIe+f0Ix6Mcs5OVGGtxP60jNfJdmPpXELGdMQkkR0PKCnB9rKFd
	xFj4bPLbCDlLP3oAr7rSq8qqTFvTXrH/TtAzzmklP3deDUcxsaeC/Cl4ofgnctez1Uj9xKTxIRJ
	jYe9LxyptQktqmQtEl91aojP73TfmlMoopO92Qmr+oJmaRXvEqWXcLkTWzOkiFRQFUPSEkNCMxt
	5DeigXHByRpcoQW9vy/jOq5x6TftIijGLwjvtviriQquZDBwt/RcPxsd7HRHNLYspAECe9nr1Cv
	7in+4dxj9g9Svb6Hk4UJGMrUjHC+hAARc56ZDERqf82lhqqjCs6vGFCzrYO0tCbsprMzaQkKtvf
	RCnwUAaFMVhDmV7JWGBMRqiJ5FgdFLlAFbuMV8cGsQlg==
X-Received: by 2002:a05:7301:6408:b0:36a:270:ce76 with SMTP id 5a478bee46e88-38570f2b27dmr8894522eec.33.1795333651851;
        Sat, 21 Nov 2026 23:47:31 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm24898071eec.9.2026.11.21.23.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 23:47:31 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 6/6] iio: proximity: sx9360: reject negative hysteresis values
Date: Sun, 22 Nov 2026 13:16:46 +0530
Message-ID: <20261122074649.239441-7-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122074649.239441-1-kapoorarnav43@gmail.com>
References: <20261122074649.239441-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sx9360_write_hysteresis() copies the value into an unsigned int before
comparing it with the threshold, so a negative value becomes a large
one, passes the "val >= pthresh >> 2" check and sets the largest
hysteresis instead of being rejected. The comparison is done in
unsigned int, so this happens on both 32-bit and 64-bit architectures.

Return -EINVAL for negative values, before converting them.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 9a2796f67949..21c1801cc2ff 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -528,9 +528,14 @@ static int sx9360_write_thresh(struct sx_common_data *data, int _val)
 
 static int sx9360_write_hysteresis(struct sx_common_data *data, int _val)
 {
-	unsigned int hyst, val = _val;
+	unsigned int hyst, val;
 	int ret, pthresh;
 
+	if (_val < 0)
+		return -EINVAL;
+
+	val = _val;
+
 	ret = sx9360_read_thresh(data, &pthresh);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

