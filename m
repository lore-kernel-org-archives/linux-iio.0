Return-Path: <knaack.h@gmx.de>
Message-ID: <55CA3FA3.4030905@gmx.de>
Date: Tue, 11 Aug 2015 20:32:03 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Crt Mori <cmo@melexis.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 2/7] iio:accel:stk8312: check for invalid value
References: <cover.1438204273.git.knaack.h@gmx.de> <f406a1b129207e44ed3c6a07a8d44e16f6f3f74f.1438204273.git.knaack.h@gmx.de> <CAKv63utc6+a5XS5eLkzggcnvcrfN=zTsTAJfNNethnPmr2S9Yg@mail.gmail.com> <55BBFCA6.1090803@gmx.de> <CAKv63usdVqx_kX8H45SpWX4wzpQ44SwMAHbBSjY8eC0bnw3dkQ@mail.gmail.com> <55C3DE5E.9050603@gmx.de> <55C5E573.3010203@kernel.org> <4586F61A4A291F4DA44D32824E7C0F402218B53E@IRSMSX109.ger.corp.intel.com>
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F402218B53E@IRSMSX109.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Breana, Tiberiu A schrieb am 10.08.2015 um 11:24:
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@kernel.org]
>> Sent: Saturday, August 8, 2015 2:18 PM
>> To: Hartmut Knaack; Crt Mori
>> Cc: linux-iio@vger.kernel.org; Lars-Peter Clausen; Peter Meerwald; Breana,
>> Tiberiu A
>> Subject: Re: [PATCH v2 2/7] iio:accel:stk8312: check for invalid value
>>
>> On 06/08/15 23:23, Hartmut Knaack wrote:
>>> Crt Mori schrieb am 01.08.2015 um 09:35:
>>>> On 1 August 2015 at 00:54, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>>>> Crt Mori schrieb am 30.07.2015 um 09:09:
>>>>>> On 29 July 2015 at 23:39, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>>>>>> Revision 1.2 of the datasheet recommends on page 22 to only write
>>>>>>> non-zero values read from OTP register 0x70 into AFECTRL register.
>>>>>>>
>>>>>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>>>>>>> Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
>>>>>>> ---
>>>>>>>  drivers/iio/accel/stk8312.c | 2 ++
>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/iio/accel/stk8312.c
>>>>>>> b/drivers/iio/accel/stk8312.c index c2bd1444d6da..6592be8e6377
>>>>>>> 100644
>>>>>>> --- a/drivers/iio/accel/stk8312.c
>>>>>>> +++ b/drivers/iio/accel/stk8312.c
>>>>>>> @@ -150,6 +150,8 @@ static int stk8312_otp_init(struct stk8312_data
>> *data)
>>>>>>>                 goto exit_err;
>>>>>>>
>>>>>>>         ret = i2c_smbus_read_byte_data(client,
>>>>>>> STK8312_REG_OTPDATA);
>>>>>>> +       if (ret == 0)
>>>>>>> +               ret = -EINVAL;
>>>>>> This seems fishy. We have a macro value written to client which
>>>>>> cannot really give us EINVAL, except if we are checking the client,
>>>>>> but then this would only fail if we had some other i2c device on
>>>>>> the line with stk8312 address, which would ack other i2c commands
>> above this.
>>>>>
>>>>> I'm not sure to really understand your point, or if you actually
>>>>> understood this patch. I'm not totally happy with EINVAL as error
>>>>> code, but it just seemed to fit better than any other possible error
>>>>> code. Of course I would be happy to get recommendations for better
>> fitting codes.
>>>>> A short explanation why this is done: in the sample code provided in
>>>>> the data sheet, it is mentioned that if the value read from that
>>>>> register 0x70 is zero, then it should not be written into the
>>>>> AFECTRL register. So, that's what I have addressed here.
>>>> EINVAL is more like bad user input, so if this fails because of the
>>>> last command then it is correct, otherwise I would put more like
>>>> -EBUSY or -EACCES
>>>>
>>>
>>> Tiberiu, I'd like to get your opinion on these alternative error
>>> codes. Do you have any information why the read value could be zero
>>> and why that AFECTRL register should not be set to zero?
>>> Thanks,
>>>
>>> Hartmut
> 
> I don't know why the read value could be 0. The only information I have is the datasheet, same as you. I think EINVAL is fine; EBUSY would also make sense. It's up to you.
> 
> Tiberiu
> 

I'm not feeling any strong preference for any other code. EBUSY however doesn't
seem so appropriate either, since the device indicated already by setting bit 7
of _REG_OTPCTRL that it is ready. I would prefer to leave it as is, and whoever
has good reason for another code shall feel free to change it.
Thanks

Hartmut

>> I already applied version 1 of this patch, so send an follow up if the decision is
>> that there is a better error code.
>>
>> J
>>>
>>>> Thank you for the explanation.
>>>>
>>>>>
>>>>>>>         if (ret < 0)
>>>>>>>                 goto exit_err;
>>>>>>>
>>>>>>> --
>>>>>>> 2.4.6
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>> linux-iio" in the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-
>> info.html
> N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
> 
