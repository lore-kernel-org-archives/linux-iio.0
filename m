Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:45857 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbbJIQ1V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 9 Oct 2015 12:27:21 -0400
Received: from mfilter25-d.gandi.net (mfilter25-d.gandi.net [217.70.178.153])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 88767FBDBA
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2015 18:27:19 +0200 (CEST)
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter25-d.gandi.net (mfilter25-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id mKDCbr_6LSHr for <linux-iio@vger.kernel.org>;
	Fri,  9 Oct 2015 18:27:18 +0200 (CEST)
Received: from coal (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
	(Authenticated sender: hadess@hadess.net)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AE8CEFBDDE
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2015 18:27:17 +0200 (CEST)
Message-ID: <1444408033.28661.43.camel@hadess.net>
Subject: User-space API again, detecting devices
From: Bastien Nocera <hadess@hadess.net>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Fri, 09 Oct 2015 18:27:13 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey,

I have a couple of bugs filed against iio-sensor-proxy where the
problem is in my code's wrong way of doing device detection.

I want to detect compasses, accelerometers, and ambient light sensors,
both those using triggers, and those that require polling. I'll try to
answer my own questions, and you can tell me whether I'm wrong.

To detect accelerometers:
- Check whether in_accel_x, in_accel_y and in_accel_z files exist

To detect ambient light sensors:
- Check whether in_intensity_both, or in_illuminance_input or
in_illuminance_raw exists (the intensity one looks wrong...)

To detect compasses:
- Check whether in_rot_from_north_magnetic_tilt_comp exists

To detect whether the device needs polling, or has a trigger, construct
a trigger name like <name>-dev<device number> for example, magn_3d-
dev0.

Is that all correct?

Cheers
