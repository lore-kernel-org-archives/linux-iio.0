Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54147 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab3HOJ3o (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Aug 2013 05:29:44 -0400
Message-ID: <520CAD98.6090405@kernel.org>
Date: Thu, 15 Aug 2013 11:29:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/1] Add Microchip MCP3422/3/4 High resolution ADC
References: <1376500125-16014-1-git-send-email-angelo.compagnucci@gmail.com> <alpine.DEB.2.01.1308151104040.29956@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1308151104040.29956@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/15/13 10:09, Peter Meerwald wrote:
> Hi,
> 
>> This revision solves various problems of the previous one.
>> Most important is locking of the chip configuration during updates
>> and the use of devm_* API.
>> For each channel there are now two sysfs attributes, so you can read
>> the raw value or the scaled one.
>>
>> To Peter: Chip versions differs in address assignment (MCP3422 has a fixed address)
>> and channel number (MCP3423 has 2 channels, MCP3424 has 4) but the chip manages
>> internally the lack of channels (it remaps non exixtent channels to the existent ones)
>> so I opted to keep the driver clean and implemented all the four channels.
> 
> looks a whole lot better!
> 
> regarding chip ids and channels: many ADC drivers create the number of 
> channels dynamically, I'd rather implement this
> 
> having different chips in mcp3422_id but not using it is confusing to me
> 
Given there are only 3 options, I'd do this as picking between 3 different static
arrays rather than actually allocating them dynamically. That way it is obvious
what is going on and only costs a tiny bit of static const data.

> regards, p.
> 
