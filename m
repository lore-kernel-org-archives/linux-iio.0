Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:55492 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947388AbdDYMRi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Apr 2017 08:17:38 -0400
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
 <1493064330.24567.180.camel@linux.intel.com>
 <dcba0513-e3c2-33f2-6cc9-c23d05a7e6ba@siemens.com>
 <CAHp75VfzH922Z5FfGQ7gS-+FLR7H_Q3mKm_58xmchZn5KEjiqQ@mail.gmail.com>
 <38f562f3-69d2-67d0-ecc2-4b44d67286e2@siemens.com>
 <CAHp75Vf517+vfe7GiTH2Gb0WBDdqi4fcR5Z1O6ideJMpbDhysw@mail.gmail.com>
 <08d40bf0-4e68-d763-af99-be1f60e369fc@siemens.com>
 <1493119630.24567.192.camel@linux.intel.com>
 <20170425113513.GQ7152@lahna.fi.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2a116105-0046-bcc1-b560-f6986220fb4b@siemens.com>
Date: Tue, 25 Apr 2017 14:17:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170425113513.GQ7152@lahna.fi.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-25 13:35, Mika Westerberg wrote:
> On Tue, Apr 25, 2017 at 02:27:10PM +0300, Andy Shevchenko wrote:
>>> Shipping own DSDTs is no long-term path: we would be forced to provide
>>> separate images due to a single parameter being different in the DSDTs
>>> of the 2020 and 2040. And you cannot provide any overlay to adjust the
>>> table after boot, i.e. once we know on which board we are.
>>>
>>> The dependency on meta-intel is also suboptimal (we will switch to a
>>> long-term supported kernel source soon), but that would probably be
>>> fixable.
>>
>> Mika, do you have anything to comment on the above?
> 
> You don't need to depend on meta-intel or meta-acpi. There are other
> ways to add SSDT overlays than initrd. For example your boards can stick
> them to EFI variable, the kernel can find them there. Then you don't
> need to ship a separate image per board type.
> 
> For more information see Documentation/acpi/ssdt-overlays.txt.

I'm not ACPI guru: How do we come from a SSDT to information that is
carried in the DSDT so far? How can we overload wrong information in the
built in DSDT this way? I'm all ears if we could fix our (and also the
Galileo) quirks like that!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
