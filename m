Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40433 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab3ERKUM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2013 06:20:12 -0400
Message-ID: <519755D6.10000@kernel.org>
Date: Sat, 18 May 2013 11:20:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Denis CIOCCA <denis.ciocca@st.com>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Use buffer without trigger
References: <CAEE_umrLpNJo1kMbLtktK0RH6WCKCEYR+yiTiyPJu_8G3coE7A@mail.gmail.com> <2076388.y5Y0d24KYt@ctocwl0124> <519614CA.5040702@metafoo.de> <2527914.pxyfU9jjLA@ctocwl0124> <5196280C.8070909@metafoo.de>
In-Reply-To: <5196280C.8070909@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/17/2013 01:52 PM, Lars-Peter Clausen wrote:
> On 05/17/2013 02:34 PM, Denis CIOCCA wrote:
>>> Yes, but you still have to assign the trigger to the device in sysfs.
>>
>> Ok but I have to use a dummy trigger for every device?
>>
>> Denis
> 
> No. Allocate your buffers and allocate your one trigger. Before you can
> enable your buffer you need to assign the trigger to the buffer in sysfs (By
> writing to trigger/current_trigger).
> 
Lots of the ADC drivers do this.  See max1363 for example. No sign a trigger
but it definitely has a buffer.  Often these parts convert on demand but can
do it at very high rates.
