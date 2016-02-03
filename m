Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:41129 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777AbcBCPJJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 3 Feb 2016 10:09:09 -0500
Date: Wed, 3 Feb 2016 16:09:07 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Daniel Baluta <daniel.baluta@intel.com>
cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: Add TI ADS1015 ADC driver support
In-Reply-To: <CAEnQRZDxQ4KCX_paZCf0iGjZ1rp-qeF1BGKgWoQZOhUYk_fi1g@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1602031604531.12205@pmeerw.net>
References: <1454494947-9073-1-git-send-email-daniel.baluta@intel.com> <alpine.DEB.2.02.1602031122350.12205@pmeerw.net> <CAEnQRZDxQ4KCX_paZCf0iGjZ1rp-qeF1BGKgWoQZOhUYk_fi1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> >> +     .scan_index = _addr,                                    \
> >> +     .scan_type = {                                          \
> >> +             .sign = 's',                                    \
> >> +             .realbits = 12,                                 \
> >> +             .storagebits = 16,                              \
> >> +             .shift = 4,                                     \
> >> +             .endianness = IIO_CPU,                          \
> >
> > I don't see the code for endianness conversion, I guess it should be _BE
> > (also below)
> 
> Conversion register is _BE but I think here is better to use IIO_CPU.
> regmap_read() encapsulates a lot of magic, it actually does the endianness
> conversion.

indeed, this is super complicated
 
> converts the value read from reg endianess to cpu endianness (in our case
> there is a transparent call  to b16_to_cpu).

kind of, depending on what i2c capabilities you have :)

anyway, your code *might* be correct :)

p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
