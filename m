Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57903 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbbHHLSP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:18:15 -0400
Subject: Re: [PATCH v2 2/7] iio:accel:stk8312: check for invalid value
To: Hartmut Knaack <knaack.h@gmx.de>, Crt Mori <cmo@melexis.com>
References: <cover.1438204273.git.knaack.h@gmx.de>
 <f406a1b129207e44ed3c6a07a8d44e16f6f3f74f.1438204273.git.knaack.h@gmx.de>
 <CAKv63utc6+a5XS5eLkzggcnvcrfN=zTsTAJfNNethnPmr2S9Yg@mail.gmail.com>
 <55BBFCA6.1090803@gmx.de>
 <CAKv63usdVqx_kX8H45SpWX4wzpQ44SwMAHbBSjY8eC0bnw3dkQ@mail.gmail.com>
 <55C3DE5E.9050603@gmx.de>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5E573.3010203@kernel.org>
Date: Sat, 8 Aug 2015 12:18:11 +0100
MIME-Version: 1.0
In-Reply-To: <55C3DE5E.9050603@gmx.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/08/15 23:23, Hartmut Knaack wrote:
> Crt Mori schrieb am 01.08.2015 um 09:35:
>> On 1 August 2015 at 00:54, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>> Crt Mori schrieb am 30.07.2015 um 09:09:
>>>> On 29 July 2015 at 23:39, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>>>> Revision 1.2 of the datasheet recommends on page 22 to only write non-zero
>>>>> values read from OTP register 0x70 into AFECTRL register.
>>>>>
>>>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>>>>> Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
>>>>> ---
>>>>>  drivers/iio/accel/stk8312.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
>>>>> index c2bd1444d6da..6592be8e6377 100644
>>>>> --- a/drivers/iio/accel/stk8312.c
>>>>> +++ b/drivers/iio/accel/stk8312.c
>>>>> @@ -150,6 +150,8 @@ static int stk8312_otp_init(struct stk8312_data *data)
>>>>>                 goto exit_err;
>>>>>
>>>>>         ret = i2c_smbus_read_byte_data(client, STK8312_REG_OTPDATA);
>>>>> +       if (ret == 0)
>>>>> +               ret = -EINVAL;
>>>> This seems fishy. We have a macro value written to client which cannot really
>>>> give us EINVAL, except if we are checking the client, but then this would only
>>>> fail if we had some other i2c device on the line with stk8312 address, which
>>>> would ack other i2c commands above this.
>>>
>>> I'm not sure to really understand your point, or if you actually understood
>>> this patch. I'm not totally happy with EINVAL as error code, but it just
>>> seemed to fit better than any other possible error code. Of course I would
>>> be happy to get recommendations for better fitting codes.
>>> A short explanation why this is done: in the sample code provided in the
>>> data sheet, it is mentioned that if the value read from that register 0x70
>>> is zero, then it should not be written into the AFECTRL register. So, that's
>>> what I have addressed here.
>> EINVAL is more like bad user input, so if this fails because of the last command
>> then it is correct, otherwise I would put more like -EBUSY or -EACCES
>>
> 
> Tiberiu, I'd like to get your opinion on these alternative error codes. Do you
> have any information why the read value could be zero and why that AFECTRL
> register should not be set to zero?
> Thanks,
> 
> Hartmut
I already applied version 1 of this patch, so send an follow up if the decision
is that there is a better error code.

J
> 
>> Thank you for the explanation.
>>
>>>
>>>>>         if (ret < 0)
>>>>>                 goto exit_err;
>>>>>
>>>>> --
>>>>> 2.4.6
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

