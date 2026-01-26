Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310C17736
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769390998; cv=none; b=rGjFki76jEwhqCLzdtYg7bhdoKPRz9KsxhpC7K/ln2nCqM/USzieqKem3R/ILGPk+SawAaLSL3WtspK13Qegk5f8oU6ftV9G9T7uDM+LQSutelo40zzbRgofDSjhd+mEAKx5lJqK/xDI6a4jcmFyGdGVB+RG+R5S6upMWgvaqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769390998; c=relaxed/simple;
	bh=MS9YqVJ1t3sphEVL27nIRnA6q3zwr4ViVe0zpRvavmg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=chjbayMed/qfzugK8dw/XnnjC6jqCo19i1lOYbBYjnL74+j6v7Yqd/PfrlzcumdXQl8m2jSKCmOpCzgdT76jTTek7cX3Yp9yyxGnEibP2r6vUAJomutvyntT6Rh1oaJCzcowemAd1tQNpzshj6VdBl3Km9DP8XuYRQMYTXKpvWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoPCOPOm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoPCOPOm"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c613a0ca52dso2251395a12.3
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 17:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769390996; x=1769995796; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mYrNczo98zZ1oh2WwPTAQz02YYW6IaFFH9AxrDCmqsQ=;
        b=EoPCOPOmdhTD6P7Mjy2ZFl3JOgKheWMcb3g/IW9Bq5V534PqEc1u3xgw0zzXEBI9Hb
         YLC15lyqgj94NHxj29+AxolC1I2L8u26CY6XLjxClpKk9EjxruuDiAeW5zFuX22eJ197
         nZFywBzK/Ex+clWCStvjBCH4zkSI8/qjr7AzICA6lb2EEOsuo2x1aUDyAuIO2wNrLlXZ
         DGIlaUBolsKGM4+lhDeJH8RZSRqU1iga5UVYPB68jg5nsJ0EBtxn1RHpulTb9XfkAUk7
         5TEmRqy67UeAlTJ4+Dc55qtzYfK8g9n0rAadBcWvemMeDnH1VrLMhMqL34UVb6GX/rtQ
         U99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769390996; x=1769995796;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYrNczo98zZ1oh2WwPTAQz02YYW6IaFFH9AxrDCmqsQ=;
        b=o1j/R/MF6LQ1e19glP6/fl/9wP9ONWfyaJz2iqdIQM6guWnYCtMdN2/ah/64F10DSI
         n9Q9Bm9QzrEOYE4+wVHOvn1HefnI8/2UbXgr3yRB1bBc0T9nhE7CQfPybbASMr5yzf++
         EPI6NHHoOZY7bv/fWExbiDV48SOH2YWrqRlNQEvPn1XpUDb417PKd4o4iFbSxju9wsx6
         3tG4YPaE1Ep9bVaRKs1/cpCu7Toq/VSAzgHP4MJZAlrJakeQg9sCEARoDIyuAGg86OL4
         4dhY91x4FuSOlT3WgGtcrLXqD3IiC80xstduyI565M2wT8I49ud8VV2rrsBHHxW7SoWu
         38xA==
X-Forwarded-Encrypted: i=1; AJvYcCUK/NRwj8ar9mKN2XuLQ0KCTWYn6pCD7H8VDaDyrkRj2yr+9CvZNMMIRdFHAPZR7JP9t+hsTgK0xAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfIshNCEIdoFmWc9P7iVbNav34zCK7F0fVWoAOR3XdorHIgsvk
	Mu0S0wspCCWQ+nADUHl7PZEPpyYZJ8X36VRzJTiR8L3DRBywT661XUl7
