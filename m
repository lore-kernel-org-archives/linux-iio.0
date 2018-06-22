Return-Path: <SRS0=GMJS=JI=gmail.com=himanshujha199640@kernel.org>
Date: Fri, 22 Jun 2018 19:44:06 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
	pmeerw@pmeerw.net, daniel.baluta@gmail.com,
	gregkh@linuxfoundation.org
Subject: Re: [RFC 0/3] Bosch BME680 Driver
Message-ID: <20180622141406.GA17901@himanshu-Vostro-3559>
References: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com>
 <20180622150143.00002e5b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180622150143.00002e5b@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 22, 2018 at 03:01:43PM +0100, Jonathan Cameron wrote:
> On Thu, 21 Jun 2018 12:04:34 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
> > GSoC'2018 Project: https://summerofcode.withgoogle.com/projects/#6691473790074880
> > Mentor: Daniel Baluta
> > 
> > BME680 is a 4-in-1 sensor with temperature, pressure, humidity & gas sensor
> > with I2C and SPI interface support.
> > 
> > The sensor has various calibration parameters[1] to be used with raw adc data
> > in the compensation functions[2] to evaluate the correct compensated reading.
> > These calibration parameters are are programmed into the devices’ non-volatile
> > memory (NVM) during production and cannot be altered by the customer. So, we
> > are required to read those parameters once(suitably at probe) and use it
> > in the compensation functions.
> > 
> > But now the problem arises that these compensation functions, calibration
> > parameters, their addresses are *not* provided in the datasheet and instead
> > provided by Bosch Sensortec in their Github API[3]. The Github API has a LICENSE
> > file[4] around 40 lines which I presume kernel community won't entertain.
> 
> That looks to be 3 clause BSD.  Which I think is fine as it is considered to
> be GPLv2 compatible.  Basic principle is that it's open enough that nothing
> stops the code being used in GPL licensed code as long as we tag it with
> the relevant license identifier.
> 
> I've cc'd Greg as he has a lot wider experience than I do!

I got a positive reply from Bosch later this day and we can easily use
their compensation functions and calibration parameters without any
legal issues.

Just adding:

	Copyright (C) 2017 - 2018 Bosch Sensortec GmbH

to the top of source would solve the problem :)

> > This 0.01 degC resolution was mentioned in the BMP280 datasheet but
> > there is no such information in the BME680 datasheet nor in the Github API.
> > 
> > This is what I have assumed since after testing pressure & humidity also
> > revealed similar readings and there is some possibilty that they could
> > have same output resolution as they belong to the same family of sensors.
> > 
> > For now I have placed the sensor in the IMU but this is not an IMU and there
> > is no such sensor(4-in-1) in the whole IIO subsystem. So, where should it
> > be placed ?
> 
> Choose the primary use case.  I.e. the bit that would lead people to put
> this chip in place.   It's a chemical sensor as far as I can see
> so put it in there.  Otherwise we end up with an ever increasing number
> of categories dependent more on what is in the marketing material than
> on how they group with similar sensors.  These categories don't need
> to be perfect.

Will do!

> > Would it be worthwhile to create a new subdirectory "environmental" since
> > it is a environmental sensor ?
> > 
> > The sensor also has an IIR filter to remove short term fluctuations from
> > the temperature and pressure readings. It has various filter coefficients
> > and I have chosen the middle valued coefficient(15) from the table for now.
> > 
> > What filter coefficient is most appropriate for the device ?
> > 
> > Again, I asked this question too from Bosch since they discuss all these
> > optimal selection of filter in "3.4 Filter selection" Pg 14 BMP280.
> 
> This should be coming from device specific calibration.  So we can give
> 'reasonable defaults', but I'd expect device manufacturers to provide
> via DT or ACPI.

I got the details from Bosch.
No worries now :)

> > I have used regmap API  and therefore we don't need the LSB address
> > of data registers as we only care about the MSB address of the data register
> > and regmap_bulk_read() handles everything fine.
> > 
> > So, would it be worthwhile to add these LSB macros definition too ?
> > They certainly will never be used!
> 
> This is common.  Don't bother with the ones that aren't used.

Sure!

Thanks for the quick feedback Jonathan.

And sorry Greg for the noise!

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
