Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45188 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbcDENMF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Apr 2016 09:12:05 -0400
In-Reply-To: <57036769.4070102@analog.com>
References: <1458721195-28915-1-git-send-email-michael.hennerich@analog.com> <CACRpkdYAqPn9o-wMbb-iZn7bjad8u9JmdwRqwrjFMArPrOXEOQ@mail.gmail.com> <5700E4E8.40304@kernel.org> <57036769.4070102@analog.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v5] iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 05 Apr 2016 14:11:57 +0100
To: michael.hennerich@analog.com, Jonathan Cameron <jic23@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
CC: Alexandre Courbot <gnurou@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Paul Cercueil <paul.cercueil@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Message-ID: <7C7C5530-7B41-4AEE-A689-613B9D2679E0@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 5 April 2016 08:21:13 BST, Michael Hennerich <michael.hennerich@analog.com> wrote:
>On 04/03/2016 11:39 AM, Jonathan Cameron wrote:
>> On 31/03/16 09:01, Linus Walleij wrote:
>>> On Wed, Mar 23, 2016 at 9:19 AM,  <michael.hennerich@analog.com>
>wrote:
>>>
>>>> From: Paul Cercueil <paul.cercueil@analog.com>
>>>>
>>>> This patch adds support for the AD5592R (spi) and AD5593R (i2c)
>>>> ADC/DAC/GPIO devices.
>>>>
>>>> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
>>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> For this v5 version:
>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> I'm fine with this new gpiochip driver being merged into the
>>> IIO tree.
>>>
>> Cool,  Paul / Michael,
>>
>> I still had a few trivial outstanding comments. Please remember to
>add
>> this reviewed-by to V6.
>
>
>Hi Jonathan,
>
>Sorry I missed these -
>
>With the comment added to the CH_MODE_DAC_AND_ADC description in the 
>bindings. Do you think we need another ACK from Rob?
I am sure Rob won't mind the addition of this clarification so no need to get
 another review (though always welcome if Rob happens to give one!)

Jonathan

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
