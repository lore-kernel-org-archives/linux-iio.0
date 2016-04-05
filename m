Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2on0090.outbound.protection.outlook.com ([65.55.169.90]:30784
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757335AbcDEH3I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Apr 2016 03:29:08 -0400
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH v5] iio: dac: Add support for the AD5592R/AD5593R
 ADCs/DACs
References: <1458721195-28915-1-git-send-email-michael.hennerich@analog.com>
 <CACRpkdYAqPn9o-wMbb-iZn7bjad8u9JmdwRqwrjFMArPrOXEOQ@mail.gmail.com>
 <5700E4E8.40304@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
CC: Alexandre Courbot <gnurou@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Paul Cercueil <paul.cercueil@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=c5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <57036769.4070102@analog.com>
Date: Tue, 5 Apr 2016 09:21:13 +0200
MIME-Version: 1.0
In-Reply-To: <5700E4E8.40304@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/03/2016 11:39 AM, Jonathan Cameron wrote:
> On 31/03/16 09:01, Linus Walleij wrote:
>> On Wed, Mar 23, 2016 at 9:19 AM,  <michael.hennerich@analog.com> wrote:
>>
>>> From: Paul Cercueil <paul.cercueil@analog.com>
>>>
>>> This patch adds support for the AD5592R (spi) and AD5593R (i2c)
>>> ADC/DAC/GPIO devices.
>>>
>>> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>
>> For this v5 version:
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> I'm fine with this new gpiochip driver being merged into the
>> IIO tree.
>>
> Cool,  Paul / Michael,
>
> I still had a few trivial outstanding comments. Please remember to add
> this reviewed-by to V6.


Hi Jonathan,

Sorry I missed these -

With the comment added to the CH_MODE_DAC_AND_ADC description in the 
bindings. Do you think we need another ACK from Rob?

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
