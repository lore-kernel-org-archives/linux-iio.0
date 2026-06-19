Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063B3BBFBF
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884521; cv=none; b=Uyl1WUhSkygjgGVxBpThTropQmg2XT8u2L2MjFdvG6rAlC/xXOEAjWpKPs5rX62kY3M/7G8ZRZse5IEXcqTsTJFN5RE3ifgJEe3rVrepBhl3NUwqmbXDW2p/Q/SXH/TC3+RlldPqwZoc7sVS23kkrjZi03iakWjqxz+I3taoeJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884521; c=relaxed/simple;
	bh=d/BqkOd8UnlZcyZwheVg3ZHL4Z6gcR9SZRo4lXJJJFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yo8vOhpz2T8M2ZAcB6LWJBdis+gPuPUMzqqKTgmjHegrP84Ta36nzn5VCAojakHWcGXdyugqPGJWeRKmrQGj1CXt8qps0277JaAdWBypd1eAUy69dlc4HbwzrqRF1E/Ev2TuMjHqwSpynekIrWHq1P23gsWQy4TcAIx2G7mh+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=NcQfI9Wn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="NcQfI9Wn"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-460166910e6so1421541f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884514; x=1782489314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQtX4QqojvY/F1hB0BH2NWjP2ov2hjCjGN3l6t9rW2g=;
        b=NcQfI9WneUj7zBLhA3cv4mOVWpigxvd4NmGwsG482JqXPmPZcPhLQqkalTMXlanhEP
         j1p7faSyeR30TBvcco2oc7OekOMY5XXGFXz6DOlv0rTT29vI5rZ+zGX+2kRb2G5cpP9h
         Ga8FcxlTMQWsXsi/FnJzrFjlJsA7LlbdhOVQgCjfqGXIlCFvuMNfcLSNUWm5WI+6zdfA
         ZboX0sSkUsmS4jhvbF6isI653L6Gy7SXALw1eqoTSaF4MmVOuJYTI7mf5/RHcl7olhsq
         22TvzQG13oIoj+LiQdBtXVuLl5ZdXZ9GNRsCI5c9Wbrx36lnx3wdp/TryrE7wzpYLLJL
         j+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884514; x=1782489314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KQtX4QqojvY/F1hB0BH2NWjP2ov2hjCjGN3l6t9rW2g=;
        b=I9ktZ9VHk2gP8hWwZZgxiDAkxTo3aaVMo7tsfCcT1AjB2t/TnSIgktB5mYlXKGhN6p
         aArmHqIVKE/nQwG+15jruxNOJ/pze+TFk/Q+KrZe5hQEnQZOX9smlQKNt3ElzTsilTz9
         pMAIFpeJCk1aifk09V/GxNdXiXRBhsXnyY1baCzBDdIfK63ag6KEGeAqsOjWkH6XSEFP
         6E3m+ANAlDx/zZfyG+i7bWOx9rf6PZVXu3D1WxoaQQRrvggO2mXvD/BsF0fACKaGIdkV
         c2F+DzrMWDgF5jbAMbkgRPM7/F4fAt3WkZXjJWfmOfkCHBUUiKHQGPg39t0qmoQrmKnE
         OdKw==
X-Forwarded-Encrypted: i=1; AFNElJ8Bosb37cXB5a+pFpf3Be9kc4BAFueA6u2mLmZu8X8Y4RCmEj/nX/7/DrnYIr1BhtbkiFvyek00ja0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9REqqyrgd452UBOX3N1HMFqBy8cXFhgwRBsF2+9+l0NqJhc2
	fK4MYv4bKMlyIMhLa80fjEJFVI8z4duTJwsXUy38i174iNmbVGTP3DaD9RYesF7ktSw=
