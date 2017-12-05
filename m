Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:42423 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751852AbdLEL2F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Dec 2017 06:28:05 -0500
Date: Tue, 5 Dec 2017 11:27:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        Jeremy Cline <jeremy@jcline.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
Message-ID: <20171205112738.00006ffd@huawei.com>
In-Reply-To: <20171204095819.GY22431@lahna.fi.intel.com>
References: <20171129223016.17848-1-jeremy@jcline.org>
        <0100016009e7c30a-407c2980-d8d5-4506-ab47-d0fb2fed481d-000000@email.amazonses.com>
        <20171202121927.3b7aa028@archlinux>
        <20171204095819.GY22431@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 4 Dec 2017 11:58:19 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> On Sat, Dec 02, 2017 at 12:19:27PM +0000, Jonathan Cameron wrote:
> > On Wed, 29 Nov 2017 22:31:12 +0000
> > Jeremy Cline <jeremy@jcline.org> wrote:
> >   
> > > Some BOSC0200 acpi_device-s describe two accelerometers in a single ACPI
> > > device. Check for a companion device and handle a second i2c_client
> > > if it is present.  
> > 
> > + Mika and Wolfram - please cc them on anything odd and i2c / ACPI related.
> > (I like to share the pain)
> > 
> > My usual question, just out of curiosity as we have to cope with this
> > fun anyway.  Are you actually allowed to do this under the ACPI spec
> > or not?  I would assume an acpi device is supposed to be just that A
> > device...  I fall asleep every time I try to read that spec ;)  
> 
> Yes, it is allowed. Typically you have an ACPI device and it can have
> multiple I2cSerialBus() connections.
> 
> Linux ACPI/I2C core then picks the first one and creates i2c_client from
> that but the additional connections need to be created by the driver in
> question.

Why does it not make sense to just create them all from the ACPI/I2C core?

> 
> BTW, there is a function i2c_new_secondary_device() that is supposed to
> be used for this but it does not have ACPI support yet (maybe it is good
> time to add it now, with this patch series?)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

