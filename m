Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37494 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313Ab3AFEez (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 5 Jan 2013 23:34:55 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1Trhwu-0000xY-NT
	for linux-iio@vger.kernel.org; Sun, 06 Jan 2013 05:35:05 +0100
Received: from pool-173-48-160-45.bstnma.fios.verizon.net ([173.48.160.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Sun, 06 Jan 2013 05:35:04 +0100
Received: from arsenix by pool-173-48-160-45.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Sun, 06 Jan 2013 05:35:04 +0100
To: linux-iio@vger.kernel.org
From: James Peverill <arsenix@gmail.com>
Subject: IIO for soft realtime control?
Date: Sun, 6 Jan 2013 04:31:41 +0000 (UTC)
Message-ID: <loom.20130106T050717-736@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


I have been working on realtime robotics under Linux, and just learned about
iio. It seems like many great hardware drivers are being written (some of which
I had started working on in parallel), and it would be great if I could
integrate what I am working on with iio. It seems mostly targeted at streaming
data acquisition and output, but also includes triggering and event support. Has
there been any thought to running realtime control loops using the iio
subsystem? For this application I would be reading from sensors (i2c interface
accelerometers etc) in the 10's of hz (ideally at least 50) and then updating
actuator outputs.

Any thoughts on the feasibility? I would probably accomplish this by writing a
kernel driver to glue the input iio devices to the output. I'm not sure what
type of latency and jitter would result from this configuration, but this could
limit the applications.

