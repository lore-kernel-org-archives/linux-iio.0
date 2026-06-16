Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D190142982C
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608301; cv=none; b=QhwVGHQfj3QJM09mpdJDPllzG0z4N23vkKXE8xOAZiMnGqxWf1RzrNnC8wwujWeYd7Qoui1MKufHVxOuXCNn69N1RZ7Xsou05QpY9qhrL4tifU5TiNnCtwfr8Hlrv6puKyQOAxG31QE8IqFeZP3KVhdMKE/kYxUbLX8f53Qcpfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608301; c=relaxed/simple;
	bh=WGX0XQW1Y1v+z1IdcNozewhJkNcGnleipMvP0AiYsYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITwB5zhU82d0ufpU3TbDA7X03dfzlMdWBhSHiLYXZAubet+I4igkBu7QfzADBX32C+vn3JalB2SZ85rH6O3LSqgUeVfJALOrb01G+lNdwgRPE7Vg6WWDFHiR/o1kw93vTf3kB8NBy+P5jLlWwHqp7RhwCcZ7BpUghVAQQF3j0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF7xvg+w; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF7xvg+w"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf1f074a12so44042665ad.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 04:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781608298; x=1782213098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaMLitRf+7HaGQy1+AJ28uDdAxg83p9TaFLMbB8gFSg=;
        b=QF7xvg+wrM+W2gP6yMxGVWCQTZ8zAaaycK3FOWkFzJiQZnql6uO2cHA8U9qxxOgDdm
         C55IXiKRfmlM2dtW18FXeIROeEQl80g/XE/z9wVdsjAVbTiWvQ7IdYomrtqpRq5iTi8G
         9coY4YQHMTPXsLPll0IOunzTH1HG8n+G3Qn1NAYXZ9Ver59weHLjrQgP+Fy6TigVVDol
         xbjAJZu7NiWOLmwR434d15PgxjdvthniCFwfN9TqipDIe+7d5i8Vk7RTrf9tyZPLpt9T
         6paGvaZxAKVvWF2sDIgbz44Rs9hk0kw51u2B3LxcZC5jaMwH4PQJa1UBBXlnErRG7Ohd
         JXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608298; x=1782213098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaMLitRf+7HaGQy1+AJ28uDdAxg83p9TaFLMbB8gFSg=;
        b=IkpjmhDmFJhpscMd2z/WFwiOMudhzPeg0oPW2Nc285mROiKqyH33h4Jq+/+5v4IOz8
         hPbcnCmLWWLX4dVnfIK8rGsYVHWzReU0moxnODfAhVLBE+JVdkInTyuaFCifjLyTGXt2
         DMiAIqqt/oC4Df1gWtTEpaqYOv2AqMAlDCSQvBQjQdEBWQ8NWunXZEaftMwUR3xgKjeY
         QBzW2XKjjbGZiIijbOS9mghT3nwcAkqn3y0O5n6b0GIR/erJyZqTFrsMQLwuXPHW4Fou
         0YrHOU9Ywl3fI+wMYMWkHB1OpzNNAlszoSdKqiqhVo0xrQNt5wsWVKcZngUabnF+Jg+0
         peXg==
X-Forwarded-Encrypted: i=1; AFNElJ9gqHdhE9DBQ5Uo1/g0KSc9rZQu08OgYUf8iMq4piZoMviNaoLNOcaDAzHg8Fc8z8cBAP2jh+l29Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlnQE10TfeTHW7ePPGmQTjw4kdDpBn9pWC6PyBTj2xV7pfqp24
	/mLI3LwfAoWSlp2DhafNNSLS2NH4L5qbmY2JZqW6vZunf0psAzGVxSYI
X-Gm-Gg: Acq92OGnfh8xOOQVwztwJXQ/gAdsq4GMByyNPGl8386NqY/8tBLq+Dw/bPstUgZqtXv
	3/2VWD5XsPwdO237BsyiI4HGx+yEvivT3hXnNQz7rpcxMLOiUEby6f6fEwU8uP+aUbLEXP6n4Be
	0Ew8lwsmaXaDt9CRF6FD51EAIBc4mh1Er7Jh1/89MGocOxPuiCDjWGMVE7o+XTTDQM9W7uo/6Nq
	73/MEQHiU6PT9Wflovz9eWfu7ROcS31o3OhhxL2wrLegGBEe6rQNuNrdxgFN4Pt4YGKJ6yQjon4
	1wEChFnwBulmziPcdZOQdlm2F5LFP2Ldhl0Pj5Nv6c2lPrH/gSwqD3id2vlTjWXKgvdQybhj1Kb
	mH18/+KfUB5FCg//82d7VkHAYIFS9N//tmsA8da+yG9l5h4tjAz3f5klL/1s+7FFCEq/41M3SrE
	GfVPZtCK68DFU0fsajyXDm7OdbeFe638dwJ0DcEDhBaY6VXOSEcWb/QV3X5C4=
X-Received: by 2002:a17:902:cf04:b0:2c0:c940:dc32 with SMTP id d9443c01a7336-2c69a114289mr36693965ad.16.1781608298360;
        Tue, 16 Jun 2026 04:11:38 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f1f0a36sm125248315ad.15.2026.06.16.04.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:11:37 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] iio: hid-sensor-accel-3d: use ! instead of explicit NULL check
Date: Tue, 16 Jun 2026 16:41:32 +0530
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-11-0cd544286575@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in to follow
the preferred kernel style.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 42c4259bf209..0999f7dbf434 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -329,7 +329,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct accel_3d_state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, indio_dev);

-- 
2.34.1

