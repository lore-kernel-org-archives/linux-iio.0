Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:26730 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbbLUJYm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Dec 2015 04:24:42 -0500
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>, <nicolas.ferre@atmel.com>,
	<alexandre.belloni@free-electrons.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 2/5] MAINTAINERS: add entry for Atmel ADC 8xx driver
Date: Mon, 21 Dec 2015 10:24:09 +0100
Message-ID: <1450689852-22763-3-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
References: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a27c660..5971c25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1927,6 +1927,12 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
 F:	drivers/tty/serial/atmel_serial.c
 
+ATMEL ADC 8xx DRIVER
+M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/adc/at91_adc8xx.c
+
 ATMEL Audio ALSA driver
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.5.0

