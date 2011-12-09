Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-081.synserver.de ([212.40.185.81]:1046 "HELO
	smtp-out-081.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751452Ab1LIJ54 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2011 04:57:56 -0500
Message-ID: <4EE1DBBB.7060609@metafoo.de>
Date: Fri, 09 Dec 2011 10:58:19 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>,
	Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio:kfifo_buf: Fix potential buffer overflow
 in iio_read_first_n_kfifo
References: <1323365753-7645-1-git-send-email-lars@metafoo.de> <1323365753-7645-2-git-send-email-lars@metafoo.de> <20111208201722.GA31926@kroah.com>
In-Reply-To: <20111208201722.GA31926@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/08/2011 09:17 PM, Greg KH wrote:
> On Thu, Dec 08, 2011 at 06:35:52PM +0100, Lars-Peter Clausen wrote:
>> n is the number of bytes to read, not the number of samples. So if there is
>> enough data available we will write to the userspace buffer beyond its bounds.
>> Fix this by copying n bytes maximum. Also round n down to the next multiple of
>> the sample size, so we will only read complete samples. If the buffer is too
>> small to hold at least one sample return -EINVAL.
>>
>> Also update the documentation of read_first_n to reflect the fact that 'n' is
>> supposed to be in bytes and not in samples.
>>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  drivers/staging/iio/buffer.h    |    2 +-
> 
> This patch no longer applies to my tree, care to refresh it and resend
> it?

Hi Greg,

I just rebased the patch on top of the current staging-next and it is
identically to this one. Could you try to re-apply it, if you still have it?
Otherwise I'll send it out again.

Thanks,
- Lars
