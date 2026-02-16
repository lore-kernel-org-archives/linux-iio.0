Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769072BE031
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 01:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771206906; cv=none; b=EAsSizAKdyRGXZofz0vCtqeQ9QRVkj2Ml/aIe1CU2JE6tCGNR61HILRqL06v+tmrHjvY5n6XZgsP5eeihslRhScVdf0hzzb8CmLuxD6ZtoCmXG2igwhXJgOVJgkIE8C3N4MMF33+gE4TtN5pRm7nS49LS8SfIlQj5MA5tvXoteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771206906; c=relaxed/simple;
	bh=dFB59mytzmRWRnKqQQNge2zn1BGrXq7oA9vprg2lXio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIqhiZEajGzG39KdVz7yIz/Y8hLKbXjI69DeTpZF/WOEABELstPOm0RvXEF6ARNdBpMV1gK07LxEmHV89MUq7ZHOvD2EG7lf8zCbVn4nWxen8DJxfvKzWdUXP4HfzzBRvjw17z2TpLpIge7fvWX+5Ph3/zV6Ti2tirxBZQwDeHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax4Utkva; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax4Utkva"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8946e0884afso50296676d6.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 17:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771206904; x=1771811704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsSw2N0mFOfL7A7wPIuvu1J4Yi6uMDkONpE+mB9hBTo=;
        b=ax4UtkvaVOENp1WQ9UPLKYpiOuqiASGk7cag5uXTIbQywuoBKzYcqU7ZBfw9OYs5K+
         pG6CsbQvQC705czXssnmBmj3eiPEO7I7jQmw6EK5IdJ4G68SIveh/N325OkSeYPc4Li8
         NrJPJzC1JyyntofoLYgI71H7guND6+/tbbOyS88x7ruO3C1Ml8LS0UPSwgu5ynvt2OlG
         0lVy7slqe0oh+Xr1NpZvYd9xpDmBr3vzCF8pyiEM/33gMrq7tRYq3OGpB+Qdt45XYg4L
         CV6JjerybS6/kfXFgOUOb/G+H1HnarizDr5iDXNyWXO1zaPO+mVaxryIl6rLnal0aiqu
         tdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771206904; x=1771811704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rsSw2N0mFOfL7A7wPIuvu1J4Yi6uMDkONpE+mB9hBTo=;
        b=RTVCsUhx/L/Ikb1DlAI6og6Xm8RtnW996u3nAP4C/t20pIfCd4H3/MdI+T/GV0jbpm
         VcSwpi+1IGzs5m4wpohzLiNUSGTaLJRiI26UBugLarBw9UimrPWOC5LJmsuqvSR8pf7X
         RdYQ2ybW1G1XtQkGrbu8IbaUl/mqfKZ4j5yACM68eoy7GO6ekeWfzTmzweISDit7Xynl
         TnStTsQJHGUTEwBEeQGR20DP05Rdv4kLb6Ocv0TZQl4d52879uasdi89OaTUcsQUHWMb
         A8SnKzSoFz/xycmzSsnJMIXMRDyoT6I5kuFAn6O4zCMInnLdlJq4lM922RSlAvZFQ77u
         8ZZg==
X-Forwarded-Encrypted: i=1; AJvYcCUfpBTgIDQOftpYEiA7KLdDfn7+fbRAJggToQ/y+kv1gDdu2aRXM5FiD3YXKCnCt+pcF/f8KjHMFLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Zc+dEXfIADodeGSXSEBRtm1KK7gYBg+pXy10GhKye9UNUUiq
	q0Tt9Yc1yLov6BDYArDxsoVxme0F6DpISm4qnBgg7wUoOq2PxzQtMQNQUJ4Tlg==
