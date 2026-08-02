Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD163438B5
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785654775; cv=none; b=Wmu3wXkKtZ7u23vZTkGhh7e500sWi90M3FyYooBzB5n0q7lhfmx12b5n0KV//Giw/ZqhSdsay2hQbGSu83LK2QT47vVzroJIZoQf50vpjaZJI0JZkMqluV3LQPaX3/qxglFVgHDACD0QQdDTodkKme4brb8kIN+WQkUDSFgKK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785654775; c=relaxed/simple;
	bh=T5lHOsgdNKHdvpMQPLi2YhCHxETt7OgdaHUH/4aE+aA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uPKahlYoSLTwLN9l3of9PKxiB4hpHzqGG+uBEwtYTDsdHOEO+JrCgBhu4zf+x3t8CTUGwU50Ov6UcNKj5fwaDpn7FP+JTrr8D8QpjoEDiXxTpJM5LJvr7ljGldha6EpOBp4ISTKYb6H33YMFgoBBIcOVzU9wm7XZOC0P2CT1kBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHKOg9nl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHKOg9nl"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so1753642a12.2
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 00:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785654773; x=1786259573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZPIdTnQh1QKWeUAz+tiT4s3AcWBx4iUakbRHDtSIp1I=;
        b=eHKOg9nlHsH/RKeQf1QlQ25AGMODQxFMlGuvjMST2dmmXm71ddPASakSbvPiNHTfci
         lzdGUWFeIn/5BF1OuYHksO/Ik3Z4jogIG/NxNmWqxFahPRz/bB1U7Ch7oYIoTO+VqFgl
         DelFYfcXCPsJmMXcHC7WUA0l7RxEs8bDgjCWyes/yrC4P7xlENrzFqaF47nYIZFCNjsw
         YgY2SgorkwtycUYCwlWN7Gkt0vPYy98iot/WS5U8aKXJ4TE4LgRFV90qPpfHy6cHLd7i
         A6QyZ+r7V1zhiursIKRYEGqKeQIWBjiTCh/xNCrKHsO2LnJvHUNwgVjxIi8f1YwymEA2
         40/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785654773; x=1786259573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZPIdTnQh1QKWeUAz+tiT4s3AcWBx4iUakbRHDtSIp1I=;
        b=Ijot0uRSnOdVhZfsiLbMGN9F951zBeR+3974+VMNJEj0xLwqpw1AWU8/UOIQQYJ3KJ
         GBk3wWrI5ng9x/Gqt1PT/rygP0mkQTI1pRIhMqPPiW+JWpjxYO/12b+cSf3ZSC4BGoHK
         FQjg5Q87H+ndQVSMtPdHHYO6fEGiWnqdugbCQMDJt79XL5fKfDfkHKAbYu5xskBrb42P
         qOqrVQ9t0AV7FjuDFL1dDcPG6YPoUBpQj3hK2gzTSsrltzJWNMOPt+z2I5pZQ+Qtc8d/
         CC/YVZWqTa1sJ20NdG6KoBRYhOuwn6+3+SIGWm/TB7ZFDBXnyspJWbKBpRwvtu14/4T5
         A+AQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4Bskyj/1WDhCTrPVQc6SVU4SSHxF+avuKB01sXtXMYqzX8zIhQtyh+A4ldMYdctEoct7vu+VcSHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvHQ0KmXzKFy2W9YKfYjiAZu/YKunWRPZITZR619QbzW0K7YD
	2qFBCu/Hi7dKl5cYijLvOLdmqg4GmjCjgXfDsq1zt9hgpeIf1NUSIRiN
X-Gm-Gg: AR+sD12mTUSXMwHWp6BSsqsys7MzWwwA7n8hX8poM6bGwm8zhyIX7MBsc9HFuUch3wy
	QgSA5p9aBipub7uZ2b/bBvmrnzrrvBA3xpTuv+GTus1qHGd0xjZVmF2YzXyI6DFnn9LFDQKZTQn
	yVDWvbdO8KalOVAoQmmGorLPXj+a3hQjfxQFiTRg/5JiVf4PaIeZ0+o0sdQ/aczW/cOooPp6r/x
	4vpWm1pSAPY+noWPkVOIcyCTrKsUPeUC+PdnPmUveYQdRJUBjwOTKoBtiODmk5ko73zJNTE7WzU
	reAbdIRDPaKiWyYSfV3VWFLYWopHiWDP16wsNTK8do0d2pzgLMXVwJVXVia/uevHDayXS7Doz57
	XyIj7fW3X/rP300+w6846poSrSJjlOTfQ+bLz/kQqlzmu2uwGTlk7XE+PmSUbHAFjHi+7sBl/E0
	BLyI+HBfD604zVzR13vL/PKJgowS8kFEIP+oeBjxMhQgol3eB6y6kj0I2HQ5pQQyhrkdT4lTbQN
	ezBtQ==
X-Received: by 2002:a05:6a20:4499:b0:3c3:8de3:8eee with SMTP id adf61e73a8af0-3c92a88ee11mr5685030637.61.1785654773335;
        Sun, 02 Aug 2026 00:12:53 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab050d8csm34288859c88.0.2026.08.02.00.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 00:12:52 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Matteo Martelli <matteomartelli3@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: pac1921: fix wrong channel used in trigger handler read
Date: Sun,  2 Aug 2026 14:12:46 +0700
Message-Id: <20260802071246.62046-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pac1921_trigger_handler() walks the enabled channels with
iio_for_each_active_channel(), which yields the scan index (bit) of each
active channel, while ch is a separate counter used to pack the samples
contiguously into the scan buffer.

The register to read was looked up with the packing counter instead of
the scan index:

	ret = pac1921_read_res(priv, idev->channels[ch].address, &val);

pac1921_channels[] is ordered by scan index, so channels[bit] is the
channel that is actually enabled, whereas channels[ch] is merely the
ch-th array entry. These coincide only when the enabled channels form a
contiguous prefix (e.g. all channels enabled). With a sparse scan mask -
for example when only the power channel (scan index 3) is enabled - the
handler reads the wrong register (VBUS instead of VPOWER) and pushes it
to userspace as the enabled channel's data.

Index the channel array by the scan index (bit) to read the correct
register, keeping ch only for contiguous packing into the scan buffer.

Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/iio/adc/pac1921.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index bce7185953ec..0037509503ed 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1037,7 +1037,7 @@ static irqreturn_t pac1921_trigger_handler(int irq, void *p)
 	iio_for_each_active_channel(idev, bit) {
 		u16 val;
 
-		ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
+		ret = pac1921_read_res(priv, idev->channels[bit].address, &val);
 		if (ret)
 			goto done;
 
-- 
2.25.1

