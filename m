Return-Path: <SRS0=uoHG=4B=linux.intel.com=mika.westerberg@kernel.org>
Date: Tue, 25 Apr 2017 14:35:13 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sascha Weisenberger <sascha.weisenberger@siemens.com>
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
Message-ID: <20170425113513.GQ7152@lahna.fi.intel.com>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
 <1493064330.24567.180.camel@linux.intel.com>
 <dcba0513-e3c2-33f2-6cc9-c23d05a7e6ba@siemens.com>
 <CAHp75VfzH922Z5FfGQ7gS-+FLR7H_Q3mKm_58xmchZn5KEjiqQ@mail.gmail.com>
 <38f562f3-69d2-67d0-ecc2-4b44d67286e2@siemens.com>
 <CAHp75Vf517+vfe7GiTH2Gb0WBDdqi4fcR5Z1O6ideJMpbDhysw@mail.gmail.com>
 <08d40bf0-4e68-d763-af99-be1f60e369fc@siemens.com>
 <1493119630.24567.192.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493119630.24567.192.camel@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Apr 25, 2017 at 02:27:10PM +0300, Andy Shevchenko wrote:
> > Shipping own DSDTs is no long-term path: we would be forced to provide
> > separate images due to a single parameter being different in the DSDTs
> > of the 2020 and 2040. And you cannot provide any overlay to adjust the
> > table after boot, i.e. once we know on which board we are.
> > 
> > The dependency on meta-intel is also suboptimal (we will switch to a
> > long-term supported kernel source soon), but that would probably be
> > fixable.
> 
> Mika, do you have anything to comment on the above?

You don't need to depend on meta-intel or meta-acpi. There are other
ways to add SSDT overlays than initrd. For example your boards can stick
them to EFI variable, the kernel can find them there. Then you don't
need to ship a separate image per board type.

For more information see Documentation/acpi/ssdt-overlays.txt.
