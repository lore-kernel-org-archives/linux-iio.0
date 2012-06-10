Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:57983 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005Ab2FJWjc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 10 Jun 2012 18:39:32 -0400
Received: from sirene.lan (83-215-0-241.stadt.dyn.salzburg-online.at [83.215.0.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pmeerw)
	by pmeerw.net (Postfix) with ESMTPSA id BEF8BC50173
	for <linux-iio@vger.kernel.org>; Mon, 11 Jun 2012 00:39:30 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Subject: iio: vcnl4000 ALS/proximity driver
Date: Mon, 11 Jun 2012 00:39:20 +0200
Message-Id: <1339367961-22456-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I'm submitting a minimal, work-in-progress driver for the 
Vishay VCNL4000 combined ambient light/proximity sensor to -staging

the driver is missing a way to adjust the IR current determining 
the range for proximity sensing

is scale/calibscale desirable?
I am lost with the meaning and use of IIO modifiers...

ultimately, periodic proximity sensing and thresholding with event 
handling should be implemented... I do have a misc/input driver for 
that but want to built upon IIO

