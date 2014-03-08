Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-024.synserver.de ([212.40.185.24]:1035 "EHLO
	smtp-out-129.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752081AbaCHPt1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Mar 2014 10:49:27 -0500
Message-ID: <531B3C25.90609@metafoo.de>
Date: Sat, 08 Mar 2014 16:49:57 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Linux IIO List <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO new drivers, features and cleanups for 3.15 - set
 3
References: <5318CB62.2020103@kernel.org> <20140306193355.GA12474@kroah.com>
In-Reply-To: <20140306193355.GA12474@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/06/2014 08:33 PM, Greg Kroah-Hartman wrote:
> On Thu, Mar 06, 2014 at 07:24:18PM +0000, Jonathan Cameron wrote:
>> The following changes since commit aa256f8d0dd9c2dff872849418d8e09e5d06718f:
>>
>>    Merge tag 'iio-for-3.15b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2014-02-23 09:08:34 -0800)
>>
>> are available in the git repository at:
>>
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.15c
>
> Pulled and pushed out.
>
> What's the status of the remaining drivers/staging/iio/ stuff?  Anything
> major keeping them from all moving out of staging sometime soon?

I think we are past the point were we can move big chunks of drivers. The 
drivers that are in good shape have already been moved. What's left has 
issues, some smaller, some bigger. Moving things out of staging is 
progressing, but it is progressing one driver at a time.

- Lars

