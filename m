Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49998 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbbJLRZ7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Oct 2015 13:25:59 -0400
Subject: Re: [PATCH] iio: Add support for LTC26xx I2C DAC
To: Lars-Peter Clausen <lars@metafoo.de>,
	Marc Andre <marc.andre@netline.ch>
References: <1444639977-42834-1-git-send-email-marc.andre@netline.ch>
 <561B8AE1.9040408@metafoo.de> <561BAD5F.7040209@netline.ch>
 <561BBF1D.8070001@metafoo.de>
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561BED24.4010906@kernel.org>
Date: Mon, 12 Oct 2015 18:25:56 +0100
MIME-Version: 1.0
In-Reply-To: <561BBF1D.8070001@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/10/15 15:09, Lars-Peter Clausen wrote:
> On 10/12/2015 02:53 PM, Marc Andre wrote:
>> On 12.10.2015 12:26, Lars-Peter Clausen wrote:
>>> On 10/12/2015 10:52 AM, Marc Andre wrote:
>>>> This driver adds support for the Linear LTC26x6, LTC26x7 and LTC26x9 I2C
>>>> DAC chips.
>>> Those look like they are very much register map compatible to what is
>>> supported by the AD5064 driver.    It makes sense to add support for them
>>> there
>>> instead of having a separate driver.
>> I see that the interfaces are similar. Not all features of the ADxxxx are
>> supported by the LTC26XX. e.g. it doesn't support the different power down
>> modes. It also doesn't support the configuration register.
>> Other features available to AD which are not available to the LTC are LDAC
>> by software, RESET and CLEAR commands. Those commands are currently not in
>> use by the driver, but in the future, if those commands are used, a
>> separation would have to be done to avoid issues with the LTC.
>>
>> I first also thought that the address / command location is different as the
>> AD5064 sends 4 bytes and "AD5064_ADDR(x)" is "((x) << 20)". By further
>> reviewing I see that this only applies to SPI connected devices, while I2C
>> connected devices have 3 bytes as LTC26xx.
>>
>> I am quite open. I have the tendency to suggest a separate ltc26xx driver,
>> also because it would allow simpler identification of the driver and
>> separate evolution. (Someone would need to know that AD4064 is compatible to
>> LTC26xx) I also think large drivers containing many separations between
>> similar, but not equal devices are more risky to break on changes. No one
>> has all those devices available for test. But I am a new contributor to the
>> Kernel, thus I am interested to listen to the experts... :-)
> 
> It's a subset, but it is a clean subset. The LTC26xx don't have any extra
> functionality not yet supported by the AD5064 driver.
> 
> And I'm pretty convinced the chip was purposefully designed to be register
> map compatible, would be a shame not to make use of that. Means we only have
> to fix things in one driver if we find a bug, or e.g. if we want the feature
> of being able to update all channels at the same time.
I would also favour adding the additional device support to the ad5064 driver
for all the reasons Lars stated.

As an aside, if you have a driver supporting multiple parts please just name
it after one of them.  The wild card thing goes wrong so often. In this
case there is an LTC2641 for starters that this doesn't support.

If you want a mega case of this see something like the max1363 which supports
a 'few' parts ;)  Actually I should do another browse to find out what Maxim
have brought out more recently that is compatible.

Jonathan
> 
> - Lars
> 

