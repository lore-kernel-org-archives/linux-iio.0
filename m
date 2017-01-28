Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44777 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdA1KbH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 05:31:07 -0500
Subject: Re: [PATCH] iio: dht11: Use usleep_range instead of msleep for start
 signal
To: John Brooks <john@fastquake.com>, Harald Geyer <harald@ccbib.org>
References: <20170118215008.GA12173@oldkitsune.fastquake.com>
 <E1cUAqD-0000MZ-0T@stardust.g4.wien.funkfeuer.at>
 <03e7614a-8f7f-e4f4-07cd-d1c591480239@kernel.org>
 <20170127013343.GA8964@oldkitsune.fastquake.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dba1e613-cf83-cc4b-7283-6741b92be4c3@kernel.org>
Date: Sat, 28 Jan 2017 10:30:27 +0000
MIME-Version: 1.0
In-Reply-To: <20170127013343.GA8964@oldkitsune.fastquake.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/17 01:33, John Brooks wrote:
> On Sun, Jan 22, 2017 at 01:36:47PM +0000, Jonathan Cameron wrote:
>> Agreed.  Any chance you can do a bisection on this John?
>>
>> Either way - defence in depth!
>> Applied to the fixes-togreg branch of iio.git.
>>
>> thanks,
>>
>> Jonathan
> 
> It's my first bug fixing kernel patch; I'm very happy to see it applied :)
> 
> I would like to bisect this. It's a bit of a pain because I'll need to branch
> and apply all the RPi kernel patches every step of the way. If I find the time,
> I will do it.
Cool and good luck!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

