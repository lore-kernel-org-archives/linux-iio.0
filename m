Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43185 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbbFNLWF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2015 07:22:05 -0400
Message-ID: <557D63DC.4000005@kernel.org>
Date: Sun, 14 Jun 2015 12:22:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
CC: Naidu Tellapati <naidu.tellapati@imgtec.com>,
	James Hartley <james.hartley@imgtec.com>,
	phani.movva@imgtec.com
Subject: Re: [PATCH 5/5] iio: adc: cc10001: Power-up the ADC at probe time
 when used remotely
References: <1431033842-1149-1-git-send-email-ezequiel.garcia@imgtec.com> <554CBD24.3060205@kernel.org> <556474C2.7020600@imgtec.com> <55747588.9000707@kernel.org>
In-Reply-To: <55747588.9000707@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/06/15 17:47, Jonathan Cameron wrote:
> On 26/05/15 14:27, Ezequiel Garcia wrote:
>>
>>
>> On 05/08/2015 10:41 AM, Jonathan Cameron wrote:
>>> On 07/05/15 17:24, Ezequiel Garcia wrote:
>>>> From: Naidu Tellapati <naidu.tellapati@imgtec.com>
>>>>
>>>> The ADC is typically shared with remote CPUs not running Linux.
>>>> However, there is only one register to power-up/power-down. Remote CPUs
>>>> aren't able to power-up the ADC, and rely in Linux doing it instead.
>>>>
>>>> This commit uses the adc-reserved-channels devicetree property to
>>>> distinguish shared usage. In this case, the ADC is powered up at
>>>> probe time.
>>>>
>>>> If the ADC is used only by the CPU running Linux, power-up/down
>>>> at runtime, only when neeeded.
>>>>
>>>> Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
>>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>> Seems sensible to me, but as you observe it's not a fix as such, so
>>> will hold this until the other patches have propagated through to
>>> the togreg tree.
>>>
>>> Feel free to remind me if I seem to have forgotten!
>>>
>>
>> Ping.
> They haven't made it to the togreg tree yet!  Will pick up when I next
> go through a pull request...
Now they are there. Applied to the togreg branch of iio.git.
Timing was rather against us this time, so this won't hit until the next
merge cycle now.

Sorry about that, been a busy few months!

Jonathan