X-Gm-Gg: AZuq6aLfBel4zaD+NndS8AbFHQhYjGZI9SS9U/1ZJr0yDZyiKQPRTh7jlyt5OZQCZ3p
	y7MnbJdr+qYypE6e1NNQXtDgR3XmwboQv6W/JfAk+QrFtFXNk6hEi7j+SZUqw/P+mmO+wDI3cVI
	ksC7Lx/piWTQG9kxiwrwHr7Qfie2W6sCPDj4yAUffT2Jf3lw40vl5d0DRQUzQuIWcyGDqoy0nGU
	r89sV86ajjXtPsj9qXZ1wPdRazDyU86r95A7J99bVn7nfK8TAZHfapF77TNs98yS62h34Jo6RGL
	/xO2Arlu/8vhKXOLtjwrXpJgZ6NluKtlq12duJoZGbINpE0zes1LJsIUlpLVUeBODdjQm/RXEOR
	PjYOj7woT4OXR7syK1QGUsWSGjeTh9WebkNNx/P+zAYrc39jf4xNe0uc5soEPV2pO3XRYRr/mdh
	Vhkwep2WhPOkuyKyCcreCpenYmCn1UQTH7oFxYFtx1zw==
X-Received: by 2002:a05:6214:da1:b0:888:89fd:a727 with SMTP id 6a1803df08f44-897404b6a0bmr104838776d6.49.1771206904509;
        Sun, 15 Feb 2026 17:55:04 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506849fbb9dsm126926161cf.15.2026.02.15.17.55.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Feb 2026 17:55:04 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v7 3/3] iio: magnetometer: bmc150_magn: minor formatting cleanup
Date: Sun, 15 Feb 2026 20:54:54 -0500
Message-ID: <20260216015454.61836-4-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260216015454.61836-1-neelb2403@gmail.com>
References: <20260216015454.61836-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve initializer list style for bmc150_magn_samp_freq_table by
moving the opening brace to its own line and using one entry per line
with proper indentation and spaces inside braces.

Add spaces inside braces for initializer lists in the preset table
for consistency.

Fix indentation of bmc150_magn_scan_masks array. No functional changes.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 31 ++++++++++++++------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index e7f8d118242b..6e154b55ca18 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -149,14 +149,16 @@ struct bmc150_magn_data {
 static const struct {
 	int freq;
 	u8 reg_val;
-} bmc150_magn_samp_freq_table[] = { {2, 0x01},
-				    {6, 0x02},
-				    {8, 0x03},
-				    {10, 0x00},
-				    {15, 0x04},
-				    {20, 0x05},
-				    {25, 0x06},
-				    {30, 0x07} };
+} bmc150_magn_samp_freq_table[] = {
+	{ 2, 0x01 },
+	{ 6, 0x02 },
+	{ 8, 0x03 },
+	{ 10, 0x00 },
+	{ 15, 0x04 },
+	{ 20, 0x05 },
+	{ 25, 0x06 },
+	{ 30, 0x07 },
+};
 
 enum bmc150_magn_presets {
 	LOW_POWER_PRESET,
@@ -170,10 +172,10 @@ static const struct bmc150_magn_preset {
 	u8 rep_z;
 	u8 odr;
 } bmc150_magn_presets_table[] = {
-	[LOW_POWER_PRESET] = {3, 3, 10},
-	[REGULAR_PRESET] =  {9, 15, 10},
-	[ENHANCED_REGULAR_PRESET] =  {15, 27, 10},
-	[HIGH_ACCURACY_PRESET] =  {47, 83, 20},
+	[LOW_POWER_PRESET] = { 3, 3, 10 },
+	[REGULAR_PRESET] = { 9, 15, 10 },
+	[ENHANCED_REGULAR_PRESET] = { 15, 27, 10 },
+	[HIGH_ACCURACY_PRESET] = { 47, 83, 20 },
 };
 
 #define BMC150_MAGN_DEFAULT_PRESET REGULAR_PRESET
@@ -643,8 +645,9 @@ static const struct iio_info bmc150_magn_info = {
 };
 
 static const unsigned long bmc150_magn_scan_masks[] = {
-					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
-					0};
+	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
+	0
+};
 
 static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
 {
-- 
2.44.0

