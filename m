Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1248BD5C
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002502; cv=none; b=aNuCrjm0Fl4MtPnYaRIEqV3z4sUzK+hBv1atbiUOjgXNiB61vRGFoyMCzF98EieSfrc1BalMN3Dc3LgwBDDnNSWboxIff0CkLjgxqLI77IFZaK0LHWA4t9/NyXEy1fcLIxwiIYguJ4PafFPQpsVKeUQQiiivmKChUs6snA840hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002502; c=relaxed/simple;
	bh=edBtExnt/8Z64dbOcPerVqZrRBJ+N7vMF3UZXd8IC2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VlFAXsnyUQEQ/azBxN/niogY0U3PoZm5VutNzrcrBoquhFeOW3BmesPnIskW5QzY2JlJjT14U3o3WbITyaoGbdOl3BAKltO9IgowCHOgaFc1qoEBNHp3TgWetZAYq0b2OYvijXyRLlHVB+zyAgcYjvmBB0qjVphSbWH7B/6kDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGqabq67; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGqabq67"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d73352cf2so5054627f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002499; x=1778607299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pL+cn2XdiJz7sJ1VmFg0Jy0AOXBj9195E1nbspZlGtU=;
        b=BGqabq67SmRMnVfGcnQ0ibH6ceUY4riiUHkGzgMG5/Jqc9HZHDaqLMqhuNxayxYq0r
         9H1GzfBcTZlqOg0NQjM6vdfnDbCaEs16UExFlJQyFrj4IIgdeUFSY6IdugNIDMe1gRc1
         /+Fo//g3glp/xJ65gKVOmusun6yGxICQgQIAawD5GcS4dVXOQS8a2cLzkDKZ9KUQEx0R
         WRTtbbjWmUTZ982yH4kkSLRblcVKnDYYBkUZ8nzPyPwJUAW56FHbqlFwC+YDFWa0aAZX
         EIxFICKRdT2iMNiBmTmha8Ec2HEq+i0SpXsiMdb+1tBxeGW9uKXP8DBGls/4W1BnGxvT
         Z7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002499; x=1778607299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL+cn2XdiJz7sJ1VmFg0Jy0AOXBj9195E1nbspZlGtU=;
        b=WMUMgoE3UxsDlf40qVOBfX51TZZcpT2ZSzmgonT+Obtp7eiqHSjUDryJxsJxDChe0f
         S+67WkpxJy2uLSpx+sHEOz8uJBjB1eN3Kexy+Qi/LIiMAnBWbO1tN9w9WG1iMdr5p9nL
         E1nc3ZSTRXeD+pEJQspTojCMwAjn5vIB55uDmvoV6pZEyBH6cMQFFpkL+480+AgfdMrZ
         ZC/BXhJTjJfSgyTORoU1BbfZK7tWt1Pe2qECnPLvUjHBzu7DE2IiHlmXW0YhZnXstCLe
         lVvoJ12eeYYkWMiNvctmf3hV52aOdL7HJ0qy6prp4Il7/yu8KPKxY2TA9fVihP7CjRZi
         eJdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fFR65t0Xvv3hBT/d2IeIaEp+33mFLFzCzqHCwMJF7mDkcEYdkjnQ1cWCMBDMHPj0KxTnomL2guh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMOEyaG5+rs9UGaNJDr24mmsYMf+o11CPihqU8s7F6MBayqMEG
	01qruZ7WzQRfRPmO3m/hgZwYdi5id/phEijBdig9cIeMhqctxtF7T2sR
X-Gm-Gg: AeBDiettZWcwRaY7KepDeNc9Rdbd3/d1q6vi3jNcjUZgY1NSVyGrgAoRNWP1KfuaVIF
	9t3jacg5SEA/Gy2AQbHQ38G1k0lfdcTIPr8MDIWETNHMoEyOJqcmAf3onOzlOuwpgqXG7LbtUis
	C0NwrCfdHef9oO/5KxyIwMuMK/zZ95hXp0B7WtQ4RhWoujfY53c+vWGHu6UREnj35ZWVaVDZzjy
	ip03cZwIHTi/+3vaLHIXHhil9EQtRH32Cx2YUaT5SQ0AdmxaH1DtlW3alfbZojLOLCh/Y9u6Gzs
	ra3HnZ3ArGHKU/zUgMIC8orjnXMQvAtdVtEA/ZaMwiyvhwcSFGFHpUoo2zNTvX3D6pTOFlmFBxd
	4Iq2I3A0NrAIgETM/M/6iN2fXnN/dDM79oHXwFHjbUhsg574RNFkkm9Wi9ipecaRR48WPxrLBDT
	QrLdpcX3vqwDzBrnBcBKfUU7aq1QZXbGI64818z2EEk7JagQ+6zfb6HUf0BsVNe1QKgQdNvHimT
	ha0P3hOMQWv2r1+5QPcTa6+d0AJbySs
X-Received: by 2002:a05:6000:3110:b0:44a:8880:ffd2 with SMTP id ffacd0b85a97d-4515b056b8fmr119815f8f.4.1778002499107;
        Tue, 05 May 2026 10:34:59 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a4878fsm5856560f8f.9.2026.05.05.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:34:58 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] iio: pressure: bmp280: zero-init bmp580 trigger handler buffer
Date: Tue,  5 May 2026 18:34:55 +0100
Message-ID: <20260505173455.181358-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bmp580_trigger_handler() builds an on-stack scan buffer containing
two __le32 fields and an aligned_s64 timestamp, and pushes it to
userspace via iio_push_to_buffers_with_ts(). However, only the low
3 bytes of each __le32 field are populated by the device data:

	memcpy(&buffer.comp_press, &data->buf[3], 3);
	memcpy(&buffer.comp_temp,  &data->buf[0], 3);

The high byte of each field is left uninitialised on the stack.
The bmp580 channels declare storagebits = 32, so the IIO core
transports all four bytes per sample to userspace as part of the
scan element, leaking two bytes of kernel stack per scan.

Zero-initialise the buffer before populating it, mirroring the fix
applied to bme280_trigger_handler() in commit 018f50909e66 ("iio:
bmp280: zero-init buffer").

Fixes: 872c8014e05e ("iio: pressure: bmp280: drop sensor_data array")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f37f20776c89..431476cff883 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -2623,6 +2623,8 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 	} buffer;
 	int ret;
 
+	memset(&buffer, 0, sizeof(buffer));
+
 	guard(mutex)(&data->lock);
 
 	/* Burst read data registers */
-- 
2.53.0

