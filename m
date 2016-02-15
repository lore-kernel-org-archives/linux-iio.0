Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30851 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbcBOJLF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Feb 2016 04:11:05 -0500
Message-ID: <56C19627.4030800@parrot.com>
Date: Mon, 15 Feb 2016 10:11:03 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC: <lars@metafoo.de>
Subject: Re: [RFC PATCH v1 3/3] iio: make drivers use new timestamping clock
 API
References: <cover.1455184829.git.gregor.boirie@parrot.com> <9bebbc3bdb3e22ebe28fa1c3b00cef199c54cbf6.1455184829.git.gregor.boirie@parrot.com> <56BF3B61.1020004@kernel.org>
In-Reply-To: <56BF3B61.1020004@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/13/2016 03:19 PM, Jonathan Cameron wrote:
> On 11/02/16 10:04, Gregor Boirie wrote:
>> Update IIO drivers to pass IIO device as argument to iio_get_time_ns() and
>> iio_get_time_res().
>>
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> Clearly you need to be careful to ensure we can build the drivers
> when only patch one is applied. I'd be tempted to just merge this
> into patch one.  Even more fun with patch 2 vs this.
> You could work some nasty macro magic, or go through a double name
> change, but given the nature of the patches, perhaps leave them as
> is for review and I'll splice them into a single patch at time of
> application - uggly but simple ;)
Ok. I'll merge all 3 patches for final submission.
>
> Otherwise looks fine to me.
>
> Jonathan
>
gregor
