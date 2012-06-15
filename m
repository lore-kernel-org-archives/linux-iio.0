Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42289 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab2FONch (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 09:32:37 -0400
Message-ID: <4FDB3972.8090209@kernel.org>
Date: Fri, 15 Jun 2012 14:32:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Bottom half trigger function never called when using the sysfs
 trigger
References: <4FDB33CD.2090805@metafoo.de>
In-Reply-To: <4FDB33CD.2090805@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/15/2012 2:08 PM, Lars-Peter Clausen wrote:
> hi,
>
> The sysfs trigger uses iio_trigger_poll_chained which calls
> handle_nested_irq. The problem now is that for nested IRQs the primary
> handler is not called. Which obviously breaks drivers which have a bottom
> half trigger function.
>
> This behaviour was introduced in commit 1f785681 ("staging:iio:trigger sysfs
> userspace trigger rework."). The commit message says you are "awaiting
> comments on using the nested_irq_trick", but not why it is necessary to use
> nested IRQs. And honestly I don't get why it would be necessary either.
> handle_nested_irq is supposed to be used with chained IRQs if we are already
> running in a thread handler of parent. Neither seems to be true here.
It was a while ago so my memory is rather sketchy.
do you meant the bottom half?  Unless I'm very confused its the top half 
that doesn't
get called.. handle_nested_irq calls thread_fn which is the bottom half.

It's the only way I've come up with for cleanly running through our 
trigger distribution
given that is all irq based.  Top halves expect to be run in interrupt 
mode. I don't know
of any way to ensure this is true if one is 'creating' the interrupt 
from software.

I did wonder at the time about putting an explicit call of the interrupt 
handler in
to deal with the missing top halves. It's rather uggly though and 
suffers from things
not being run in the state they expect to be run in....

Other suggestions welcome.
