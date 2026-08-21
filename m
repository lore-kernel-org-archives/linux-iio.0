Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657214B8DDA
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321164; cv=none; b=I54LUYLpCEexdadCWfdlnPmme74puUO6jVkRrOL4Sa8NG4UlE19hg4vlbDfI/WUCFlaglNfyGnM1LdauKSF9LTuzfNmAWmfJlS1gMjRXws2ivJ+GLOfthvtBYhrXzpuX9JP2/9inKzGDuER8DOMn7NX4P5D5CNaZ+VK0Ll5qxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321164; c=relaxed/simple;
	bh=IfoBQ4bub4ZBdr2Zye2DaFpflAJa8ArwNnySmVhpMko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRt0qXYpUwejRsnf0CfLAeuyLQrtiPzYNPaveaSRnL2EL4tQF5GPjF2Q1Up5SIZLq/5DvwvlW2Mlc/SPeJo7H5ITGYC7qoamOHNOS+tJHzk7rgOwge6cekqfamZvfkxOitE4E3V1SJuLZFcsIJ2bKNLvLywUrmAeKuKhG+YhUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhadF43v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhadF43v"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-476a130c138so1115193f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787321160; x=1787925960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vmdrK6h/jVsq9AV7dib6Dc8oZ4m+hh5j3iRL9a4RIZU=;
        b=rhadF43vG3eE9CL0U89SjEZRUhZNnK/o2Wh2nLpJF4cHk2Pjjc4oM9JeLL+LfnpOjO
         mMRjx2z7PN0+k2JbzGNAscTzOg/V4WA9rGD8FpbqFT4MtN+XWrrusmCrv1AHPbqvs883
         e9wa1MBns3VA434WtGIxSJr73JOMdoDrRv80rax08/5M0FQHST3mNLnlG7IpSPoYHqKP
         0ljqliMev3HMRU5/uSGW8iyBAMTuHN3nZ+IXhL6c+ibqRjod/HMqncaQYd0B+L1IdQfO
         IUq68sH7TWuZcIRbcqcg+LPuI3fY+aJtF97lTUCyxoinMKfnirVqRFjN3lD+UoGsvT2H
         elmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787321160; x=1787925960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vmdrK6h/jVsq9AV7dib6Dc8oZ4m+hh5j3iRL9a4RIZU=;
        b=qB3EQKjD/AUsG6+m11J9OeyrmPzCQhqAvPYY8Pjws/TKPRP0wUGB9VO5gV4+AxUnS+
         MICNPuaznqTGaGOv3RX3wmLWFTQm0F2X1orT4CaIYHYr0uF5sY9p2Yphu7UAQVpSgpnC
         IGahJRCooJRKKvECzsJEfJloD2D4+nUZyuXZjxIFvs2Xkc4cihQogjvPdS+Vn3OFYxJ+
         HqoLnuswF/cTfJj5KYT2JzF5OTtXwRWengRD02nrVCTziE9IjiG4dsyaTY4gNaorqdFH
         5RK334fhIWCps9OdkA0is3yqtIBqhBJrF5DCG3TZ6RmJ/JUa4BH8ojevTQkcl3lR/S0R
         OUPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrbMf9Y/fvK/ACWt5Cwff0cFRBptoOoxrOIKW/kOXNcu07h7MNnDmNlHDygqjMlUNmVsaL0Tcnpnh8=@vger.kernel.org
X-Gm-Message-State: AFuF++nzrgFSt/DtkfZZ7wbgCeDLCj/fE3sqOr8mosN/WCgecIlr4ftB
	IJ8EyXW/EjJsqZomHYXFxvZN3lWRW34ADie2RmAwHg3Sv/kn4S4+o0QH
X-Gm-Gg: AR+sD11P7M8/+Xrl/lXdrCxr+pEKTqOcC5NwtICehi87IO7usFDICUETr7uM1+FcFE/
	onX6XB4stDoNCCiLvy9JKZjHPmv2n6CvpG9T3ELZiKpehUsdawlNZfPeZzU4lP1vXFQx8pkdWRZ
	vzSfsOUY7SX/g/LYuUMEvSjAmxg3Zm55xI9Bn4yoEMzV17tSxL6cE8GYHhh8QSMn8+LH2abxpI6
	tkFspso6iCf2zVp6HmlKrRDaBkCoPsptgnmUFAfooKOLsJCUtW0F3EitnYPMeb8OQNt+IedPQ2I
	dmrJzh9X67I8dXOUGglRWfXWjaxeX2Buz46y4UKuTlQykIDur4e/vqVnfumKhp2ox8tZ1n66Zu7
	ugA89HEkbis0bvnU/NC98X+wsWmfgVT+jH74eJkzr3Hz9YWmzUnIdyD0t5iypk+19apM8zw8Tzp
	xqlXPwCttcI1Z1Xpcuvb/gcEuP6FuxPV3jO4EVkqh1XggrA082Qjw3zmevia8lLANx5h2At8azy
	UUKett9mNVH8gP3QBSkWRCd1fCc+Lz3A24=
X-Received: by 2002:a05:6000:989:b0:481:512c:b6b3 with SMTP id ffacd0b85a97d-482c0b55df6mr10300015f8f.3.1787321160210;
        Fri, 21 Aug 2026 07:06:00 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:9816:5963:8c6d:ec64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm15106964f8f.26.2026.08.21.07.05.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 07:05:59 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: gyro: itg3200: use iio_push_to_buffers_with_ts()
Date: Fri, 21 Aug 2026 15:05:53 +0100
Message-ID: <20260821140553.80246-4-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260821140553.80246-1-grondon@gmail.com>
References: <20260821140553.80246-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/iio/gyro/itg3200_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index 87efa2c74ca4..426d04d496b4 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -59,7 +59,8 @@ static irqreturn_t itg3200_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto error_ret;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    pf->timestamp);
 
 error_ret:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.50.1 (Apple Git-155)

