Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E682F0673
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389471; cv=none; b=XY601qs/KBW3Jix3RLWWt2Yw9voPkKg+KyGauaKs2ySNMwkD6nTMTnaEubiBgKIZUYa+LKRczLS7GcWizSws1bL35qCWSPoZ4X4IlxUXxAnf3F7ZG/Ocp7lulysrrDwMoqps8puKYnMYqyVEumdRQAe20ewOgibra6OZB/AjlH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389471; c=relaxed/simple;
	bh=pagHrvqBbwrKpiRdGecFFOqcw3gp13P/UHq0LoGCMuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxCVKdzcmjDo1oWcOH3+VXR1Ab1kcw8WsBzHEmEvQpPsC/pYx3pS9iZ9EfWkVfGzsibEKn04CVm7TqAram24c8/xO0VWo/oXFVYDRlsIfDwRfIY9ixbJ/z8apXY2uvhusL99ws2eDB2K+Pbwa0vDpCQZpjjbXJKW6fFw4tWpU94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdMZkTtl; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdMZkTtl"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-794fe698e36so44578647b3.2
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 20:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771389469; x=1771994269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbfCSCPWbYKBtZ/X2FNoHWhz4WNydDjl7xPuqNagV4U=;
        b=QdMZkTtlTqwOTj87ABapGsm8sl47ti8IVF1b4LHt7uLoSmuMI76nTmpvOPoiP8Pkr4
         q+2wFzswPmvmQUbgV5jsX9IJWi7M/PujvhkvzN2eEWCpnSd8ss5XCBB/f/UEvd0IYsr8
         LecZhBkGSGxqQFR5PIvac+c5QPgV9YvmynlQ+Wf8+tFYT4sKS6XfKCe6zht5+aGfN7cK
         F3IsPl3AqEX/l9S3VxB6cV+r9Dx1pzglQCOpXLaWtxpbQeECnnAxks9TGHuQn1MueomQ
         zeY4sd8JsaL2Ks6ebZ5apz3hBD8M9SHA0ZK5R6Sg64g9yO/T8I0Aeiosc7r//vL/IRjr
         St/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771389469; x=1771994269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wbfCSCPWbYKBtZ/X2FNoHWhz4WNydDjl7xPuqNagV4U=;
        b=QkwtfRBJeudxSWlfkARsYL5jQqFnMhsQG+WVB3Mo9gtlsPBdKWoj0egOlLXJubGGdG
         T5MHKDK5+Cc9kshS1/XL59Ts33BssS40i/U8iADET/tk9Rn0KRpmizKtKcTy190e+JVK
         2Y++cbUKtRSoAjsDM8IY0ntgmS2XsoCGKUObe6Po0J2vAqky5Amu2F/Grt+j6eujtvoM
         5hBW8h922AbiUq1GLUfZLXkX5mW3ZeDfO/GF0P42K7O2/xQe4Urq17gRpg9VcyYXl5Po
         ya8SrbOW6aVEICGpYUlZvci11jkDV0et7TKr/SOXmGeRihnhVOr6cA0sRmR9+x8rvxwT
         W4DA==
X-Forwarded-Encrypted: i=1; AJvYcCWhXQh3vyjwNCgjIwXB/VebVtvoDB523BoqEfyQpX+eVdt6+p5fMyRONd2L0IJDP3MGPsyofYGvBv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfzVxfO/PwCmPIHcBn8N3hxosWMJMflccDp8tuTHOyknRazjN2
	lXnEKECX+0O/sdiZqMKqjeR3Oc6q09SIiKLCqiWX4+tbMuJ+9D8trfuw
X-Gm-Gg: AZuq6aJgzwnYaK2AyOr1iaIhTVH3C+vB2YcjTKsyFSJw94e4n0zK1qfhVHGoNnMxtny
	sf9sY2TlFdut34C3Wl8as2fY06T83ZkuSUqkoyJiQweE5+ICZE9QwQxEVzT7mKvHyCz1s8FgRV3
	xtas5PBofZbQtsjijVRZ2EYxuoyE8uEQMI5ssR3F6Ol9k/64eaVkXAAo16/pigY9dzzisTY75yF
	Rz9mhwQdIYIad1fYRHWY3G4BQdre58rIOI70QvDyFJItPN+hHCnJMoGdeL0kR2f0Q6okVUCCg0D
	1ihsZA/NBb0yGvS408w6mKEwJ7F7ApKta9OfaalyIEfaUVKCwDWttyAF7wgwp+C/GFyG5NSBs65
	NCTNnMSZCMLXujywZkgpETURLGsEwslQ4icmtX2OCrlcdm8rQykX8aY4YMhgysBFVOuoL+K56T0
	kiRceDrnws27MDFtrrUPlnKHbAsDvoifJJPbEThc/8nZeMPIPW0Fgo1TSF2DTjzuz5GJJUXNmyc
	U+UtOQDCzEpgUz6MFjQo+BjmVsyzn+FQT+W50Zx01E=
X-Received: by 2002:a05:690c:2607:b0:797:e0ec:b8df with SMTP id 00721157ae682-797f71c12a3mr4865877b3.18.1771389469023;
        Tue, 17 Feb 2026 20:37:49 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23e4bdsm119850617b3.32.2026.02.17.20.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 20:37:48 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 2/9] iio: light: gp2ap020a00f: correct return type to int
Date: Tue, 17 Feb 2026 22:37:21 -0600
Message-ID: <20260218043728.609659-3-ethantidmore06@gmail.com>
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

The function gp2ap020a00f_get_thresh_reg() can return -EINVAL in its
error path. Yet, the function has return type of u8. Added error
checking for gp2ap020a00f_get_thresh_reg() return value.

Detected by Smatch:
drivers/iio/light/gp2ap020a00f.c:1013 gp2ap020a00f_get_thresh_reg() warn:
signedness bug returning '(-22)'

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v4:
- Added Reviewed-by: tag from Andy Shevchenko.
v3:
- Remove Fixes: tag.
- Added Smatch warning.
v2:
- Fixed gp2ap020a00f_get_thresh_reg() parameter alignment.
- Removed unneeded whitespace between assignment and check.

 drivers/iio/light/gp2ap020a00f.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 91fdcb980111..deca9fd77fdd 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -993,8 +993,8 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
-					     enum iio_event_direction event_dir)
+static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
+				       enum iio_event_direction event_dir)
 {
 	switch (chan->type) {
 	case IIO_PROXIMITY:
@@ -1024,11 +1024,14 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	bool event_en = false;
 	u8 thresh_val_id;
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 
 	guard(mutex)(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
+	if (thresh_reg_l < 0)
+		return thresh_reg_l;
+
 	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
 	if (thresh_val_id > GP2AP020A00F_THRESH_PH)
 		return -EINVAL;
@@ -1070,11 +1073,13 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
 				       int *val, int *val2)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 
 	guard(mutex)(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
+	if (thresh_reg_l < 0)
+		return thresh_reg_l;
 	if (thresh_reg_l > GP2AP020A00F_PH_L_REG)
 		return -EINVAL;
 
-- 
2.53.0

