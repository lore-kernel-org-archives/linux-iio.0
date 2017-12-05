Return-Path: <SRS0=IX/W=DB=huawei.com=jonathan.cameron@kernel.org>
Date: Tue, 5 Dec 2017 11:54:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Jeremy Cline <jeremy@jcline.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Hans de Goede
	<hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser
	<steve@pressers.name>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
Message-ID: <20171205115413.00007e64@huawei.com>
In-Reply-To: <20171205113801.GU22431@lahna.fi.intel.com>
References: <20171129223016.17848-1-jeremy@jcline.org>
	<0100016009e7c30a-407c2980-d8d5-4506-ab47-d0fb2fed481d-000000@email.amazonses.com>
	<20171202121927.3b7aa028@archlinux>
	<20171204095819.GY22431@lahna.fi.intel.com>
	<20171205112738.00006ffd@huawei.com>
	<20171205113801.GU22431@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Tue, 5 Dec 2017 13:38:01 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> On Tue, Dec 05, 2017 at 11:27:38AM +0000, Jonathan Cameron wrote:
> > Why does it not make sense to just create them all from the ACPI/I2C core?  
> 
> How do you know in ACPI/I2C core what is the right thing to do? Is it a
> single device, like EEPROM with multiple addresses, or is it multiple
> completely separate devices like in case of many sensors?

Fine, though this seems like a flaw in the ACPI description as it
isn't possible to tell the difference.  Why it allows on ACPI description
for multiple devices in one ACPI device is beyond me...

More ACPI specific driver code that may eventually end up in every
driver.  Goody. Perhaps we can define a helper function to at least
make this trivial and minimize the burden. Ultimately if this happens
enough we could probably figure out how to move it into the I2C core
entirely - flag in the i2c_driver structure for example.

Jonathan
