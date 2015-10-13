Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from netline-mail3.netline.ch ([78.47.214.34]:48987 "EHLO
	netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbbJMJqm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2015 05:46:42 -0400
Subject: Re: [PATCH] iio: Add support for LTC26xx I2C DAC
To: Lars-Peter Clausen <lars@metafoo.de>, jic23@kernel.org
References: <1444639977-42834-1-git-send-email-marc.andre@netline.ch>
 <561B8AE1.9040408@metafoo.de> <561BAD5F.7040209@netline.ch>
 <561BBF1D.8070001@metafoo.de> <561CAE46.5070909@netline.ch>
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
From: Marc Andre <marc.andre@netline.ch>
Message-ID: <561CD2FE.4060103@netline.ch>
Date: Tue, 13 Oct 2015 11:46:38 +0200
MIME-Version: 1.0
In-Reply-To: <561CAE46.5070909@netline.ch>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13.10.2015 09:09, Marc Andre wrote:
> On 12.10.2015 16:09, Lars-Peter Clausen wrote:
>> On 10/12/2015 02:53 PM, Marc Andre wrote:
>>> On 12.10.2015 12:26, Lars-Peter Clausen wrote:
>>>> On 10/12/2015 10:52 AM, Marc Andre wrote:
>>>>> This driver adds support for the Linear LTC26x6, LTC26x7 and 
>>>>> LTC26x9 I2C
>>>>> DAC chips.
>>>> Those look like they are very much register map compatible to what is
>>>> supported by the AD5064 driver.    It makes sense to add support 
>>>> for them
>>>> there
>>>> instead of having a separate driver.
>>> I see that the interfaces are similar. Not all features of the 
>>> ADxxxx are
>>> supported by the LTC26XX. e.g. it doesn't support the different 
>>> power down
>>> modes. It also doesn't support the configuration register.
>>> Other features available to AD which are not available to the LTC 
>>> are LDAC
>>> by software, RESET and CLEAR commands. Those commands are currently 
>>> not in
>>> use by the driver, but in the future, if those commands are used, a
>>> separation would have to be done to avoid issues with the LTC.
>>>
>>> I first also thought that the address / command location is 
>>> different as the
>>> AD5064 sends 4 bytes and "AD5064_ADDR(x)" is "((x) << 20)". By further
>>> reviewing I see that this only applies to SPI connected devices, 
>>> while I2C
>>> connected devices have 3 bytes as LTC26xx.
>>>
>>> I am quite open. I have the tendency to suggest a separate ltc26xx 
>>> driver,
>>> also because it would allow simpler identification of the driver and
>>> separate evolution. (Someone would need to know that AD4064 is 
>>> compatible to
>>> LTC26xx) I also think large drivers containing many separations between
>>> similar, but not equal devices are more risky to break on changes. 
>>> No one
>>> has all those devices available for test. But I am a new contributor 
>>> to the
>>> Kernel, thus I am interested to listen to the experts... :-)
>> It's a subset, but it is a clean subset. The LTC26xx don't have any 
>> extra
>> functionality not yet supported by the AD5064 driver.
>>
>> And I'm pretty convinced the chip was purposefully designed to be 
>> register
>> map compatible, would be a shame not to make use of that. Means we 
>> only have
>> to fix things in one driver if we find a bug, or e.g. if we want the 
>> feature
>> of being able to update all channels at the same time.
>>
> I started testing with the ad5064 driver, but the driver seams to be 
> quite broken for i2c. Before I fix all of it, I just want to confirm 
> that I didn't get it wrong:
> - ad5064_write_raw() expects the ad5064_write() to return 0 if 
> success. But ad5064_i2c_write() directly returns the return value of 
> i2c_master_send() which is the number of bytes sent if successful. I 
> need to add a wrap to convert the return value of i2c_master_send() to 
> 0 if the correct number of bytes is written.
> - #define AD5064_CHANNEL() sets the shift as follows: .shift = 20 - bits
> ad5064_write then applies this shift before sending it to the i2c/spi 
> command. This assumes that the number of data bits is 20 for all DAC 
> chips. As written yesterday this seams to be only true for the SPI 
> type chips. The I2C type chips use 2 bytes (16 bits).
>
> Do you know if the ad5064 driver has been used for any i2c type device 
> yet? Was it tested?
>
> If I want to implement LTC2617 (and fix the other i2c devices), I will 
> have to do a few patches and also make some changes to structures 
> (i.e. adjust the shift bits based on sensor type). I am ok to do that, 
> but just want to confirm first that this is your intention.
>
> Marc
>
After further thoughts I wonder if would make sense to split of AD5629 
and AD5629 from the AD5064 driver and keep AD5064 driver for SPI based 
devices with 20 data bits and make a new driver for I2C based devices 
with 16 data bits.
I could submit a new driver which combines AD5629 and LTC2617 (and 
similar devices).

