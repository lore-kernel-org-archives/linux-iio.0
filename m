Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53219 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab1HRKKG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Aug 2011 06:10:06 -0400
Message-ID: <4E4CE6E6.2010308@cam.ac.uk>
Date: Thu, 18 Aug 2011 11:18:14 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RFC: Does separate types for differential signals make sense?
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Whilst working on some of the capacitance adc drivers yesterday I added a second
differential type.   Whilst we only had IIO_VOlTAGE_DIFF, it seemed easier to
handle it as a special case - now we have IIO_CAPACITANCE_DIFF, I'm not so sure.

The alternative is to add another flag to struct iio_chan_spec and build the
differential names automatically (easy enough I think).  Nastier is how to handle
the related event codes.  As we haven't pushed out the new 64 bit codes, this
is a perfect time to slip in a change there (rather than two changes back to back.)

Current macro to generate codes is:

define IIO_EVENT_CODE(chan_type, modifier, direction,			\
		       type, chan, chan1, chan2)			\
	(((u64)type << 56) | ((u64)direction << 48) | ((u64)modifier << 40) | \
	 ((u64)chan_type << 32) | (chan2 << 16) | chan1 | chan)

So if we were to steal a bit to mark channels as differential, where would we do it?
Obvious choice is in type - reducing max number of types to 128 - can't see that being
a problem any time soon.  Could pinch the top bit off direction instead - that one
has way more values than I can think of uses for...

This is going to be an annoyingly invasive patch to do. I'll probably scrap the
use of the IIO_CHAN macro for all differential channels rather than adding another
parameter to it. Plan was to scrap that macro entirely eventually, so not such a
bad thing.

Jonathan

