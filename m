Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CEE430B91
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772309044; cv=none; b=qdBJpOAOKx5eYWjewpyV1QXwTUQ5NNJdKTxUUf0h6cFV8ATbEpOIWjvMT8sQH6+kRf4eFIbsJWBvN4SVe2Kynv/GmUlF5KXuWWhOEUx3o7PbC3aJg4H6tlhAJiDcDxPrmu2V94BAylCi/l9cENb/zxwBFdj7Bp/S8BbCiEfFJok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772309044; c=relaxed/simple;
	bh=Tml8NSuUzi1rxzSKD4vwjG6v9vlm4oP2bm1Xe5cL5IA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q6OwfGD+qK49cmN0N3G9vA1BXvDQyN8MB1R8QZhks5ENIARcrlUkj4l8bHqHAgMOthazPRsEDQgkrDnTykbVtht0uLexQMpYVoY9RqUS5sMHEBpWCSiJJ0fTW05NbClQfDWmUjKyq/RaukIwSP3iTrPJLZANog+apPX9G14Yi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gwHIghQV; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gwHIghQV"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-463a94f8475so2611512b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 12:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772309041; x=1772913841; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j/zft2uTLV6nJnLwPmbv0LSJma9hhFD05ECXQxkCKDw=;
        b=gwHIghQVws6mRYZyVw4VWdrX4D4jr0dKTFXDfOVA53X/p45U1nNEBCVgNS29W5wej7
         HVPrAPR9PQsnc9oymHubkB+5mnV+3HAd7m771Dg/ljpyJ726UCA4LS+hfMH8yVqnmBtB
         R1awszPuW2qkXDL/DDnu9wnY+u+ZG4MwPdZ9vRBtPfjjKPprdlM53meA4QFOCAytSpMY
         IBlJcwcY5CCxgySKvr3TW5H8utNEe/MouVlCcoGdNs00MFeF3LcWDwUuwiz+11kmlVOn
         l7Gp0C1s1klO/2H/eArbc1laTAn1ybhJXntw6O6MqdLWKerz1P/6bISTclmHWZSrwmPE
         tMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772309041; x=1772913841;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/zft2uTLV6nJnLwPmbv0LSJma9hhFD05ECXQxkCKDw=;
        b=H5lHnfEBEMLJvUM1/l03lTgRxZ0Ka4Ui84g9ZE3fqV05W9mND3fs6gbA3dWCejMPsr
         dIg8yHLjY+NZc+m1G5yP3UOEHLafjzvAtTnX2tGJfS/cLoE4LOH4pkb/vZ+6HE/adMl8
         ZqI8LW0mDvbeqrOlFxBxUl2c5URAOgUMgm6J/NO5gil8NsUP/4PFaUfKLNZMpz8uQ+3z
         xjcW5cpsk0hgCOtDUv36dut82jxgRK3Y2KJfXvEIS1CmK1fRP28N8OFRLNMD7u2IyBmv
         FqLqP0jFK+1RTcSTs+emFybtLxBVnPhmLJxpL1HMBttcos01nio/L4kVE3U1PPONOxAP
         Bi/A==
X-Gm-Message-State: AOJu0YyOg5AgAr0cLRtoX4iT7yR4sA8v5s14nyH7xLhYG3PJc6s5tgEG
	XSPWDXZe81tWPswczWIKLEc3rJaW9bFhf0GhdPxmNNt9q4lhVqoBwFJliY9ZfWU+Dm4=
