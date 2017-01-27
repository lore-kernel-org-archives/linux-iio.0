Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34386 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754448AbdA0Jc1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 04:32:27 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so56721686wmi.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Jan 2017 01:31:10 -0800 (PST)
Subject: Re: [RFC] iio: accel: Add driver for the Analog Devices ADXL345
 3-axis accelerometer
To: Daniel Baluta <daniel.baluta@gmail.com>
References: <1485336354-26566-1-git-send-email-eraretuya@gmail.com>
 <86cc101b-6a3e-41d0-6a8a-4743ac7bb152@gmail.com>
 <CAEnQRZB0DVVEktZXycvMs6fbvVrgdwc4-g2XmRLp5W4qp4uoiw@mail.gmail.com>
Cc: Eva Rachel Retuya <eraretuya@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alison Schofield <amsfield22@gmail.com>
From: Florian Vaussard <florian.vaussard@gmail.com>
Message-ID: <3f691b8d-b55e-f3ec-ed03-3a957386b681@gmail.com>
Date: Fri, 27 Jan 2017 10:31:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZB0DVVEktZXycvMs6fbvVrgdwc4-g2XmRLp5W4qp4uoiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi!

On 01/26/2017 09:33 AM, Daniel Baluta wrote:
> On Thu, Jan 26, 2017 at 9:23 AM, Florian Vaussard
> <florian.vaussard@gmail.com> wrote:
>> Hello,
>>
>> On 01/25/2017 10:25 AM, Eva Rachel Retuya wrote:
>>> Add basic IIO support for the Analog Devices ADXL345 3-axis accelerometer.
>>> The datasheet can be found here:
>>> http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
>>>
>>
>> There is already a driver in the kernel for this accelerometer (under
>> drivers/input/misc/adxl34x*). Maybe it would be worth migrating the exiting
>> driver to IIO instead of duplicating the effort?
>>
>> Your driver appears to support only the I2C variant, whereas the existing driver
>> supports both I2C / SPI (hint: I have the SPI variant on a board :))
> 
> Hi Florian,
> 
> This is our intention, to migrate the ADXL34x input driver to adxl345
> IIO driver,
> supporting all the features the input driver is offering.
> 

Great to hear that!

> We sent this patch early for review in order to get a feeling of
> what IIO/input folks think about this device and if moving it to IIO
> is a good thing.
> 
> Glad that you have the SPI variant, perhaps you can help us with
> testing the patches :).
> 

I probably missed the RFC tag ;) Sure, I can test with SPI variant when your
driver integrates the SPI support. Please CC it to florian.vaussard@heig-vd.ch,
otherwise I may miss it.

Best,
Florian
