Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:56887 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab1HARN7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Aug 2011 13:13:59 -0400
Message-ID: <4E36E0B7.3070900@cam.ac.uk>
Date: Mon, 01 Aug 2011 18:21:59 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: IIO: Interface for capacitance inputs (and outputs)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Michael / All,

We have a quite a few capacitance drivers. They are all simple and so
would be easy to clean up, except for the fact that we don't have an abi
for them.

So lets make one up. How about the following?  Main choice is the units...
Doing it with Farads leaves us with a lot of needed decimal places, but then
we need a lot anyway for these so what the heck.  We are going to need those
types with holes in them..

What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
What:		/sys/bus/iio/devices/iio:deviceX/out_capacitanceY_raw
What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY-capacitanceZ_raw
KernelVersion:	3.1
Contact:	linux-iio@vger.kernel.org
Description:
		Raw (unscaled no bias removal etc) capacitance value from/to
		channel Y. After application of _offset and _scale, units will
		be Farads.

Additional entries for:

What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_offset
What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_scale


With the ad7745 the capdac does seem to be available off chip. If I understand
their use correctly it could just be treated as a _calibbias parameters?
(the complexity being that there are two..)  Naturally there is also a
calibration register so this gets somewhat tricky...  Is there an optimum
combination for a given desire measurement range?


All comments welcom.

Jonathan
