Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368548;
	b=nQSH4CZIRvUFMj/JqoyHJs/5mZAnDj0hM+ZAHaubPW2yhb/P2KOsJNE/JfbP/oS3xJaL
	 mXslqIdRHfd5JvE2omzsj5N7/V2oxznVx0J+37xyZsVH4q4IY9gKCpGu6iLMAa/mpDJdI
	 R0HiuxT3j76Xqkf3eAn+x3gghLHBMjwa6oFU7eJBZbBeG7GHhNSEx8BXeaUMg38X3vAhO
	 Ag1klapjBxrxsDYXqjvlAlG6gHj8hA70lMuSr/ItJRsmEXIdHtblf8tLrf1supo4qNwLr
	 mq+RbMwyncZp0O4OqxdFPVQivGN3LWlgTuSJhwWETOroG67wZHufJ9MTO5W7f7m+4Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368548;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l4oVsBp8uv9SuXgwJjN38IlhtA0NjzxtCUVkeQV3GrM=;
	b=jYW94mgA3y5n1CuJke0oMAjpAfshlCdZiHuUl57bHUy2VRkJGY7v5kaziXSOZO78wJED
	 YV5YQNSYiHymtrmOR3X20AjU32vFEJdZI0zrTidd/pqYsDcj06ZKLbvmdZuOfV8yM8vvV
	 ZdNCAeTshqbgvkyvLwWMBk9IfXn4QBDnfPvvN0OulkPqU/F+wgJWxJjAVNDl5CLC2DIe5
	 OjMHFF+VnhwypdaZsbqXZd624rj+R2uXf+cQIFz7fvjpUdYFF6bRjpl47IZOtEqCvxhKA
	 SBd3JTaLkxfdh7VcMH9PDL+Auy62AWQB8uwnksfCR3wjhhSqZzle/ZZ5G27XnFuFYcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=P+FJksJU;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E95E606A320;
	Wed, 11 Nov 2026 03:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E95E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=P+FJksJU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=P+FJksJUcBVIPMDMVnICzUWQ07IX14gqddFIeMUHig1FMbEneVwm7ev1GfpEfvnZN0giw+/F49BZt
	 QS2/1EnHryY/KHEKhuaBZ7TsneQ7xDthcPY0Ibb0mS8DukekPiraJkaqN4YLR+BJuNp4MRRbtHIGxB
	 GFYFt59xckG9T6Fo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af3e421159-d4a4a;
	Wed, 11 Nov 2026 11:42:26 +0800 (CST)
X-RM-TRANSID:2ee76af3e421159-d4a4a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af3e42121e-cd2e4;
	Wed, 11 Nov 2026 11:42:26 +0800 (CST)
X-RM-TRANSID:2ee16af3e42121e-cd2e4
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andriy.shevchenko@intel.com,
	crofts@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH v2] iio: temperature: mcp9600: Bound thresholds before scaling
Date: Wed, 11 Nov 2026 11:42:24 +0800
Message-ID: <20261111034224.12709-1-zhujun2@cmss.chinamobile.com>
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
Changes in v2:
- Use MICRO from <linux/units.h>, cast to int to preserve
  signed division for the negative temperature limit (Andy Shevchenko).

 drivers/iio/temperature/mcp9600.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index b0ff0c7b4891..d030f639f500 100644
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
+		val = clamp_val(val, MCP9600_MIN_TEMP_HOT_JUNCTION_MICRO / (int)MICRO,
+				MCP9600_MAX_TEMP_HOT_JUNCTION_MICRO / (int)MICRO);
 		/* Scale value to include decimal part into calculations */
 		s_val = (val < 0) ? ((val * 1000000) - val2) :
 				    ((val * 1000000) + val2);
-- 
2.51.0



