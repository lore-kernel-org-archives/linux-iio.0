Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43317 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab2EaHS7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 May 2012 03:18:59 -0400
Message-ID: <4FC71B5A.1020803@kernel.org>
Date: Thu, 31 May 2012 08:18:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Getz, Robin" <robin.getz@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/8] IIO: Cleanups and complicated channel modifiers.
References: <1338406866-3833-1-git-send-email-jic23@kernel.org> <201205301533.33508.robin.getz@analog.com>
In-Reply-To: <201205301533.33508.robin.getz@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/30/2012 8:33 PM, Getz, Robin wrote:
> On Wed 30 May 2012 15:40, Jonathan Cameron pondered:
>> Hi All,
>>
>> Dropping the reset attributes was discussed a while back and no
>> one could come up with a reason for having them. Unless anyone
>> does have a good reason, lets drop these before we move the
>> relevant drivers out of staging.
>
> This is the only way that userspace can re-initialise the device (if someone
> modified the calibration settings, and wants to get back to the factory
> setting).
>
> That doesn't mean it's necessary - it just means that is what it was there
> for.
Indeed, it had a usecase. In my view if people go fiddlying with those 
without knowing what they are doing then then deserve to need to reboot 
or remove and reinsert the module!
>
> -Robin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

