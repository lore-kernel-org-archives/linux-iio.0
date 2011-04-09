Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:56799 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab1DISVr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Apr 2011 14:21:47 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:52505)
	by ppsw-51.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1Q8cn1-00065o-ZG (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Sat, 09 Apr 2011 19:21:43 +0100
Message-ID: <4DA0A420.8060302@cam.ac.uk>
Date: Sat, 09 Apr 2011 19:23:28 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RFC How to handle device with different _scale values depending on
 how you access them.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear All,

I'm messing with my favourite 'special' device, the sca3000.

It has a hardware ring buffer and direct read abilities.

Direct reads of current value are 13bit signed, the buffer
is either 11 bit or 8 bit.

So ultimately the scale on the buffer can change which is
nasty enough, however direct reads are 13bits whatever
the buffer is set to.

Hence we need to export two scale's at a time.

Would anyone mind if I add the option to have both

/device0/accel_scale (applies to _raw files in the same dir).
and
/device0/device0:buffer0/accel_scale (or maybe put it
in the 'scan_elements' directory?

This means we will have to define a precedence for these
attributes when reading from buffers which isn't nice, but
such is life...

Jonathan
