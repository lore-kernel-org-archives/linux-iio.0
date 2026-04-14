Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB33019D6
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209979; cv=none; b=FZnsyDobJxmxG0xom4oxrHyAFtxC1xCjo8mD7wonR/bnQ6rcXAbxp86V9P6OGGxCwtIVkVbNMQgevtbSp1U4BLiZFWnsJ09m7cLNKRdl0YmpyitIMEsLyjbbpjiSL9lbfMymsTjbdi+VTE9H442lvBEHkq3gRisTX2BxrDTr5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209979; c=relaxed/simple;
	bh=V+8xRjb38N9k8m21mrgWMPiodX+L8M6kxRCmfXwrglU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aB0NYjg66V/Q1Eqbx2pUCVwz7CFShHMCD8u9c9aAThPSh1thdFeCaRxiRqr1GroW9wA7DPUwyuZe8h+l3qLgZ5g7u1cVE/krzMpGOV95GriI6jDHI6BIbcKQPeu9aAIaBhA7ElIMEhxP4wtUcYLQwOpytcvi6TsUNi2zOdm8CYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=VU+jOoCA; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="VU+jOoCA"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so5721372eec.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776209975; x=1776814775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eQUooV4agpgxiKsY6wKBu/XJ5rHnng5iqky395I/lkA=;
        b=VU+jOoCAW5ublGIi9hODSSRqykIGCNb6inzTpFYhVuJ6NqUAeYTpIiSbzAY6fe21yn
         yQg9pgPbSdBbk92h6+hv3ANiR9Pv0SapLoycNfTaMLFk3QjHjbJiHHyCf30zTg+GqIQ5
         jxXFWZN0AimVwerNUoh9uG9kbSBpq4+60Rvi/MqH9Z2jW5nnI5i3doWE5kkwD7TdIHub
         MgzL3vPGpVlzraU6SIWk/kSnnopqDXALbATavo7hE5ogKFtmxt9TBDWhOkjg7E3VJe/J
         hbFw5ElvDX/hq3kWNDOz4rB/G7xMH15ad7ZJXrCkHsdIqxJbcVKLO6cJPlVXs79NBbBA
         yEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776209975; x=1776814775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQUooV4agpgxiKsY6wKBu/XJ5rHnng5iqky395I/lkA=;
        b=HbsGSnY+rwhlc3Y7P8tTzDwfIuR6pm6NJ1ztjX5pDsIEYok79y9lbTag1D58hGWaTk
         IthT90ghl5AC6L0xWgsx9Z+Edx662Org6KwcGKS960GZF9dK+hd/aNGIj4wKAzVOygW+
         GZQeR2c8OVBbk7TetfZaIuHYPgfVkiT9ptzbn7nlYOMA5lFP/NCDkxFHCEb9DWlpXszw
         6BGSwSdLpqmh+OpwLY8z3JIjHfi03kNkOjhPCPTLQqYk2roJos/dKFtlnGXzUJAOcBPJ
         QPDvUOmxnvhmuvWPUnTjyzwgdCKy/h5Nxh7kJVNLVdCjpAMxE4WvKSCMZye8jSw3eI0E
         YfYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Q/S3dhjHAMZeRrhlKFvk6xa+pfPgd9IXOuIjrOtCR3Hdahk/ZL5JpTAl/PdjfN/BIwQoSk6Dw0nE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqvq7nzqXK7jPPr6IBcZlUhwyGRp/FX+h3rXHpDkC7/f0oIWHy
	8ScuBIIlV7aYKD8lgqYO7LSSMZVVi+fMq7yS9RD+E1/mDo9S09NlPS5Hrqjhtm4SToY=
X-Gm-Gg: AeBDieumNxd7TzerxvWM5JITC1ZdngXDDLiL3nKWWWHpgY3xPL7J3UnEGknsXMxdJ8r
	8A3dFGwc17lI7RUkCewOAixpTDu//gnR9pR9GHbSfVZKB0zhYps65QTRvgYYDyzuKaj5nSHqXFt
	9eKHvfjUKSysO1YY2UaCoq7wolgEMt7VjMCiq7Ieg67Z8qWwEsOqQZ1//lBwfEP05DdL/zm1NBk
	bwee4fMy8OoQ2noQErlCOAY7I26HouGaeDVnGonXdAxNjk7/EkJ8qdY59SjRNr/J4X2JdGSkuP5
	8BXrXtEMYsFDTSEEpTBozbCfoeuL9LVy6GbR759p9WiZuppIM2shEhzerC7y6t5oTJTlvqSA2Rz
	fdIFXu+FrYkk00nts5KqgpypRX5fX1LNrSuwp/T671Uks+friSKQeKVVilY13ml9RsDnMDZcmky
	Oo9HJNBsYbcHJgi0X/faRajgeTooB1rXYGXFxHMQ==
X-Received: by 2002:a05:7300:320a:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-2d5888a1ae6mr11946610eec.23.1776209975140;
        Tue, 14 Apr 2026 16:39:35 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:d8ed:1d91:d678:ff9c:58af])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2de8f960dd1sm118642eec.25.2026.04.14.16.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 16:39:34 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Erick Henrique <erick.henrique.rodrigues@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: dac: m62332: Use guard(mutex) for locking
Date: Tue, 14 Apr 2026 20:39:10 -0300
Message-ID: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
simplify locking and make cleanup automatic when the lock goes out
of scope.

Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
---
 drivers/iio/dac/m62332.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 3497513854d7..233a179d234b 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -41,33 +41,27 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 	outbuf[0] = channel;
 	outbuf[1] = val;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (val) {
 		res = regulator_enable(data->vcc);
 		if (res)
-			goto out;
+			return res;
 	}
 
 	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
 	if (res >= 0 && res != ARRAY_SIZE(outbuf))
 		res = -EIO;
 	if (res < 0)
-		goto out;
+		return res;
 
 	data->raw[channel] = val;
 
 	if (!val)
 		regulator_disable(data->vcc);
 
-	mutex_unlock(&data->mutex);
-
 	return 0;
 
-out:
-	mutex_unlock(&data->mutex);
-
-	return res;
 }
 
 static int m62332_read_raw(struct iio_dev *indio_dev,
-- 
2.51.0

