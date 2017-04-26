Return-Path: <SRS0=imYQ=4C=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <5f628aa9-092f-52c0-549c-db7bdb7ea67b@siemens.com>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
 <alpine.DEB.2.20.1704250906150.7992@vps.pmeerw.net> <5f628aa9-092f-52c0-549c-db7bdb7ea67b@siemens.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Apr 2017 13:21:06 +0300
Message-ID: <CAHp75VcLy7rjtK47sMPSUgGizCfSV+C5XBiajd_Ojmfs1Xs43g@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sascha Weisenberger <sascha.weisenberger@siemens.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 26, 2017 at 8:37 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2017-04-25 09:31, Peter Meerwald-Stadler wrote:

>> I think board-specific stuff should not go into the driver -> DT?
>
> Still looking for suggestions how to provide the external reference
> voltage as parameter. Chip select is gone now.

Unified Device Properties API.

Just
ret = device_property_read_u16();
if (ret)
 ...use default...

> Also, should I suggest a device tree binding even though I have no test
> case for it? My current feeling is to better leave this exercise to the
> first user on a DT platform.

But I prefer this one. One problem at a time.

-- 
With Best Regards,
Andy Shevchenko
