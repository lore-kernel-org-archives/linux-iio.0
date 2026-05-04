Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337B204C36
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886475; cv=none; b=SgI+uacbDZvrbUk38ynV+880wp7InA3RH0YTaiyb1dgskF/Xp7zNZsn7Z/DPhSSlIAcqGGbDhATLkENs+WCVyUQgU4EfhXewTpxtH9TuTsmW/JUhstcEy4oJw93rs5np+gwS55MzhGhW9JORHUzSYyrYKMdzTiKUZvFeocDj2T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886475; c=relaxed/simple;
	bh=duUPlCxI8wuGm0k2U3KXAy4SPMs3kgHGrFE/FbdciHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZmb5NEXyEob2whgqb9RZvSmvUvjZ/CREiEKMRACaznhDhYDqXZzmnFWRcgU5MFlivMzU0KzobC8q+Zajkq0W9qNGGr7N8ugfGlg9TTWTOM1J0ehVcDjIlHtwLfQHRjzS/7Wuf47MBomUNdSzqdubiW9wXRPU905GKf/RDBa8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLCKsjJE; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLCKsjJE"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8028fa6039so600059a12.2
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777886474; x=1778491274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFWdw4K1FqjJCcxwSDMp7zY+uVTZLL9z6JMSUECo2AY=;
        b=WLCKsjJEUMfaLD2slgNdYZ0nqxLfVmis5EC9g5XI5sMiqfFFOS1C6SDSVUZnRNmwVb
         iCOSevQs7qOyrNVkHlfX0C92mL4mvbCYc3gerzITuVdX9S1Hcsh1a/mMf6uzPtOrP0DJ
         6FAjO5CMudb7/3hgQ/jTqHfrGbzSh75t1/W0stYEz8KlVx3quT3xf5w/71lhOwR/I+4O
         3e4UpXqBc08z5V2Y/zX0rl/E7nrxE+L4G8cFm3EQk/vMC09wMxs5d4Zen0cBmAIag7Nz
         6fwdhFq8bImQY0u+Wnj/+sMeCBvm/9acRxse48JdRz8rJkqZ9NWaDhBqtHkOZ9LZym48
         I16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777886474; x=1778491274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kFWdw4K1FqjJCcxwSDMp7zY+uVTZLL9z6JMSUECo2AY=;
        b=shh8bN0NohHHJ36iNkJbiWrtkg1n+jKcetZqegScnr7ysmvMxCMD/p5A+JIowJhRkT
         iZ9phhgTjY9qv+se50fHINERqV/DGeEqAQUuNRHftq/FhFsLTlIi3HKt2rw/Vhr8s/+e
         r+/euYUsOpLT78hp+xvGmFXkLLYuAgNPs0w8J4BuPp9g+9Xff3da4oCJfPYoBUb38aSs
         9nupxVcTo2hTFO/OxQo6ORty7fKwGWO51RGZ6bvq5GqEvqoJ3f2VaMzefKcfyMQsaOnN
         wXb4w6pS+0c+RaXA24p0unIvUxywzQMW3J8A3KsXB2GhSySEbDtciAEspoyo3CEqZ+KJ
         ctVA==
X-Gm-Message-State: AOJu0Yx62NF2beEs/dKj4DLrPo9YBQ1c0ylx1TROtpArQ0u26mqs+b+A
	XG/f7Iy18jX1kSmimSe2Qhse3zrfd2eUA0sYHLa++W+I3kQ/830XGdT2sPAda4wux0Q=
X-Gm-Gg: AeBDieu+Ky6UoL0rvnQkFEX5Zn7h3HyJJJd7PQ32CI3u1SyaPeUstMQGUfJLHXpMOTo
	rrom4hzEqdhMLTQijoJuet8IRFWZczIgfcm3gzwMq7AYcO+rjDootJ/rlZwwAEApL3wJ3xf9OUt
	mF+o8wx87Y7ufmhpfbqSSCrhOWrqogA5kSSUNo3YYMKzbMUPZOD94TJXok6lmipeA63dvmO3exz
	Mk1bbC1Yk3y4rd/FAISgo0xDDeI7/sZEbEmVbRa9l5dV+1usL2FnWze+NgLUw712wFlCXfEqyuQ
	E/I6YcMLbubAKel3RzVFK6TLF3Q44eFqc6WTN4ZqtCdmJGeurlOIXns/EUQhpO2dUQMpYZR8/NH
	GR1yXW+vonB1TxReNZSFkuvAiwIYnzuiUBzCX7w3mAKdDQL3+QH8lCYCMxVik2xoD/nnC59Fjm6
	nvIskXWMZG7xjQmQqBu33YrZjf2aDQEg==
X-Received: by 2002:a05:6a21:3a82:b0:3a2:fbf9:d824 with SMTP id adf61e73a8af0-3a7f1e9a75emr9174677637.54.1777886473478;
        Mon, 04 May 2026 02:21:13 -0700 (PDT)
Received: from scootaloo ([101.179.98.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c802545908esm4163923a12.27.2026.05.04.02.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 02:21:13 -0700 (PDT)
From: Angus Gardner <angusg778@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-staging@lists.linux.dev,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Subject: [PATCH 2/3] staging: iio: ad9834: use dev_err_probe() in probe function
Date: Mon,  4 May 2026 19:20:58 +1000
Message-ID: <20260504092059.1536094-3-angusg778@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260504092059.1536094-1-angusg778@gmail.com>
References: <20260504092059.1536094-1-angusg778@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded dev_err() + return sequences with dev_err_probe(),
which is the preferred pattern for probe error paths as it handles
deferred probing correctly and reduces boilerplate.

Convert all three remaining instances in ad9834_probe():
 - master clock enable failure
 - device init SPI sync failure

The avdd regulator path already used dev_err_probe().

Signed-off-by: Angus Gardner <angusg778@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index f2bf7123ffcf..0e4727fb8cde 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -394,10 +394,9 @@ static int ad9834_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
 	st->mclk = devm_clk_get_enabled(&spi->dev, NULL);
-	if (IS_ERR(st->mclk)) {
-		dev_err(&spi->dev, "Failed to enable master clock\n");
-		return PTR_ERR(st->mclk);
-	}
+	if (IS_ERR(st->mclk))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->mclk),
+				     "Failed to enable master clock\n");
 
 	st->spi = spi;
 	st->devid = spi_get_device_id(spi)->driver_data;
@@ -439,10 +438,9 @@ static int ad9834_probe(struct spi_device *spi)
 
 	st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
 	ret = spi_sync(st->spi, &st->msg);
-	if (ret) {
-		dev_err(&spi->dev, "device init failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "device init failed\n");
 
 	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, 1000000);
 	if (ret)
-- 
2.51.0

