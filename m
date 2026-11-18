Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020073;
	b=1QymcirgCT9jB61tI+lKTKnoc8t5K/4LCt30ROlYTt7QR++K6ey0iNl63cr8Ce+pffI/
	 aLV7Uu1He2tebfjvLZVg1MCUHVDGetYcc2HZjNYRAO+nIXZrShU9QoMMOBkuCiMPBqdIT
	 MRSeFlfD3qx3gZo9hWM9y6ujM8PDmSoknW5bjrA3c6bvn2irJX2pBKztINnXTBmkinWsi
	 rPmJX1LnVUa9rDm8tVuus+GupoOOsgmM5ls+9ergMuel3bPymMCjFPQK/xsNCb3DbSOAY
	 aN6l5AoNlhc19B+K3y3lAI4ACMFDDAq2RmZXRbuJ10qeQ1rsqs5CV1zF2MslVHLflVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dvAzJc66WDQmGpxUAtDLCtw0eHNkjSaLiA8bjaXpai0=;
	b=pjVfxMIO2hR3GXu3SmnB+3Hzn2VXzCB/f1nNGJhvGxOIG7w1rbiOgOriTq4ArzqCy1lS
	 UOv6aLGzCbnAxt2Aom4tBzeIZtF9wa9wC9gnei19PmS3mgYBU5+2xxRC1lH5/Nh0O5Dup
	 IEOA9Y1SNTl1cDAQ0fEER8IQDz8dPNRgNInzlH9deSQFbZoQudX2rWRxk6Fmu1SvbVCkr
	 tiVbPkheWJcrr3vXnW93RyTRAwRtS3RxjqmxOX4gz/LndqL1Av9anxWhBWKbAWzhlnNn8
	 y+Awp5ocpCnFZ6NvGJYy9+kzluAhU35iFbhZTtld0GyyWYrI9RqwmZYYpnR3F+IBa/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXhvMG6C;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B428D606A31C
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 16:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B428D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXhvMG6C
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b546061d58so1797275c88.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 08:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795020072; x=1795624872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dvAzJc66WDQmGpxUAtDLCtw0eHNkjSaLiA8bjaXpai0=;
        b=rXhvMG6Cyh05y9uIqxkR4ZKq0h0kgeiEZTS34LWaJ1SvJAdSsoHB+zIpzHEF+wSb1n
         kWRg4AQwFTDq5s2oPEXpuxQlFYjZVd0OpllFBW6/hcKNWMDdxGATPpktI2m6gTRhd9tR
         BdYMrhJI1I2TrB05zND+Xmb/thS/NbLA83tL6jam2JouBd+f6c/ue1D9R3CIpx8/Uk0j
         2uNmm6D/CBTz8jPnPbuv/CU5sp8clNXEQ0qIPTqClGhsHyCgcUJwKeE16kVr8Cu8ooNF
         8uj6cN+sldH3DO0noqZiLvOcjFbfbPAZQvR0W6zJR7vriCsCDOiBTC79yk8qXHK9fLj4
         J/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795020072; x=1795624872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dvAzJc66WDQmGpxUAtDLCtw0eHNkjSaLiA8bjaXpai0=;
        b=b1j0eOpTEPBU8kV85JuCpnZE637BcG2mefbE093xRPZrcMR5uWukx0DKoj4IkWbH5H
         2Hl5BDF17bPvzwiMMLxgzce6w9BIPuXlO3hEt7mEvNDw9lIPRfHEmn4w5vrEsSWu6R5L
         4UzbYqnF2R55S0NglsrKWzLR3LpiDtEKMzq0q2HfgEsL0OZzHHp0LlybsWZhC1r8eO/5
         DiU1ylvcW5+O/uW5MgXGQK92Uo61fNbAPm0Foj19HFljUQNMjKu/gDJWIWdGj9roPI+n
         upCBmoJtRqDlrTeovnPcpJZwViYqpIpfZjm24QDHblBfjSoJffIszqJdIbSHEaRX7axO
         cFjQ==
