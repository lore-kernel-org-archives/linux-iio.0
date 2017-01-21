Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34689 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdAUM4A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 07:56:00 -0500
Subject: Re: [PATCH 2/7] iio: adc: stm32: Enable use of stm32 timer triggers
To: kbuild test robot <lkp@intel.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <201701200712.zoWuIMA4%fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux@armlinux.org.uk, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, benjamin.gaignard@linaro.org,
        benjamin.gaignard@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c2042413-c47d-c31c-2890-3b626829f478@kernel.org>
Date: Sat, 21 Jan 2017 12:55:56 +0000
MIME-Version: 1.0
In-Reply-To: <201701200712.zoWuIMA4%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/01/17 23:31, kbuild test robot wrote:
> Hi Fabrice,
> 
> [auto build test ERROR on next-20170119]
> [also build test ERROR on v4.10-rc4]
> [cannot apply to iio/togreg robh/for-next v4.9-rc8 v4.9-rc7 v4.9-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Fabrice-Gasnier/Add-support-for-triggered-buffer-mode-to-STM32-ADC/20170120-062214
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
There is a precursor patch set mentioned in the cover letter. Not sure there is
a sensible automated way to deal with that!

Jonathan
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/iio/adc/stm32-adc.c:26:49: fatal error: linux/iio/timer/stm32-timer-trigger.h: No such file or directory
>     #include <linux/iio/timer/stm32-timer-trigger.h>
>                                                     ^
>    compilation terminated.
> 
> vim +26 drivers/iio/adc/stm32-adc.c
> 
>     20	 */
>     21	
>     22	#include <linux/clk.h>
>     23	#include <linux/delay.h>
>     24	#include <linux/iio/iio.h>
>     25	#include <linux/iio/buffer.h>
>   > 26	#include <linux/iio/timer/stm32-timer-trigger.h>
>     27	#include <linux/iio/trigger.h>
>     28	#include <linux/iio/trigger_consumer.h>
>     29	#include <linux/iio/triggered_buffer.h>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

