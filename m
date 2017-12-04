Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45572 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbdLDK3d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Dec 2017 05:29:33 -0500
Received: by mail-wm0-f66.google.com with SMTP id 9so4810401wme.4
        for <linux-iio@vger.kernel.org>; Mon, 04 Dec 2017 02:29:33 -0800 (PST)
Subject: Re: [PATCH 2/2] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Jeremy Cline <jeremy@jcline.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>
References: <20171129223016.17848-1-jeremy@jcline.org>
 <0100016009e7c30a-407c2980-d8d5-4506-ab47-d0fb2fed481d-000000@email.amazonses.com>
 <20171202121927.3b7aa028@archlinux>
 <20171204095819.GY22431@lahna.fi.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <045185e0-927e-f004-2ec6-44205e5f6c13@redhat.com>
Date: Mon, 4 Dec 2017 11:29:31 +0100
MIME-Version: 1.0
In-Reply-To: <20171204095819.GY22431@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 04-12-17 10:58, Mika Westerberg wrote:
> On Sat, Dec 02, 2017 at 12:19:27PM +0000, Jonathan Cameron wrote:
>> On Wed, 29 Nov 2017 22:31:12 +0000
>> Jeremy Cline <jeremy@jcline.org> wrote:
>>
>>> Some BOSC0200 acpi_device-s describe two accelerometers in a single ACPI
>>> device. Check for a companion device and handle a second i2c_client
>>> if it is present.
>>
>> + Mika and Wolfram - please cc them on anything odd and i2c / ACPI related.
>> (I like to share the pain)
>>
>> My usual question, just out of curiosity as we have to cope with this
>> fun anyway.  Are you actually allowed to do this under the ACPI spec
>> or not?  I would assume an acpi device is supposed to be just that A
>> device...  I fall asleep every time I try to read that spec ;)
> 
> Yes, it is allowed. Typically you have an ACPI device and it can have
> multiple I2cSerialBus() connections.
> 
> Linux ACPI/I2C core then picks the first one and creates i2c_client from
> that but the additional connections need to be created by the driver in
> question.
> 
> BTW, there is a function i2c_new_secondary_device() that is supposed to
> be used for this but it does not have ACPI support yet (maybe it is good
> time to add it now, with this patch series?)

i2c_new_secondary_device() is for a different purpose, this is for when
a single i2c device listens on multiple addresses and the driver wants
separate i2c_client-s to use to talk to each address.

In this case there are 2 separate devices, not a single device listening
on multiple addresses.  Something like i2c_new_secondary_device() ACPI
support might be useful for i2c devices where a single device / "IC" listens
on multiple addresses and all these addresses are listed in the ACPI resource
table, but not for this specific case.

Regards,

Hans

