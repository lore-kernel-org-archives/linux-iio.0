Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:41581 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab1HDLUq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2011 07:20:46 -0400
Message-ID: <4E3A826F.1050008@cam.ac.uk>
Date: Thu, 04 Aug 2011 12:28:47 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: RFC: Event attributes. How to handle the options.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Just thinking about how to handle the various controls associated with
events (motivated by looking at cases where the chan_spec stuff isn't
being used and why it isn't).

1) Not all drivers can turn events on or off. For consistency lets have
  the _en attributes for these anyway, but make them return 1 in all
  cases and read only.  Lets make write_event_config optional and for
  devices where some events are controllable and others not the
  write_event_config will just return -EINVAL for when it can't control
  the event.

2) Hysteresis - a number of drivers have _hyst_raw attributes.  We could
   actually have these for all events and set the value to 0 if
   the device doesn't support controlling this.

3) Period (how long a threshold must be crossed for before event occurs).
  This is in the abi and used in a few drivers.  Again we might want to have
  the attribute for all events.  If they will cause the interrupt on the
  next sample we output 0 and don't allow writing.

Now if we decide we only want these exported in drivers where they aren't
both zero,the questions come down how to implement them?

We could do something similar to the info_mask element of chan_spec, but things
get really tricky if we have some events with some extra elements and others without.

On option that occurs is a pointer to an array of (array terminated by an element with
a 0 mask. If the pointer is null, only value attribute exists.  All current events are
meaningless without a value.

enum {
	IIO_EVENT_INFO_HYST_SEPARATE,
	IIO_EVENT_INFO_HYST_SHARED,
	IIO_EVENT_INFO_PERIOD_SEPARATE,
	IIO_EVENT_INFO_PERIOD_SHARED
};

struct iio_event_info {
	const long mask,
	const long elements,
};

If all events available have the same controls associated with them we have

const struct iio_event_info deviceeventinfo[] = {
	{ <mask that matches the event mask>, IIO_EVENT_HYST_SEPARATE | IIO_EVENT_INFO_PERIOD_SEPARATE },
{}
};

>>From that we can construct everything we need.
Taking a device where period only applies to say ROC events we might have:

const struct iio_event_info deviceeventinfo[] = {
{
	IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) | IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
  	IIO_EVENT_INFO_HYST_SEPARATE },
{
	IIO_EV_BIT(IIO_EV_TYPE_ROC, IIO_eV_DIR_RISING) | IIO_EV_BIT(IIO_EV_TYPE_ROC, IIO_EV_DIR_FALLING),
	IIO_EVENT_INFO_HYST_SEPARATE | IIO_EVENT_INFO_PERIOD_SEPARATE },
{}
};

We can also be a little more fine grained here in allowing extra enum elements such as
IIO_EVENT_INFO_HYST_CHANNEL_SHARED, which will specify that the hysteresis value is shared
across all events on a channel (occurs in the ad7998 for starters).

Note that this structure will also cover what is in the existing event_mask element so
we could get rid of that.

Clearly the event callbacks for setting values would need a little more information to be passed so one could
cover all such IIO_EVENT_INFO_*.

Anyhow, something to think about.

Jonathan
