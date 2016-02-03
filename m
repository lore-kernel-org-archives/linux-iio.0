Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32904 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbcBCPSn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Feb 2016 10:18:43 -0500
Received: by mail-wm0-f67.google.com with SMTP id r129so7881927wmr.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Feb 2016 07:18:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1602031604531.12205@pmeerw.net>
References: <1454494947-9073-1-git-send-email-daniel.baluta@intel.com>
	<alpine.DEB.2.02.1602031122350.12205@pmeerw.net>
	<CAEnQRZDxQ4KCX_paZCf0iGjZ1rp-qeF1BGKgWoQZOhUYk_fi1g@mail.gmail.com>
	<alpine.DEB.2.02.1602031604531.12205@pmeerw.net>
Date: Wed, 3 Feb 2016 17:18:42 +0200
Message-ID: <CAEnQRZBDfb_2F=UafL9Dx+6s8Q4Si7JCdrgSb5D0xq_nT2BipQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: Add TI ADS1015 ADC driver support
From: Daniel Baluta <daniel.baluta@intel.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 3, 2016 at 5:09 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>
>> >> +     .scan_index = _addr,                                    \
>> >> +     .scan_type = {                                          \
>> >> +             .sign = 's',                                    \
>> >> +             .realbits = 12,                                 \
>> >> +             .storagebits = 16,                              \
>> >> +             .shift = 4,                                     \
>> >> +             .endianness = IIO_CPU,                          \
>> >
>> > I don't see the code for endianness conversion, I guess it should be _BE
>> > (also below)
>>
>> Conversion register is _BE but I think here is better to use IIO_CPU.
>> regmap_read() encapsulates a lot of magic, it actually does the endianness
>> conversion.
>
> indeed, this is super complicated
>
>> converts the value read from reg endianess to cpu endianness (in our case
>> there is a transparent call  to b16_to_cpu).
>
> kind of, depending on what i2c capabilities you have :)
>
> anyway, your code *might* be correct :)

Can you point a case where the code can be wrong?

AFAICS the regmap_read shouldn't depend on i2c capabilities. Or at
least will return
an error code if something goes bad.

thanks,
Daniel.
