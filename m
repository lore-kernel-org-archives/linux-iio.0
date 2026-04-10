Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997823DA5B1
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837962; cv=none; b=XQ/VS3NCAZ4OAdEyLJT/uj0OUElDhzSgYD4rFW+F5BQdfwxE6R3Gnw7koVB4rdYeXp1Olq9VINy1ULtSHZu2xGlqeaOng04pfxo7e3Sv99StZP3vF0al7oJIz7LNDnKdenv4lNOICbqqg4M3UN9gknUE5rWLxuZUxDujkVVdnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837962; c=relaxed/simple;
	bh=jF7QrJPWozjagYtKlcGbAqUjNIO6FBn/dqF4amW6Mmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3jgNjhyQjX5Xj/5xcModir8TFI16kCGGk+Di2ybTUuHdXadyGaJvXh6xcaEHlBZ7EPlP06iLRx6A42jmemc1jVPVf3zmpqex1d7jgMJCThJjawooxH5s2RlHYqe0cLWL4B9NSJ1kKO4O5sz0WVLHptd8DMJBzSXIl8wHKak1VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc12SOZf; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc12SOZf"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7982c3b7dfcso22952727b3.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775837960; x=1776442760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00/sSIScn/UuAAJmy+1XJn6CWmZCg/mywV0xNQGgwVU=;
        b=jc12SOZfK+eA2erg5nVouYDIHB3sIKA0LsTr7/f6indrOXNGpbnHrOf9v7gC6Q7laH
         3n5vHOUTqPZqIi07kzveLYJprHohucCWgKgcFGB/n1HeZB4OBLP5voc7ao58apbq/bx9
         xbxzBoVytQYu6zHtC8NP5DV6/mPp13RNvcO62C6iP0JSIFVumaiglActA6UlJgOrsroz
         V8eG2tdz+V65G1Q8z78amA0TBNTC7nPsrCHDSUCwXypBKqw7NTNteDfQq+/nPA2IHhak
         EoSOllkN67oUVpm0Pn3UxBhcJAK1EUN3h5PxJKwC926oqfqGL1CV0F6oGzYB6KwWU67l
         36LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775837960; x=1776442760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00/sSIScn/UuAAJmy+1XJn6CWmZCg/mywV0xNQGgwVU=;
        b=jUhnDaiBpxCGPiJREpFhFU6pjzWIoPLmH4cm98D3ixL+m+ot9h6Wz5iKdhIXlkFW2/
         L9E4L1ZwE4/PyDP/P1t9FZIYlAcg8ZVun1DgUKZnLd1RnFPcRUZXmjMGMSiAQXneMYzW
         DF/tOtxFaueD0MwocmpA4iZKJq3sKnuFzE2rjJSbzKCldhi9ZUbITzg7FsV81XjJxxMS
         fQoJ2pKgHv+xtOr6uRuqdHcrwYvwYs60eI9jMVuGmj3KAT9mMlaBqx7To8c6lSpfswVh
         Vedtj2DLdBJahMg/O1Rl7OvBw5Ba0nLOuDYPBvFD2K7wMhVXjvmAaJ6GX5zghKGl44xU
         AkgQ==
X-Gm-Message-State: AOJu0Yz5lkDziPs0IHxq/STg8dP9hVdDFgrVo5izHF6rz8G5+NQnZlJy
	/LX7R/0kmrfjMBTkB9AocdQvhjl9uPp5kUhyNFpwtj/P7MTuUUiI96pC
X-Gm-Gg: AeBDiesq/hUYNxpUkbqVidi19GXqRXEiQ8ffkVfsHOGpwYa93oXuUQhHKj5N6lx+KFE
	FJN/wP5rKPOMTMlHiZ5WtDswOTATJCQrLPJZSBJRcMAeF4XxLnhB9+gD6svPdfdYg2CsgxpCJ3M
	98ACgTnrbpcQr+5vRqjYVtjiqnr7NYweBhXlmUMC81BeMPAeVylK2RQyWA0/pA20FZf/oQiaLXY
	NJRJ0/3n999In8hKxuhNDC7dIU7GxDbMaMpwrj3nGMpJbT92qXTKlXaY8ll61WWb59jMC2L4QiT
	9fR6hwQ3wY3+IgBlG5IM/74qHHF/899MeMEzCiploFwiVMEnF6vRT4f1kCzCWxUHK/r0OZ55R/X
	46vAsOMsWjwRj/0Bh37ayMtwaNPrN31nLWy6tk3xEepWEZIYNUQUKGj0Uv0Sf2idOz/QSLjC2Er
	/xO55cJsiIdxcnagSNe3ZF0ZE95w==
X-Received: by 2002:a05:690c:e04e:b0:799:1d0a:aca8 with SMTP id 00721157ae682-7af6f80be65mr32206387b3.19.1775837960646;
        Fri, 10 Apr 2026 09:19:20 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa05b48sm15408337b3.33.2026.04.10.09.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:19:20 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Fri, 10 Apr 2026 19:11:21 +0300
Subject: [PATCH v3 5/6] iio: light: vcnl4000: make pm_runtime_enable()
 device-managed
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-vcnl4000-drop-enum-v3-5-2ea2bc6f5dfb@gmail.com>
References: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
In-Reply-To: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.1

Replace pm_runtime_set_active() and pm_runtime_enable() with their
device-managed counterpart to remove them from vcnl4000_remove().

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 1a8672564cc4..b08cb6b33d33 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2055,23 +2055,18 @@ static int vcnl4000_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = pm_runtime_set_active(dev);
-	if (ret < 0)
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
 		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto fail_register;
+		return ret;
 
-	pm_runtime_enable(dev);
 	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
 	return 0;
-
-fail_register:
-	pm_runtime_set_suspended(dev);
-	return ret;
 }
 
 static const struct of_device_id vcnl_4000_of_match[] = {
@@ -2091,10 +2086,7 @@ static void vcnl4000_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	pm_runtime_dont_use_autosuspend(&client->dev);
-	pm_runtime_disable(&client->dev);
 	iio_device_unregister(indio_dev);
-	pm_runtime_set_suspended(&client->dev);
 }
 
 static int vcnl4000_runtime_suspend(struct device *dev)

-- 
2.53.0

