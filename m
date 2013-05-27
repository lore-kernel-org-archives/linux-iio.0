Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48315 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3E0TMS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 May 2013 15:12:18 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>
Subject: am335x: touch & adc patches
Date: Mon, 27 May 2013 21:11:47 +0200
Message-Id: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

this is basicall a repost of the recent series. It dependent on a few
patches which were not merged yet but I assuemd otherwise.
This series now includes a reworked version of them and contains:
- pending touchscreen patche (patches 1-3, 5)
- support device tree and removal of platform device structres. The am335x
  platform is DT so there is no need for it.
- small clean ups here and there.

Sebastian

