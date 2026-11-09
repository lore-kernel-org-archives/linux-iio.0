Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216922;
	b=dD/U0tQ0KgQb5mRMUxlglfwrr/WnTSXf2V3ukRI/WPSnNUt1K+EqX93DcgVOvw0QRf4H
	 M1T6g0UVL9J+UzSwXos0pJUSCFcrOtQhmk4y74ZRECNhJDWZqiesn1celVLsAQ9S64hpy
	 Dh7VPRfHmdzGKCdRnzpifUkhC4WILa3NL4dybRniT7taW5sm3BojCPcapkwqyG60oyMSb
	 9hRzwUNUL6JrOeCutd0MY3cVprhEwhFIs1oJGngUPQij9WjVyC7Ao3JG0HyoverELx4Xd
	 z8YHOVEWabYc9jWfmrkgEcMoQC7r2HqZT0wRAK5w8g4VamS3RdJFQNGfdQ3eNSMqgmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216922;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3m4MXCEx7RjqLZia27iJuB15Wc5H8UcIwgleSTl48u4=;
	b=FyQtImIR8psVHrLgKjp2VmQi3ivIje/M9lCPku7YQRqjjM5Or/X2Xp1YutHxnPzi4pLM
	 a5HLEr8spSfAEutl6YkezBkh7tcj/QGTsKL/nVpx9CohfDPjUoAzvcNP0WW8ZMylmaxTk
	 HZ/6EhcJp+VEg+bRuklqFOAMy1nRlhs7GjPtaBqerHSSBow0ejMEjGh3ykDegLBjBalre
	 FKeUNiM71I/sLz7SvzXHiRSHz+14gin5nJOaUsccpOb0glWLaCqX7nUVu9EU3R1R/AoBe
	 KzEKLwC0vn65Z37x6DNBqFiR4mEqfDrDSQ2PAfv5AfH3lth6d55DgNrcoh3UWPLA0sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=CWgmU0BI;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8F8606A31C;
	Mon,  9 Nov 2026 09:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A8F8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=CWgmU0BI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=CWgmU0BIX5HMN+2LeUgx37LOgzK4QTSDgZt6pMlQcOzOMtvzLJxTcXiFjACJJFpdmbSyqxyrRBYu5
	 cKGGk35Giwi2y6Tyjtki7VwNb5rG+uMWa2Z0auGT55YmBhrurtwc122ZicVBPPAr2MfpOH78jXMYZd
	 SBmwNhdA498a34fM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af193d7e78-a0235;
	Mon, 09 Nov 2026 17:35:20 +0800 (CST)
X-RM-TRANSID:2ee16af193d7e78-a0235
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af193d68ef-8a7a2;
	Mon, 09 Nov 2026 17:35:19 +0800 (CST)
X-RM-TRANSID:2ee56af193d68ef-8a7a2
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: zhujun <zhujun2@cmss.chinamobile.com>,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: temperature: mcp9600: Bound thresholds before scaling
Date: Mon,  9 Nov 2026 17:35:17 +0800
Message-ID: <20261109093518.5418-1-zhujun2@cmss.chinamobile.com>
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

From: zhujun <zhujun2@cmss.chinamobile.com>

mcp9600_write_thresh() multiplies the integer part by 1000000 before
clamping to the supported temperature range. The multiplication can
overflow int, so a request such as 3000 degrees can select the lower
threshold instead of the upper threshold.

Clamp the integer part to the hot-junction range before scaling. Keep
the existing final clamp for fractional values and the narrower cold-
junction range.

Fixes: dea750f8015b ("iio: temperature: mcp9600: add threshold events support")
---
Validation: x86-64 and i386 driver objects built with W=1.
Source-extracted boundary tests passed on 32-bit and 64-bit;
the corresponding test fails on the base revision. I/O is mocked.
No physical sensor hardware or booted-kernel test was available.
OpenAI Codex assisted analysis, code, tests and changelog drafting.
The human submitter must review and add their Signed-off-by.

 drivers/iio/temperature/mcp9600.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index b0ff0c7b4891..51ae622d41f7 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -326,6 +326,8 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
 	i = mcp9600_get_alert_index(chan->channel2, dir);
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
+		val = clamp_val(val, MCP9600_MIN_TEMP_HOT_JUNCTION_MICRO / 1000000,
+				MCP9600_MAX_TEMP_HOT_JUNCTION_MICRO / 1000000);
 		/* Scale value to include decimal part into calculations */
 		s_val = (val < 0) ? ((val * 1000000) - val2) :
 				    ((val * 1000000) + val2);

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.51.0



