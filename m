Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:48477 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbdBTMHl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 07:07:41 -0500
Subject: Re: [PATCH 4/4] iio: accel: adxl345: Add ACPI support
To: jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, dmitry.torokhov@gmail.com,
        michael.hennerich@analog.com, daniel.baluta@gmail.com,
        amsfield22@gmail.com, florian.vaussard@heig-vd.ch,
        linux-kernel@vger.kernel.org
References: <1487239327-21406-1-git-send-email-eraretuya@gmail.com>
 <1487239327-21406-5-git-send-email-eraretuya@gmail.com>
 <cd10157c-a1ac-c042-bd91-3cb7647919af@metafoo.de>
 <20170219121506.GA3856@Socrates-UM>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <aa845fa1-4689-cdac-bbf5-0bab19e003dd@metafoo.de>
Date: Mon, 20 Feb 2017 13:07:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170219121506.GA3856@Socrates-UM>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/19/2017 01:15 PM, Eva Rachel Retuya wrote:
> On Sun, Feb 19, 2017 at 11:01:23AM +0100, Lars-Peter Clausen wrote:
>> On 02/16/2017 11:02 AM, Eva Rachel Retuya wrote:
>> [...]
>>> @@ -54,9 +55,17 @@ static const struct i2c_device_id adxl345_i2c_id[] = {
>>>  
>>>  MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
>>>  
>>> +static const struct acpi_device_id adxl345_acpi_id[] = {
>>> +	{ "ADX0345", 0 },
>>
>> Who allocated this ID? ADX does not seem to be a registered vendor ID
>> (http://www.uefi.org/PNP_ACPI_Registry).
>>
> 
> Hello Lars,
> 
> Pardon the ignorance. I was not aware of this when I set it like that.
> Is "ADS0345" OK? Will submit a new version with that ID.

Excellent question. ACPI is not like devicetree where we can just randomly
choose IDs. The namespaces are more controlled. The vendor IDs are managed
and allocated by the UEFI forum, each vendor then allocates device IDs in
its vendor namespace for specific purposes. Unless you own a vendor ID or
the device ID has been allocated by the vendor for you you shouldn't use the ID.

If you have a ACPI based system which features the adxl345 maybe using
PRP0001[1] might be the better approach.

- Lars

[1] https://www.kernel.org/doc/Documentation/acpi/enumeration.txt

