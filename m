Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B342EEBE
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605614; cv=none; b=rKF8MoTjZPuLSvKuN1nfBlSJ8panAiRiu2B2pbtios895ytaKxTOhqC3NXGtuswePlIMsRKBqP2G2kXbwgEhC4MyTNDN8Y1zONDCRvlijsWF7t6GnWDJKuD2mDNfV1F0VP62obMSUkDR/bVin47hJVzdS/6v7kczg8TWyKVsVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605614; c=relaxed/simple;
	bh=Tatshw8tZp3isUeJgpguim4utDTPO4m7ZqEDtHPAsiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EWGCM4XbfUcHiIUd2CNa7znmZp4LF0kyTy5GK70TDA2V1fvAwHCpV4e7l+VRxhT844ZjCYgq8c2gGAQBsn0BBPz3RLpXMD8zt/LB52keK9DCAl2tTP72aI5R4Iwc6eTR68kkmSRdc5dPVG4tyuDvnwcbzByT/Pc/yOLJ1V/c/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYHL0im5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYHL0im5"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso3636080a91.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605613; x=1782210413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fb6YzEnYflcBWwBNi3JZ3ijbs1rvmfdK7b9YH3s3sDg=;
        b=oYHL0im5Tfk6TtNPqw3WAV515y2e49L4lNSaAGB57BuyRnNBE9QciyN+Os/hIaBCxH
         KtBQ+StDd9ywd1k3iBs6k4K5c5AQEC2b2SepPdITjEgA9OTTpHcKBC8CK6t9psKOor+I
         kAfqEnXa8/sIik+oL8oCsrNoCEYQfSx5yHOA6PVellDPbCQJejYr6Os2lf6kr/ZQFPiq
         mm80lAxENhgBEtmddYJd9LiWZ4SDOMEFNTo/351bXYi5f8laGsWejy2uAyqadAGF2cgj
         WrqO+BPCt2mTV7IGFzaUvGHQ5vblMUuYoxxTsnAnPWC9iabU200PB3W7+yu21fYIy9Vc
         5BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605613; x=1782210413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fb6YzEnYflcBWwBNi3JZ3ijbs1rvmfdK7b9YH3s3sDg=;
        b=cl9UFyNX18ekgCNSRbUab3gbO41Fyjk+voBJrnl7vGP8b/+zwHW6EvbTll/M0kk/e1
         2FcmANfq+GsR/5gS3rHZVdYOMl2RmR2jqHFTtZUEYmBECv0wOjZKXCGeHUz+JH2lroIx
         b8l4h2RnWnHE1vVr8yZBakxMJVNvOKoheuMa/Ac7ck6FlKK2NyGzuBPvhmKDAx/f1bKE
         BnTW6dpV5rKszSr/ja5WZy+2U9knjNH+E8NSxB3IJ4JHRnLogrbr1MTkCVhwlCwD37d9
         J+t1SDZ3bbGKXqVMnlXJyXeJ/PB0A3lxNe2yr/6dacmFCNeAt7sYvtMUKOyZQmsVxGgm
         5RAg==
X-Gm-Message-State: AOJu0YwzBZbHGMgGN4UpHn0K3H0hYpdUsxyIUBGk+DEl00Qbcwehy68H
	F2x+NTbaYCwMJBOiNkCq4OWaYzCB6FFXXZsi20v5LEI39KgenLByIbk0
X-Gm-Gg: Acq92OHyDblW2rPeAkv5lLz5kkR6E0MzVCU07wBTY92Bj1F6j831+SihUd1D61I3HIk
	nWJi9EOR27uDGuiaaPHfNXO/MGkfGWtuX8nk5sq0M6NU2Kc3HWpu3kqrxqgvzeX+HztxdZ0V/zD
	fHNCUkCSHsayOsitsJoQIN+ZkkqrAKjJ7mzFIpBzI8rLeXqzEjwdbNLlUQIh+BrHrlAHM1xqj/U
	rcOTlOHN/qMxL5nDvnUStPsg16pIABpeDTVG/4UHhT2wKI/ZKteJiAv3+13kWkLHOBvnx5ys7h1
	c1MPgCZ03zb4V3KasqF8xQcotjkvc7+a+eZ7wg10poLxBFPYohfWyyH8OZ2TVgKWykuz96+pklq
	4aNCycNKuXbgPp3JT4OS9JKkGmFJ4gWSBrerQdd/gHWSFuwAXdOGZ2XJHA7Z4zkV2aWcqtSybIL
	H3ixtmKlZRAcgI3xTS+i/LJgm62aE14cR5EO4GzBrwQyaP7V0g
X-Received: by 2002:a17:90a:d006:b0:36a:8ce7:b879 with SMTP id 98e67ed59e1d1-37a018486cdmr17603706a91.5.1781605612690;
        Tue, 16 Jun 2026 03:26:52 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:26:52 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:10 +0530
Subject: [PATCH 05/11] iio: humidity: hid-sensor-humidity: use common
 device for devres
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-5-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Zhang Lixu <lixu.zhang@intel.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

kmemdup() is used for memory that is logically tied to the HID
platform device, even though the driver binds into the IIO framework.

Using &indio_dev->dev for devres allocations works functionally, but it
results in two separate devres ownership trees—one for the HID
platform device (pdev) and another for the IIO device (indio_dev).

The devres framework is intended to have a single, well-defined parent
device. Since the memory originates from HID sensor probing and is not
IIO-specific, &pdev->dev is the correct and logical owner.

Switch to using the platform device for devm_kmemdup() so that all
resources are released deterministically and consistently.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 6fed019f4099..73120b87d641 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -215,7 +215,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	humid_chans = devm_kmemdup(&indio_dev->dev, humidity_channels,
+	humid_chans = devm_kmemdup(&pdev->dev, humidity_channels,
 				   sizeof(humidity_channels), GFP_KERNEL);
 	if (!humid_chans)
 		return -ENOMEM;

-- 
2.34.1

