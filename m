Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:48360 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab1GVJyn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jul 2011 05:54:43 -0400
Message-ID: <4E2948E7.7080908@cam.ac.uk>
Date: Fri, 22 Jul 2011 10:54:47 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jon Brenner <jbrenner@taosinc.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: 64 bit event code. How to split up?
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Given Michael has already run out of space in our 32 bit event code I suggest
we bite the bullet and move over to a 64 bit one now.  I doubt there is much
userspace code in place so this shouldn't be 'too' painful.

So to start the ball rolling, how about the following split.
The final will probably still be a macro of doom.  Bitfields get a bit
confusing cross architectures.  I 'think' the following should even
be fine of arm oabi (IIRC that has 4 byte alignment for structures).

The following avoids all the conditionals we currently have in the macro.
It costs us space, but we have more of that. Note we'll need to add
a NO_MOD modifier and add 1 to all the modifier codes.  It should also
allow us to use enums for everything.

/**
 * iio_event - general purpose event to userspace.
 * @time: timestamp
 * @chan: index of non differential channel
 * @chan1: index of first end of differential channel
 * @chan2: index of second end of differential channel
 * @chan_type: an iio_chan_type (we currently have 15)
 * @modifier: currently we interleave several types of these (axial, light).
 *            having this much space would allow us to relax that and lead to
 *            simpler code.
 * @direction: currently only 3, but definitely want level versions as well.
 * @type: event type (currently thresh, mag, roc). Can see we will have more
 *        of these.
 */

struct iio_event {
        int64_t time;
	union {
		unsigned chan:32;
		struct {
			unsigned chan1:16;
			unsigned chan2:16;
		};
	};
	unsigned chan_type:8;
	unsigned modifier:8;
	unsigned direction:8;
	unsigned type:8;
};

So the question is, is this rough and ready distribution of bits good
enough, or do we need more channel types for example at the cost of some
directions?

I'll hack some patches based on this together shortly so we can see what
other cleanups it allows.

Jonathan
