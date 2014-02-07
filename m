Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34117 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaBGWTx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Feb 2014 17:19:53 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so3703997pdj.15
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2014 14:19:53 -0800 (PST)
Date: Fri, 07 Feb 2014 14:19:59 -0800
Subject: Re: DMA sampling and IIO
From: John Syn <john3909@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, Matt Flax <flatmax@flatmax.org>
Message-ID: <CF1A99B5.1996C%john3909@gmail.com>
References: <CF17C5B7.1940A%john3909@gmail.com>
 <52F35C5B.7080409@metafoo.de>
 <CF19225A.196C9%john3909@gmail.com>
 <52F3FB6E.3070201@metafoo.de>
 <20140207132058.GN32298@sirena.org.uk>
In-Reply-To: <20140207132058.GN32298@sirena.org.uk>
Mime-version: 1.0
Content-type: text/plain;
	charset="ISO-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 2/7/14, 5:20 AM, "Mark Brown" <broonie@kernel.org> wrote:

>On Thu, Feb 06, 2014 at 10:15:26PM +0100, Lars-Peter Clausen wrote:
>
>> I guess this is because it is the traditional area where I2S is used
>>and nobody
>> cared so far about using it somewhere else in the context of the Linux
>>kernel.
>> Not having to have a extra layer of abstraction in the middle between
>>ALSA/ASoC
>> and the I2S peripheral driver helped to keep things simple.
>
>Plus many of the uses actually found that the audio APIs were doing
>useful things for them anyway - the DMA bit is reasonably useful way of
>transferring continuous streams of data and nothing much cares if that
>data is actually audio or not so long as the application on top doesn't
>mind.
Hi Mark,

That is interesting. The ADE7878 transmits the measurements as 16
sequential measurements (Voltage A, Voltage B, Voltage C, Current A, etc)
and uses a frame to denote a new set of measurements. Can the audio API
cope with 16 channels and how do I prevent any modification (equalization,
etc) to the measurement data? Also, is it possible to break out these
measurements into separate buffers (Voltage A buffer, Voltage B buffer,
etc)? I guess I would access these measurement in the same way as an audio
application like aplay?

What I don¹t like about this solution is the possibility of missing
samples. In an audio app, this isn¹t so critical, but in my app this would
be a big problem. 

Regards,
John
>


