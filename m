Return-Path: <gwendal@google.com>
MIME-Version: 1.0
Sender: gwendal@google.com
In-Reply-To: <1414768889.3254.4.camel@spandruv-hsb-test>
References: <1414620097-6787-1-git-send-email-gwendal@chromium.org> <1414768889.3254.4.camel@spandruv-hsb-test>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Sat, 1 Nov 2014 14:03:48 -0700
Message-ID: <CAMHSBOUzGXUJHtBLabTQW-_r8gUAVYjLQuk_rEkfrOD-=Gk2cQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] iio: ak8975: Add AKM0991x support.
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, jic23@kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Oct 31, 2014 at 8:21 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Wed, 2014-10-29 at 15:01 -0700, Gwendal Grignou wrote:
>> AK09912 is an accelerometer with the same register set as AK09911, but
>> same behavior as AK8973, so I was not sure where to add the support.
>> I decided to merge all AKM magnetometer support in the same file while
>> being as clean as I could.
>>
> AK09911 is implemented as a separate driver to have a clean.
> - Register map is different and have different indexes
Please take a look at the code, I separated the registers definition
from the code itself.

> - AK09911 is a very compact interface with no DRDY pin. So no support
>      of interrupt or GPIO poll
Other AK can work the same way, use DRDY and interrupt is optional.
> - Even for polled mode no mention on ST2 register, which is required in
>     ak8975 driver
Not true: after polling the measurement, you have to look at ST2
register to ensure you don't have an overflow (HOFL bit).
> - mode values are different for fuse access
Taken care of.
>
> I didn't get chance to check your merged driver, IMO simple standalone
> driver is better if there are two many difference like above, difference
> between AK09911 and AK8973.
The problem I have is AK09912 has almost the same register set than
AK09911 but the same behavior as AK8973 (DRDY pin and interrupt).
So if we want to support it, we end up adding either the interrupt
code in ak09911.c or adding AK09912 register map into ak8973.c:
in the former case, we will end up with 2 very similar drivers, in the
later, ak8973.c driver would handle ak0911 without difficulty. That's
the latter approach I chose.

Gwendal.

>
> Thanks,
> Srinivas
>
>
>
