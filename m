Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37389 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbaKHMRc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Nov 2014 07:17:32 -0500
Message-ID: <545E09DA.3040501@kernel.org>
Date: Sat, 08 Nov 2014 12:17:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Gwendal Grignou <gwendal@google.com>
CC: Gwendal Grignou <gwendal@chromium.org>, knaack.h@gmx.de,
	linux-iio@vger.kernel.org
Subject: Re: [PATCHv2] iio: ak8975: Add AKM0991x support.
References: <5458003C.90107@gmx.de>	 <1415130097-25080-1-git-send-email-gwendal@chromium.org>	 <545A34AC.9040606@kernel.org>	 <CAMHSBOWmmCdd=5HXJN-vz9saaPrq3n0p-LjCNvnX3Q3ZieZdRQ@mail.gmail.com> <1415284340.7340.9.camel@spandruv-hsb-test>
In-Reply-To: <1415284340.7340.9.camel@spandruv-hsb-test>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/14 14:32, Srinivas Pandruvada wrote:
> On Wed, 2014-11-05 at 13:19 -0800, Gwendal Grignou wrote:
>> On Wed, Nov 5, 2014 at 6:31 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 04/11/14 19:41, Gwendal Grignou wrote:
>>>> File and config id remains the same, but driver is now named akxxxx.
>>>
>>> Don't do that.  Please name the driver after one supported part rather
>>> than a general wild card.  Leaving it as ak8975 would be sensible.
>>> Wild cards seem like a good idea until along comes a part that fits
>>> in the naming scheme but is otherwise totally different.
>>>
>>> Much cleaner to just pick a part to use in naming the driver and
>>> make it clear what parts are supported in kconfig (see iio/adc/max1363 for
>>> example).
>> Will do. It is cleaner indeed.
>>>
>>> I would have prefered this as a two patch series.  The first combining
>>> the existing drivers, and the second (small one) adding the new part
>>> support.
>> I will submit 3 patches soon:
>> - minor fixes in the driver first,
>> - one that refactor the current driver to introduce a definition data structure
>> - the next one that remove ak9911.c and add support for ak09911 and
>> ak9912 into ak8975.c
>>>
>>> Would have broken it up into logical steps thus making it a little
>>> easier to check for feature parity etc.
>>>
>>> Once you've dropped the name change, this patch will contain less noise.
>>> Also, there are a couple of sensible refactorings in there.  I would
>>> have prefered these to be in precursor patches that made much smaller
>>> changes.
>> The re-factoring became obvious after I introduce the definition data structure.
>>>
>>> This sort of merging of drivers is one of the hardest types of code to
>>> review, so making it as easy as possible for reviewers by packaging
>>> it up as baby steps is the way to go.
>>>
>>> There is still some work to be done in convincing people that merging
>>> the drivers is sensible (I'm pretty much convinced having waded through
>>> this) but that is an easier job with a well split up series of steps!
>>>
>>> Jonathan
>>>
>>>> Move AKM09911 support in the same file.
>>>>
>>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>>>> ---
>>>>
>>>> Addressed all comments from Hartmut.
>>>>
>>>>  drivers/iio/magnetometer/Kconfig   |  19 +-
>>>>  drivers/iio/magnetometer/Makefile  |   1 -
>>>>  drivers/iio/magnetometer/ak09911.c | 326 -------------------
>>>>  drivers/iio/magnetometer/ak8975.c  | 629 ++++++++++++++++++++++++++-----------
>>>>  4 files changed, 444 insertions(+), 531 deletions(-)
>>>>  delete mode 100644 drivers/iio/magnetometer/ak09911.c
>>>>
>>>> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
>>>> index b2dba9e..67f005d 100644
>>>> --- a/drivers/iio/magnetometer/Kconfig
>>>> +++ b/drivers/iio/magnetometer/Kconfig
>>>> @@ -6,26 +6,15 @@
>>>>  menu "Magnetometer sensors"
>>>>
>>>>  config AK8975
>>>> -     tristate "Asahi Kasei AK8975 3-Axis Magnetometer"
>>>> +     tristate "Asahi Kasei AK 3-Axis Magnetometer"
>>>>       depends on I2C
>>>>       depends on GPIOLIB
>>>>       help
>>>> -       Say yes here to build support for Asahi Kasei AK8975 3-Axis
>>>> -       Magnetometer. This driver can also support AK8963, if i2c
>>>> -       device name is identified as ak8963.
>>>> +       Say yes here to build support for Asahi Kasei AK8975, AK8963,
>>>> +       AK09911 or AK09912 3-Axis Magnetometer.
>>>>
>>>>         To compile this driver as a module, choose M here: the module
>>>> -       will be called ak8975.
>>>> -
>>>> -config AK09911
>>>> -     tristate "Asahi Kasei AK09911 3-axis Compass"
>>>> -     depends on I2C
>>>> -     help
>>>> -       Say yes here to build support for Asahi Kasei AK09911 3-Axis
>>>> -       Magnetometer.
>>>> -
>>>> -       To compile this driver as a module, choose M here: the module
>>>> -       will be called ak09911.
>>>> +       will be called akxxxx.
>>>>
> We already have released products with CONFIG_AK09911, so will next
> kernel upgrade will break them. Customers don't allow config changes.
> So we can't remove this config.
> Merging of drivers is fine. At the least we should keep the config and
> select the AK8975 when defined in the config if we remove AK09911.
> 
> Jonathan,
> What do you think? This driver is part of a commercial released product.
> As you know customers are very sensitive about .config changes.
Absolutely.  When merging drivers putting in some config magic
to select the new driver is a common solution.

> 
> Thanks,
> Srinivas
> 


