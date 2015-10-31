Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38681 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbbJaKnv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2015 06:43:51 -0400
Subject: Re: generic_buffer.c bug
To: Matt Ranostay <mranostay@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <CAKzfze8JuNGf4NEZJxP0X3UQ21FubYgyB8da7FQSv_dK9cuk8Q@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56349B65.3010201@kernel.org>
Date: Sat, 31 Oct 2015 10:43:49 +0000
MIME-Version: 1.0
In-Reply-To: <CAKzfze8JuNGf4NEZJxP0X3UQ21FubYgyB8da7FQSv_dK9cuk8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/10/15 05:26, Matt Ranostay wrote:
> Jonathan et all,
> 
> Well actually this issues is in the build_channel_array function
> located in iio_utils.c, but when testing my LIDAR driver with the
> generic_buffer tool I found the following corner case.
> 
> So in_distance_* has a scale entry but no offset so it in turn it
> fails.. at line 495 in iio_utils.c
This is odd.  That line currently contains:
if ((ret < 0) && (ret != -ENOENT))

The -ENOENT bit is there to deal with the file not existing.
Any chance you are using a version prior to the fix that added the
ENOENT check?
7868dfd216074fc5f902e7befacda2a0ec76e403
 tools: iio: make scale and offset files optional
from back on July.

There was a window in which it was broken prior to that.

Jonathan

> 
> Thanks,
> 
> Matt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

