Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:52914 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751618Ab2EMPC7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 May 2012 11:02:59 -0400
Message-ID: <4FAFCD5D.2090805@metafoo.de>
Date: Sun, 13 May 2012 17:03:57 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio:dac:max517: Convert to channel spec
References: <1336755862-24184-1-git-send-email-lars@metafoo.de> <1336755862-24184-2-git-send-email-lars@metafoo.de> <4FAEB14A.8020408@kernel.org> <4FAED9AD.4020803@antcom.de> <4FAF61CF.6070509@metafoo.de> <4FAF79AB.1080906@antcom.de> <4FAF7CDE.8070507@metafoo.de> <4FAF81E5.8070700@antcom.de>
In-Reply-To: <4FAF81E5.8070700@antcom.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/13/2012 11:41 AM, Roland Stigge wrote:
> On 13/05/12 11:20, Lars-Peter Clausen wrote:
> [regarding the "1&2" output]
>> You can only set the same value on both
>> outputs simultaneously, which I think has not so many practical use-cases.
> 
> _If_ you want to switch outputs "simultaneously", it's hard to do with
> the max51x chips due to relatively slow I2C communication. Don't have
> timing diagrams right now how close you get if you switch the two
> outputs directly one after another, though.

Hm, I thought the whole purpose of the "1&2" attribute was to update them
simultaneously. According to the datasheet the chip will latch new values on a
stop condition. So if you write both channels in one transfer they will be
updated simultaneously. If you don't care about that you might as well just
update the channels by writing to their respective attribute.

> 
> But right, it's not highest priority...
> 
>> You'd rather want to set two different values on output 1 and 2.
> 
> We have and will have attributes for those anyway, don't we?
> 

Yes, sure. But again I meant simultaneously, which will be possible with buffer
output support.

- Lars
