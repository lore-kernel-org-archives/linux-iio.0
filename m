Return-Path: <jbe@pengutronix.de>
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devel@driverdev.osuosl.org,
	marex@denx.de,
	fabio.estevam@freescale.com,
	jic23@cam.ac.uk
Subject: [RFCv2] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Fri,  6 Sep 2013 12:08:38 +0200
Message-Id: <1378462123-4830-1-git-send-email-jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

The following series replaces the current busy loop touchscreen implementation
for i.MX28/i.MX23 SoCs by a fully interrupt driven implementation.

Since i.MX23 and i.Mx28 silicon differs, the existing implementation can
be used for the i.MX28 SoC only.

So, the first two patches of this series move the i.MX28 specific definitions
out of the way. Then the i.MX23 specific definitions are added, also the code
to distinguish both SoCs at run-time.
Up to here the existing driver will now run on an i.MX23 Soc as well.

When the i.MX23 SoC is running from battery it seems not to be a good idea to
run a busy loop to detect touches and their location. The fourth patch adds a
fully interrupt driven implementation which makes use of the built-in delay
and multiple sample features of the touchscreen controller. This will reduce
the interrupt load to a minimum.

The last patch in this series just removes the existing busy loop
implementation.

Some restrictions:

- yet tested on i.MX23 SoC only
- touchscreen parametrisation ability is provided (with fixed values for now)
  but should be done via device tree. Some recommendations how to define the
  bindings would be helpful

Changes since v1:

- adding register access functions to make the existing code more readable
- adding some functions to distinguish the SoCs at run-time to avoid if-else
  contructs whenever differences in the register layout between i.MX23 and
  i.MX28 must be handled

Comments are welcome.

Juergen
