Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D074A32B118
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616344; cv=none; b=VjVef8pIuyP2NfNJnd7gfIXBVOMRgybvyVN59C3qiL+FK5ERIku5ABV3FU4rfrfT7c6L5kEhCZ6YWbwI+we+IupksKD1ROgpuxImVt2KqhIjwGpkflJ5FkMMjQN0EvzWMojtNy0qbHTzM94QJFJGJlG8NFP8774L16uJbZZT6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616344; c=relaxed/simple;
	bh=hFI0bsXMz+2PaBf6GvmdWgvuDy1uZynADtqdNcaOw4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IE2zsTK2gvmv+PT83X7DiOuLZSfRH92ul9H17/uKVT874xaRuKrmw14RjgqW1m2ba0WC/61PHlcBYQZTZkGboZwQx0JKANWMM0lPDwKHTm6xjCKDtClwZHFF/AFc5CUdC9+DDu91ygRjhen55G350XGHHgnicVWmh6oHUV1kpJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRm2KgY5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRm2KgY5"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84347ad88edso3159112b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616343; x=1782221143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEukyJG+XRwKezQQnUjo18fsrtOq5mlzoNiWZ/icNHY=;
        b=mRm2KgY5XjwKdtmFQTDUv5D/OFJzQdcRh3wPATQ7/L5OYK/RvanB6oKgmnG1ZvQosp
         bpt3iZtPEYTWYK57+dlYmu038yDWyV1Xcgc9mZZmbRRdvY+ouwO2KTaAScTWWY8nRVF8
         npUJNkxwJ+2kAZ0V1uqgcBC04jHyYuyepU/E1V2Lw8F63fXBinskUop9c0sfUqg+aWFu
         Ja6s4U657h8ZpSgIOO+9q5hT5Rx148rd63sJ9TV0fcSTlwTLJD3Ajl2MkQZf47Xs4996
         crHBHjgfv4ePBCIxMUk2l5UCtUlsjpQvJReB1358D+mVUYQcBjHiMvfgurKBy6zIveBr
         BaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616343; x=1782221143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KEukyJG+XRwKezQQnUjo18fsrtOq5mlzoNiWZ/icNHY=;
        b=AJjxl5U0vEcBV2KWOp634roH0CycDx+qlgUDfWsU7t/h0SL3RKsIlnSzuvdOW/CmGi
         7a695cAF9rtWFJtW8Mkz/QTcAfscJk8yagJWV42G1jGszciYbsN+K5meNrPnzHn/zCiq
         DSIO/3kwD1wl/l6nrE4QGZ9j0A69jvBdEJVgKQ/Kz5jjgohgPLRdQ4ObhNSznzHWxKk2
         NGhB+dw423Kzw4lsnr2ILWmD8t3ZqVV2B9LJnWKYYGRf0y/uD3IKME/guNusGssdkQzj
         7nrqHwgciblXMNwy83oGrTYxz+WU6qSx+1salJTk4di0ftsJBk9DlHIr7LnM0l7OjdEV
         mpEg==
X-Forwarded-Encrypted: i=1; AFNElJ+TFqK9EDEwurndywKWE1mTB3W0EzQJgor2OCqcTmexJPiXPCMpI+RUvO8yFd2HKHbp5+fB0gyNirI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkScOOSWS5+M5ZP1n10i0I4o14njJTNwY5n0A52yM3sewqLWT
	IqhjaFAykKqJSeAMjF3GY+1D3VmR0/zgk2SzsoBptwQ5N8Gj7kR/9XUC
X-Gm-Gg: Acq92OFPSO6HtzHCBmUaj617vx7c0qqyXWyrZZlJVYqNVo71W9cM0bv6d7/2Qoom7Gx
	YcKIDwhQMKbQbG90oWjTBZLA7C0pKO0jEdFvjU02ufBjsHKLrtAE2Mu7MX5uPU6aK5MzZKWvN7r
	t5OpJ6crrJ5kE3A6yCFjPcexF2XbcN6IMr1d3nhlzfnsDgdIfcxB+CV2euUErBkLdwPXTwPk5oc
	MeaO1nY/oAxciBVpz5id0IGUsIDfoSd/zUA88LhpJBQHsOBdr7XBx9+EGKZ0bGcRHElAvMHOKVI
	AbbgrPLhg/1XNuFP+IIzdv8ZIfOBHneCNF/QXuclOpH6QrObRpQ2wuxkh/597geqHWUFJtzeyIa
	SEYUSZ0wj1b5qP8/vj1duK0WnvSOEq5oA2G9cqXujqRufrB6Zkp+ShVWxWJZhzPTTganZx1F6+z
	bw0rs/wYzlLSFYNwBaCgroPkZwuGXxI8LIb2iNW1R0m+e/LFDYXoAHQgRuikA=
X-Received: by 2002:a05:6a00:32c3:b0:842:7e7f:2914 with SMTP id d2e1a72fcca58-845153dc547mr4127758b3a.4.1781616343317;
        Tue, 16 Jun 2026 06:25:43 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm13105079b3a.53.2026.06.16.06.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:25:42 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 18:55:22 +0530
Subject: [PATCH 3/3] iio: hid-sensor-custom-intel-hinge: use u32 instead of
 unsigned int
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-16-jun-hid-iio-u32-api-type-v1-3-952c74195f46@gmail.com>
References: <20260616-16-jun-hid-iio-u32-api-type-v1-0-952c74195f46@gmail.com>
In-Reply-To: <20260616-16-jun-hid-iio-u32-api-type-v1-0-952c74195f46@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of 'unsigned int' for usage_id variable.
This matches expected callback API type and improves code clarity.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index a26d391661fd..2139ddb670c4 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -190,7 +190,7 @@ static const struct iio_info hinge_info = {
  * and captured.
  */
 static int hinge_proc_event(struct hid_sensor_hub_device *hsdev,
-			    unsigned int usage_id, void *priv)
+			    u32 usage_id, void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
 	struct hinge_state *st = iio_priv(indio_dev);
@@ -209,7 +209,7 @@ static int hinge_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int hinge_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, size_t raw_len,
+				u32 usage_id, size_t raw_len,
 				char *raw_data, void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -236,7 +236,7 @@ static int hinge_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int hinge_parse_report(struct platform_device *pdev,
 			      struct hid_sensor_hub_device *hsdev,
 			      struct iio_chan_spec *channels,
-			      unsigned int usage_id, struct hinge_state *st)
+			      u32 usage_id, struct hinge_state *st)
 {
 	int ret;
 	int i;

-- 
2.34.1

