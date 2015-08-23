Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35452 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbbHWWKm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 Aug 2015 18:10:42 -0400
MIME-Version: 1.0
In-Reply-To: <55D8B605.4040302@kernel.org>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-14-git-send-email-javier@osg.samsung.com>
 <20150820200912.GA2866@deathstar> <55D64E80.4050502@osg.samsung.com>
 <20150820222906.GB28249@deathstar> <55D65937.6070909@osg.samsung.com> <55D8B605.4040302@kernel.org>
From: Rob Herring <robherring2@gmail.com>
Date: Sun, 23 Aug 2015 17:10:22 -0500
Message-ID: <CAL_Jsq+_ET8O=vQirFutY5sF7rkK-qF_1uTAroto2dZzC4ugWA@mail.gmail.com>
Subject: Re: [PATCH 13/18] iio: adc: mcp320x: Set struct spi_driver .of_match_table
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Michael Welling <mwelling@ieee.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrea Galbusera <gizero@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Manfred Schlaegl <manfred.schlaegl@gmx.at>,
	=?UTF-8?Q?S=C3=B8ren_Andersen?= <san@rosetechnology.dk>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Aug 22, 2015 at 12:48 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 20/08/15 23:48, Javier Martinez Canillas wrote:
>> Hello Michael,
>>
>> On 08/21/2015 12:29 AM, Michael Welling wrote:
>>> On Fri, Aug 21, 2015 at 12:02:40AM +0200, Javier Martinez Canillas wrote:
>>>> Hello Michael,
>>>>
>>>> On 08/20/2015 10:09 PM, Michael Welling wrote:
>>>>> On Thu, Aug 20, 2015 at 09:07:26AM +0200, Javier Martinez Canillas wrote:
>>>>>> The driver has an OF id table but the .of_match_table is not set so
>>>>>> the SPI core can't do an OF style match and the table was unused.
>>>>>>
>>>>>
>>>>> Is an OF style match necessary?
>>>>>
>>>>
>>>> Did you read the cover letter [0] on which I explain why is needed to
>>>> avoid breaking module autoloading in the future? Once the SPI core is
>>>> changed by RFC patch 18/18? (you were cc'ed in the cover letter BTW).
>>>
>>> Well I have read it now. :)
>>>
>>
>> Great :)
>>
>>>>
>>>>> I have been using devicetree and it matches based on the .id_table.
>>>>>
>>>>
>>>> Yes it fallbacks to the .id_table or the driver name but the correct
>>>> thing to do for devices registered by OF, is to match using the
>>>> compatible string.
>>>>
>>>>> Couldn't we just remove the mcp320x_dt_ids table instead?
>>>>>
>>>>
>>>> No, that is the wrong thing to do IMHO since the compatible string
>>>> contains both vendor and device name whle the .id_table only contains
>>>> a device name.
>>>>
>>>> So it makes sense to match using the compatible string and also report
>>>> the OF modalias information to user-space.
>>>>
>>>> Otherwise what's the point of the vendor in the compatible string for
>>>> SPI devices? You can just use "bar" instead of "foo,bar" as a string.
>>>>
>>>
>>> Well then shouldn't the patch include adding the vendor to the compatible
>>> string?
>>>
>>
>> Well, I was talking in general. You are right that this specific driver does
>> not have a vendor prefix for the compatible strings. This is incorrect
>> according to the ePAPR document [0].
>>
>> However, these compatible strings are already documented as a DT binding doc
>> in Documentation/devicetree/bindings/iio/adc/mcp320x.txt so I don't know
>> what is the correct thing to do in this situation.
> Take the view the old version is wrong but needs to be supported and add also
> the corrected strings + document them.
>
> cc'd The device tree list for any more comments on this.

Agreed. Document both and mark the old one deprecated.

Rob
