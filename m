Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:53030 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759510Ab3HNJE1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Aug 2013 05:04:27 -0400
Received: by mail-bk0-f53.google.com with SMTP id d7so2998749bkh.12
        for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2013 02:04:26 -0700 (PDT)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH v2] *** Add Microchip MCP3422/3/4 high resolution ADC ***
Date: Wed, 14 Aug 2013 11:04:06 +0200
Message-Id: <1376471047-9636-1-git-send-email-angelo.compagnucci@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch add support for Microchip MCP3422/3/4 high resolution adc.

http://ww1.microchip.com/downloads/en/devicedoc/22088b.pdf

This review maintain the correct alphabetic order in Makefile and Kconfig and 
fixes some minor codestyle issues.
I' will be grateful to anyone who wants to review it.

Thank you!

Angelo Compagnucci (1):
  Add mcp3422 kernel driver

 drivers/iio/adc/Kconfig   |   10 ++
 drivers/iio/adc/Makefile  |    1 +
 drivers/iio/adc/mcp3422.c |  400 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 411 insertions(+)
 create mode 100644 drivers/iio/adc/mcp3422.c

-- 
1.7.9.5

