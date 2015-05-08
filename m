Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <553D19A5.1030101@kernel.org>
References: <1429891112-11888-1-git-send-email-daniel.baluta@intel.com>
	<553D19A5.1030101@kernel.org>
Date: Fri, 8 May 2015 14:29:15 +0300
Message-ID: <CAEnQRZCAZFT1zQimyTARJDBcnvMHCWJZEixJtX3femS2NMEeww@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Introduce support for MMC35240 magnetic sensor
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Apr 26, 2015 at 8:00 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 24/04/15 16:58, Daniel Baluta wrote:
>> This adds support for Memsic's MMC35240 magnetometer. The sensor does
>> not offer an interrupt line for data ready so for the moment we only
>> expose raw readings via sysfs interface.
>>
>> This patchset also adds ACPI and Power Management support.
>>
>> Changes since v1:
>>       * fixed nits reported by Peter and Jonathan
>>       * https://lkml.org/lkml/2015/4/15/186
>>
>> Daniel Baluta (3):
>>   iio: magnetometer: Add support for MEMSIC MMC35240 sensor
>>   iio: magnetometer: mmc35240: Add PM sleep support
>>   iio: magnetometer: Add ACPI support for MMC35240
>>
>>  drivers/iio/magnetometer/Kconfig    |  11 +
>>  drivers/iio/magnetometer/Makefile   |   1 +
>>  drivers/iio/magnetometer/mmc35240.c | 511 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 523 insertions(+)
>>  create mode 100644 drivers/iio/magnetometer/mmc35240.c
>>
> I'm happy with the whole series.  Will leave it a few days though to
> give Peter time to take another look if he wants (or anyone else
> who feels like it!)
>
> Hopefully I'll manage a quick catch up session sometime mid week
> as only getting to this stuff on Saturday's is leaving me with quite
> a backlog at the moment!

Slow poke on this one :).

Daniel.
