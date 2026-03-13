Received: from h4.cmg1.smtp.forpsi.com (h4.cmg1.smtp.forpsi.com [185.129.138.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413BE36D9FA
	for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394122; cv=none; b=XUmh1LLCN1ni4qhYTZ7F8ntSfDytNC+axLQlvK/RPe2T/5/YSAZZ5Fx3+wvyt0v9IAPJDAJkGFJvo555y+KTiZRCaHDeHA5+6WbsCRDo6c4q+wN5P2lHriLx52Nnllq04GDOJwzzqWPkucJIXMbEqlDopwiCx/GbN3HxQ6elXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394122; c=relaxed/simple;
	bh=xnaOsc1tnGIB+dC3QzHfqbEuQqaSqRqNq3TkmvnXDKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jUOtcPnJEW/5ppLHHm3jbpNwuCyfG7pROqEWGjV3Ajfv8l1+gDw5ZY8iH1PJ9qgE0pJ0soEonYumltuw/jo/PPqjkMRFJqR/C+QAm0z+cpQXm54TdRZbvn4eUr+Zc/Kp5OoGUFUAx41nF51yyr6PpB4k63/VnMlLbXrBFz/a74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=ktNe+IB3; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=ktNe+IB3; arc=none smtp.client-ip=185.129.138.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="ktNe+IB3";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="ktNe+IB3"
Received: from localhost.localdomain ([178.143.46.35])
	by cmgsmtp with ESMTPSA
	id 0ylXwpOZGRypH0ymFw0tjp; Fri, 13 Mar 2026 10:25:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1773393952; bh=7RJ9A5RZLO+/pUgTcg0H/Aw2ch1gg/47MK97JlKa2lo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ktNe+IB3RboXzrPDbIiu7xdA0PrXnmPJ7NszGL1EP8qPES++GrljXPRZUOuvoDVOU
	 PwTSbBU54q7lmtxgKwH+JFI+8dXWkMyBnmfX8C2ghP47HAKGGPGciecZZT5vyoWLN1
	 51isCDD6uOyvCYRf53XMq9A6pmLqZ1uO09j0EyzV2R+Xb3ShAD+bgNw6p6OkrKonbO
	 zFn6Ce7UCAOeJoPL+zd1SwFUPh2tiHmMf7YR+VggCrsQX+EknhchfAOwRMm7Y8MtcT
	 OXN+HTyV92e1yfVwcNsW/KTPkCOIUb9cRKkvOjwtAwDm6Jjn253aZJAUjAYSHdkpwL
	 W6B4i1e7ksDxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1773393952; bh=7RJ9A5RZLO+/pUgTcg0H/Aw2ch1gg/47MK97JlKa2lo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ktNe+IB3RboXzrPDbIiu7xdA0PrXnmPJ7NszGL1EP8qPES++GrljXPRZUOuvoDVOU
	 PwTSbBU54q7lmtxgKwH+JFI+8dXWkMyBnmfX8C2ghP47HAKGGPGciecZZT5vyoWLN1
	 51isCDD6uOyvCYRf53XMq9A6pmLqZ1uO09j0EyzV2R+Xb3ShAD+bgNw6p6OkrKonbO
	 zFn6Ce7UCAOeJoPL+zd1SwFUPh2tiHmMf7YR+VggCrsQX+EknhchfAOwRMm7Y8MtcT
	 OXN+HTyV92e1yfVwcNsW/KTPkCOIUb9cRKkvOjwtAwDm6Jjn253aZJAUjAYSHdkpwL
	 W6B4i1e7ksDxw==
From: Andrej Valek <andy@skyrain.eu>
To: linux-iio@vger.kernel.org
Cc: Valek Andrej <andrej.v@skyrain.eu>,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	puranjay@kernel.org,
	jonathan.cameron@huawei.com,
	dlechner@baylibre.com
Subject: [PATCH] iio: accel: fix ADXL355 temperature signature value
Date: Fri, 13 Mar 2026 10:24:13 +0100
Message-Id: <20260313092413.35912-1-andy@skyrain.eu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfD69uxUksygkb5oHIM/o87wJiYl9D+cURbl2vUKAc1LQimF2C8EzPYKAoWzulhmK5Pap6UaEZk7N9XOnLi1p5Jzwu/uJYBIGwRXQwAEpil7A/+qXbgA0
 aAMuFY6JUafO2ToPAVIYliqLCFnUwJzJLyUILYjzgb5CeoJCqSfvtm4OZaKH2gsneuUaXFmWfO4ZcgU7s91oloIVurNa0IWFF0f5rotdWweEhDNIC9EqB4Hw
 SviXEht9cUD46TF1IOeXn46uNVcCN5AZggzHzotvYsz0/QFOoJelA0xvgWFtf1bp9Po9V/EzgmZEvnB3JHxp0tTelqDY1kf1/xqiLNMB3EkWlbxOhA0x7jxM
 SgJ5EU4kwciP2TvnWDxU/pLSSg74mPHOF1rh/TGvi6uoKct0TdI=

From: "Valek Andrej <andrej.v@skyrain.eu>"

Temperature was wrongly represented as 12-bit signature, confirmed by DS.
Even if the temperature is negative, the value in the register stays
unsigned.

Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
---
 drivers/iio/accel/adxl355_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 1c1d64d5cbcb2..8f90c58f41008 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -745,7 +745,7 @@ static const struct iio_chan_spec adxl355_channels[] = {
 				      BIT(IIO_CHAN_INFO_OFFSET),
 		.scan_index = 3,
 		.scan_type = {
-			.sign = 's',
+			.sign = 'u',
 			.realbits = 12,
 			.storagebits = 16,
 			.endianness = IIO_BE,
-- 
2.34.1

