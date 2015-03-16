Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailrelay118.isp.belgacom.be ([195.238.20.145]:20258 "EHLO
	mailrelay118.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933741AbbCPTTD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2015 15:19:03 -0400
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fabian Frederick <fabf@skynet.be>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: [PATCH 09/35 linux-next] iio: constify of_device_id array
Date: Mon, 16 Mar 2015 20:17:15 +0100
Message-Id: <1426533469-25458-10-git-send-email-fabf@skynet.be>
In-Reply-To: <1426533469-25458-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 55a90082..9a40097 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -437,7 +437,7 @@ int ssp_queue_ssp_refresh_task(struct ssp_data *data, unsigned int delay)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id ssp_of_match[] = {
+static const struct of_device_id ssp_of_match[] = {
 	{
 		.compatible	= "samsung,sensorhub-rinato",
 		.data		= &ssp_rinato_info,
-- 
2.1.0

