Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45934 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632Ab2KBKxE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Nov 2012 06:53:04 -0400
Message-ID: <5093A60C.90806@kernel.org>
Date: Fri, 02 Nov 2012 10:53:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] staging:iio: add a callback buffer for in kernel
 push interface
References: <1351679431-7963-1-git-send-email-jic23@kernel.org> <1351679431-7963-4-git-send-email-jic23@kernel.org> <alpine.DEB.2.01.1210311505340.10186@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1210311505340.10186@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/31/2012 02:10 PM, Peter Meerwald wrote:
> Hi,
> 
> I'm sure you missed my spellchecking :)
I am always happy to accept fixes like this that mean I don't look as
much of an idiot when patches hit mainline ;)
> 
>> +config IIO_BUFFER_CB
>> +       boolean "IIO callback buffer used for push in kernel interfaces"
>> +       help
>> +         Should be selected by any drivers that do inkernel push
>> +	 usage.  That is, those where the data is pushed to the consumer.
>> +
> 
> is it 'in kernel' or 'inkernel'? I'd prefer in-kernel :)
> indentation seems inconsistent
in-kernel is indeed nicer.  I'll do that here and maybe clean up the other uses later.

> 
>> +/**
>> + * iio_channel_cb_get_channels() - get access to the underlying channels.
>> + * @cb_buff:		The callback buffers from whom we want the channel
>> + *			information.
> 
> buffers from which?

actually should be 'buffer from whom'.
Good catch though - I could have read that 100 times and never noticed.

I'm lazy so won't repost the patch with these changes but will wait a little longer
then merge it if no one shouts loudly that I shouldn't. (they'll be in the wip
branch if anyone actually cares enough to look)
