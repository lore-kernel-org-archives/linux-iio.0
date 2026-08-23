Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84FC25782D
	for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 04:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787458996; cv=none; b=JhmKtoEtZXsHIr8WrMfQ6fLyh0DRnFWvSK2jNtZBh3FxS29I+7ZCF0ZI+txyJYHjM0m57Nz8n2c3tZShyo01j7/J1OQJBd8YxYHoMY9cBoVWjB6Ox+sJcUIYYucNhBj9dGawiFrewZP2hdcMh525IsHT8D/ceFS/szPsAVosDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787458996; c=relaxed/simple;
	bh=3jbqfX+LJOE4LgDFWxvC9cPEHh0UYZ2oUg18IBwNNko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=et+rJFDKxEg9jOunNjt+9KYsxyIJ+/CrieK4AQLaxYqYbNisNnysMiwgQN6XGE2Naf+WxkrIUIKoZnferP5VoKuwzD+IyocJkUmFs1NvcPeCK16zingFytcHarymS22ag26Ts8WYjc0EiNUEH++JZC/JUIpqVhV+HjuuQpLc0fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maJ/bE2A; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maJ/bE2A"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso3838769a12.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 21:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787458993; x=1788063793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BIJS2CcWR3cjJ9nUGAUVjeQNXVtGXGh52wi5uvAZF88=;
        b=maJ/bE2Au0BjwS7xBlnhsoj+hAupgqO3Rno6nBuVLrvZhIoEsZ55cRY0EHaqKN+HsM
         I/V2IAc5kW6dHnU9ZNOyxvpsM8hIpammI+oBOHYk6IaUQpsQemHvduTGhrYm3WpBGCmH
         2H5Qf+sDMiDBtUHFT6hP8JqWd93253JR16Zn5KnXvmkiNXm428CeRgVbZ5Zw+WYrgLHx
         GvpyTr+50cf66IoWh9+mbeM01bTcX+B9a2MKA4c3ZXyTuz5LSXT2kvlfv0jFeLbGQk/r
         Aq9igsfqnNsq3mVdodTgRoY6nfV3D8ZBxv968V0vgtRezrQAXy2xdQsCViscsK/BgH1d
         Iv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787458993; x=1788063793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BIJS2CcWR3cjJ9nUGAUVjeQNXVtGXGh52wi5uvAZF88=;
        b=ESL5VrdO46c3bF/EgajwHq9MTJ4blk6CXfjlwxn/IvuLV53kC1nj7co+2wBNT8UgJI
         I10tpJLW603uvSxUcxrQDCgZQbHyYRykVPiBGHjUFVmH1qkQKDkrckRTiebUhRVShJNd
         S9DbDCaemYcHJAETBc15JhR0n49ZqziKZv0o9C7FcgR959cMpMtcn/Absz0WtgIAwLGc
         mxeXFUIJ9AtAc4+b+8Dqzzv8Hf+JufnJbiaToNm8Fy6Wuedsr1aYpww0JOig9+Ynf/cv
         anu38Ty8JZrH1DqDS8wJrrl8c5bNstZ8PZs9FmXforpIthm+JT0JV+wAgHIdyKjw4Rlr
         fVtg==
X-Gm-Message-State: AFuF++nBYXvpr/DPB4N5J6d0pA5yU5xzn8cbCkbsgTz8kS9V79rG6VXe
	7zKKCRGE4TExxKpXKM7/MhwCaU5ostz+aSFn4FVyVdCRSOdOcM0dTsa6
X-Gm-Gg: AR+sD13DCfK0/f7Ivne0Uac71GpQXN2WRDuMf5/WLC0CPFVYFnZuCvBXu1VIWXBSk/p
	UeiIYmotEW8r00S3C0m22U+IcS9o2RH66QRLrFIixa99VIIac6D3v0ztrdIBxtyvTnLYdDm8L0Q
	5jvpTh4GV79N7hzx3Bj6HnMbbhwR8gFemSd79SiadsfkSyt1L/TZ43IpnythX/OLBJ14zZAuJsQ
	32ZcbkDj25JBVuu5uD/7vbEU7YQ3yZJ+Vu1rN1XE9CKW4zhGRaWynNnjwCPHix1dzkCestpSvwh
	OHw99WiKI1A/ENsyKpBfXsjE5r6tye8SQ9Mi8Jp1iFHNm1O+oL+lVLE2n8reBGPOGKlsxlVagiX
	0JbjUBdXpUMZ/5p/lWQIkAyvMdVadOBsefmIIxc7oUcB88+gW8SEgtMNhdnHownG/KqoQA/NmeI
	mM9e3XAIcpWis+8jkrRSVWCSugxLVUVy4xNfUQJKPnl8m7Ma5v37/m4S9MYo2oDEHY8T6pB1B4j
	/M=
X-Received: by 2002:a05:6402:5d2:b0:69a:b38d:403c with SMTP id 4fb4d7f45d1cf-6a42f18f10amr20464229a12.7.1787458992804;
        Sat, 22 Aug 2026 21:23:12 -0700 (PDT)
Received: from localhost.localdomain ([196.235.129.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1d7399sm1615626a12.26.2026.08.22.21.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 21:23:11 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] iio: temperature: tmp117: fix calibbias cache update on I2C write failure
Date: Sun, 23 Aug 2026 05:23:00 +0100
Message-ID: <20260823042300.24308-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calibbias cache (data->calibbias) was updated before the I2C
write to TMP117_REG_TEMP_OFFSET was known to succeed. If the write
failed, the function correctly returned an error, but the driver's
internal cache had already been updated to the new value.

This causes the cache and the actual hardware register to go out of
sync: a subsequent write of the same value would be silently
skipped by the early "if (off == data->calibbias) return 0;" check,
since the cache matches even though the register was never
successfully updated.

Update data->calibbias only after confirming the I2C write
succeeded, so the cache always reflects the actual state of the
device.

Found by code inspection.

Fixes: df041e737a38 ("iio: temperature: add driver support for ti tmp117")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes since v2:
- Fixed formatting around ret assignment and check (Joshua Crofts).
- Mentioned in commit description that the issue was found by code inspection (David Lechner).

 drivers/iio/temperature/tmp117.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 6bc18616ad15..a07028d560ba 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -95,15 +95,20 @@ static int tmp117_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 {
 	struct tmp117_data *data = iio_priv(indio_dev);
 	s16 off;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		off = clamp_t(int, val, S16_MIN, S16_MAX);
 		if (off == data->calibbias)
 			return 0;
+
+		ret = i2c_smbus_write_word_swapped(data->client, TMP117_REG_TEMP_OFFSET, off);
+		if (ret)
+			return ret;
+
 		data->calibbias = off;
-		return i2c_smbus_write_word_swapped(data->client,
-						TMP117_REG_TEMP_OFFSET, off);
+		return 0;
 
 	default:
 		return -EINVAL;
-- 
2.43.0

