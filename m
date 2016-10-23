Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57362 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752845AbcJWJxm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2016 05:53:42 -0400
Subject: Re: [RFC] multipixel infrared thermopile sensors
To: Matt Ranostay <matt@ranostay.consulting>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
References: <CAJ_EiSQ0KEXOqNOQvqcaF5=f-TJtxZNsWs39k6gHuzN_f1OT7w@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <02678572-347e-a5a8-5c78-cf39c2b3284f@kernel.org>
Date: Sun, 23 Oct 2016 10:53:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ_EiSQ0KEXOqNOQvqcaF5=f-TJtxZNsWs39k6gHuzN_f1OT7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 18:13, Matt Ranostay wrote:
> Jonathan et all,
> 
> Know this has been brought up in the past but what is the view of
> multipixel infrared thermopiles?
> 
> Initially I plan to do summing average of all the pixels and report
> that back, but would like in the future to be able to push the pixel
> data to the buffers.
> 
> These of course are weird because they barely fit into iio, but nor do
> they fit into v4l2 (especially since the data isn't DMA'able).
DMA isn't really a requirement for v4l2.

Usual rule of thumb that if no one else thinks it's in their scope and
it measures something it goes in IIO :)

So real question is do the v4l2 people think it should be in there?

My gut feeling is yes.  These things are only going to get bigger as the
technology moves on so will become more and more camera like.

It's possible we'll ultimately end up bridging one way or the other
between IIO and v4l2 but only once we have a clean use case for it
and I'm not convinced this is one yet...

Though maybe it is if exporting the average of pixels is actually how
these devices are typically used...

J
> 
> Datasheet -> https://eewiki.net/download/attachments/13599167/Grid-EYE%20SPECIFICATIONS%28Reference%29.pdf
> 
> Thanks,
> 
> Matt
> 

