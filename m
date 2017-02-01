Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:44946
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752589AbdBAVPD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2017 16:15:03 -0500
Subject: Re: [PATCH v9 6/8] drivers:input:ads7846(+tsc2046): fix spi module
 table
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <cover.1482936802.git.hns@goldelico.com>
 <c79bdd79a22dab877b8a80136ac253c951698745.1482936802.git.hns@goldelico.com>
 <20170128193558.GC38136@dtor-ws>
 <F39E49DD-45AF-4491-A26E-F3A9D86F30F6@goldelico.com>
 <20170129180108.GA10743@dtor-ws>
 <A169CC1E-9EC9-43CA-887B-1382F1903CE1@goldelico.com>
 <B64DBFB0-62E8-4B4C-957F-C90C33BEF693@goldelico.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Michel Verlaan <michel.verl@gmail.com>,
        Nick Dyer <nick@shmanahar.org>,
        Tony Lindgren <tony@atomide.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Engestrom <eric@engestrom.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Petr Cvek <petr.cvek@tul.cz>,
        Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-iio@vger.kernel.org,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        kernel@pyra-handheld.com, Michael Welling <mwelling@ieee.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>
Message-ID: <cc403765-9b88-1424-a77f-36e775fbd5a0@osg.samsung.com>
Date: Wed, 1 Feb 2017 18:14:39 -0300
MIME-Version: 1.0
In-Reply-To: <B64DBFB0-62E8-4B4C-957F-C90C33BEF693@goldelico.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Nikolaus,

On 02/01/2017 05:20 PM, H. Nikolaus Schaller wrote:
> Hi Dmitry, Javier,
> 
>> Am 29.01.2017 um 19:25 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
>>
>> Hi Dmitry,
>>
>>> Am 29.01.2017 um 19:01 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>>
>>> On Sun, Jan 29, 2017 at 09:39:39AM +0100, H. Nikolaus Schaller wrote:
>>>> Hi Dmitry,
>>>>
>>>>> Am 28.01.2017 um 20:35 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>>>>
>>>>> On Wed, Dec 28, 2016 at 03:53:21PM +0100, H. Nikolaus Schaller wrote:
>>>>>> Fix module table so that the driver is loaded if compiled
>>>>>> as module and requested by DT.
>>>>>>
>>>>>
>>>>> I believe I already replied to a similar patch: we alreadyhave necessary
>>>>> aliases in this driver, we need to fix module loading to use it.
>>>>
>>>> Yes, you did comment on [PATCH v6 7/8] (19 Nov 2016):
>>>>
>>>>>> We really need to fix it between spi/i23c core and module utils instead
>>>>>> of keeping adding duplicate IDs all over drivers. We already have OF
>>>>>> module device table containing the same data, we should be able to use
>>>>>> it.
>>>>
>>>> And Javier Martinez Canillas replied (23 Nov 2016):
>>>>
>>>>> Agreed, unfortunately until the I2C and SPI core are changed to properly
>>>>> report OF modaliases, we will have to keep adding these duplicated IDs.
>>>>>
>>>>> And changing the I2C and SPI core isn't trivial since it could break a
>>>>> lot of drivers that rely on a platform modalias being reported (i.e: no
>>>>> OF device IDs present in the drivers even when are registered via DT).
>>>>
>>>> Therefore I didn't see a need to change it.
>>>
>>> I agree that changing I2C and SPI core is not trivial, however this is
>>> no reason for piling up workarounds in all drivers. Are you seriously
>>> advocating going though *every* driver and copying OF data into I2C/SPI
>>> instead of doing the right thing and fixing the root of the issue?
>>
>> If you prefer to have this done (and I agree it would be a tiny improvement),
>> please do it for us all. But please after merging this workaround.
> 
> Have we been lucky to find someone who is able and willing to work on this?
>

As said, changing the core is trivial. A RFC patch is [0].

The problem is how to make sure that this change won't cause regressions
in existing drivers.

There was particularly tricky for the spi-nor driver, it doesn't help that
a lot of DT are using undocumented compatible strings (sometimes with no
vendor prefix). You can see the discussion here [1].

In the same thread Mark Brown said that it wasn't that bad to have the
information in the OF device ID table duplicated in a SPI device table.

Certainly isn't the best approach but IMHO is better than the module not
loading.

https://patchwork.kernel.org/patch/7041141/
https://patchwork.ozlabs.org/patch/545125/
 
> If not, I'd recommend to stay with the current level of optimality.
> 
> BR and thanks,
> Nikolaus
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
