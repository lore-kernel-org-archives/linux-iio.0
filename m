Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6064 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1430158AbdDYMcn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Apr 2017 08:32:43 -0400
Date: Tue, 25 Apr 2017 15:30:29 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
Message-ID: <20170425123029.GS7152@lahna.fi.intel.com>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
 <1493064330.24567.180.camel@linux.intel.com>
 <dcba0513-e3c2-33f2-6cc9-c23d05a7e6ba@siemens.com>
 <CAHp75VfzH922Z5FfGQ7gS-+FLR7H_Q3mKm_58xmchZn5KEjiqQ@mail.gmail.com>
 <38f562f3-69d2-67d0-ecc2-4b44d67286e2@siemens.com>
 <CAHp75Vf517+vfe7GiTH2Gb0WBDdqi4fcR5Z1O6ideJMpbDhysw@mail.gmail.com>
 <08d40bf0-4e68-d763-af99-be1f60e369fc@siemens.com>
 <1493119630.24567.192.camel@linux.intel.com>
 <20170425113513.GQ7152@lahna.fi.intel.com>
 <2a116105-0046-bcc1-b560-f6986220fb4b@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2a116105-0046-bcc1-b560-f6986220fb4b@siemens.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Apr 25, 2017 at 02:17:23PM +0200, Jan Kiszka wrote:
> I'm not ACPI guru: How do we come from a SSDT to information that is
> carried in the DSDT so far? How can we overload wrong information in the
> built in DSDT this way? I'm all ears if we could fix our (and also the
> Galileo) quirks like that!

SSDT stands for Secondary System Description table which basically adds
stuff to DSDT (the main table). Main use for SSDTs is to add devices but
you can also amend an existing device in DSDT by adding methods and so
forth.

In case of Galileo the SPI1 host controller happens to miss _CRS method
so we can use SSDT like below to add that method there:

Scope (\_SB.PCI0.SPI1)
{
    Name (_CRS, ResourceTemplate () {
        GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionOutputOnly,
                "\\_SB.PCI0.GIP0.GPO", 0) {2} // MUX6_IO
    })

    Name (_DSD, Package () {
        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
            Package () {
                "cs-gpios", Package () {^SPI1, 0, 0, 0},
            },
        }
    })
}

This effectively means that once the table is parsed we find the SPI1
device with two new methods, _CRS and _DSD and the kernel is happy to
handle the rest.

Important thing here is the

	Scope (\_SB.PCI0.SPI1)

which allows us to reference an object in DSDT.
