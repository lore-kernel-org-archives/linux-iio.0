Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f177.google.com ([209.85.213.177]:34895 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936361AbcIFQsG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Sep 2016 12:48:06 -0400
MIME-Version: 1.0
In-Reply-To: <6b262774-fb80-7212-5426-dfc055689865@metafoo.de>
References: <1473157554-4990-1-git-send-email-enric.balletbo@collabora.com> <6b262774-fb80-7212-5426-dfc055689865@metafoo.de>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Tue, 6 Sep 2016 18:48:03 +0200
Message-ID: <CAFqH_513e24aOZ8NJ+m0WtzKmf-n3R8FwwApFGWCdgoQbJRdNA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: acpi-als: Add a tuning parameter interface.
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars,

2016-09-06 12:31 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 09/06/2016 12:25 PM, Enric Balletbo i Serra wrote:
>> From: Bryan Freed <bfreed@chromium.org>
>>
>> Add IIO_CHAN_INFO_CALIBSCALE to the channel to scale up or down
>> the raw measurements through the IIO framework.
>>
>> Add IIO_CHAN_INFO_PROCESSED to provide the interface to read the
>> scaled measurements through the in_illuminance_input file.
>
> What is the use-case for this, how is this interface supposed to be used?

The idea behind this is be able to do a per-device calibration. The
use case we're thinking is:

 1. Read raw measurements from sensor in controlled environment (at
30, 500 and 1000 lux)
 2. do some math to calculate the calibration value.
 3. write the value to calibscale (in_illuminance_calibscale)
 4. read the calibrated measurement (in_illuminance_input)

Regards,
  Enric
