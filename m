Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:24935 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934607AbdDZJCE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Apr 2017 05:02:04 -0400
Date: Wed, 26 Apr 2017 12:01:58 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
Message-ID: <20170426090158.GV7152@lahna.fi.intel.com>
References: <CAHp75VfzH922Z5FfGQ7gS-+FLR7H_Q3mKm_58xmchZn5KEjiqQ@mail.gmail.com>
 <38f562f3-69d2-67d0-ecc2-4b44d67286e2@siemens.com>
 <CAHp75Vf517+vfe7GiTH2Gb0WBDdqi4fcR5Z1O6ideJMpbDhysw@mail.gmail.com>
 <08d40bf0-4e68-d763-af99-be1f60e369fc@siemens.com>
 <1493119630.24567.192.camel@linux.intel.com>
 <20170425113513.GQ7152@lahna.fi.intel.com>
 <2a116105-0046-bcc1-b560-f6986220fb4b@siemens.com>
 <20170425123029.GS7152@lahna.fi.intel.com>
 <ca23678c-be8c-1e3f-4688-67b29770c99b@siemens.com>
 <32803199-239f-821c-7942-748436d53261@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <32803199-239f-821c-7942-748436d53261@siemens.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Apr 25, 2017 at 06:12:12PM +0200, Jan Kiszka wrote:
> Now, do you also a suggestion where to put that 5 V reference voltage
> value that is hard-coded (via wiring) on the target boards for the ADC?
> That is now device-specific, not a controller parameter. Is there an
> ACPI-way to express such a parameter?

You may put it into device property using _DSD (as long as you don't try
to represent regulators or so).

> How would that be done for DTs?

I don't know but you may look under Documentation/devicetree/bindings if
there is anything.

> Plan B would be hard-coding in the code for now, waiting for a second,
> non-ACPI user to address it.

Sounds reasonable.
