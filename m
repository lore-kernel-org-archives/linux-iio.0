Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35556 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbHAHgE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 1 Aug 2015 03:36:04 -0400
Received: by ykdu72 with SMTP id u72so76084647ykd.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2015 00:36:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55BBFCA6.1090803@gmx.de>
References: <cover.1438204273.git.knaack.h@gmx.de> <f406a1b129207e44ed3c6a07a8d44e16f6f3f74f.1438204273.git.knaack.h@gmx.de>
 <CAKv63utc6+a5XS5eLkzggcnvcrfN=zTsTAJfNNethnPmr2S9Yg@mail.gmail.com> <55BBFCA6.1090803@gmx.de>
From: Crt Mori <cmo@melexis.com>
Date: Sat, 1 Aug 2015 09:35:23 +0200
Message-ID: <CAKv63usdVqx_kX8H45SpWX4wzpQ44SwMAHbBSjY8eC0bnw3dkQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] iio:accel:stk8312: check for invalid value
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 1 August 2015 at 00:54, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Crt Mori schrieb am 30.07.2015 um 09:09:
>> On 29 July 2015 at 23:39, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>> Revision 1.2 of the datasheet recommends on page 22 to only write non-zero
>>> values read from OTP register 0x70 into AFECTRL register.
>>>
>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>>> Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
>>> ---
>>>  drivers/iio/accel/stk8312.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
>>> index c2bd1444d6da..6592be8e6377 100644
>>> --- a/drivers/iio/accel/stk8312.c
>>> +++ b/drivers/iio/accel/stk8312.c
>>> @@ -150,6 +150,8 @@ static int stk8312_otp_init(struct stk8312_data *data)
>>>                 goto exit_err;
>>>
>>>         ret = i2c_smbus_read_byte_data(client, STK8312_REG_OTPDATA);
>>> +       if (ret == 0)
>>> +               ret = -EINVAL;
>> This seems fishy. We have a macro value written to client which cannot really
>> give us EINVAL, except if we are checking the client, but then this would only
>> fail if we had some other i2c device on the line with stk8312 address, which
>> would ack other i2c commands above this.
>
> I'm not sure to really understand your point, or if you actually understood
> this patch. I'm not totally happy with EINVAL as error code, but it just
> seemed to fit better than any other possible error code. Of course I would
> be happy to get recommendations for better fitting codes.
> A short explanation why this is done: in the sample code provided in the
> data sheet, it is mentioned that if the value read from that register 0x70
> is zero, then it should not be written into the AFECTRL register. So, that's
> what I have addressed here.
EINVAL is more like bad user input, so if this fails because of the last command
then it is correct, otherwise I would put more like -EBUSY or -EACCES

Thank you for the explanation.

>
>>>         if (ret < 0)
>>>                 goto exit_err;
>>>
>>> --
>>> 2.4.6
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
