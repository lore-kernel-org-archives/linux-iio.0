Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782814;
	b=eQ7u6VKqPwmwF9VMpix4Hw6D1iVjxDewFvEGuT9rHg/2j/P9Fy6nt65by/zGLKmq/lwe
	 EFa2sUW5wxoX1qZmpQYtrNu7DJaiLsqPqoRiEBl/liNVKM3R0rsvNstsN5QX2WJ6BgB8p
	 7KT7kzxywEtYR9rgyPcORoTr2XRWNSNEbbdMXO5sG+tC8vncyqyj8osxp/Gd0mC9HcWHM
	 LE9a8hB6unrZ6E+8TxIjupEBWju0UKHZ03Tw7epovM2JZA9OaayXa8hcfLj0oqpq8ab9F
	 kVeqV9fygS0Bsw+R5rTZO5INwRc7lbGL3KWF7E07NAawhfo6fc7oc28lK5aVQoeqxdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hIeANPuOo+0UodL/jtwBsvki60pnCVOtzVXCd0ehd7Y=;
	b=Q/G1tjKr8r0O3Udui0wIYwcxvQ3+stYN5yFjog9fXnhGjajYJZDp5bi/5w37qlxFORMn
	 SGmdpV7bnB5rTOlvaD/9EsbVzW7YhjH0tlJetqLysMXhKq8sJxfuNUX+BI5FjeFiEy3RZ
	 rqXKXMl5cP5gxxFW7JtyOCMlafrPF0RxnOgbwIg4dyxYwHhrpFxx4vmfQI5wHeQ7/lMZi
	 YHEkcEl5D1+DkC4K6SHlEncZmM9ZSAlCqjfZa4MngQSGjLlG3wEjRzitcwlscpEKYW1xY
	 2vFBPvoTPI6RN+VmAmlA+mzvrDmUW2hILSph4tzhu7M/nrGkZIEJJ0+ANghV98Tic5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=THqREuWy;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD72606A31E
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 12:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD72606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=THqREuWy
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so3941944b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 04:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795782813; x=1796387613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hIeANPuOo+0UodL/jtwBsvki60pnCVOtzVXCd0ehd7Y=;
        b=THqREuWys77wZVHbPsPC4rZDghJLvvKLzd5ojOdrqcJ8ENogbFgTYxP/SPAOD62FRd
         UKRvmIAoYskIyLG/xdguiKl1GDYRpnuyITv7WhiS5OBE6TUbrksxzY94omI+PYR17acG
         FCMMGJgqKjatnBZ2miaFIiZUUygTTYNlP5VCPj3lTJGa12RRP2dFmcGCgPPmvzQ+ffrR
         v20dYvFhMoAo07r9F6XEOOB+FaAwM60DDV5xj+Lul5/wl731RsAhIR1k0I0Jt+1QNp7I
         py7I33d0YMfknm42p34soOWtPutXz8a6mcaPHWM0Zv2KOIIT8F/Xko6zClxIV1dgxzpM
         CSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782813; x=1796387613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hIeANPuOo+0UodL/jtwBsvki60pnCVOtzVXCd0ehd7Y=;
        b=HzetqUiP3j9Ho5h0t4KVAXuNR2g3/u5fSDtpPOl9Y2QmWfABVTl/ZxAnd3E5ZJfKA9
         Em/ksQNECphxQkexNuxmi3pey78v4/4IPfElOIAo2Nxq9Pi+HD3Ep3ICpZgGQye8dpIm
         8E4kXYHx4LKD4IkG8hfwqEyoTiDPxJtUW4vwKfzTkwZdIcOxd1mzU53+/b7+E7aOnLs4
         jdM6P/XW5QvY3C5d05Z6DQVC/yb3kPBiE0d2sfJx0TCCFmls0uCCxgjsT8EXsMMJhcHx
         hP+sC6GfmaS/aoOZv0CWQ4Xqph+Uvbp/EbmiwJZfW0pAoNj+4UuVLQrgi5zOh2CMiBdt
         4o6w==
X-Forwarded-Encrypted: i=1; AL+hErF1dJldbCtFTQwiSRX7IJox6VrQFUFDwJCPlNrXHBw1Cp8BktuGo2vKuCVsGwWtzQyhDjU5Mb8jhwI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8d5ad7VWTfjio8twH/cjbuvJMkWS2nkCcbfZ0RP0HhSo1jh5gN
	MWttOD/T6ujbO1EerQ2d0amJ10FvjaYjJKErmN2CKHAwN0fQ2cZ6h4hJ
