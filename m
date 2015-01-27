Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:49200 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759698AbbA0WPs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jan 2015 17:15:48 -0500
Received: by mail-la0-f54.google.com with SMTP id hv19so15746627lab.13
        for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2015 14:15:46 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Welling <mwelling@ieee.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Aybuke Ozdemir <aybuke.147@gmail.com>,
	Monam Agarwal <monamagarwal123@gmail.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: light: tsl2583: Change type in printf format string
Date: Tue, 27 Jan 2015 23:19:05 +0100
Message-Id: <1422397145-8957-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Wrong type in printf format string, requires 'int'
but the argument type is 'unsigned int'

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/staging/iio/light/tsl2583.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index cc4ddcc..8afae8e 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -692,7 +692,7 @@ static ssize_t taos_luxtable_show(struct device *dev,
 	int offset = 0;
 
 	for (i = 0; i < ARRAY_SIZE(taos_device_lux); i++) {
-		offset += sprintf(buf + offset, "%d,%d,%d,",
+		offset += sprintf(buf + offset, "%u,%u,%u,",
 				  taos_device_lux[i].ratio,
 				  taos_device_lux[i].ch0,
 				  taos_device_lux[i].ch1);
-- 
1.7.10.4

