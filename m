Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43899 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeJ1B4W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Oct 2018 21:56:22 -0400
Date: Sat, 27 Oct 2018 22:44:28 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Dan O'Donovan <dan@emutex.com>
Cc: linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>,
        Javier Arteaga <javier@emutex.com>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v3 2/3] iio: adc128s052: add ACPI _HID AANT1280
Message-ID: <20181027171428.GA2503@himanshu-Vostro-3559>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
 <1540481742-23596-3-git-send-email-dan@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1540481742-23596-3-git-send-email-dan@emutex.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Dan,

On Thu, Oct 25, 2018 at 04:35:41PM +0100, Dan O'Donovan wrote:
> From: Nicola Lunghi <nicola.lunghi@emutex.com>
> 
> ACPI _HID AANT1280 matches an ADC124S101 present on E3940 SKUs of the UP
> Squared board.
> 
> Add it to the driver.
> 
> Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
> [javier@emutex.com: fix up commit message and one checkpatch warning]
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> ---
>  drivers/iio/adc/ti-adc128s052.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

[]

> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id adc128_acpi_match[] = {
> +	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
> +#endif

I'm curious about the naming conventions used for selecting 
an ACPI ID.

AFAIK, ACPI or PNP ID consists of *Vendor* ID + Product ID.

PNP ID: PNP Vendor IDs consist of 3 characters, each character being
an uppercase letter (A-Z).

ACPI ID: ACPI Vendor IDs consist of 4 characters, each character being
either an uppercase letter (A-Z) or a numeral (0-9).

In your case,

Vendor ID -> AANT (AAEON TECHNOLOGY INC. registered ACPI ID prefix)
http://www.uefi.org/ACPI_ID_List?search=AANT

Product ID -> 1280

How did you come up with 1280 ? And why AANT ? why not TXNW which is
registered ACPI prefix for TEXAS INSTRUMENTS ?
http://www.uefi.org/ACPI_ID_List?search=Texas+

Latest ACPI manuals says:

6.1.5 _HID (Hardware ID)
------------------------

This object is used to supply OSPM with the device’s Plug and Play
hardware ID.[1]

[1] "A Plug and Play ID or ACPI ID can be obtained by sending e-mail to
pnpid@microsoft.com."

A _HID object evaluates to either a numeric 32-bit compressed EISA type ID or a string. If a
string, the format must be an alphanumeric PNP or ACPI ID with no asterisk or other leading
characters.

A valid PNP ID must be of the form "AAA####" where A is an uppercase letter and # is a hex
digit. A valid ACPI ID must be of the form "NNNN####" where N is an uppercase letter or a
digit ('0'-'9') and # is a hex digit. This specification reserves the string "ACPI" for use only
with devices defined herein. It further reserves all strings representing 4 HEX digits for
exclusive use with PCI-assigned Vendor IDs.


Next question:

There are a lot drivers in iio/ using ACPI for device enumeration using
these IDs. For now, let's take an example of Bosch Sensors:

drivers/iio/accel/bmc150-accel-i2c.c:static const struct acpi_device_id bmc150_accel_acpi_match[] = {
drivers/iio/accel/bmc150-accel-i2c.c-   {"BSBA0150",    bmc150},
drivers/iio/accel/bmc150-accel-i2c.c-   {"BMC150A",     bmc150},
drivers/iio/accel/bmc150-accel-i2c.c-   {"BMI055A",     bmi055},
drivers/iio/accel/bmc150-accel-i2c.c-   {"BMA0255",     bma255},

drivers/iio/gyro/bmg160_i2c.c:static const struct acpi_device_id bmg160_acpi_match[] = {
drivers/iio/gyro/bmg160_i2c.c-  {"BMG0160", 0},
drivers/iio/gyro/bmg160_i2c.c-  {"BMI055B", 0},
drivers/iio/gyro/bmg160_i2c.c-  {},
drivers/iio/gyro/bmg160_i2c.c-};

drivers/iio/imu/bmi160/bmi160_i2c.c:static const struct acpi_device_id bmi160_acpi_match[] = {
drivers/iio/imu/bmi160/bmi160_i2c.c-    {"BMI0160", 0},
drivers/iio/imu/bmi160/bmi160_i2c.c-    { },
drivers/iio/imu/bmi160/bmi160_i2c.c-};
drivers/iio/imu/bmi160/bmi160_i2c.c-MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);

Bosch registered ACPI ID: BOSC
http://www.uefi.org/ACPI_ID_List?search=Bosch

Bosch registered PNP ID: BSG
http://www.uefi.org/PNP_ID_List?search=Bosch

So, how could we use PNP ID "BMI" which is registered prefix for
BENSON MEDICAL INSTRUMENTS COMPANY ?
http://www.uefi.org/PNP_ID_List?search=BMI

Product ID -> "160" is fine for bmi160 which uniquely identifies the
sensor device.

But shouldn't the prefix be "BSG0160" instead of "BMI0160" ?

When I wrote the driver for Bosch BME680, I followed the same guideline
as done everywhere else in the Bosch family:

drivers/iio/pressure/bmp280-i2c.c-      {"BMP0280", BMP280_CHIP_ID },
drivers/iio/pressure/bmp280-i2c.c-      {"BMP0180", BMP180_CHIP_ID },
drivers/iio/pressure/bmp280-i2c.c-      {"BMP0085", BMP180_CHIP_ID },
drivers/iio/pressure/bmp280-i2c.c-      {"BME0280", BME280_CHIP_ID },

Therefore, I used BME0680 for bosch bme680 sensor!

In OF matching, we use vendor prefixes and that looks more legimate:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/vendor-prefixes.txt

Dan,

These questions are not just for you but to rest of the community
members as well.

If there is something I misunderstood, then please let me know :)


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
