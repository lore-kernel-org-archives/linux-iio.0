Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:45035 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeFVJEt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jun 2018 05:04:49 -0400
Received: by mail-pg0-f49.google.com with SMTP id g26-v6so2688322pgn.11
        for <linux-iio@vger.kernel.org>; Fri, 22 Jun 2018 02:04:49 -0700 (PDT)
Date: Fri, 22 Jun 2018 14:34:42 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        daniel.baluta@gmail.com
Subject: Re: [RFC 0/3] Bosch BME680 Driver
Message-ID: <20180622075458.GA12587@himanshu-Vostro-3559>
References: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com>
 <CAJCx=gmDUZ47EUuGH3a_+mYwvoPcFj2RwdSKvPmhqhdrYi1DHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJCx=gmDUZ47EUuGH3a_+mYwvoPcFj2RwdSKvPmhqhdrYi1DHg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Matt,

> > For now I have placed the sensor in the IMU but this is not an IMU and there
> > is no such sensor(4-in-1) in the whole IIO subsystem. So, where should it
> > be placed ?
> > Would it be worthwhile to create a new subdirectory "environmental" since
> > it is a environmental sensor ?
> >
> 
> Since it the most interesting feature is the VOC sensor I'd think it
> would make more sense  in drivers/iio/chemical (maybe I'm biased of
> course).

Yes, the gas sensing part is the most distinguished feature of the
sensor and relatively different from Temperature, Pressure & Humidity.

But still not sure about the placement.

> Even thought is doesn't output a processed value that you can use
> without Bosch's software.
> 
> Also I've looked briefly at the datasheet, and wondering why this
> can't be added to the existing BMP280 driver (like how the BME280
> humidity support was added).

Agreed! I had this same question on my mind but if you look carefully at
the BME280 datasheet "5.2 Register compatibility to BMP280" Pg 24, says
that BME280 & BMP280 share the same register addressing which is why it
was a wise decision to add them in a single driver. You don't need to
make new functions for temp, press, humid, read_calib, chip_config,
etc., separately and rather use a generic function for both of them.

Also, bme680 has some peculiar characteristics such as:

 1. different chip id address for SPI and I2C.
 2. Two power modes only and no *normal mode*

And a few more...

It is sad that Bosch discusses about the trimming/calibration parameters in
both bmp280 & bme280 but not in my(bme680) case. I don't know why ?

Although I got to know about it through Bosch BME680 API but since it is
mentioned *not* in datasheet and rather in their API. So, we need their
permission before using it and it's been two weeks since I and Daniel both
sent the email and no reply :(

Anyway, you're a chemical sensor expert and I have a question for
you which I would really appreciate if you could answer:

The user needs to supply to attributes to the gas sensor:

	1. Heater temperature: For eg. 200 degC to heat the sensor
	heater elemnent used for sensing. So, this 200 degC is converted
	to register code using BME680 API algorithm.

	2. Heater duration: The duration for which heater will be
	heated. For eg. 100ms

What would be the appropriate channel type for the above ?

Thank you for your time and that "Industrial I/O and You" Conference
video :)

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
