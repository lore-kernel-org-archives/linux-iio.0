Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F9372B37
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703218; cv=none; b=S4OxjJTGtJfphZWeuaVTEpFhO+I86REtUTH6EQ0/2OuBs9Z6BFH1piSvxielaJ6izZM0QwYeLfr3T/a/ucmwXwVSA96wSWpeL9Mqyqw+YVUCHhLoKO5m2PgjUSHBr62Mha9qlYXkk52870BGD+u+ORRqIdA6iVsz0hI++/cKWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703218; c=relaxed/simple;
	bh=bvCXSrrK+bsuMX/JIIQ5RzFghgzKSgXgNYwxE4t+MDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BmHgg5l9DCY63eMfm2kex+Y+WJxD1v+9lozdioVQ34SLZEKyspC9sG5XUee7AtBr11jg3E1wY1tk4u3pRF3otl6RHLZBZJXJtWR/GuyF+utLA7KzH83k6Zq3SZ62yiCArrU97oradXk2rnxglOVzFNYZ8gpXvBbO1zLiiK6WxJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh8EvO7J; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh8EvO7J"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c0c1e03405so119384eec.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773703216; x=1774308016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0wbNvfm2bMqUSp2PBT04xk1dYdjzZD03hLTKy9vjQfM=;
        b=Rh8EvO7JAtcUlPWNVVD9PdW5+2j6W/ef63IKsbgdnVQ1ueQqUIY63njfrFa9MA3km9
         h3CSN4sBeiXpmdYGBixNhKA9qb8nb0b2AiBVKYg2T35b/Qsm7MTZtjMBwpXJoI8M0x38
         qxobOnzfUWvCct2PoZj4jiagYmD3kKs9QfMSdULsAh4SlvKKamCwcGohC0u7al0g/70F
         xiMB6VpIdHzIgJyJ3+eThXNeTiWcXxndlAwJDUKgimoav95gbEiBhmUXLw83kV6r6OD6
         abLi20kDw3b3Lj530QLYTzxkt4NhNUZEjvMNvyrEE+6OaZc65qY7LLOJgBGyfb72MvK1
         MuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773703216; x=1774308016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wbNvfm2bMqUSp2PBT04xk1dYdjzZD03hLTKy9vjQfM=;
        b=Zth+3nlnutTTwHc8V52NKmWHJCjrVAqJYcB8RfBYHZXNGWfPraDBFSVF2LxVz2LYtd
         HHtblkHDi9vPXZZLw58xEfYjTDjMEtuqHmcZcvAqyDbaOWiiVf82O/eQqjqxj6ogkeJp
         Z/LuokxCn6DRfx5LeJ6Ivo7ksFnZZwfWXyDQTqOBs2gi68Gdgc5b25cxlxUCEgoFHb44
         PvZER9XqNR7yKlepr8JElAlnB3qHc2at4xxfaHZLLSQuLdGSHYlcpNcHncwWlypqVyfF
         h5rRZpaeCSQpzLzcWD9IKnz9Wp0+Deo9G+bEGynNyB1aewbISQ19OrgLvx1IFN+XfdMD
         QLqw==
X-Forwarded-Encrypted: i=1; AJvYcCVCRnNRljRQkkpHstDLDdh5HimXkm5e5L+NTT+tt8PlGXRxD4j3ZsSI2Fzaa+sP83r9u0wSXjeGH8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYAQ9kI01H/WE/O3UsT6/KqzJ0wnhZ1ll8Zje/dZJSW1DmBItr
	NWcFpJ98cDSn+629zKy3p9dbr5vXBIcrry7it33u8r+Px+q+wvxdZ4qX
X-Gm-Gg: ATEYQzxb58dES9i7l3L18wwf1MRql11o4VllLGGK27QhmM1OTNsQqq39/T5Q3XtTuWe
	jDhiWJ97mgCjAGWfl7klHudIg5LWMqCs4Ya8dEMYLIP88mGB6UhJIMd5QwmqFlGbYH8pcUGXens
	SA9Gpto2fnexBdPiUc04NdqsuJZCVKMwHKMQ6s2XZsOnWaxREgvv1wyiAfqMBWAUHCMRt5Z2AOk
	M/UQS6Omwd9p4SOo40x0SgybhO7Qf2mOIix5HqbTQvmDCj/H1ViRsv0EvXy3e2MY3Ki1t0p9CPa
	u/Eab3dR9CWcLpTO1v6u0GP+YgzEALeNwNk831/I6w92y5RkpqyqUXlT51lZQ0XbNtlqAgwx+Sy
	w3//alX1FZONceZIldHkkQQn6qz0Ri+yKrSVOdWt19wsCrL8npzbdOUXIMviSgTnzzAs/Pf4jCH
	ndy9BqdAAgeIaxyiqsAIkbG5SMqit+O9Pic6mrJTbY91GHzYbPfdsOyY+Onyus/m1hgLDQsnlFa
	WigMQ==
