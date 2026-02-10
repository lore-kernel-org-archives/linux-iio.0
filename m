Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5584A33A71B
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766799; cv=none; b=Qw+2akZSGi/kOuO3EI69cm8QjNFucVE48r1E5ad7hvqVB7fUjNEg5drh3DQ/4rrFqXbB5TXUM5U/WFLksmK+uVX7T4kK5r3ZPqfMbGR719sSpzMTIbNq69FUfU0HhK20iFEr1Ys0NWDyrlKnEbrFKePnNosHSdeNY+sF1om7Jrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766799; c=relaxed/simple;
	bh=czdkNrjo/SfaVp6cIZf1OHbVS8dBW8nubTB5FlGu98o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3Y6mdk9YvZ8cP8kG33ZEMNYPPN7MvuHgcAngu0J3Wq8E9SobIXObW6UCU06lUm3/1pScOF3ftHJ/IBZrrUUl/VS6C07xlz8VzgVkOmFiDpYU63UQNhedTCxkucxJeqkwaD1c6E1SzT03ZOnCT1uu12m17veMpPQSN+cgGVkTbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbFWMK0K; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbFWMK0K"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-505aaab61d9so12324191cf.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 15:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770766797; x=1771371597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef3Kj/PignqJoi3Xjlh5mQznCMdAFgdmVh4ZVGLFMGc=;
        b=HbFWMK0KbedwOI7NfKZHmAznF8rho0uEl40V5PXZrvzFNhp97TGQY/FYKjiWZrBKF6
         6oNv+hV9EZTVcc9/SXGL7mLaKhrWKAUU8uUl9E1e4joYrxa+Ih7L/e7Wc7mQNmxPb4ht
         EltxwEBWGGsO6XZ9UgeTyBr4Mhsgyp9EcDpcNAXEFdXC+Hid37SisfogyhQqY0rKz8AF
         WDyg2flqkmef6qtA5nn7jW38cXNFMYY6AmnIQGLayC1qZjGbt/lJXWoQxBbUD1cMNhQX
         XzKllKmFVzUahkjxYMmggXRtlVmz23+fUMb+Ju5hj8/qg/GWKp1xkkPcNnYw0ZqXdZ3b
         F0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770766797; x=1771371597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ef3Kj/PignqJoi3Xjlh5mQznCMdAFgdmVh4ZVGLFMGc=;
        b=fXC2z9Tf256v80VHtsA87ZzVtJCkosuHp4kKY7VN0XGt+PShtsEYSXTO+YGffsCWqR
         1YTQjC6TKFVpKQM/TxlVJJzS6CbzorH3kgycoJ3IsC9RE11BMJckkOKp3scyp27IOfUq
         Siq1KSYDnOREFAJVayifeCBoR3MFbdmqTE4ftnakYzbC9wOKm/FerlFujfI9q3maFDOr
         Qg8NMC5fQ8yjHxzdtHu0GHCtxZv++i47Nyhy9dB7Gl2owIlfay3xLogP74QLyVlkOg1A
         H+QwUiqnyvootRaLWK9E1Divkds6g5Edh0QQqLXzq+f4w3QmwkJbuY2yAOlwWNJ6V+Ty
         JKmA==
X-Forwarded-Encrypted: i=1; AJvYcCVue70R+cdekU+cJd0WwHQOUf10+gpzhc9hEDtA2g3oj1hgkwyjdwIrDVrNKu5HlOlHTi43J4WknHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhTbaAitjEWWez/UJBFuB2RNMok1niruIzoihlIU16RbSiI2yx
	lSg3ZNykgRUQPEGv2IwwxhlVMq+AHIVCv2uYbAcW3xTREGerwqOssabjoFQNsg==
X-Gm-Gg: AZuq6aIcNb2hsH0UivTX2a+CzO6mQkJ/oGdPxyPGu7qgnfip1oOCE4hGhWmKVoNIH4o
	JadetUn0N3icsEGyKJP3Sx/n4+jc4VrkPQT2isN35O8AMZ58GOt/FOQSqle5HGyic8KqzKaykCv
	MVaiJMO7tLsXDNUyYzug3wiOiA37eSbLkdrdJniIPjc83xYBdoQgpDsME6UkZuUU1sSv5oLNhen
	xQo1Xe+s8sc53FSeVJB/ywoGWSKskKtAZvd2AVHrFTtbX2LRQj+5ir+x+ga0FWgprOphuucbEBN
	2dWkhhhrtwWfmJLAE5BpGvleqMo0xWogNPEF7XMCZYY4MTR0tyi5FTkBCbHqrYO+nTlQrB9bqlV
	ptr+LMnbfUKKyVDCSk+kuGX0I+tMJIWptdLveEnfIbdCdfa1JK2pTt17gqWhqxHKdLReWNH+niK
	AukITPnM7IHbvE3b9S/L1+Vd2tj9KhbLYZSX+yElhgPA==
X-Received: by 2002:a05:622a:50a:b0:506:1fc3:dac7 with SMTP id d75a77b69052e-506398d46e3mr213239661cf.7.1770766797279;
        Tue, 10 Feb 2026 15:39:57 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50682f13f20sm1850561cf.14.2026.02.10.15.39.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Feb 2026 15:39:56 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v6 3/3] iio: magnetometer: bmc150_magn: minor formatting cleanup
Date: Tue, 10 Feb 2026 18:39:45 -0500
Message-ID: <20260210233945.40975-4-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260210233945.40975-1-neelb2403@gmail.com>
References: <20260210233945.40975-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve initializer list style for bmc150_magn_samp_freq_table by
moving the opening brace to its own line and grouping four entries
per line with index comments.

Add spaces inside braces for initializer lists in the preset table
for consistency.

Fix indentation of bmc150_magn_scan_masks array. No functional changes.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index f254774d28e5..942c2f5e97e1 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -149,14 +149,10 @@ struct bmc150_magn_data {
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
+	{ 2, 0x01 }, { 6, 0x02 }, { 8, 0x03 }, { 10, 0x00 },		/* 0 - 3 */
+	{ 15, 0x04 }, { 20, 0x05 }, { 25, 0x06 }, { 30, 0x07 },	    /* 4 - 7 */
+};
 
 enum bmc150_magn_presets {
 	LOW_POWER_PRESET,
@@ -170,10 +166,10 @@ static const struct bmc150_magn_preset {
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
@@ -641,8 +637,9 @@ static const struct iio_info bmc150_magn_info = {
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

