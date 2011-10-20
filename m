Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:38784 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781Ab1JTQok (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2011 12:44:40 -0400
Message-ID: <4EA04FFD.9080708@cam.ac.uk>
Date: Thu, 20 Oct 2011 17:44:45 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Barry Song <21cnbao@gmail.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Towards a IIO in kernel push interface.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Route plan based on initial messing around today.


This will all be in staging for now as no where
near enough infrastructure is available in the initial
proposed move out of staging. Right now boring though
it is, if anyone has review time please look at those
patches first.

1) We now have basic demux functionality.

2) Need to stop timestamps being special so as to simplify
code paths.

3) Need to support multiple buffers (again - thought they
never really worked before).

4) Bring the inkernel pull interfaces across to staging tree (quick)

5) Create pass through buffer type

6) Interfaces for drivers to instantiate such a pass through.

7) Work out stop and restart for other devices changing the
scan being done.  (fiddly to get right and test).

8) Lots of interface pinning down so clients can query what they
are going to get in response to their channel requests.

So lots of fun to come.  Oh dear.

ps. cc list is drawn from the various threads of the last day or
so that touch on this. 

p.p.s. I'll probably push the demuxer up stream just as soon
as the timestamp issue is sorted as it shouldn't break anything
not explicitly calling it.
