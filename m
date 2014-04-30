Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:19769 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757359AbaD3J2s (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Apr 2014 05:28:48 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, lars@metafoo.de, cpgs@samsung.com,
	grundler@chromium.org, t.figa@samsung.com
Subject: [PATCH 0/5 v3] iio: exynos_adc: fix minor nits in the driver
Date: Wed, 30 Apr 2014 14:56:50 +0530
Message-id: <1398850015-17761-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset fixes the 
1. bug causing a crash during module removal for exynos_adc.ko.
-> The bug was seen by Doug, while trying to compile the whole IIO subsystem
   as module @ https://lkml.org/lkml/2014/4/21/481 from Doug.

2. rearrange the clock and regulator enable/disable calls during
   probe, remove, suspend and resume calls
-> Comments give by Jonathan @ https://lkml.org/lkml/2014/4/23/644

3. reduces the timeout and uses wait_for_completion_timeout instead of the
   interruptible varient.
-> This change was under review @ https://lkml.org/lkml/2013/11/5/92
   Final comments were given by Tomasz, to split and submit.

Naveen Krishna Ch (2):
  iio: exynos_adc: use indio_dev->dev structure to handle child nodes
  iio: exynos_adc: rearrange clk and regulator enable/disable calls

Naveen Krishna Chatradhi (3):
  iio: exynos_adc: reduce timeout and use wait_for_completion_timeout
  iio: exynos_adc: do a soft reset in case of timeout
  iio: exynos_adc: do a reinit_completion before the conversion

 drivers/iio/adc/exynos_adc.c |  137 +++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 63 deletions(-)

-- 
1.7.9.5

