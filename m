Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37854 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbdD0GBO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 02:01:14 -0400
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Mark Brown <broonie@kernel.org>
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
 <20170426090158.GV7152@lahna.fi.intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9a210132-854b-cf3e-da33-fc3d073ad491@kernel.org>
Date: Thu, 27 Apr 2017 07:01:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170426090158.GV7152@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/04/17 10:01, Mika Westerberg wrote:
> On Tue, Apr 25, 2017 at 06:12:12PM +0200, Jan Kiszka wrote:
>> Now, do you also a suggestion where to put that 5 V reference voltage
>> value that is hard-coded (via wiring) on the target boards for the ADC?
>> That is now device-specific, not a controller parameter. Is there an
>> ACPI-way to express such a parameter?
> 
> You may put it into device property using _DSD (as long as you don't try
> to represent regulators or so).
> 
>> How would that be done for DTs?
> 
> I don't know but you may look under Documentation/devicetree/bindings if
> there is anything.
Under DT it would be done using a fixed voltage regulator.
> 
>> Plan B would be hard-coding in the code for now, waiting for a second,
>> non-ACPI user to address it.
> 
> Sounds reasonable.
Somewhat of a pain to basically use a random value as the default going
forward.  Presumably this isn't the first ever ACPI table to need to
tell use about a reference voltage...

Mark, seen anything similar?

I see https://www.kernel.org/doc/Documentation/arm64/arm-acpi.txt suggests
that mapping to regulators isn't expected to ever happen...

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

