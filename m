Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60271 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdETQ0a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2017 12:26:30 -0400
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
To: Mark Brown <broonie@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
References: <CAHp75Vf517+vfe7GiTH2Gb0WBDdqi4fcR5Z1O6ideJMpbDhysw@mail.gmail.com>
 <08d40bf0-4e68-d763-af99-be1f60e369fc@siemens.com>
 <1493119630.24567.192.camel@linux.intel.com>
 <20170425113513.GQ7152@lahna.fi.intel.com>
 <2a116105-0046-bcc1-b560-f6986220fb4b@siemens.com>
 <20170425123029.GS7152@lahna.fi.intel.com>
 <ca23678c-be8c-1e3f-4688-67b29770c99b@siemens.com>
 <32803199-239f-821c-7942-748436d53261@siemens.com>
 <20170426090158.GV7152@lahna.fi.intel.com>
 <9a210132-854b-cf3e-da33-fc3d073ad491@kernel.org>
 <20170519160133.ukkne2emubfbrrvg@sirena.org.uk>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e224532c-260c-a2df-23be-35e5b3243151@kernel.org>
Date: Sat, 20 May 2017 17:26:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170519160133.ukkne2emubfbrrvg@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/17 17:01, Mark Brown wrote:
> On Thu, Apr 27, 2017 at 07:01:07AM +0100, Jonathan Cameron wrote:
> 
>> Somewhat of a pain to basically use a random value as the default going
>> forward.  Presumably this isn't the first ever ACPI table to need to
>> tell use about a reference voltage...
> 
>> Mark, seen anything similar?
> 
>> I see https://www.kernel.org/doc/Documentation/arm64/arm-acpi.txt suggests
>> that mapping to regulators isn't expected to ever happen...
> 
> There's multiple different camps trying to use ACPI for very different
> things.  There's the server people on both x86 and ARM who want to use
> standard ACPI and nothing but with the power management all hidden in
> the AML but there's also the embedded x86 people who have the same needs
> as DT platforms but find themselves unable to use DT so have to map all
> the DT support into ACPI.  This has been accepted in areas that clearly
> don't overlap with areas where there are existing ACPI bindings for
> things, power management is one area where there are clear bindings
> though.
Thanks Mark,

Just to clarify what do we do here, where a regulator is providing a
reference voltage and there appears to be no information on it in ACPI?

Right now we are just going with a fixed value that matches the board
someone has, but that's hardly sustainable.

Jonathan
> 

