Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39478 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932538AbaHGRAi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Aug 2014 13:00:38 -0400
Message-ID: <53E3B0B4.2090807@kernel.org>
Date: Thu, 07 Aug 2014 18:00:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: balbi@ti.com
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
References: <1407341409-30284-1-git-send-email-balbi@ti.com> <alpine.DEB.2.01.1408061815140.29646@pmeerw.net> <20140806214222.GB3556@saruman.home> <53E35018.1000900@kernel.org> <20140807143943.GB24581@saruman.home> <53E3A90C.6080006@kernel.org> <20140807163632.GB29964@saruman.home>
In-Reply-To: <20140807163632.GB29964@saruman.home>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/08/14 17:36, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Aug 07, 2014 at 05:27:56PM +0100, Jonathan Cameron wrote:
>>>>>>> + +	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS) +		return -EBUSY; + +	if (chan->type != IIO_LIGHT)
>>>>>>> + return -EINVAL; + +	mutex_lock(&opt->lock); + +	switch (mask) {
>>>>>>
>>>>>> is there no way to control the scale?
>>>>>
>>>>> yeah, but the HW does auto-scaling which works pretty well. Why would you want to control the scale manually ?
>>>> On a slow device like this you probably wouldn't but for quicker devices the overhead of converting into a
>>>> standard form in kernel might be excessive.
>>>
>>> hehe, even when you _do_ set the scale, you still have the top 4
>>> bits as exponent, the difference is that you know what they are
>>> before the conversion is done :-)
>> Then you can junk them and let userspace use the known value to deal
>> with the raw data.
> 
> alright, I'll leave that to a future patch then. Auto-ranging is so much
> simpler.
> 
Agreed - it's just unusual for it to actually be present on the device.
