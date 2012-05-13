Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:34730 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326Ab2EMJG4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 May 2012 05:06:56 -0400
Message-ID: <4FAF79AB.1080906@antcom.de>
Date: Sun, 13 May 2012 11:06:51 +0200
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio:dac:max517: Convert to channel spec
References: <1336755862-24184-1-git-send-email-lars@metafoo.de> <1336755862-24184-2-git-send-email-lars@metafoo.de> <4FAEB14A.8020408@kernel.org> <4FAED9AD.4020803@antcom.de> <4FAF61CF.6070509@metafoo.de>
In-Reply-To: <4FAF61CF.6070509@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 13/05/12 09:25, Lars-Peter Clausen wrote:
>> I'm generally fine with the proposed changes and can ack it. However, we
>> should provide a replacement for the old "1&2" attribute. It supports a
>> certain hardware feature of this chip. No need to sacrifice it.
> 
> I don't think it makes sense to keep it in it's current form. First of all this
> isn't really covered by the IIO spec to have one attribute which changes two
> (or more) output at once and secondly it is artificially limited to setting the
> same value on both outputs, while the chip doesn't have this limitations and
> you can set different values on both outputs at once.

Please consider this as a special feature of the chip (setting the
outputs timely at once), not a "limitation", since you can also set them
individually.

However, I'm not sure how many people are actually using this feature.
So feel free to patch as proposed and go forward moving the driver out
of staging.

> The proper solution for this is to implement buffered support for output
> devices and I do have some experimental code for that.

Good! When you already have code, please provide, so I can test it.
Maybe we can re-integrate it into the "new" driver later on.

Thanks for working on this,

Roland
