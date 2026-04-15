Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCD338939
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229681; cv=none; b=plmAuABRoOK1ueOm6uXGLC0KFf0GjsGqwyhc9dHD4qQC0R9DeLXTrE4nGt9A3MbAlRK3npP356BkhB4t9lSTmTZAfne148VQ5ICO+msbca0onPAjlBB2HJmXdYyXYJ4XJ3v/xjUvdAPOzRSdJvOmLIc1127yOQfnYeSUDu5Rd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229681; c=relaxed/simple;
	bh=QXrG+TuFDlDz3tXsO9LNxvG3qjS1y8ULhRPOEGUq1hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F2s2Z3D9KbvAqlOEQ6m7riO5IzHEJISNPtjG9r/ogSwE/UguiLmAm3MQloVY0DxcUqPVKNKQVSyUMtaaxYU7lnw4oa6EiNzdzSWGgw1Ygat2/5Uxcl9GtL1s2jyJUPwClz5OlgIr/tnHr5m8GmwAwfrmarHzmSXndU/mS6+yQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhQWAzkY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhQWAzkY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f41fce3e6so1368907b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 22:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776229680; x=1776834480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYy8AAiohTN8C2YtR+3ofOomrQuUpW2DvTjg+vRZlMA=;
        b=IhQWAzkYHO9LfedMZDTQ5zWCw/EUnYGqRzQ6KHjPTEUJoul5VBGBFzC0H+eCnG3pKL
         W5YNvAVh8crz4JeLenhknFXYwPrt8QO7XOyBn0rKpMIphAj9pseMauc1/VJ9FQEajj40
         kYGHGK3uKV/0cRa39j7qoUwT1QKWNQGsS42oRQ9+M08ps2/EgcQJ3WD5ayY/qchugo3n
         b6A54ohApP/IWjDUEowVJZ53pnPpMqkXH4buhLFLWbLoPhLBzIbXCTLPuFv7FVWP4xsM
         cJNX/7Sy8aJ6erHYzEgAKKBIFAYFSyIfjZrtFKgJw1X+ug3KeDlxRUEjwqY/uTVTSAs+
         Izkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229680; x=1776834480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYy8AAiohTN8C2YtR+3ofOomrQuUpW2DvTjg+vRZlMA=;
        b=MnachPyWJjY5NJjpuZePGw8gSPWztSa6J4+NqydWiPn6GNx/6ZO0AmzNNXXuGdPxby
         lOZfDCX3sNh/PWpZvAPrEDY8dSO9QZXkBCIXVpgOgtccdMoO6h2UzztAeCP2nr6kpHFa
         qCbt4VRmep43tJUrkftMcvrJ8eM8WEYLXN71mXR5+ScnGCdlYQi7wDqYirUb33FGKmUn
         S8q3rkxgC+1GKOs6SR22sfjwNyw042Z6mTvHlmUKOFcKqe1VEPrSP/hNX//IZrpjg5i2
         NPEsRrclOXxndg4iqKMhYHjS8CRSkvKG/YyFI6v7422q1S5w8hQ4qlcoI4yZ/mkpFq94
         HkzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1hC4W3le8IxBx5wvzTkwdAwLPkuhPJSqpaw0YwUc1rcctX4ijfMqc7R9MtfJGkVoV+nP4FpwtyZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+VTHcu50AOgJD78rEC5vLIQ2oUFq3U/KZUME9zwpk9S/pkisM
	+CIbj5XZR5owYaTlqSdrGXyQhZv/yNutIs1By006odgUS/UnhOv5R1zM
X-Gm-Gg: AeBDiesm4ZpKr607ve6mEOO5TDFpIirr+y4oiNCnnzNbcux53TBgAtjG200cLu+RWIF
	F4FJ4Vc40DeN7eGO8/6a/1UKMMOqSjmuUTxGWTsmAX2URPrA22X8RrAgTfTsz6wqG3OIcUBA0jX
	tZsEhoko5wbtKW6ZFZ0YjFGauiQ7tOlTLUoi96M7Lj1tMCbjiCki6gwv2GOG5WT2568OE4UyRDG
	TfLhWhEWIcGZzCgtn5VsW8DyGbgSQNaF2mv3ZAbyvquMqwcOZ+FxCw1XMxIG1nj0drhhXI0UaEn
	jcRnsaQsZ4LVUXdPAl7nea7ySmvxwKWeLkwLkJT9wIQmKo7tZP4DxkZqRIBpVmXIIqVLV2TaEHL
	XnAqBylejeEEfxhnnT8XJ0BD/cFe6rKdCEgdy6lV5K5o6qdbkzLqKKwSc0C2MnmDdRIYp8Gz1H9
	RJ+R8JUb7ZBOw1tH3ZftUuOz9XowTw21M0HT18Ekn8akg3xZlat//zBQ3DVEE=
X-Received: by 2002:a05:6a00:140f:b0:82c:dd31:b844 with SMTP id d2e1a72fcca58-82f0c316a23mr20393930b3a.40.1776229680042;
        Tue, 14 Apr 2026 22:08:00 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67469dc3sm763706b3a.58.2026.04.14.22.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:07:59 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/7] iio: ssp_sensors: cleanup codestyle warning
Date: Wed, 15 Apr 2026 10:37:43 +0530
Message-Id: <20260415050749.3858046-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415050749.3858046-1-sanjayembedded@gmail.com>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/common/ssp_sensors/ssp_spi.c

WARNING: Prefer __packed over __attribute__((__packed__))
+} __attribute__((__packed__));

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 6c81c0385fb5..8c1e15d61db7 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -29,7 +29,7 @@ struct ssp_msg_header {
 	__le16 length;
 	__le16 options;
 	__le32 data;
-} __attribute__((__packed__));
+} __packed;
 
 struct ssp_msg {
 	u16 length;
-- 
2.34.1