X-Gm-Gg: AfdE7cmZzJNQbWyLawfF+PJ957pokMxTwZrZpOcbjz7+7U9QAjZQyS28aPQ+4G+fv76
	RHRGnypK9JMVc4JMqY9L0+XqR13PuILIZvHmVPLZkvUAThpQte6qN8UrdEqIoQRo6LJrpvpv4E+
	k/qVdM4ff8StD+MOk2QuUoa8Tb2nH9kbMpVNer8NAJSzYXdPmuIBcO202z2IK5xoxqqN3MbFXIy
	cPcGWFl0pDnYcYwa2r4OdbkSZmkOKUEXiLqd7yGlW4QZpqfQEB28q1kKP67VAijMLktDhwX0THr
	zfCslDEAY7QAlR5js4yCY2rksfw+TwOs2uHk9YLQ3jcx33KRAkRI+pI1T6p7sTd4IxNj/OEFBzC
	jp7dqE4yZiakdYXi5LapA7EoMWN1qDjf4aXcuPhFUpMmEoC+Yo4jjgBmG4+/kpUU0TcFj/2y06H
	XROBZfktxUlc83zI/pWzAdREGWKRWK8fWRiDCyzhj3lqTzO0uJrtVmpwsNVrUAG1sz0d61g2i+2
	VjHSl/HNKN6pw==
X-Received: by 2002:a05:600c:6383:b0:490:5cb3:e94a with SMTP id 5b1f17b1804b1-4923ef4c440mr78279435e9.2.1781884513746;
        Fri, 19 Jun 2026 08:55:13 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4923fd1ac18sm115542925e9.12.2026.06.19.08.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:12 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vladislav Kulikov <vlad.kulikov.c@gmail.com>,
	Kevin Tung <kevin.tung.openbmc@gmail.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/13] iio: Initialize i2c_device_id arrays using member names (part 2)
Date: Fri, 19 Jun 2026 17:54:29 +0200
Message-ID:  <db01a5dd94c1086bf39c99f798901d33c8cabaa1.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1598; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=d/BqkOd8UnlZcyZwheVg3ZHL4Z6gcR9SZRo4lXJJJFw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWY3fnKp6jPT7cLw1JnhgD6IY8jRuZ/RQl7VW mO0Apd8RbWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVmNwAKCRCPgPtYfRL+ TiFqB/41mRow/UtlZ2+jylWHKUsm8tj1ZCKroH50/B2Z3SSwuxv7ulGXeQ8Qhs435xip8TXyCx4 KTQJj0eemvuz0TvsA0nIUwV9QtvWyK9dXoYGD+v6BmkjEbvw0d/nhW2MR7eHVzJJYm8OGM1eOdR oQcMpPQaoOZnWvkSWHAaJbXeNdP3hDMa44EIY5DaE3UnKbp3CetboezFhndPT+cJrUYpCWU0219 cYRk4gooJdm3CFB/F/CsBsQ1r+gTWKy0bqOi7Z7VF7CA0YCJgINm9e760oBrHTAwFAnb3IZG5TY rcLvOp0OxkHuJBfplSYmi5p6lXHFaJIUdLYsKnzoFi3yCIP0
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This is a follow-up for commit f68afce8e8a7 ("iio: Initialize
i2c_device_id arrays using member names"). This previous commit missed
these two instances because these drivers didn't exist yet in the tree
where I prepared the respective patch.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/rtq6056.c          | 4 ++--
 drivers/iio/magnetometer/mmc5983.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index e2b1da13c0d3..ae50fb27bac9 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -872,8 +872,8 @@ static const struct richtek_dev_data rtq6059_devdata = {
 };
 
 static const struct i2c_device_id rtq6056_id[] = {
-	{ "rtq6056", (kernel_ulong_t)&rtq6056_devdata },
-	{ "rtq6059", (kernel_ulong_t)&rtq6059_devdata },
+	{ .name = "rtq6056", .driver_data = (kernel_ulong_t)&rtq6056_devdata },
+	{ .name = "rtq6059", .driver_data = (kernel_ulong_t)&rtq6059_devdata },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rtq6056_id);
diff --git a/drivers/iio/magnetometer/mmc5983.c b/drivers/iio/magnetometer/mmc5983.c
index a67b13393b6b..18f3f3d25c4e 100644
--- a/drivers/iio/magnetometer/mmc5983.c
+++ b/drivers/iio/magnetometer/mmc5983.c
@@ -328,7 +328,7 @@ static const struct of_device_id mmc5983_of_match[] = {
 MODULE_DEVICE_TABLE(of, mmc5983_of_match);
 
 static const struct i2c_device_id mmc5983_id[] = {
-	{ "mmc5983" },
+	{ .name = "mmc5983" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mmc5983_id);
-- 
2.47.3

