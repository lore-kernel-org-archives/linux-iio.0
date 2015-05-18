Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bytesatwork.ch ([91.135.72.15]:59757 "EHLO bytesatwork.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbbERMOM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 May 2015 08:14:12 -0400
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bytesatwork.ch>
To: jic23@kernel.org, angelo.compagnucci@gmail.com,
	urs.fassler@bytesatwork.ch
Cc: iivanov@mm-sol.com, ezequiel.garcia@imgtec.com,
	jacob.jun.pan@linux.intel.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc128s052: add support for adc122s021
Date: Mon, 18 May 2015 14:04:35 +0200
Message-Id: <1431950676-22379-1-git-send-email-urs.fassler@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support for the 2 channel ADC adc122s021.
Since I only have an adc122s021 at hand, I can not test the adc128s052 part.
Patch is built against v4.1-rc2.

Urs Fässler (1):
  iio: adc128s052: add support for adc122s021

 .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |  6 ++---
 drivers/iio/adc/Kconfig                            |  4 ++--
 drivers/iio/adc/ti-adc128s052.c                    | 27 ++++++++++++++++++----
 3 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.1.4

