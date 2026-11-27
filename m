Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782809;
	b=j8qZs3ePKjme6HDKZPkQX95o0cfyrCE/xM8+x/E6BAtnWHUSnsdAUQke9HZdeb6dmlhH
	 dRcOPn/aFN6sHKnbPkV/IQmNShisOi0qbBlwJpNVqtlppdt/0N/DzV+BdZyEIQkFDDj+Q
	 2o0D2fAzOmeRHxHR7MHmCi4Cuouko1a6Gzo5IOQgCKvgqCca6hMJaCXJCKZOif1/+PBvq
	 +6x2S7858/kcU6OxvlM0lvmE/pE2rUMs7OcYSe1xGfhahnsWbnUFSgRez1FEH/67Mg2hd
	 +CcjQdJIMpP2pWS6Rp0aGZ9cMlc8oVAeXr/6kuzbH45fn/N8JV6Yio0mXjilqhehT8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Uvh4AWWzO4kiSVlySE0GOXT3P3aE1dpUQ/DuKk1yuDs=;
	b=i8hNDuIaWO92TsF2sg7/3TVS2FfURIom4lDLxwmY2N44f3Ly/rGvvsdMqoEHwhyRehgc
	 gjJa/l7EU06O80rbCy0DK9geyNI4eW7Xi3qVce8Gta3tB2iAB+KhHtkEf34P8G08fyILR
	 lwvz3N2YcTjFC0/Po+MhWeEcF6h0gxqCHXZ1uIhaoRNAg0D4x1w806rwI7BeQjiBnNSU5
	 smHd1ZW5K3aPUa0lq6EcYAvFGDFeTsQz4jcuqoFj1xV7qoYAzWMgf5KkN5hrsAN/444M4
	 Rd9OwFCymdmNzAecESLp0SJIJLBoNgdnYv+urFH5C1sfBVzLtHuwUd60yhxGfMAQERQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Y6IM/sZ9";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF3606A31E
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 12:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BBF3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y6IM/sZ9
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a594d313a3so5263195b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 04:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795782808; x=1796387608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uvh4AWWzO4kiSVlySE0GOXT3P3aE1dpUQ/DuKk1yuDs=;
        b=Y6IM/sZ9sta4L8BFf6R7U/XIGH0EFgwibL9R6elR+C5W4/ERbvWR4qF3i/8SkN64xN
         iYRIAASVp3ZO9+enaObL4ay0NTMQRNrP/ePhc70oBcoicfaSap4V6bo+rrUWOQpdcK4v
         U+BjOXp4PViNkdS+a0FVMXcbnpeTZlceTtQDAhhZenmrmJChlvFev2sVMRWrmJ97FTqI
         8qiE+PT6ZUuWmkurIih6tx3S6bURDBGlt21r3IAvNHC/0ChSzYnoRkVs1B/sku5/Q1yF
         IkK9atqdG+bvBPhEYZqTpY1GumvQ98ICoC1tcNn+Ruq2mK7NeQAhwLlrkGhmzccMxtLS
         utQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782808; x=1796387608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uvh4AWWzO4kiSVlySE0GOXT3P3aE1dpUQ/DuKk1yuDs=;
        b=K4FTA+rDEZYvTyueGd647sTCyIny9QiFu32Je6S4aTZB1KrRBzvQfHphrztpb6sJeD
         yLTrEFgsJTKInjS3qXx3U1gU8sMtYj4qgXN28FdjTiAjHmANvR+jGbIhCDs68PgYWQvg
         dTNU4FBZbcKHdrnQ9wAv7p00gZDNTdiFgHRwHmjl9QswwpZjZh+VsYZYved8NHFj8I1h
         /9jkZHSC0kNSTw6jE2qHoPihcDa93QgVxT5v8mGdhi/gJdfVmX7wgtMkKAXncluJFhGc
         C5I0mYhGfA6VZIbZ+3IfQlxxcoqRl+ZqS28FY73AcsYf1AFJd3reTSLUfGrK60I6nUQu
         hEFw==
X-Forwarded-Encrypted: i=1; AL+hErF4Gs3Bz+PFg1R28Bl21NqqrsdbF3+r260Isems64mwsqZZt3ZvXv6fkngZZHkUCsdPISrBBbbZcKk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+d4LLwECRJVaEkU8chtahsRkOP/YgviZV2cpff3TfET19ySCzk
	mRSfF/zhBJp0MFKCHG/EGqAZBYmXl90J9baLhhlBaA2PpeXkSwBGBeI2
