Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:41396 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab1JXOZE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2011 10:25:04 -0400
Message-ID: <4EA57547.3010804@cam.ac.uk>
Date: Mon, 24 Oct 2011 15:25:11 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Channel-less IIO events
References: <4EA56C67.7020203@metafoo.de>
In-Reply-To: <4EA56C67.7020203@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/11 14:47, Lars-Peter Clausen wrote:
> Hi,
> 
> Some chips generate events which don't really map to a channel, but are
> rather chip global. For example over-temperature events.
That one is a channel.
> Do you think this is something we should add support for or should we rather
> use a dummy channel, which doesn't report any actual values, for propagating
> the event?
Yup, have a temp channel for that one.  Conceptually you might have two chips
that are otherwise identical but one has a readable temp channel, the other
doesn't.  Userspace that is interested only in events won't care about
this difference.  Also we want to report what the conditions are as if it were
a channel we could read.  We want to know at what temperature this occurs.

There are others events such as loss of tracking / wire out for the resolvers,
but they so far have always corresponded to 'gah, it's all gone wrong' events.
Last time I asked more generally about this, Alan Cox suggested using the
signals typically employed for network sockets.  General view is we didn't
want them coming through our normal event path and for example being blocked
behind the handling of another event.  I then got bogged down with this
in kernel interface stuff so haven't looked at it again.
> 
> My idea for supporting channel-less events is to add a event_mask to struct
> iio_info, which would be used just like a channels event_mask, but there
> would be no index for the sysfs attributes and for events we would set the
> event number to 0xffff.
Could you give more examples?  The temp one to my mind definitely needs a
channel, perhaps others do not?  I am not against in principal but not
yet certain exactly when this would make sense...
> 
> Thanks
> - Lars
> 

