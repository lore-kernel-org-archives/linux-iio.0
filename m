Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03641DDC35
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788116046; cv=none; b=s2CShb6fa5HSK4pq5zvH9IjHH22y+2VVZMh1xU1Aa0GtVw5uGgYnxdYCEFPrHMRzHqdOusvb9FHDrEnqUqFcxgt6f/hfHuqKEiUf4fnOaKb6Yz7Vzmp5Lt2dcXjJDUCKt2oi1FWi6WQDNSs5xn72IUgLC9m+SCmmkIdVgzsepuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788116046; c=relaxed/simple;
	bh=G9R9x1h3gOGXHwUQ7Jm3JXDD+c+UzZ2B8yR3B763DB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COPocXGCT7onTQ0/lT9JtXX1Xv019b8SbUAPZWP2A/MKczpjSz5CIlnoet74iIUTaTEWjPmInflO+Yi6PsuNY1T68PkPsRoIQ2D28/5d0iH168DZK1DeSczb/rBj+EukWlcrsH339Wrzbjn+TUrmI8VJYzeMXelxHNR/gzzDzb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjnd7Q+a; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjnd7Q+a"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca7c1176317so2309847a12.1
        for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788116044; x=1788720844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7cyfTkCtPn7AmqDEgml00QrDyZ+ySqvSEbLoL9i0Ys0=;
        b=Yjnd7Q+alUPmzEQ/ckHpHxn8p2icg/iH+V3YXgJlXv7K3CF8DCY7Z5xxZ9sHBpsC8s
         h0y4ZgLcwZUHX2F1EmREFpmJgo5vDyfaCwOc+jCBAroZo6ea4GGEj+HH4BZMhElTJcGC
         QK2UR2KtVa2v2ANmD65z0ZafA3Vla7hcJghZqQqGB61EQpmHZeR6OR71VJzw9GF3chkE
         Yn+Sw2egbkIhZo8vlJuJiDYrEnKpm8CjwVmugWKGfBpJnFhqYrvYhYXYFETtQZasWjho
         nQfGRN5k4Hc3XQIwV9AdMOY+ja8w7O4FVjm6Iy4eHqXahuxEoPU2hNxffvMSOXdxIlcH
         Myvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788116044; x=1788720844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7cyfTkCtPn7AmqDEgml00QrDyZ+ySqvSEbLoL9i0Ys0=;
        b=fAKQ9lOp8WtWa9QKiBtFuZFEV+zHZZFxenpCJZ01sv5TpTJtz6HnvQz22ULHYXFnB2
         5QBKfJpmbqpukd7HYtnsySTr79VTR6zI/9CCn6kCKwsb46uJ9WzVzdANo4IL2qfS1ZCf
         65lIOLMQih7/Oevsr3z3MDmC7L+ZwvZ8OSB+Xf5Lh0uhCAk1h6VZY6ue0UKsWCk2jOmP
         XPRt0bN4ZRCA3APHu/DraAMmft4tNq4qZeso+wcXKBW9wk+ZjPoOnYyzXnfuRyZSKGWD
         kQpUOMeQWvkebWnlpqOnaBmmyRPI8+YJ2zi9hi4x+6fM+3prsg/Z13/k1xS90jB/+TBN
         MpzA==
X-Forwarded-Encrypted: i=1; AHgh+RpgNV7vzxb71wpwZCJsYsWhUd+tUVAO4nEtDfAZsqnqK4SdV4PLefnhImBTRfw8jxu4Acz/nPO4jOE=@vger.kernel.org
X-Gm-Message-State: AFuF++lgPNgliz7RGCrooUSyBlc/Yl4YXCafiTjGfMhiVvewkTV6p4gq
	iZmmvrERz/Dfm1QeJj/tMF91/6NbiZaieb22PZk1azZvVbSsN+tY4Kk=
X-Gm-Gg: AR+sD10u9VluCD0QX+CRPhIGMLOFjWdXXuGwO9+kcka6dHbqxuYiUZlw2Y1sEMQYymd
	tYN1ZYCQXCFfkSbOZw8Y4I1tHe884hHoQgztuuflpnp6nRp+6Lp/HaRpurQm1uYObRok03/p0SY
	Lbi2dYXEq1yWjOvcZbvim+X+bVjayzzSQXNZbpKp2jMMFNj4zYZ5yFGi+J9TmV6PVLbq2+FdM1U
	EwKj6J/hs+ogMKmkDyBKb7uA2KN2PxkzEX6yRIah1ybGBdOLoI6TYO9aAsexflU+cFW4oTTSok7
	J8r7S5ULmsB1jc6l4vqgxwrvG3EMJ+gyjHvJjbP3tK++xnV+iraU42MRfBSWlTWK+VOmaAYxryz
	1N5NHLOnM8D1+krZm0k6BaYO5cx/H7AUTkl6qJPeD1HSz+VI/puKV7I4lw79Oenv2t+mkKyTaZB
	F5Gr4Id0Y5DFDuF9pYJr8cp3ga5duFydjbIIFupYkpenk47ZSTOEthAkqKneZX4DKgaaJeELe0F
	g==
X-Received: by 2002:a05:6a21:7a9c:b0:3d3:ae0f:5269 with SMTP id adf61e73a8af0-3d3ae0f5ee0mr20393866637.21.1788116044242;
        Sun, 30 Aug 2026 11:54:04 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6496:3266:4625:ebf0:e422:3504])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36e8ee6sm3030170a12.26.2026.08.30.11.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 11:54:03 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH v2] iio: light: vcnl4000: use sysfs_emit() for near_level
Date: Mon, 31 Aug 2026 03:53:45 +0900
Message-ID: <20260830185345.2209268-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use sysfs_emit() instead of sprintf() for writing to the sysfs
output buffer. sysfs_emit() is aware of the buffer's PAGE_SIZE
limit and is the preferred helper for sysfs callbacks.

Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
v1 -> v2: Add #include <linux/sysfs.h> for sysfs_emit() instead of
relying on transitive includes. (Suggested by Joshua Crofts)

v1: https://lore.kernel.org/linux-iio/20260830054237.2147950-1-donggeunyoo.kernel@gmail.com/

 drivers/iio/light/vcnl4000.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 336468d59ea7..911f8d1c74d4 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
@@ -1504,7 +1505,7 @@ static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
 {
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%u\n", data->near_level);
+	return sysfs_emit(buf, "%u\n", data->near_level);
 }
 
 static irqreturn_t vcnl4010_irq_thread(int irq, void *p)

base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
-- 
2.53.0