X-Gm-Gg: AZFdTZcPHfdRoZk0GL5p9KdPMAbY0RoLIjAO7aLxlKz82lM8XU3IN2Eh6/00tbKUQjm
	dB2ZOoKDZLBZHVIOnO6KT2oTSN3JR/8lrswD24Obp4Yrv73EHkjXqIbnDIMhcgIJ/RFvUd/HpvQ
	1/s/9Tpptt2tnOk30nuEZKiO74oIpZZ3nXt21HUlsBym7NoODyB0IBueLtYrtxg0ZFt09LrRgxh
	Tthx5RLS40zrLcpLNkZD7p+SlqOwj25wU9BN5RQH7lG9ByTNIOcazgw2bU5FLkeLAnXv0BAEwRX
	HIPYvDkV+leAEu3STqC0/tV4tzkR3iHNMB0Wh3kuOToFOluBB5HNp7ROpis+js2ZnlL2F1vMELj
	2AxlgqD0+L9PiVCM1zHpoZn0Ck9vRoXwvXWn8x2pU0j+FcGas4sLx9tzI+n8qK7IsvkXm8oiR6J
	7k+dgOn/44YqjlUStIy6/f6slbq5WqzD165fVWh5mxmdZMaoFri6OD6L7EEI5Gv8EZjKhnyyTq/
	GRNjmAZai1Gzu5dlEE0qVskVqlT9/UAB0Ly79SdjnngVGUSFo14o7EgDlQEC8i3PXGcMFgHb5VP
	g04zmssa6r+dNL+5MYTRX+0EMf3xqARblaX8tmAWckyBM/hEaXM+ajKgbBEqg6xMSNgABAI=
X-Received: by 2002:a05:6a21:7e84:b0:3fa:1dbd:7f75 with SMTP id adf61e73a8af0-4014cd4a8dfmr23334113637.36.1795782808548;
        Fri, 27 Nov 2026 04:33:28 -0800 (PST)
Received: from localhost ([2401:4900:1c2a:12da:3176:e694:92eb:c932])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077944bsm12568899b3a.2.2026.11.27.04.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:33:28 -0800 (PST)
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
Subject: [PATCH 2/4] staging: iio: impedance-analyzer: ad5933: reject frequency code overflow
Date: Fri, 27 Nov 2026 18:03:01 +0530
Message-ID: <20261127123303.144052-3-punnaysharma805@gmail.com>
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

With a 500 kHz external MCLK, writing 30000 to
out_altvoltage0_frequency_start succeeds, but the chip starts at
14374 Hz. The attribute then reads back 14374.
out_altvoltage0_frequency_increment has the same problem.

The start and increment registers hold 24 bits. ad5933_set_freq()
turns the frequency into a code, freq * 2^27 / (MCLK / 4), and writes
only the low 24 bits. A bigger code silently loses its top bits.
ad5933_store_frequency() only checks the fixed 100 kHz limit. With an
MCLK of 3.2 MHz or less, 100 kHz already overflows. The datasheet
suggests a 500 kHz MCLK for measurements between 100 Hz and 1 kHz.

Move the conversion into a helper, ad5933_freq_to_code(), and call it
from both ad5933_set_freq() and ad5933_store_frequency(). Make
ad5933_store_frequency() return -EINVAL when the code does not fit in
24 bits. With one helper, the check and the value sent to the chip use
the same math.

Keep the 10 kHz probe default, because a probe failure breaks boards
with a very low MCLK that work today.

Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 Impedance Converter, Network Analyzer")
Signed-off-by: Punnay Sharma <punnaysharma805@gmail.com>
---

Notes:
    Tested in a virtme-ng VM with i2c-stub and a fake 500 kHz "mclk" clock.
    I have no AD5933 hardware, so this does not check the real output
    frequency.
    
    Before: a write of 30000 to frequency_start returns 0 and reads back
    14374. A write of 15625 returns 0 and reads back 0.
    
    After: both writes fail with -EINVAL, and the register keeps its old
    value. 15624 still works and reads back 15623. frequency_increment
    behaves the same. With the internal clock, 100000 works and 100001
    fails, before and after.

 drivers/staging/iio/impedance-analyzer/ad5933.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index bd85cb37ca4b..da07a75ad3a9 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -187,6 +187,11 @@ static int ad5933_wait_busy(struct ad5933_state *st, unsigned char event)
 	return -EAGAIN;
 }
 
+static u64 ad5933_freq_to_code(struct ad5933_state *st, unsigned long freq)
+{
+	return div64_ul(BIT_ULL(27) * freq, st->mclk_hz / 4);
+}
+
 static int ad5933_set_freq(struct ad5933_state *st,
 			   unsigned int reg, unsigned long freq)
 {
@@ -196,7 +201,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
 		u8 d8[4];
 	} dat;
 
-	freqreg = div64_ul(BIT_ULL(27) * freq, st->mclk_hz / 4);
+	freqreg = ad5933_freq_to_code(st, freq);
 
 	switch (reg) {
 	case AD5933_REG_FREQ_START:
@@ -307,6 +312,9 @@ static ssize_t ad5933_store_frequency(struct device *dev,
 	if (val > AD5933_MAX_OUTPUT_FREQ_Hz)
 		return -EINVAL;
 
+	if (ad5933_freq_to_code(st, val) > GENMASK(23, 0))
+		return -EINVAL;
+
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
-- 
2.56.0

