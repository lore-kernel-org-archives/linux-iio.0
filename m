Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782818;
	b=yGFmBvBJM7B3LA4TMm1Om9ISkxFPV/QMhlwIe9073Y6taG0tRIB9Q5A3R2C2IIOJHQJj
	 t5ABsPmNmjmXMrBcH8twJtv0WUJ4//qYtQg4k4xa3Q+70Cc+RfwmOqqAVpOZXqX4d2Hyn
	 tOaA/QoQKn9bv14kutLcM/bDJtkuoJeNJ23nLQjYXVteQSxF5O8qCZpoBDFEB3ZrGe8YY
	 W2iWo7fpjPtqc9kF9hk39Jqid2pwRfsV8L640GY2nrYoJJ41kcUcBrcDC1YiP7B0Gt9x1
	 QSg3NPYD5dL3XRS5rbYPO9ExmiD9NvzWXmv3d+kqd8PntUr07x63QBhwOM99Ks+vo+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UruTXZxxiLvetKzSZp7hmCf6qHi2zqy13sjBi3H5//8=;
	b=acOMjpWL17odCkBymWPGsDXscjBKSMlcKELPgG3WtUcX6Qr8c74tChQFifagfimPw6ui
	 LSsBPaEbWlAkxUATaf0DlLtx7YrD6MW4KI3LpMvrSvWPp4hG8VU53bqW3i1/qlAtiz78j
	 dnTRj7+Uf2s4iNoPOVbvbowusc8bsRF82WwGi9DNRw2aVCqVHkll9SAcdAEr057phDrdF
	 vdgBWHycdtCjsOTe7UvHvbxO4FgeobBLaHsjJb5Ho3KnhjmfhuI8WcFyvu2zepfHbcqzb
	 I5LBiaHBJw7zhY4YwSaIDA7aYaDzcwnc7WRgtkVg7leuLFKrNL7uHZou0Mh1ZPwT8gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RR4QR1R5;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D950606A31E
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 12:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D950606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RR4QR1R5
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8c4cc85a315so5265198b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 04:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795782817; x=1796387617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UruTXZxxiLvetKzSZp7hmCf6qHi2zqy13sjBi3H5//8=;
        b=RR4QR1R5QsYN7hrmHiz14VqpqJ9Fa6b4XR2EcDizk73RaOmWDA32lZLvkEgUW2SV3k
         DgcM+FmAnp6+9wyKyzLTLeUNQLeX+Mw/onE3cthNgp3IMGrs5Ok4ksIsd1VTir9L4D76
         PV4wCBC7BuNoaGURiYmfBTozmjp1qlY4u1VatUFk/eawoLZMMQL4seyQFSs5Bfl0iHR6
         qtLhursmOhhYdeuS4ZF/sioT4GYy/VwtLfIiIyqBMdJEOB6JkIZM2gNPR5td/nlRNYV6
         vfn5a6VMOAXxy1sfK390ZOLS1kmJ4h+at7HcKWzrlhyWc42UDSjjmVsKh1+3rEPa7fYB
         U6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782817; x=1796387617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UruTXZxxiLvetKzSZp7hmCf6qHi2zqy13sjBi3H5//8=;
        b=NkO+nLdz6MlHScxVLb1q87zmQKyN0sM7nEV0mJuj/BgaskPaomPSDtcN/vnBNKcKvi
         IhL3y1AnTC1Jvj/8Cp3bNJWKGTkBR7FRTavWElxaTngxefhcWB+c9WcvtHrwrrczuy1Z
         dqMZvZGZQ6P+xKte8g0X1byKCgHzJ8T6jjR3PKWkFeLTFjpN/ph158CY3vOX3gfOGWL2
         z/PJIvZsLP9c67UIkFntAeyJ8cKVht8mMGmxC62CHEH89eTFPgvnl5pGDovEVtZm9EtW
         4TnEiwQNUInFNA3vQiDISSvR3A+hxnty13YdbXN7QipKBSVMkS8xnnwXq1FXEkya90vW
         ZNLg==
X-Forwarded-Encrypted: i=1; AL+hErHDRAsDBKk1+VGpJz5GkIrDUxqZSgQQ2peQ8Nl9CkCraUTGjR5sKbEXAOENGCaFKmpBSLdtldc6QyI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zPgDvG7qiMmSgbeRQ6zRx7G5Q8SeOAUl0Q3YtmConc9JF29/g
	pRv4uwxjDH67+KxJEZ4x6BlXo92X6lzltQUvfWTR+GiBR1ei01ppwVEP
