Return-Path: <SRS0=aZyi=2A=gmail.com=eraretuya@kernel.org>
Date: Sun, 19 Feb 2017 20:15:07 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, dmitry.torokhov@gmail.com,
	michael.hennerich@analog.com, daniel.baluta@gmail.com,
	amsfield22@gmail.com, florian.vaussard@heig-vd.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: accel: adxl345: Add ACPI support
Message-ID: <20170219121506.GA3856@Socrates-UM>
References: <1487239327-21406-1-git-send-email-eraretuya@gmail.com>
 <1487239327-21406-5-git-send-email-eraretuya@gmail.com>
 <cd10157c-a1ac-c042-bd91-3cb7647919af@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cd10157c-a1ac-c042-bd91-3cb7647919af@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Feb 19, 2017 at 11:01:23AM +0100, Lars-Peter Clausen wrote:
> On 02/16/2017 11:02 AM, Eva Rachel Retuya wrote:
> [...]
> > @@ -54,9 +55,17 @@ static const struct i2c_device_id adxl345_i2c_id[] = {
> >  
> >  MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
> >  
> > +static const struct acpi_device_id adxl345_acpi_id[] = {
> > +	{ "ADX0345", 0 },
> 
> Who allocated this ID? ADX does not seem to be a registered vendor ID
> (http://www.uefi.org/PNP_ACPI_Registry).
> 

Hello Lars,

Pardon the ignorance. I was not aware of this when I set it like that.
Is "ADS0345" OK? Will submit a new version with that ID.

Thanks,
Eva

> > +	{ }
> > +};
> 
