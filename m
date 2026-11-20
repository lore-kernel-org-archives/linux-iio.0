Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170537;
	b=FJoJlfAn8MIVy/bKY2UunuS1inwpyq90X2fNDAJXv6NoRxn3doj3Zb8iynfgnVJkHnp/
	 mLWJkoACRwLeWTbOBj+dVsY72KXFes91J3A/9RZG6iT9c6B48V3aT4aKdjnit2DHPyNYj
	 TkepdCSlf0JHb3WQuapyxLUj4rpD24F3PpwX3AGamc2BbhLBjEKB0stFfDZm6d2ImyG4q
	 Wj93tswfglD6RjE4+T9cEQcLZrL8fEt6QyBtRH86VBYoFzsp+uCk0tCUiMPScFvAGI3vm
	 jG3A6KpsROIdcjQt7aW2effcK3gz/ImQwJ9QmYMTx5Dy9y9KlyyVtpDSGMrxQSl+r5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4gcjUg+kW4Rww4E1kdgtFMSot1r+hOLKOAxIyXgCC14=;
	b=HTb4NhFTcw2C2k20oNyjE54YnhuMUrCmlnUjl2vcKwLpLlSkjQGQLNu0RGnYcnKxTcf3
	 FPdL3cVNIeQhHDr7R6tnjhw6ZPvZYj//7t6qmbFi4gO8/1Z/XulBBOma9D2rMdliVfAbD
	 kXglEJFgocDjhg4LtPOvJEeqzWXQF6BAVFKblXUYJHVWBFuat+sVUUKIX9cOBHOHxeLAY
	 4bcAOCAAkudRPFt1T2EN1u32KsE1wKNACJugNDZ1Y+Lrebz4Nuq0Ljp4xyYWcCo8IltWc
	 E2wjRhtNTuj5xAnEapNZYzop0PGXmBTiUVvyTueSZL7hyEiyGMk/iZzXousAWndwK5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dyDS7tmC;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21B60A262D
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 10:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC21B60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dyDS7tmC
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso602202a91.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 02:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795170536; x=1795775336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4gcjUg+kW4Rww4E1kdgtFMSot1r+hOLKOAxIyXgCC14=;
        b=dyDS7tmCE7cjzZjDh4CWwWyCddKJ3rt4OobgL+Ro6jzSa7p6fP2JJ5C7zbL8e3UtOi
         nPSDpA+n/UyBmN8VuSemd/K7n34UVSebXII44bzkqnooHJ0H0Jp0V1THl8gxfl79Sws4
         fNY8Nhg02UU0ISIUxdu93ouCEGIh0+QEV15BmiA1UJCCSOwbIsNsLM4/8cAtC0uCRPHb
         aeIhVTJzqgkIJqIcgTxPq69Np7+aW+Ph3HZsqdkhJrlAZfARXrCePJ3IzBmsJBu+K1xU
         PI2gnwVJit1tc9k8kn4hiSC8jyo52c9hKw0DfwnK934gjeXN70JTNqJr23UU3XzB2uFC
         Y6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170536; x=1795775336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4gcjUg+kW4Rww4E1kdgtFMSot1r+hOLKOAxIyXgCC14=;
        b=q62lF9LiLDuh8+UMIKuk46jfStehdpFCbwZdPLlG8Jorc9LomuBj5zYLcOCfj5Gq72
         /CF79WdfRSJXoeuteAjIteFILaC3jGw6o6spohyDOEADP8G5Swu7G7uq+2CU9Z0OSLNs
         smCJIX8vfLdGeq+vqv/Dh8RvYk/bvgC8TACoi3ZfMQVlmNLRoHW1BUtJhmNBpjJ6f4rX
         bv8T6ny4um1AHTi+nxNi5rgQo3rCOoTOyx0T5DVqjomuDPpGeZ2oJrh4cGAmk5G/okIj
         jmMKFgawBXzEbPXj2u0oSw9CatBWPAfCjHZStDwj/6ARmDV+j6gAIATH3LLTfP8WOH9u
         583w==
