Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:5138 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332Ab0IAWwb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2010 18:52:31 -0400
From: Rhyland Klein <rklein@nvidia.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "jic23@cam.ac.uk" <jic23@cam.ac.uk>
Date: Wed, 1 Sep 2010 15:52:29 -0700
Subject: question about hwo to fit in an ALS driver
Message-ID: <E88A1D35AF5437468E5B14C7C4BA61C702CF4B627B@HQMAIL01.nvidia.com>
Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I am looking into submitting a sensor driver for the isl29018 ambient l=
ight sensor (als). I noticed there is an old isl als driver for a diffe=
rent part (isl29003) in drivers/misc but I also see the light sensor dr=
iver for tsl2653 in the drivers/staging/iio/light directory which seems=
 much more like the correct place for this type of sensor driver to res=
ide.=20

Is this subsystem designed for ALS drivers or a different type of light=
 sensor? If it should support ALS drivers, I don't know how the IIO_DEV=
* attributes should map for this. I suppose it would just use the IIO_D=
EV_ATTR_LIGHT_VISIBLE for the lux, which could work, except that the is=
l29018 also functions as a proximity sensor, and the driver will suppor=
t both modes. =A0What is the proper way to fit a driver like this into =
the iio subsystem?

One thing to note is that there are additional properties other than ju=
st reporting the lux that will need to be supported including changing =
the mode and setting the range, and I am not sure how these should fit =
into the device attribute framework exposed via light.h.

Thanks,
Rhyland

-----------------------------------------------------------------------=
------------
This email message is for the sole use of the intended recipient(s) and=
 may contain
confidential information.  Any unauthorized review, use, disclosure or =
distribution
is prohibited.  If you are not the intended recipient, please contact t=
he sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------=
------------
