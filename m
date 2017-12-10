Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdLJRg7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 12:36:59 -0500
Date: Sun, 10 Dec 2017 17:36:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>
Subject: Re: [PATCH v1 0/7] iio: adc: ina2xx: Rework CNVR alignment, fix
 busy loops
Message-ID: <20171210173654.0d6cb19a@archlinux>
In-Reply-To: <8e8ef11e-37df-44f3-b4a4-06e995924ca8@rwthex-w2-a.rwth-ad.de>
References: <8e8ef11e-37df-44f3-b4a4-06e995924ca8@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 8 Dec 2017 18:41:45 +0100
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> Currently, the INA2xx driver may end up causing 100% load on a single core
> and fully loading the I2C bus, which is caused by two different issues:
> 
> The code uses a udelay to bridge the gab between two subsequent samples.
> As the sampling interval may be up to 16 seconds, the CPU is busy
> waiting most of the time.
> 
> The second issue manifests when using the (default) "synchronous" mode.
> The code polls for a set conversion ready flag, but fails to align the
> sampling interval to the raising flag. The polling interval is
> (rightfully) slighly shorter than the sampling interval, so after some
> samples the sampling thread is continously polling.

I'm confused.  Would you mind doing an asci art example perhaps?

Thanks,

Jonathan
> 
> The patch series fixes both issues:
> Patch 1 and 2 are just some small cosmetic changes.
> 
> Patch 3 removes an unnecessary read. According to the datasheet, the
> CNVR flag is only cleared by reading the power register, but is cleared
> by reading any of the measurement registers, thus the dummy read can
> be skipped. This behaviour has been confirmed by TI technical support.
> 
> Patch 4 replaces the udelay with usleep_range.
> 
> Patch 5 reworks the delay logic. Previously the IIO timestamp clock was
> used to capture entry and exit times of the work function. The
> timestamp clock is user selectable and may be non-monotonic. Also,
> any time spent outside the work function is not accounted for.
> 
> Patch 6 moves the timestap capture to the end of the conversion ready
> status poll.
> 
> Patch 7 addresses the alignment issue. Every time an unset flag is seen
> on poll loop entry, the reference timestamp is readjusted.
> 
> Both old and fixed behaviour has been verified using a logic analyzer.
> In synchrounous mode, every few samples a double read of the status
> register can be observed, showing the raising status flag, the other
> samples are evenly spaced at sampling intervals inbetween.
> 
> 
> Stefan Brüns (7):
>   iio: adc: ina2xx: Remove bogus cast for data argument
>   iio: adc: ina2xx: Clarify size requirement for data buffer
>   iio: adc: ina2xx: Remove unneeded dummy read to clear CNVR flag
>   iio: adc: ina2xx: Do not udelay for several seconds
>   iio: adc: ina2xx: Use a monotonic clock for delay calculation
>   iio: adc: ina2xx: Align timestamp with conversion ready flag
>   iio: adc: ina2xx: Actually align the loop with the conversion ready
>     flag
> 
>  drivers/iio/adc/ina2xx-adc.c | 104 ++++++++++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 45 deletions(-)
> 

