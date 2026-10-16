Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525944C4FB
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151201; cv=none; b=KyTSjKNija81xnctKqn74YR2qH9MILPtZHcxlz9iZpo7YR85pls42IPviIX084pmwb4xUgzmG0LHGs6NN+TB7p8lRLSP35rHv47VrdAeimeZGay+Eflx7QweRSMVlIhTED6NrrgpOUdVJ3nlDzQBr3WYCmKTC154849XAXHmRgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151201; c=relaxed/simple;
	bh=iknpBKL/+fRfSik9M4DCRF1TBz+Dk3rWM0cM+WTvsR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9KxE/o1hnNPQzc7j0mkxeQ/EgXQTxKB432xcjwm2LyQJXh1zXy+eHoIX2Dx/b8lOBFqVz/G1iyzCgBc+Nexg1TgDp2QlQAMfL+d8FpuCk5Bf7trLHOPGyqHdil8sFEMizMaTIm3JrBLmZIFvNVTo7JZtN+kxDN/CEO19n1x4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETeRlj5b; arc=none smtp.client-ip=74.125.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETeRlj5b"
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-35dc2af1f2fso1748803eec.0
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792151200; x=1792756000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Guv4YIlbjPaNFX5mQLYcMXfkDV2Jd4+Ri+vbx4z4JM=;
        b=ETeRlj5b+KbHL0pHEvwelj4XhbN/d/n+J+Git68lirSkpemSUOKaxyM5nc15Qo4vqh
         tE+4XZCcxH00gqc20WGS4l37RZM/FAtZZsd5M6ifHPa0XcDAd/oNygB1KZi4smbk5n26
         9/L2Et+FFnnLfKhgt3+4BoOsLkpHpjJfP1SYiqpzR376JZ/ByaVS61N7LgVHaGBvSA+2
         tDgZA8zxRI+ju1dUfVUOAFosbaiy79cwH90Xtveg/QK/c27VIz307U5x7D5DGDWqQKRl
         4vir/2Q3js3ofQjq/HjX34mDThmDjGKPcjaT7Ym6aipxKfTLloTy6X82gIRXb/5pqL9w
         YbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792151200; x=1792756000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Guv4YIlbjPaNFX5mQLYcMXfkDV2Jd4+Ri+vbx4z4JM=;
        b=tMGO+uRM1AO/Ugo6K5ip3jYREVEwpf5bJY6z4kmNutacdRHvJoN93gJGHC0Q7I6IPM
         d+B2xaCpZ5pcHxmk3Djoj4sqz8BNRZLzXv6DXh1RISEBDU4RG03gle7Bs90s+VBA/AHv
         Vk4dKsY+gqucmhB1USDfBgeMLukZpjzOZPpnnCcJQT0XskyDiDkZcCKHKc/V+nZDhU1I
         BT7DStr9Oe3Tnu8+d7tdMfaqFRny1H3gFOMh3ADshk02lspKJm1pN36sTtJ8W8PnMOV6
         7lZFP3yxDh77PhGMUfKXTN+wmNgO5RfLqVbMegRunbpj7hb9PxZxHs7S+YUmJbBzimYl
         O/Fg==
X-Forwarded-Encrypted: i=1; AKwUvByY+FonfUsSVEaFQzV7tq/pzza56rEIdRMr5aF2GKbyOqZqP5jcLxkuYSjHEI0C0pqdAoiGiPMvvd8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIBkS2zElbXf9V2Wk3mWersJczlOeLIDcoBVjxmZlBiBUQwLNr
	pNO7iH4DsjPet6Eh203K4soOCqg5iIVxPrkjMAobl/MMHIkXM5mVTHKp
X-Gm-Gg: AYBFou2bE6Nov5gDLjFRqpv0S9W7dRWdqthRvmzF74m9M6KO8t0A/FNwf4ps4LkFToM
	go9bTlzCWTQdir9qveo8Zhb6SM73KcwDZwqmcOMvRhX3JXiIAZeN+uLZNdyCRXx2U2EO9kM5IZT
	QfXvpgpudY19NYY6p7DiXQpvCN1P9m02clAd6SyPGchFqdo/3zKooabWgBL4Mlv5MPgDy0Wjt1I
	d90fQGwiCpfuLASQ9A5iTJr+57flTBx/CBB652evYr9kPInitcFmzVZo2n+ka6PH5CCp5DABtnn
	AaFqPgtTISEoE7m3LHUH683jjz31sojGj24eUjLFHhtKZ/VkMFiMDCtyh8x3Y7vz0mAnKxML7Ff
	yHDOucIjCbxXmZZqWzooGcvqKhKtqPVn4AS5MUPMMVILlm/SI/9DD7Z6fvW96/5CN4Pu5HENG/Z
	1gqE3pnN8+++DStWlkaZla4XF9t9l2AwOfON7NnNAzTgbYX6lAho+0mos6OYT0YF3Si1np
X-Received: by 2002:a05:7301:78c9:b0:34e:e7f4:cc78 with SMTP id 5a478bee46e88-3537de1cfd3mr28424762eec.5.1792151199537;
        Fri, 16 Oct 2026 04:46:39 -0700 (PDT)
Received: from fedora ([117.134.210.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b63e1sm7330259eec.8.2026.10.16.04.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:46:39 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [PATCH 2/2] iio: accel: adis16209: Add OF device ID table
Date: Fri, 16 Oct 2026 16:45:27 +0500
Message-ID: <20261016114527.128364-3-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016114527.128364-1-shehryar.amd@gmail.com>
References: <20261016114527.128364-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add of_device_id table for adis16209 and register it with
MODULE_DEVICE_TABLE() to enable device tree based matching.

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 drivers/iio/accel/adis16209.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
index 07a682d68..2dd140dd5 100644
--- a/drivers/iio/accel/adis16209.c
+++ b/drivers/iio/accel/adis16209.c
@@ -298,6 +298,12 @@ static int adis16209_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct of_device_id adis16209_of_match[] = {
+	{ .compatible  = "adi,adis16209" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adis16209_of_match);
+
 static const struct spi_device_id adis16209_ids[] = {
 	{ .name = "adis16209" },
 	{ }
@@ -307,6 +313,7 @@ MODULE_DEVICE_TABLE(spi, adis16209_ids);
 static struct spi_driver adis16209_driver = {
 	.driver = {
 		.name = "adis16209",
+		.of_match_table = adis16209_of_match,
 	},
 	.probe = adis16209_probe,
 	.id_table = adis16209_ids,
-- 
2.56.0

