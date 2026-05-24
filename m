Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E5309DB5
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650480; cv=none; b=jvC+zEGZ2BQARpHGybeZliUeMIxeh6jrts5fqB26HoaHviFHPoaCpJ5dSDymXT7TWNQhqAcfaJOQK8CKNAKfAghS3pB2QrkG2tBpAcyFPtAnRe0FSgbs85K5bbFRRg0eL0oyQd2+qqZfxadtwIFUFZSfILLQzlLE0imuSlGMjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650480; c=relaxed/simple;
	bh=9uhax4q2rGQbpqbcJk3KVDZqiUQogDJSXsxjgjQuG8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iuGkfCff+NUEoNQBh5StXFBqi1GZKlTHBeUrhxCyKjKQScgkxbrZKzlGRgB39RydqD1VjseoGmTXGvyUSc1XDEYlo+OPW6rzaiAmqOz8czRpmPN5le/BHjnxVGOKKyVaC7ni1uym4L0MzmbClOS48LLkgUjSGLNczk9cxivTp78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUjhdkST; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUjhdkST"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so7525584b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650479; x=1780255279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCgsae+qDTmuIw6l4PzkInHNCEWSiAzO45jvcrCltYM=;
        b=cUjhdkSTlXa3+LP20MYJTt/iCXntlyD2mnzLPqj3g0KFLebsO4Jvhj/dDeqJBcHvz1
         ecOlx0woLJzlPOAUMdzj9vJGAHRcJeD4fXEc2X06+CbP/Xy6fxXbSpW7Yi+iuDoPCQG5
         /D2wtlN4SAp1+fHWTsMEeklEEIgnQqyuFN5HSPYOF1oiCKHShgLbC4CiHohE9eMbzCd6
         DNdVy852l40VevabEIxR0sLmBZxd+1oYUNiAdplXvreD2q7Zm8IGtknlWq5vVsX60uUn
         ROU+mZ32hkVmzf+yKl9heOpTbiCypWD077gzXDN0fc3+4A8Ey7aWoHlqBN9nEpejydlH
         irOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650479; x=1780255279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RCgsae+qDTmuIw6l4PzkInHNCEWSiAzO45jvcrCltYM=;
        b=qMn5cOikDg9rlGqKLo3UMaRNXv9/Kr83G9h9ox1GYsk+saeFa5th7bX07snsRnaPAp
         yVv8BmP4Xkocxp7Fyyz00rtn96C5UsI9pZkQLFHUArk7AUntIn0WSEGJbesQYyma9fs2
         AXSYXNXGU/idhh/X+33yW4sfEPmgXYiEVPMVuFws4xElSRNZWvs6zRfZzpxeBaC2Tp37
         o6R7WCFycMmnFgGLQoodmMX0ikm/pgnb66XG62BiV7pF7JUFT96Lgz9qHZj8dCvKkMrn
         r7H4cYC63Br28qRSmO8YGyxiV/mEaCz5jb6CRdGoJvtG+L3VHrv2npo6GLWH0CkM8j24
         qA6w==
X-Forwarded-Encrypted: i=1; AFNElJ+fB6QCJvpheIz5qgWjxMbg6KgbMo5oUEpcPrbbeLnpLVp17f0N8EOl3ai4Bp9QpuJlCJIOwq/l7KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0nkkEA9hqdI+LuUt8lB3w/GdEvlu35PYNZ7Jk59C7n5//gJU7
	UX4hFoo5UPnifz0IUb69FHrK1Wl5JDnAt8k3CzNhTgD64SSAxq9KM7dD
X-Gm-Gg: Acq92OGQYlQCbQl3mfxA68SxadTV1Ml7SuIehloDTfcs6vrvbtFSDyD3CFiVG2mW24x
	XMtzaNAF5zrecodBHV0YPbAgZk9rh2TIVZ4qmZbLjkb46fAwd4btlatYKppAiSHPjOznb2PzGEe
	jzGjilu10rhcFIaRg93ZOgks2XJ9OwyjwMWDUISItsyuQKpZYqXwa7KmgJs3Q3b0BVb8MPKXA5n
	IsIH6iV/LX5Hgo4YZOV9dRZGbNMO1vjeltFEpEIEYiZVsxZ0g90pq7hyltMNlvpBQl0UaMBk/kT
	3QWA2pUkNkxecfOYU05q97m2+qqCMqXmF2GsOXyR2PTXzhgOcjol2rsb3T+OyQ4GGJR7Ue+0tle
	jCgVLHtxGreuEhc4xEV68QqAEc3XRpXNQ2xQRlTO7RDxKJaMh8kG6sA58nTjBXfQnI/jGTPqS6s
	IlGhBdNPgSJbwYLEb3idT3zt3DTmCG59Zl4fXFmfFWPq7dnMkH
X-Received: by 2002:a05:6a00:1817:b0:836:3f6a:3e77 with SMTP id d2e1a72fcca58-8415f17db99mr11156443b3a.17.1779650478457;
        Sun, 24 May 2026 12:21:18 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:17 -0700 (PDT)
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
Subject: [PATCH v4 02/36] iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned
Date: Mon, 25 May 2026 00:50:25 +0530
Message-Id: <20260524192059.1193716-3-sanjayembedded@gmail.com>
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
Changes in v4:
- Use 'u32' instead of 'unsigned int' as driver is already uses that and respective prototype has same data type with input from David and Andy
- Link to v3 -> https://lore.kernel.org/all/20260509101040.791404-5-sanjayembedded@gmail.com/
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c340cc899a7c..020812639947 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -187,7 +187,7 @@ static const struct iio_info gyro_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -209,7 +209,7 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -244,7 +244,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int gyro_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct gyro_3d_state *st)
 {
 	int ret;
-- 
2.34.1

