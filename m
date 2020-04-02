Return-Path: <SRS0=Ys1d=5S=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D809C43331
	for <linux-iio@archiver.kernel.org>; Thu,  2 Apr 2020 13:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5A820719
	for <linux-iio@archiver.kernel.org>; Thu,  2 Apr 2020 13:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbgDBNQs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:16:48 -0400
Received: from relay-1.mailobj.net ([213.182.54.6]:50485 "EHLO
        relay-1.mailobj.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbgDBNQr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Apr 2020 09:16:47 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2020 09:16:47 EDT
Received: from www-2.localdomain (www-2.in.mailobj.net [192.168.90.194])
        by relay-1.mailobj.net (Postfix) with SMTP id E444812D3
        for <linux-iio@vger.kernel.org>; Thu,  2 Apr 2020 15:08:33 +0200 (CEST)
Received: by www-2.mailo.com with http webmail; Thu,  2 Apr 2020
  15:08:33 +0200 (CEST)
X-EA-Auth: dBhVzB8r86WTdEzeFCSo17GOCLpZhE4H1eQjQzH7ocXOuKIo3344gWMYArNk5vtRBviHSETRQAiFiLApMQkXmYhwYWrO5pQo
From:   yarl-baudig@mailoo.org
To:     linux-iio@vger.kernel.org
Date:   Thu,  2 Apr 2020 15:08:33 +0200 (CEST)
Subject: [PATCH] iio: st_sensors: rely on odr mask to know if odr can be
 set
X-Priority: 3
MIME-Version: 1.0
X-Mailer: COMS/EA19.11/r20200317
Message-ID: <ea-mime-5e85e3d1-41c4-5150003f@www-2.mailo.com>
Content-Type: text/plain;
 charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Indeed, relying on addr being not 0 cannot work because some device have
their register to set odr at address 0. As a matter of fact, if the odr
can be set, then there is a mask.
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index a0c2cbd60c6f..cccd4c26dfa4 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -79,7 +79,7 @@ int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
 	struct st_sensor_odr_avl odr_out = {0, 0};
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	if (!sdata->sensor_settings->odr.addr)
+	if (!sdata->sensor_settings->odr.mask)
 		return 0;
 
 	err = st_sensors_match_odr(sdata->sensor_settings, odr, &odr_out);
-- 
2.26.0


