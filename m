Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348C2E738D
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359780; cv=none; b=mEpDmJyd1KT3gcvuCNiQ+Zv8MjNqT4htymr7RjdkyKuSXpSNcoD19NSocgnTYiGR05CgXQrdJLzU3qDGpoJPf1eIgQ1bOjjWd8dYdY4WyErEHnRdA3H3scLooMf3I6ymGIkGwAy4YFYaTSIDqLsX7EdIWfY4Z8LCY84imWUOy68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359780; c=relaxed/simple;
	bh=DiZtnae8GaRwNlIJox8oO2achnBh0mLin7iBy86DhtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DpgBzgWxaTRlSeHhPFXm2/AjM1ru+OEFWkZNsbJAg/wVracfs48gzb/Bl3GUNuFcA57FpmmZx947TB3dvJaw7IePRzQlkikDNe747O38eDATUBKggxUza209AvCmd8IpsYVz0qTW63CFdIaIlynec3R2nZ0L6rBAa1F2v93Zzok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5s9gPt3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5s9gPt3"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso4515673a12.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 17:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787359777; x=1787964577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPUnz8OFDYXe3Sf5t4pEZ2F4toWxVvBDHTXITsiNgFk=;
        b=G5s9gPt38lh93h2DHAwFH8lupM4QLRSn1pgh7/VZYf/ESBLBn5cL+KtUgD6drRaoe8
         9swWTaKyukQCmTHY9SQTziR75V1VXKpidgFFwbOt9OTCBVgAT9O66x1wpLM74eVjKdOc
         xiYBkvhf9yoJSO1DuGTR/gxqM6+wI3azXQJq7QyLTiwp26KBMESFNExEi3F/d05P94WD
         R0F9m47bPQwZ3h8lLyv72GBHVxf3XzPeZ64aD2r3n5aUrdXEfCkpZxyEVHfUO5JuMvrg
         ZWwB5CB9Uzn2dXaXOpCfGrhZS8a3n55Y5BLMNxIl/hEafLUCcHoBylHsAxMRPCfh5XK3
         94Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787359777; x=1787964577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPUnz8OFDYXe3Sf5t4pEZ2F4toWxVvBDHTXITsiNgFk=;
        b=NsGL3CDFw1iX87k0kL/MVMgF4WiduJjQx9fvHRUWUzqII32C7VATyr62GKGafaykJY
         50SbQ0kibgRRejrTddZYgCPZltD530QIdZd7SQRjnDKlpnRM9s6JTNvJpZu32zUHV0m8
         hfD/cOaWiO9/mdL/SztayLvWNGl310PVUjoXRsbirCSKjaCSl8NcvaQvsZBZTvcprEd4
         REVC3XSZuQSlZ+wQDfBwQGFMXeN4TjOnLoJi8rqgl8vyvZQjVg3/zb4N7jPT7+uUEtk+
         6fqVNArdnCTkQoG1lsgTWXfDIF5PbzvhHDwTg5Xs4lp2wHgZGfgUVkdck7lEGYy9ABRH
         c0BQ==
X-Gm-Message-State: AFuF++l1xm2LmcxzwH4EmJU1C2qWwkgZe5gTPStssYAP8yZ0KgbthYUc
	MqNsB8Ecrzomf+pyo7XpQgI88vBdD20nrb4FO3ah57eL9E3qSVtXF1oe5MF0Jg==
X-Gm-Gg: AR+sD11V2zk2cTbJSvYvbWxw6eRfVyAe/IwWa2kg81fXreCqs5vooGqoG9vTr6/ocb5
	QvZSXbg6MvPl8/EDYfN0brS+kzoHeISd08ctXCKZQWMYfXyvCMYals8ZvZyqnnNNvVrVsP5VOBz
	1RRD/sD6HTJNqshHIFWchAhlPiWmwx7aMpa2GMTHVx4DaWx5b7E14V4AjpxAzTCj62Z1rs7/0QU
	Xh3F9xc5OXp0tL7RYoiG8qjW5pZg34aI7tiNCxutFkGmf7Sad9Za5OqNlDG2+Sh3SXSP8NYDUlY
	+0iPzbAzJq5Hr9Ij8zEvXuUIiNQgsqQ6JjUfLJKJ2LYi9smiRp0ao74b0Xc/D07tuFh8KMzt5sB
	7o7WY3gnI/UDKlcIaku4nixpiteEfp7x1TyJeyfQ9EEWeqZZe/XKL2fiuF7te4rzNDxTQ/Fr8Ut
	OjumwzZ38jTyVk9vRw6JFqrL3LdPnD84x/g8DBqjeYeMWkb5yt2Wb1vEx/8++8lh30Oja/tJx+u
	Q==
X-Received: by 2002:a17:907:8dc9:b0:c16:6dac:a008 with SMTP id a640c23a62f3a-c246dc97d69mr876404266b.8.1787359776522;
        Fri, 21 Aug 2026 17:49:36 -0700 (PDT)
Received: from localhost.localdomain ([196.235.229.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629929dsm71104966b.23.2026.08.21.17.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 17:49:35 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: temperature: tmp117: fix calibbias cache update on I2C write failure
Date: Sat, 22 Aug 2026 01:49:28 +0100
Message-ID: <20260822004929.13643-1-salah.triki@gmail.com>
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

Fixes: df041e737a38 ("iio: temperature: add driver support for ti tmp117")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/temperature/tmp117.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 6bc18616ad15..7d74f401bb80 100644
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
+		ret = i2c_smbus_write_word_swapped(data->client, TMP117_REG_TEMP_OFFSET, off);
+
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

