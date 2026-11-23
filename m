Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452808;
	b=03jgsMsZLoM9yv+hiMX+wimN7u2NO8vZnPrk+FI8+ymGH9iiHqFUSLBJQQgjhB/JGnQR
	 TlBoHC21JVbpYTpib596XRNVEhMPgCX7PEKhwt1ZNBMIlX2XuT8/OQkDHCWif3lh4gxc1
	 3r/jFUyw9gIySDKL8tlyVdHn7CNBoKXLmlmBTAup994qRKyE2E79p46dJGf4rQkQ8gX+/
	 loND6Bz0gpd1NXonA758WkOdt7aW39fC5E/WjdGomrFDKJ4Nc6c0C4aod4y7biuqkik16
	 4YqTEUSawbP4ftq0Pln1rYxSw86ZoKF21NUHfmDChTda6RNWDUxhHU/0ohYU4DgU3kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0hMDwGIZ1CmuXEKexNJFNnVKPQDIFLNJNbZG3fq5Pmg=;
	b=5HkUYu7rDyckej0Fnr93Hs5ykVEE+1nSCHq1Di+UWVB2KkxY9udbmrSlWao3VLtZa73n
	 bXIjP6B+ReR1C8SUvH71zCqRdQqHHK8NnwvTsM88+9vULhgBWi67BoDyYMS+HCRN7xMcg
	 mMIahKd72LCzfhdf1BODXV+rIw0QqxP7/DR1mFUoCidZlFvP/TAWcDiUyWxU/M6WHIhDZ
	 JQV8ZW4YJQXnXjXLimXeZVPeekH/kkoQsg2zaDkUFc3OIXMMXeMEe9Jknqnkobxa3iFIT
	 hCXZ3QyrVnu24zq+8Bc9Vwj8ufY6Ie/A0pJf9X9ncS5Zahx49Wd7R9YU+OzAoWmsMjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAgI6mQ4;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32185606A31A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 16:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32185606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAgI6mQ4
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-382f4710a17so6015846eec.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 08:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452806; x=1796057606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0hMDwGIZ1CmuXEKexNJFNnVKPQDIFLNJNbZG3fq5Pmg=;
        b=QAgI6mQ47O9O0YdUtk9FS9leGpox/ZYcHHkWibAZkpfGQqG1sSwiOMdvLdbbLdQcZP
         DViA1VkUEfG1Y/imndnV/yi5HD3WdhDB8a7yVsvX2tZgxK94FgWjdHerZrJvmgWflGfk
         adyh8wjnKg3JF+LjWlv3ttE2KPHzqgNwnqx4a4xOGan9xaHRvyiTUpJ8p2Dmqd8DOQL+
         PrZg15j8FhrVa3aoOtWE3xNsSTZ2YsKN6g9cOlGNExVNB2efejhEXAHFpzQaDLQ3cbHU
         s5nJZU2fV5nMtYIHQdXoqYV6YCOWfM00NgoJE0hd6xjNZo8tKazHUq52qWYhWakfarNv
         JiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452806; x=1796057606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0hMDwGIZ1CmuXEKexNJFNnVKPQDIFLNJNbZG3fq5Pmg=;
        b=rlMk7bI5vnQO3F8CXXlp0QtG1VbGpH4eekAOCS/uhCN3jluA5RSmVusweSBAjoGD/q
         0VSUiFoelxGRRXUR/8Gp4YiQ1zwwY9Cpq2gNLjUpfMAdA35ZR/lpQYwwVY/lz6vtNL3E
         Y+2oCG5LoOq7OWUL7agNJZpEZndEPb7C/zJs37Fx2mn7PCkDcjrUKAgOFCHcGXRV1Zo4
         EGirQnvE0/PJHEVIEb9p1az7UKsm6hiGwZerQM31Zo+qXIrXjFvU89W/jaj8Ca/I5AAH
         ms+sek/YLpyXG+nF1foxLSnniuu8gtcW/FngjpSGuNxrFrSqMygyCoaQBrPl7Kg8z7dC
         3Oiw==
X-Forwarded-Encrypted: i=1; AL+hErGsI8b++jSGs07WcRTf/qnCLskzgDdhbN/SjQfzV7e4SJ/BBN/IWs5qA615CJ2K3TsmjfJ2LuJoEpE=@vger.kernel.org
X-Gm-Message-State: APuU4Z89U1UChdY9D0zuzBsxLQo6RE1n1piZSd5m5Ti4hqJ09Ci/xFNw
	YX9PxcNcvgk78FzSLw9LUwLtznGO7eekp6dDmQCFRRmWgAADeHfzY2Lg
