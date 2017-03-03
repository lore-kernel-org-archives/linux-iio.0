Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33488 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdCCR1y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Mar 2017 12:27:54 -0500
MIME-Version: 1.0
In-Reply-To: <2f9264bc-98a2-acfc-918a-a6cec0ad33c7@kernel.org>
References: <cover.1488248485.git.eraretuya@gmail.com> <CAHp75VdtqNAf_PaWBL=YPc9iz=E-0tAz2=Fk-mDYSeBvtU+KYg@mail.gmail.com>
 <20170302030221.GA4026@Socrates-UM> <2f9264bc-98a2-acfc-918a-a6cec0ad33c7@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 3 Mar 2017 18:57:20 +0200
Message-ID: <CAHp75Vc4tRNnftwtN_DfG9TM19SaMiQxS1p4G+MoTZoNb1+1PQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] iio: accel: adxl345: Split driver into core and
 I2C then add SPI support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 2, 2017 at 9:59 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 02/03/17 03:02, Eva Rachel Retuya wrote:
>> On Thu, Mar 02, 2017 at 01:22:11AM +0200, Andy Shevchenko wrote:
>>> On Tue, Feb 28, 2017 at 4:37 AM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
>>>> This patchset modifies the adxl345 to use regmap. In doing so, we can
>>>> easily introduce SPI support and let regmap handle the rest.

>> Please state your comments and I will submit a new revision.

Just did.

> Looks good to me so I'll probably pick this up over the weekend unless you want
> to make a V6 with anything from Andy.  Can always send follow up patches later
> for any issues highlighted.

Yep, feel free incorporate now, or fix later (though I prefer now :-) )

-- 
With Best Regards,
Andy Shevchenko
