Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:58593 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750821Ab2EMJTh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 May 2012 05:19:37 -0400
Message-ID: <4FAF7CDE.8070507@metafoo.de>
Date: Sun, 13 May 2012 11:20:30 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio:dac:max517: Convert to channel spec
References: <1336755862-24184-1-git-send-email-lars@metafoo.de> <1336755862-24184-2-git-send-email-lars@metafoo.de> <4FAEB14A.8020408@kernel.org> <4FAED9AD.4020803@antcom.de> <4FAF61CF.6070509@metafoo.de> <4FAF79AB.1080906@antcom.de>
In-Reply-To: <4FAF79AB.1080906@antcom.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/13/2012 11:06 AM, Roland Stigge wrote:
> Hi,
> 
> On 13/05/12 09:25, Lars-Peter Clausen wrote:
>>> I'm generally fine with the proposed changes and can ack it. However, we
>>> should provide a replacement for the old "1&2" attribute. It supports a
>>> certain hardware feature of this chip. No need to sacrifice it.
>>
>> I don't think it makes sense to keep it in it's current form. First of all this
>> isn't really covered by the IIO spec to have one attribute which changes two
>> (or more) output at once and secondly it is artificially limited to setting the
>> same value on both outputs, while the chip doesn't have this limitations and
>> you can set different values on both outputs at once.
> 
> Please consider this as a special feature of the chip (setting the
> outputs timely at once), not a "limitation", since you can also set them
> individually.
> 

What I meant was that it is not a limitation of the chip, but the driver only
allows limited use of that feature. You can only set the same value on both
outputs simultaneously, which I think has not so many practical use-cases.
You'd rather want to set two different values on output 1 and 2.

- Lars
