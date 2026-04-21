Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AF3A453D
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810184; cv=none; b=FJ/qgW9w5R/BBK68tg0vc4rYX+GmiAR9DVhi/bpc+25B/dpqtbtZBvT3knhnnywtJPNGqcB7ONjU9QKdALa4dbRLIQgdsOtK1lEwWIXP1xev/rcuZ3IBHAXDl+a2LK32YcdoOwJJyTX4yQR7tJZ6oxLPhpvp1SOLV8aHzAesemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810184; c=relaxed/simple;
	bh=JBGxskPAlxesezIsmdBy4JBF6ffl9IJu9YrIIh4DFo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLoobXWUU9Z9jy5IDF2doRUVZZvwBZzX9s4KNctgEuoVQZh3fxqIGmKUNbViUr57ws0DwiMlX7M5zNeXdRLkqKM88cGOLVd3QQaVNCuXnHDr09OjealvrNbccohNvZfvaHgE7Zz8tOZUXN+qHXLs1f/OF2k4VjEWN/fQ5W/tI1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=h2l60K/G; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="h2l60K/G"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c1a170a50so5909463c88.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810182; x=1777414982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMgcC6xmHzm251G4tD4kusrT9SwebP5b/OJN5LCz8G8=;
        b=h2l60K/GbUaXeNw/45Vh04iBV8WL5o/JF6gAsoT6dgFvkgp83Xu4u/r/ns9uzTr3In
         jB7LGj63phD1ztbl1U0Jjs7bO9a3qNnO+pkxYvi51HHoEJhpLj2BIVmh76J/w9vhewl5
         bwGQssCt34aiS2K+XvHKNqgV/Zlk8XRjaHSdXj0oWlh0g4NJlchDuosTjzuD058VtKsu
         IjwjWy2GqOLHItnBTWaQYgJ4rACJidUeVyKdMe1TvOgTDjPTGCtz122dtiYPTUg0qEJ0
         8NRQ3L2OHvdaLGPEggRv9VxQiUhiTNGIJLLG15nRIFY+4K+e71mgBzo7RCx0CMOJqwxd
         SbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810182; x=1777414982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMgcC6xmHzm251G4tD4kusrT9SwebP5b/OJN5LCz8G8=;
        b=jXez3JsHLXWgCTYCt39VBlL2kL0e4CQj58BVUd+VOuQd84AAVgeN603OrN9uMX/a1y
         +Hc/l2DxvOg2oHI4Eso/1Iprh4fckbOB/6ZNKbolRxDlDHbvliZ/ndwWQ5tBb4vuE4qr
         Oe1QYhhBUF9IskRt92ojNnaKU7ZMjs/PHgApSCCMsXTr5lKhBH+RCEbJftVdhzhOWtJF
         4A0Y1YrxpkzJssfjZI+oy4HPM14P4VINRioTRcyjwmTiPDDDPHnQrwLuPHMIepfVkQZT
         crBSJi9KJ3dMwz84MoX7jd3BwVmB5sdwUY05/FfSJZB+nNKuGTdq1AjVKwQDy9vBYhlO
         02Eg==
X-Forwarded-Encrypted: i=1; AFNElJ/74IPmkNOAHQvr/xr2Mm3xsBlvD2Fyj/OxmMDtVZSdSbxKmdn4/oVg/O7+2n01fcjcmEhxCI0hesc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydEq194qlBGMaFo6Uczrb2P3NT2U3rMhMpGGc9KeNyOsB2cnBR
	dApKkzCnkFhnXrVp8JHGlGVbiKP8tFT5ngSzRXYTknpVDNfbj2vULFPz9gPqof+ewbI=
X-Gm-Gg: AeBDietSP1r2pqYSG3yR/p3QimaxiPngXCBVVV0WXCZBT7n75M7t2EAUb4IezXsPOZ3
	b6p76PzhjIJxWNAxbv8IPbL+GZ1azN9RoLI8LaO/zD3p0M8JPYmK6pbMgWY/ERpIoVexXlc9dqx
	Dtr6QfTp+MgMBZiusWrNNdirHHWFNfFd0bM9s2TBD6T2UHdD3k4CFtkX1nGIPU+YIM/S1UBHQ17
	VYIYrJtB9l56xUsxjza3cw+IvHCZ+OUNUWmypXVrCNID1hHm+wbjfOTlIEtkd5+/Q136Y4ph66M
	qQ7+4rIRbAcqTi9rlOz3amzsQ1zMwtbkcF5ilBjElqVNKUg/7d95pUaXXbDzXrtHaenQkHexPMJ
	YxxR16Xo4shsaIloB2cvNg8hAXeBhsGdRIxlovLMJiXUoj8wQp1ugDDEYZ2y+7eqBpwLBLA4y3Y
	/GTlincIf2EINfntmR3o9TftRCxx8Y0JZoPKJP0puICRPzQVMY
X-Received: by 2002:a05:7022:1282:b0:122:33e:6d41 with SMTP id a92af1059eb24-12c73f975e0mr8682377c88.23.1776810182431;
        Tue, 21 Apr 2026 15:23:02 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:23:02 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	bentiss@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v2 6/7] iio: magnetometer: HID: Replace method magn_3d_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:38 -0300
Message-ID: <20260421222210.16016-7-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260421222210.16016-1-natalia.andre@ime.usp.br>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace method magn_3d_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e47..f1939da22e0d 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -132,17 +132,6 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void magn_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int magn_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -418,9 +407,9 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			if (i != CHANNEL_SCAN_INDEX_TIMESTAMP) {
 				/* Set magn_val_addr to iio value address */
 				st->magn_val_addr[i] = &st->iio_vals[*chan_count];
-				magn_3d_adjust_channel_bit_mask(_channels,
-								*chan_count,
-								st->magn[i].size);
+				hid_sensor_adjust_channel_bit_mask(_channels,
+					*chan_count,
+					st->magn[i].size);
 			}
 			(*chan_count)++;
 		}
-- 
2.51.0

