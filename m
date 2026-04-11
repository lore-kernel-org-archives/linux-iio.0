Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC9259CBD
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775914532; cv=none; b=KGijGiz/7xXMfnJQjvQZ+rBpaw2ePz9mwuyQfVR52O1zXsxu0GAeKV7fSMy3QGNxN+kVPGeo4Tydesm4Kj8TmxGexE+9+YNhk3q5MOT7IjKvbILE5oenJij2QUYoYChKxNfFjnptzloZJP/vv39v1RnvIFCz+h3zp93zE0Y+rz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775914532; c=relaxed/simple;
	bh=OtSFvIvNO2UsQhwYhpaoeFLi0Y5BtoWJurPvxz8r300=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GLNx5icWu5zJID24RqYWLvXMeaWzwMBsBPjNFPXj/5lpd+EYUJ1/ouQqmQGrXFwNWUNNRcrzPJ0lvdmE2RvpA8ehidulRE4oBFsm09rZGG1RUH1Ooj0sAujG7tWN8Cf+2BjD57uyd7dHx3pXXZdsKAdnkyUejsEtzQXeo6clvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4GZP5k3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4GZP5k3"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d90833cacso1941787a91.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775914529; x=1776519329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0Or23BS7mDFDSkUDM2f976vD3FVKjgJPHCZRQcp6vA=;
        b=R4GZP5k3LAAU99ggcXw+Wc2U+v9ARuD/zhbCXFfF0kFgK9WtrjuBNbELhSrxf+xo8v
         oNmOQRrlxY42ILDrJQBkhwF2HXYCRYFBDifzYjf/p7FdHJf4Mo/KlTIsk7mUegx9SJ2P
         RipYTnLJIk1iWSDFneKS+FgznfQpPEhd/KaIJO/KmsMRcEtVpSSWOtC9zAjsWKA7J67K
         FH2OtWHyHDU4ssvZ+iA+geguULjEySVfwenE0b2HoHjdrruc7hV9dkMs0+I2kQXMivXl
         FYYI0tDcfojCMnhFSvgcuQlwoSwqDuGk4aQBhjAZCs7Y0gPjvUjczXBHZvhN5Xg3x2Mk
         0Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775914529; x=1776519329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0Or23BS7mDFDSkUDM2f976vD3FVKjgJPHCZRQcp6vA=;
        b=KPgFfkZBprtwbeLotYxlFVQMYshw/iWkV3Ys+dCFg3WjXsm3DWfcZDNVKC4u9jKZgF
         /3PpOPGeB/lp8DsfsT4KnK/Q5D5zCP52eLIDheu68HXA8GgbDfnkN4srQ3P1ubaTSTX2
         HYzUo5xpw4P6Aqn0fTN7c9kEtuS0F65DScDg8yn6HUokuP1ljsjLFarF9uqv+eyYnX9P
         VUun9KkPArKyyAnkq0c3zDbq8gLeObpscOxJrVo/izLhaiRYbgtcJ2xxnbu5c8IJ/MKo
         TGxNZOmxJbFatCJLBSFo/o+qQ1/DHFxbVpaORC5fDAVXw5ayD3unuDKgDpueHj0Y7c2S
         mxyA==
X-Forwarded-Encrypted: i=1; AJvYcCURDOaz/3A7qFd0rsM6Sk6ed3TKU3Bwpb526WyY4LfXq9U9FWbsDPb+GecX8sEodnBcsjSe00JAYHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZtwbKl1ZAH+V92TDyt3jna70G4PexrWJYlOya4Ix0I64gVLk
	dcJZ7wvp30NBF6L9/WZozbrI1Z1qvMXz0WHjjiquk8R0mAC1nPStjKu7
X-Gm-Gg: AeBDieu0b/4UpYb+0kOC1BNSt1y9ArnUH76XtyFIgtdBK6Qs8UsYOBFo8ALvxbXY9Vx
	hmzME+R9uRxBbM6/tFxyk0zi7O2aP0qTbk/n70JEqvldPk+GHjJhMmxCZQiorCR4LBRlpk6BNK2
	amj5DXbw5vLw2ldV0v/G6BhWQLk0wVZHypIHMM4iX4NCCvrsK9KCjenUTChBJEH+GygrJr9XQJH
	3WtsrblSMtKh3tjaF1QOJRBDVlmHnOmzo5rzn8+hmh3m4eZEyF3bR0KQaePmuiZsdzoKHyRpwcL
	d4lF4/057UoqcvIjxwT9XUHu3mi0XijRYEQyesZCo8yjEMmInqCGUXqFgF8gNJj6SvBm6d9dMta
	GOaLK/tV3w+TYyOK761tN2LVFMtGdQ2Pnast0MsOQgsXX80UK5V8sFA2jA6qswqEEFY5Y4eKKFz
	Wy7fAVsle5w61bgcvXGC7INw==
X-Received: by 2002:a17:90a:741:b0:35e:5723:85e3 with SMTP id 98e67ed59e1d1-35e5723894dmr364580a91.9.1775914529394;
        Sat, 11 Apr 2026 06:35:29 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34e959bcsm10056720a91.0.2026.04.11.06.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 06:35:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] counter: Fix refcount leak in counter_alloc() error path
Date: Sat, 11 Apr 2026 21:35:11 +0800
Message-ID: <20260411133511.2214024-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After device_initialize(), the lifetime of the embedded struct device
is expected to be managed through the device core reference counting.

In counter_alloc(), if dev_set_name() fails after device_initialize(),
the error path removes the chrdev, frees the ID, and frees the backing
allocation directly instead of releasing the device reference with
put_device(). This bypasses the normal device lifetime rules and may
leave the reference count of the embedded struct device unbalanced,
resulting in a refcount leak and potentially leading to a use-after-free.

Fix this by using put_device() in the dev_set_name() failure path and
let counter_device_release() handle the final cleanup.

Fixes: 4da08477ea1f ("counter: Set counter device name")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/counter/counter-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 50bd30ba3d03..12dc18c78672 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -123,10 +123,10 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 	return counter;
 
 err_dev_set_name:
+	put_device(dev);
+	return NULL;
 
-	counter_chrdev_remove(counter);
 err_chrdev_add:
-
 	ida_free(&counter_ida, dev->id);
 err_ida_alloc:
 
-- 
2.43.0

