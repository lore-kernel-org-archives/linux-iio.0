Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:58386 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab1EDJfa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2011 05:35:30 -0400
Message-ID: <4DC11E71.4050407@cam.ac.uk>
Date: Wed, 04 May 2011 10:37:53 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Amit Kucheria <amit.kucheria@verdurent.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RFC small change to tsl2563 event interface.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Amit,

As part of moving to an registration of IIO channels through
a table of iio_chan_spec structures, I'm proposing to make
a small change to the event interface for the tsl2563 driver.

Currently it has 

 intensity0_both_thresh_en as a single sysfs attr enabling both
rising and falling attributes (which have separate value attributes).

I propose changing this to a pair of attrs which are interlinked
(e.g. change one and you'll change the other - our interface
spec has always allowed this as it's vital in more complex
interlinked event cases).

intensity0_both_thresh_falling_en     intensity0_both_thresh_rising_en

It removes a fiddly special case (which I haven't figured out how to
do!) from the core code.

Any objections to this?

Thanks,

Jonathan
