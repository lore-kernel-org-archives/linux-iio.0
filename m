Return-Path: <lars@metafoo.de>
Message-ID: <4EA56C67.7020203@metafoo.de>
Date: Mon, 24 Oct 2011 15:47:19 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Channel-less IIO events
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi,

Some chips generate events which don't really map to a channel, but are
rather chip global. For example over-temperature events.
Do you think this is something we should add support for or should we rather
use a dummy channel, which doesn't report any actual values, for propagating
the event?

My idea for supporting channel-less events is to add a event_mask to struct
iio_info, which would be used just like a channels event_mask, but there
would be no index for the sysfs attributes and for events we would set the
event number to 0xffff.

Thanks
- Lars
