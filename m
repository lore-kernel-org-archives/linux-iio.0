Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:43146 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab1JXIdR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2011 04:33:17 -0400
Message-ID: <4EA522D3.9000906@cam.ac.uk>
Date: Mon, 24 Oct 2011 09:33:23 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, michael.hennerich@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging:iio:treewide only use shared to decide on interfaces
References: <1319211579-14367-1-git-send-email-jic23@cam.ac.uk> <1319211579-14367-2-git-send-email-jic23@cam.ac.uk> <4EA5220A.6010301@metafoo.de>
In-Reply-To: <4EA5220A.6010301@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/11 09:30, Lars-Peter Clausen wrote:
> On 10/21/2011 05:39 PM, Jonathan Cameron wrote:
>> Internally the fact that say scale is shared across channels is
>> actually of remarkably little interest.  Hence lets not store it.
>> Numerous devices have weird combinations of channels sharing
>> scale anyway so it is not as though this was really telling
>> us much. Note however that we do still use the shared sysfs
>> attrs thus massively reducing the number of attrs in complex
>> drivers.
>>
>> Side effect is that certain drivers that were abusing this
>> (mostly my work) needed to do a few more checks on what the
>> channel they are being queried on actually is.
>>
>> This is also helpful for in kernel interfaces where we
>> just want to query the scale and don't care whether it
>> is shared with other channels or not.
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Hi
> 
> Seems to work. I think it makes sense to submit this one and the other,
> which removes the bitmask addressing, together. Will you take care of this?
Yes.  Might take a few days to hit though as I would guess Greg is going
to be busy at the kernel summit.

Are you happy to Ack this patch or if not give a tested-by.
Whilst I can push stuff on without review to Greg, I always prefer not to!

Jonathan
