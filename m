Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39308 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbcBFKwL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 05:52:11 -0500
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
To: Daniel Baluta <daniel.baluta@intel.com>,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
 <CAKi4VALtv3+_SjRG=_gmfpH=EN6D=DJJ9W8MHiCiADn56ber+A@mail.gmail.com>
 <CAEnQRZD6n5ZdgPGA7pD6_Od_FwP=hn5mKcA5WJ3daUGuJBcSvw@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Michael Welling <mwelling@ieee.org>,
	Guenter Roeck <linux@roeck-us.net>, eibach@gdsys.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B5D057.2090208@kernel.org>
Date: Sat, 6 Feb 2016 10:52:07 +0000
MIME-Version: 1.0
In-Reply-To: <CAEnQRZD6n5ZdgPGA7pD6_Od_FwP=hn5mKcA5WJ3daUGuJBcSvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/16 21:44, Daniel Baluta wrote:
> On Fri, Feb 5, 2016 at 11:02 PM, Lucas De Marchi
> <lucas.de.marchi@gmail.com> wrote:
>> Hi Daniel,
>>
>> On Fri, Feb 5, 2016 at 11:17 AM, Daniel Baluta <daniel.baluta@intel.com> wrote:
>>> +
>>> +static const struct i2c_device_id ads1015_id[] = {
>>> +       {"ads1015", 0},
>>> +       {}
>>> +};
>>
>> Since this module is not 100% compatible with the hwmon version,
>> wouldn't it be better to use another id?
> 
> Hmm, as it is now it should be 100% compatible with the hwmon driver
> for ads1015 device.
> 
> I don't have a strong preference for id here. Do you see any problems using
> this id?
We definitely want to keep the ID if at all possible as otherwise
we end up with a driver choice having to be made at compile time (or possibly
via the device tree).  If there is a compatibility issue, then Lucas,
please highlight it.

In the short term both drivers will exist and we'll rely on the Kconfig tricks
above to prevent them being both built.  Longer term, if this driver supports
all features of the HWMON driver (via the iio-hwmon bridge) then then extra
support in here will make it sensible to drop the HWMON driver (just not for
at least a cycle or two I would guess).

Jonathan
> 
>>
>> Other than that, I tested it on the MinnowBoard Max with a Drone Lure
>> connected and it works fine.
> 
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

