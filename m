Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442167;
	b=PIs+oU3k6pxFilox+e5U/nBYlUWLKsjMHuuq2Wk5M7Xka6THOnRqmJdN3upXZFFoyQhK
	 hq7eLvPqcDG2E6GCNcItCCXbMJTLnaEwAsLWzv7cLMG0efn7trmY5zewdoDZ9U/YtBFOB
	 O9nAoU1TetY7S5mhYhmSuRJdiHSlhkqBB3rED6DTIhWZSiQJqc8pJ2pCuc/SoBAYwzMeY
	 azzTwOPMW1S9nwLVPte5alaoOiyHKQkAA3rG+MOiD4veWoc9qqwav5SqEdQgHFW12lrO6
	 vc1b6HLtUPOYJJn95Yevb96iynKA/V409nxqQrh+WKcogGcRHzCHQQXo6c5gpOfV73w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LSykIlbfutXIhoOr65gq9qD6MLKki1+tTFA0l8dejz4=;
	b=VEFSGfhIBk659hkzeZH+rnkXbIdawLQ+Yugo68EPHS21ruWw1Ugm+MnxKD3YyF6iW93n
	 lFvrO9tWTmw+CQk6elEXYSGJuaFtgNWOkgdYrygtIYwOuEyj4Cq2d+K5m7gq9KSzpEm7t
	 m/7L9PXVOabMpqnPw54JWTS6Nau2C5ds2kj49vIDIUAPm2EjTK5RB0aJDN4Fom3QQ6xW1
	 AZ8FwYp4DvOn93vWrKao49eI9rCp+mk3nD1XZ7yAc/NAGxwKrH/zNEULxIg6zPCPlDJz0
	 N5Z2mMy+gzxd0kovCInzxr1kNoXjUH2RTWcyhTK7RDPefuK814v14z1xaLdbiaj1ubA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZRV01e9+;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50BC606A32A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 13:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A50BC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZRV01e9+
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-38564b4b017so3556901eec.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 05:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795442166; x=1796046966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LSykIlbfutXIhoOr65gq9qD6MLKki1+tTFA0l8dejz4=;
        b=ZRV01e9+Syq9Oce7NKh7SY49PHV1Mj7/tB1yd3TfhQ8aSin05O9/bBwaU+rCeYfDUC
         yXKaqW+6zCxQgjR7jowhZgzsFIFsy41MX77y5n0HeNBF/6LNukAnLaHn3cDAl7uQgsci
         AI5Hh+YPzWLYzTXHKmBxJjbSf87DbLdZBEOX9ZjPV8TO7K29qLsYDjmb+Fvd/57G+Y7Y
         STVSW7AJ3Qrw7yUAnGHm4RlrYP0wDFuXrzmFy+echK+rJ48tA58JCh267TM+3/yFWAgl
         Uel/ZrkZUY4hvCWPW0/x7TFgzPJ7tv1Q4wZ9Bme0+dYoKn/nq9wFZW7Urm7ZEFolgAgc
         bbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442166; x=1796046966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LSykIlbfutXIhoOr65gq9qD6MLKki1+tTFA0l8dejz4=;
        b=UnEO46Iw4hjJuOJYe7SCTaVhKYG+GR6keedG2tCy5SMbqlEFZDny88rU1FIB+/zdmT
         lfmyUrE2YW9VxvPYNdR2zdJy0OP9ZCpSf82L3+6CzthjXsbB3MqbUyO0tord14ULOXUk
         HPztSgdDc/KYpdMcpFrL9o9qfrM+GWmZN1FO+GlFSUJYn2JIJnNa4s0rYorRC2vC4BsC
         ZRVIgOKK60VGLX0gLxK/5pLxPQTReqVSS1l6TxpZuFDsnhdlTSGkIosIQuXoeDuzOD7M
         kRCM1cxPQgeOYp33e+Wo7pkzhi0DDddpvZJZBNTVqSU9CkR2Hph0nQ3l2kc1JkNhcSwz
         E3GA==
X-Forwarded-Encrypted: i=1; AL+hErEuHm1/8Wuz7eqqHSkJ8pFrO4fTbUaVnABt4euw7dp577j81pSh2L1zvhlbnPSaJup82dGVSzImwVA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3HjhkJ9QrXCOELUSh6MVEblOGkAXPs9tuJlDBHcQrxp52CCA9
	s5KEF9b+T5mtGgDczB9W7x/c7QP32k3rdggI6GypudfcjYiNIh3Tt+yC6qe+PA==
