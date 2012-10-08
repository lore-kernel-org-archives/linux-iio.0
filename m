Return-Path: <pavel@ucw.cz>
Date: Mon, 8 Oct 2012 21:50:08 +0200
From: Pavel Machek <pavel@denx.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Denis CIOCCA <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"burman.yan@gmail.com" <burman.yan@gmail.com>
Subject: Re: STMicroelectronics accelerometers driver.
Message-ID: <20121008195007.GA32042@elf.ucw.cz>
References: <5072F3B9.4050309@st.com>
 <5073260C.3010506@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5073260C.3010506@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>


> > drivers/iio/accel/STMicroelectronics_accelerometers_iio_i2c.c
> >   create mode 100644
> > drivers/iio/accel/STMicroelectronics_accelerometers_iio_spi.c
> >   create mode 100644
> > drivers/iio/accel/STMicroelectronics_accelerometers_iio_trigger.c
> 
> the file names are a bit excessive in my opinion. How about
> st_accel_{buffer,core,i2c,...}.c?

drivers/iio/accel/st/iio_spi.c ?

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
