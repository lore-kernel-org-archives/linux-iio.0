Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:38915 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbcCCQIu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Mar 2016 11:08:50 -0500
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 0/3] iio:adc:at91-sama5d2: add support for signed conversion
Date: Thu, 3 Mar 2016 17:09:12 +0100
Message-ID: <1457021355-23898-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This set of patches does some cleanup in the code and export channels for
signed and unsigned conversions.

Ludovic Desroches (3):
  iio:adc:at91-sama5d2: fix typo
  iio:adc:at91-sama5d2: fix identation
  iio:adc:at91-sama5d2: add support for signed conversion

 drivers/iio/adc/at91-sama5d2_adc.c | 101 ++++++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 24 deletions(-)

-- 
2.5.0

