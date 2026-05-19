Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD403DEADC
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178422; cv=none; b=e75PXL0vUxJ/TBtAq1KfSmITX5/1bJdKj2xNah+NexDRCeumYaybJ9P1zlNdDxv7aXnTc8cXuakRC//AYz7P80LOWYEemzzl53D+uE0RR9xShPJLMRMFTEj5iTMpId2MLA9q7UgUOOVvkUcInceX/W0KEIFYcJQbDot1eq+RxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178422; c=relaxed/simple;
	bh=P6WJBWVk/AYGVD2iDvgFs9VxHbByPo/vw8XkLrthBzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CByjfo6nU/IgQq81tIRwb9hwbUJyYbzfI2EvAr2SZYTfjZUKAQ8UC7YDBlzxKH9wMyMZJWCg5/QWipLRSjp71oOAxFvGoJkm7Vp874BJg7Fqp3gyxGQeUtF87p49t/qwakjwOZcBg8CCtYq3xvuGxLzbnMtb8TdNgIzNj4zvJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=eMv3Jyae; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="eMv3Jyae"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so35519005e9.0
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 01:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779178418; x=1779783218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6u6ckoYuRTe6EuUn2jyVBOE8hQkJls/nvi7cB3Wx+c=;
        b=eMv3JyaeTw+EIxl7g5sw0Y1dVOh9lgyhb1KsVV/feFo04GrmJmk2CSEzqd+jWojsaN
         xKsTqtqEHum5tpTUGPEagMV2SUm942vEL9TrcyVs+yhbSPFVeYM96NMNFmT7upmHabIx
         Fq7BXJBUMFKeORxpr0syQx2XByEpUZjK+efBAOqLBtokHh6EB/Zu4e6yeeSj0hqYeYCq
         em+HdQcHXf/1Sr1GErN20N8IBVE3Pll90iLUkhZfrYMxL6VWiEZrS4H18nK8RBDZAJ+N
         JwXE51gE8EskS69Dx4iPCY0TLLbvV+NbEA2k/hKOyJwZFrbr+2qyKrvyJL9e0tkQLFFi
         Zd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178418; x=1779783218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6u6ckoYuRTe6EuUn2jyVBOE8hQkJls/nvi7cB3Wx+c=;
        b=TkUAfT8P1I5mPZCIjVTTT4Eno4t6ztA+/oDqjgDSe2iGqGu/3Fc84FvYz/Clcwfa38
         HK54HUz5DxlIg83HLLfKiuH1iGwBsv8n0nj7D34bqzRm82aiBCHMqM4Gly9USMz+vA8y
         lvIks8+1cIjKrgQxUQxYV9DThdAwcyLhFu+Spbh7au1sR8cnBXfBJHLcTAuM8bfTCWC5
         FMQ5B5xqKupy71mHpezGmiynsoqheYuXwe1kKBoxUWRQQ6eNr3Vn4KphzLvVbuon9T6f
         2LBOPu5NXY4z5f1KO10bZ2QfR64rVd6yW25sRvvcLmwxPiMNMugMEOpGdDyAJK99BRYu
         g34A==
X-Forwarded-Encrypted: i=1; AFNElJ+2fMYmATtoGdEdR2oUx4XDThwTWNMZUw09sxqsi9Fn/9pPI4uTt3y4mv4+SLSoGZWQQZ/Lv5pd1SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrsF7ROd7qHm8fZFPcHEf40PsSt6pc4ujHzkRSQZDkWtTtKL06
	c6DlwL/bJAuQciB03skYDdlDOoaHkghWUQ7SKOAduOaX+oI1kqEaRRtG0XvPYpPGkGQ=
X-Gm-Gg: Acq92OF4duEBpZV4qo8jf5dhicpKnCNu8QPbslpe6gIfdR5sheb2qMPZ+SdKKG4yEoz
	+WAyfJCB8flmypqkNjteBag/U+n9uETKIXNWyesrn9BQSmtbmzW8v9mk6ddQTkhATDOtNpaepBL
	XrSyVZ9gaRubnsO5/xEJe9q7+uEUKjA6y9Rqr15GB/1x5WpRkS0MIPZRh1uUHF4LDTs8E55KCF5
	bIbSOMc363D/jQ5jxmK7g/w74qwmfsokDfCyBWtCkT6FQPES1Oz0vDt7BQRv2kk68IQD/+bQIh3
	TjR4rXUkulbJm57ucOVwn/4zHooSTKLfkLb9DRTtyUhGvgejuOAacuJuIlKqcCKvxnOwearLcyb
	/R0Jc0G2YQmmjknW0q/R26PU9e+A9vDPNjRuGsUPS9AJt8NDSA47Nk3MJQpseNDk+cE1IPdzp5v
	wKts5cEhtU3zNs7JHwjmVT1VUqq0tdmc/AczdhttBWdx2FGuAihYWhAQXB2WAFGxirQeXcveGox
	i7WH80fqUXshb8=
