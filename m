Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160613222502.GA4376@d830.WORKGROUP>
References: <1465708397-19649-1-git-send-email-mranostay@gmail.com> <20160613222502.GA4376@d830.WORKGROUP>
From: Matt Ranostay <mranostay@gmail.com>
Date: Mon, 13 Jun 2016 16:23:41 -0700
Message-ID: <CAKzfze_=URjXxePW4+P_Y8OUrgoMiC90Nzr=3ey+G=ZHKsRxCA@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: humidity: sht31: add Sensirion SHT31 support
To: Alison Schofield <amsfield22@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Didn't notice that will till now, and looking at the timestamp I see why :).
However this is more for the sw triggered buffer support which hwmon
lacks... there is a few examples of this already in the tree.

Maybe Jonathan and Peter will have some input on this.

On Mon, Jun 13, 2016 at 3:25 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> On Sat, Jun 11, 2016 at 10:13:15PM -0700, Matt Ranostay wrote:
>> Add support for the humidity and temperature functionally for the SHT31
>> chipset. In addition add support for using using software triggers.
>
> Now that I'm hwmon-aware ;)  I see this same driver under review in hwmon.
> Can support exist in 2 places?
>
> alisons
>
>>
>> Matt Ranostay (2):
>>   devicetree: add Sensirion AG vendor id
>>   iio: humidity: sht31: add Sensirion SHT31 support
>>
>>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>>  drivers/iio/humidity/Kconfig                       |  11 +
>>  drivers/iio/humidity/Makefile                      |   1 +
>>  drivers/iio/humidity/sht31.c                       | 416 +++++++++++++++++++++
>>  5 files changed, 430 insertions(+)
>>  create mode 100644 drivers/iio/humidity/sht31.c
>>
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
