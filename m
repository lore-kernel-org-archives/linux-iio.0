Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448662;
	b=tsz0kMCCm2TJvtGaLKi0+nS0h47xSO9JbmX76ZpoyE3QLTyGh1JNXlMjCjg9qs5iQ2KT
	 WlIa1Pt38PRvYqdaAQaw6debxs+OjjFSBm20gASYHJqx3hHMfcfU1F9TXNfOGRYfAFFcE
	 F2q34PKqlSAp4iSB9b8tDNRzuum3GErcF3VLxP5Rw0HJjziVf7rJm8i3iqgrON8Ni16Z3
	 EfHbgn7bOvqvxaUN3ohD5Myf2VsgMrIbJeVu5EmjAH+P8tr8xIukPnTWTthv85CVAWY8+
	 xCntx99KmHp48/kzzFptB8kphY5a9w5c1hpCtJNSswkDx5nOpxFBaOK5csOiWuO2cAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448662;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RlMi5qRbVg28z/a6dBARCAv0cTB7nwEjI1lh0Bith44=;
	b=NxJSzYKwh59/f2jKawN9bbmPn8SlS1xTns/0u1Y5adIxeRySfq3Jo8O9exRYsPIendYa
	 7GaiFuKISggL464UbFq2uUC1UBxT2/dDD5Rt3AP1fFzWRLobGZmqqbT2BAtfmbF9rlCoZ
	 KF+v8S/Nz3vhDRpNCoVoS2d7cKH1AoyIEMfDQ69EAZZtFlDGznJ/zjjhAhkgKbth+sF4K
	 DRkUAadXlH7XO15ll6pat79kjMrB2HbwEC46EDQKjwddBcc81WFMNh37DggOX2NM5t0vb
	 9eIEcbMHyGtSrORW8WD6Azs5+ZqoY5iCqMvOhPnp6gkaoTvGSKnypK3k5mDh85gSSLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=b1eopLMU;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6296606A321;
	Thu, 12 Nov 2026 01:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6296606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=b1eopLMU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=b1eopLMU7z+leSaQUWheyW2TWYbWGInAMthmPwR4O6Gd3Xxf358Mz78UNtpMIOnNSnzq6Oc8zRPBX
	 0PeV+itGC3QGFcNPIuPkflZvc4g7cngJx5umIQ1XnTfcb+fmAMCNLtV3lJbql3YqETIPg8oUrw3fej
	 DSiNTWP6jbyVeNbM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af51d101e7-e15de;
	Thu, 12 Nov 2026 09:57:40 +0800 (CST)
X-RM-TRANSID:2ee96af51d101e7-e15de
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af51d12a9f-eddaf;
	Thu, 12 Nov 2026 09:57:40 +0800 (CST)
X-RM-TRANSID:2ee86af51d12a9f-eddaf
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andriy.shevchenko@intel.com,
	crofts@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH v3] iio: temperature: mcp9600: Bound thresholds before scaling
Date: Thu, 12 Nov 2026 09:57:38 +0800
Message-ID: <20261112015738.115833-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcp9600_write_thresh() multiplies the integer part by 1000000 before
clamping to the supported temperature range. The multiplication can
overflow int, so a request such as 3000 degrees can select the lower
threshold instead of the upper threshold.

Clamp the integer part to the hot-junction range before scaling. Keep
the existing final clamp for fractional values and the narrower cold-
junction range.

Fixes: dea750f8015b ("iio: temperature: mcp9600: add threshold events support")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes in v3:
- Use clamp() instead of clamp_val(); all operands are int (Andy Shevchenko).

Changes in v2:
- Use MICRO from <linux/units.h>, cast to int to preserve
  signed division for the negative temperature limit (Andy Shevchenko).

 drivers/iio/temperature/mcp9600.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index b0ff0c7b4891..00f1acb348a5 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -17,6 +17,7 @@
 #include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/units.h>
 
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
@@ -326,6 +327,8 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
 	i = mcp9600_get_alert_index(chan->channel2, dir);
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
+		val = clamp(val, MCP9600_MIN_TEMP_HOT_JUNCTION_MICRO / (int)MICRO,
+			    MCP9600_MAX_TEMP_HOT_JUNCTION_MICRO / (int)MICRO);
 		/* Scale value to include decimal part into calculations */
 		s_val = (val < 0) ? ((val * 1000000) - val2) :
 				    ((val * 1000000) + val2);
-- 
2.51.0



