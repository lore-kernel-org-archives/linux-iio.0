Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1F3E3C5F
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334213; cv=none; b=kZc1Ql2OqhOVoZsP3aMjcAVc+rGSBJO9by9zZCxSTb/emLKGRcSJkuN3pEJ0WT9XCAoTxeaoRP7W3RlY8HhjaGPO3SyK4+ZLH9y7sowkPsmZyvZv5aPXMPi6qXULP+/2dY59jkh3EQsU8g7KDifEw97Z/tfXqybSD5SPeI9X2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334213; c=relaxed/simple;
	bh=zC4z0kFbgJ/oRwa7t2ro0ax09WNAsCpiV49s9UZsfl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTMno0nyEU7DKbY2kklU672pnC3do+eHXP03d09wWb/osNqMHDNWNrHHUXzAo6EANkXhDvKjG94bwNEJyBEPAnRi0zEmCeCjj8wA4UshvXmxbzOWihEvI2//+oD2XjtjKhTAeEcrJM/wXV8A+px0bfgrksPRvIyN38lTxM2JigI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKkwfyH8; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKkwfyH8"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-48877a1da19so186743f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790334210; x=1790939010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CerMNlkIdGv7koVlXaq6GKcXCSbjYoltTboOWcnalW0=;
        b=VKkwfyH8Sx8CFPHiyzav6P2zAlPzRl30E6/SI0CClIBny5tWJO8e7uigeyGl0nONjY
         uasOIhWUptuQKAKIEuydVASbWb+6PZoEZTcgpFUVyBvzQCMG9vS68bWpURR3Ceq16qS6
         zUvgziLzBbO+S8xR7ouZtrtWnxtmI7UYVVx0yTC2T2OV5gAgi7PIvUhOuF3sPgvl5hbp
         H5F6L6UN82K9+76wujApVvaJRU1GuRgN9GIeHbUpEmJsysnWoPBCclVcBkqG59BpkPnT
         5iiIzzfmh7xJ4PLb9/2uEoVrW/GG3Kyv9/gjCoTzJWdaqZIxP1W9G3AkGVPGG3mK+9hd
         mdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790334210; x=1790939010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CerMNlkIdGv7koVlXaq6GKcXCSbjYoltTboOWcnalW0=;
        b=hxpQvjmaFT2mCBjehQEP2VdFmwSs35BYNkCfEJSgqxe27SVW8y29yCWDNInOxHkZnP
         PaI5puTJqO6bbGZI5G2SW2ROdgvu5pmuoQJ0o/QhXGjq110/bNoQN1zJ13Xd/ThyFNnh
         fy2W2v8TqLHUKFOZuJwq2zVB+N4hG/Oeh9HZs19gooOBftMqaIP62/b56bkmW2IlLStJ
         HR7jWWJ8d7uFkQDtDyUB0JEghvk55t4rUWl0a+TbPBMwj/6bnxkA4V9E8w5JMoXF4Fc+
         qbVLre3OAukULRYNRdbf0QdR1dBJB3G+OFdBtiqskRTQyMao8cuH5JcoxEKkUYYao3y+
         bzLA==
X-Forwarded-Encrypted: i=1; AKwUvBwfCzUSD/QcHPbN7kFRTrWJr6Zgu8fhM0zFrv/nBGPP8aHLN9waJGEmKUlayF/+c3xcYdyi7WEiX+U=@vger.kernel.org
X-Gm-Message-State: AFuF++kNSPu8GVZVUT5mCwcuf/71ZYjAVwrMWD36uHOFm50NThJjhkpj
	CKaGvP31X/ASAUCRrrBm7qEmSb2n2HlYCXCC4D1KPEQ+YFuTcEn6MvxM
X-Gm-Gg: AYBFou0wEkcka7vpOz3sJ8aa6fg18PDuMqLL1YG3eGjzAvYy/UwUj/yDo9HwQPlf5S7
	C0Asx/sD195FG97PomSW3m4VHBgfpgivE6CyBUH9UQcU71kemLDpE8J4Gx7Iw0zTF+Wjeef2iDC
	9HJ1dt/E5AG7ypffjk7DlqPJYnE8U1GRFKNJ1hRZ+XYEo9+xkLJuheaMltHeqvPbhz6V+dOF7Js
	HQkk/NAV49TalO9zA8H5NDoF1PQGs5Q10Dt7NCT38ZtqZD7ivVr4BEGW1GZORNCE6A6rttZZ30r
	PEmQEX+7tMUaOIHojYVj7Krwd/2Tmoam6cwBVeOccZIikiIbpCW0gCcnuSmrj4fCgdm1fjMoT9U
	qG1LQALd93KeyEZ+STRjJoRWfIzL1U5kinnBRsG6fs/9aGGvUSpUUtF8nhi+JZoIFbu3f4ifaa2
	sbZ7UKc0sHZmeQGzjzp6h9uklL8XyWvQnmXMGjykzHdMTy4ceZVG3xpJLSAn9u7BKYDg==
X-Received: by 2002:a05:6000:1788:b0:487:77c:f6c4 with SMTP id ffacd0b85a97d-4887db2effamr3048240f8f.35.1790334209914;
        Fri, 25 Sep 2026 04:03:29 -0700 (PDT)
Received: from fedora ([165.99.41.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355826sm6414715f8f.18.2026.09.25.04.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 04:03:29 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [RFC PATCH] iio: adis_buffer: fix buffer ordering for IIO core demultiplexing
Date: Fri, 25 Sep 2026 16:02:39 +0500
Message-ID: <20260925110239.59320-1-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

After issue raised by Sashiko in adis16203 graduation series [1], looking at
other drivers if they might have same issue. It appears that the root
cause is in adis_buffer.c itself. The library constructs the SPI
transaction in channel array order while IIO core demultiplexes in
scan_index order.

adis16209 and adis16260 have the same mismatched ordering that
adis16201/16203 had.

Rather than reordering channel arrays in affected driver,
would it be sensible to make adis_update_scan_mode() iterate
in scan_index order instead of channel array order?

Would this be the right approach, or is there something I'm missing?

[1]: https://lore.kernel.org/all/20260914015321.7a660ab5@jic23-hlaptop/

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 drivers/iio/imu/adis_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 501da4eae..45200b753 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -110,10 +110,10 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 		spi_message_add_tail(&adis->xfer[j], &adis->msg);
 	}
 
-	chan = indio_dev->channels;
-	for (i = 0; i < indio_dev->num_channels; i++, chan++) {
-		if (!test_bit(chan->scan_index, scan_mask))
-			continue;
+	for_each_set_bit(i, scan_mask, iio_get_masklength(indio_dev)) {
+		chan = iio_find_channel_from_si(indio_dev, i);
+		if (!chan)
+			return -EINVAL;
 		if (chan->scan_type.storagebits == 32)
 			*tx++ = cpu_to_be16((chan->address + 2) << 8);
 		*tx++ = cpu_to_be16(chan->address << 8);
-- 
2.55.0

