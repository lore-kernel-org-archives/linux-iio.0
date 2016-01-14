Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:44962 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbcANPiz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jan 2016 10:38:55 -0500
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>, <nicolas.ferre@atmel.com>,
	<alexandre.belloni@free-electrons.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<linux-arm-kernel@lists.infradead.org>, <pmeerw@pmeerw.net>,
	<robh@kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v3 2/5] MAINTAINERS: add entry for Atmel ADC 8xx driver
Date: Thu, 14 Jan 2016 16:38:14 +0100
Message-ID: <1452785897-16270-3-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1452785897-16270-1-git-send-email-ludovic.desroches@atmel.com>
References: <1452785897-16270-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dac3be0..113900c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1951,6 +1951,12 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
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

