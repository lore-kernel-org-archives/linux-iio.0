Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AAF1A23A6
	for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787458177; cv=none; b=bup5XJLzAnrMVl9fsk+i+tgyNv60Q9Cdc07EXpvmPk171SqDNBaGF+IVB6tAoT9FT6NG0oVIIPxywgkx8qFV//NzW01sGXsZmP5yxk2nAm0BndeZNr3ufNcbg896W403hzPz7XhW17FtU5cFx2QFDmx+0OIujCWczsNlpQb4pn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787458177; c=relaxed/simple;
	bh=FN4axVCvWeOGI9QQ+GARbmaIW+DTWB7UwVfBjwyccdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZWB1CmSAAVyfa4A97kd4jQvPE4pfyVW5N8qXTz4LBx9fliQFsDTc63naZ24+Q/JnRCHYLFdd2ncYWpY1mMQuCGujUQ6zRIGijoAA5Gd65USrkNnpuERvCTnajUHWjzX2XR0QXY8W9E1jy1/xQmuCFcVOTd+/1N0udwtFKAtDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggvOxLSO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggvOxLSO"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2055573c8cso347127466b.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 21:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787458174; x=1788062974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OFUI86o2y1mtgXhwS0nsFHdUGTMiw8ONk/CuNvr2P5k=;
        b=ggvOxLSOf5ZHE1K/eiDxFGyxRqKY36C52AvUk+ZvLZkoua+O43i9y4+aTMCD58Kk69
         pNfs4qbwKYuve+rtvHKMAebU9SQfNEf//ERalwarnAZSTR55Joe2RavWMtVkuvSKIurF
         VLT9nRzWrcUS3jjzjTVAK4w6JMhtRx5en7f8VjmouIZ3NrbVDAory/T/evt2vjaCcyo+
         09t9C3pJKfpEUcuYFZF2uui1X2somf1XPL8GvqBikE6KMbaTX1+41PqYgnsNbZ9/x8Gp
         OLsAJRZS10O3Sm1sBd/JM6utEGRDxedJj+5x4h2enNykCe9RvUgeeNPjwwRfg13JDQQ/
         myog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787458174; x=1788062974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OFUI86o2y1mtgXhwS0nsFHdUGTMiw8ONk/CuNvr2P5k=;
        b=CnWUxHtpMxOsKZWkMH0unHH8xcmYbof0Rn8Wrt8Au9721eAOVSXBHTtRJE50hlWOyu
         veCx5OrDlFD9H9OGdjbOZlS/XnsD1eHfo+z3FoYxcWredaEdPQgMp4ayM7B+Y4RdbZNL
         7POqbWmsCxx+jqTnrtnI4ZEVDLxUxiFgFiFbEb8MV0JfrzsPjcjsnurS+/Q8KH1+WTsk
         omBvgrfTJmKg/32FRc2VEdAZ0K1GhmGpxXLh7MJJMjMBMgq48sxztYyf5JUTnJuwh+mY
         XzbJF4diMbtcAeaT9TMrOiz+nMZAZSrFZQW5yYZNC2dNoCMBr1JFQ6nQ3e1Qshuy78DO
         vwhA==
X-Gm-Message-State: AFuF++mCu9HdHxcTX4CR/JfEAb4lq3B3iWuzcr+XozFdboQJ1t1BS1Pe
	5CAnT/oX7Chlq1fNWbylTADru/bvD0EJgHqlf4ksUfjy932LuQWgmOun
X-Gm-Gg: AR+sD10VPXu63QR1En0R24g3nivPXZfLMakeWm4IbatbahQgccXMRxHklkq2u8RxO0K
	JMCiVzHmAVzz23UhTOG24QPUHnerwtq5jeR27cooyCrYAxByK363x31goqlJgS9YH4VcLRrXzEX
	hhcNdLG5fZGhwzRQpitUD32R+q7xiYFJHWV26AJgP/NHyufIwiZF6dwS1tJMSEEugxqW+H0CDJj
	R/mUuN8LcqwOWVK+0dZ2DTTyiNkcJ9uA298IHX5hP6puDu+BHtwRCs4iACpmLH/ySSjuJUy5bzr
	iYFk0TxgUJVq3ctIj19+e2o4fxlpflXd9xnDi5ngnzZwEcCO2Ty4oHLeNmZiLY2GqdTj59bp+D1
	ZEPoh8/gXME4ofHUIhe2bRYdDwCe2BfK475EaZG09DH0/stYWR5egihvG4Wj/i+6KZt8rsgluDU
	0QrjHT9X9u1YWK8DD3JCCUVUlWMd4lEBVNqjXIiOhpAv+mhykHhDls+58JDw0F11y/IeZxmyPq1
	nw+U1szk0bdew==
X-Received: by 2002:a17:907:3d42:b0:c12:6632:e7f0 with SMTP id a640c23a62f3a-c2492797eb0mr1068784566b.24.1787458173881;
        Sat, 22 Aug 2026 21:09:33 -0700 (PDT)
Received: from localhost.localdomain ([196.235.129.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629929dsm601433166b.23.2026.08.22.21.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 21:09:32 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Wang Shuaijie <wangshuaijie@awinic.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] iio: proximity: aw96103: Fix early return in IRQ handler loop
Date: Sun, 23 Aug 2026 05:09:25 +0100
Message-ID: <20260823040926.23860-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an unrecognized proximity status is encountered in aw96103_irq(),
the default case executes a return IRQ_HANDLED. Because this happens
inside the loop over the device's channels, any remaining channels are
left unhandled, causing missed events and stale IRQ status.

Replace the return IRQ_HANDLED statement in the default case with
continue to ensure all channels are processed even if one has an
unexpected status value.

This issue was found via code inspection.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes since v1:
-Remove Fixes tag as this is hardening rather than a fix for a real-world bug.
-Mention in commit message that the issue was identified through code reading.

 drivers/iio/proximity/aw96103.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index 8fbb755dcae0..b1f36a51d56f 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -669,7 +669,7 @@ static irqreturn_t aw96103_irq(int irq, void *data)
 				       iio_get_time_ns(indio_dev));
 			break;
 		default:
-			return IRQ_HANDLED;
+			continue;
 		}
 		aw96103->channels_arr[i].old_irq_status = curr_status;
 	}
-- 
2.43.0

