Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:53158 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab1I0NYL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2011 09:24:11 -0400
Message-ID: <4E81D071.5050806@cam.ac.uk>
Date: Tue, 27 Sep 2011 14:32:33 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Amit Kucheria <amit.kucheria@verdurent.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: IIO: ownership of patches taking drivers out of staging.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

I'm putting together a patch set to propose the first step in moving
IIO out of the staging tree.

I want to take a small set (initially) of representative drivers
along for the ride.

Now unlike later elements which will consist of git moves (and hence
preserve history) those that come with us now will be done by
stripping down the drivers and then building their feature set
back up as we go.

My question here is whether people are happy if I assign authorship
of patches for their drivers to them (with appropriate note and
sign off from me to explain where they came from).

Right now my example set consists of

ad799x - Michael's
max1363 - mine :)
tsl2583 - Amit's
adis16400 - Manuel's but with large bits from drivers of mine
	    and Barry Song. I'm fine with it being Manuel's.
	    Copyright notice covers that some of it is Analog's
	    so, Michael, is that fine with you guys?

So I need responses from Amit, Michael and Manuel as to whether
they mind me setting author of relevant drivers to them?  I'd
obviously also like sign offs once you have had time to look
at them. I'll post an updated tree shortly to github.

Thanks,

Jonathan


