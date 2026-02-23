Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6822BA21
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 03:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818047; cv=none; b=I7v/nZyzKnhyp219ugUlS7tldXPTm1FshvEMrYvcAqPA7myPp8KfyXbBKOqkIwE1/lUlhjfh2LxdGan9oRetHazkvu2xlWslieib7UeA9CqqW+7LQ0BXfmmkmybtF6WtQzNtUBJRyFIUcI01eyu05X+s6Bv29Dj5qKm8Bo72aaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818047; c=relaxed/simple;
	bh=y8vKPCubDswMfiV1BDFc/WRWFhnkHJE3yofbqLmhM6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d06QZ2cgByasVciltDmo9D7TUDgs+KGYneFsynJr4GL8HV+glnW6eJwZ7psTNQvN8Cx4IEOc5dZfJll1nYVv9SxjKzr3uWd2lHX6a3Hk6Dm8WMRUz8OpOt7gF+ZM+jQMISwIy9WR5Vv7tK2NqUHTzbQPiNt6ol3QJcvQS19RKGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8mX5vII; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8mX5vII"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-797ab169454so35354557b3.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 19:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818045; x=1772422845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IRh4rvJW/Bj1AuQS9zzQJnQDdzxOYm3yTJBXXZTfSk=;
        b=b8mX5vIIP7wKcZw256qO7AvO7PSjDBcxrlh0KGv+DMHChh4rUDLFhNgYXNEGwLHbhr
         DfI2REHoOAZvvBrIjN+X7cI3L4840+ieYMyhGbjQgUhib48WYgvN6F2Gbw1eKYH3Y4T3
         vXpcsvohHIqu+TwByTsTHgNXzKC4LyM8J1p8n+CUCBX2pGHEWFb7uW0dSLKKKZNr70M8
         lK5QKmgG7KWgLWpOu93GBlmhg87Mj4oEny13YNsIT2OfCsRiVblKch3Bu81CzD0j3i1t
         BS0Wtx/wPH0IjyAX+gefY5yutOSTF03kv2D3a0fmWcs1LCTVOFjnGh96cmry27c4wF1E
         s/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818045; x=1772422845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8IRh4rvJW/Bj1AuQS9zzQJnQDdzxOYm3yTJBXXZTfSk=;
        b=tv0ZGhiXnBbMZSgMudeTulH9Q3IYyBQOxotfMBV+8sIQzAHxvujWAjW+qOEiZLa/B1
         owFTUk3FR+Avf1qDltIjAAqEMwKeFFr7DoEiMUFt+DZohf4FVrGkyaTaBnG0CYNWnvxq
         cK/FDX7zqb5MQHPjLdbDtzLms2gouHLTeJs8x5x9wnSSVGXBUbqCOaPo7MEOpGSFDizz
         uNJtqSRSDTVJd5q+6N8b+y7hkqJUFpNHMABe47GXSe9XEicqbU6rPwcMWGKTRGZuNP5z
         8bNZhRJyJJVxEEmNn4bF4bLhegloo+gR8GTta+z2x6uuNQLRAXdoqvmlIuEKVDcRdArz
         PGoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7W10SjlLCykZXbAQBS2YcIwqeaFQ/j2HdWUGyGxBwhuiv8ksEaJkT6LoRUN9WQSQm4IYhCzFsnbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7nXl8bOZUr/6slKGvoyQ/LYwvF5tNS47ERjwF+AeSYSnV9C1
	sNq+OSPQfofsmyPjf/X5WAzYZJnERQ4dBPo7I7TfUhwPhvks7aPR4OY6
X-Gm-Gg: ATEYQzwWqRBXkgeFERg/cBCmG+1A+2zgYIcBe7RwN3iKYKedEoKjOkfJ15CTY4eIh1o
	DJSH2pE9a5tdhIk4+oFI6lsuF726dpbECSAJZHQNBemaxMboVTVg0wSYoaZakVJRrEM/y91T8hc
	UiAYIZj/S+o1XXbvYo6phEqScY2KSJ2f3ABAOm3ua2B0sBuOYrw7NZlcgomaX+6DI1ils8PUyjD
	V0f0rxxDK4Nr3oDXxgzR3WcM5W/YwHMA6PbQoKNK00235JDx4XP8WG9u5KJddOUAnbnTF3LxKmm
	zRHHkCYWXt6ZjS9XnzaS/ahKxNbN64aH6u+pVG4EpKSa0hpEhWun7vB43D2JrG19tPzKFJLiXhf
	IYRA/50nkyUEl8C9OBTtX1llUg/nyt2CxvRaEYDNrx76b4RLWzI0MdtIsihvF34MhijOUf/asqQ
	iCp2lBZoOFYgfoOYcBdY4Vug0W1XEaX3Tagzb4tXC5Nnp06LdxDrRtCeGSMw9nrNa19Qgu7RPgZ
	CKjTslszMrnlPDKRhrQ8EzX
X-Received: by 2002:a05:690c:d91:b0:798:4fd:7211 with SMTP id 00721157ae682-79829028641mr65498377b3.45.1771818044901;
        Sun, 22 Feb 2026 19:40:44 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd5939sm27285237b3.15.2026.02.22.19.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:40:44 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 05/10] iio: light: gp2ap020a00f: Fix possible error swallow
Date: Sun, 22 Feb 2026 21:40:15 -0600
Message-ID: <20260223034020.27625-6-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223034020.27625-1-ethantidmore06@gmail.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move error check into for loop in gp2ap020a00f_buffer_postenable() and
gp2ap020a00f_buffer_predisable(), this fixes a possible error swallow.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v5:
- Split this patch from the patch number 4, to keep bug fix separate
  from style fix.

 drivers/iio/light/gp2ap020a00f.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 6b283b52698f..d2156e133b75 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1339,7 +1339,7 @@ static const struct iio_info gp2ap020a00f_info = {
 static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	int i, err = 0;
+	int i, err;
 
 	guard(mutex)(&data->lock);
 
@@ -1366,11 +1366,10 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 					GP2AP020A00F_CMD_TRIGGER_PROX_EN);
 			break;
 		}
+		if (err)
+			return err;
 	}
 
-	if (err < 0)
-		return err;
-
 	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (!data->buffer)
 		return -ENOMEM;
@@ -1381,7 +1380,7 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	int i, err = 0;
+	int i, err;
 
 	guard(mutex)(&data->lock);
 
@@ -1400,11 +1399,10 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 					GP2AP020A00F_CMD_TRIGGER_PROX_DIS);
 			break;
 		}
+		if (err)
+			return err;
 	}
 
-	if (err)
-		return err;
-
 	kfree(data->buffer);
 	return 0;
 }
-- 
2.53.0

