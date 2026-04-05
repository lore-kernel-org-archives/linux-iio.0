Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05430CDA2
	for <linux-iio@vger.kernel.org>; Sun,  5 Apr 2026 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775405339; cv=none; b=WXvMsSB0o01jCc/MvWqNXx6rqgFMeXZn5p4e/Qe8VQYGsMlU8BAUujxLjCrdkiEWEkwgWGnXy3cItCdUXwIpEJ1CFLczT4oLBbnKoW6SNrX81LLZCNg8n1LUAJWw9hgIEpMM1DU6c2BUMSS61sdtQxbxlqucGnBKxHeYRFm6Tqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775405339; c=relaxed/simple;
	bh=cH3F218X278uogrQhozgOjxHvU8OCy1FU0iCLuRW00A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUyYUr0a3Zv2fKsPM0Yn5MIQYPWwxY6zWwQj35JJfmdn00/9bcLnMOJKZOMUdMIeW08EJhSiPjTeStlDYPLFu4yEVdPCDoBNN3irWso8WQriarlT77uVoO4Bp2DhGyLiwFGX2YGE2U2zgRh87u/Jg61+ESIL/O/rRTJoAjJek8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aw3h+guB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw3h+guB"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66ee0241bc4so502815a12.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775405336; x=1776010136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEwYglifR0MmXj7wx6gBUAWBEtub2MxfN50siSCQHrE=;
        b=aw3h+guB27OOlQCiJJ5+P0vkIViinvPDejlkXj8Xu8zYiapcXZTjW00zjIbrMvz+Uo
         4dWd64V0kj6GHLAYdgj6wW/4DH4KGX+nD8CitmjTPORqbj/Rl0OjkVbpPmi/Pd3k4IaX
         KEcwoXMrXSd+/u/TTBr39VyAlUFlJlYQDdTEtSfeMOvTSPHuJz6AwMYB+1n8WGucihKH
         eJtE6YaV8Y+72ohODRNX4Jhh8sAbZZdUn/DUfPlw6ZaCQg7Cyngr9ipvITlRPT+5x0WR
         JaEyi2oihQ4hy5j3E8yjqQnIm8b6SPOyCriyVzzVfn0BU46tzjRrqhZlNgibJOFuzQ6K
         KnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775405336; x=1776010136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PEwYglifR0MmXj7wx6gBUAWBEtub2MxfN50siSCQHrE=;
        b=AYNE2tpOLtRh1M5T9ejYUlO4Oma/8+6PTn/gZn+PsKRcFJYTwqiBCYWkwE2ShwQ07v
         1yJCr7ye0zG5XPIcjDrhUJWB8VEH+HhYmW6U25yt8pjDmREi+T96LixPmsI9RLBz9HPI
         Yfpf0Qkm7Vt5KiQHi31aqtvMuMEn4BTPkrSPdN5PE49WigcKcvT9mWHwPjbEtGO+cNJ6
         8rZ3WYX/P9XicIqF3YNDNN1e8vYyMlATfaN+zNLvyQUMicDgPzM/hMzmu5+Co7s/udKv
         oxZY341Dp7uj4c6uXkDpFJhhcapJ0k48spoy5Pc5LKlve5pLNsyYrNWOtxu7Mavil2NO
         0oGg==
X-Gm-Message-State: AOJu0Yx2di62Cmvs+q5lumrC7ptedQQFk2IFCI+y7Koxnfoh2btps8WI
	ooSmEXoVomznvoIjq5cWuj2xT9aEJ78TZ1rQ9PLr3pT4w0UBXqolH8Y/2QaLR199
X-Gm-Gg: AeBDietzuLTGQBvA9wwdMX8jJ0V6HiwJN/38BZbGGa9M+laXtHVxHQqBW151JXxhz2X
	4/Qpu0f98pPG9pxAojJUsr1tVNpfdpdYJxREL8Jxc8KujNxdWKRuNvV6J1zYftyB+cfh1oeRlbK
	eiBTFhLK/NXb4DWe0X5U4B5XELKHu89Ogd7TpZPf9VxGPtHw1+w9zVqXy3/SAhzV2GkYIagF3NJ
	uPoymqk/JU170k/Aq6u2tXElcoBJB6ZawP8jXx8qoadhPcGsYc4n/WLqI+IV9DIilj7Vd0JMkza
	GvkKtkDuM6OytUg3O9wxnbnEej1EXPx2US+f4etkHRgXhdieL4IXIK0H9Ew8qPZyv4c8kscxSYb
	uwFnCNRuPqCb43+b4/+VqfecmpDhi0I0XlewZLopdKT2lLmE3LiML7mE181NDReo0GCxSt+TJzy
	MtuN6o8n5XmczYYYgMVWfjdAktxQ==
X-Received: by 2002:a05:6402:34c3:b0:66e:3870:76a0 with SMTP id 4fb4d7f45d1cf-66e3f3dbfebmr4543898a12.10.1775405336062;
        Sun, 05 Apr 2026 09:08:56 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e02f389absm3195890a12.13.2026.04.05.09.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 09:08:55 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sun, 05 Apr 2026 19:08:39 +0300
Subject: [PATCH v2 2/6] iio: light: vcnl4000: move device tree entries into
 one line
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-vcnl4000-drop-enum-v2-2-7c8dc98c3974@gmail.com>
References: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
In-Reply-To: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.1

Make device tree entries one line each to save space and LOC.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 72d68d54864e..604e7412bea7 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2079,35 +2079,14 @@ static int vcnl4000_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id vcnl_4000_of_match[] = {
-	{
-		.compatible = "capella,cm36672p",
-		.data = (void *)CM36672P,
-	},
+	{ .compatible = "capella,cm36672p", .data = (void *)CM36672P, },
 	/* Capella CM36686 is fully compatible with Vishay VCNL4040 */
-	{
-		.compatible = "capella,cm36686",
-		.data = (void *)VCNL4040,
-	},
-	{
-		.compatible = "vishay,vcnl4000",
-		.data = (void *)VCNL4000,
-	},
-	{
-		.compatible = "vishay,vcnl4010",
-		.data = (void *)VCNL4010,
-	},
-	{
-		.compatible = "vishay,vcnl4020",
-		.data = (void *)VCNL4010,
-	},
-	{
-		.compatible = "vishay,vcnl4040",
-		.data = (void *)VCNL4040,
-	},
-	{
-		.compatible = "vishay,vcnl4200",
-		.data = (void *)VCNL4200,
-	},
+	{ .compatible = "capella,cm36686", .data = (void *)VCNL4040, },
+	{ .compatible = "vishay,vcnl4000", .data = (void *)VCNL4000, },
+	{ .compatible = "vishay,vcnl4010", .data = (void *)VCNL4010, },
+	{ .compatible = "vishay,vcnl4020", .data = (void *)VCNL4010, },
+	{ .compatible = "vishay,vcnl4040", .data = (void *)VCNL4040, },
+	{ .compatible = "vishay,vcnl4200", .data = (void *)VCNL4200, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);

-- 
2.53.0

