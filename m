Return-Path: <lars@metafoo.de>
Message-ID: <5453E697.7050107@metafoo.de>
Date: Fri, 31 Oct 2014 20:44:23 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
 linux-iio@vger.kernel.org, jic23@kernel.org, Naidu.Tellapati@imgtec.com,
 james.hartley@imgtec.com, abrestic@chromium.org
CC: Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH 1/2] iio: adc: Cosmic Circuits 10001 ADC driver
References: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com> <1414615531-26172-2-git-send-email-ezequiel.garcia@imgtec.com> <5453C494.4030906@metafoo.de>
In-Reply-To: <5453C494.4030906@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 10/31/2014 06:19 PM, Lars-Peter Clausen wrote:
> On 10/29/2014 09:45 PM, Ezequiel Garcia wrote:
>> From: Phani Movva <Phani.Movva@imgtec.com>
>>
>> This commit adds support for Cosmic Circuits 10001 10-bit ADC device.
>>
>> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>> [Ezequiel: code style cleaning]
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>
> Looks very good. Just a few very minor issues.

One thing I forgot to mention. We use indio_dev for the name of the struct 
iio_dev variable. Please use this in this driver as well, makes it easier to 
follow and review the code.

- Lars