X-Gm-Gg: AZuq6aJ7RUGUJkRA1dHAVrczG8rIbEf9y+eMqh3WTtbjjSOU/wObjOcJ0DkX46QDhDg
	+FaW95GZ2HAawdBI2Q3f7M/jfhWlj/CuS+RJTqbjdSYGmghcHuZHqRx+6xYYaxS4byc/HaMfz61
	H/hmqDC4Of8vCdAab/7EMTksY61p0rMuC6zUvDzj3NY25Jx5BlL05DIzNOqUBzCqU+lvVQ8OmJ6
	aKLMZIBPXszgIaQRVtTO9LbmlITyerM/ndpFgAHa6DlkXF2eOz5Pzf4p7mC+nsdVOeFVaTk7FLA
	5bkY8FW0wGoGUM3WKwg6O897LPBwnMWBZ4w3X/V3obzgELKvB2zTP53BKVZrFqMOLh++sfAfH0o
	EDprtRxUeL8nqfPZle36LDIaj54s7PJJdKFslbwSmCIREPO+0uVGNP5VKPOusM2o2W8Hhl4Nafq
	WabnE0SF7CkfyFTske2L13GOLu6CmYJ0kUnSPKw+bhcyDdZC/PuD8=
X-Received: by 2002:a05:6a21:2e18:b0:366:5d1a:c737 with SMTP id adf61e73a8af0-38e9f14efa5mr2293253637.16.1769390995922;
        Sun, 25 Jan 2026 17:29:55 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a1309dfsm7010359a12.6.2026.01.25.17.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 17:29:55 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v3 0/2] iio: adc: ltc2309: add support driver for ltc2305
Date: Mon, 26 Jan 2026 09:29:40 +0800
Message-Id: <20260126-add_ltc2305_driver-v3-0-951349a87f97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAITDdmkC/33NTQqDMBCG4atI1k1JJmpsV71HKZLmRwfUlERCi
 3j3RlcuSpfvB/PMQqINaCO5FgsJNmFEP+UQp4LoXk2dpWhyE2BQcQBBlTHtMGsQrGpNwGQDldA
 4deE1f2pJ8uErWIfvHb0/cvcYZx8++4/Et/Uvlzhl1DjFGpDO1MBu3ahwOGs/ko1LcCTKnwRkg
 tXcyUa7slLiSKzr+gWQPPnU9wAAAA==
X-Change-ID: 20251223-add_ltc2305_driver-728fa9161bc7
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=MS9YqVJ1t3sphEVL27nIRnA6q3zwr4ViVe0zpRvavmg=;
 b=owGbwMvMwMW4tNlpO2fYkUbG02pJDJllhydE6N07wNqnnzpzt28Y04yAhaEyao93TBE+v8zJT
 mLNs55bnYzGLAyMXAyyYoosJ+WO9aY8j/hpeGzFdJhBrEwgUxi4OAVgIta67P9LDjfHzHt+4Lpq
 V2WL+gcDNqY3OtLXE9uENYt2L/t5NGmZqm+kKZuR9FOJhyvu655MLONanGV77vS8V+fOfHNV/qe
 d+qTHzXTRWSetLanlFS0tQX4pJ2N6Iy6FMvc66v52NhRxdXAX19bcI7d+hu+jTe5NHOm+7T+alq
 vFxLxYsC2tTPHFql6jOZNij844ePz6Zq6789VfNJSv2fEvqaQiumSS/t+PAp2cE0XfP47xXm912
 vAC/8ptejPbonZc1UhqjeZ2k6k62Wi3aC1fZ17KRr95xo0lssvPmEV5VQTGxzhxztONfK4p08Gr
 eT1jTZtTz/ZVO9m9xD/mSIo4sPgsnPNErSplj52Wc9QVAA==
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

The series add support for ltc2305 controller from 
Linear Technology Corporation(lltc).
This is low noise, low power, 2 channels 12-bit successive
approximation ADCs.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v3:
- Modify ltc2305 channel mask to compatible ltc2309.
- Link to v2: https://lore.kernel.org/r/20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com

Changes in v2:
- Reordered chip descriptions and code from low to high order.
- Renamed chip info structure to use ltc2309 driver prefix.
- Switched to i2c_get_match_data().
- Removed unused variables.
- Added chip info to i2c_device_id table.
- Link to v1: https://lore.kernel.org/r/20251223-add_ltc2305_driver-v1-0-dfa0827fd620@gmail.com

---
Kyle Hsieh (2):
      dt-bindings: adc: ltc2497: add support for ltc2305
      iio: adc: ltc2309: add support for ltc2305

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |  7 ++++
 drivers/iio/adc/ltc2309.c                          | 48 +++++++++++++++++++---
 2 files changed, 50 insertions(+), 5 deletions(-)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251223-add_ltc2305_driver-728fa9161bc7

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>

