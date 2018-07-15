Return-Path: <SRS0=poh1=J7=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH 5/5] iio:adxl372: Add filter bandwidth support
To: Jonathan Cameron <jic23@kernel.org>, Stefan Popa <stefan.popa@analog.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1531409818-20300-1-git-send-email-stefan.popa@analog.com>
 <20180715113636.5394c756@archlinux>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f16d0271-b203-ab02-50d8-fb0ef2ddc540@metafoo.de>
Date: Sun, 15 Jul 2018 12:44:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180715113636.5394c756@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 07/15/2018 12:36 PM, Jonathan Cameron wrote:
> On Thu, 12 Jul 2018 18:36:58 +0300
> Stefan Popa <stefan.popa@analog.com> wrote:
> 
>> This patch adds the option for the user to select the filter bandwidth. The
>> user can also read the available bandwidths which are always adjusted to be
>> at most half of the sampling frequency. Furthermore, the currently selected
>> bandwidth can be read via the read_raw function, while the write_raw sets a
>> new bandwidth value.
>>
> 
> How will the youth of today learn about aliasing if we are so nice to them?
>  :)  Good user friendly design choice btw.  If someone is doing something
> crazy where they actually want the aliasing they can hack the driver.

Actually they can't. The hardware itself enforces that the filter bandwidth
is below or equal to the Nyquist frequency. All the user can do is select a
bandwidth even smaller. :)
