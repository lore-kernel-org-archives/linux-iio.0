Return-Path: <linux@roeck-us.net>
Subject: Re: MCP9808 iio or hwmon
To: Daniel Baluta <daniel.baluta@intel.com>,
 Alison Schofield <amsfield22@gmail.com>
References: <20160613220843.GA4235@d830.WORKGROUP>
 <CAEnQRZBZcQZRYGbk-6Eh5sN7_D90HTZPPo=uOSSZF2obB5VD+w@mail.gmail.com>
 <CAEnQRZC9ES6dGyUdycW=nRuA=6yRa=i01BWBLt7uFsieE-74OQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 linux-hwmon@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57600656.7030902@roeck-us.net>
Date: Tue, 14 Jun 2016 06:27:50 -0700
MIME-Version: 1.0
In-Reply-To: <CAEnQRZC9ES6dGyUdycW=nRuA=6yRa=i01BWBLt7uFsieE-74OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/14/2016 01:22 AM, Daniel Baluta wrote:
> [fixing IIO, hwmon lists emails]
>
> On Tue, Jun 14, 2016 at 11:20 AM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>> On Tue, Jun 14, 2016 at 1:08 AM, Alison Schofield <amsfield22@gmail.com> wrote:
>>>
>>> I was working on an iio driver for MCP9808 when Jonathan took notice
>>> and suggested we have the iio or hwmon discussion.
>>>
>>> So, where should this sensor driver reside?
>>>
>>> http://ww1.microchip.com/downloads/en/DeviceDoc/25095A.pdf
>>>
>>> It's a digital temp sensor with user programmable registers for
>>> sensing applications.  Supports shutdown, low power modes,
>>> specifying of event & critical output boundaries.  Can support
>>> 8 sensors on a single serial bus. Touted as 'ideal for sophisticated
>>> multi-zone temperature-monitoring applications.'
>>
>> This is debatable, looking to the datasheet this driver could reside
>> in both places.
>>
>> Because this sensor has Industrial utility (e.g freezers, refrigerators) I
>> am inclined to say we should support it in IIO.
>>

Literally every sensor has that utility.

Alternatively, you might consider adding its device ID to the jc42 driver.
If you want to be fancy, you could add optional support for resolution
selection to the driver.

Guenter
