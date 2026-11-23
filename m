Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452789;
	b=LSEhZuEaesm0+uFZDqGEPliOaAdIyJOEzGwy5sbkyBnpxFcjtGKSrn7trWD7WBFAK4IX
	 WcsRKb3j74L47HvEUTrLjQQs/tSL9C0/bspsnyxe6ZTwiuclM4fTG5QFjn2R9XEDUSRwS
	 q0CBiRuunRAFXpPL8y4z1ExTpzT2zoHqjxid6RghvI2/qHyR2nHMA2ftvk5tynfR6DDPs
	 WZVaFfXZEnMjvsjsZuyBAGqaK1JdVrvURp5vIv054Ijmd5JUr0sujLuFFb7mn+2lG04MX
	 clN9IhbfCN3tompUXXSgQhy6p8388vdLTneQsgG9AL+4hUmZX2YIh8u1p8fvdNX1WRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vlW+/uQXinlAIx3W5Fww0L0MiqVj5LTP/VuZyzEAKC0=;
	b=VX6pzDhvYAXFSk3nt9hii+DfY3buP9wT0ws7pEBzOOT1rynN9LWXle2F2O4W/A0hpjmI
	 QmXcq1mBQ2h12Rn1yqcCD4XG4+EwPq5s7JQkmxHMFKz5aZ5M6fzibDLHVNkPkvBbX8lfV
	 vl01HUWT0xz/+7hSSCLPn2OWgPhqjG0eQkFmX833/gu4EoJLMpCU209pPvRHkoHuVBfi2
	 92w3nJXAqOV0O5AZommJilNoCXDrWz+SM8AB7NNeqYZ/NIb5URyydnMlw8XV8JA3Uf4iV
	 gxnfvVB4u2r+ont1SQFiYPW/22b8TyZmKd9qJm3Cfpjv0Ilg4nr8zpyjmOSYbE7TuGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C9Ehjifk;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E9606A31A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 16:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C4E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C9Ehjifk
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38692f62b22so2394243eec.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 08:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452789; x=1796057589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vlW+/uQXinlAIx3W5Fww0L0MiqVj5LTP/VuZyzEAKC0=;
        b=C9EhjifkniwrduHkB0S/JJtqsRYUHS0DebOI+roJmCiKB5ILd2TJ28zkQjasZ4GEtG
         Lp8BQqqkmNdee/0ih/Gth+rnrIzH5K5vfr9Q19V2JIOuuPJawtswBJkpxH8NprTedL38
         QdEH08+08CYKLNsO6svpyER4ezY6oXSH341/eqf5kNdl1sldC+tToI1Sp7df9yWdXKz3
         bZP9flBAvsZRD2b90lSgw2ZA/Rx2+DGn+3/Cf0gfg3b7MiO4i6ub4cHhkkPZPnU7fVN0
         9uIqIsv0oOurI9dU+hjNJ3XwPaXpI6oAzAYf/VzdQjlAEQV4YCZ6viKGPrSFHIOBN5+x
         zDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452789; x=1796057589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vlW+/uQXinlAIx3W5Fww0L0MiqVj5LTP/VuZyzEAKC0=;
        b=T2Wo2oEBdLcyyS7iOkGc3gbPgHxCu/LREhKFQdzSf1aM21RQ8dhbz6sC8caGYRo0VT
         5c39njGzrV5W55W1gPY8kDuHlS5Ch37N+NXSYSuHEimzIjde8aa/4cnPqnMibvUtlnNX
         8Rysowj3Q0SAz8VyEPqfEC7EClI6nZ7pKJkmNYppWFWjjLVyTmt1RdyC5cjdASAjfHr6
         NAWanZTcIvhp+ROsMQh9b0LdWhQxhgR3WNZGcD4BXYJfdaPnJeN4L6C67hTAPccA8Yh3
         NdjwzVmxIHVuVe0JahsSCsXc2ZC+NtrF6VMZ5w9oRZqUVRGYizhJSjzQIC2ytiu9hV63
         9WSQ==
X-Forwarded-Encrypted: i=1; AL+hErG6ZFkBQYj9NM4qJYU+NrYk6ukJQA5hxaGXFal5QEggzjNc1CHkGRTzQtkllvC6Fx0casoz9KGB+aI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TBKRVAgzFdfSsTlYaGZ5IXVyj5ai2arAmYyQKxy/kt1xmheMO
	d9xLEjMv+m8VX5DxHVPHK2+gdImfosh3VKxVZbGkhHWhvGwxn3elb9dL
