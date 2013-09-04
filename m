Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38372 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491Ab3IDNCD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Sep 2013 09:02:03 -0400
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <jbe@pengutronix.de>)
	id 1VHCig-000132-13
	for linux-iio@vger.kernel.org; Wed, 04 Sep 2013 15:02:02 +0200
Received: from jbe by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <jbe@pengutronix.de>)
	id 1VHCif-00023L-Vl
	for linux-iio@vger.kernel.org; Wed, 04 Sep 2013 15:02:01 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-iio@vger.kernel.org
Subject: [RFC] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Wed,  4 Sep 2013 15:01:41 +0200
Message-Id: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following series replaces the current busy loop touchscreen implementation
by a fully interrupt driven implementation.

Since i.MX23 and i.Mx28 silicon is different, the existing implementation can
be used for the i.MX28 SoC only.

So, the first two patches of this series move the i.MX28 specific definitions
out of the way. Then the i.MX23 specific definitions are added, also the code
to distinguish both SoCs at run-time.
Up to here the existing driver will also run on an i.MX23 Soc now.

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

Comments are welcome.

Juergen

