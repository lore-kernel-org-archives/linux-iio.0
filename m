Return-Path: <Ezequiel.Garcia@imgtec.com>
Message-ID: <556474C2.7020600@imgtec.com>
Date: Tue, 26 May 2015 10:27:30 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Naidu Tellapati <naidu.tellapati@imgtec.com>, James Hartley
	<james.hartley@imgtec.com>, <phani.movva@imgtec.com>
Subject: Re: [PATCH 5/5] iio: adc: cc10001: Power-up the ADC at probe time
 when used remotely
References: <1431033842-1149-1-git-send-email-ezequiel.garcia@imgtec.com> <554CBD24.3060205@kernel.org>
In-Reply-To: <554CBD24.3060205@kernel.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>



On 05/08/2015 10:41 AM, Jonathan Cameron wrote:
> On 07/05/15 17:24, Ezequiel Garcia wrote:
>> From: Naidu Tellapati <naidu.tellapati@imgtec.com>
>>
>> The ADC is typically shared with remote CPUs not running Linux.
>> However, there is only one register to power-up/power-down. Remote CPUs
>> aren't able to power-up the ADC, and rely in Linux doing it instead.
>>
>> This commit uses the adc-reserved-channels devicetree property to
>> distinguish shared usage. In this case, the ADC is powered up at
>> probe time.
>>
>> If the ADC is used only by the CPU running Linux, power-up/down
>> at runtime, only when neeeded.
>>
>> Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Seems sensible to me, but as you observe it's not a fix as such, so
> will hold this until the other patches have propagated through to
> the togreg tree.
> 
> Feel free to remind me if I seem to have forgotten!
> 

Ping.

Thanks!
-- 
Ezequiel
