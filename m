Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42833 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472Ab3FWV5m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Jun 2013 17:57:42 -0400
Date: Sun, 23 Jun 2013 23:57:39 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org
Subject: patches
Message-ID: <alpine.DEB.2.01.1306232331490.27567@pmeerw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

I just posted two patch series;

one to add two features to the mcp4725 dac driver

1/4 iio: add store_eeprom to mcp4725 dac driver
2/4 iio: add powerdown to mcp4725 dac driver
3/4 iio: add DAC 500kohm_to_gnd to possible powerdown_modes
4/4 iio: move ABI specification for store_eeprom

and some cleanups

1/5 iio: fix typos in dac Kconfig
2/5 iio: use I2C_FUNC_SMBUS_I2C_BLOCKmacro
3/5 iio: fix Kconfig typos
4/5 iio: remove mention of ring-buffer from CONFIG_IIO_KFIFO
5/5 iio: reword help text of several IIO_ST drivers

further, I'm working on drivers for tsl45315 (ALS) and ds1077 
(oscillator); si114x is also still in the queue

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
