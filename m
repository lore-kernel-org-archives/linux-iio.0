Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE13476699
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553104; cv=none; b=mvQ9ypbVqGc2OjhCj1GS6zkvaNkvdWZtmFq5b8Ku9EUmRhrGnqfi1ktHhgWywgLNusoK+LzWUngd1GD1AHUSsGRxVTiJeaZqclNxnGzHq//sjXSwev8mQfgJ0nwMz1s0eVTKASJLMNXF4lOcToSMFZFmtWOf+b02jbePIsCLKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553104; c=relaxed/simple;
	bh=bB7cTFtQkA6GY2hg96XdtGA5bAmnXPgrq8JSiOvFnOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mFThgn0a8h32qEz9ejMMeOd0IPKRHhmY0jXQlEPM0lxOj+6pODww7XX+4KMEwQdJkq1P9ySzuBD6ws+HkIaSK39rzpjMYVvISHqqiQaJrU25Fodpu83Xbcfe7Fx/TsxtHI0180vJjjEM9gHHgrZNtuKCeRABRY58oQcPX/gA0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhjT1m5H; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhjT1m5H"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca7c1176317so976156a12.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786553103; x=1787157903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wctmwy/+rV9SrvO63suyHx9jYj3uIcWMAuL/oEwqgBs=;
        b=RhjT1m5HHICXFfJeY1CYm48RyuFpqWsnrR85PwfcuOdgbTywP9menu2qB41SVdjR3e
         nwK2KnLLt3CN4IDoGmMmbjLetbF32JcMczX+jZ/V4IWoeMgSnmYBJMCYdBsPXNZEHNIv
         CjeQDxP3P9vj2ZqF1+n6GA/S+6dN5Eo/vowQB5LGuqEhTHi8huhfcHfKt1o3cpY+JOWp
         kuUwycosWV2Pdidz/wNxpjEKlmnQgt7YSn0HhC5+V9mel2EJcrlRf3Dpc6SGMpRAO5Vc
         W2IXKuUluyjnTabulcQy5rM0aSAaHrtiFKtwas2bxbU7UeHYoT8r8yZLqIUY9jBflO76
         TV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553103; x=1787157903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wctmwy/+rV9SrvO63suyHx9jYj3uIcWMAuL/oEwqgBs=;
        b=lNBidt5N231D3tEnD3nSsUqq+mlP0BCQZGw/bXI8wmCUynGRXibUBgN1xRUnP1tdQI
         rmIFjwpaKwnowv5T0usscx0SCBOSfzJRhFDLDikeyDg0uoydJBRuoMVlU4Rmc4dTsRKA
         OVSoDdd+aETDRLTh6XyQzMeB3tU/SO6qpzj0ZKjp/wCZyj0bNZn1kL/KlQidyb6B39Od
         71nGluVp4hXRwscwyDvExBuSuf56ADsl7wz+nk0OR/jB2gKcVeRVV5KcN8PdDmSn4vOa
         Ev+/OLjcTXANMmXxeIK+tTx3U2i2L66WAYXOVGSVkMjcB2HdlhDJhwCtteiv07Ig9U+Y
         ihfA==
X-Forwarded-Encrypted: i=1; AHgh+RoTWGpALZpJaF3yAEgCMsOmSZpXwSM+11lyoQyG4Q1Cm1D6HPb1Un5LY0lRWsX4GOG1m4O/YG78vSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoiNEixFIx2NMpKAcXZHL3su+1b9gE5frgzjUlb1TWbxaiKK0X
	VdZ0wgOAm3vu0eHd1nfJhGGNMC2030gzacjr66r1dwecr4EYZiXBz21p
X-Gm-Gg: AR+sD10CV0Dr7mmfU/GaGobf++YucN5dqFmXAyO7CMyrLjZzX3nWNQXV2tjFBwwPJVO
	uin1dY5xSAoPR/N0ao2QlIijmrcbaV+p5nssfM+KcLkCxftgLEPSHz0zK2387fCXRFKY35rNgpo
	JkoZ20YqQ9sm7eh8pKVOUlyf0NyJy+BX8e7P4hnZEufnzBTMk1HSTDVd5SFMLUzEOHYhGZNhr5E
	PJcPToea3yfahbMMRTmlBTtItEHgUMXZV4cCvH5qG2BQlT3CsnocV09BC3eLGfgBgUA4kAGAO0B
	fOBZOri1x1Ve05tFIjZgTpvOQ35HmKPCEiUUmoaJ8jyrXAkMMZRrsWeKJTCBKn8ZpfbOletczYZ
	48aDE2IRTI07OskcYjXSZtVZ3GIl86PkaRfB3jYA84vdbcEll9dul57MIMaUMstmLkUfntE4rmk
	jF2w2OnpjAdoRr9kJqBFY1K4uxb9b7tcmRh7jbqXY1EfxJ1WyQivjpHROOZvXolfmd3MvMbneq0
	dqulGQFNLZpNh3PBkqMZ7+8q1RXLUSb2qIL+6nFRjd7lw==
X-Received: by 2002:a05:6a20:734b:b0:3c0:b766:74f4 with SMTP id adf61e73a8af0-3cc3f7e214emr6339487637.31.1786553102742;
        Wed, 12 Aug 2026 09:45:02 -0700 (PDT)
Received: from debian.ari ([47.30.26.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf40f7151sm12462621eec.12.2026.08.12.09.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:45:02 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 3/8] iio: adc: ti-ads1015: sort headers alphabetically
Date: Wed, 12 Aug 2026 22:14:28 +0530
Message-Id: <20260812164433.23011-4-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260812164433.23011-1-architanant5@gmail.com>
References: <20260812164433.23011-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder include headers alphabetically to comply with the preferred
coding style and improve maintainability.

No functional changes.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 3a14fdab56d8..293fdd49381f 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -11,24 +11,24 @@
  *	* 0x4B - ADDR connected to SCL
  */
 
-#include <linux/module.h>
 #include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
-#include <linux/pm_runtime.h>
-#include <linux/mutex.h>
-#include <linux/delay.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/types.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/types.h>
 
 #define ADS1015_DRV_NAME "ads1015"
 
-- 
2.39.5

