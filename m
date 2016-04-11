Return-Path: <vlad.dogaru@intel.com>
Date: Mon, 11 Apr 2016 11:44:59 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Christoph Mair <christoph.mair@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: pressure: bmp280: add support for BMP180
Message-ID: <20160411084459.GA31705@vdogaru>
References: <1460044621-17274-1-git-send-email-akinobu.mita@gmail.com>
 <20160408104313.GA12944@vdogaru>
 <CAC5umyjDk_LE-g+yJ5Lin+OPE2T5-3_V5VO_tO+F5TGaPp=tvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAC5umyjDk_LE-g+yJ5Lin+OPE2T5-3_V5VO_tO+F5TGaPp=tvg@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Apr 09, 2016 at 03:53:39AM +0900, Akinobu Mita wrote:
> 2016-04-08 19:43 GMT+09:00 Vlad Dogaru <vlad.dogaru@intel.com>:
> > On Fri, Apr 08, 2016 at 12:57:01AM +0900, Akinobu Mita wrote:
> [...]
> >> +static int bmp180_chip_init(struct bmp280_data *data)
> >> +{
> >> +     return 0;
> >> +}
> >
> > When setting the oversampling ratio, we do a lookup in the available
> > values array, then call ops->init to write the values to the register.
> > This function does nothing in the bmp180 case.  Or am I missing
> > something?
> 
> Your understanding is correct.  There is nothing to do for bmp180 when
> the oversampling setting is changed by the user.  When the actual
> measurement is requested, the measurement conversion is started by
> writing ctrl_meas register with the oversampling setting and start
> conversion bit.

Ah, I see.  That makes sense, thanks for the explanation.

Vlad
