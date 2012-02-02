Return-Path: <jic23@hermes.cam.ac.uk>
Date: 02 Feb 2012 14:15:57 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@suse.de>,
    devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
    Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 5/6] staging:iio:events: Use non-atomic bitops
Message-ID: <Prayer.1.3.4.1202021415570.18883@hermes-2.csi.cam.ac.uk>
In-Reply-To: <20120202114922.GE24652@mwanda>
References: <1328121956-29596-1-git-send-email-lars@metafoo.de>
 <1328121956-29596-6-git-send-email-lars@metafoo.de>
 <20120202062053.GC24652@mwanda>
 <4F2A53F1.3020304@metafoo.de>
 <20120202111916.GT3356@mwanda>
 <20120202114922.GE24652@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Feb 2 2012, Dan Carpenter wrote:

>On Thu, Feb 02, 2012 at 02:19:16PM +0300, Dan Carpenter wrote:
>> On Thu, Feb 02, 2012 at 10:14:25AM +0100, Lars-Peter Clausen wrote:
>> > I don't think there is any real performance improvement to be expected of
>> > this patch. If you have good a reason why non-atomic bitops should not be
>> > used I guess this patch could be dropped.
>> 
>
>Actually perhaps it's better to apply this because the code is
>already tricky and the double underscores serve as a reminder.
>I'm fine with this change.
>
>Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
>
>You could also remove the "/* Does anyone care? */ from
>iio_push_event() because we do care.
>
Ah, that one was my bad. Probably written way to late in the evening.
It  isn't meant to be a comment about the code, but rather a description
of what is being checked!  Literally 'This is checking whether there is anyone
listening'.

Jonathan