X-Gm-Gg: AZFdTZer0F2y/WBQHNCXeHJGXMAU1zWseznIvqQv30A8zaiHcOfqo4wixE5jv6ij29q
	WJh4jkhbNwvzep1g+U5o9Fi+EAT+sQqR7c+bGh9XSXyV3fI4dY/BcQaNgnrekU9FPm+byys3tKN
	1tmaihfirzL7qNYhT4xcgrb32O192KkNDA0MRzBv53gLmD73NKz03KBsuOtKYx7q9Ed5zvvQHx4
	QBFdZbFHOigVnPvLh3p6aFcqM/mCvRbXRVI9qYRAyHhQmmqSsDsYcJ+LJZ22jZnKcYYGt328PQ4
	HqRxWLT/VRuiLkR0mvC4CPxPwBpfFpg3nBh2j1swWVQqXE16Nw8UOHSCKRTO9FUm2yt14Z8UGge
	RxdlRf2Pge+AyvbtuoFscUnybSsG7N8nwbrEWUbAux4a7kbkxbX6zZXF7/Ok0EgIcOxBEonESFh
	WfXIakZffR5AE/Bg1ws6UXSp19mtHmc+djNd6ob41jKs9er2Hnnb+RhZjCjtNPrbGv1pPzxOif2
	JZefgr1na2Vhy+xgEZ94OhACvmQ2ib5x3GNmV8tG0K6XbejTrVaJL/QOO5aK+7RZktEn6iHsnsF
	nhl5zhToJ4J0CuFzxSuPss72/1eDIihiKHCDezbfQlNjNdKo2lNVD1+n055QZrmyIwKNTko=
X-Received: by 2002:a05:6a20:430d:b0:3eb:aeb4:2c2c with SMTP id adf61e73a8af0-4014a17d41dmr27791319637.4.1795782817548;
        Fri, 27 Nov 2026 04:33:37 -0800 (PST)
Received: from localhost ([2401:4900:1c2a:12da:3176:e694:92eb:c932])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077944bsm12568899b3a.2.2026.11.27.04.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:33:37 -0800 (PST)
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
Subject: [PATCH 4/4] staging: iio: impedance-analyzer: ad5933: keep old values on failed writes
Date: Fri, 27 Nov 2026 18:03:03 +0530
Message-ID: <20261127123303.144052-5-punnaysharma805@gmail.com>
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

ad5933_store() updates the driver's copy of a setting before it writes
the setting to the chip. If the I2C write fails, userspace gets the
error, but the driver keeps the new value.

For out_altvoltage0_raw (output range) and in_voltage0_scale (PGA
gain), the new bits stay in st->ctrl_hb. ad5933_cmd() sends ctrl_hb
with every command, so the next buffer enable programs the failed
setting anyway. For example, if echo 198 > out_altvoltage0_raw fails,
the next sweep still runs with the 198 mV range. For
out_altvoltage0_settling_cycles and out_altvoltage0_frequency_points,
the attribute reads back a value that never reached the chip.

Save the old values before the switch and put them back when the
write fails.

Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 Impedance Converter, Network Analyzer")
Signed-off-by: Punnay Sharma <punnaysharma805@gmail.com>
---

Notes:
    Tested in a virtme-ng VM with a throwaway copy of i2c-stub that makes
    the next write fail with -EIO. The copy is test code only. I have no
    AD5933 hardware, so this does not show a real bus error.
    
    Before: echo 198 > out_altvoltage0_raw fails with -EIO but reads back
    198. echo 1 > in_voltage0_scale fails but reads back 1. After a buffer
    enable and disable, 0x80 is 0xa3, so the chip got both failed settings.
    A failed settling_cycles write of 1023 reads back 1020, but 0x8A/0x8B
    still hold 100. A failed frequency_points write of 200 reads back 200,
    but 0x88/0x89 still hold 100.
    
    After: each failed write reads back the old value, and 0x80 stays 0xa0.
    The same writes without a failure give the same results as before.

 drivers/staging/iio/impedance-analyzer/ad5933.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index bb72d9c55f6d..cd3c8661f4ff 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -379,6 +379,9 @@ static ssize_t ad5933_store(struct device *dev,
 	u16 val;
 	int i, ret = 0;
 	__be16 dat;
+	unsigned char old_ctrl_hb;
+	unsigned short old_settling_cycles;
+	unsigned short old_freq_points;
 
 	if (this_attr->address != AD5933_IN_PGA_GAIN) {
 		ret = kstrtou16(buf, 10, &val);
@@ -390,6 +393,10 @@ static ssize_t ad5933_store(struct device *dev,
 		return -EBUSY;
 
 	mutex_lock(&st->lock);
+	old_ctrl_hb = st->ctrl_hb;
+	old_settling_cycles = st->settling_cycles;
+	old_freq_points = st->freq_points;
+
 	switch ((u32)this_attr->address) {
 	case AD5933_OUT_RANGE:
 		ret = -EINVAL;
@@ -443,6 +450,12 @@ static ssize_t ad5933_store(struct device *dev,
 		ret = -EINVAL;
 	}
 
+	if (ret) {
+		st->ctrl_hb = old_ctrl_hb;
+		st->settling_cycles = old_settling_cycles;
+		st->freq_points = old_freq_points;
+	}
+
 	mutex_unlock(&st->lock);
 
 	iio_device_release_direct(indio_dev);
-- 
2.56.0

