Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7436C0CE
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778401574; cv=none; b=Mx9YslORhQFvUuF2ZofmF+Su3Q8/0ws0kA8PvUct+WrkioS9p/scGxfb4/1bz0p8Rp4smv4dRvhicZmPu5JjqWYqQTllWT2cQXkdJalFAc4Oli1JkThjqv31LOkNhGVCVX0jVzLvkzU6Rnan2FQ8GfmEoZ7IJq/N9NFp35cDW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778401574; c=relaxed/simple;
	bh=TGExzduSRqEUls7gT6JZ0OSGVJ47icyi3qee/j8ADHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0EpMcsWLeo3xTI+WdPrPG2wderulQZHiN3IoMEMeYJxro4GqlQ217B7l5NyJrTrctVMPWRN5PSiOGDSiDdjW+kxrDfOR9BA7ubESKglCB0U9/vEqCp2/pkNnOV+LZbjxvOCjtBIRySQkmIIxy1PT2xo3HobevFixSA28FHZyVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+gQGLLY; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+gQGLLY"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3937014be0cso29585181fa.0
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778401571; x=1779006371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRgfxsKe41w0yP/KdCBLMcT3m1XUAhL+wpDzwCetSfU=;
        b=j+gQGLLY8eQ+WuOl2XXfi6xyfiQpVt+2nxPG1IdXz8Q2hhyTqYm9vUp2uyJVlyhYD5
         dNQAYVCK2Uol7sqDvko1grAi41L/12QzjhKCvhPB1OhWQo5lXLNyt0n8b4tgtNslvhVT
         hVGNT829+uBFIHAB7Rn70urhsCuiHgHhxAtl6+jZXmHEjhwb08IvKW9LuA7oIsyuUq8X
         /8sHF4PqW1Y3vBpb3MprJVX5sa6chu/ANMvblTFcvhMu0OQpaotQLtEs9kEd6D1P+Kjb
         aeQ7Y3AvOzypeZQd8atCS7fnNojGQslEwpmta9BJU+hPfBohCKrUEkMw5ZHN7uTK7zwj
         ANsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778401571; x=1779006371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRgfxsKe41w0yP/KdCBLMcT3m1XUAhL+wpDzwCetSfU=;
        b=XjUnbhb6WKQh75x4xxmNratwFrQaEFKmr3boa+lxGFAzNtLqYW0NjGdgLDXibi4lvH
         6ptIueoG3e1OHGVoEVuLRUjc47s/9yhyelPT60sSxYyV2oVt2pWrlyvA8xKdO9nTIbWt
         BQJoXIcpPMFnldEidcxtj2VRlzWyYESdpSjV5omCue1Ba5czyZ/Px1W8P0KhHGwfwm8L
         fkQmEXUNPTMSi4flvYGVYHq2iNs4oVR/097UpK6Ye6mHbdRdOxvrrD7hzy9nMz9pviaJ
         N6HdBfBVbFDZW5zuTa9XCFwtFxbwOzbPqXK+s5RQzKfn21d5RJPyPCLlIZY/P3ixEkZq
         3c+w==
X-Forwarded-Encrypted: i=1; AFNElJ/s8WPKSCHlk/xZ0s9BRMHeXlIJIElcWpw8PvLDXZEicX5PAfHlkziow58ia4am2izUpYuP0RG76Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Qoy3JonlmpremjEGrz8/QPmV9e4BcUPo8mp8BcBKBV8bnI6+
	6XYeCWkjnikWbALQuKVOdupfiRNgKFV+nvPU6pvTRFlHS0+WfPtd5BWg
X-Gm-Gg: Acq92OFDm2nuIeSK6JnBdiTsqlLmKs88Wfn+xPuOME1kjnieTq8wC4V4sd5OuRIdNDB
	OCHSZlDGGBYzx/2MenNAAYgrk83Yc3nsz/Pigp/TrxZEwUeOu96t9yOdSay7UuvG2IQlR/AFk7R
	Ws7y88wDj6SnDD78Z9C4Z69CFJBqoHkkOy6FSgZi4qrzOJeDwf/cu+1HOo+OY2s2Zjjih1RvF5M
	6cMss1gTidkrFKsWosXp6gLwqHENjghq/BY5BsA5q6ryblMGdN/jXD9ZAyLGQUiiT5z5IP9GMQs
	YsVkOV+36setLM++56Hkk+03tr0mgWUorxlTa69uGSKs85SOp8oA4HcrW4NI9WBTSas/JxCo4R0
	x+RefEo8c9TQ3rlw43djYnd3JIcOQxoesz058DyCpVwDwoCSY/uQUHB0+oaFUd4XVoNfTpXbAED
	1SBc9/6EHG0SUZkAqKSPOJzF/Gr55XM0gTr/3Na0VCvw75tdRarV6/HoSo4/6Pyd2zfgnE9E8DJ
	9w=
X-Received: by 2002:a05:651c:4419:10b0:393:fcd7:5f69 with SMTP id 38308e7fff4ca-393fcd760damr18725831fa.17.1778401571221;
        Sun, 10 May 2026 01:26:11 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4dasm17810681fa.20.2026.05.10.01.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 01:26:10 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 5/5] iio: accel: adxl345: Add timestamp to FIFO data
Date: Sun, 10 May 2026 11:25:56 +0300
Message-ID: <20260510082556.3867-6-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260510082556.3867-1-shofiqtest@gmail.com>
References: <20260510082556.3867-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver pushes FIFO samples using iio_push_to_buffers() which does
not attach a hardware timestamp to the data.  Add a scan buffer struct
with an aligned_s64 timestamp field to struct adxl345_state, capture a
timestamp with iio_get_time_ns() at the start of adxl345_fifo_push(),
and switch the push loop to iio_push_to_buffers_with_timestamp().  The
ADXL345 always scans all three axes together so the scan buffer layout
is fixed.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 6c9080d88c..2b121bed89 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -204,6 +204,10 @@ struct adxl345_state {
 	u32 tap_window_us;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
+	struct {
+		__le16 channels[ADXL345_DIRS];
+		aligned_s64 ts;
+	} scan;
 };
 
 static const struct iio_event_spec adxl345_events[] = {
@@ -1657,6 +1661,7 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 			     int samples)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
+	s64 ts = iio_get_time_ns(indio_dev);
 	int i, ret;
 
 	if (samples <= 0)
@@ -1666,8 +1671,11 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < ADXL345_DIRS * samples; i += ADXL345_DIRS)
-		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+	for (i = 0; i < ADXL345_DIRS * samples; i += ADXL345_DIRS) {
+		memcpy(st->scan.channels, &st->fifo_buf[i],
+		       sizeof(st->scan.channels));
+		iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, ts);
+	}
 
 	return 0;
 }
-- 
2.54.0.windows.1

