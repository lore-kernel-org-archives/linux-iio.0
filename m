Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366342;
	b=KIPFl6NZIez5SVjQHBftiHcTOn2i+dH3kO+ZHu0aVCLCQgc8TT9fY+BzfydvoZ9xwbOd
	 5qA2wM4YgUl3iEqWW4m/M9epngpwrJFG8IFJcJQv9SXiN289QmO9NzC+PH2BzHhmpwLwf
	 jdujOEPzuXDXtiFctx/PenPpxi0Gp3MCIZ0cQUY2MZyG5DLYhebGpzC6fftBxZ7uqLjzb
	 Bbu8V5aYp0rh1XPArG4o53rggTS502oO2dkN6uODHl8FQnW8k/InhXCn5j3X49yZGJvhE
	 d75INlKdOKbhcpo6RIgyVNdzSRia0/M7Bw9yyB8ddsPScmNAM8Hh9V/nJwn7H9equXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366342;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q9dh0eC9tiG5dtZYvNDq9HKp18r7vEAQYTFnav9a9/s=;
	b=fJzJd7sOhree7MDhz07OU1DRG49YgwrL3Y3tlG4kx903qFxfC5KVTYrdTe0pbn/LF4eu
	 l1KPof/bs2JdmtM5t3fUEz7b4/W+cYZobvtdg70Tl4pZg4BbzpVEFuCkQHcdtmAXjKeFA
	 mY2DwKTFrDaZT4qUoY6r8d/7g4m06XncVG3B88NgFd9mS+FdXQe8FViw/Ck7SCByFKI9q
	 OXDTk4VsCBgegb6beqt1v00sqvQopJ6WFKYvmZZ0EH4B1zfgbPL9n7AgP6CGT6NPJSJEo
	 sAbHboph/tN8Djk9iwNcNsQzopLVAyELvuN5oijaTj3obg00na8A49MGS9h0+PYhz4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=w7eu5sQj;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB1606A32A;
	Wed, 11 Nov 2026 03:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41AB1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=w7eu5sQj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=w7eu5sQjk08OyWtgKZ5ccte4ghepokjHnHZL9Tt7z2a31aYVMS5tQxlOgcKY3FRT9OQe+3MXVnkDA
	 6wC4yvuYjLe5KDSpj54Mw/5zquohayX8eJQvzn45ebU6izuVeOlAdnRurz25BRDxX3itZjx+0l08Rp
	 HEkOolPVRzgJrTq8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af3db8257e-736d4;
	Wed, 11 Nov 2026 11:05:39 +0800 (CST)
X-RM-TRANSID:2ee86af3db8257e-736d4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af3db82eb8-cbef2;
	Wed, 11 Nov 2026 11:05:39 +0800 (CST)
X-RM-TRANSID:2ee46af3db82eb8-cbef2
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
Date: Wed, 11 Nov 2026 11:05:38 +0800
Message-ID: <20261111030538.10565-1-zhujun2@cmss.chinamobile.com>
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



