Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0853446A5
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 03:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818045; cv=none; b=oJ2DOMF4MLsftt1h39OuKrpCCapAFcVCdSY2lbFs0oip8+7awxCPAX86yOV9CHoCiTzAsuW2ksq8jevkpwYeqTjceTf1PwD2f3uiHsWUc3JviVr137LvYX1w7qydBJ+1qhn47Ke9lSFI/f82Gj6RZPoO+ZcbD6X7gvPzpRirry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818045; c=relaxed/simple;
	bh=SGTNQIHXd2l45qUTlPXuJMT7dV8mZHGFRewKet2Zehk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUtGG5wssz8XpZaZIUpiKZBijdC4g7kSr8C/5fmbPFWzsyAxOIiUQ458CuH4NUATMkAn0aSgeufeWWTJ1C+OvWOUNOJjwW41aR9pXh5UGXZtALrePzi25QiIyOr32O1PNDf+y5WrC7FktHaV1FUfotfmWjaM0SdXJkk+RDDzXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqhwtF73; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqhwtF73"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7927261a3acso33538127b3.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 19:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818043; x=1772422843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llBR4+ajSqeSvY9ajnO7OKctHCvK1f4bcOFt4jCCGI8=;
        b=lqhwtF73E07gSl7/j5nOw3mqLKMzctgm7P3ztBCo5BowSpJqI+u3lEha28djHCgVNC
         c1RpVtG7OIja0FR4J4yWXQbamdo9TRjGlCDRItSbxdRc62EnJd4RlolTiWgbqGjnJDBI
         Nt/hbu3jGDJuHpO0uxQyMGiL7rhfXfdrGXTRJdw87JJwX8RzktuVmEnWudoUf5WJ4wJN
         SBrbbUBRXdYi4EpP82DUEp+E35gwpgzklbcmrO5vpjxMVV/nQM/UxH6yxpdKQSgjytOd
         19BM3LxsTTufsncrAiTuZM4sqN6SzNilPKzgIyeGky76inCmUqzomZtuVXLP9mCpsEiH
         kk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818043; x=1772422843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=llBR4+ajSqeSvY9ajnO7OKctHCvK1f4bcOFt4jCCGI8=;
        b=d+hW1BbagSmArQMN6dkaDzZtZxVgcGvqLRt8vG8f1irgjoF3dwjvdXeEP1zcAOxVkK
         aQl9qqTzS1BLgejBHI/7n7/5XvF3tK2latqJ1/Ds/ESTDHFwtDkPPueyg6RVMO9AFx76
         +5/8rgRxWhnVUYWBmI6qATlacnoyq6Tl3w6/EUd4nJ3Pus2tUABQgGrSUeftzg/xEbVJ
         f/9lIAmKLXsZulP1wjj/i9zpWVwGJiI+NybMh1IsI3zHxkqv2xoZPtDQB3Gq/7QouWw2
         DYWHV0p0DMpSYqf2xZpnfuN2GkRyCg/pr8VZWMC5eIADcPSkfuMIePJjzqcqZlGcPny4
         qp1g==
X-Forwarded-Encrypted: i=1; AJvYcCUAsqjOTq1DSYj6NH2/ob1CsbJz86EE4/0P5MtWYRABtePbsDxX2nOAaYjyrpqDoLIMQMf47fywGRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx28pAPJ2aXdV4oj9EIgNbDjeaOHrwpW4ZjjxeDG0ro5EwulXMn
	1jzyKiHtNLv1O+VeT/ZIRiiQGre7esERbOzgb/UVCysiqXAzsR63kX6P
X-Gm-Gg: ATEYQzx7wDQ5T6PCP5F6GABy707pp1DlUsAGNNHW5J0+rwq1fGeVNP0yMIeZo/LfOZ/
	uT/zQm57dk8iDYD0eDJY5do89M+GbnQnGxZqYTldhlbiuEFAruBy2129ZH+sibeZteOeHAXp8z7
	is4VfIII4di4teQ9ZdNUXSxxAOyuKaVkcScneRE9XlQPcEPJjjyTcciH7ASOROTqVXJh7bOe2TW
	8HuGvaQS/Yy+Vm5eGaRyMkfo/S4DbnXVgt8aNI0kSztlo0ig3SqxjWGH0NA0zu16/aHrmg9NJ08
	RedyBlcRUbQkd2sVYLvpPVpxGqcnG0VRsh1SVltXs+CPAEw0inYSZ7CKwTvQvLM4iXiBHXZ38Vh
	etxreXIp2r6mJdBzhSlZjIbyFfdJi6pBIzOe+oQlJd/VnhoHS/dVcTVOSSTATnPjA08GsvOUCdl
	7LKAVUC0BvttQ5RoQ8VPVlrspp9kaGmyxYyfwDbSeF+fx9oh8l9w5WMKLBaYhHtr30Rh2hE0AKm
	wE5JjrY4tn8XCYyPIotBONuYWFsbCpTX2U=
X-Received: by 2002:a05:690c:e3e8:b0:798:270:fec0 with SMTP id 00721157ae682-79828cf8c2bmr59182167b3.5.1771818042816;
        Sun, 22 Feb 2026 19:40:42 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd5939sm27285237b3.15.2026.02.22.19.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:40:42 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v5 03/10] iio: light: gp2ap020a00f: Use correct types for 16-bit LE data
Date: Sun, 22 Feb 2026 21:40:13 -0600
Message-ID: <20260223034020.27625-4-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223034020.27625-1-ethantidmore06@gmail.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
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
v5:
- No change.
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 6fe4486101b8..8558c4c3ef7a 100644
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

