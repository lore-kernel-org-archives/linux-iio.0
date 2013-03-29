Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:52416 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab3C2OyU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Mar 2013 10:54:20 -0400
From: <ludovic.desroches@atmel.com>
To: <linux-iio@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <plagnioj@jcrosoft.com>,
	<nicolas.ferre@atmel.com>, <maxime.ripard@free-electrons.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2 0/3] iio: at91_adc: add lowres, sleep and sample&hold time missing support
Date: Fri, 29 Mar 2013 15:54:10 +0100
Message-ID: <1364568853-18561-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

The current adc driver is missing some key feature support
  - select high/low resolution support
  - sleep mode
  - sample and hold Time

v2 changes:
- split dts part
- correct typo and documentation


Jean-Christophe PLAGNIOL-VILLARD (2):
  iio: at91_adc: add sleep mode support
  iio: at91_adc: fix missing Sample and Hold time

Ludovic Desroches (1):
  iio: at91_adc: add low and high res support

 .../devicetree/bindings/arm/atmel-adc.txt          | 13 ++++
 drivers/iio/adc/at91_adc.c                         | 90 ++++++++++++++++++++--
 2 files changed, 98 insertions(+), 5 deletions(-)

-- 
1.7.11.3

