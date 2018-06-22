Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:9120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751233AbeFVOCL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 Jun 2018 10:02:11 -0400
Date: Fri, 22 Jun 2018 15:01:43 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <daniel.baluta@gmail.com>,
        <gregkh@linuxfoundation.org>
Subject: Re: [RFC 0/3] Bosch BME680 Driver
Message-ID: <20180622150143.00002e5b@huawei.com>
In-Reply-To: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com>
References: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 21 Jun 2018 12:04:34 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> GSoC'2018 Project: https://summerofcode.withgoogle.com/projects/#6691473790074880
> Mentor: Daniel Baluta
> 
> BME680 is a 4-in-1 sensor with temperature, pressure, humidity & gas sensor
> with I2C and SPI interface support.
> 
> The sensor has various calibration parameters[1] to be used with raw adc data
> in the compensation functions[2] to evaluate the correct compensated reading.
> These calibration parameters are are programmed into the devices’ non-volatile
> memory (NVM) during production and cannot be altered by the customer. So, we
> are required to read those parameters once(suitably at probe) and use it
> in the compensation functions.
> 
> But now the problem arises that these compensation functions, calibration
> parameters, their addresses are *not* provided in the datasheet and instead
> provided by Bosch Sensortec in their Github API[3]. The Github API has a LICENSE
> file[4] around 40 lines which I presume kernel community won't entertain.

That looks to be 3 clause BSD.  Which I think is fine as it is considered to
be GPLv2 compatible.  Basic principle is that it's open enough that nothing
stops the code being used in GPL licensed code as long as we tag it with
the relevant license identifier.

I've cc'd Greg as he has a lot wider experience than I do!

> Therefore, we contacted Bosch Sensortec thrice 2 weeks ago and got no response
> so far. We stated all the problems relating to Lincensing & missing calibration
> info from the datasheet. I got to know about these missing information from the
> Github API and also looking at the various sensors supplied by the company
> such as BMP280, BME280 etc.
> 
> After using their compensation function in my driver I get correct readings.
> But we can't simply use these function without their permission!

Now I'm certainly not a lawyer, but I believe that, even if these had been
under an incompatible license we 'could' have done the fairly elaborate
processes needed to legally use the maths inherent in that code.

> 
> For instance:
> I got a temperature reading of:
> 
> 	3254
> 
> and if this sensor has a similar resolution as that of BMP280 which 0.01 degC
> then it is absolutely correct.
> 
> 	3254 * 0.01 = 32.54 degC
> 
> This 0.01 degC resolution was mentioned in the BMP280 datasheet but
> there is no such information in the BME680 datasheet nor in the Github API.
> 
> This is what I have assumed since after testing pressure & humidity also
> revealed similar readings and there is some possibilty that they could
> have same output resolution as they belong to the same family of sensors.
> 
> For now I have placed the sensor in the IMU but this is not an IMU and there
> is no such sensor(4-in-1) in the whole IIO subsystem. So, where should it
> be placed ?

Choose the primary use case.  I.e. the bit that would lead people to put
this chip in place.   It's a chemical sensor as far as I can see
so put it in there.  Otherwise we end up with an ever increasing number
of categories dependent more on what is in the marketing material than
on how they group with similar sensors.  These categories don't need
to be perfect.


> Would it be worthwhile to create a new subdirectory "environmental" since
> it is a environmental sensor ?
> 
> The sensor also has an IIR filter to remove short term fluctuations from
> the temperature and pressure readings. It has various filter coefficients
> and I have chosen the middle valued coefficient(15) from the table for now.
> 
> What filter coefficient is most appropriate for the device ?
> 
> Again, I asked this question too from Bosch since they discuss all these
> optimal selection of filter in "3.4 Filter selection" Pg 14 BMP280.

This should be coming from device specific calibration.  So we can give
'reasonable defaults', but I'd expect device manufacturers to provide
via DT or ACPI.

> 
> I have used regmap API  and therefore we don't need the LSB address
> of data registers as we only care about the MSB address of the data register
> and regmap_bulk_read() handles everything fine.
> 
> So, would it be worthwhile to add these LSB macros definition too ?
> They certainly will never be used!

This is common.  Don't bother with the ones that aren't used.

> 
> For now, this series doesn't include any of the copyrighted code from
> Bosch and I have just added them as a dummy function.
> 
> I have mentioned more detailed summary in my blog[5] and would love
> any feedback on it.
> 
> If anyone has contacts to Bosch Sensortec GmbH then please let me
> know.

Unfortunately not but as I say above, with my definitely not a lawyer
hat on, my understanding is we are fine as long as we maintain
the license text.  I would put such code in a separate file so that
we have more normal licensing for the rest of the driver.

> 
> [1] https://github.com/BoschSensortec/BME680_driver/blob/313a58a9c57ad86c8df06c98521579c6cb695999/bme680_defs.h#L410
> [2] https://github.com/BoschSensortec/BME680_driver/blob/master/bme680.c#L876
> [3] https://github.com/BoschSensortec/BME680_driver
> [4] https://github.com/BoschSensortec/BME680_driver/blob/master/LICENSE
> [5] https://himanshujha199640.wordpress.com/2018/06/14/0x01bme680-temperature-channel/
> 
> Himanshu Jha (3):
>   iio: imu: bme680: Add initial support for Bosch BME680
>   iio: imu: bme680: Add temperaure, pressure & humidity channels
>   iio: imu: bme680: Add ACPI support
> 
>  drivers/iio/imu/Kconfig              |   1 +
>  drivers/iio/imu/Makefile             |   1 +
>  drivers/iio/imu/bme680/Kconfig       |  32 +++
>  drivers/iio/imu/bme680/Makefile      |   6 +
>  drivers/iio/imu/bme680/bme680.h      |  11 +
>  drivers/iio/imu/bme680/bme680_core.c | 542 +++++++++++++++++++++++++++++++++++
>  drivers/iio/imu/bme680/bme680_i2c.c  |  62 ++++
>  drivers/iio/imu/bme680/bme680_spi.c  |  49 ++++
>  8 files changed, 704 insertions(+)
>  create mode 100644 drivers/iio/imu/bme680/Kconfig
>  create mode 100644 drivers/iio/imu/bme680/Makefile
>  create mode 100644 drivers/iio/imu/bme680/bme680.h
>  create mode 100644 drivers/iio/imu/bme680/bme680_core.c
>  create mode 100644 drivers/iio/imu/bme680/bme680_i2c.c
>  create mode 100644 drivers/iio/imu/bme680/bme680_spi.c
> 


> 

