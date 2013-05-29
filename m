Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57925 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759694Ab3E2RKD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 May 2013 13:10:03 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: sameo@linux.intel.com, jic23@cam.ac.uk, dmitry.torokhov@gmail.com,
	balbi@ti.com
Subject: am335x adc & tsc, second batch
Date: Wed, 29 May 2013 19:09:51 +0200
Message-Id: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

this basically fixes a few issues when TSC and ADC are used at the same
time. One issues was found in the TSC part where it used one wrong
coordinate while reading from the FIFO.

This depends on the series I sent the 19 patchset I sent earlier.
The complete series can be found at
 git://git.breakpoint.cc/bigeasy/linux.git am335x_tsc_adc

Sebastian