X-Received: by 2002:a05:600c:c087:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-48fe61f2768mr209830205e9.15.1779178418608;
        Tue, 19 May 2026 01:13:38 -0700 (PDT)
Received: from localhost (p200300f65f47db0428dec7b135f55767.dip0.t-ipconnect.de. [2003:f6:5f47:db04:28de:c7b1:35f5:5767])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe4c88e5asm330216655e9.6.2026.05.19.01.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:13:38 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matteo Martelli <matteomartelli3@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] iio: Drop unused driver_data in four i2c drivers
Date: Tue, 19 May 2026 10:13:03 +0200
Message-ID:  <32001830b38e14cd8717247388f8d1a976770f97.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=P6WJBWVk/AYGVD2iDvgFs9VxHbByPo/vw8XkLrthBzI=; b=owGbwMvMwMXY3/A7olbonx/jabUkhiwe6dkhRfPPd/9szcnvrv1Zl9QuUPyVtbJU8puQhQJfT U2f0MJORmMWBkYuBlkxRRb7xjWZVlVykZ1r/12GGcTKBDKFgYtTACYic4z9n03/0wChtjeeomUS cZE9SWpMdW1LXu55XVvR5sxi2urYcXrFjGWZf7taHAQu/0hNU3oX8Me71uCfndXlRX1tZ+9/n/Z nmrqI8bGI5l1PTCe59J5L+/HXNeeqm0XkM7l9+euTt54zdQ6fESznzxglFMfhqH2uVOu24cUfOs nyna9UHrUJXFS69eaO26JJ5RZLm/o2vHQP1y5hOnjdOKwgaaH1rtJ1ygfa+7ZMWhgbnh+4iq30w o11TC/kD+b8bMyZstzU2/iBrqHA+1LOc8FXC3dpefy+63NV4vPx6LmsH10Wasn6L1nlYfjm8SKP EJEpGaxbyv5t6jAUFljX+nSh/7pa7wuGbi18VnKTaqwA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

For the four drivers the .driver_data member of i2c_device_id is
write-only. Drop the explicit assignment.

While touching these arrays use a named initializer to assign the .name
member, which is easier to parse for a human.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/pac1921.c    | 2 +-
 drivers/iio/light/apds9160.c | 2 +-
 drivers/iio/light/tsl2563.c  | 8 ++++----
 drivers/iio/light/tsl2583.c  | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index bce7185953ec..68bdd2f30bad 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1310,7 +1310,7 @@ static int pac1921_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id pac1921_id[] = {
-	{ .name = "pac1921", 0 },
+	{ .name = "pac1921" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pac1921_id);
diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
index 3da0bdac04cf..8dacb1730429 100644
--- a/drivers/iio/light/apds9160.c
+++ b/drivers/iio/light/apds9160.c
@@ -1572,7 +1572,7 @@ static const struct of_device_id apds9160_of_match[] = {
 MODULE_DEVICE_TABLE(of, apds9160_of_match);
 
 static const struct i2c_device_id apds9160_id[] = {
-	{ "apds9160", 0 },
+	{ .name = "apds9160" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, apds9160_id);
diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index f2af1cd7c2d1..7e277bc6a8b1 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -839,10 +839,10 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tsl2563_pm_ops, tsl2563_suspend,
 				tsl2563_resume);
 
 static const struct i2c_device_id tsl2563_id[] = {
-	{ "tsl2560", 0 },
-	{ "tsl2561", 1 },
-	{ "tsl2562", 2 },
-	{ "tsl2563", 3 },
+	{ .name = "tsl2560" },
+	{ .name = "tsl2561" },
+	{ .name = "tsl2562" },
+	{ .name = "tsl2563" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tsl2563_id);
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 8801a491de77..a0dd122af2cf 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -913,9 +913,9 @@ static DEFINE_RUNTIME_DEV_PM_OPS(tsl2583_pm_ops, tsl2583_suspend,
 				 tsl2583_resume, NULL);
 
 static const struct i2c_device_id tsl2583_idtable[] = {
-	{ "tsl2580", 0 },
-	{ "tsl2581", 1 },
-	{ "tsl2583", 2 },
+	{ .name = "tsl2580" },
+	{ .name = "tsl2581" },
+	{ .name = "tsl2583" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tsl2583_idtable);
-- 
2.47.3

