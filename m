Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bytesatwork.ch ([91.135.72.15]:33474 "EHLO bytesatwork.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837AbbERNWu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 May 2015 09:22:50 -0400
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bytesatwork.ch>
To: jic23@kernel.org, angelo.compagnucci@gmail.com,
	urs.fassler@bytesatwork.ch
Cc: iivanov@mm-sol.com, ezequiel.garcia@imgtec.com,
	jacob.jun.pan@linux.intel.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: adc128s052: add support for adc122s021
Date: Mon, 18 May 2015 15:22:43 +0200
Message-Id: <1431955364-25059-1-git-send-email-urs.fassler@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes in version 2:
- leave vendor prefix in compatible string of device tree
  (and rendering indention problem obsolete)
- add link to datasheet

Urs Fässler (1):
  iio: adc128s052: add support for adc122s021

 .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |  4 +--
 drivers/iio/adc/Kconfig                            |  4 +--
 drivers/iio/adc/ti-adc128s052.c                    | 30 +++++++++++++++++-----
 3 files changed, 28 insertions(+), 10 deletions(-)

-- 
2.1.4