X-Gm-Gg: AZFdTZdV7OmrAgzSMzQELOmgKMIXTeX3vuVEjuCL0ip81+43Z6zNPONmRsZc9RxOxkE
	sTbV23H3glgfKKOjz7bs/b1YMRUTwr0dlrcps2Sj14kFK4Tj6pze6SSBEMLeeR55tWFwcNqS8Ia
	NWSLzfUHAupTaS7vwuUua/tyxC1s6gDTttcxzUkPUKGCA609UL87Kq1SdUw30dphAAjqRz/lY9m
	KYB2ci1HW8zF85Ld3Qc6oiFp7Wp4UOAUU4dr/2T4xktgHKGASpFul7GhmURej0xkG4Ao0CKp72A
	HUMtsWtBb39TCNTFsNUr0LSFtS9L4XahBl8QhlbIe1SOH7awWpIOiswR0oZiQ0pVuDW5iRAYgLc
	tDWxPVnzP2zRg4zipFWoGdnKs1q2euEI9mGD4pMa0iTqr4zwX72ChQGG3fKmg5nI/dqk1L876Sb
	+Oz8f9qK/ogzSNe+NtzrP1PbPrn/xmglMVSlZvtOEBNlZ8ZP9no2fQxKpNsvCYrAWFqhHdRdT+1
	CZFIWK7QvYH2hgRUt0e72C8GYLy1C9JVIBJ3kftH4TR3soBPH7hsoinW8VhwC/XLOkpyDxkoBr1
	kT+Pv/Gpc3sFA4EYhfbVbxC6lt4aOy+wGKPq1RwSU5w9SUwBfRx6iA==
X-Received: by 2002:a05:701b:2319:b0:1b3:a8fc:6306 with SMTP id a92af1059eb24-1b55247e725mr11431757c88.6.1795442165384;
        Mon, 23 Nov 2026 05:56:05 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm29310267c88.5.2026.11.23.05.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:04 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux@analog.com,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Andrea Merello <andrea.merello@iit.it>
Subject: [PATCH 2/3] iio: imu: bno055: check the hw_xlate lookup in bno055_get_regmask()
Date: Mon, 23 Nov 2026 21:55:53 +0800
Message-Id: <20261123135554.2983499-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123135554.2983499-1-maoyixie.tju@gmail.com>
References: <20261123135554.2983499-1-maoyixie.tju@gmail.com>
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

bno055_get_regmask() translates a register field through
attr->hw_xlate[] into an index into attr->vals[]. When no entry matches,
the raw field is used as the index. The gyroscope range field has three
bits and bno055_gyr_scale_hw_xlate[] covers 0 to 4, so 5 to 7 read past
bno055_gyr_scale_vals[]. The IIO core then divides by an int read past
the table. In an x86-64 gcc build that int is zero. bno055_set_regmask()
only writes 0 to 4, so this needs a chip or bus that returns a value it
should not.

Commit 399b883ec828 ("iio: imu: bno055: fix OOB access of hw_xlate
array") fixed the bound of the lookup loop. Return -ERANGE when no entry
matches.

Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under ASan and UBSan, which report
nothing with this patch. Not tested on hardware, only compile-tested
with W=1 on next-20261116.

I used an LLM to help write the harness and this patch.

 drivers/iio/imu/bno055/bno055.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index d0101607a9b3ad0..ae7e219d36d1e46 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -587,12 +587,15 @@ static int bno055_get_regmask(struct bno055_priv *priv, int *val, int *val2,
 		return ret;
 
 	idx = (hwval & mask) >> shift;
-	if (attr->hw_xlate)
+	if (attr->hw_xlate) {
 		for (i = 0; i < attr->hw_xlate_len; i++)
 			if (attr->hw_xlate[i] == idx) {
 				idx = i;
 				break;
 			}
+		if (i == attr->hw_xlate_len)
+			return -ERANGE;
+	}
 	if (attr->type == IIO_VAL_INT) {
 		*val = attr->vals[idx];
 	} else { /* IIO_VAL_INT_PLUS_MICRO or IIO_VAL_FRACTIONAL */
-- 
2.34.1

