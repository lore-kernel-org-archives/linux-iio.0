Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:33520 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759159AbbA0WQr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jan 2015 17:16:47 -0500
Received: by mail-la0-f42.google.com with SMTP id ms9so15852806lab.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2015 14:16:45 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mario Schuknecht <mario.schuknecht@dresearch-fe.de>,
	Aybuke Ozdemir <aybuke.147@gmail.com>,
	Tina Johnson <tinajohnson.1234@gmail.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: light: tsl2x7x_core: Change type in printf format string
Date: Tue, 27 Jan 2015 23:20:04 +0100
Message-Id: <1422397204-9079-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Wrong type in printf format string, requires 'int'
but the argument type is 'unsigned int'

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/staging/iio/light/tsl2x7x_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 423f96b..4a5dc26 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1147,7 +1147,7 @@ static ssize_t tsl2x7x_luxtable_show(struct device *dev,
 	int offset = 0;
 
 	while (i < (TSL2X7X_MAX_LUX_TABLE_SIZE * 3)) {
-		offset += snprintf(buf + offset, PAGE_SIZE, "%d,%d,%d,",
+		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,%u,",
 			chip->tsl2x7x_device_lux[i].ratio,
 			chip->tsl2x7x_device_lux[i].ch0,
 			chip->tsl2x7x_device_lux[i].ch1);
-- 
1.7.10.4

