Return-Path: <lars@metafoo.de>
Message-ID: <54F9704B.3040501@metafoo.de>
Date: Fri, 06 Mar 2015 10:15:55 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>,
 Somya Anand <somyaanand214@gmail.com>
CC: outreachy-kernel@googlegroups.com,
 Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [Outreachy kernel] [PATCH] Staging: iio: Change data type in
 adis16220_read_16bit to u16
References: <1425630960-7142-1-git-send-email-somyaanand214@gmail.com> <CAEnQRZB9hGx1jR9YVJgQUPRzewNrj4TQ=_SnPLSK4rHvUtcU=w@mail.gmail.com>
In-Reply-To: <CAEnQRZB9hGx1jR9YVJgQUPRzewNrj4TQ=_SnPLSK4rHvUtcU=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/06/2015 09:58 AM, Daniel Baluta wrote:
> Hi Somya,
>
> On Fri, Mar 6, 2015 at 10:36 AM, Somya Anand <somyaanand214@gmail.com> wrote:
>> In the adis16220_read16bit() function we earlier used a s16 value 'val'
>> which is used by the adis_read_reg_16 function to read data and takes a
>> u16 value as a parameter.
>>
>> So, this patch changes the data type of 'val' from s16 to u16 for further
>> simplification of code and thereby avoiding unnecessary typecast.
>>
>> Signed-off-by: Somya Anand <somyaanand214@gmail.com>

Patch looks ok. But it changes the semantics of the function, the reason why 
this is a s16 instead of a u16 is because at some point the function was 
used to read register that contained signed 16 bit values. The code is 
essentially the short version of:

	u16 uval;
	adis_read_reg_16(&st->adis, this_attr->address, &uval);
	sprintf("%d\n", sign_extend32(uval, 15));

This patch removes the extra sign extension. Which is ok, since the only 
user of the function uses it to read a 10 unsigned value which will lead to 
the same result in both cases. But the commit message should mention this, 
since it is not just the removal of a unnecessary type cast.

- Lars
