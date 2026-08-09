Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACA156661
	for <linux-iio@vger.kernel.org>; Sun,  9 Aug 2026 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786273999; cv=none; b=Brc8aoNczp7th3hLIKU13pPCvys9ogz/Fou0VuN5tM2CGsrJ5LLR+EDjFB5CBusOSrHNI72cWsYRIMnLCd67jGVtIupdJXw7PMI7nGQmfLgIvDaQF6VEllDtHJHBj5nQsMEcRlNwGEkr+M3c+RB+KfKoGdGHBwXWaw7I1Z9FSTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786273999; c=relaxed/simple;
	bh=XaP8uJa2B1P/h9IrcbZZC7i4WH42BO4pc64EM9r5Efk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lKpsw/hQdqWuv2qAdr8BveLDCNIvbvFxYF4x4T+WIB/1Rmc1eycK/pBZh+QP9yy48BSt4ISZ/rPBuf3zbO9vCp6yYiHaz3nf/Q4sV9bVOoonwgbY2cxBgN0QtgYVzTIS1YqwnmRBW4ZNOJvytfXD5QcHBY1BDGaAbbjAKjrtIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i26axEgK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i26axEgK"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1000471a91.3
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2026 04:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786273997; x=1786878797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ATYrTrILFqq0zNcxTWZD3wbBBugHUrs0A91546BI8T8=;
        b=i26axEgKi06fDpH574IyFMK6KXI04v9p0c1QYfhcQB68eljFaz3KM9f05EpJuPxQR2
         pJbqAqEH99Asbo/TzjOY4nRKNVfrLJrh0bG6Xld19meJZzJ8sCRsyt4t/0MaioTEi/dv
         M5Gpf9h7iEnpOTzB6EOASaDdSNojOgADMoliIorm06OwBp5Yf8OmkY4VFdOFJThHouIH
         vTKRgzItgobW+/vspCD1AD8oE4GFMTNRGxOTAQmDEq5VcMnf5K8nWhrBw3oBw8C4VeyF
         Cm9Qhf9aBGMFqK1FIVayO2+D3o1DXACGJipo+p8Xe2b0fbx8+gVAdS7oQaKwnpiHwBzk
         4TXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786273997; x=1786878797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATYrTrILFqq0zNcxTWZD3wbBBugHUrs0A91546BI8T8=;
        b=NEfu2bGmJlYNeasnn5OSImuF5gPsJSrk9Kg2l0lZTPQ9SQdzBZVoQMKSHSl1O2pWgl
         +5q9vjVE4WMYy7GdbKo3XUUI1Hf0lEFwFUIAJoqxSM8DkDd6XDQcNJlFWqX3cUAVfH+r
         Ol0pWmsisFIoPGsqwzJ7jbO7BRGm1becvFe2iIwwnV8m7J68PT1kIS9VET6Y+QEo+taD
         qpUxoTDCb426ZH1+mbHiklW9VzkvzKpdaRVRDXYr7++uWJuuuNdRcuIdwPTxTyX/8HCk
         quserBBuL9nd/kdpffj+R83ivhrW8Q4mKAtPXOOCygD3wNjyZo6iZkzb78wRjabSHPG9
         Uy1g==
X-Forwarded-Encrypted: i=1; AHgh+RqXQAJbnan8S18JM7hjTudjj2uDq4f7cFK6N0fNITYQn4fSFX4RxjzW2wh6uf26WV6V3cau8+jd81s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1tijUCXI26KfJg3EUX28oqxVZnp1MQHKDH5XKvtSOcpEfDS4r
	XYDOGJgNhT/BzRDQxYBECoCHH3YL5egBG5Q8bQenZ+yI1w42NTBPB9bV3I39SVW6
X-Gm-Gg: AR+sD12esFZ+UH6PUG2updjO11HJ8kGQfJQW/hazAOJojEX1AbeeyzCUF0gWK0R+DdD
	inpGozj0vjnErlPdPXcTd/Yv8I3UWEHArAZOBmVWDsBVbvmOXnkkzXBCURad4fWolLrSriDlTBO
	rzPeMj/Dj+tGSj8OKTz9LbHh6MIu5y5iGaXbQh9Lk2wywX14wH+rYhvIBKRTlBya88KWNtkCbH2
	lWh9oZs2q5OouhCRXCfEIbYZXZxzBF7shguk+zjmdcklT8yO2NLQusRpAsQpsEfDSETl+h68xzX
	sTIg+GKbhxTB4FdNoecdP+7/s/cQVqlbc2eLsfUCR6ih07o/Sax6K15odqNIs2UTMXO81A5Cxkj
	bvqGfScefj/953TMKARIjzkM5LdD6EU4HHJLZNFAMXOvaVLaBGUDhf6sxxA4gNZT3Noe+IdkJnE
	3JAHe8nqMmjepwWk41hzrPP1GGWanoS5qY2xbZnH3sLXxCwfBIPieabAqLDabFNFz90/0g1tPmX
	bkbnD3P
X-Received: by 2002:a17:90b:498b:b0:38e:7268:220d with SMTP id 98e67ed59e1d1-3903c628176mr38953678a91.20.1786273997367;
        Sun, 09 Aug 2026 04:13:17 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40d4:1066:5a44:8324:6698:a7a4:2315])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a9220sm32046945eec.7.2026.08.09.04.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 04:13:16 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH] iio: accel: bmc150: use iio_push_to_buffers_with_ts()
Date: Sun,  9 Aug 2026 16:43:03 +0530
Message-ID: <20260809111303.496393-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts() to allow source size runtime checks.

Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
Follow-up suggested in:
https://lore.kernel.org/linux-iio/261dcaa5-3e9f-4da8-adb9-dae4eb7310f2@baylibre.com/

 drivers/iio/accel/bmc150-accel-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index dc8a6285cf3d..d904136720d5 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1011,8 +1011,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
 			       sizeof(data->scan.channels[0]));
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-						   tstamp);
+		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+					    sizeof(data->scan), tstamp);
 
 		tstamp += sample_period;
 	}
@@ -1196,8 +1196,8 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, data->buffer,
+				    sizeof(data->buffer), pf->timestamp);
 err_read:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.43.0

