Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58922 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757AbbHTWCq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 20 Aug 2015 18:02:46 -0400
Subject: Re: [PATCH 13/18] iio: adc: mcp320x: Set struct spi_driver
 .of_match_table
To: Michael Welling <mwelling@ieee.org>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-14-git-send-email-javier@osg.samsung.com>
 <20150820200912.GA2866@deathstar>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Andrea Galbusera <gizero@gmail.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Manfred Schlaegl <manfred.schlaegl@gmx.at>,
	=?UTF-8?Q?S=c3=b8ren_Andersen?= <san@rosetechnology.dk>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Message-ID: <55D64E80.4050502@osg.samsung.com>
Date: Fri, 21 Aug 2015 00:02:40 +0200
MIME-Version: 1.0
In-Reply-To: <20150820200912.GA2866@deathstar>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Michael,

On 08/20/2015 10:09 PM, Michael Welling wrote:
> On Thu, Aug 20, 2015 at 09:07:26AM +0200, Javier Martinez Canillas wrote:
>> The driver has an OF id table but the .of_match_table is not set so
>> the SPI core can't do an OF style match and the table was unused.
>>
> 
> Is an OF style match necessary?
>

Did you read the cover letter [0] on which I explain why is needed to
avoid breaking module autoloading in the future? Once the SPI core is
changed by RFC patch 18/18? (you were cc'ed in the cover letter BTW).

> I have been using devicetree and it matches based on the .id_table.
>

Yes it fallbacks to the .id_table or the driver name but the correct
thing to do for devices registered by OF, is to match using the
compatible string.

> Couldn't we just remove the mcp320x_dt_ids table instead?
>

No, that is the wrong thing to do IMHO since the compatible string
contains both vendor and device name whle the .id_table only contains
a device name.

So it makes sense to match using the compatible string and also report
the OF modalias information to user-space.

Otherwise what's the point of the vendor in the compatible string for
SPI devices? You can just use "bar" instead of "foo,bar" as a string.

[0]: https://lkml.org/lkml/2015/8/20/109

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
