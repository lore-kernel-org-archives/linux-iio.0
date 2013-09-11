Return-Path: <jbe@pengutronix.de>
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devel@driverdev.osuosl.org,
	marex@denx.de,
	fabio.estevam@freescale.com,
	jic23@cam.ac.uk
Subject: [RFCv4] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Wed, 11 Sep 2013 10:18:25 +0200
Message-Id: <1378887511-24530-1-git-send-email-jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

The following series replaces the current busy loop touchscreen implementation
for i.MX28/i.MX23 SoCs by a fully interrupt driven implementation.

Since i.MX23 and i.Mx28 silicon differs, the existing implementation can
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

The last patch in this series just removes the existing busy loop
implementation.

Still some restrictions/questions:

- the touchscreen part is yet tested on i.MX23 SoC only
- touchscreen parametrisation ability is provided (with fixed values for now)
  but should be done via device tree. Some recommendations how to define the
  bindings would be helpful
- has someone a good idea how to implement a reliable pressure measurement if
  the resistances of the touchscree's plates are unknown?

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
