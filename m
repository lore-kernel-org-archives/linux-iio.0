Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:40560 "EHLO
	ppsw-30.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab0IWNER (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Sep 2010 09:04:17 -0400
Message-ID: <4C9B5191.9050407@cam.ac.uk>
Date: Thu, 23 Sep 2010 14:09:37 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: RFC: Building event codes from the event type.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


This proposal is based on an observation of Manuel's that
we could construct all of our event codes in a much more
logical fashion by breaking them up into a series of bit
fields within the event code.

So lets define this as a structure for the purposes of this
discussion.  The eventual implementation would probably be
done with macros.

I'm assuming it makes sense to have a single 32bit number
as the event code. Sorry for the abuse of kernel doc.
I have no idea how one actually documents unions or structures
within structures. 

/**
 * iio_event_code - structure representing an event
 * @sensor_type: 256 codes for different classes of sensors
 *   - accel, gyro, in, light etc.
 * @directedornot: Tells us whether the modifier is for a sensor
 *   with axes or one where this doesn't make sense.
 * @modifier: identify which channel 
 *    @directed: modifier for sensor where an axis makes sense
 *        @direction: 16 different directions, x, y, z + compound
 *                    versions x|y|z x|y x|z y|z x&y&z x&y x&z y&z
 *        @number: allow up to 8 sensors in a given direction if
 *                  it is a sensor where direction makes sense.
 *    @number: for sensor where axis doesn't make sense allow 128 channels
 * @type: thresh, mag, roc + specific things like free fall etc.
 * @direction: falling or rising or either.  (so there are some spare bits here).
 **/  
struct iio_event_code {
	unsigned sensor_type:8;
	union {
		unsigned directedornot:1;
		struct {   		
		unsigned direction:4;
		unsigned number:3;
		} directed;
		unsigned number:7; 
	} modifer;
	unsigned type:8;
	unsigned direction:8;
};

So would people be happy with this rough approach. + please comment on the
exact layout and in particular point out classes of event that do not fit.

The interpretation of everything after sensor_type for buffer events will
probably have to be separately defined. It would complicate this too much.

Given the resounding silence that followed my recent post asking for wider
opinions on naming of such events (to lkml), I'll probably just get on with
implementing the scheme we suggested there for naming the attributes etc.

Thanks,

Jonathan