X-Received: by 2002:a05:7022:2214:b0:128:d396:f2ea with SMTP id a92af1059eb24-1291722bc7cmr547868c88.11.1773703216378;
        Mon, 16 Mar 2026 16:20:16 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:82a2:a465:e71c:7d56:aecd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab555c44sm19846924eec.25.2026.03.16.16.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 16:20:15 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: lanzano.alex@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gustavograzs@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: bmi270: use dev_warn for unexpected chip id
Date: Mon, 16 Mar 2026 20:11:48 -0300
Message-ID: <20260316232007.22887-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An unexpected chip id read from hardware indicates a potential
failure for detecting id, which needs a more appropriate level
of verbosity.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
I was exploring Bosch BMI270 driver and noticed a possible dev_info usage that might
not be appropriate it regarding its verbosity level. Let's consider that probe definition
at [1], used by [2] spi version and [3] i2 version.
The i2c or spi callers will fill chip_info and then, probe will try to validate it at _init function:

// drivers/iio/imu/bmi270/bmi270_core.c
int bmi270_core_probe(struct device *dev, struct regmap *regmap,
		      const struct bmi270_chip_info *chip_info)          
    data->chip_info = chip_info;
...
	ret = bmi270_chip_init(data);
....

static int bmi270_chip_init(struct bmi270_data *data)
{
	int ret;

	ret = bmi270_validate_chip_id(data);
	if (ret)
        return ret;
....

from init, chipid will be read from hardware but if the value is not expected with
the one from the caller, i2c or spi, it will trigger a dev_info and not a warning:

// valid ids for i2c and spi
#define BMI260_CHIP_ID_VAL				0x27
#define BMI270_CHIP_ID_VAL				0x24

static int bmi270_validate_chip_id(struct bmi270_data *data)
{
	int chip_id;
	int ret;
	struct device *dev = data->dev;
	struct regmap *regmap = data->regmap;

	ret = regmap_read(regmap, BMI270_CHIP_ID_REG, &chip_id);
	if (ret)
		return dev_err_probe(dev, ret, "Failed to read chip id");

....
	if (chip_id != data->chip_info->chip_id)
		dev_info(dev, "Unexpected chip id 0x%x", chip_id);

	if (chip_id == bmi260_chip_info.chip_id)
		data->chip_info = &bmi260_chip_info;
	else if (chip_id == bmi270_chip_info.chip_id)
		data->chip_info = &bmi270_chip_info;

	return 0;
}

The chip_info will be correct due the caller matching DT or ACPI before, and here,
driver is only double-checking the value at hardware and printing if it is not matching.
Printing as info can be confusing, since this is more like a warning than info. 
I don't have the hw here to test it, but I'm suggesting to just change the level
of that msg.
Tks and regards.

[1] https://github.com/torvalds/linux/blob/2d1373e4246da3b58e1df058374ed6b101804e07/drivers/iio/imu/bmi270/bmi270_core.c#L1599
[2] https://github.com/torvalds/linux/blob/2d1373e4246da3b58e1df058374ed6b101804e07/drivers/iio/imu/bmi270/bmi270_spi.c#L65
[3] https://github.com/torvalds/linux/blob/2d1373e4246da3b58e1df058374ed6b101804e07/drivers/iio/imu/bmi270/bmi270_i2c.c#L32
---
 drivers/iio/imu/bmi270/bmi270_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 2ad230788532..a2f90ac22873 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -1473,7 +1473,7 @@ static int bmi270_validate_chip_id(struct bmi270_data *data)
 		return -ENODEV;
 
 	if (chip_id != data->chip_info->chip_id)
-		dev_info(dev, "Unexpected chip id 0x%x", chip_id);
+		dev_warn(dev, "Unexpected chip id 0x%x", chip_id);
 
 	if (chip_id == bmi260_chip_info.chip_id)
 		data->chip_info = &bmi260_chip_info;
-- 
2.48.1

