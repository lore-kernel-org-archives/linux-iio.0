Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4C3A8733
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288307; cv=none; b=ZQ12Sp/2zTGuQQtf5LS7ya0MOlJrKBahsrt8qoveONWlhTPDOBXTcahe6i4af3i3X2W6oXzkII2vL4Djvk9fW/Om4zaxRlfofWC0xooDMhbGDI180IrU7/Y+IbX60pD6QdM6pABt5Gzf+k6TkdKxq6lnq8JPtE2addta+dCAqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288307; c=relaxed/simple;
	bh=ySxi/Mn8Fix5kKo/2W/6bJG6HK/Mzx5jqEG4YxuqbGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JcG9w0vaa4P03bJ5eFT2DGWGoKWPuOtY2+5wdSZ8AaDmU0SVu+CwTMAazgH13+uRi+URS62EXi0JpzAKSt8uCGTQEIeHoTF9aKdAIQtwvbK51so5y7XFr6E2amfFZhC7r5Qw6jdXRJAAMMZ7xS8fOC9+T14NqGbFWzCCxY+6/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhbLlgPA; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhbLlgPA"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso6777937a91.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777288304; x=1777893104; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K08Zq0UVM8TVhDNWvLc1RrJwIwugZ3qdN02ICKjF00g=;
        b=HhbLlgPAtDUHSqDF29vlfrlMAFh9kgnS0tbXzEHYJ4XHmuwl9i6ptvgXZmQ/2PB6+q
         prB9XXFeHHlKIn3Ya+S9YDzI/Wj2knRKVnA5J+2IHQf7P1N+x3sGQCDcz7wpU53b/oF7
         46px5gxZF7iYjle1CYfm+t1vKqnK/erE0CJncBCazRsv0khthwXHwJTuTKSdSDKTcnvZ
         x+YxDx9nE03GlGvIxEBzonSI7qdkNzDoVTGGnRyiyM+D83gb7HVj3E86n0LARULgeRtF
         njmzSS/b6f/XnepGldhgmuXD/gslyLjT50OidG7VYFyLND+x7CKKcziNABCiwN3jbZuu
         lmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777288304; x=1777893104;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K08Zq0UVM8TVhDNWvLc1RrJwIwugZ3qdN02ICKjF00g=;
        b=FF2/xNHssAo5h1SJywGWMU1fzoHV8n11+EnKlAqPmJ6qNzsAG4MfK/ZyKNFHIqM/r2
         xc5MQbYbtFpRlbqB9Sh+PXXR2Cber9EiiIofij0lZ4ki3j2lxFqIQVJcS2pFLpm5Uejm
         hE98j4Jy2Tnbu6KcESYYvSEzGQGl0Cr+o4UZtuJy2KJgCfD8j6hm9/Y6daQ/Gib3+vdl
         mLtrwOcmhk//CfQp6mys/NYtJ3BJA+RYpKKXClCkee+T4MegAR4KA1P8pjiCMi2u0gtI
         fMM0FmP/4roSocu7Ra0OIlbhXhsXkmPbVoNcONy6VSPf1UCNND24gYiXw+RkeRW3k4Vx
         dx4A==
X-Gm-Message-State: AOJu0YwbrfPHAsMHjLbFuSYTIRo1ueMwFUg6kJWRIfO6kdhnBDAcNOr1
	6zTtnsSBU8TQlQTrbld8HUfrOVuX9ca6QWa+LgKe0yqeloKFAI9hb3/9xgNoeA==
X-Gm-Gg: AeBDiev7ngpUi/1tx7VodYccYxWzZ95ZlX/m7GHYrkjOv9gdxqMO1GFCl461lfOWOcZ
	wMSx7BDsSsCA6zVnIHWPZb81bLaLhfMLQVFHURXpFX5XK6WRab93pnhFY6aEBOS4HBFdOxc/ODS
	HGSsNYLdjFNtQtmGsWiTKB4KTgtBOLwt1JVCMEPTvrX2L+5biqDAkXBjoKEabjAYWtqYZDD9kpa
	W9bDgwyd6BYn8wR6tWG3OSH1SJSZh8sMil79hY9ZMIBde4FtTDxF7HgNVMqx9NqQnKxKjC5Wcea
	gSNLSdjZLUncGpu2bmLo7MNAfcLYxfNmpuTOf802b0SVK5wTUMSQWUMwngMHUYBbHCbkezHyHwh
	nkp5VnM5YoKOJFYS+yrgbLQ5EvCxtnb+DHadHDkb+i8Tm0Bf0Bz3bl49R1MO/skcJWolfqjKgP1
	C8ANWt76XuhoG517roYOntV1qVw+n4mB+uJWTu85HnMYAY8WBGEp3LbRUEH53Yo0Y5dG8Fg6y9r
	1RrhDfvD0XB8s9Q376GDJuHp6lXhLkQsPSizqTbeQ==
X-Received: by 2002:a17:90b:2fc4:b0:35b:e51a:ec77 with SMTP id 98e67ed59e1d1-3614046cd62mr40648962a91.16.1777288303668;
        Mon, 27 Apr 2026 04:11:43 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36471fa688fsm1990016a91.4.2026.04.27.04.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 04:11:43 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 27 Apr 2026 19:11:39 +0800
Subject: [PATCH] iio: buffer: hw-consumer: free scan_mask on buffer release
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-iio_buf-v1-1-2bbdac844647@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGpE72kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNz3czM/Pik0jRdAxNTyyTjtETjlFQLJaDqgqLUtMwKsEnRsbW1AOk
 oQDlZAAAA
X-Change-ID: 20260427-iio_buf-0459b3fa3de8
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777288301; l=1408;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=ySxi/Mn8Fix5kKo/2W/6bJG6HK/Mzx5jqEG4YxuqbGI=;
 b=tUiVgbQfuDwKz55HhdbhNA6cMTkWuwxxQLOe1/osLDaVRF9pFwQCNp68uCvFNlu98deBTzrjg
 +wnhQTTK/7gASukY4ON3Udx8SQvg9ryaVM3YvzeoN0HrzWFPCNp3b06
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The scan_mask lifetime changed in commit 9a2e1233d38c ("iio: buffer:
hw-consumer: remove redundant scan_mask flexible array").

Before that change, the scan mask storage was embedded in struct
hw_consumer_buffer, so iio_hw_buf_release() could free the whole
allocation with a single kfree(hw_buf).

That commit moved the scan mask to a separate bitmap_zalloc() allocation
stored in buffer.scan_mask, but left iio_hw_buf_release() unchanged.

Free the scan mask in iio_hw_buf_release() before freeing the buffer
wrapper.

Fixes: 9a2e1233d38c ("iio: buffer: hw-consumer: remove redundant scan_mask flexible array")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 24d7df603760..d1ab2cbf8c88 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -40,6 +40,8 @@ static void iio_hw_buf_release(struct iio_buffer *buffer)
 {
 	struct hw_consumer_buffer *hw_buf =
 		iio_buffer_to_hw_consumer_buffer(buffer);
+
+	bitmap_free(buffer->scan_mask);
 	kfree(hw_buf);
 }
 

---
base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
change-id: 20260427-iio_buf-0459b3fa3de8

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

