Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23DF3B47C9
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553926; cv=none; b=ajmCHeTa61Q7Xt+MXYwzli3vvGaXR0R3VmJpC1Y3+qtBa6DsDf8db8KvPjokIga5zKGPHwNx9+KhSKeSfKYwwfHS9ma48SLQhmloIjGgX4uOlxrgvccH/7jJAqV4RcZxqXMcNYsnPkhZCrAnhVYnES1QW7y5NpglM+2Ad1A4IC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553926; c=relaxed/simple;
	bh=26ys8kIw0HiJULrE9K/wY6TyoErhLepMfus0zdlimjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNMxNJpNFzcrv6i2RnASd5Zyy+F6rqHs8+Hl/NJZr8ne7UaCyRN+SDNyIGY3ztdEpKyd96Y64slbipWJBYPymBSjyt9qQyAr5ec1HvsVX62uagHsmydrHJ4aqK3rrJxrjWdCMAASwRN4WusOAo2yYztzsLnO+8n5p6gckuaUMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6X4LeHG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6X4LeHG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so37770645e9.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553923; x=1782158723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f4/U3zvUWrpnp/mAuWS1moZKTdwgAAYFZbGapcuDQw=;
        b=a6X4LeHGe6MniB19OBhT5MWVFcv6B/0SB5tBZUMnnFVRfumgXRQy9TvCQQTwqR106n
         h7x68qZMosiu0qjr68Sd63wPyx651BrHQy6UD9uHmEJCIk8DZw3MvtIUe8oKWw5s0yZY
         oWXtnVpOnr7VPoxSUQ2ZxmSNocLD3o4Encn2JzuBYAXgqAgBYtzW2UfL/B4b2DUthdYB
         veNW5ALFIV4/Z/KWGwOewR2Tfu49XOB10uQR8/glqVVt6nIWyDW6984ucFusMD7B7Bc2
         OG0aHmOmONDDBUZgocKXEoBLJrNrJRgmu5hGmjY0PdSJ0wlfvIOwp0/jicDo7yoA9Cxh
         CFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553923; x=1782158723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6f4/U3zvUWrpnp/mAuWS1moZKTdwgAAYFZbGapcuDQw=;
        b=e+Gz1HeoG/XVwLglNZnrBVuiLlW0Hwa2aRlLiDVqAkdT7JQzgPN406jOkHXHDJeUxn
         PWmSS94Cmy8f8qBpbB4D1CSwdTEA7ojCd2vX03Jau+w2MNVgS9rj+zCKMOp9j9YzeEAD
         yzjOr7iZRlnOO+ANJPZHdUp1qtGEnxN9lVO7RDxnFcj2jt4E1Qsyv09W6ewB2ahfsQF5
         ItWAIXgbX1NVasBmXYrM+vKBROqGm/GNJ6kRBeh7rmpw7iE+E8LC94BR+tmCCgwVK9Sd
         ZiRAldHXV99Jn22ErhYODDPeZ0+qiDj27ktI9k7wrbQN4FnOL2I078eofEtqbvoGNG0q
         opgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9t29eRp9Fh+oNQqLAG7uOVse3oSuB6JGzecWgvcCmd/KkQhQFXKou8wNXWOmc1SffoXc433OxX/hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YYAGvBLboYFmMdXSyALsFdIt9q22b7qg2u2PFrjZeZAIKKgW
	AsGCqDX/b114fzZacwyB8afvr83DNyHCoovA1bJGcuV3DmGRcLGG84Jv
X-Gm-Gg: Acq92OEuilvhvE6QehKkp6wkaqSuLb0A7w0XiYYPsLSS97sFbMDJ8EA0MkeFVYh37rD
	C6d4bhTO+yX0mDrqNEoLUhPPRqj1b7Yw4IPvaY8PRlAPa2i5JPLE5jSL6/EbDQIBTYKUNdzRpl0
	x9GNvZNn90BqQMIDyh5mtxn0vA0v4LbqlpRl5bzsxH+/vw4gBbFmPCPrn6X7gT+3Fr9gAsrNilL
	FyZsstUiZ4gY1PJeYLHDF19qoiGL4P/LQSJxsJWSU8nfFSyXJQax9F29AMSsh1voD1YteNh7UDu
	XojS0nJCDLlooIgiWXLNTk5dmNj1zE5Omu/bhvi4NGcqAzuw8mMXbuhgEtP0b7WeOiekLQyVg7e
	zz17I6jQqIPOMmoGtO7YbcI62A0wI1S07763upwJlj4MhJUAOrJMVOz+Io0eoUUMLQHWmQ+nPEU
	HCBTaXKR1rWmFwT/CLTN3kJNvzYxbbla9HU724YJqfWfZ964+yBwkVtfyOrQgdGuCtbO5yleIVF
	bLxBg==
X-Received: by 2002:a05:6000:4a10:b0:43b:3b80:6776 with SMTP id ffacd0b85a97d-4606dbefb1dmr21309572f8f.30.1781553923290;
        Mon, 15 Jun 2026 13:05:23 -0700 (PDT)
Received: from arch.lan ([91.230.98.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2e592csm40267547f8f.36.2026.06.15.13.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:05:22 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: m32285159@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 1/2] iio: chemical: sps30: update email
Date: Mon, 15 Jun 2026 22:04:58 +0200
Message-ID: <20260615200459.8272-2-tduszyns@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615200459.8272-1-tduszyns@gmail.com>
References: <20260615200459.8272-1-tduszyns@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old email has been inactive for a while. Replace all occurrences
with the current address.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/chemical/sps30_i2c.c    | 4 ++--
 drivers/iio/chemical/sps30_serial.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30_i2c.c
index 61781aaabd85..bd4a2e6eff5f 100644
--- a/drivers/iio/chemical/sps30_i2c.c
+++ b/drivers/iio/chemical/sps30_i2c.c
@@ -2,7 +2,7 @@
 /*
  * Sensirion SPS30 particulate matter sensor i2c driver
  *
- * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ * Copyright (c) 2020 Tomasz Duszynski <tduszyns@gmail.com>
  *
  * I2C slave address: 0x69
  */
@@ -253,7 +253,7 @@ static struct i2c_driver sps30_i2c_driver = {
 };
 module_i2c_driver(sps30_i2c_driver);
 
-MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
+MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor i2c driver");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("IIO_SPS30");
diff --git a/drivers/iio/chemical/sps30_serial.c b/drivers/iio/chemical/sps30_serial.c
index a5e6bc08d5fd..c8bad4de0c26 100644
--- a/drivers/iio/chemical/sps30_serial.c
+++ b/drivers/iio/chemical/sps30_serial.c
@@ -2,7 +2,7 @@
 /*
  * Sensirion SPS30 particulate matter sensor serial driver
  *
- * Copyright (c) 2021 Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ * Copyright (c) 2021 Tomasz Duszynski <tduszyns@gmail.com>
  */
 #include <linux/completion.h>
 #include <linux/device.h>
@@ -426,7 +426,7 @@ static struct serdev_device_driver sps30_serial_driver = {
 };
 module_serdev_device_driver(sps30_serial_driver);
 
-MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
+MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor serial driver");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("IIO_SPS30");
-- 
2.54.0

