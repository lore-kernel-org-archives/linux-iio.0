Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194B3B19AE
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776766052; cv=none; b=EsxATVQuQV42biIA20b9R+sol1yz+CzkNnmQcY3Jozym7iioMFHdR+I3ujtj0xGowRMeZJ0EJLosbKtYlW06ZwMlrTlkzAiY/jatZywBjmtDsC2UBdWwRYaw/resjqb4YQm5WEmii27RGckViLe8T4BI28LTTNrBHYIcvn5ztk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776766052; c=relaxed/simple;
	bh=4rc7d4rV7q22m4V5UAzTwchybsXTbSN/zluomuZK3Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l53Il0bEPpWmskN6sPI2q0BNYz6ojbeLg+Bu39c4uTEID0Qj1beOe8b4GMCbAfemh+gxqFhs9eKIXNgGtQg74fVPHDQkX4PflYwswmh/jYiFPuL0nqp7Ir4jNWMoO6TfUuQ8obVfRMX2OEB1bhfkaJGruXxRC5PN29394yeTdkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOIZNJP3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOIZNJP3"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8d7f22d405so699161266b.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776766049; x=1777370849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcWEE0D2kUWLEnguD5ZkSGbltLSvh2TI9q4YJsxKb0I=;
        b=OOIZNJP3Wx3ND2iWZwzDu+MKgmmUaPf/7CvCl5Sj6zYZM+g2qALIqdVJS1CNEjGxUM
         TiqPmQ6UBw4a0ahSwoEF3v4df/20trmGO6Bm7ZClK1vR2Sa0if8lF1rGtUv0k0EXz28L
         /SpS44jESblP7QURgNwmETveKkpQdqOh4F62UkBVywn8OxZjLu3dbQiqLS9kz7x2KCNP
         DRm1mAqZTvg3iOszDalygxrby+XyDCGQeZKN4ypMSuMDzPzNX01LRv+oPLl0Nce5fDYE
         OFIVwkV1ltnCWgzjF3IQHqauhZDCdbH8Zu3w+R7koIO5MGfRM5O3A7BF328voDyuZq4C
         o6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776766049; x=1777370849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcWEE0D2kUWLEnguD5ZkSGbltLSvh2TI9q4YJsxKb0I=;
        b=WjguJUNUK0AMySAKCLqlzR3WYurV7bndYKWhaV1K4CV5+iR+4OA8pCj/qfgwLENPvD
         0g5buIlT0D9QhwAK0jY4QKR58k9Tmf6dGRRFodqxdqyEiI/eCYn9zVI1yKv/1XHT+ppX
         lMtk+cNAN/rKC1en0oRL5rYNbHeyLWpyyGViW8E4siCu/F7OHV6BbB2e/6VB7ewZSgue
         YE+XajFVytLeQPX0U79j9EeZI/NbK2J3IktkMkv0G3fz+YH/EfcVIgoXrVAA0dAK/MOd
         3QyEF3qUqNYzEI2uIij4CBE26dIW7fgrq4ceiM4NOc7KHU58J3Ds07oJo3LdhURGuS9H
         zFqA==
X-Forwarded-Encrypted: i=1; AFNElJ8IAvYmMBNKvSTE4NGnJGFQOTysWz8JJe8C1Fe5QRBavYZzA0xxg9DvhnqDi6UFs5e+XFyqUemYFnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKH63PSOmwTLH2yV7qB1dO1evyxdbz0PhNUvbUt5GlA4KVmnrb
	HyPHUH6IWIhkx9uKw+HjeATlq703vP0MHyzjrO/qOk/f6O9vpw/HY9ca
X-Gm-Gg: AeBDievVuiuhJT3mZxruucOfRKLwzqgv0fxJS+l+TbliUkMub9FlkkkzObux6LgS/QM
	ayORcJY8QssLhwZpg2dfpcYGMR3sRwR1QEJrPlRrhGw35eH2ELfptGm/A0wjROPhMxEhY1i7sGH
	JB2Mlp3c8CvZUz3OrGJwNfjpafBQ1NF0MgP4oBI6DgI0G6xuRG2nNekABzifHjYosXkKIpHfReD
	bQkks2trFmst1T3s8HjQH8reOB/Y9wX86PystL287SONFygNmkXBNQlJUXKK7IwiyXnSR8lTcSJ
	e9X1gx67yovEdwd+VSGeLj62q2eq3fJm3kqnyICJk5XYM0Ed+pS2fOCbeE5SWHzbuiYraa++nMt
	w/cxu1Po8RC+2X7xBg1YFPtChA8i7GgMphHKvKJkVj0dSBlD6XwFj8yQaZAjhYOQNXhBbIoNBOT
	O2ws2YfVcTsIGFjt5PEd1LXMaTw9QQguyOmgbM7tjp+ZyG9e71yVzJNJMeYKGvYgxizYMVJVlYm
	i6gBTzlFQYBYqx/gXnlkyYZjRCqFejU0ft1B0+fMd5IrMUGx1RQiGp6Q9+uhJsfXQ6c+PdzCjTK
	6snXwwvWAbj5F6j686JRex/W/Ti4G3H1r6qfurO8LSwfHjTzqiCOvZaQV1PjBayIwGF96s0sgfW
	GffhvT3k+swKo2bMnOyyk6g7LLpKII9+5FBKFOzUJIccZPd24z5LHQlYBPnUbxoSRN1AOUQIzdi
	gD9ZR9O/s=
X-Received: by 2002:a17:907:7293:b0:ba5:9407:92 with SMTP id a640c23a62f3a-ba594070b7cmr616041366b.4.1776766048956;
        Tue, 21 Apr 2026 03:07:28 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (238.77.147.34.bc.googleusercontent.com. [34.147.77.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4550468d6sm428078766b.52.2026.04.21.03.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:07:28 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2 3/4] iio: magnetometer: ak8975: change 'u8*' to 'u8 *' in cast
Date: Tue, 21 Apr 2026 10:07:21 +0000
Message-ID: <20260421100722.1296-4-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421100722.1296-1-joshua.crofts1@gmail.com>
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change 'u8*' cast to 'u8 *' as the former triggers a checkpatch error.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 7c37faaa4d9..d0d95d3914a 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -760,9 +760,10 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	if (ret)
 		goto exit;
 
-	ret = i2c_smbus_read_i2c_block_data_or_emulated(
-			client, def->data_regs[index],
-			sizeof(rval), (u8*)&rval);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
+							def->data_regs[index],
+							sizeof(rval),
+							(u8 *)&rval);
 	if (ret < 0)
 		goto exit;
 
-- 
2.47.3

