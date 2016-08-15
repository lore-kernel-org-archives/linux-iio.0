Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41316 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbcHOOw5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 10:52:57 -0400
Subject: Re: [PATCH v4 5/7] iio: hid-sensors: use asynchronous resume
To: Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1470561939-14278-6-git-send-email-srinivas.pandruvada@linux.intel.com>
 <alpine.LNX.2.00.1608071214500.22028@cbobk.fhfr.pm>
 <884e74df-569e-8218-fbda-f9c7ecfe1e5a@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <af2d1c90-a0ec-0888-8048-76463bf98ece@kernel.org>
Date: Mon, 15 Aug 2016 15:52:53 +0100
MIME-Version: 1.0
In-Reply-To: <884e74df-569e-8218-fbda-f9c7ecfe1e5a@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/08/16 15:07, Jonathan Cameron wrote:
> On 07/08/16 11:15, Jiri Kosina wrote:
>> On Sun, 7 Aug 2016, Srinivas Pandruvada wrote:
>>
>>> Some platforms power off sensor hubs during S3 suspend, which will require
>>> longer time to resume. This hurts system resume time, so resume
>>> asynchronously.
>>>
>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>
>> Jonathan, are you going to cherry-pick this patch from the series? 
>> Alternatively, if you're okay with it, I can pull it in together with the 
>> whole set with your Acked-by or Reviewed-by.
>>
> I'll take it via IIO. Got a bit of catching up to do (been on holiday)
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.
This one is not really connected to the others so makes sense to
take it separately.

I'm out of my depth on the rest of the patches in this series
and don't have time to learn enough to follow them! Sorry I
can't help on that front.

Jonathan
> 
> Jonathan
>> Thanks,
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

