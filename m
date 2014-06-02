Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40161 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbaFBUxL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Jun 2014 16:53:11 -0400
Message-ID: <538CE4A1.90406@kernel.org>
Date: Mon, 02 Jun 2014 21:54:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sebastian Reichel <sre@kernel.org>
CC: Paul Kocialkowski <contact@paulk.fr>, linux-iio@vger.kernel.org,
	j-keerthy@ti.com
Subject: Re: [PATCH] twl4030-madc: Request processed values in twl4030_get_madc_conversion
References: <1400933398.2079.16.camel@aldrin> <538CBBA6.30203@kernel.org> <20140602181039.GA2185@earth.universe>
In-Reply-To: <20140602181039.GA2185@earth.universe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/14 19:10, Sebastian Reichel wrote:
> Hi,
>
> On Mon, Jun 02, 2014 at 07:00:06PM +0100, Jonathan Cameron wrote:
>> On 24/05/14 13:09, Paul Kocialkowski wrote:
>>> Not setting the raw parameter in the request causes it to be randomly
>>> initialized to a value that might be different from zero or zero. This leads to
>>> values that are randomly either raw or processed, making it very difficult to
>>> make reliable use of the values.
>>>
>>> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>>
>> This one seems obvious enough to me that I've applied it to the fixes-togreg
>> branch. Note you should cc the author or if the log makes it clear someone
>> else has been working with the driver recently, then cc them.
>> In this case Sebastian.
>
> The commit message looks a bit odd "[...] different from zero or
> zero". In case this is still relevant:
>
> Acked-By: Sebastian Reichel <sre@kernel.org>
Given I was a muppet and applied it to the wrong branch, I've added the ack
and now applied it to the fixes-togreg branch....

>
>> [...]
>
> -- Sebastian
>

