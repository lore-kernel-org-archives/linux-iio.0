Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bytesatwork.ch ([91.135.72.15]:41696 "EHLO bytesatwork.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbbLIJa5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 9 Dec 2015 04:30:57 -0500
From: =?UTF-8?q?Oliver=20St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>
To: angelo.compagnucci@gmail.com, jic23@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	=?UTF-8?q?Oliver=20St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>
Subject: [PATCH 0/1] iio:adc128s052: add support for adc124s021
Date: Wed,  9 Dec 2015 10:24:03 +0100
Message-Id: <1449653044-30127-1-git-send-email-oliver.staebler@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This trivial patch adds support for adc124s021, which is a 4-channel version of
the already supported ADC chips.
Built against v4.4-rc4


Oliver Stäbler (1):
  iio:adc128s052: add support for adc124s021

 Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt |  4 ++--
 drivers/iio/adc/Kconfig                                     |  6 +++---
 drivers/iio/adc/ti-adc128s052.c                             | 13 ++++++++++++-
 3 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.4.10

