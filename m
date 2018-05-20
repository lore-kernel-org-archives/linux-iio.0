Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751162AbeETQXh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 12:23:37 -0400
Date: Sun, 20 May 2018 17:23:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/9] ACPI/i2c Enumerate several instances out of one
 fwnode
Message-ID: <20180520172331.5297177b@archlinux>
In-Reply-To: <20180520132857.8103-1-hdegoede@redhat.com>
References: <20180520132857.8103-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 20 May 2018 15:28:48 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi All,
> 
> This series really consists of 2 series, patches 1-5 add support for
> interesting ACPI tables which describe multiple i2c chips in a single
> fwnode, sometimes multiple cases of the same chip on different addresses,
> sometimes a bunch of related chips.
> 
> Andy Shevchenko has come up with the solution of adding a quirk based
> on the ACPI HID of the fwnode for these devices which makes the
> drivers/i2c/i2c-core-acpi.c code instantiate separate i2c_client devices
> for each I2cSerialBusV2 in the fwnode. I agree with him that this is
> the best (least ugly) solution for this.
> 
> I've been testing this solution on a device if mine which needs a solution
> for this, the HP Pavilion x2 - 10-n000nd 2-in-1 has an acpi_device / fwnode
> with a HID of BSG1160 which describes 3 different i2c sensors in an accel /
> magneto / gyro sensor cluster on the tablet. This has let to some extra
> prep. patches and some fixes to Andy's patches.
> 
> Patches 6-9 use the new functionality creating  one i2c-client per
> I2cSerialBusV2 resource to make the sensor cluster on the HP X2 work and
> are posted as part of this series to show how this functionality can be
> used.
> 
> Assuming everyone is ok with this series (I'm not expecting anyone to be
> really happy about the need for this), then I suggest that patches 1-6
> get merged togther through either the ACPI or the i2c tree, I guess the
> i2c tree would make somewhat more sense, since most patches are there.
> 
> Then once those are accepted patches 7-9 can be merged into the iio tree,
> there is no compile time dependency between the 2, so these can be merged
> separately. Note merging 7-9 before there is agreement that this is the
> right way to fix this is probably not a good idea.

It's hideous, but I can live with it as better than anything else anyone
has come up with.  I just hope we don't get a huge number of these
'interesting' ACPI cases going forwards.

Jonathan

> 
> Regards,
> 
> Hans
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