X-Gm-Gg: AZFdTZeVxKmAzjtFOcJnoqHu8QjpP5f0FTVsL8kZJu6YdMllwd5sQq1hWcF0JZnGRjS
	IF7ZbhIYnGM6xOfXZYtH2ZvbanywJL57oV4YD4qY2HoRYYISKpztzd5gybNWkcrdgKfZsCrBDRE
	KG04u+pMXucRETmp91x+sA3HzKLT2jz3r2b3VtjgW0IwEX13ko4Ipw/gXpiuBDu7GBKXEQQualL
	t7uBuM+fT4BqthHfD9FnCESBlSiE+ENTzGJ97NT+0hWRWry7gAQbkXkJm/Aesg6W3dnXxRPCRV+
	1r+j3mLCGts6w7tbQ8P+JN9FCip9gcX+CjXq0e1jetNBkj8BJ7RAsSFG+L1NoHTRECUI9tV5nTq
	ELB40DAH1LFsExey2B12bs2x96CT9LPdslUfJhC9dKHYzoXokH4fmGkl9/3FzO3+9h5ipCmw93U
	Cznfu5JpeevMsjZd5bbV+xDCSKTyz1BtHBV5w+QFbBwwM6q23d4kCG01+rP8mXq34Ttd+I4aCqD
	oxHhMsTNKlJ6weiZZkNLZbvV6IQHNC0eQr5D4OseX3pAhKz8mNCu4Jb3aeERijjwqCiEXTEg/IZ
	BJyd1XHJFPgmicObUmQVHlWIbbybpyDVgL8zCWkfeXesILcXZc2TpD1FmXwpc+p5LE+WAR+tk1n
	ouDPhrAPcwgpKscKFD8tnYHOfm3N73llvDIGC0Sp+CEUrozZspRz2kYxe/wRHkvF1oHaMIb6gOd
	fn+FoGmOZRPFRP1cQlQi4vX5ESp45N6hfqptfGJFk2ow==
X-Received: by 2002:a05:7300:1c95:b0:385:8851:fa4a with SMTP id 5a478bee46e88-385885211c2mr12324049eec.6.1795452806183;
        Mon, 23 Nov 2026 08:53:26 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm47196668eec.5.2026.11.23.08.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:53:25 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 5/5] iio: proximity: hx9023s: reject out-of-range debounce values
Date: Mon, 23 Nov 2026 22:22:51 +0530
Message-ID: <20261123165255.239490-6-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123165255.239490-1-kapoorarnav43@gmail.com>
References: <20261123165255.239490-1-kapoorarnav43@gmail.com>
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

The near and far debounce counts are 4-bit fields.
hx9023s_write_far_debounce() and hx9023s_write_near_debounce() pass the
value through FIELD_GET(), which only masks it here because the field
starts at bit 0, so an out-of-range value is silently written as a
different one: 16 becomes 0 (no debounce) and -1 becomes 15.

Return -EINVAL for values outside 0..15, and use FIELD_PREP(), which is
the right helper for building a register value.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 1545b4ed2ead..906fd4baa468 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -359,18 +359,24 @@ static int hx9023s_ch_cfg(struct hx9023s_data *data)
 
 static int hx9023s_write_far_debounce(struct hx9023s_data *data, int val)
 {
+	if (val < 0 || val > FIELD_MAX(HX9023S_PROX_DEBOUNCE_MASK))
+		return -EINVAL;
+
 	guard(mutex)(&data->mutex);
 	return regmap_update_bits(data->regmap, HX9023S_PROX_INT_LOW_CFG,
 				HX9023S_PROX_DEBOUNCE_MASK,
-				FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, val));
+				FIELD_PREP(HX9023S_PROX_DEBOUNCE_MASK, val));
 }
 
 static int hx9023s_write_near_debounce(struct hx9023s_data *data, int val)
 {
+	if (val < 0 || val > FIELD_MAX(HX9023S_PROX_DEBOUNCE_MASK))
+		return -EINVAL;
+
 	guard(mutex)(&data->mutex);
 	return regmap_update_bits(data->regmap, HX9023S_PROX_INT_HIGH_CFG,
 				HX9023S_PROX_DEBOUNCE_MASK,
-				FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, val));
+				FIELD_PREP(HX9023S_PROX_DEBOUNCE_MASK, val));
 }
 
 static int hx9023s_read_far_debounce(struct hx9023s_data *data, int *val)
-- 
2.53.0

