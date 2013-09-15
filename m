Return-Path: <pmeerw@pmeerw.net>
Date: Sun, 15 Sep 2013 17:51:51 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: Add tcs3472 color light sensor driver
In-Reply-To: <5234CB23.3050902@kernel.org>
Message-ID: <alpine.DEB.2.01.1309151744150.22469@pmeerw.net>
References: <52344B8B.1010704@kernel.org> <1379187514-28650-1-git-send-email-pmeerw@pmeerw.net> <5234CB23.3050902@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hi,

> > chip has four 16-bit channels for red, green, blue, clear color
> > intensity; driver supports the TCS3x7x family of devices and was
> > tested with a TCS34725 chip; further information here:
> > http://www.ams.com/eng/Products/Light-Sensors/Color-Sensor/TCS34725
> > 
> > v2 (thanks to Jonathan Cameron):
> > * drop dynamic buffer allocation, buffer is in tcs3472_data
> > * limit sysfs output to PAGE_SIZE
> > * check val2 == 0 when writing CALIBSCALE

> Applied to the togreg branch of iio.git

> > +struct tcs3472_data {
> > +	struct i2c_client *client;
> > +	u8 enable;
> > +	u8 control;
> > +	u8 atime;
> > +	u16 buffer[4];
> > +};
> > +
> > +/* 4 16-bit channels + timestamp = 16 bytes */
> > +#define TSL3472_BUFFER_SIZE 16

I messed this up, sorry
buffer must be of size 8 (hence 16 bytes) obviously;

patch following (removing the obsolete #define also)

thanks, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
