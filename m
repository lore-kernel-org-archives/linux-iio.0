Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40237 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187AbaFBUyv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Jun 2014 16:54:51 -0400
Message-ID: <538CE506.9060203@kernel.org>
Date: Mon, 02 Jun 2014 21:56:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Paul Kocialkowski <contact@paulk.fr>,
	Sebastian Reichel <sre@kernel.org>
CC: linux-iio@vger.kernel.org, j-keerthy@ti.com
Subject: Re: [PATCH] twl4030-madc: Request processed values in twl4030_get_madc_conversion
References: <1400933398.2079.16.camel@aldrin> <538CBBA6.30203@kernel.org>	 <20140602181039.GA2185@earth.universe> <1401736646.2083.2.camel@aldrin>
In-Reply-To: <1401736646.2083.2.camel@aldrin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/14 20:17, Paul Kocialkowski wrote:
> Le lundi 02 juin 2014 à 20:10 +0200, Sebastian Reichel a écrit :
>> Hi,
>>
>> On Mon, Jun 02, 2014 at 07:00:06PM +0100, Jonathan Cameron wrote:
>>> On 24/05/14 13:09, Paul Kocialkowski wrote:
>>>> Not setting the raw parameter in the request causes it to be randomly
>>>> initialized to a value that might be different from zero or zero. This leads to
>>>> values that are randomly either raw or processed, making it very difficult to
>>>> make reliable use of the values.
>>>>
>>>> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>>>
>>> This one seems obvious enough to me that I've applied it to the fixes-togreg
>>> branch. Note you should cc the author or if the log makes it clear someone
>>> else has been working with the driver recently, then cc them.
>>> In this case Sebastian.
>
> Thanks for your feedback and sorry that I didn't check the previous
> contributors to the driver!
>
>> The commit message looks a bit odd "[...] different from zero or
>> zero".
>
> How about replacing that with: "that may or may not be zero" and
> inversing "processed" and "raw" in the next sentence (if that's not too
> late)? The commit message would be:
>
> Not setting the raw parameter in the request causes it to be randomly
> initialized to a value that may or may not be zero. This leads to
> values that are randomly either processed or raw, making it very
> difficult to make reliable use of the values.
Whilst original text was a little unwieldy it was clear enough so I've left
it bit.
>
>> In case this is still relevant:
>>
>> Acked-By: Sebastian Reichel <sre@kernel.org>
>
> Paul
>

