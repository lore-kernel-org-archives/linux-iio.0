Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6247CC63
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988275; cv=none; b=GuwCkxmdwfWEAKQ5dfWzTjjaKXRzuMs72/zPEFY3soZzg0f4MyhErlYMllAbY4R/HzMh3O6bS2Tv+sf8MwsQZ48IBAog4PSFanpMELfRzpogSfQYSXCtNO7rcJiDa3nNIJ0Vrvnd2jFAkt2yzKl35COsEN2WuqpdHpnY6SexAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988275; c=relaxed/simple;
	bh=nI482rHAbt5nXbKBqEJDa7o2nSrbcSlgM1ZPd6rpVsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvC4pHjkIZULf8e7NyVpFCjm/wWqb6aUJyae12Ea1TizTEmtY/UX5cZF5UVKX6uW0p55JHr6pml0KAH867H3AWz/HQwWiIgmT7GNko9LZuQFqFgGLqeaCebSzRaySw3qdU/o7yUwWEmP949YHmX2NRQN3XYUbGPMMbw+RSqbG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAh4ZExN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAh4ZExN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso28003445e9.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 06:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777988272; x=1778593072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zqGy9FCxsyto+kn1sLwjo8QRhEdeQTEmwhLR5OXod0=;
        b=nAh4ZExNWY5zSJTf1wuqWZzlvDsn3P98+RtvyT+v2D64+8/f5KhYTaTT1Uxt/Ur+4d
         ZTvfBzCpHUkNlREgCkfs7EjiFHzY0lqaX+ZZmC7YyyYSGRzDqE/0mGf8QpO4Z1V4Q65o
         qPtsLlX76ZNUIN5Ww1jwotx3bh0BtkVh3zl2B8N/dLJF+iHL2gyE24O2us7CJ53rXOkk
         U+GdOwIH8/yyScGd2fz862t0iJTbNqT0SRSqX/MskMpAIFaJTgxp2j0EFOz8QMb9bna4
         GktlV6l/l2kzKiVCJppPij2QsdEOHoLNNO7TD5rSu8Gyu00NOX8KQKVbyBkYjJt/2J8F
         xfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988272; x=1778593072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zqGy9FCxsyto+kn1sLwjo8QRhEdeQTEmwhLR5OXod0=;
        b=K/pCRIqm45FfTGvqebcUAtpfbqYnArMMd9amY4+1JuBzOzB8ILfaiycdu/hVSSX8K7
         ooGdSVU8GYCfDoigAfMqWmzNDV9zleCG8WlpQbQqBKtiEQUIwWm2NkNzL5RrFksnknBg
         41ptmEwWQVrfjXcPHx7kdJUbE6lRNZSztqyW12mnbI9hq8H8HqNYR6KIeKTLMRnWX5u3
         CGKiSXcHoIj9KVwYQ6viPscWCMAxnhofdfbtS0Usyak9W603Dbs8Q8gZiNLaFLlWchyK
         ZHq9KKVcEFeP0Jx31OxRyLp6rl0fkKQLHyzPA3pShPTj9HDV/czpNFKLQmQiBJGROxkV
         0B9Q==
X-Forwarded-Encrypted: i=1; AFNElJ867om8ZlFm7rNaGe7JddQNY/DkSnp8HV+WPdfe2WgcIhCxf2p/9FezUuU/S/PbWGtS0mqmsnxgnV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPcLUpgckrxQQKU9n2TtqzbiKUGZMXED1CcE908aFVdzegQni
	HpOCacurGfw4Mkcyz2V0QHykKsrFc9Xk1TMUhviGSNANm9lUDkjDlTN8
X-Gm-Gg: AeBDievhNdxSHyP/WKQ2wY9NgLVvyaPjGiAC6Nj+avASVbsTLD7vzbbz4SEtbUuhReH
	fsWfcYvN7rHrZwa7SJ/cpSVJNoKHSvMdYdfmw6aLz2iHiMaqrBvsOGmh7v8BkVUUUmgKKfPjVn8
	6O3SQ5DSsYMSctVECQUX78hdO/CB4hrQEArtCVsvv0ST+Wj7gsE6Mysnehxry4r4QvMmVRgPVsA
	45t16p8hzakJB/5Z8Pvx55nvxsOjvtqFG46WURWipj/vHqCvguirsA+gTXBd/A5vDYw/KFRBNMh
	WcoZXKHZjbmN74LTNrEDQpIKAjOU53GcQu0Zmmj/pR0qemjaSE+gky8XHFn408j179Vm0Ef1PnW
	lYQX+qZ6nfUP8r9trTjYD0a6iAJ5eEQ1OkiXRs16tjp3HR6iyHaIR1bldT6dA4OlKNnM6NpO0vv
	WuJcRzTC8819Zs7E/CP83dISGLXeufr/N8ojI6fgLi/LvKSCVnEVcz3n7v5yUYongLnwDLTq+9X
	xrN1FeyLw0KrLk9mnwsfVWZW4iPaC5n
X-Received: by 2002:a05:600c:3596:b0:488:fd7e:1063 with SMTP id 5b1f17b1804b1-48a988cee29mr269575315e9.29.1777988271858;
        Tue, 05 May 2026 06:37:51 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81b99127sm391200295e9.0.2026.05.05.06.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:37:51 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] iio: gyro: itg3200: fix i2c read into the wrong stack location
Date: Tue,  5 May 2026 14:37:48 +0100
Message-ID: <20260505133748.51355-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

itg3200_read_all_channels() takes `__be16 *buf' as a parameter and
fills the i2c_msg destination as `(char *)&buf'. Since `buf' is the
parameter (a pointer), `&buf' is the address of the local pointer
slot on the stack of itg3200_read_all_channels(), not the address
of the caller's scan buffer. The (char *) cast hides the type
mismatch.

i2c_transfer() therefore writes ITG3200_SCAN_ELEMENTS * sizeof(s16)
= 8 bytes into the parameter's stack slot, which is discarded when
the function returns. The caller's scan buffer in
itg3200_trigger_handler() is never written to, so
iio_push_to_buffers_with_timestamp() pushes uninitialised stack
contents to userspace via /dev/iio:deviceX every scan -- both a
functional bug (no actual gyroscope or temperature data is
delivered through the triggered buffer) and an information leak.

The non-buffered read_raw() path is unaffected: it goes through
itg3200_read_reg_s16() which uses `&out' on a local s16 value,
where that is correct.

Drop the spurious `&' so the i2c read writes into the caller's
buffer.

Fixes: 9dbf091da080 ("iio: gyro: Add itg3200")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/iio/gyro/itg3200_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index a624400a239c..0d3a50031d76 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -34,7 +34,7 @@ static int itg3200_read_all_channels(struct i2c_client *i2c, __be16 *buf)
 			.addr = i2c->addr,
 			.flags = i2c->flags | I2C_M_RD,
 			.len = ITG3200_SCAN_ELEMENTS * sizeof(s16),
-			.buf = (char *)&buf,
+			.buf = (char *)buf,
 		},
 	};
 
-- 
2.53.0

