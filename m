Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:39538 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeENB6m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 May 2018 21:58:42 -0400
Subject: Re: [PATCH v4] iio: magnetometer: mag3110: Add ability to run in
 continuous mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
References: <c6182b29-3a9a-244e-6212-b425cb607027@electromag.com.au>
 <19dc65cf-ce1b-e9f1-f4cd-cd936a11951d@electromag.com.au>
 <20c9e404-3dfe-4950-91be-43210c57811b@electromag.com.au>
 <20180507181356.2e05b3ba@archlinux>
 <40af3230-da71-ec12-9bd3-aee219ecae74@electromag.com.au>
 <360496b6-7763-89d7-3890-514f2a74618f@electromag.com.au>
 <20180512110046.09383eb3@archlinux>
From: Richard Tresidder <rtresidd@electromag.com.au>
Message-ID: <ad00e6fa-d130-da77-bed1-58ec3f70dc45@electromag.com.au>
Date: Mon, 14 May 2018 09:58:48 +0800
MIME-Version: 1.0
In-Reply-To: <20180512110046.09383eb3@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thanks Jonathan
I'll take another look at the comment formats for the next iteration. 
Appreciate you help in getting this through.

Cheers
  Richard

On 12/05/2018 6:00 PM, Jonathan Cameron wrote:
> On Tue, 8 May 2018 15:59:54 +0800
> Richard Tresidder <rtresidd@electromag.com.au> wrote:
>
>> Adds the ability to run the Mag3110 in continuous mode to speed up the sampling rate.
>> Depending on the sampling rate requested the device can be put in or out of continuous mode automatically.
>> Shifting out of continuous mode requires a potential 1 / ODR wait which is also implemented.
>> Modified the sleep method when data is not ready to allow for sampling > 50sps to work.
>>
>> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
> One general thing.  When sending a new version of a patch, don't
> reply to the previous version.  In any threading email client things
> can get awfully hard to follow so it is 'mostly' preferred to do
> a new thread for a new version.
>
> There are a couple of trivial things about comment syntax but
> otherwise this looks good.
>
> Applied, with minor tweaks to the togreg branch of iio.git and pushed
> out as testing for the autobuilders to play with it.
>
> Thanks,
>
> Jonathan
>

