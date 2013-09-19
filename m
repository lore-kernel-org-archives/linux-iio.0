Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34673 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab3ISMW5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2013 08:22:57 -0400
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
	marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk
Subject: [PATCHv5] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Thu, 19 Sep 2013 14:22:42 +0200
Message-Id: <1379593369-22010-1-git-send-email-jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following series replaces the current busy loop touchscreen implementation
for i.MX28/i.MX23 SoCs by a fully interrupt driven implementation.

Since i.MX23 and i.MX28 silicon differs, the existing implementation can
be used for the i.MX28 SoC only.

So, the first two patches of this series move the i.MX28 specific definitions
out of the way. The third patch simplifies the register access to make it easier
to add the i.MX23 support. Then the i.MX23 specific definitions are added, also
the code to distinguish both SoCs at run-time.
Up to here the existing touchscreen driver will now run on an i.MX23 Soc as well.

When the i.MX23 SoC is running from battery it seems not to be a good idea to
run a busy loop to detect touches and their location. The fourth patch adds a
fully interrupt driven implementation which makes use of the built-in delay
and multiple sample features of the touchscreen controller. This will reduce
the interrupt load to a minimum.

The next to last patch in this series just removes the existing busy loop
implementation.

The last patch adds a devicetree bindings proposal (to be discussed).

Some restrictions/questions:

- the touchscreen part is yet tested on i.MX23 SoC only
- has someone a good idea how to implement a reliable pressure measurement if
  the resistances of the touchscreen's plates are unknown?

Changes since v4:

- honor Jonathan's comments about function names
- honor Dmitry's comments about workqueue canceling and interrupts
- adding devicetree bindings proposal

Changes since v3:

- split adding register access functions and i.MX23 support into two patches

Changes since v2:

- useless debug output removed

Changes since v1:

- adding register access functions to make the existing code more readable
- adding some functions to distinguish the SoCs at run-time to avoid if-else
  contructs whenever differences in the register layout between i.MX23 and
  i.MX28 must be handled

Comments are welcome.

Juergen

