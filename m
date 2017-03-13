Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48015 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdCMUje (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:39:34 -0400
Subject: Re: [Outreachy kernel] Re: [PATCH v2] staging: iio: ad7280a: Group
 similar macros into enums
To: Julia Lawall <julia.lawall@lip6.fr>,
        sayli karnik <karniksayli1995@gmail.com>
References: <20170307191112.GA29306@sayli-HP-15-Notebook-PC>
 <20170307191746.GA22068@kroah.com>
 <CAKG5xWiuKm2VboRAR2ALz+SnHPbcBTQvH2Hw+Rpkfm2P+GK2Qg@mail.gmail.com>
 <alpine.DEB.2.20.1703080736250.2108@hadrien>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy-kernel <outreachy-kernel@googlegroups.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f52ff321-649f-d90b-6d17-58c4905866b2@kernel.org>
Date: Mon, 13 Mar 2017 20:39:31 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703080736250.2108@hadrien>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/03/17 06:47, Julia Lawall wrote:
> 
> 
> On Wed, 8 Mar 2017, sayli karnik wrote:
> 
>>
>>
>> On Wed, Mar 8, 2017 at 12:47 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> On Wed, Mar 08, 2017 at 12:41:12AM +0530, sayli karnik wrote:
>>>> The patch groups similar macros into enum data types.
>>>
>>> Why?
>>>
>>> What benefit does this provide?
>> As suggested by Lars, I converted the macros to an enum data type, so that
>> it is clear what their function is-
>> https://groups.google.com/d/msg/outreachy-kernel/VM6Wu-fJVfQ/VngpohNBAwAJ
>>
>>>
>>>>
>>>> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>> Corrected the order of both the enums.
>>>> Used enum data type names instead of unsigned int inside struct
>>>> ad7280_platform_data.
>>>>
>>>>  drivers/staging/iio/adc/ad7280a.h | 24 ++++++++++++++----------
>>>>  1 file changed, 14 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/iio/adc/ad7280a.h
>> b/drivers/staging/iio/adc/ad7280a.h
>>>> index ccfb90d..e22694f 100644
>>>> --- a/drivers/staging/iio/adc/ad7280a.h
>>>> +++ b/drivers/staging/iio/adc/ad7280a.h
>>>> @@ -13,15 +13,19 @@
>>>>   * TODO: struct ad7280_platform_data needs to go into include/linux/iio
>>>>   */
>>>>
>>>> -#define AD7280A_ACQ_TIME_400ns                       0
>>>> -#define AD7280A_ACQ_TIME_800ns                       1
>>>> -#define AD7280A_ACQ_TIME_1200ns                      2
>>>> -#define AD7280A_ACQ_TIME_1600ns                      3
>>>> +enum ad7280a_acq_time {
>>>> +     AD7280A_ACQ_TIME_400ns = 0,
>>>> +     AD7280A_ACQ_TIME_800ns,
>>>> +     AD7280A_ACQ_TIME_1200ns,
>>>> +     AD7280A_ACQ_TIME_1600ns,
>>>
>>> Before your change, you instantly knew that the 1600ns value needed to
>>> be 3.  Now I need to count an enum.  Does this seem like a better
>>> change?
>>
>> Hmm we do need to count.
>> But,
>> -I feel grouping into an enum organizes similar #defines in a better way.
>>
>> -You get free compile time checking of valid values using enums. For example
>>
>> public static int VALUE_ONE = 0;
>> public static int VALUE_TWO = 1;
>>
>> does not ensure,
>>
>> void selectOption(int value) {
>> ...
>> }
>> will only accept 0 or 1 as a parameter value. Using an enum, that is
>> guaranteed.
> 
> Regrettably in C it is not.
> 
> Still, using enums does make it possible to design tools that do such
> checking.  With a random bunch of defines it is less clear what goes with
> what.
> 
>>
>> -Also it avoids the repetitive #defines.
>>
>>> Are you _sure_ the compiler sets the values properly?
> 
> Page 105 of this document
> 
> WG14/N1256 Committee Draft — Septermber 7, 2007 ISO/IEC 9899:TC3
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
> 
> says:
> 
> An enumerator with = defines its enumeration constant as the value of the
> constant expression.  If the first enumerator has no =, the value of its
> enumeration constant is 0. Each subsequent enumerator with no = defines
> its enumeration constant as the value of the constant expression obtained
> by adding 1 to the value of the previous enumeration constant.
> 
> 
> One could also check whether the actual value is important, eg the
> constant is passed to a device, or if it is just used as an internal flag.
This is the key element to my mind.   Scan indexes are just a software
construction.  We want them to be consistent, but don't really care exactly
what they are as long as the are monotonic.

For register values like these ones it gets less obvious.  Personally I
prefer the consistency of just having them as defines, even though you
loose the checking of type, which can be useful.

Jonathan
> 
> julia
> 
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to outreachy-kernel+unsubscribe@googlegroups.com.
>> To post to this group, send email to outreachy-kernel@googlegroups.com.
>> To view this discussion on the web visithttps://groups.google.com/d/msgid/outreachy-kernel/CAKG5xWiuKm2VboRAR2ALz%2
>> BSnHPbcBTQvH2Hw%2BRpkfm2P%2BGK2Qg%40mail.gmail.com.
>> For more options, visit https://groups.google.com/d/optout.
>>
>>
> 

