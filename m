Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81455C1B7
	for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2026 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958992; cv=none; b=BiliZkNvnMMLV/k9Y8LOSgvT3rbZhTPr28kDVctb0rnq3NXJnZR5J7qkyoTGVNC8O3lTah+qA1gWBcY/y7Tyu2Y9SVIVGEo9M3SMX+ONnhb+LFChetc2E4Jamgwv1rDdc2gM/7TaWZ9h64A/3luKJTvhidrrDOl/PVw1yeLJkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958992; c=relaxed/simple;
	bh=8aRTU8lVGgUweHEo4N2lqmZpdLeCLEASyfjPi1iOJ0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TucpD7eOmivl8ve0tz9QY3Rj47cblfGkOMhRm8kvc0TZ3jvby5Mq836Hpe807dDb2QFhyVl8c6o4t/6G08XN+6cgdDNf3WyxqJNv2mXR8RG2ESutaNmM80n3EZDWupVJT4pZOU0d3ErGGodw+tbalf9xpDtXxnGHVfKGBw151BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnujjKsz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnujjKsz"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c28fde3bbd2so488904466b.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788958989; x=1789563789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ODTOke9WBLLFCAtlr6DbY54kUxk8UUHwnHp/PHXh6k=;
        b=JnujjKszf80hjdJW8mAw+V3sOnMfW77+6TQ/VlE7CZs9IgjQfdXJbI7eqt9qxY83eA
         hodaQGOTNSQpyAkFbTbVCRRetGh/YHzE9UoU/G80SPI1Oa2SPV8jWG1iP8oXedswgBgt
         0Y8pExycguvz9mw4bIMHOFfgVOClbSPckyFxUnMD2uhT4P0PzkYufzQTJkqUVXugOJag
         OvO/llZRU9yJdX0N5p8w6pPZ2WTGx+JnKt33eClCAHrcR3KSQ9ubOA73EzJsgfLU2qP6
         ZQNno9FyP6okHXZWWvw4L95dX7svyMZExXdGc5gWHxcfZcvljRQFZhvT8/KGMqt36tP/
         u1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958989; x=1789563789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ODTOke9WBLLFCAtlr6DbY54kUxk8UUHwnHp/PHXh6k=;
        b=sWBwG5X4RiZKPuonMYDA1RoSaPGRoWyzXZemgaw/RUniidYctPTAKGlYCDEW9fP9NW
         uee/t8XnuvwL1MEUOZG8TX2PbTxKlHXhwGTz+AEj9yqiyJ+UWx6kswFNxwwj94V7ct9H
         ZOSOZ7rd8EuYkfDgmtwCZ4HvQHexw3VU+fX2usMP2tFZdZ1MYj+SaaEUbcHAzVIKwq9j
         O5hzlzuI62YP++/4XR3Ud5Yy0SEt0jmYXI0RLklgVLbpdA/oTfP8r3UfRXpNIhf8UZ74
         D9DdHCUYBsTzYdEwqiOdYHjCufr+ojpdIN0oTZ2mOOelu9gdDDtz1LJzRztLL/nIAjYM
         CKZQ==
X-Gm-Message-State: AFuF++lV+b0sHo0WcsQstRKRjsSXtZi5jRPABGK6YwZdxluQDQo5P7i0
	43gT2+O6XTnin2T1Uzn26yw7pUZSgT4lU4eb2buHdCT2D1R0CQ6iaK9X
X-Gm-Gg: AYBFou0p8IizPBBiOoXfUD6g1HUSh2pzOYz6c3uLeaxOa2Og8r8rJYBTKAcsE6qnxou
	He+vC9JeqJWZm3nLn4h4wWV48Wh9lgRt1e8/PYpMIAkT+jFW0yuR4GNpsMqna0ezEH6BxGdmgp7
	cRJ25eSPC5gk+GpJXXAhriAZf9E7vOagLdNWxl5YT+x2y+6Di5vlA7hs/OSUIddVlZn/fgKBC+z
	4lQkE/vSBgDe3yuIAEPI5cm8yVdNs74ygTNjk7eYbhDhZ/3RLyFSnbncnRHJutdfFKZRYm1VcCC
	Pieh8ARqYJLLrTzp+RWAHomtUX1JolooozhReKmW3TUz0Dz2cgboF5jjhOPUO1vecXqFmluPPyD
	f7zl84uK8uIvWqfXMUBZ+bjSoGq4DDsJEbcVLTfx9h8iHh6aBmfQEMujIXr8C9G2aifd6IExHJ0
	QFURaYGpn2CM/MZW/IQWM3wbotZhV5UhZmItjQwAcyyDEGSD5kikNrSdD8d1uw8OvbRibY+q9Y5
	Qmu9yB+2ieMRCyB8Rs0ozyH+1BC+LQY8VDmoi46/CkDRyarcWpSqjHoY2GCr4NrRS7XtdyFbOAr
	N0xXTnoQ8+uh8D3P8mi1m/0WloldiUezktFAlLLun7Eyl1V7SjRr0VP701IwVsZloQasGOawaCG
	JoEw+6wkXGp/1uG9DH3ENQsT3vc5jhA0vyGzzmcDzbHybQ45I48/k391/nSYPbTsCrHdUMNrB4e
	VO11o6M1ho8msKN9gTIwAU6f2r/iRJeZYdHdWnkp1VIGs4vTH8PgQze8foPRlpcubP6WzI0qBv1
	jp/ZH1W1bCvIms=
X-Received: by 2002:a17:907:94c7:b0:c1c:3b06:ed03 with SMTP id a640c23a62f3a-c260cb54617mr1419558766b.23.1788958988471;
        Wed, 09 Sep 2026 06:03:08 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.oa7bb030819b2a894-tp.internal (158.54.90.34.bc.googleusercontent.com. [34.90.54.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c28e4579395sm506159166b.48.2026.09.09.06.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:03:08 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Kim Seer Paller <kimseer.paller@analog.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: adc: max14001: add missing MODULE_DEVICE_TABLE macro
Date: Wed,  9 Sep 2026 13:03:04 +0000
Message-ID: <20260909130304.1395-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX14001 has an SPI ID table, but does not export it with the
MODULE_DEVICE_TABLE(spi, ...) macro. Because of this, SPI-based module
autoloading fails on systems that don't use devicetree (e.g. via
spi_board_info).

Add the missing macro to export the alias information.

Fixes: 59795109fa67 ("iio: adc: max14001: New driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/adc/max14001.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
index 58adeac62dde..7694fbb6a9fd 100644
--- a/drivers/iio/adc/max14001.c
+++ b/drivers/iio/adc/max14001.c
@@ -366,6 +366,7 @@ static const struct spi_device_id max14001_id_table[] = {
 	{ .name = "max14002", .driver_data = (kernel_ulong_t)&max14002_chip_info },
 	{ }
 };
+MODULE_DEVICE_TABLE(spi, max14001_id_table);
 
 static const struct of_device_id max14001_of_match[] = {
 	{ .compatible = "adi,max14001", .data = &max14001_chip_info },
-- 
2.47.3

