Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33063 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbcBEVod (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2016 16:44:33 -0500
MIME-Version: 1.0
In-Reply-To: <CAKi4VALtv3+_SjRG=_gmfpH=EN6D=DJJ9W8MHiCiADn56ber+A@mail.gmail.com>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
	<CAKi4VALtv3+_SjRG=_gmfpH=EN6D=DJJ9W8MHiCiADn56ber+A@mail.gmail.com>
Date: Fri, 5 Feb 2016 23:44:32 +0200
Message-ID: <CAEnQRZD6n5ZdgPGA7pD6_Od_FwP=hn5mKcA5WJ3daUGuJBcSvw@mail.gmail.com>
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Michael Welling <mwelling@ieee.org>,
	Guenter Roeck <linux@roeck-us.net>, eibach@gdsys.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 5, 2016 at 11:02 PM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> Hi Daniel,
>
> On Fri, Feb 5, 2016 at 11:17 AM, Daniel Baluta <daniel.baluta@intel.com> wrote:
>> +
>> +static const struct i2c_device_id ads1015_id[] = {
>> +       {"ads1015", 0},
>> +       {}
>> +};
>
> Since this module is not 100% compatible with the hwmon version,
> wouldn't it be better to use another id?

Hmm, as it is now it should be 100% compatible with the hwmon driver
for ads1015 device.

I don't have a strong preference for id here. Do you see any problems using
this id?

>
> Other than that, I tested it on the MinnowBoard Max with a Drone Lure
> connected and it works fine.

thanks,
Daniel.
