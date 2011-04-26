Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:49688 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756997Ab1DZQLW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Apr 2011 12:11:22 -0400
Message-ID: <4DB6EF2D.9090704@cam.ac.uk>
Date: Tue, 26 Apr 2011 17:13:33 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Oddities and how to handle them.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Michael,

I'm trying to squash the remaining drivers that don't build after
all the changes in iio-onwards.  A couple of odd cases have come
up.

ad7291 - has two similar concurrent event measurements on the same temperature channel.
One is almost a windowed average, but not quite. The other based on raw value.
I'm not sure what event code we should generate for them to differentiate between
them.  So for now I just have both producing a generic temperature threshold event.
(filtering on data isn't covered by our abi's yet, let alone on event detectors!)

ad7745 - slow capacitance adc.  This one actually makes a possibly valid use of the
buffer event codes.  It is slow enough that it may make sense to notify userspace
that a new reading is available (90Hz).  I'd prefer to see this happen by just allowing
polling on the sysfs attributes though. I have no means to testing this one, and such
a change is a little more invasive than I like to make without hardware!

adt7310 - should be in hwmon as far as I can see.... + it's abusing our interfaces
so I don't like it ;)  For now I've squashed the events into basic temp events.
adt7410 - the same.

adt7316 - The fault condition on the external temperature sensor isn't an event that
one should ever see unless something is horribly wrong.  I'd be inclined to copy the
hwmon interface for this and do it as an alarm sysfs attribute... I don't think it
belongs in out main event path...  For now I've removed it's ability to be reported at all.

 
ade7758 - Complex driver I'm not that keen on touching without a lot of testing support.
Don't suppose you want to take this one Michael? (*looks hopeful*)  At lease blugeoning
it into more or less current interfaces would be a great help. I can do it, but then I
suspect I'll break it in a few exciting ways :(

So all in all, only ad7745 and ade7758 no longer build.

Lots more clean up to be done all over the tree, but I think we are making good progress
in the right direction.

Jonathan
