Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:55861 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbaIJWnz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Sep 2014 18:43:55 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so10093779pdb.39
        for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2014 15:43:55 -0700 (PDT)
Date: Wed, 10 Sep 2014 15:43:50 -0700
Subject: Re: DMA sampling and IIO
From: John Syn <john3909@gmail.com>
To: <linux-iio@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <D036210C.44F7D%john3909@gmail.com>
References: <CF17C5B7.1940A%john3909@gmail.com> <52F35C5B.7080409@metafoo.de> <CF19225A.196C9%john3909@gmail.com> <52F3FB6E.3070201@metafoo.de>
In-Reply-To: <20140207132058.GN32298@sirena.org.uk>
Mime-version: 1.0
Content-type: text/plain;
	charset="ISO-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I¹m following Mark¹s suggestion and using the audio API to stream the
samples from the ADE7878. I created a small circuit that translates the
ADE7878 HSDC (SPI style interface) to I2S type interface so that the
ADE7878 samples can be treated like samples from a codec. The ADE7878
outputs 16 samples which I treat as 16 slots in a traditional audio
channel. 

My platform is a BeagleBoneBlack (BBB) so I¹m using a McASP interface for
I2S. 

Next, I used the SPDIF RX codec as a template to create a ade78xx type
codec and then modified davinci-evm.c link in the ade78xx codec.
Everything seems to load OK and I see a /dev/snd/pcmC0D0c device. Now when
I try to use arecord, it simply hangs and I think the problem occurs
because the ade7854-i2c driver is in the IIO folder and my ade78xx driver
is in the audio folder and currently there is no coordination to start and
stop streaming, which probably causes under runs, over run errors. In a
traditional Codec, the I2C and I2S functionality is in the same driver so
it is easy to coordinate start streaming and stop streaming.

What is the best way to handle this problem?

BTW, I used this wiki as a reference:

http://processors.wiki.ti.com/index.php/Sitara_Linux_SDK_Audio_DAC_Example


Regards,

John




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