X-Forwarded-Encrypted: i=1; AL+hErEDfgl4RyXgtRNcLN1K1aa/6orKtxkr17ka/HrkF4S+lFqIABpOA+cPhsworga9iuQVNTQH9vy96J8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fDeQ0bDYRiGiA0JTpbNEthiqDI6kNn7eywscGxkBqMiE7EGWL
	eZOPqEfKjtqLm0S5TseGnM9X7OcWocyVDBk47FUj+DLEzXEVGFBUq8S5
X-Gm-Gg: AZFdTZcFFouAu+QNyQ/pLWioXEP4kEizph2zCWVNgJO9v8wRqoIg3nrqVk3bLQyhZCy
	tWNZ7lrSJPpcMMlQQApnJNo0RFg0aFtLyABA55iVMTkUswitUR7O0bsJc4OER0DBUCO+sjwbC9e
	Esh6T/sugyFO/wolzR/2bDI68bQvAlXMnqiaX9d1Ej+NqFiqkjXJmhTQOEQqE6ybVIthKq2oDFW
	oY6QYMU+TMlWoB6UVwedXoZLto+fG1CzpmapNwWAJkOVlvSCcejo82+amUpUZMloJS+aVVlQe8v
	jzAGyEJ8w0rZrn34f6Hr3K02acmP/oR3mHaK//CUaC0Es3bqMoJrke9S3pU29KOkYeJPXx2AWhD
	DHBu6kKDP053Jt0wVtYT62nAZxAHQl6zZQuMLJ6x5G444BJVCFYhBhd9TNj3h7DFmfQI45jJK65
	nn5qlCWHcjTReS9Y8y1o9LjyV3szVjQVaz2BZ4lEBF2YJd5yDR13XB5KnXPziw3j9OV6fodf2AY
	5/XY0oohGXArU4offaxXIdTkAD+Kt6SB60ZnBCz4bwC4l979kMU29EsLjH3xrRZEFvxl1KgEfYp
	eAS2HaMGhNiEFmO1y++/KsgZNGvd1sa96/rJllB7GBSMMTfwiL8YRw==
X-Received: by 2002:a17:90b:2d8a:b0:3ac:450b:164c with SMTP id 98e67ed59e1d1-3b41c96cde4mr2443318a91.47.1795170536110;
        Fri, 20 Nov 2026 02:28:56 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578dca0sm7158810a91.2.2026.11.20.02.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:28:55 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Song Qiang <songqiang1304521@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: magnetometer: rm3100: check TMRC in rm3100_get_samp_freq()
Date: Fri, 20 Nov 2026 18:28:48 +0800
Message-Id: <20261120102848.3198371-1-maoyixie.tju@gmail.com>
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
rm3100_common_probe() after a crash on failing hardware. Check the
value here as well and return -ERANGE.

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

v2:
- keep the declarations in reversed xmas tree order (Andy)
- use ARRAY_SIZE() for the upper bound (Andy)
- return -ERANGE instead of -EINVAL (Andy)

v1: https://lore.kernel.org/linux-iio/20261118164106.4108794-1-maoyixie.tju@gmail.com/

 drivers/iio/magnetometer/rm3100-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 46fce2978d76705..8e80cf6790c728f 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -277,6 +277,7 @@ static const int rm3100_samp_rates[RM3100_SAMP_NUM][3] = {
 
 static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
 {
+	int samp_rate_index;
 	unsigned int tmp;
 	int ret;
 
@@ -286,8 +287,13 @@ static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
-	*val2 = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
+	samp_rate_index = tmp - RM3100_TMRC_OFFSET;
+	if (samp_rate_index < 0 ||
+	    samp_rate_index >= ARRAY_SIZE(rm3100_samp_rates))
+		return -ERANGE;
+
+	*val = rm3100_samp_rates[samp_rate_index][0];
+	*val2 = rm3100_samp_rates[samp_rate_index][1];
 
 	return IIO_VAL_INT_PLUS_MICRO;
 }

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.34.1

