Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECFC3ACF05
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748299; cv=none; b=E9gUBi4LMtCHG8y0hl8pManva2k9Jmj8okFPce1X/KCZgfB/6UAEXtq+vTy1gDqQ0IWw9VO2Vy7bycSpkALGdrzCaDhv7D/5rwDJJwiC3Gzk8PFxA4ZuNj/F/53JqnvdLLQx2qqKTHPztB33FDxASTdlTcVBPoKMmMajTxn8UQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748299; c=relaxed/simple;
	bh=9L/E3JsGKziQ3+/+hKLS5npytaMtAbu8QjP5hbmSmKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P76QotkqqMdGOCnI8PbuAhRHhcxBPcq8T20kGSO2ZIvZkXM/X2YPqaRc0wB/c6d+7wyF5gohUN8wKfRJ18GDoDAjv2TMuLd9Fk6tLp/d98txUaFSEyyibTI9Q1yqxI+538/T/Z6DugSnZzRaBaRRCsR/t/4F0RAyMBTamhzmFis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQgsZSHs; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQgsZSHs"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c85822059d8so1789995a12.1
        for <linux-iio@vger.kernel.org>; Sat, 06 Jun 2026 05:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780748297; x=1781353097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oF6o4yICBZJ2JEeavzYUdjsXSOPLZL3YFiV2vZkyltM=;
        b=FQgsZSHsIkkyvWOeM9aP02mx2fQtwbX5EQbhm/J8BZ5y+D9I80RdJYftpBNvrVsIf5
         u92JitW/NyH3l1LkE8wMnpLyi6/F/tohqFGU/nngjNuaJdzLBRQE4w9bJH4jD2nPGNcq
         Ojb0MS/BFwoQtO8aeWvCTBbRDpPL9wB6jRobVjlgBv/Kt3nPV0YhyaetqADFphL7BGVx
         LYn5S9BJXtuGUGGwKXpZzIP/edNwFyrxKWaN8o+5MKdHTnQf+QdkPSUqFKcDxVA/fOy8
         0aIFR2tNieIekgiUCyUMpkpoJRcq5Yw81t+6bn3RH0tDSzN8z0MuZcS+rRO0LRDOCT1D
         ETyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780748297; x=1781353097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oF6o4yICBZJ2JEeavzYUdjsXSOPLZL3YFiV2vZkyltM=;
        b=eYfvYwgOyGSwOeS0VvOcWIcUSuYjwYl1CRYq1gQ0RS4pb/KUpznp9XEReXBzjSAOpN
         eZEWFkr5m8Z+bm5Ufgcbxq//9dX1ZuRvChvupv0iTRwXD/+Q8sJGEugWVsy25IaU8nFi
         vTCMK9tdGuwmsKZgRCJqQrcG9dKoYtsi+t6jUU/BLiuu4m/RyaFo1ytqHs0VzufA2RPr
         +uvGCEeWVX/OPLeqSpq61oCVMV7e1MwehOcHIta4lDZ1u/qKQNnR4h2ngaPH2ZSmI1+y
         SkkkyqLcqrc1o37axk+V1r3GOV+dQvcwLxjVKCua9gxBnRKtDmpgUeZGXd1XymnnR32b
         x4ww==
X-Forwarded-Encrypted: i=1; AFNElJ9P+4Xlm6R3nnN+eQGCpqBHfnvgRCTgranqWWepvgEkPkELgvAb2jxr+sPuq25Rt9gJHNQpEGtjh+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMORQPRC5u9kaFRzfU4jT1ADL8R7k8pbuXw/ceKw6DRddP9OZe
	E6+n6CUCmFlnBUyd67ekI680oE7p5QSgzhIae9PfHBLIkr/Owk8oLFPk
X-Gm-Gg: Acq92OEFjxLW1EN/A/0M56NRLNUHi5KFZWU7FTSIZyRc/NYAHrSv5gcO2W056t/Znp4
	8dby4SQ5M0Sz+B1VViAIhBMyCBX0Diz9yL1OJx7n2Q1IQrpSPXE9xV9yuPy8rflJpZXINdap2Rz
	T040W3dO8Ho2wF6Sm0Sjmvd5Lm+wc7pfw+4lrENY8pNoQNyLoL27haKOK6uKToRfe3tclbxLA2f
	60guEM2PeXCrWlj9xQowtGfR56YPIZyHh6mVoyouDgyJlqi96DnsqenOLcFd6v6+HSzycaktREj
	J7Qdgf2deeIPZjfNFQbMoUeOB47Euff4jXW/V7imnKpr8ErYue1q1uRcx8gNo9wL5S802+dt/Oj
	NLXzNhM7Al1Wbd6K20syL5sQdsCdhWSR8slv5sbLYFy8zPXRfuunuw9s9NJj5yPooDWQNhDm+PX
	eTsI9F4fpNaG+5ERWTN6HpsLbfOP/AZBBWR4sZTou3igRI6CNX+8f6omVWlFo=
X-Received: by 2002:a05:6a00:2789:b0:841:58b0:82c7 with SMTP id d2e1a72fcca58-842b0d82b13mr8379976b3a.8.1780748297468;
        Sat, 06 Jun 2026 05:18:17 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm15253532b3a.61.2026.06.06.05.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:18:17 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:47:47 +0530
Subject: [PATCH 6/7] iio: orientation: hid-sensor-rotation: use u32 instead
 of unsigned
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-6-june-hid-iio-correct-usage-id-v1-6-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 4a11e4555099..20563d8efaf6 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -176,7 +176,7 @@ static const struct iio_info dev_rot_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -209,7 +209,7 @@ static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int dev_rot_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -240,7 +240,7 @@ static int dev_rot_capture_sample(struct hid_sensor_hub_device *hsdev,
 /* Parse report which is specific to an usage id*/
 static int dev_rot_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				struct dev_rot_state *st)
 {
 	int ret;

-- 
2.34.1

