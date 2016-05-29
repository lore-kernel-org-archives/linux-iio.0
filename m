Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34383 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbcE2T3n (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 15:29:43 -0400
Subject: Re: [PATCH 3/3] iio: st_sensors: Use level interrupts
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
 <6c5cc47895ca35fce84b6b01a3ecf7df928aa197.1463164919.git.leonard.crestez@intel.com>
 <CACRpkdbch1dhUTdCMxLqLHY_cfmgtFvxKoBaCwf7w=RjV0vh7A@mail.gmail.com>
 <821accfa-33fc-9d64-2601-7feae77bf38a@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a27872f0-6359-2c73-002c-2550ef6a9a2b@kernel.org>
Date: Sun, 29 May 2016 20:29:40 +0100
MIME-Version: 1.0
In-Reply-To: <821accfa-33fc-9d64-2601-7feae77bf38a@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/05/16 13:35, Crestez Dan Leonard wrote:
> On 05/24/2016 02:40 PM, Linus Walleij wrote:
>> On Fri, May 13, 2016 at 8:43 PM, Crestez Dan Leonard
>> <leonard.crestez@intel.com> wrote:
>>
>>> As far as I can tell DRDY for ST sensors behaves as a level rather than
>>> edge interrupt. Registering for IRQF_TRIGGER_RISING instead of
>>> IRQF_TRIGGER_HIGH mostly works except when the sampling frequency is
>>> high enough that new samples come before the new ones are read
>>> completely. In that case the interrupt line remains high, no more rising
>>> edges occur and the iio buffer stalls.
>>>
>>> Configuring the interrupt as IRQF_TRIGGER_HIGH makes it work as
>>> expected. This patch makes it so that st_sensors_trigger interrupt
>>> request code doesn't mangle the request flags into IRQF_TRIGGER_RISING.
>>>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Giuseppe Barba <giuseppe.barba@st.com>
>>> Cc: Denis Ciocca <denis.ciocca@st.com>
>>> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
>>
>> The analysis is probably correct: the sensors will hold the line low
>> until the values have been read and no data is ready in the pipe.
>>
>> This is delicate when the sensors are used with GPIO controllers
>> as interrupt line handlers, because some of them (like mine
>> on Ux500) do not support level interrupts :(
> 
> This might be completely crazy, but wouldn't it be possible to support
> gpio level interrupts purely in software? Just read the GPIO state again
> after the interrupt is unmasked and retrigger.
> 
> This seems preferable to implementing per-driver workarounds. Perhaps it
> would even fit in some gpio-irqchip glue.
That's precisely the question I raised way back when writing the lis3l02dq
driver.  Apparently someone once had a go but it never went anywhere...

Feel free to try! It would be great if possible.

Jonathan
> 

