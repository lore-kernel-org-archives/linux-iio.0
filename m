Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from argos.tuxed.org ([176.9.87.227]:40106 "EHLO argos.tuxed.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbcALSRf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 12 Jan 2016 13:17:35 -0500
From: Alexander Koch <mail@alexanderkoch.net>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mhornung.linux@gmail.com, dannenberg@ti.com, balbi@ti.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Koch <mail@alexanderkoch.net>
Subject: [PATCH 0/2] iio: light: opt3001: Enable operation w/o IRQ
Date: Tue, 12 Jan 2016 19:09:38 +0100
Message-Id: <1452622180-12728-1-git-send-email-mail@alexanderkoch.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series aims at enabling IRQ-less operation for the TI OPT3001 light
sensor.

The current version of the driver requires an interrupt line to be connected to
the INT pin of the sensor, through which the IIO framework gets notified about
readout values being ready. In the datasheet this is described as optional (sec.
8.1.1).

In my use case of the OPT3001 I do not have any interrupt lines or GPIOs
available to connect the INT pin to, so I have implemented an interrupt-less
operation mode that simply sleeps for the specified worst-case readout time
instead of waiting for the interrupt.

This change is transparent as interrupt-less operation mode is done only when no
valid interrupt no. is configured via device tree.

Patches are taken against linux-next/master, tested by compilation,
checkpatch.pl and by running on an embedded developer board (both IRQ-enabled
and IRQ-less mode).


Alexander Koch (2):
  iio: light: opt3001: extract int. time constants
  iio: light: opt3001: enable operation w/o IRQ

 drivers/iio/light/opt3001.c | 152 ++++++++++++++++++++++++++++++--------------
 1 file changed, 104 insertions(+), 48 deletions(-)

-- 
2.7.0

