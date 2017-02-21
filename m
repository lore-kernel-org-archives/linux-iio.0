Return-Path: <SRS0=hYFC=2C=gmail.com=eraretuya@kernel.org>
Date: Tue, 21 Feb 2017 23:18:33 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, dmitry.torokhov@gmail.com,
	michael.hennerich@analog.com, daniel.baluta@gmail.com,
	amsfield22@gmail.com, florian.vaussard@heig-vd.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: accel: adxl345: Add ACPI support
Message-ID: <20170221151832.GB3315@Socrates-UM>
References: <1487239327-21406-1-git-send-email-eraretuya@gmail.com>
 <1487239327-21406-5-git-send-email-eraretuya@gmail.com>
 <cd10157c-a1ac-c042-bd91-3cb7647919af@metafoo.de>
 <20170219121506.GA3856@Socrates-UM>
 <aa845fa1-4689-cdac-bbf5-0bab19e003dd@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aa845fa1-4689-cdac-bbf5-0bab19e003dd@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 20, 2017 at 01:07:38PM +0100, Lars-Peter Clausen wrote:
> On 02/19/2017 01:15 PM, Eva Rachel Retuya wrote:
> > On Sun, Feb 19, 2017 at 11:01:23AM +0100, Lars-Peter Clausen wrote:
> >> On 02/16/2017 11:02 AM, Eva Rachel Retuya wrote:
> >> [...]
> >>> @@ -54,9 +55,17 @@ static const struct i2c_device_id adxl345_i2c_id[] = {
> >>>  
> >>>  MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
> >>>  
> >>> +static const struct acpi_device_id adxl345_acpi_id[] = {
> >>> +	{ "ADX0345", 0 },
> >>
> >> Who allocated this ID? ADX does not seem to be a registered vendor ID
> >> (http://www.uefi.org/PNP_ACPI_Registry).
> >>
> > 
> > Hello Lars,
> > 
> > Pardon the ignorance. I was not aware of this when I set it like that.
> > Is "ADS0345" OK? Will submit a new version with that ID.
> 
> Excellent question. ACPI is not like devicetree where we can just randomly
> choose IDs. The namespaces are more controlled. The vendor IDs are managed
> and allocated by the UEFI forum, each vendor then allocates device IDs in
> its vendor namespace for specific purposes. Unless you own a vendor ID or
> the device ID has been allocated by the vendor for you you shouldn't use the ID.
> 
> If you have a ACPI based system which features the adxl345 maybe using
> PRP0001[1] might be the better approach.
> 
> - Lars
> 
> [1] https://www.kernel.org/doc/Documentation/acpi/enumeration.txt

Since the ID has not been allocated yet, will drop this patch at the
moment. Thanks for the explanation.

Eva

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
