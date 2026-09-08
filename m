Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627F52ED34
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867699; cv=none; b=Mqn7kcbEBWNNxXCB/seDopa+qM55qfc4jmh+jUErsm/aFrG3cNHGbGzAqfUG/yq49UrSNrpqRVkq0+/KGPT2FXqNYKzWddhlirCVWjaPh2b/nLg1bGJu4phBnjhjjlxbOd5MCfZWGZFQS02SQ0GkDs2/L11efpWvjkJLuTrWAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867699; c=relaxed/simple;
	bh=JEriB6GDjlcrCUa78TKwGOGGWVkUgVsCS1pUbwbx7n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c62BFRAUp2QV3RYZXmPUg/ORFX1CfqK88YYQzNZ7wt5o5P25QivQr5yMTHAeLsdguM61iYbiRa+JpiHNpmXngzWQ/7ZBUIZYrZ3Pq2k1I5Zp0ASskg0z2bgK8AR9uW0vPcIXMRJEeLRR/Ccryo7U0EoZ0epe6RMe8BC8a/HM2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR3I+aF3; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR3I+aF3"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a985799954so125258a12.1
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788867692; x=1789472492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=geWMNX1K6rx9sqL3rAvPz4Otwn4ZznXQlhtRu8yNQXQ=;
        b=lR3I+aF3JKqFWmZq7/dZzhbQmd1vFF/b02TxJz5tfP4Tvm8OokaTHNqKVom4tnGf33
         21XxReeSPgCvtuIwaXSBzXddEWexpY26rH0+o08xcg7trZpb0ZNmXg9C0W520QTNdDFI
         IUxTYyppQX6f5KWLqnspucJy5rFe1Kro52kI4aStsfnVh5PZvacINOMO7MPUyRRC5sNE
         mMdB+o3g/ftfUInN2FahS12Sp3NY70sJqRqMmzbbS+lc9uVEzjCDeamWyq+rcEpqVDUr
         9Yxf+cOGtx5e85c16ucFPAfQD7Bv7uqbbHBqqcuPsaKEpUGGzghZvEsiD4PZbebqZpk6
         I7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788867692; x=1789472492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=geWMNX1K6rx9sqL3rAvPz4Otwn4ZznXQlhtRu8yNQXQ=;
        b=ClCSAReA/4llQntYj5Q3NV2k3pomnpQvY2op0ph90Gcg52JaVm2r5g4oeu7WRYUkxp
         IWxGWFNr5g1sW0IEibqwUfdhy8VnbORk0gq/RW1Mty3TWH11j6P9eCJj96lGVYRvIV3Z
         TgmbncVu/+7fKMAlHxF1chBHeC/YjHUS//uccr2j+EwrH4iw0vAJ51ymplmcgP6xY29c
         55Wgc0PpwUblLGbSGYga0ruKWlq2ITUTLPKrSsgmE3Ne9XPly9bNIpoprFQXo9JxTBd5
         FSjq38bT5CAH6K3ui3jJOex2V9DDl9SPImv/k0qwyBtRYKzagP+ybA9lT/CtPl/PiMqb
         V7Lg==
X-Gm-Message-State: AFuF++miea2xRlNgKsyTAilgSFdfIdkKu0WzZDxV6BzjuX48X1FnKAju
	69KFj7Crgt3JM/BhUjDk8XCeGCqBxkLUhqWdRmCZzd9sHqda9TLi7xKr
X-Gm-Gg: AYBFou1O1hKRV1BKTj2pCuRqg/xyzjb2rE87zUwvEuo7TUiMHCkbaoz/IAVDZF6d4sn
	HZBujT+rpsYYd1dZx+7/dkzJhPWZxwk6Ga5mULLTb2Qc7FyiXElhPs3dN1rhpTpDFsMHLHKjeAW
	nDnwRORdrARqnJ352eXrC/yup7mAnfQerTFc471RfzVkkXZU0Q9Sz7ywgrWw+Qj26V5rgEp8Cb5
	U1w/JOeFfMtMSWjPNpMYPjWqJlGliO/Re1taJFkHnszS6m//bS4xprFtN2tEB5glaoGFY8bu1uf
	g6unakY400eSWT6wp+lbN/Jyyr9mcivgg9KzBQfM+nPAZKV6N65spqYZEpkLabzFMWzaudgHJv4
	oyRfgsvv/zx8KYkCbNmXHgjlCPXtMPf4C7R+sZikNi0PIsf9G9ARa/jUFlyWnlq4bdHf/dODFGt
	4CF66uVSS9OZUFNLXycw34uNUqcLWKTWTSpQSj2FfpJi0Td2cR9z40ytVonm9Qk3n2jU0jpFyaf
	gwjfXPeOBVt5nJ25KcFJoHZhwlyF6tehhaaC6NbvXkF2pSEchUwPQst52xywIfseQty8Sz+5xFf
	qhbiOZmuLZ5MkRW24eoZ/gQQ8i4Repg6f0CSl162qs3N0rUhCMZMGyZlH28zM/1ynAgUKLQVyv3
	50ph6EsoLcLGzNA6i3w2T+mAe293+Bjz3FgSUiE42bN2dw/wi9K3Xl6MPgZv0CPKtvQ/EHnKKP6
	YSBBGLPHMKx50DZbThRq5nBwa8dpdJSfpTNktK3P1kbZP3JiM3RrEazetENl42GCHj+gWUDvEV
X-Received: by 2002:a05:6402:4050:10b0:6a6:92d6:daad with SMTP id 4fb4d7f45d1cf-6a696a98b4emr9152785a12.10.1788867692285;
        Tue, 08 Sep 2026 04:41:32 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.oa7bb030819b2a894-tp.internal (209.47.7.34.bc.googleusercontent.com. [34.7.47.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6beesm5530489a12.8.2026.09.08.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:41:31 -0700 (PDT)
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
Subject: [PATCH] iio: adc: max14001: add missing MODULE_DEVICE_TABLE macro
Date: Tue,  8 Sep 2026 11:40:47 +0000
Message-ID: <20260908114047.1360-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX14001 has an SPI ID table, but is missing a MODULE_DEVICE_TABLE()
macro.

Add the missing macro.

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

