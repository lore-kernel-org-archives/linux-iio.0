Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:60590 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070Ab3G0PcE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 27 Jul 2013 11:32:04 -0400
Received: from sirene.lan (83-215-0-241.stadt.dyn.salzburg-online.at [83.215.0.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pmeerw)
	by pmeerw.net (Postfix) with ESMTPSA id E965EC50171
	for <linux-iio@vger.kernel.org>; Sat, 27 Jul 2013 17:31:59 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Subject: 
Date: Sat, 27 Jul 2013 17:31:43 +0200
Message-Id: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

here's a patch series to clean up the hmc5843 magnetometer driver in
staging; the driver still has some extra attributes:

measurement configuration: used only for testing I think

operating mode: single vs. continuous conversion, also allows idle and sleep mode 
(which should not be exposed to user-mode I think); the data ready irq and buffered mode is not
implemented; the driver/chip runs in continues conversion mode by default

in_magn_range: some kind of gain, could probably use HARDWAREGAIN?

sampling_frequency: well-known, OK              
sampling frequency_available, well-known, OK

otherwise, look clean to me...

regards, p.

