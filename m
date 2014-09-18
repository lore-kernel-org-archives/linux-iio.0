Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:50405 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbaIREGR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Sep 2014 00:06:17 -0400
Received: by mail-pd0-f170.google.com with SMTP id fp1so519805pdb.15
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2014 21:06:17 -0700 (PDT)
Date: Wed, 17 Sep 2014 21:06:12 -0700
Subject: Re: DMA sampling and IIO
From: John Syn <john3909@gmail.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <D03F9E66.48538%john3909@gmail.com>
References: <CF17C5B7.1940A%john3909@gmail.com>
 <52F35C5B.7080409@metafoo.de>
 <CF19225A.196C9%john3909@gmail.com>
 <52F3FB6E.3070201@metafoo.de>
 <D036210C.44F7D%john3909@gmail.com>
 <20140917195328.GW7960@sirena.org.uk>
In-Reply-To: <20140917195328.GW7960@sirena.org.uk>
Mime-version: 1.0
Content-type: text/plain;
	charset="EUC-KR"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 9/17/14, 12:53 PM, "Mark Brown" <broonie@kernel.org> wrote:

>On Wed, Sep 10, 2014 at 03:43:50PM -0700, John Syn wrote:
>> I©öm following Mark©ös suggestion and using the audio API to stream the
>> samples from the ADE7878. I created a small circuit that translates the
>
>Please don't top post; quote relevant context when replying so people
>can follow the discussion.
>
>> codec and then modified davinci-evm.c link in the ade78xx codec.
>> Everything seems to load OK and I see a /dev/snd/pcmC0D0c device. Now
>>when
>> I try to use arecord, it simply hangs and I think the problem occurs
>> because the ade7854-i2c driver is in the IIO folder and my ade78xx
>>driver
>> is in the audio folder and currently there is no coordination to start
>>and
>> stop streaming, which probably causes under runs, over run errors. In a
>> traditional Codec, the I2C and I2S functionality is in the same driver
>>so
>> it is easy to coordinate start streaming and stop streaming.
>
>The location of the files is not going to have any impact at all, the
>callbacks aren't based on link order at all.  If data isn't being
>transferred the most likely reason is that the clocks aren't being
>started which will be a driver issue.
Hi Mark,

The ADE7878 is the clock master and I enable that clock using a simple
script which uses /sys to write to the ADE7878 registers. I start the
clock after I start my user space capture app. On both my oscilloscope and
protocol analyzer I can see the clock running and I also see the data
streaming from the ADE7878. It looks like the McASP isn¡¯t getting started
because my user space snd_pcm_readi call is failing. It looks like I need
some sort of trigger to start the McASP receive. I have a tlv320aic3106
codec working and I¡¯ve captured the kernel calls using kernel function
tracer which I¡¯m hoping will help me understand how the McASP gets
started. After that I¡¯ll do the same with my ade78xx codec driver and
hopefully I¡¯ll learn what is missing. I¡¯ll keep you updated as I learn
more. 

Thank you for all your help,

Regards,
John





