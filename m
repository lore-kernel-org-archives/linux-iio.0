Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441CB3D5225
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360618; cv=none; b=hpuNYVEk+mJLaGp6a8uPLAufvj0atwiPT3v5wrcuYUi6o7wtQ0WB+DYjN7Bx36r83qGOVR3x1N5+KzkKazruCFcmC/SgS/qoI2rKd9gIKj7A1rjBYGEVZWhVMqkhgamiJPNst65rtZTZqF1tBsKbACzvQKtCydrA4ZEvzWAMDUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360618; c=relaxed/simple;
	bh=vWzftnPb2VYPvoicuNfbPRc2SN9uxcg7TbWPV9A6AEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1kQq/khALlFhwLjosyy+Z5QwdLyWC1/OnNAvZz6AXiv3gbxdQG6dumHq6ji3/lc79uh8MCJORUrgTgUGwWSNdyglLh82f5DNchNS6eaMbZHih+EDBP76zGBGMXSghRdzhXKxV1lm8iLWykvWhPjxvdIU+KN6PghAKi+pjwn73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebmkuGAB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebmkuGAB"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-834da62e52dso335653b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360617; x=1777965417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrN77yUHuXfxb55ovw/AbnE9BU9M7aiBBJTgg7euu7A=;
        b=ebmkuGABSmc4pgI5g8cJxEv+2dwUic918rfOAUdDg7Mt0E+vIlNlzqtN4665oCczhV
         kdbymh5kJTxAsnx0E6A7+lWLBPDpMymWvGqL2NdodVnXoP+qPHBLDolPVRk+qS1sgDtx
         Y75QhQK/wC4mSqx/wl5Y8TeouVadQZZzJ+Hfdxpr0zVcFa59xUnBFLuJNvVOKB/YXByA
         qHM9X0RM26SEorUkju+0Isxo45Aclye+xjoBfhJi8R1NsQnklgMEdvIMhZ3wxT+4z4IP
         xQ3hQbxZoUvG3RpW4KRShBVT51+kqaSBOLjgaDCI1O8HKBhTM5po/qaBCIPvWUlbW521
         bMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360617; x=1777965417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vrN77yUHuXfxb55ovw/AbnE9BU9M7aiBBJTgg7euu7A=;
        b=oFh55wU8496qkqqv3X+2BkA1LBZjjdOi7363On+u8djq0oXmhTHk+oW8r9iocy0Vbz
         KQfkRObkTVNc4wwnEiwoyEVDaVvT1Y/J+hW/T6RWXpj46rOSbbiABfQWXkxxavBCqrgy
         pumKwJFkAPpLi4TfSalEctZm2USB9ri/bq7I7ZDwM9JcF5xbZJmxQVDoAmxuy2+YF6iG
         SYwdFJ0AgvPz44BbaZcN1PnhUBekU3ZHWbdhD9YCzIS338sRNLGowqWw08Ij6+Ym6Y70
         NWfnYwUsnfe8bDE1lxV5nirfY5mTjWRpNNJ5eqtwBcr0I9Mt86s5BUacBWt/pnrhupZ0
         0i7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8V3i6U9AezyeIVdSbTfj91jvATiuVdPXNufIQBBESJswIYCEsHOJTweOsXI6QlBxQcPsNMuynMSbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1VTVwVju/2VvNCXbLv3+SVvp65J6TR7dKBluUFVSA1WjnaHMU
	+1S6oMymOm6O6qW0BqJ7psvlZnxlFUtQa8k0qxmWCnJ8GAxzP5xgsro0
X-Gm-Gg: AeBDievfbhqYXMmXsZgK/4gninXKDSPOoFkxVidax73RATixYE9+9LZ9fn+e+wkX86b
	rN0HrlL0BqJpttEiQhKxmubfxGLw/wnCh0CHoopnL5DtkHzalI8IuVpK6lYLN3KXXaCdyNuShAT
	G6N7TUNBR7Ge6+wuxV0T26baUABfyfwRe93e2MvsfjRua95//sfmnalvbDkd3lZE/mBQINXrHZj
	yyQ7tPTj7SLUseAYgj13o0dgH702TE8wVeCwGabQKquHdZeHIZIwHSUjUNvR56nEGfzf29xSSB3
	Md5otRHN+cczeZofizV0e54H8BbSNq9+mrfDpwJRe4M9sU4E1OcDO8CKHuggAyMDFG49833urA+
	bxT0Mk5bQwTWwrv72Z5TwGVYD/oPbukD3cxJpVKWZ/u7Jq+r/eLC1fWBx+5hTKkc1zuza+Ip6xj
	CjOMpnIy1OJ2vC7gi8QcftAcNRpttTrJSeYb3JkWh/FoY95YcxkfOA/0/bVEA=
X-Received: by 2002:a05:6a00:2293:b0:82f:b0:28f0 with SMTP id d2e1a72fcca58-834ddbd01fcmr2031845b3a.34.1777360616512;
        Tue, 28 Apr 2026 00:16:56 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:56 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sakari.ailus@linux.intel.com,
	sanjayembeddedse@gmail.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] iio: position: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:12 +0530
Message-Id: <20260428071613.1134053-10-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428071613.1134053-1-sanjayembedded@gmail.com>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Update the driver to match the updated hid_sensor_remove_trigger()
prototype, which no longer requires struct iio_dev.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index a26d391661fd..5288b63f4e21 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -337,7 +337,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &st->common_attributes);
+	hid_sensor_remove_trigger(&st->common_attributes);
 	return ret;
 }
 
@@ -350,7 +350,7 @@ static void hid_hinge_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
-	hid_sensor_remove_trigger(indio_dev, &st->common_attributes);
+	hid_sensor_remove_trigger(&st->common_attributes);
 }
 
 static const struct platform_device_id hid_hinge_ids[] = {
-- 
2.34.1

