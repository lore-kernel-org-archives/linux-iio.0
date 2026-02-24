Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61070B640
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771900533; cv=none; b=eeGjNPzw8+TW7Z1NlhjBCGEPm923J414C7QHIba+f7uKTbd/SlcvZkBI1TdxOks/xzIBnJ+1ToqmD7EYe0inU9yBQELJadf1ifjSIQJWGgzogHegm0+7DLFEqBqsaA3fnYkyyUR6di7q8U6XMUJ12zIV7zXadzGeoBECfUiJALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771900533; c=relaxed/simple;
	bh=s1zFK1TS73tq+ohY7NVytq/+OZdvoToGVEo4dW6cH2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLXvL/QfqsrE7mS6r0OOE9Y2NTelI7aPTHYVPBdatxNkvmj+jwTdRqSr42ml083JwDnZlop2XsYtkrBcmTYeZ+6wH5f2fNfxJcfqr4C8uf0/xEICc+pBwWc076rXKxJ9m5tye/Qn9llZ7Jn6fPsCPh7/aScME17HzD1tks3AYcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THMSyZ1l; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THMSyZ1l"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7964fb9ae3dso43955047b3.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 18:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771900531; x=1772505331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xO7NRodaccApnRmqi9Da4QW+JCUoIB9yS32ni4hFaBA=;
        b=THMSyZ1lYDJEetCWquQaJfATPudXLw7U66cZH6sBf44dBjXgcYlprkOeiwC9ZLvhX7
         DdesGP1dQP9mtlLpQQc6Cr+71pG7ohNTTUXGV2rAn3AmnuSX/QkGdluF93w1GdoQ9DHq
         VkqRLFArSHP/L0XJNrGi3Lz612dXEvwrTo4FcGBzVJtk3QDucd9P4yfWmuV32PwG+NMx
         9Qew/rn2rSZQ1Tv3t9i9O1xy3OGy0C+TuTEI4AB9Q2nCoRzUtDbsr6H61+2XGiMUNv0m
         nojjM0ZDKMgrJ6q4B9apYNxbIBsLxD08Txg4J5K5KCSlZSIBJmPZ8TvGq3JWh5AgK2oI
         wjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771900531; x=1772505331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO7NRodaccApnRmqi9Da4QW+JCUoIB9yS32ni4hFaBA=;
        b=AHkCeaYCwKxxcNSCeK3HsQ74axvCgEewPQ1FIybcQU0v1B780ML6z8q+NMnJs1oHSm
         CsGaOIrAzYDYQfTlDTel8Rt5YDGPYbJcGEERpHzs2CJsdIFKfekdBuFFKNfI/N9bnT6c
         VRqPcN6pvJ2aVBjY+EqKvrPqFjZIRaJbwA6gXM8+l6dxgsyM0i2j0V/HAOIGL+EvGd5/
         0uRgvv/MvjVWjK2WB9Pg7CRvNuHEZDVbGE0kRzlt9Tblb0c1ogFN/hA4CvQ/cjFyz6FO
         RjKs+HzZQxBayL1yw9gYsueBKgljcvLAQXl4zJf6X/JVlNHdh+kuo6sLbNFBAiw9S6BR
         PG7w==
X-Forwarded-Encrypted: i=1; AJvYcCX7fRnOG7E8JhPp5Y15yMmJriCsv9DYqQGXkjGVQ7rfgWdMzIuXNVPFwaVlqaTvhjUj/uQBYy8SAH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/m7NnxhEx+vzkexeVQKAj6ePWIYdkJq55rTkxUHhwbshJ3Kz
	PqS+USwoQnv8Bh6DRwraAOPsXiJlRKVUo+E9tEK+v80rJOOceW6tF6ph
X-Gm-Gg: ATEYQzzdESM/SUTgMAVL8mTMvKwGWD69JK1qkju/MLiNHR+vx96UY6Jd7/lQ3IBNrv4
	MzjfaZVMnPhLz9FROJAnwwu1L2ExlxB7qAQMtbUK63VDZHxVRHIdLc43WKw3X3OzIk+RGWo7b0g
	myohD+MWD2mMNzEAMrli9QETxdNVllY52MHkbgJeGph6bb0jeRo92UjkDizfSH0SF/hmhE3phBw
	IWlHZHaDqhy1J1rmaaEJY3DWesxDwiVrAc1nDJzL/fnETjbTIgJnWbkRFdLifJ2jGXbYWTDIsvh
	QeeFujJJDlul92+r4/hm6iX9NcoIJeub/kszK8OvZ+OYpKbl7Ct2+xqCI83vFpnLSeNJu4ubnlX
	MJAyELpMu886mw/sFv01KxJP61BIlL1s3G/23YFevHvAfM/svomP1i6bThq/0x8y95tE7YkIT9P
	8R+JUichuRhtWclwo9c/ANreNk/J7hA1eTfpTxBE6qceQSH6lnbvjp9u3h/v8SnHmyopSbENwYW
	BU9DoN1E/cdYagmjIGe9hbI
X-Received: by 2002:a05:690c:c8b:b0:794:f36a:c97 with SMTP id 00721157ae682-7982902483fmr99939287b3.55.1771900531199;
        Mon, 23 Feb 2026 18:35:31 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982d985074sm39585407b3.0.2026.02.23.18.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 18:35:30 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v2 0/4] Multiple bug fixes
Date: Mon, 23 Feb 2026 20:35:07 -0600
Message-ID: <20260224023511.274038-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes 4 bugs:
- Patch 1: Fix free_irq() being called with wrong handler.
- Patch 2: Added missing free_irq() in an error path.
- Patch 3: Moved iio_device_register() to end of probe function, in
  doing so had to implement correct error cleanups and place
  iio_device_unregister in beginning of remove callback.
- Patch 4: free_irq() is after called iio_triggered_buffer_cleanup()
  which breaks LIFO, place it before it.

I plan on doing a proper devm_ conversion of this driver, but went ahead
and did these fixes so they could be backported.

Ethan Tidmore (4):
  iio: gyro: mpu3050: Fix incorrect free_irq() variable
  iio: gyro: mpu3050: Fix irq resource leak
  iio: gyro: mpu3050: Move iio_device_register() to correct location
  iio: gyro: mpu3050: Fix out-of-sequence free_irq()

 drivers/iio/gyro/mpu3050-core.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

-- 
2.53.0

