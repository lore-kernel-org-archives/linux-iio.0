Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36362 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1176908AbdDYJUN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Apr 2017 05:20:13 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1704250906150.7992@vps.pmeerw.net>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com> <alpine.DEB.2.20.1704250906150.7992@vps.pmeerw.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 25 Apr 2017 12:20:11 +0300
Message-ID: <CAHp75VcpAwtUHgXgMW_jm5r24vC+H331Fj-L+TjzcSLuaan+wQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Apr 25, 2017 at 10:31 AM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>
>> This is an upstream port of an IIO driver for the TI ADC108S102 and
>> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
>> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
>> included.

> I think board-specific stuff should not go into the driver -> DT?

World is not ARM/DT only -> Unified Device Properties, yes.

P.S. I agree with everything else, though it looks a bit overlapping
with my review, which is a good sign to me :-)

-- 
With Best Regards,
Andy Shevchenko
