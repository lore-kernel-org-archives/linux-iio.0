Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B72FE071
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770513441; cv=none; b=ELT+w1vHSaZindSLcrUPcEskJoBBpgulFaZYXk4Dtg3usUutbdF9uCikqujiPRZ0bz3DRG2C/BaZ0lFVPQRunpcjPQSsAjnp/JSYtcIjQvu9YSyzzyM5Oe7U241Zu1BJfm5AMPbM98O7lLQZ85krPlM6E3b7elq2zpL/2nnYQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770513441; c=relaxed/simple;
	bh=hTMJMKgPKAcjJwsvkc1cKtMsNmA+nLdiKGssW1qJWY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mz6un9B+TXImIRD1zgsNSlZ69W+dJptsL4CtSuvKn9slpIRMT8vZLPxkw2OXnGQ5H+cxahIQ0feSHAQNBkGB0lKh/ufySJw327Gu3r6xK242kk7QztWUNr2OJHo5jb9BhVbXrgS4a/rIwyIYHwPehDhOpyN6/W/L5VS036zIqoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyQQCa3a; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyQQCa3a"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c6aaf3cd62so331038385a.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Feb 2026 17:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770513440; x=1771118240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQKUWbk2kffWFGeitl+6R3tmkJKGHBOuzEDPgFGOhGU=;
        b=DyQQCa3a1F1ph6Zbe0WBp+9irDUZjEl0FnIjuOQ7orNZSCPxT53e+EOyZ1V2uX/DRo
         CjlxwLCnYmHlPrbogro5byoxlQb4gJjdsqqOpP3TPoSAd4KyMV1QMn7z35kuNe+2o+HP
         fBQ7RrqjoaBpLb1OXl9lNZ9U973OPYhPYWs200PVFLAxcXaahhWMksxrlEKic5/qyXcF
         ktINcIFgJO0WSIKmsTT5TCcW9byPHYp1MzeOD/ydSOEFjkbxsEnm2dpdtbJkVn0N5jXw
         3k60V4Pt87FmMr9Zo5XUR6eOhDgZdk1WvvzDXaHH74c982AvgjmcDMfFow9yZA253B6f
         qgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770513440; x=1771118240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CQKUWbk2kffWFGeitl+6R3tmkJKGHBOuzEDPgFGOhGU=;
        b=kjL9G+KWDWvknGQeaxbLx9eCeYFSVB1WsyIJcTfjNoFQv/6b5H2fRCzJNKagXawSR1
         4w3N4bGm7h9vk5zLSkpvmnJeCL0O1CrrveMIX4BUi5XqfAzu9OqsvcGUJbjCn43uFqJz
         GdWA/MvA+H14RgNQP67BM5Oo3G2ybKhq+KzyXcQRrycz4Rs2+MrjeUEnTGCK/qGLH1ky
         suBaOEd/VHIOp/oUb8vw04DwtjbZsuwE0slOaF4Io1ytKB1vngQdiu6uQaREQWGd9xeO
         xRvqFY6FZ6yKPwXwANV5KPSkFtx2vRv46r6rvLBOaUUFLyvSQ1K8+GnX0mkRYrYfUWZd
         RP9g==
X-Forwarded-Encrypted: i=1; AJvYcCUgIsalsb7KsGmeiiwDuAvWmKWPZucgQeiH4TmPhS5vcPfz5KYmKFLGs5qZ92PWGoDNkqmD7jrp5yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWhG7qDNGUObLn+5krPi3ko5HlNtGIOPnFSt66X+/D0v7S1+D
	1TEI3j9svF+Wfar0BPbE5jcadUjmsf7revILQmC0H2DzO8qS+6YrMVIs
X-Gm-Gg: AZuq6aIYELTs4SF96McmLEyB5c3P/sb8C2sTFl9hY3DxL9fX0RkYVIbtP+TTqohEHNI
	hOXmBaV43cn8wUQBxS8tXOdQpw8EIKV42FGOZpw+FqoOYQnjfDAH/765NyAzMqYoo0hnvFaB+OC
	xGdx+pgYgJEHPnM+MPdOuWSwUub7A+SyOaKQYoxICQW0nqUZ4pFL34gfUhIpfjT1tE2OH1mhOib
	uLoC7mw2OrI5twF8k9CdNrGSSNj24gyT984PIsjS+btp73TCle14e01B+9lvCQ2OwaxsbFcgoHg
	Exq+WIiSKPZq4qeRK4jvRKC5WWnUgXMRNxx/wOGEPXjwRFh7+4T9Sc8SpO6MJcxaUPN4+jsSFsa
	XBn3VpXkvml8KAdZxPZ3UgTkr2s0FB3qXtvx7ulmbeyA0foqAdPnvtmHgpBVYsUlTvhjAE9X8HZ
	9IheFD5Lsxl2FxNdqHJPSNkvskRTfsRjIv+RiEcrt3
X-Received: by 2002:a05:620a:45ab:b0:8b1:8858:6ead with SMTP id af79cd13be357-8caefccac1emr1005834385a.11.1770513440056;
        Sat, 07 Feb 2026 17:17:20 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf4a97997sm481364385a.0.2026.02.07.17.17.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Feb 2026 17:17:19 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v5 2/2] iio: magnetometer: bmc150_magn: minor formatting cleanup
Date: Sat,  7 Feb 2026 20:16:59 -0500
Message-ID: <20260208011659.53722-3-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260208011659.53722-1-neelb2403@gmail.com>
References: <20260208011659.53722-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spaces inside braces for initializer lists in the sampling
frequency and preset tables for consistency.

Fix indentation of bmc150_magn_scan_masks array and add trailing
comma. No functional changes.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 29 +++++++++++++-------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 117bf70d6899..8e249e25b799 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -149,14 +149,14 @@ struct bmc150_magn_data {
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
+} bmc150_magn_samp_freq_table[] = { { 2, 0x01 },
+				    { 6, 0x02 },
+				    { 8, 0x03 },
+				    { 10, 0x00 },
+				    { 15, 0x04 },
+				    { 20, 0x05 },
+				    { 25, 0x06 },
+				    { 30, 0x07 } };
 
 enum bmc150_magn_presets {
 	LOW_POWER_PRESET,
@@ -170,10 +170,10 @@ static const struct bmc150_magn_preset {
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
@@ -643,8 +643,9 @@ static const struct iio_info bmc150_magn_info = {
 };
 
 static const unsigned long bmc150_magn_scan_masks[] = {
-					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
-					0};
+	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
+	0,
+};
 
 static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
 {
-- 
2.44.0

