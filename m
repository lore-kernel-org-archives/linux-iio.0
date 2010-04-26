Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:59550 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab0DZUNm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Apr 2010 16:13:42 -0400
Message-ID: <4BD5F4A8.7020309@cam.ac.uk>
Date: Mon, 26 Apr 2010 21:16:40 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "Song, Barry" <Barry.Song@analog.com>,
	"Zhang, Sonic" <Sonic.Zhang@analog.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: IIO driver merge plans (for next merge window)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

It is getting to that point of the kernel development cycle where we
want to start thinking about which drivers to push out to Greg in
plenty of time for the next merge window.  If possible I'd like to
see some of them moving over to the new abi.  However, given we are
in staging anyway, we can always merge them first and change them
later!  Obviously the question of whether the abi changes merge
in time is down to what feedback they generate so that may further
complicate things.

I see there are loads from Analog in the blackfin tree and based on
a quick glance at the source they are all in pretty good state.  The
only holes I can see are possibly in documentation and that is probably
more a case of adding things to the abi docs (in my latest patch set)
than anything else.

Barry, Sonic, Michael, what are your current plans for mainlining?
(as much as staging is mainline anyway)

I see you guys have started adding ring support.  How are you finding
that element?  I'm still far from sure we have gotten that bit right
yet!  I'm going to have a play with the new FIFO implementation and
see if that provides at the very least and easier to review alternative
to the current buffer.

Would also be great to start merging DAC and DDS support from your tree and
finally justify the output element of IIO.

I know Manuel has a couple of drivers as well. Sorry to anyone I have
forgotten.  Please post your drivers!

If people want assistance with moving over to the new abi, then I'm happy
to convert drivers, but obviously would need people to test that I haven't
broken anything in the process.

With a bit of luck I'll clean up a few half written drivers I have
and perhaps look at pulling in the other light sensors now that ALS
has bitten the dust.

Looking forward to seeing lots of drivers!

Thanks,

Jonathan

p.s. If anyone has a chance to glance over the latest patch set, that would
be great.
