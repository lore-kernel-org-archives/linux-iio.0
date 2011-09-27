Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:50293 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab1I0PEA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2011 11:04:00 -0400
Message-ID: <4E81E7D6.60904@cam.ac.uk>
Date: Tue, 27 Sep 2011 16:12:22 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Amit Kucheria <amit.kucheria@verdurent.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: IIO: ownership of patches taking drivers out of staging.
References: <4E81D071.5050806@cam.ac.uk> <20110927145907.GA2580@matterhorn1>
In-Reply-To: <20110927145907.GA2580@matterhorn1>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/27/11 15:59, Amit Kucheria wrote:
> On 11 Sep 27, Jonathan Cameron wrote:
>> Hi All,
>>
>> I'm putting together a patch set to propose the first step in moving
>> IIO out of the staging tree.
>>
>> I want to take a small set (initially) of representative drivers
>> along for the ride.
>>
>> Now unlike later elements which will consist of git moves (and hence
>> preserve history) those that come with us now will be done by
>> stripping down the drivers and then building their feature set
>> back up as we go.
>>
>> My question here is whether people are happy if I assign authorship
>> of patches for their drivers to them (with appropriate note and
>> sign off from me to explain where they came from).
>>
>> Right now my example set consists of
>>
>> ad799x - Michael's
>> max1363 - mine :)
>> tsl2583 - Amit's
>> adis16400 - Manuel's but with large bits from drivers of mine
>> 	    and Barry Song. I'm fine with it being Manuel's.
>> 	    Copyright notice covers that some of it is Analog's
>> 	    so, Michael, is that fine with you guys?
>>
>> So I need responses from Amit, Michael and Manuel as to whether
>> they mind me setting author of relevant drivers to them?  I'd
>> obviously also like sign offs once you have had time to look
>> at them. I'll post an updated tree shortly to github.
>>
> 
> Yes, that'd be fine. I'll try to test out the changes/moves as we go but I
> won't be close to HW and a reliable internet connection over the next few
> weeks.
> 
> /Amit
> 
Not to worry. It's a rare thing but I actually have a part to test that
particular driver (have a tsl2561)

Thanks,

Jonathan
