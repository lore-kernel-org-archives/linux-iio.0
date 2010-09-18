Return-Path: <mensch0815@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <4C94B4A6.2060001@cam.ac.uk>
References: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>
	<4C94B4A6.2060001@cam.ac.uk>
Date: Sat, 18 Sep 2010 17:48:24 +0200
Message-ID: <AANLkTinQ04UmbBvakGQBeSap0PCh3VrWmhhobLh0u9Qj@mail.gmail.com>
Subject: Re: [PATCH 0/2 V2] Adding support for adis16250/5 to adis16260 driver.
From: matthias <mensch0815@googlemail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, m_brugger@web.de, Michael.Hennerich@analog.com,
	Robin.Getz@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

sorry for not answering yet. I was on vacation and next week I won't
be able to test the driver. Will try to do it asap....

Matthias

2010/9/18 Jonathan Cameron <jic23@cam.ac.uk>:
> On 09/06/10 16:16, Jonathan Cameron wrote:
>> Mainly a rebase, but a couple of attribute naming fixes as well.
>>
>> Note I don't have one of these so if anyone could test that would
>> be great!
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> Jonathan Cameron (2):
>> =C2=A0 staging:iio:adis16260 add id table support
>> =C2=A0 staging:iio:adis16260 add suppport for adis16255 and adis16250.
>>
>> =C2=A0drivers/staging/iio/gyro/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A08 +-
>> =C2=A0drivers/staging/iio/gyro/adis16260.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +
>> =C2=A0drivers/staging/iio/gyro/adis16260_core.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0139 ++++++++++++++------
>> =C2=A0drivers/staging/iio/gyro/adis16260_platform_data.h | =C2=A0 19 +++
>> =C2=A0drivers/staging/iio/gyro/gyro.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A09 ++
>> =C2=A05 files changed, 136 insertions(+), 42 deletions(-)
>> =C2=A0create mode 100644 drivers/staging/iio/gyro/adis16260_platform_dat=
a.h
>>
>>
> Whilst I haven't tested these (don't have the hardware) I don't think the=
re
> is anything controversial, so my intent is to push these to Greg before t=
he
> next merge window. =C2=A0This is primarily to remove the duplication we c=
urrently
> have with two drivers that effectively cover the same parts.
>
> Thanks,
>
> Jonathan
>



--=20
motzblog.wordpress.com
