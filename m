Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB530C371
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650507; cv=none; b=J0gRwTe8WvwfJW1znV0LxB7DJWgl4emzrE7gGyAOF7nIGeNQLrnSG13XC0KTcNJxoB4K+iVl9zOAXffPlz+gw1I1hpHESVgh4wEBeKdWgl7a5vdjhnyiNBIvTvBY36u+5R/S1L3AEfpBxiMoV2mfgi0XAZq0HB0EV5YVPax47ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650507; c=relaxed/simple;
	bh=L3ovo+6Ro+nBzEezvu+E5fV6IUvO9DTQS8RV+KRwOlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qYxcCjUr3AtItJ2TeTp7KvUvZEO5gYj43uFNZWe8R8prwLahQbjVngWG3lkltYqTZhAR5zg4GOPtq8HwtQn4PGaBCFec8LdP9eSWniQotH+QvPnWnLJ12IBsNXJdFg+QrDWPuC22tQl/hwZEiQwCz5pc3czu7e0pMd5NfkSijR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7OUMpf1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7OUMpf1"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-824c9da9928so3908916b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650505; x=1780255305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVYsCz7J/uOD6Q014m35hqnUDvr2fi6eWsdHVw2C0Nc=;
        b=h7OUMpf1uS7Wmn87Ii0PSJoorfeMjWCbY58w0d9ozyaYg0+LiUiSi9rqEijBvwfskv
         /ZO4B3B9z/guzoma/T+PAutLD/14vCBsrXfKhsuVKfuBeMG+eHRp0e8SKjLRCZpbpvBd
         hNYPJ+2HOlbDa14KGWKzWnQyZojImrsOWtR8voLxv/PsTIKD2LfWF8ymGXYOr4Q4GTDw
         oBg3ey2TGV8l3SxeGE7dX7O+a5gRmCNs04aHPaySb9eXXgwJWTsePfMt6ei9uPES/m1g
         Iz3R9rpcxELh9Y72Zc3SxCSn5rKYzlUVgfD2AGpPzpdu8z6B81jcUIbhyHkA3ICbk9HK
         PAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650505; x=1780255305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AVYsCz7J/uOD6Q014m35hqnUDvr2fi6eWsdHVw2C0Nc=;
        b=lH/PSOMO3F3z+efnr+BKwZkz/fwDSdzrMhxVBt/RTIqwkqT4fWZt9Bb+csFuoytw9o
         WyduqFZERxzEU2VbYjZv9Fm9Ke08LIhEMAzjLPyLo2ZF4r1Yv3D+NIY1LnhGLJuuMXwf
         n/bvt2QVKGBuFnpaUf/jOmB8JSCdtwRHUc2c+ixRWLdaM52hEnNzrNbniWiObuaYhr8X
         u2uSuKiQrhkMHJjJ37vxl1gTNBRlqm1qlMKWFa/fgmAeGvSu7EulLj13XduAPQfAQGmK
         YqCeTqDIUrULC+U8TcNoCDWuq5Ea+Su9c5Y77UADjBm1GqGhqiY8QxmeheXN/0ILIGLJ
         FqUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MBgTdGIu76OtRml+B9Wk84+Yv/WkQ4WeQXwEJxqbfHL8XGuaqL/tdmpKo0nG/JuG2k2F1qxd009E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkG1sWo/kJK5BQs03QdzbyGEC8cfqXvptJKJ6XqDUgNgZpH62V
	zL0+1b3s2Co58mk59uGh0D2hl/cQzRw+d26SpjVUdnwVe9kzQAJfM1sg
X-Gm-Gg: Acq92OFYvHlTlAjzS7QJ3dgu95rWgKCSu1I74pFB8L6lTqsz0NeaHXU9P3R7Ae0vo09
	7ZkbEgLE+TaH+bSe9DxKbvlujnK6n7yhBDZmoR9YbVYn/TP+o4XvGQM4BTolOuOl02AOlWgTUKq
	sxfgeA7ICMgrmCLFdszfRKhiPtGn1XbkWrTsNlWPaQUmQLtZjyaQ6GJsB4a6hG/0IAJ9ZibBAHj
	SE5MbK5GIJtQ56cV0EUaL/haJ5RfXp1Vpttb93KrTz/+76ZkQyFOyiWKES4oPLUADEqtqgnJGLX
	j5QjXfDw4q+FFZUuoLs5Ez4/VtXxwch88MMDwYa70aoZvyVwPjToFXUEiqQJi5HZDkE/T0WM/RE
	T8iZaPuVvHuzqAldZHAY8nHoBQTSt2wr7M5IG/8TNWWbi0vBoRgLB5jIvpeLDmujA7hHgASH7S/
	+wY8y4NP6Gj1/9dmsCqC3SuR0yf8s7G28+Xel41Xfo42aeRwM1rqOKOtmME24=
X-Received: by 2002:a05:6a00:9092:b0:82f:38:a5b2 with SMTP id d2e1a72fcca58-8415f3640c8mr10712096b3a.40.1779650505434;
        Sun, 24 May 2026 12:21:45 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:44 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/36] iio: orientation: hid-sensor-rotation: use u32 instead of unsigned
Date: Mon, 25 May 2026 00:50:30 +0530
Message-Id: <20260524192059.1193716-8-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192059.1193716-1-sanjayembedded@gmail.com>
References: <20260524192059.1193716-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

