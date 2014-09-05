Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:35238 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbaIESXV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Sep 2014 14:23:21 -0400
Date: Fri, 5 Sep 2014 15:22:03 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	James Hartley <james.hartley@imgtec.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: Re: IIO hrtimer trigger
Message-ID: <20140905152203.42ff6868@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Lars,

I'm picking this discussion, since we're also interested in using an hrtimer
trigger.

> On 10/06/2013 08:15 PM, Jonathan Cameron wrote:
>> We are pretty much stuck with that for the sysfs trigger already...
>
> Unfortunately yes. I never liked its API and I still don't like it and we
> have to live with it. But this doesn't mean we have to add more of the same.

So the reason why the hrtimer trigger hasn't been merged in its current form is
because we're still discussing the ABI, right?

Can you elaborate on why you don't like the sysfs trigger API? If you can give
me some hints I can try to cook a patch for the configfs hrtimer trigger.

Thanks!
Ezequiel
