Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB9481FBB
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831674; cv=none; b=BBfUEz+20d/21OGMk3TsE5HPgnB1pqsxartfhpfaEk5LqqbmuCvJYcSK+Igy5faj54AVo2VdHkEngzORSTx83AKkkug24wFO0LL2JGrHTVRZJK1DVLydPmR3PuvoDwo/XoZXHknxcmnRxDmO1SCSKRZhzYvXfg/7P5r5H/i/NpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831674; c=relaxed/simple;
	bh=wSA/DdAe6JURGVPpZuwBr/S85CFhrCFFSj57biLfVG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcMKqwbyFO3zt/amsy4hHdB/9ChS0sdJCANjcWDHhxc5zdwhsuHZzGCzi24x9MkfSwnhN2orbvGzZM/LSTiNcjOjZ0hPP8udT+uwXqKp9HysGjkMMvgSfsCRbd10Eeuc65oPxwPcZvf5WMY8h3fWMJrCfD6mUyChxnx1LPU5yGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyPw14vC; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyPw14vC"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c70c112cb61so5297324a12.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 13:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772831671; x=1773436471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pBsyepyAI+QydFDz6qXK8tzV7YF+mv4q72ZRPpJ6gw=;
        b=iyPw14vCJB2A0bj/lTeVpJ2p1ZXsa6sRGSfDKK1pkzuktxPu8wFCWDSVHZWVghOnZU
         aFAN2rSi6Ww0GQiDoGzKAFT/kWWpvWXvZeSNReYkrDujafcE+y1Hkr2HJZDcCTTPA1on
         3Dv7r6FSCbqjxS8iUZREuNkWKBNXMQhwBV/7kZIIDPi+mNzAOtrOMobIvdkFSzlLxPiB
         n37ta21ATAO2ao/Diun9xEFmiVdtoH6h8DtW4R26/HB85Dy36qaMn0CSvP/tvgzqlYCG
         uLJKS41Voval/pn49+trWOxXA4hTqMEpocUfoMp+Xd897BPSpkej7iTEe14KQNagRZA3
         jJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831671; x=1773436471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7pBsyepyAI+QydFDz6qXK8tzV7YF+mv4q72ZRPpJ6gw=;
        b=bbBZQCRe34uXEDAstFglN2c1DNINgGShwR4d7lOeRMCAtmM1W8DpzkoeGZoIEBK5yA
         DwGNpqu27w3TBYt1CxwBmNZdjuG4TWgWmPLNSY1ow+pAJYnzuHwI4UQv3NbVvyWblBoJ
         bpxyStWS6tU3SxDNmtH01eN0XmVrPJTNEgwr8jZQfZeQqal0eGHjM0l4d+EZlJY13L5r
         v76JzsxGn+dQoH7YystjVizm3++gzbvnwdr7P4Uy0pnsOc2vSluu43cbSz7VMM46U72R
         4RlARHqGXNFhLQ1ce77vp37tNiTIl8gmQisGB/nqqnNdG8LHD9GbfsI0sJBUSFFycEjU
         Ngqg==
X-Gm-Message-State: AOJu0YwfhmP7S4CfNDs6Fjd2uITcExZkS8+jsfKLj5ZTh+bbxaVT/25i
	mCVHo1lJRktVBRDVXTOF5/VH/7Cl3OzX14cGyJTpNmzr+s7CbI0iI7Ke
X-Gm-Gg: ATEYQzwePc9qlHpn8OLLT5gB3IfTcCqsLxHgDKc7pBpuvlHnew2+puC2peKKW/r6rEY
	t+xvz1ps+rjrPghZNVcS4V+gl2hwjOun7b5TB3ujp3GGrS90HJhXczLXG9wrMOnNNa5RdAxUyYS
	hKPBd02+R5dbxfdstp72h3Jx4T6r/xln5ekmvbZN/x/lc7+IwC5nr9/de0jmxaboA8Xcng3gGWe
	rvr7Lh/4dOt5W5jzxg17uotGMcSJVdrPVExEpzdSWJPldJ8joZVAa4ZBqagKELIpCmwWso/mdQi
	sWRPLkuJ2VY0kurI06bj1Aaf9quo/mbi1o0F7RMH4CNpvawjBz4Hp3gWwaGphBLwIE/9XlcjqO6
	FwJ0EgTDFprI+lXaE+LLTIl+M8SUKp5QcWAJffuyqya+ch5hgSnO0JiWjxHVCX/5WAaLsg1V7Yl
	tfHEQSRKiBNQyMnsgX9Dl6rTMs9Kqopql4rSNScgq7dlAv4joHROQnTe1h+gKiOrLd+fF9fTUqj
	A33nvnMPZ1c9MezVom9+pCm
X-Received: by 2002:a05:6a21:71c5:b0:398:4a5b:eaa9 with SMTP id adf61e73a8af0-3985908776dmr2887465637.39.1772831671543;
        Fri, 06 Mar 2026 13:14:31 -0800 (PST)
Received: from fedora ([103.215.156.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e170c87sm2661331a12.18.2026.03.06.13.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:14:31 -0800 (PST)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	puranjay@kernel.org,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v2 2/3] iio: accel: adxl355: convert to guard(mutex)
Date: Sat,  7 Mar 2026 02:41:51 +0530
Message-ID: <20260306211152.65109-3-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
References: <d587dd07-ce23-49f1-9a38-ea741e4ef14c@baylibre.com>
 <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/iio/accel/adxl355_core.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 1c1d64d5cbcb..ef05178bff00 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -9,6 +9,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
@@ -263,12 +264,11 @@ static int adxl355_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct adxl355_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
 				 ADXL355_POWER_CTL_DRDY_MSK,
 				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK,
 					    state ? 0 : 1));
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -409,16 +409,15 @@ static int adxl355_set_odr(struct adxl355_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	if (data->odr == odr) {
-		mutex_unlock(&data->lock);
 		return 0;
 	}
 
 	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
 				 ADXL355_FILTER_ODR_MSK,
@@ -433,13 +432,10 @@ static int adxl355_set_odr(struct adxl355_data *data,
 	if (ret)
 		goto err_set_opmode;
 
-	mutex_unlock(&data->lock);
 	return 0;
 
 err_set_opmode:
 	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
-err_unlock:
-	mutex_unlock(&data->lock);
 	return ret;
 }
 
@@ -448,16 +444,15 @@ static int adxl355_set_hpf_3db(struct adxl355_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	if (data->hpf_3db == hpf) {
-		mutex_unlock(&data->lock);
 		return 0;
 	}
 
 	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
 				 ADXL355_FILTER_HPF_MSK,
@@ -471,13 +466,10 @@ static int adxl355_set_hpf_3db(struct adxl355_data *data,
 	if (ret)
 		goto err_set_opmode;
 
-	mutex_unlock(&data->lock);
 	return 0;
 
 err_set_opmode:
 	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
-err_unlock:
-	mutex_unlock(&data->lock);
 	return ret;
 }
 
@@ -486,11 +478,11 @@ static int adxl355_set_calibbias(struct adxl355_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	put_unaligned_be16(calibbias, data->transf_buf);
 	ret = regmap_bulk_write(data->regmap,
@@ -505,13 +497,10 @@ static int adxl355_set_calibbias(struct adxl355_data *data,
 	if (ret)
 		goto err_set_opmode;
 
-	mutex_unlock(&data->lock);
 	return 0;
 
 err_set_opmode:
 	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
-err_unlock:
-	mutex_unlock(&data->lock);
 	return ret;
 }
 
-- 
2.53.0

