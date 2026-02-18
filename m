Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B712FBDFF
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 04:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389472; cv=none; b=K9mIeuN3iizgDjXxvsG6qN9TZR0Uo6C+HKv8ITCwcdZ+q5awX+82ro1QwWB+R5XmubZlIpRfwNtvP1ddpsh3OKs87wV8mBeMnrqAewNXNzPxVvSL3sL987LY9qu1S60agP2t4vbpIMzvCUeK2j5fPH5yiNqCiGKoYfK85Mk9Zsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389472; c=relaxed/simple;
	bh=JoAZJDoiWPN35rMghHaD46+8b456UvXitcTsjZHErg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGAWIvv9DY6SqzsW0n4SOdOs8VgjKJH38C17zmdjvyyFiwGYWjk83qEjRiMGzS46k2spyOfsT55w9S9SsF4uOZ8BgPWlo0pSBy9GyTFoLPgtaTG2Au6huPdxSyxkUyP3bQnW2HStSSxC0Im7uietxqOsOndKvHdrRsy0ZRx/b/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YipxEGCM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YipxEGCM"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-797ab169454so36543627b3.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 20:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771389470; x=1771994270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJMl8aGE3aksQFMSCHrKQEMvQMnBaLOVn3cqjYbpNCI=;
        b=YipxEGCMRfN7xJ5zU2tQ8QAPRJwIbewhxOZobfxH9hvKqrnSEIBcLAeiLMQf7LAsOb
         onJHEPkn1N8ciUi5xfmbHvv8f7jZRVBNXvdZAfgp7gavEoPWxrtnLqJDDCqhyRYM0AKj
         fzUm7VZzYsWqIo5UHqkaeBM4TATZ5+8S4x6KFT0Lh3hf+dyib93wgfZ/D4ghfcM7U7RK
         OPIK8q5/upEroc2WbvkLqoe35gnsTJawbdNWqk3fDPZOI0cFaLvldeJPDZh7O8KJgP/P
         LTytJ06046bfJMyyeeslERDJICZypQq9SVPbbT/Fk7NMADwAGNJOxJ7pkDKwXor7C7lm
         CR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771389470; x=1771994270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJMl8aGE3aksQFMSCHrKQEMvQMnBaLOVn3cqjYbpNCI=;
        b=WrFkIGJS2nYbHw5MC9UE9ilI6TbtYOD2y3qEX3Q762CKvksuWEKt3RqXo58tWsOFG9
         jCRRR4VoSzXh+RYrrCbd/X8VzGo6nXo1GVOKUK35FnANEgbtYmrZw69xmUttS2+7RkBE
         q5vqORCbzSOoRhODI8b6ksqYA/AsfiKEGwEpLUtNE9e4SKPkznRTYIXXPLVfpgIxsiOg
         MpP/ivlzqQzNZnqb0+OD4eSfIVx3MuT3iT7ny93og/ZzwynYGL8ID3+LFwqqUX5HFbWC
         ve4AHLK1G3exJ05t+jW69HgCP1+ZVgBGCOYNAgwOUU63BiuX/Um7VYbdjF4AF7bXmKQ4
         Lf6A==
X-Forwarded-Encrypted: i=1; AJvYcCWrzez79+XE8yV4ubDaBMsfoqqIRwbXapNf/PmoxKIa+kJnmn+5xKcqQ8nt2BdTFYNMj2h3zsDya2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1dSZwREF360tCaktJTymt+43EQf06Gz7EqldwOQAJXJaEoqW
	GNJ0yE6308pgJZZM2SkS1KeB0xujNC8JZeKdsoEEl67kH4dGgdC3Rtj6kvfDeFF/2XQ=
X-Gm-Gg: AZuq6aJH/WqdlBMAxcXXKCLlv2xrVsaHJAtIJRfjYBbBs90XsDWnIU/fkDpopciHWOh
	rs8SQK38pjvXi8GEHHWZOwYnRbmz9I1InIBBi5aLLcCGRpiCbuD4Fl3MdrPwY8D2F2sF2WeO5L0
	QTg/9KYxSS/AZPBjdvK1NVu2jQSugJd44rUT0Fa9YnzGutwkfTfvlXqvIyatQ/weOKE81qTPNFB
	O8+d2MAzh6yjykpACGwDMhYqV4DXqEZAzt2NwHDSG67vGbiprc8MLDcLbNLFP513KCmOuURTQC8
	YadRC96cBQRZN0xRKIbsUNsvgp0KDcMNkW6fbbIhSMfhA8xVVoiePq9wG4LiuP2iR425GobN3Px
	kjohcZI9luLLLeyXFwCCRTBHmmGXJ5Tgkh3AHIVB6myXPhj8Tswx04mlHAdgIP2r5TYC1sv9usW
	VEwIc/YPytlqr4D+TJs3g2cIlLB9JDorq2BNUUrNqIuBJpxgeB/stTBfSOC4zW4al3Zn5aqOXk9
	271Wy1q8Hwrh0lR/Yzj7e01GWH3otF3EqChSCSX3jc=
