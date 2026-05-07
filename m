Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7DD3ECBD7
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151103; cv=none; b=ItUa9FREDAL6Lp83h7JFR481px5V/HuEqalnbOV/I06mp4a/Vn4E9MGsXOI8Xwdk2wpM2ocvVvd10k737s4q97VIVKRbvHQM/lXKI4gQgHzV0xVRJ7Ua1KFxyUbQiq6qv5wxIrsxlFMgeNyJlHL6NhRtGQEXKx/S5KaTBUwCe7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151103; c=relaxed/simple;
	bh=7wwEeddHxhCClQzgwuisu1/1yJfMaAt2aMlXmyRxTYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oo938wsxMQwW5Nkim3wwbW0G9SbcC6wA79CBDGgaQbg4Cffp4GrB3XtQSu+2gawsjD7EOpjnPLs5kfwr+03n6KWXyph5Yug5MJrgmpKW26AwDlYUAaHvq1NM6OtAy1x3XTY8t6lPPSM10ms13s0Ah+aX6nDlXkK/WVuIRlmrN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwqiopdD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwqiopdD"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8891febd2so747298e87.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 03:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151093; x=1778755893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4zF8aJYC8sIqGUROlbDSF6MUK4SPWjcto9OGe/HwWY=;
        b=iwqiopdD+35jsAzlLNJuDfX+FvyCRzVQ0maiISK8s9ZQmrkk+WjaGmC+JocKTkSpWE
         H0wHYGH/oUSnKI1RgIYprAkOR9swCGtXXfkALa4PpJiJrwZIoQ637CL3bNB0t0nFT+Ke
         PohHN+xNzuzrI7pWzS92z9DGocD1i8+gIM0066MU6cIiKtNyAkoGjGkFFIU4D5r3FDeT
         xzfYyYRzHw/ZEwPP+PpejW4YPlGqcTyCepiv0RlExJoHG/n0q/Wa8+QcCvkeQySWh+yd
         TCQQZBBHxzs1BR6P5QoWjhdfz9L2IFoUuX0Yk3GgOqBYnRE183IErLlmKHDBgbWzanOx
         KHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151093; x=1778755893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4zF8aJYC8sIqGUROlbDSF6MUK4SPWjcto9OGe/HwWY=;
        b=Soo5PJ/QW251jgKmDiZPjDO4KlemJHOthaxUZbmxkKe27w27KX/uYKy/b2ONElNM+p
         +PAUb4CBubSNtFgf0rn1yZWQb3lfzyQf3oJvRXVt+BFZjs51O909HVn97tl/U+758Xdn
         scVfS8QBECP5PwQRKMgulovJOju2Otb+7hpk4Qcnrz0JKaEpyFwybpadj91FO6A7pZnZ
         XUTeB0edVeYMCoC/SLsuGJQ/xrEw5OPjqVplVCy50aZgRPKkVCajWW1B5X33lQ4xVjlZ
         F066g/yZLupyI2/JyAnikOQ7GXIfys2QWE+bSmYviZwd7n1uiJbaq5PP01/w7pEa87Z5
         pRUw==
X-Gm-Message-State: AOJu0YwK4xy6o0hIayUH6wZ3KAowktMgxv7GcwpiTntdrA9qGnteDMr9
	7+cfVgZZBvJCdpsHLjolX26PWjhQ20dDprVBBRV5M/Vi0PGjNnjxk1mDfl5dWQnx
X-Gm-Gg: AeBDieu9IM0tvGLg3souUZf2U/TxxJAvcVg9Hy7FuckhlN6V6+ujWhFeDJgRDQBprG4
	+0TR3Nsbhhh0QEtREaguIPbNanJ/coCytbVUKaZpaxsZpUzoStHxRhX5Jj3HAqsUOG++IodgVZ7
	vWUn1hNmAsMCVNA6SyyETO38mbOzFMqab++xQKWo5UrLQrAr6KGqlkcoGFXvGc7LZxTSEZ1ai5k
	jby4GVh7JeaJM0Orj1P465jPJtTt4T/NW2A4fGU1Mo0bxYYdM52R2g+a4I40ZY3WWcIAvvDI1aW
	kn5AUkO6BSyH5Bsr2DUBGsiSKuOMHuigP7Qq9VrPFCtmLh147wv4D7XPo9/E/tEmaYaZR3Lq1PU
	6x4IVZJ93IoBpanTlndannXNAgvAEPhJvvlO8EHctSBiDcNyUXEoNwNFfJarssuxnoMVAJp2vSV
	3hwk7cdrO/sRg5tmMugELQdIstXm1eIi4iQ+rfT8nF3CXKOFwpkD+0Fd6CYRFnU9N0MCwlTTsf8
	Tw=
X-Received: by 2002:a05:6512:1113:b0:5a8:99bd:12cc with SMTP id 2adb3069b0e04-5a899bd137fmr960708e87.28.1778151092648;
        Thu, 07 May 2026 03:51:32 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c341848sm5530224e87.65.2026.05.07.03.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:51:32 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	mike.looijmans@topic.nl
Subject: [PATCH v2 2/3] iio: adc: ti-ads1298: Fix incorrect timeout comment
Date: Thu,  7 May 2026 13:51:27 +0300
Message-ID: <20260507105129.25639-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260507105129.25639-1-shofiqtest@gmail.com>
References: <20260507105129.25639-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the lowest supported data rate of 250Hz, one conversion period is
4ms, not 40ms. Fix the comment to correctly reflect the timing.
The 50ms timeout value itself is correct as a conservative margin.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index cf5f954206..186bda3087 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -210,7 +210,7 @@ static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
 		return ret;
 	}
 
-	/* Cannot take longer than 40ms (250Hz) */
+	/* Cannot take longer than 4ms at the lowest rate (250Hz) */
 	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));
 	if (!ret)
 		return -ETIMEDOUT;
-- 
2.54.0.windows.1

