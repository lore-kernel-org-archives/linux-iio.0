Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1803D0929
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856937; cv=none; b=npltDrLSSZw6rzW/RA0Zp44s15ElBk0BACf655XREjYVNcsF9wLCZ2IlCbR9W9jtbi7GxajUH3SkGIHUWb89/ihO8va6ckMZMmat7LdlrxD7w5LpPLfQnoMDZc5uM/2SIDNBpnA6d3RpjeSrt+LdNLmhlgbhWHBsw1/y72bDzh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856937; c=relaxed/simple;
	bh=XicQrbXHtxEc+nhrDPwExzIG6n7m5hf/XgOWq5PALP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a17ABOxHl0ZCTl/o3Oh7FzuE4AmwY3TN4zo0VauHXSuaIPVYkNKLWSaBshBDsm85KvidTTLfx3C9U9YtbnYu9t4/fYyAeKhdg5C+9B35RMij4xd/ZMlcceKHbQ8wKytyLXvSQxm2kdQHQQ7neQDb4Ccn+tIIDKPpoXKjpnQK0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKnvaypq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKnvaypq"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b941762394aso727057066b.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 04:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776856934; x=1777461734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTkeT7ykGWUo4e90ZjfsCvFOhSZrp8IqQ5e83jDUh4U=;
        b=sKnvaypqZ3ZjyekIl9iVu+Bk3erb+g+b4laAbNHN/AsQg+X2rRl30v+igS4QqHCE58
         SFlMXU6roQAd8ExozHXGC8RUBwsfjxoBwHwk6PiBRxJq0I4+13nMGH1CiP+2JCK7pul/
         VcXDIBM7Tjs+J48ClfSKHsMgg9AY+jNZsT//bDjveHuk/duJCp9ngzdbIMra8vrOXcRG
         UanEs10Ev0znbs7RcbACSdN5p6zJGRsWYka0ndSMkQnKEkqzV94dewytKP0N90PPLZfF
         YIX3kqAooNMLFWTWdWHvI2mGvJvvQT8QFf8U85H6IQkLKfiwqWzeggt315G+3LDCt+Ad
         rtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776856934; x=1777461734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oTkeT7ykGWUo4e90ZjfsCvFOhSZrp8IqQ5e83jDUh4U=;
        b=knvw29CvWo2LW/+UDzIhRxwTkiIv+H++0IoKlA6poJv/gdNz9myWn8tvEWJCw77Stc
         l5Zt9NYj5I7jH3z5Bu+C17H0SvQ1/jhw7fUpaca/+3yZ6nf86RWRJiYtaN/gOun9MHbc
         ObCkg5/NP4eKnQbdAyRFvWrucz/mSf+SGdY1WDE86IdlXl95gqrVDm23qNo0R4hZDnJU
         yZMEzMmHIdb4UqbUWSCB1Wxgv2FBQ7GvRxjQZId1hUV/NXPPsa6Lwc3frBx7pI8aF4nD
         ZpzGhrW9zyoaDjvj11oKA74Npy8KhTKggC7daNzQmO6CaeiwixcHm7xn8YvszBJaU4ce
         A18Q==
X-Forwarded-Encrypted: i=1; AFNElJ89Y0LCTytAI/lzfr5V3ijUyEbAIBJLGjPIb1Wk0GWFDTEuFQnG7OGjrMeW58Lfuu/1EiZxJp80MTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9l6zoSN2Aq2n5WLIg5K2eVQAWvNf10g6eHo0ugL2slSsUdBMw
	dQ21EADNpAkxguGHYL5chImg7ihQosnGw+Ah5T7bQwJbDn5+/yUKfT4c
X-Gm-Gg: AeBDieu8b1KqbKRxGLgpkJltY9DQEDw/7ZXbI8CC8a4iFvTQ2MkPNKBx75BjBi1ct4H
	WaC3dZ9Zei5I1sEEME20Rt0RPcC9VmfP5vUOuGd9i6NfJQMO/k2I5f7RHHqqEiOrVp62QXySZbe
	PpuP85rz3XFPDjic36btZ9MDiOS9r8sl0EHlhHx+bqnZOQq72w0Rgv7+AFpqR56AjvzwR9D22BD
	6xWd++jmfuDQyzMjzbtXP0bQS3+7cjc1d9ZefadKIOdX8C4CeHJ72ocrI5HLtmUk2NF4QfhUyiQ
	Sovs3RhuxJsxhT2isBrbw8KkqOYbetRUXDsFOZsoNGEDtNs6UpTA/b3Zc6V8IVxjLLHuH0cktVV
	Ano2DSpBnXM1y9qSpWMVCvKQJzRKvR7/zoWDXszgSFw55WxJnNs5KPdIiF4DqHxeW3MQ0+Mpoau
	P9I6uvklHPsRE1LI5kDt/qZffqtvamC1RRsrbrab4VHp5Ahulf0dAk0O1zqG09Vc1IDyDPrgO3E
	jLTjXUOC2yBxcRK64fFxaYHL6/H/Ob4onpDpXmsW4lvZAeii91N6gYcEhj0RJihLhAYiVgMCZ1l
	onC/BBO7RikiEicoa9vga7ZNaJKjh3tj2tLmq5Pmr35NAoXFcNaIcjew6UnsVkl2ryyYq0jC+hZ
	g86rKkMGEOCWHClAm7crAKpJwg6VaVAGiC6agSQ3agnozxZdHg1zhz2tX9MYwh2jKbG4dnEqxEK
	Nfb+zop1c=
X-Received: by 2002:a17:907:9629:b0:ba4:94f8:4df with SMTP id a640c23a62f3a-ba494f82009mr975254866b.17.1776856934368;
        Wed, 22 Apr 2026 04:22:14 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (25.236.141.34.bc.googleusercontent.com. [34.141.236.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba6366452c6sm395156866b.11.2026.04.22.04.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 04:22:13 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 5/6] iio: magnetometer: ak8975: fix wrong errno on return
Date: Wed, 22 Apr 2026 11:22:06 +0000
Message-ID: <20260422112207.1313-6-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422112207.1313-1-joshua.crofts1@gmail.com>
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently returns -EINVAL on polling timeout instead of
-ETIMEDOUT.

Replace return code for -ETIMEDOUT and remove unnecessary error message
as error is described enough by error code.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index bceab47e5af..723c2f64b8e 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -662,10 +662,8 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
 			break;
 		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
 	}
-	if (!timeout_ms) {
-		dev_err(&client->dev, "Conversion timeout happened\n");
-		return -EINVAL;
-	}
+	if (!timeout_ms)
+		return -ETIMEDOUT;
 
 	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
 	if (ret < 0)
@@ -695,10 +693,8 @@ static int wait_conversion_complete_polled(struct ak8975_data *data)
 			break;
 		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
 	}
-	if (!timeout_ms) {
-		dev_err(&client->dev, "Conversion timeout happened\n");
-		return -EINVAL;
-	}
+	if (!timeout_ms)
+		return -ETIMEDOUT;
 
 	return read_status;
 }
-- 
2.47.3

