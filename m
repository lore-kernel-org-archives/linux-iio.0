Return-Path: <SRS0=JY0V=CC=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171104031119.00006e56@huawei.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com> <20171104031119.00006e56@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 4 Nov 2017 11:43:53 +0100
Message-ID: <CACRpkdYhJK2=2UAO5sZ0WGouF-V8woiuhTzCYQYz29PuQKcfQQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] iio: proximity: sx9500: Assign interrupt from GpioIo()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Sat, Nov 4, 2017 at 4:11 AM, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Fri, 3 Nov 2017 15:03:36 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> The commit 0f0796509c07
>>
>> ("iio: remove gpio interrupt probing from drivers that use a single
>> interrupt")
>>
>> removed custom IRQ assignment for the drivers which are enumerated via
>> ACPI or OF. Unfortunately, some ACPI tables have IRQ line defined as
>> GpioIo() resource and thus automatic IRQ allocation will fail.
>
> I'll ask the obvious question - is this allowed under the ACPI spec?
>
>>
>> Partially revert the commit 0f0796509c07 to restore original
>> behaviour.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> I really don't like scattering fixes for broken ACPI tables through
> drivers...  Is there really no better solution to this?
>
> On patches like this best to pull in ACPI and GPIO on the cc list.
>
> Also cc'd Mika who made the original change to support gpioint.

Andy and Mika are the maintainers of ACPI GPIO, I have only
superficial knowledge of how that actually works. But it's good if
Mika can look at it too.

The only thing that I know for sure about ACPI GPIO is the same
as always : the people who devised it think that they are releaving
the OS authors of a burden by taking stuff over, and end up
creating more work for us since they make mistakes and
deploy them in firmware that "cannot be fixed".

Linus Walleij