X-Forwarded-Encrypted: i=1; AL+hErGL0nar0Vjaj1a67GMfUWPVTljzqwcC/kGVxofOIXXeEXNmrA+Zd0oT1j2XZausNr86ZD12uTWz1xU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LCXZKwGV8x6wgJ2kfRwO2bNGlL0EMPRtarQT1aZONQ4jWXUop
	fYiaBe8yrTtyevwv1+Kq8LjdfsD+LuUeFcM1c2wANthC1D2bGUXx1giT
X-Gm-Gg: AYBFou3VBj2K1R4wQii96Tq04lZHHhYeKHc2n13HjPjd1ypG4wBlT68MoG64SrRcqHB
	GH563T+9dbkomAik1Sa/p1feQ0mzedZ7hu6q0dcqGWpNO51jHZ7CKM3q8elyXUS7PwrYjUj6tR5
	jmI9x9FBPEbIb7bOc/oZv6wD/ITDV5z3qTNSWICt3xQEGQ9uVG0kmjpvPHuB9Iu63pHnm+STikT
	JAtRcUNwEct17Dyx4myRnBw445a4LS2Xu+ObSsJMZlN3IEFdy4QTMepq6a3QaYpUtJuuLmXdAYJ
	VZlNyEPPn5HiBkcGzh7gCIK7/9WOlwFBbwlmAuc+wgiuRa2432Bh3xMeMWuiHAJ2WtzlGGpgsdo
	AMZr/X5GGgWOO4gM0ZhBUsylTh9Fb1FAY9qymiBMTnDb+EzFNIoDdJhP6x0oUk3c57BLFoy+ZZt
	rkrTP3DqV0hQ3pZKf7aBPFarmCMb/e+CUq5SJPnyVW+oLpKHyxeidcy/CN/LrGp/AHnD02VC2Pz
	BekSKVZs/wYBUJ792m0ylnLXp1Xt10gWzJGuajZA/65rVjV4l86nbbQcnjmopwHHSmS7u4z0hnJ
	VKOMyZiOIm66UI3w8Zej2uVt9VSgbd1w8orvGndTvGYr2knKoOzyow==
X-Received: by 2002:a05:701a:c961:b0:1b5:2bcb:8691 with SMTP id a92af1059eb24-1b543c447e7mr2952861c88.42.1795020071657;
        Wed, 18 Nov 2026 08:41:11 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447dc5e9sm11140414c88.11.2026.11.18.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:41:10 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Song Qiang <songqiang1304521@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: magnetometer: rm3100: check TMRC in rm3100_get_samp_freq()
Date: Thu, 19 Nov 2026 00:41:06 +0800
Message-Id: <20261118164106.4108794-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

rm3100_get_samp_freq() reads TMRC from the sensor and uses the value
minus RM3100_TMRC_OFFSET as an index into rm3100_samp_rates[] without a
check. A value outside 0x92 to 0x9f reads outside the table. The driver
only writes values in that range, so this needs a chip or bus that
misbehaves after probe.

Commit 792595bab492 ("iio: magnetometer: rm3100: add boundary check for
the value read from RM3100_REG_TMRC") added the check to
rm3100_common_probe() after a crash on failing hardware. Do the same
here and return -EINVAL.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under ASan and UBSan, which report
nothing with this patch. Not tested on hardware, only compile-tested
with W=1 on next-20261116.

Fixes: 121354b2eceb ("iio: magnetometer: Add driver support for PNI RM3100")
Co-developed-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Signed-off-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/iio/magnetometer/rm3100-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 46fce2978d76705..2fec02e5679eaf7 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -279,6 +279,7 @@ static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
 {
 	unsigned int tmp;
 	int ret;
+	int samp_rate_index;
 
 	guard(mutex)(&data->lock);
 
@@ -286,8 +287,12 @@ static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
-	*val2 = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
+	samp_rate_index = tmp - RM3100_TMRC_OFFSET;
+	if (samp_rate_index < 0 || samp_rate_index >= RM3100_SAMP_NUM)
+		return -EINVAL;
+
+	*val = rm3100_samp_rates[samp_rate_index][0];
+	*val2 = rm3100_samp_rates[samp_rate_index][1];
 
 	return IIO_VAL_INT_PLUS_MICRO;
 }

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.34.1

