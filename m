Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881237;
	b=X/0AQcCBBP8wawvenyqBGWJPhQUnaREdn6rd8OTtZvLFBYbO1UfgZekVwMfnQe8BCcrB
	 DWgBT0UIgH4PvxB+vx4sjWPaPLyBXAPNk5YAAMNemi5rq2ojP+rlg+4Pdi/85hqsqBZee
	 InSYub8tQSgip/cmuICOIcVe8Rv1hVdwGmN8Tfq0F5Le00yeNT9sk5+i260myHFj3UcMD
	 ZhEX8lWMf6zvUcbokZ6BZnGYYWVrxCKOgJF9cYvP9nakDxrUpSRLJm4sobb/bxUnFFMHO
	 EAnBQegNFoWSD85C680TH+xPdUPqwWAz1F9RzNqaPHUNyNe0b7I617zN439cOeLy2Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881237;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OLUnGvYwOC48SloSAiu0WufUKOV5tVIRadr3I27DxbQ=;
	b=LNI7Q7oeq0cBFwym3D1SFIxFXzsQed0DBTL1hYYqQgS+mWZsc3m34oo4PZPe5Uf2Yd70
	 xrojZLwzQijfH6CixhYHkPbUo+eHP1FVXnZVy1zBdOroSnvMOOONB5iHKXdX+ITB5FRM/
	 EVhIEQ1W/ls/hqXPE2460dC4+B6C1wZX+vCE3TGh/VPF3CP9o9MLuXpVhTIxkd5PbsSYy
	 9ruLkVJMyHaSXpV8AaxlM9QOzBbQzSqZYHquJeRvg2st8wvjohccbuzg/4t9mDTa6iAXD
	 8ojZIaoFFoXOO0RRxwq0tVBe7ZTNPe1NDpmN+JqCNrJ9iV7BC4cwuaMV2iyabaxl4HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Q3HQ8yTx;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E330606A335;
	Tue, 17 Nov 2026 02:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E330606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Q3HQ8yTx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Q3HQ8yTxEirvq4yYQgtq/FUTOSFxUVY9KJQrXPH/kXTOJ/5EteUaqG8tlTkBlZnqe484niPxQfpRt
	 B8oVS0nWe/Q3SvU8kyyMjHaNZP9CtbrucUEIUahKxtsbuIRx/yY2krQ0gn1ZYHkvE3XPVI2cXni15b
	 pZiXklSoaJUnml/c=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86afbb6cb8f2-a3e28;
	Tue, 17 Nov 2026 10:07:08 +0800 (CST)
X-RM-TRANSID:2ee86afbb6cb8f2-a3e28
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56afbb6ca618-9edcb;
	Tue, 17 Nov 2026 10:07:08 +0800 (CST)
X-RM-TRANSID:2ee56afbb6ca618-9edcb
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eugen Hristev <ehristev@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: pl022: handle clk_prepare_enable() failure on runtime resume
Date: Tue, 17 Nov 2026 10:07:11 +0800
Message-Id: <20261117020711.20158-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.24.4
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

pl022_runtime_resume() ignores the return value of clk_prepare_enable()
and always returns 0.  A failed runtime resume is therefore reported as
success and the controller is used with its clock off.

Return the error from clk_prepare_enable().

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 drivers/spi/spi-pl022.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f52130465a..64bf9c4b0a 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2067,9 +2067,8 @@ static int pl022_runtime_resume(struct device *dev)
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 
 	pinctrl_pm_select_default_state(dev);
-	clk_prepare_enable(pl022->clk);
 
-	return 0;
+	return clk_prepare_enable(pl022->clk);
 }
 
 static const struct dev_pm_ops pl022_dev_pm_ops = {
-- 
2.24.4



