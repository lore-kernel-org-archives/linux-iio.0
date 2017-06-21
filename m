Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0066.outbound.protection.outlook.com ([104.47.33.66]:42400
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751030AbdFUKyB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jun 2017 06:54:01 -0400
Subject: Re: [PATCH] iio: adc: xilinx-ams: add missing break in AMS_SUPPLY[78]
 cases
To: Jonathan Cameron <jic23@kernel.org>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
CC: <michal.simek@xilinx.com>, <rajnikant.bhojani@xilinx.com>,
        <linux-iio@vger.kernel.org>
References: <1496776881-5265-1-git-send-email-jeff.dagenais@gmail.com>
 <20170611145831.040a2b45@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <8f81bd31-420a-6d99-483e-c8a9904032d2@xilinx.com>
Date: Wed, 21 Jun 2017 12:53:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170611145831.040a2b45@kernel.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11.6.2017 15:58, Jonathan Cameron wrote:
> On Tue,  6 Jun 2017 15:21:21 -0400
> Jean-Francois Dagenais <jeff.dagenais@gmail.com> wrote:
> 
>> This would otherwise lead supply 7 and 8 to scale to 3V instead of
>> 6V
>>
>> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> Interesting... Driver isn't in mainline though and as far as I know
> hasn't been submitted.

It is in Xilinx tree. I hope that this will be send out soon for review.

Thanks,
Michal
