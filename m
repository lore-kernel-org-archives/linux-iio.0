Return-Path: <SRS0=qq5G=MD=gmail.com=songqiang1304521@kernel.org>
Date: Fri, 21 Sep 2018 17:13:18 +0800
From: Song Qiang <songqiang1304521@gmail.com>
To: Phil Reid <preid@electromag.com.au>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org, mark.rutland@arm.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180921091318.GA2151@Eros>
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
 <4633d30b-b493-d70b-dd7b-3f5bc3e16e78@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4633d30b-b493-d70b-dd7b-3f5bc3e16e78@electromag.com.au>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Sep 21, 2018 at 10:05:38AM +0800, Phil Reid wrote:
> On 20/09/2018 9:13 PM, Song Qiang wrote:
> > PNI RM3100 magnetometer is a high resolution, large signal immunity
> > magnetometer, composed of 3 single sensors and a processing chip.
> > PNI is currently not in the vendors list, so this is also adding it.
> > 
> 
> In the subject: Isn't the RM3100 a 3axis mag.
> The 9axis bit comes when you combine it with an accel / gryo I think.
> 
> ... snip
> 

Hi Phil,

That's right!
The first time I got this sensor I googled it on the internet and the
abstract of the first webpage told me that it's a 9-axis sensor, and
it's from its offcial website! I just googled it and saw it's still
there, but after I entered the website, there isn't anything on the
webpage about '9-axis', maybe I just saw the old wrong web cache of 
google. Newer websites do say it's a 3-axis magnetometer sensor, and 
it only has three channels of data can be read. 3-axis it is.

> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> > @@ -0,0 +1,57 @@
> > +* PNI RM3100 9-axis magnetometer sensor
> > +
> > +I2C Bus:
> > +
> > +Required properties:
> > +
> > +- compatible : should be "pni,rm3100-i2c"
> > +- reg : the I2C address of the magnetometer
> > +
> 
> ... snip
> 
> > +SPI Bus:
> > +
> > +Required properties:
> > +
> > +- compatible : should be "pni,rm3100-spi"
> > +- reg : address of sensor, usually 0 or 1.
> > +
> 
> Looking at other drivers supporting i2c / spi.
> They use the same compatible for both.
> 
> eg: see iio/accel/adxl345_*.c
> 
> and it's binding doc:
> 
> Required properties:
>  - compatible : should be "adi,adxl345"
>  - reg : the I2C address or SPI chip select number of the sensor
> 

Agreed, since nodes of this sensor should be already on the bus where it
should be in DT, there's no need for compitable string to identify which
bus it's on.

yours,
Song Qiang
