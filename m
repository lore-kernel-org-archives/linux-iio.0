Return-Path: <knaack.h@gmx.de>
Message-ID: <52C4A27B.6030407@gmx.de>
Date: Thu, 02 Jan 2014 00:19:23 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH]staging:iio:ad799x make use of platform_data optional
References: <52C00C37.2080009@gmx.de> <52C4105F.3020600@kernel.org> <52C4154F.2050902@gmx.de> <52C422D7.4030609@kernel.org> <52C43656.2040800@metafoo.de>
In-Reply-To: <52C43656.2040800@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Lars-Peter Clausen schrieb:
> On 01/01/2014 03:14 PM, Jonathan Cameron wrote:
>>
>> On 01/01/14 13:17, Hartmut Knaack wrote:
>>> Jonathan Cameron schrieb:
>>>> On 29/12/13 11:49, Hartmut Knaack wrote:
>>>>> Setting Vref with platform_data is a neat feature, though it is
>>>>> not essential for operating these devices. So make the use of
>>>>> platform_data optional and set default value of 1000 mV if
>>>>> nothing else is defined.
>>>>>
>>>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>>>> Hi Hartmut,
>>> Hi
>>>> Why a default of 1V?  Does that correspond to anything in
>>>> particular?
>>> This makes it easier to calculate your real voltage, since you only
>>> need to multiply with your reference voltage. Another reason: if you
>>> are more interested in the relation of your input in the range
>>> [0V-Vref], you can simply get the per mill value.
>> Sorry, but I'm not going to take this as whilst I can see how it
>> is useful for your use case, it would introduce a new non standard
>> interface.
> Yep, this sounds like a hack. It's definitely something that we do not want
> to do as it wont work with applications that assume the standard ABI. That
> said, the driver should be updated to not allow specifying the reference
> voltage via platform data, but only use the regulator API, like we did for
> other drivers as well. I have a more or less untested patch for this, see
> https://github.com/analogdevicesinc/linux/commit/18a2c9a304fea7360b10c9041995cad122fbff07
This attempt looks promising to me.
Yet, at line 553:
+  if (!IS_ERR(st->reg))
+    return PTR_ERR(st->reg);
Since the man-page [1] states: "Returns non-0 value if the /ptr/ is an error. Otherwise 0 if it's not an error." Shouldn't that be done without negation?

[1] http://dev.gentoo.org/~cardoe/man-pages/man9/IS_ERR.9.html
>>>> Whilst the way this is set here is clunky there is a need for this
>>>> voltage to be supplied in some fashion.  Now we'd do it via a
>>>> regulator to give us nice standard device tree bindings and to
>>>> allow for less simplistic hardware configurations.
>>>>
>>>> So lets say we convert this to use a regulator, is there still a
>>>> reason why one might want a default value?
>>> I'm not aware of the current state of the device tree implementation
>>> at the moment. My intention is to also be able to use this driver
>>> without the need of compiling a custom kernel (so to use the
>>> distribution of choice out of the box).
>> Then it needs to be device tree enabled and the configuration done
>> via that.
> I think with the above patch the driver should work fine with devicetree.
>
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
