Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:50710 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab1JLPlb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2011 11:41:31 -0400
Message-ID: <4E95B52B.1080409@cam.ac.uk>
Date: Wed, 12 Oct 2011 16:41:31 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Arnd Bergmann <arnd@arndb.de>, Zoltan Devai <zdevai@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
References: <1318178172-7965-1-git-send-email-zoss@devai.org> <201110111617.52061.arnd@arndb.de> <20111011144005.GI3471@opensource.wolfsonmicro.com> <201110111724.48069.arnd@arndb.de> <20111012144251.GM3647@opensource.wolfsonmicro.com>
In-Reply-To: <20111012144251.GM3647@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/11 15:42, Mark Brown wrote:
> On Tue, Oct 11, 2011 at 05:24:47PM +0200, Arnd Bergmann wrote:
>> On Tuesday 11 October 2011, Mark Brown wrote:
> 
>>> I'm not sure that IIO isn't the kernel subsystem we're looking for here
>>> - as I keep saying when this comes up it's just representing bare DACs
>>> and ADCs pretty directly which looks like a generic subsystem to me.
> 
>> Possible, yes. Until now, IIO is a subsystem for user-level access
>> not for kernel access though, so it's not the right place yet.
>> If we decide to let IIO handle all ADC input, do you think it would
>> also be the right place to do PWM output, rather than having a
>> separate subsystem for that?
> 
> Off the top of my head I'd expect PWM to be a separate thing which could
> optionally synthesize stuff onto an IIO device (bitbanging the PWM
> essentially).  The specialized PWM stuff tends to be "output this steady
> state for an indefinite period" type interface rather than "here's a
> batch of samples, output them".
Same can be true of dds chips, with the addition that they often have
gpio type switching between a set of predefined frequencies (FM basically).
+ weird waveform choices sometimes.
