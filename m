Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46BA477E2E
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521519; cv=none; b=rCscIhBkVzDLhqYp/KWPcWmUKCTMLkFUxpOGYHtWqTHMCwT9fdphOeXHVPrToHYt3iVpS02w45WANiZFbIEbeu6QYWtrgSydL+UECd8KDCqaK4k7v0P6xg3UwHNl+JWWsSHUKQcfsuZSIZ+bumwvQST3IEuAVCh81qEDbYIjdVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521519; c=relaxed/simple;
	bh=fC6+iF3wZIOJ9jkDKq6JyJEIBQEMNM9kicOyuc7ikR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8KMomex8US4mDgGBljQ7SWowIaloJNeNfhTr0VTF4LWsIR7nhE9EKdof/j6+yOohbt7xrf9a/NX8WN8LZlR5lJkxj+wNsfC4kmYnQsTOEb7rQTljBepyH8LzqGT143iF9BD/ws00mkPTt7a8+mTRAkydDCEnW8uhEnQ22u9Cw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV1MUdVn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV1MUdVn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so29006055ad.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521518; x=1779126318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXBbj7mUNYlbg4rkKVQUy4THqQa8ssCmEHhDW08Rios=;
        b=JV1MUdVnzTg/C0GYqiHjH5/TK4rxbD6FywdJ905+0CnaM8GVuFkyRPEFBb8seRxB5z
         s0zd2OCXlg0WIFHZzXKzRTpWfjoJ/jtesQdbGLOgU1ydcmGYmrC5UHtFwusQbzt9TijB
         P7nI31v2+s7o+VtAQ8JYIvGqCWLAZNKQP416SfcGffZiKp+BlXEw8PrWKr+/FIMJlIpa
         5rufysvh58H+hd81SWG1DxsHOsNp2zYAsiwiUzGLb3hS5ZFgXxJMNGaKtirdcOEi3RH2
         F/Zkvg3Ldg8aB0g6GVTm5X/Jiq0ja7eR1yR5LGlDCW0LVIx6B8cv4/pXDmsRbD+f6T1l
         HEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521518; x=1779126318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UXBbj7mUNYlbg4rkKVQUy4THqQa8ssCmEHhDW08Rios=;
        b=s34e/spuNup5I4N31OXP08ugGQ/DxdM01jif5jbGlh16H0+h/aChwBm6vv+YzHkxJI
         BV+sYRZJFe0mQQD/9QRxjEWZJolYCI6XX7PL9+gGkVqWkMdqEAs0B6PIhOkWkMN5a0a1
         WloBD7X8WnvTt0nukusWvYIQjECLXhbOCYTBVw7Z1ZzKneiyMjBHMcS7KciVjh1v7ypq
         TlpY+0jBCeuRu/3r44UtB90Tr1VR9heHRfHjiYdICtMaEXZtrnukWoUR4RhJ2yByAPTE
         nrE9eb56iUzXOsSohchJarD5nOLwN2tyS8/nxq3iNF1Eurf03Kj0P307YvLV0xDoM6lr
         dCZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NyAid0EQgK1RTnkOxEtiViQoxfx9mcCTvyxUxu7/8xotJf5hwGOFTw2E6RNHBMB0LbQHTzLcgFAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtabIPxpI1FtbjE9EPR26LfJKE0nMV49VBUBs+FDxdOdiwIvZh
	6gqUKAx3IwUWzrYAneYtjCzXKXxN7bGozYeufWjNxSGCSGIFurI6aqnA
X-Gm-Gg: Acq92OGwhqqSJTrV5l28eCSyXpGXEpXsNYY0ZXOaI1r8IvShZ0+n0efBKq0mvcNApXs
	gQegZDCEYnqasRgweVCTCbmkV7N1ufd3MqNNRcTZt8BCP7RRDOxgv8BTz9KqWOWtPPgsbFu1/vq
	ns5wGTd+jFrptFe/7xA9oVeUV35PUWRgtRZ7E4wM1914KdU/NUtWutCsxAkpBnsx5eYS4V4z2UA
	y+LxSUbyy38OT/HhaStCl3ZNdxgB32sBVQyWcPHbCtlqfs9GARLvcqSle+d6xGbdgV4wb+I6zEo
	aSvJ/aTvGWi8NBI6HEsvchMa3Ti0kyekt62q1j+RfjhEYVTFW8tEJkbuwoMxLiLO3vqzPU1Vv6N
	FTmW3ar60Hu2de2113oPzn6df5ORDQ/ofB+ZDJ4O5PFn3ax6zfw7WDgQLsgzPmTuAwhsl6fLHhM
	+E5b55/uMCcTN7B9ERNoMIznFg90oArMraGem/XJhq1nYmkXC23/14jF7EwCxjNXn7EA5yATQwn
	lo9oFSdiHbV43B7rQl53ksePxdC8KTaiD2HDWYArx6q9caqtRCd4yRjqusyvCdTbZgokrU=
X-Received: by 2002:a17:903:2ed0:b0:2bc:b80f:677e with SMTP id d9443c01a7336-2bcb80f698bmr73240535ad.25.1778521515128;
        Mon, 11 May 2026 10:45:15 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm106838425ad.44.2026.05.11.10.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:45:14 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org
Cc: ak@it-klinger.de,
	andriy.shevchenko@linux.intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 v8 09/11] iio: adc: hx711: localize loop iterators in hx711_read
Date: Mon, 11 May 2026 23:13:34 +0530
Message-ID: <20260511174342.123820-10-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511174342.123820-1-piyushpatle228@gmail.com>
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tighten the scope of the loop variables in hx711_read() now that
trailing-pulse selection is already handled by the callers.

Also replace the 24-bit loop bound with a named constant while touching
the same code.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/hx711.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 9e5cafa1e307..0db2d2db9242 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -23,6 +23,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 
+#define HX711_DATA_BITS		24
+
 /* gain to pulse and scale conversion */
 #define HX711_GAIN_MAX		3
 #define HX711_RESET_GAIN	128
@@ -157,16 +159,16 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 
 static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
-	int i, ret;
 	int value = 0;
 	int val;
+	int ret;
 
 	/* we double check if it's really down */
 	val = gpiod_get_value(hx711_data->gpiod_dout);
 	if (val)
 		return -EIO;
 
-	for (i = 0; i < 24; i++) {
+	for (int i = 0; i < HX711_DATA_BITS; i++) {
 		value <<= 1;
 		ret = hx711_cycle(hx711_data);
 		if (ret)
@@ -175,7 +177,7 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 
 	value ^= 0x800000;
 
-	for (i = 0; i < trailing_pulses; i++)
+	for (int i = 0; i < trailing_pulses; i++)
 		hx711_cycle(hx711_data);
 
 	return value;
-- 
2.43.0