X-Gm-Gg: ATEYQzy8e5V2zkeSu5y5Md+5B73JylTtTXOTMV/wRuUlhCVxKjiFkW/gkC/VwnEu5fH
	aoP+CBixH7rDPiwYY3ykflv6wdDrO6VI5Zglr5fPh5X1KQR9jMRVmMVvt5sS8NnXE8eFP8YlSRN
	KkIvwvZrKJYmZbv/PyBpJOvW6fPXz8sLr7OBXjRuH9gWmQcHyPnyJQQ3LYjH4pMmsBneDW6mG6F
	mGcmcTt/C7zjFebLOEVKxYDQTKGctLf7iGGJTvSIJCr4hU3g8KavuBLTOzrPUGSesq0GUD1Jmr1
	bybR7pqr+t4CsPYAX6X3EOJy6TLJZI6CUfcbgIKvuTIS6P9GQFG8a5+T3eyvAwOSvUYYPfo+U5E
	//soKWU9M7t1KzIH0IyziWsGKBRlul1qQKWU8aOgOCz63yyy3A1Ae810h+G8roUFeP4o9QZOL/r
	NABzlBn5xkrH/X/7+knDDTw+vTyKmQ
X-Received: by 2002:a05:6808:170f:b0:45c:7aef:621d with SMTP id 5614622812f47-464a5eab3demr5376938b6e.23.1772309040821;
        Sat, 28 Feb 2026 12:04:00 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d2cf00fsm7579785fac.20.2026.02.28.12.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 12:04:00 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] iio: orientation: hid-sensor-rotation: fix
 quaternion alignment
Date: Sat, 28 Feb 2026 14:02:21 -0600
Message-Id: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7ZhpBUFW3sOwKHWASaAlLSESw
 t2tnMDl+/n//R0iB+EIdbZD4FWieJdAXzKwg3E9o7wTgyZ9J61yFPHYyQcDz2wWNKP0bmK3YFE
 WrbZED9YFpPkcOPVO9atJPEhcfNjOp1X90j+kq0LCvOxI6aqyFd2erdlGaQNfrZ+gOY7jCwlc7
 XTDAAAA
X-Change-ID: 20260214-iio-fix-repeat-alignment-575b2c009e25
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Lixu Zhang <lixu.zhang@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Tml8NSuUzi1rxzSKD4vwjG6v9vlm4oP2bm1Xe5cL5IA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpo0oaPCYrXh9Je6cQGJH9OHltDO9OjDkom0XVf
 qEw9jbcb2WJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaNKGgAKCRDCzCAB/wGP
 wGkJB/41MEvdIRHOjO68oSGJZOLI8NLvmV63HIzlXl/dZqK2JefZ25odqLJHxctd2GyYBFwRFjS
 YfGZgcyFBOScz2ErEv5YZ+EgR6sBUhj36a1bepS5bH8nrolvEsEkfnXc8wJaexMeDLEYLRnZmk+
 7IJ685jfHLhsqn7OtJM6NgmQ2g0caAwRJOYCjW62x610G9ub0lIcokbkcpAeeEzwzd1AJTp3b2A
 Ahgsd5t9p4iK3303V5xh9TmbnlxA6RjtehEpWEPMuyDIKWOBpyuEBTWTIpc2u52y9yVh83oukon
 brLUWeWg92I0aYxNlEIzcTIn4CFzeH8POZ5xIyNlqQ7yGi8L
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The main point of this series is to fix a regression reported in
hid-sensor-rotation where the alignment of the quaternion field in the
data was inadvertently changed from 16 bytes to 8 bytes. This is an
unusually case (one of only 2 in the kernel) where the .repeat field of
struct iio_scan_type is used and we have such a requirement. (The other
case uses u16 instead of u32, so it wasn't affected.)

To make the reason for the alignment more explicit to future readers,
we introduce a new macro, IIO_DECLARE_QUATERNION(), to declare the
array with proper alignment. This is meant to follow the pattern of
the similar IIO_DECLARE_BUFFER_WITH_TS() macro.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Rename IIO_DECLARE_REPEATED_ELEMENT() to IIO_DECLARE_QUATERNION().
- Link to v1: https://lore.kernel.org/r/20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com

---
David Lechner (2):
      iio: add IIO_DECLARE_QUATERNION() macro
      iio: orientation: hid-sensor-rotation: fix quaternion alignment

 drivers/iio/orientation/hid-sensor-rotation.c |  2 +-
 include/linux/iio/iio.h                       | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260214-iio-fix-repeat-alignment-575b2c009e25

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

