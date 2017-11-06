Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42135 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752212AbdKFJiK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Nov 2017 04:38:10 -0500
Date: Mon, 6 Nov 2017 11:35:56 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iio: proximity: sx9500: Assign interrupt from
 GpioIo()
Message-ID: <20171106093556.GR2283@lahna.fi.intel.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
 <20171104031119.00006e56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171104031119.00006e56@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 04, 2017 at 03:11:19AM +0000, Jonathan Cameron wrote:
> On Fri, 3 Nov 2017 15:03:36 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The commit 0f0796509c07
> > 
> > ("iio: remove gpio interrupt probing from drivers that use a single
> > interrupt")
> > 
> > removed custom IRQ assignment for the drivers which are enumerated via
> > ACPI or OF. Unfortunately, some ACPI tables have IRQ line defined as
> > GpioIo() resource and thus automatic IRQ allocation will fail.
> 
> I'll ask the obvious question - is this allowed under the ACPI spec?

Yes, it is perfectly fine.

> > Partially revert the commit 0f0796509c07 to restore original
> > behaviour.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I really don't like scattering fixes for broken ACPI tables through
> drivers...  Is there really no better solution to this?

This is not about broken ACPI tables. We just currently have
"convenience" stuff in the kernel that translates trivial things like a
single ACPI GpioInt() resource directly to a device interrupt. If the
table has multiple GpioInt()s or uses GpioIo() then it is up to the
driver to handle device specific details.

> On patches like this best to pull in ACPI and GPIO on the cc list.
> 
> Also cc'd Mika who made the original change to support gpioint.

The patch looks fine to me,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
