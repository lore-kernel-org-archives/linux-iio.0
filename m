Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DD41D131
	for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786816674; cv=none; b=n017RwScLvUVbtjopo4U1RiJcatvAjHookXEPiEGb/ZsS/tX3ebkB5pU6GyTZfbR9DXmMrEt2Hn7H/XiBTu8/fdhtmAiS00SUruhAYisB6kZ4BIF+BUkootjtqieZEo32jzf0262IL/KnqVkdZAeDvuMM4GT4+v+Gbjzxdq4Sno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786816674; c=relaxed/simple;
	bh=tcPA71Iwiuh+6d+K2BWWYWOPeNYRXOyrhzjZLVSYZnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9vNn9JfryDnXWJ7uFoJY9A/QNG1CaqNHtLwkO+ow8GvPgvk4/hRI/L76G58Ryb2U8JbndGOffP7qNttdbHKLVaI59Smwcb+ufcy0ddJna+WS/0LdmT6q8Gnyp7HSaohQx+LnfVbZ4mNVLvM/z0O0gxGImBt0gtfesRWotfuJ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjKg6dA4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjKg6dA4"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3811f512167so2972490a91.3
        for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786816673; x=1787421473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2bSckIlwPJpx9hvVSl2glvjNco4xqitYXbnHQtc+DPs=;
        b=QjKg6dA4VoI0LVZAbAUCjHiiOWZAHCcCXcpjyznBegZqM3acfs6n/PUNU6loYfYvh7
         UDlQE5q9EOTZeAjgHpsU7moiKrdMyeHw8wJ/UYLHmpQatJdzTvCVV998RZmM9oN6eIg4
         YA/ECrACNVoxlVNVC+8w5qGAIDoMjdAFivkdq4E5hFafP6Gwv96kzu1BOIraXNCfU1yY
         nql9yaFYUwj1zsPCa05xw6pNLiNr8KSbmGfXbSJVterzXBr2LkqHBMkl7Y/vW9FX+sn1
         TYuo63C+5X58wn1xsOGBUaS+wmFZL7CW/gI8mzjU8FXD0+CrUro8UnnlasJd8pCz9SkZ
         diWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786816673; x=1787421473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2bSckIlwPJpx9hvVSl2glvjNco4xqitYXbnHQtc+DPs=;
        b=qzeMqTqyQgzyY1F6M5dVWwaERFIMqH1iHS3drwMdQDquXYflAQQ/cZpSOOOHtFywPC
         SzogPT9n1oKhbtj0Y/v/2gCp+em0PSOg8yKs7PNAyG2+2+8mfNuzgyxHh2SgU1lpaeMp
         b3BSMzMgGFvJdBmLwiJaepi6vK9Kr2Ajb/TGiwMcdzwFf2aHoOUd+2WlA3Llh+B2d2D6
         SPmWBzxt9iGvBmJJyGiFmT5z6oXGnv0lkAuxrsN0KIoUpniQcolccB7yPC2xri0DrUql
         INImY+/sL4IS5Zv8M+80iVQvjKRYVji63oWfNSEAojGBzxH8wJ5ZXKQSsEgfotVADiu0
         UDgg==
X-Forwarded-Encrypted: i=1; AHgh+Rrjgcn0II56by8U5nmfVsvDdPukZHkjBRwMG0L7LMy8xrpMJ4sgbqe65ZmIFoOAFMScnLl31q0wfKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzEhkpZKAch6izUz9qOEUQsxJ71728tXIJH6T5JbWCKnF1kN91
	U9RqUWAi2HXAx1RqxwqN6DCnKjM73fyTO9UAYHGCJqSar2MNBH4E/+Zj5ADZZDrz
X-Gm-Gg: AR+sD11ol/Th4vty/cIuEM6lHDgQFxOS2uHNfWo+dP2KgFzNk1GIrxKeeHy3pENl0aZ
	v34GMiTDpqzPYZxkT6yYs1gr6VXaG3u7nQ9HTZV40jVBrEn/i5IDjRXS1TJjCr+DniW72dWE5sb
	3XDG7hZX9FQrcQ5ajPCwOu79QYo3s30jfgEpBXGgYXVfwPW3o1RuJuBP5T7T27D8SAQJ52oiopc
	yyZuv+VHYF0PtyoArLSXZ9TgzuKfuPELKkWdhClzkrxTNu7aovsmWuzqTYnHQg4qlSUSRkHGv7m
	QC46rWXAfIHWJMMsWz1uU0oGmrQ8xY9dQ5sMC98AS3ef/nTDrRRGpQ3odOFhBGqFa0rE5x/mLaG
	q2XKDWokoTfZNy97soQ/oGCYa1fcB+geZRcQVPqpzWGWSwn7qDzxsOqVRf7InyIvF4xj596roPP
	Bj8XjJ4IlI2naiWou7S4gacJ7PY4tYuqKs0GeTygYzx8Db9YEJ6hnAwHPExcyhIHg93YwG2947r
	8G2s3zd
X-Received: by 2002:a05:6a21:7316:b0:3b4:b276:a789 with SMTP id adf61e73a8af0-3cc71ed6b3bmr16267696637.36.1786816672887;
        Sat, 15 Aug 2026 10:57:52 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40d4:1248:1816:fcb7:1765:17f9:b9a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2fcfb8sm17305163eec.21.2026.08.15.10.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 10:57:52 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	yashsuthar983@gmail.com,
	grondon@gmail.com,
	linusw@kernel.org,
	hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iio: accel: bmc150: use iio_push_to_buffers_with_ts()
Date: Sat, 15 Aug 2026 23:27:28 +0530
Message-ID: <20260815175728.99541-4-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815175728.99541-1-yashsuthar983@gmail.com>
References: <20260815175728.99541-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts() to allow source size runtime checks.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index e8d27fd1be3f..b6d67965b984 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1009,8 +1009,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 			       &data->fifo_buff[i * 3 + bit],
 			       sizeof(data->scan.channels[0]));
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-						   tstamp);
+		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+					    sizeof(data->scan), tstamp);
 
 		tstamp += sample_period;
 	}
@@ -1194,8 +1194,8 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+				    sizeof(data->scan), pf->timestamp);
 err_read:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.43.0

