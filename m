Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826C6FC5
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178159; cv=none; b=h7qsLeOgmqo+69v9i6DQEaQsTXmp6w4NxG3xc5Ughvv/udYbMr2pJPDBZ+qK+c2Eitq+Y8oqKkeDGJEGf2v+NJu9Gii9IHF6OD7fzPsmLIn7bR/RKk5sWqQo6e1InVLt7RvQxNCpwuEXRlQZKq/FIexO40ITohzskWvIBRjcVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178159; c=relaxed/simple;
	bh=7RWIoSclFP1i3qWRPE54q4B38ZhRaoSug7X3jmx7E1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2sa7230JkBBOfwdSOFWUVf4YlGeu6uKJtk9cvb8UIPZzRAEIz/EmdrfLvY6I5FrPBfPCffSfqGGP8azaoPspwvAKOopxEeaRB318tYNWClu0dAUMlJSlVEov4UEpQbokWxC76f6hoCCyzx2VfCNBPoZC3FnKxgjghap9ThL2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNJKQdA3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNJKQdA3"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cab973140bso41095725ad.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785178158; x=1785782958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6U94ZLfUTkdFVTd30M9C67yCfXIWRpfQ6ZBe9ZOpY14=;
        b=XNJKQdA353t7zaK0AeAeIOhPsWj/ZG9aK3LrP2Q8lCRICMsrZ+S8VtS32bdYILJE7T
         +Itt4UiN1+B/X62/CSOElAhqH5pZPITKVH0uIj+TwsqoHnbA20MufjturQK3z3fvSo+d
         A6Xz4fpS0dco3dHlYUPkfI5zbducigB3tMN7GA82/mZFywrDczSXfJqmg9dosKLw34nY
         Jxe4cQXkwNHXkZqKzwVBml9s/mEx4utFPeBpibg1drniQOYTL18LSJW9l8ZeuxLtgha8
         bxPDmgLr/EiMa8vNrz5Pn1B8GIp2OEfPh6hAeznH0NLR/bQiHZgLOKHpteeM6AlSQUQ2
         fuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178158; x=1785782958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6U94ZLfUTkdFVTd30M9C67yCfXIWRpfQ6ZBe9ZOpY14=;
        b=As5NPV+mAehl8D7R3P+IMCJdQu75jOl9oi0Xji+H44DAPiK8yQvCbE6Xsz8KdzoV4h
         tmLLEiJSDaeIY2Tgvbk9cAdpmZfF7X16oKpjifxEPPaaDWhDf2Jhki85jdrQfbbZQiQ4
         PqleFIUWivSOCLjIlbpfpOJHU176+UpCOs8ozFkDy1r9aVdwMr9z5djjs1W/qNtw2yMv
         Sdpospcw0Dq/NTvyk7hmsb50BjSsuC+sDuGtmKrJ8XhTzRHYcNHe+gKIBr8LoZdd972s
         V+1vkk+6ae6jz+7Z8ACue3040gqNQqaFUM6BWOWdRRQZu7/qmsAKg1tTU1UuFpZKN6Ac
         ld6w==
X-Forwarded-Encrypted: i=1; AHgh+RpBT0l6HMOnCh/yLosLF7htd73FivsMzXZZ3tol3rsnp4iIanyXYt9Z2JCF0BywOtkficMu5Wc3fLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKMq4cTcHRMBA0jZUk/S6kNB6D/QXb7zEYUqA6Mecnw7N+dza
	Fx0YkD262IWmDWQB3MpBD9llVmcpYxvT/HJgEK6Rs/6fjJJayoV0y1p8
X-Gm-Gg: AR+sD12pFX/O7uDmYe+fQS0vKx18hvujoppQti+1cnr/YQ1wwPY/WbXQVYubgj+7Mcm
	6tagY2kOmxaRdrz5T6xl+PgroXj4/p/6dktMqDjUH9NohacSIyhw4JFdLfk8XNWhwi0LPD9mUGh
	l4t/pem10vTlWakecRPSkShyeltwtXikhSi3Yun2bGTyny8DizTWq8dY29/TggtkIfb3XWX9kdQ
	uxxWk79gdgkhl7XVJJPxpZpeAs+IrNJnqGRZQz2XYM+07bULgGrGceYUzmeRDGVKWn4eeoXR4jc
	Va+65M7L4qnAHFuJ8thrOBdNrbd+G1TAzaIun3JWI28cdI6nlxk8mr/M/9VzlKUF3colvC5bFRD
	2rKrtGE7p+/W+z1k1qit7DqA6KihmuyfxO9RDbMoGMaIsx3G1Ma2wzrr/L8LSEvGNzjCBlp6V
X-Received: by 2002:a17:902:c402:b0:2cf:a2d2:84c0 with SMTP id d9443c01a7336-2cfde55bb4amr93146695ad.0.1785178157618;
        Mon, 27 Jul 2026 11:49:17 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d7b87sm40186245ad.57.2026.07.27.11.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:49:17 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 6/9] iio: light: vcnl4000: remove vcnl4000_set_pm_runtime_state() helper
Date: Tue, 28 Jul 2026 03:47:43 +0900
Message-ID: <20260727184755.2055414-7-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727184755.2055414-1-ekffu200098@gmail.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vcnl4000_set_pm_runtime_state() just calls pm_runtime_resume_and_get()
or pm_runtime_put_autosuspend() depending on its bool argument. Call
them directly and remove the helper.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index b8ac156ad5c9..336468d59ea7 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -537,16 +537,6 @@ static bool vcnl4010_is_in_periodic_mode(struct vcnl4000_data *data)
 	return !!(ret & VCNL4000_SELF_TIMED_EN);
 }
 
-static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
-{
-	struct device *dev = &data->client->dev;
-
-	if (on)
-		return pm_runtime_resume_and_get(dev);
-
-	return pm_runtime_put_autosuspend(dev);
-}
-
 static int vcnl4040_read_als_it(struct vcnl4000_data *data, int *val, int *val2)
 {
 	int ret;
@@ -850,7 +840,7 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = vcnl4000_set_pm_runtime_state(data, true);
+		ret = pm_runtime_resume_and_get(&data->client->dev);
 		if  (ret < 0)
 			return ret;
 
@@ -869,7 +859,7 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		default:
 			ret = -EINVAL;
 		}
-		vcnl4000_set_pm_runtime_state(data, false);
+		pm_runtime_put_autosuspend(&data->client->dev);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type != IIO_LIGHT)
-- 
2.43.0

