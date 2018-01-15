Return-Path: <SRS0=mva0=EK=dowhile0.org=javier@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180114105110.14ec8c8f@archlinux>
References: <1514556006-23293-1-git-send-email-mastichi@gmail.com>
 <CAHp75VfqKaARX2fTJ7BRTU7JLPg-OGROH1NMc_CSh3JZyqPycQ@mail.gmail.com>
 <20171229175449.760e734d@archlinux> <CALieaeeZXZ-6WKYXSMgLiiTO6eTFvdJjazOY9wx4VFk7YcA4Lg@mail.gmail.com>
 <20180101095342.4d4d5325@archlinux> <CABxcv=kmnithguOYV03KASM2DF09yiRs7FPvnBM3fX=k9+soQw@mail.gmail.com>
 <20180114105110.14ec8c8f@archlinux>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Mon, 15 Jan 2018 13:31:12 +0100
Message-ID: <CABxcv=kSNZMKkL7Ge2WkvDqH1V-CVSJN-agPcMmU4qvdy9HRiQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: max9611: fix module auto-loading
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Mastykin <mastichi@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Dan Carpenter <dan.carpenter@oracle.com>, Rob Herring <robh@kernel.org>,
	linux-iio <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jan 14, 2018 at 11:51 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 10 Jan 2018 12:01:07 +0100
> Javier Martinez Canillas <javier@dowhile0.org> wrote:
>
>> Hello Jonathan,
>>
>> On Mon, Jan 1, 2018 at 10:53 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> [snip]
>>
>> >
>> > I may well be missing some subtle detail of course having spent only a few
>> > minute looking at this!
>> >
>>
>> Your understanding is correct. This change has nothing to do with
>> module autoloading.
>>
>> The .probe_new callback is only used to avoid requiring an I2C device
>> ID table since the old .probe callback has a struct i2c_device_id as a
>> parameter and so requires a table even in OF (or ACPI) only drivers.
>
> OK, then let us revisit this patch once we have an answer on your one
> fixing the autoprobing more generally.  Until we then we don't know
> whether we need to add the i2c table in or not whether this suffices.
>

That's correct. If the driver is for a device that's OF-only (e.g:
will never be used from a non-DT platform) then I don't think we
should add a I2C table.

Now, if Wolfram nacks my patch then we should add it as a workaround
to have auto-loading working.

> Jonathan
>

Best regards,
Javier
