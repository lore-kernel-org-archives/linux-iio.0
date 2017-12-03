Return-Path: <SRS0=+0OV=C7=redhat.com=javierm@kernel.org>
Subject: Re: [PATCH] iio: accel: bmc150: Add OF device ID table
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20171201111058.13483-1-javierm@redhat.com>
 <20171202120251.77ade310@archlinux>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <0b96ad0e-79b6-0f22-38e0-b4dc762621a5@redhat.com>
Date: Sun, 3 Dec 2017 02:11:27 +0100
MIME-Version: 1.0
In-Reply-To: <20171202120251.77ade310@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

On 12/02/2017 01:02 PM, Jonathan Cameron wrote:
> On Fri,  1 Dec 2017 12:10:58 +0100
> Javier Martinez Canillas <javierm@redhat.com> wrote:
> 
>> The driver doesn't have a struct of_device_id table but supported devices
>> are registered via Device Trees. This is working on the assumption that a
>> I2C device registered via OF will always match a legacy I2C device ID and
>> that the MODALIAS reported will always be of the form i2c:<device>.
>>
>> But this could change in the future so the correct approach is to have an
>> OF device ID table if the devices are registered via OF.
>>
>> The I2C device ID table entries have the .driver_data field set, but they
>> are not used in the driver so weren't set in the OF device table entries.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
> 
> Would be nice to do the spi counterpart at somepoint, but as this is
> clearly an improvement on nothing I applied this one as step 1.
>

Ok, I can do the same for SPI. I'll post a patch for it next week.
 
> Good point about the data fields though - we should probably clean those
> out as misleading.
>

Same for this, I can post a cleanup patch to get rid of the .data fields.

> Thanks,
> 
> Jonathan

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