X-Received: by 2002:a05:690c:83:b0:796:2fde:5df3 with SMTP id 00721157ae682-797ac5d44f9mr92487807b3.40.1771389469689;
        Tue, 17 Feb 2026 20:37:49 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23e4bdsm119850617b3.32.2026.02.17.20.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 20:37:49 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v4 3/9] iio: light: gp2ap020a00f: Use correct types for 16-bit LE data
Date: Tue, 17 Feb 2026 22:37:22 -0600
Message-ID: <20260218043728.609659-4-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218043728.609659-1-ethantidmore06@gmail.com>
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Instead of using byte arrays and then explicit castings, change
the types of byte arrays to be __le16 and update the endianness
conversions accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index deca9fd77fdd..82b078f6a43d 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -462,7 +462,7 @@ static int gp2ap020a00f_write_event_threshold(struct gp2ap020a00f_data *data,
 
 	return regmap_bulk_write(data->regmap,
 				 GP2AP020A00F_THRESH_REG(th_val_id),
-				 (u8 *)&thresh_buf, 2);
+				 &thresh_buf, sizeof(thresh_buf));
 }
 
 static int gp2ap020a00f_alter_opmode(struct gp2ap020a00f_data *data,
@@ -698,18 +698,18 @@ static int wait_conversion_complete_irq(struct gp2ap020a00f_data *data)
 static int gp2ap020a00f_read_output(struct gp2ap020a00f_data *data,
 					unsigned int output_reg, int *val)
 {
-	u8 reg_buf[2];
+	__le16 reg_buf;
 	int err;
 
 	err = wait_conversion_complete_irq(data);
 	if (err < 0)
 		dev_dbg(&data->client->dev, "data ready timeout\n");
 
-	err = regmap_bulk_read(data->regmap, output_reg, reg_buf, 2);
+	err = regmap_bulk_read(data->regmap, output_reg, &reg_buf, sizeof(reg_buf));
 	if (err < 0)
 		return err;
 
-	*val = le16_to_cpup((__le16 *)reg_buf);
+	*val = le16_to_cpu(reg_buf);
 
 	return err;
 }
@@ -867,8 +867,9 @@ static irqreturn_t gp2ap020a00f_thresh_event_handler(int irq, void *data)
 {
 	struct iio_dev *indio_dev = data;
 	struct gp2ap020a00f_data *priv = iio_priv(indio_dev);
-	u8 op_reg_flags, d0_reg_buf[2];
 	unsigned int output_val, op_reg_val;
+	__le16 d0_reg_buf;
+	u8 op_reg_flags;
 	int thresh_val_id, ret;
 
 	/* Read interrupt flags */
@@ -896,11 +897,11 @@ static irqreturn_t gp2ap020a00f_thresh_event_handler(int irq, void *data)
 		 * transition is required.
 		 */
 		ret = regmap_bulk_read(priv->regmap, GP2AP020A00F_D0_L_REG,
-							d0_reg_buf, 2);
+				       &d0_reg_buf, sizeof(d0_reg_buf));
 		if (ret < 0)
 			goto done;
 
-		output_val = le16_to_cpup((__le16 *)d0_reg_buf);
+		output_val = le16_to_cpu(d0_reg_buf);
 
 		if (gp2ap020a00f_adjust_lux_mode(priv, output_val))
 			goto done;
@@ -967,17 +968,15 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 	int i, out_val, ret;
 
 	iio_for_each_active_channel(indio_dev, i) {
-		ret = regmap_bulk_read(priv->regmap,
-				GP2AP020A00F_DATA_REG(i),
-				&priv->buffer[d_size], 2);
+		ret = regmap_bulk_read(priv->regmap, GP2AP020A00F_DATA_REG(i),
+				       &priv->buffer[d_size], 2);
 		if (ret < 0)
 			goto done;
 
 		if (i == GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR ||
 		    i == GP2AP020A00F_SCAN_MODE_LIGHT_IR) {
-			out_val = le16_to_cpup((__le16 *)&priv->buffer[d_size]);
+			out_val = get_unaligned_le16(&priv->buffer[d_size]);
 			gp2ap020a00f_output_to_lux(priv, &out_val);
-
 			put_unaligned_le32(out_val, &priv->buffer[d_size]);
 			d_size += 4;
 		} else {
-- 
2.53.0

