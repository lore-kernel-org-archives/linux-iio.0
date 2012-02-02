Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-059.synserver.de ([212.40.185.59]:1054 "EHLO
	smtp-out-034.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753124Ab2BBJNZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Feb 2012 04:13:25 -0500
Message-ID: <4F2A53F1.3020304@metafoo.de>
Date: Thu, 02 Feb 2012 10:14:25 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 5/6] staging:iio:events: Use non-atomic bitops
References: <1328121956-29596-1-git-send-email-lars@metafoo.de> <1328121956-29596-6-git-send-email-lars@metafoo.de> <20120202062053.GC24652@mwanda>
In-Reply-To: <20120202062053.GC24652@mwanda>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/02/2012 07:20 AM, Dan Carpenter wrote:
> On Wed, Feb 01, 2012 at 07:45:55PM +0100, Lars-Peter Clausen wrote:
>> We always hold the waitqueue lock when modifying the flags field. So it is safe
>> to use the non-atomic bitops here instead of the atomic versions.
>>
>> The lock has to be held, because we need to clear the busy flag and flush the
>> event fifo in one atomic operation when closing the event file descriptor.
>>
> 
> Is the performance improvement worth it?
> 

I don't think there is any real performance improvement to be expected of
this patch. If you have good a reason why non-atomic bitops should not be
used I guess this patch could be dropped. But right now I don't see anything
wrong with it.

Thanks,
- Lars
