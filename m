Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48163 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbcHOTnc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 15:43:32 -0400
Date: Mon, 15 Aug 2016 12:43:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Florian Lobmaier <Florian.Lobmaier@ams.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Elitsa Polizoeva <Elitsa.Polizoeva@ams.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jean Delvare <jdelvare@suse.de>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH V4 1/1] iio: as6200: add AS6200 temperature sensor driver
 from ams AG
Message-ID: <20160815194327.GA4400@roeck-us.net>
References: <4ace1394d6064ab2b7dd4a5335cc1a7c@SUX5076.office.amsiag.com>
 <14a70eac-eed6-426f-d22d-ccc79ccf5ebb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14a70eac-eed6-426f-d22d-ccc79ccf5ebb@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 15, 2016 at 06:25:44PM +0100, Jonathan Cameron wrote:
> On 04/08/16 09:35, Florian Lobmaier wrote:
> > Hello Peter,
> > 
> > Thanks again for your valuable feedback. We use now IIO_EV_THRESH to
> > set high and low limits for temperature. Also removed all the custom
> > ABI as this are mainly settings which will be set one-time only. For
> > the removed custom ABI init defines where introduced which will be
> > written to the registers in the probe function. The remaining custom
> > ABI is now documented as well as the device tree bindings.> 
> > Br,
> > Florian
> > 
> > Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>
> > Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
> Please post as a fresh email thread with a clean title. Otherwise
> people will assume it is simply a reply to a comment on an earlier
> version.  Also don't include earlier versions as you have here!
> 
> i.e. drop the RE from the title as it's confusing!
> 
> Anyhow, right back at v1 Peter mentioned that this might be more
> suitable as a hwmon driver than an IIO one.  If you have a good reason
> for supporting this part via IIO you should put it in the patch
> description. I'm afraid I've been more or less offline for the last
> couple fo weeks or I'd have highlighted that this question was
> important. A superficial look suggest to me that this is definitely
> a part targeting hardware monitoring applications.
> 
Conversion time, conversion rate, the presence of limit registers,
and the intended use cases suggest that this should be a hardware
monitoring driver.

Regarding the attributes, most of those would be standard attributes
in a hwmon driver. "alarm polarity" should be a  devicetree / platform
data configuration parameter, and interrupt vs. comparator mode could
be determined based on the presence of an interrupt line.

> I'll only take a border line part with agreement form Guenter / Jean
> who are the hwmon maintainers.
> 
> I'll do a quick review ignoring this question.
> Mostly pretty good though I really don't like the remaining
> custom ABI. Can't see a reason for its existence.

Me not either.

Guenter
