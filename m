Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2on0054.outbound.protection.outlook.com ([207.46.100.54]:22976
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752300AbcCGMdV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 7 Mar 2016 07:33:21 -0500
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH v2] iio: dac: Add support for the AD5592R/AD5593R
 ADCs/DACs
References: <1456407412-16218-1-git-send-email-michael.hennerich@analog.com>
 <56D1E1CB.6070704@kernel.org> <56D71309.30204@analog.com>
 <56DB1E49.3070908@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
	<knaack.h@gmx.de>, <paul.cercueil@analog.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <56DD7342.5040101@analog.com>
Date: Mon, 7 Mar 2016 13:25:38 +0100
MIME-Version: 1.0
In-Reply-To: <56DB1E49.3070908@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/05/2016 06:58 PM, Jonathan Cameron wrote:
> On 02/03/16 16:21, Michael Hennerich wrote:
>> On 02/27/2016 06:50 PM, Jonathan Cameron wrote:
>>> On 25/02/16 13:36, michael.hennerich@analog.com wrote:
>>>> From: Paul Cercueil <paul.cercueil@analog.com>
>>>>
>>>> This patch adds support for the AD5592R (spi) and AD5593R (i2c)
>>>> ADC/DAC devices.
>>>>
>>>> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
>>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>>>
>>> A few bits inline.
>>>
>>> I'll need a gpio review on this (looks fine to me but it does contain
>>> a gpiochip driver.) Not to mention the question of whether they will
>>> be happy with a gpio chip hiding in iio (rather than via an mfd with a
>>> separate driver - which feels like overkill here).
>>>
>>> The big question to my mind is whether we can take the view this won't
>>> be the last multipurpose chip we will see so do we need to sort the
>>> binding out to make it generic?  It'll be a bit of a pain for you
>>> but I think we can do it fairly easily.
>>> (either way I'll also need a device tree ack on this one!)
>>>
>>> So then we get into the question of the best way of doing the bindings.
>>> The gpio approach seems a little limiting for things as flexible as
>>> this but we should certainly be using their macros where relevant.
>>
>> Hi Jonathan,
>>
>> Thanks for the review.
>>
>> The problem is see is that using GPIOF_OPEN_DRAIN, will simulate OPEN DRAIN behaviour only, by configuring the device for input when outputing logic high.
>>
> Is it actually documented as such anywhere? (that's hideous!)


In fact it is -
www.kernel.org/doc/Documentation/gpio/gpio-legacy.txt

"When setting the flag as GPIOF_OPEN_DRAIN then it will assume that pins is
open drain type. Such pins will not be driven to 1 in output mode. It is
require to connect pull-up on such pins. By enabling this flag, gpio lib 
will
make the direction to input when it is asked to set value of 1 in output 
mode
to make the pin HIGH. The pin is make to LOW by driving value 0 in 
output mode."

And that's exactly what the gpiolib code does.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
