Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:12631 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbeITOPm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Sep 2018 10:15:42 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4183D646243E8
        for <linux-iio@vger.kernel.org>; Thu, 20 Sep 2018 16:33:21 +0800 (CST)
Date: Thu, 20 Sep 2018 09:33:11 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: David Frey <dpfrey@gmail.com>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: question about iio_dev.active_scan_mask
Message-ID: <20180920093311.00004ec4@huawei.com>
In-Reply-To: <320ab010-4200-20cf-f71d-2fb77a2d1a67@gmail.com>
References: <320ab010-4200-20cf-f71d-2fb77a2d1a67@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 19 Sep 2018 15:03:11 -0700
David Frey <dpfrey@gmail.com> wrote:

> Hi,
Hi David,

> 
> I am looking at struct iio_dev in include/linux/iio/iio.h and the
> active_scan_mask member is documented as:
> 
> @active_scan_mask:   [INTERN] union of all scan masks requested by buffers
> 
> I believe that this is a bitmap where if bit X is set, that means the
> channel with scan_index == X is enabled for buffering.

Correct. It represents the channels the device should be sampling,
which are not always the same as the ones that the driver's userspace interface
has configured as the channel demux may well be in use.

> 
> I believe that "[INTERN]" means that this member should not be accessed
> by a device driver, but I see many device drivers iterating over the
> bits of this field.  Is my understanding incorrect?  Perhaps "[INTERN]"
> means that the field can be read from the driver, but should not be written.

Yeah, this was a bit of historical mess we have slowly been cleaning out.
(or at least intending to clear out - as you've noted we haven't gotten
very far with it)

The upshot is they shouldn't access it directly, but only via the value
passed to the update_scan_mode callback. Now arguably we should reconsider
this given there are drivers in which the only thing that callback would
do is to take a copy of this field.  One that needs some more thought and
analysis of whether this is because there is actually a common case where
there are no optimizations that can be 'pre baked' in this callback, or
because they simply haven't been done yet for many of these parts.

This is one of those ugly corners I'd completely forgotten we still had
so glad you reminded us!

Jonathan

> 
> Please help me clear up my understanding.
> 
> Thanks,
> David
