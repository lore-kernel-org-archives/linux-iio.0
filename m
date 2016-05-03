Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <21eeb9cd-5d48-043f-716a-7b7b4f5305b9@kernel.org>
References: <1461932343-14967-1-git-send-email-constantin.musca@intel.com>
	<21eeb9cd-5d48-043f-716a-7b7b4f5305b9@kernel.org>
Date: Tue, 3 May 2016 10:29:26 +0300
Message-ID: <CAEnQRZA05=_fShP9W6QXu7cYGwn_ApPr1V7JGHwbB33jKzyMMw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: accel: Add support for Freescale MMA7660FC
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Constantin Musca <constantin.musca@intel.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, May 1, 2016 at 9:56 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 29/04/16 13:19, Constantin Musca wrote:
>> Minimal implementation of an IIO driver for the Freescale
>> MMA7660FC 3-axis accelerometer. Datasheet:
>> http://www.freescale.com.cn/files/sensors/doc/data_sheet/MMA7660FC.pdf
>>
>> Includes:
>> - ACPI support;
>> - read_raw for x,y,z axes;
>> - reading and setting the scale (range) parameter.
>> - power management
>>
>> Signed-off-by: Constantin Musca <constantin.musca@intel.com>
> Couple of trivial bits inline as well as that request to update the link above
> if possible...
>
> Why the retries? (I'm on a train without internet access for quite a few
> hours yet hence I can't dig into the datasheet!)

I suggested the retries because it's quite unsafe to infinitely loop
in the kernel
on a hardware condition. We can lockup the kernel if there is some sort of
hardware problem.


>
> Anyhow, even if it's obvious from the datasheet, that sort of 'magic' needs
> an explanation comment...
