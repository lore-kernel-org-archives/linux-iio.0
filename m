Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:38194
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759057Ab3BMTMx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Feb 2013 14:12:53 -0500
From: "Getz, Robin" <robin.getz@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Userspace libs
Date: Wed, 13 Feb 2013 14:12:57 -0500
CC: Lars-Peter Clausen <lars-peter.clausen@analog.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201302131412.58742.robin.getz@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan:

We made an "iio-scope" - a real time visualiser which runs natively on the 
embedded hardware. The application supports plotting of the captured data in 
three different modes (time domain, frequency domain and constatation).

Description (and screen shots) are at:
http://wiki.analog.com/resources/eval/user-guides/ad-fmcomms1-ebz/software/linux/applications/iio_scope

Source is at:
https://github.com/analogdevicesinc/iio-oscilloscope

As you can see, it includes some of your code:
https://github.com/analogdevicesinc/iio-oscilloscope/blob/master/iio_utils.h
Which (I think) is still in ./staging/iio/Documentation/ [1]

We build on some of that:
https://github.com/analogdevicesinc/iio-oscilloscope/blob/master/iio_utils.c

Which really isn't specific to the scope, and could be pushed to where ever we 
decide the .h file lives (this is a question/suggestion).

We also have a network stack for IIO.
http://wiki.analog.com/resources/tools-software/linux-software/iio_cmdsrv

https://github.com/analogdevicesinc/iio-cmdsrv

I would like to re-write some of the existing iio-utils.h (so iio device 
context is managed by the application), to become a little more thread 
friendly, and also merge in some of the networking piece - so when using a 
headless embedded device - userspace doesn't need to change/manage things 
much.

Is there a list of other things people want to see from userspace? [2]

-Robin

[1] Which reminds me - is this planned on moving out 
of ./drivres/staging/iio/Documentation  into ./Documentation/iio ?

[2] I have been going through:
  - zio-dump   http://www.ohwr.org/projects/zio/wiki/Readme
  - Comedilib  various
?