X-Gm-Gg: AZFdTZeqOXq+RNI9MXFXvhGNL4DFIhvfHDbNRdMmDSjS8H1oaWzf7U6sttcNbgnoWmE
	MObZTSPwI3hh03Sx5rTTSb1r/3PGwpy/xF0/OPpeOOiNOAS4HwtKg6K4iZ1A+brpguDMGtrgte9
	0LnDbqQyI1GmQeBGwRrEUAbEq9phrV3/ABj4cRPTAB+Rwrnxn4NbJESNnhqwP0UiLn0tSKFVUdd
	F0S/32tbcmOgqqYCmKSvmXa2X9p7Xe1cQjlFzoylSMjG9LlTguxR2FK40YUOHiJqnykwlf0Hxjl
	Ofiza+++1YIHW+LnV1bLruHFBlRw9ojtc2vyOr2ZM3suqks3EwdDjBrAic/uuYWoXVuCGab7nEB
	8smzVjIIv3iPl4+GwKUy1XmIqh3gqg4zXFpODAGmSno1XgGklnYEp/VJcbXumycxTaO1bps2IpI
	EAnbRUu7X4HY+l6UIqDzsDPeFzAxU+MRTRTcX4EV24+NfP55UsHFAgi/iDpjW1kXLjv3nQkdPVb
	HkcslA4Ac8xI3EOL+RPbYdY+B2In8DprZaYRTnaaosfxSBm/UTMsGBYcyredbBQKvtZ+NoLKz49
	9Y55Awp8s31kThU2TZETbfcgCoJIQ7hon/GEiJCtHApZUNlGeXfnF9bdErwt5ygr8r7IjKU=
X-Received: by 2002:a05:6a20:6a0c:b0:3f8:d7eb:1ab9 with SMTP id adf61e73a8af0-4014ca4512fmr27148069637.15.1795782813040;
        Fri, 27 Nov 2026 04:33:33 -0800 (PST)
Received: from localhost ([2401:4900:1c2a:12da:3176:e694:92eb:c932])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077944bsm12568899b3a.2.2026.11.27.04.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:33:32 -0800 (PST)
From: Punnay Sharma <punnaysharma805@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux@analog.com,
	Punnay Sharma <punnaysharma805@gmail.com>
Subject: [PATCH 3/4] staging: iio: impedance-analyzer: ad5933: fix settling cycles readback
Date: Fri, 27 Nov 2026 18:03:02 +0530
Message-ID: <20261127123303.144052-4-punnaysharma805@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127123303.144052-1-punnaysharma805@gmail.com>
References: <20261127123303.144052-1-punnaysharma805@gmail.com>
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

Writing 1023 to out_altvoltage0_settling_cycles reads back 1023, but
the chip uses 1020. The cycle count in the register is 9 bits, so the
driver programs 255 with the x4 multiplier. Odd values from 513 to
1021 read back 1 too high. Values from 1023 to 2044 that are not a
multiple of 4 read back up to 3 too high.

ad5933_store() saves the value in st->settling_cycles before it
divides it by 2 or 4 for the register. ad5933_show() then returns the
saved value, not the count the chip uses. The ABI says the attribute
is the number of cycles before the ADC starts a conversion.

Save the value rounded down to a multiple of 2 or 4, which is the
count the chip uses.

Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 Impedance Converter, Network Analyzer")
Signed-off-by: Punnay Sharma <punnaysharma805@gmail.com>
---

Notes:
    Tested in a virtme-ng VM with i2c-stub. I have no AD5933 hardware, so
    this checks the register value with i2cget but not the real settling
    time.
    
    Before: 1023 reads back 1023, but 0x8A/0x8B hold 0x06FF, which is
    255 x 4 = 1020. A write of 513 reads back 513, but the chip uses 512.
    
    After: 1023 reads back 1020, and 513 reads back 512. 1022 and 2044 read
    back the same as before.

 drivers/staging/iio/impedance-analyzer/ad5933.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index da07a75ad3a9..bb72d9c55f6d 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -414,13 +414,17 @@ static ssize_t ad5933_store(struct device *dev,
 		break;
 	case AD5933_OUT_SETTLING_CYCLES:
 		val = clamp(val, (u16)0, (u16)0x7FC);
-		st->settling_cycles = val;
 
 		/* 2x, 4x handling, see datasheet */
-		if (val > 1022)
+		if (val > 1022) {
+			st->settling_cycles = round_down(val, 4);
 			val = (val >> 2) | (3 << 9);
-		else if (val > 511)
+		} else if (val > 511) {
+			st->settling_cycles = round_down(val, 2);
 			val = (val >> 1) | BIT(9);
+		} else {
+			st->settling_cycles = val;
+		}
 
 		dat = cpu_to_be16(val);
 		ret = ad5933_i2c_write(st->client,
-- 
2.56.0