X-Gm-Gg: AZFdTZcAr2nNrPm6Z1B+NeY5uYZk6cXl4HoRjdmqdhSJ0A97wUVt15WZ5/8lZzylNLG
	2UJgu/E67S4VywHfax6QXqbBUf/rTafb6PB9mA2Sg5zTjFDLoZfUnGi9wAi9b+YJb9eZGuQCLAx
	F81X9DXHZaDN6kh8ZnFokuItlWCRWnxkC5g6e7VOSQ29UW0FnyyCm4OYN5oXirrOheSBMsRcfBs
	jmB286giEcP/nAxZXLXnosMPFKAjpev1/DhTzaHWgpNso2RbHPgPUaiRkeq1OCxMtBIr0mCWDOM
	sbE9Y5HwIHoqSKUTrKvOe4xfHFBzRWrAlw/gYxB2MjD4oLmbxAuwrlBS7K8PsepvzoDmW9fhVQe
	XbKKlwZb28n7+IyHnNyHGoucjV4lEf0lMs/99lkQzb8RUdZCGNMJh9Rv3HIEcf8EFawLIEMXajN
	nISbfcJUjrl2QUwDUCbaP9OIoTPLYuY/o+QO8fofYkrjhJj1d/M6Kp3Y5zcpfte2Jtn84CQBxhn
	pdfferVkFPfVVHkRQDLLHw2gBIvb3E2k6p+x5FXcRYmFDwX3buIcOfw5rlo3C3FnBNlRSh8R9qC
	F9vE75Vy/peV/CJosZdvcO6u0UwmzhJcoDZnf0pL1M352N03JEYZcIbEm5So+zzYxyhVxLIeSrb
	NmQPfaLvJWJnGYPHFDTArphPVu/yManMOBCBEMbLCCa4eHfjp7vw0tvFjsjqwHqHsc2fLLdYTW0
	MXgoB2qj1iDzMhCtRZU/HJpUigMFBNAwa5ds6PtwprSg==
X-Received: by 2002:a05:7300:6d03:b0:375:b560:a323 with SMTP id 5a478bee46e88-3856c0ce045mr18190158eec.1.1795452788354;
        Mon, 23 Nov 2026 08:53:08 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm47196668eec.5.2026.11.23.08.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:53:07 -0800 (PST)
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
Subject: [PATCH 1/5] iio: proximity: hx9023s: fix division by zero in set_samp_freq
Date: Mon, 23 Nov 2026 22:22:47 +0530
Message-ID: <20261123165255.239490-2-kapoorarnav43@gmail.com>
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

hx9023s_set_samp_freq() passes val * MEGA + val2 to div_u64(), whose
divisor is a u32, so the sum is truncated to 32 bits. MEGA is an
unsigned long, so on 64-bit the product itself does not overflow, but
the truncation does, and on 32-bit the product already wraps. Either
way, any value for which val * MEGA + val2 is a multiple of 2^32 gives a
zero divisor, e.g.

  echo 67108864 > sampling_frequency

(67108864 * 10^6 = 15625 * 2^32) triggers a divide error, on both 32-bit
and 64-bit architectures. Negative values wrap the same way (-67108864
also gives 0), which the check added by commit a318cfc08537 ("iio:
proximity: hx9023s: Protect against division by zero in set_samp_freq")
does not catch, as it only rejects val == 0 && val2 == 0.

Reject negative values and do the division in 64 bits with div64_u64().

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 2a6da557f22e..eaf962c29256 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -718,10 +718,10 @@ static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int val2)
 	struct device *dev = regmap_get_device(data->regmap);
 	unsigned int i, period_ms;
 
-	if (!val && !val2)
+	if (val < 0 || val2 < 0 || (!val && !val2))
 		return -EINVAL;
 
-	period_ms = div_u64(NANO, (val * MEGA + val2));
+	period_ms = div64_u64(NANO, (u64)val * MEGA + val2);
 
 	for (i = 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
 		if (period_ms == hx9023s_samp_freq_table[i])
-- 
2.53.0

