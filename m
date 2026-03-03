Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A746A33DEC8
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545666; cv=none; b=J9oVGFrESzbJNJBWCIg8Ujnkk8jhyu6soilY77qo9F9R6gqCXtUiVoU+ZFrUY627EzpPj1ANpKfdiebCKFAb4I9nLmr3LYQH34TjYDUpC4pZxjJFfa3qBTJRDts7nwE/t134R37OHv07+NNqcsrgIFpwaDoKHPXVk8HIM5GtPGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545666; c=relaxed/simple;
	bh=/p1xCSK5FThphEim6HkaSU/vJIAnaM1raetdYl9rcRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dV1lCgXNRYbfYh0a7A8aeeLUqnKP0bBmdzoHqsZyirfbbULG0Kju1S4ZQ2UUW+KEzcOFH6UXRFQOxGOl+ieR4Fl0hNr7wi+NiEdqet/ASuG4XPTqNs2AkktSxM/jKnPIipk0n9heRGIKkmnl6OcfGsPlG9mtS/YV0MRamAy4gCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV/Sv1VU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV/Sv1VU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae527552acso7776565ad.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 05:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772545664; x=1773150464; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8aa4zaI2ZiY3bWVO4cehbNkJdG5rQzLVFR2soNe+L3o=;
        b=KV/Sv1VUQ18sUVfYaQen8yXlcWyGjzfsYBKoGmbioPuFHprf562Uz3yHwWvVCoSP3D
         H5mJDds8I0axv2lwOv42o8cJ2SwKZBubxNL9+Wy6MM8gKkveyc/F7cTF/ACRMWP/5RQa
         3isDk1eTFD0ZHB+7uKXMS7yaccsceB7EHF06Dr6y8ydFS1VIGsHxsqQVCvYTl0mmdCmx
         KUbo/OScPGN2TQyhpbfYaKqDeqMKPQG9ov4LYXuajIjwHnjRZYMM1b8UIKQTP9QmhwQ7
         YmdyWmzLF+lbpt+WMEtXuhMVecA7LGqXKnrhfAWhf0Flv4XKQCdlbMWyW/ly5bidGCin
         rn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772545664; x=1773150464;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aa4zaI2ZiY3bWVO4cehbNkJdG5rQzLVFR2soNe+L3o=;
        b=JxxOO8arHFDiBOomrufcVL8nWCOEXhNWm68RuYyvGU7hcIm1h/fXkEvjIjmoSKQnmE
         M/dcfMPQkrfjyJ1UCQvpXeHkuTDDNLaxCKr/vWv73Lec5vpbeZs6ojS/ZJovWI09CcmZ
         YWx1O7+10yRfiYuQXQenBqC7QErGAHX/bWsnaKuYahE/E/OSSwJJhvGqOCi+fdK754lm
         TL5lmkgu3WLfDyEpBr+X7F+5Azq4JJkHGIc0kxcpLwN7PWbGZcPRVvtATINxELTsbO/4
         ddgshZ0rH1cvajEJjf/7l6qwOBbg3dRCoJNUig/I3dac6fVb3uXF0F2uF0NdruP2Se4z
         yTBw==
X-Forwarded-Encrypted: i=1; AJvYcCXWxzs9ksU0RvQEMsD4njmNzIgSvUcfnoiZaDMslk39zsykPdymkuyDlAqslj+sKbHQlSRHWOPtyLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWxsXLlQJal7tXUFRQdwjNvYrLJSH2BIh4p7L/Wa92UbOY3hr
	cl6wDD4ZHy3jSNUwfO+5Vlzqa/JaeKogerY9oUH8PYRptiw7Tfz1HIYY
X-Gm-Gg: ATEYQzw9+sFrC8oxJZ43ETlI7aHJ0cMgrbK1siGsYKcdGYUCJg213I69KH4uUavSLdJ
	XfT5reZCJrOohmFfBULdvGRsv02WcXI+N/BFh5ogTOpYO5QCazEE1mYvzNF3rQ9GuT0WHm106PJ
	EuE/jnlRF4GLWDZSYFJrLFpgevfeYl017UXUw3Ay7wQW398EfhB2QDYPzfA4vDRBhO28y5x5Llq
	HZ1y4Fv6Y6Cn/i2XXBFh6IS94Rkrg0A24SIytqQRrZ5hFtEEfCd6e8H3LXx2KH1E4Ct4tK5nIBD
	giV0EzOrGZucdisWrPm47NxaEjVsyINEOawwyL1huWTpcQU+3xk5oUJ/2Y+RMMCS8ZgpVMorD3g
	ATQm3BvNgIPRt5/fxuI6h3g1nUbLK2IUnzoFI1C2qrQQsIJiqwhw7Tu0vmT2c3PX07zkpWHjRYb
	i6Ktdpl4+UEawLrGe5WbMScLIKJcjLyuiooAmgUj36G1+gE6E=
X-Received: by 2002:a17:903:1250:b0:2a7:d42f:7065 with SMTP id d9443c01a7336-2ae2e489fc1mr139637605ad.27.1772545664036;
        Tue, 03 Mar 2026 05:47:44 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:f9d2:c148:3305:e3bf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1b2c5esm101535245ad.6.2026.03.03.05.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:47:43 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 03 Mar 2026 21:47:33 +0800
Subject: [PATCH v2] iio: adc: ti-ads1119: Reinit completion before
 wait_for_completion_timeout()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-ti-ads1119-1-v2-1-3badba8737f3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHTmpmkC/3WMQQqDMBBFryKzbkomERu78h7FRUhGHaimJBJaJ
 Hdv6r6bD+/DewckikwJ7s0BkTInDlsFdWnALXabSbCvDEqqTmqpxc7C+oSIvUDhXGdIO4k3o6E
 qr0gTv8/cY6y8cNpD/Jz1jL/3TyhjHdKTIy9Nb9t2mFfLz6sLK4yllC/Dr+OAqAAAAA==
X-Change-ID: 20260303-ti-ads1119-1-cc68e3c01783
To: Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772545657; l=1115;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=/p1xCSK5FThphEim6HkaSU/vJIAnaM1raetdYl9rcRU=;
 b=+uTxiOyiVuUKuPbAnkyMIQq99eSk0jWaXxVVUL2k1UcVJWna5bfq2sA6fLwrDvSKMa1pmAtHG
 dlpY46hAP47Ad4ytYgWFMf6HOIvmR+4aIxsEl0lYoxkDFV1i7vER7uC
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The completion is not reinit before wait_for_completion_timeout(),
so wait_for_completion_timeout() will return immediately after
the first successful completion.

Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Fix Jonathan's comment.
- Link to v1: https://lore.kernel.org/r/20260303-ti-ads1119-1-v1-1-e3fced089a44@gmail.com
---
 drivers/iio/adc/ti-ads1119.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index c9cedc59cdcd..049cdb108dad 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -280,6 +280,9 @@ static int ads1119_single_conversion(struct ads1119_state *st,
 	if (ret)
 		goto pdown;
 
+	if (st->client->irq)
+		reinit_completion(&st->completion);
+
 	ret = i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
 	if (ret)
 		goto pdown;

---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260303-ti-ads1119-1-cc68e3c01783

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

