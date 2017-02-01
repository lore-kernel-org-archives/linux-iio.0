Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:45440
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753172AbdBAWub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2017 17:50:31 -0500
Subject: Re: [PATCH v9 6/8] drivers:input:ads7846(+tsc2046): fix spi module
 table
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <cover.1482936802.git.hns@goldelico.com>
 <c79bdd79a22dab877b8a80136ac253c951698745.1482936802.git.hns@goldelico.com>
 <20170128193558.GC38136@dtor-ws>
 <F39E49DD-45AF-4491-A26E-F3A9D86F30F6@goldelico.com>
 <20170129180108.GA10743@dtor-ws>
 <A169CC1E-9EC9-43CA-887B-1382F1903CE1@goldelico.com>
 <B64DBFB0-62E8-4B4C-957F-C90C33BEF693@goldelico.com>
 <cc403765-9b88-1424-a77f-36e775fbd5a0@osg.samsung.com>
 <20170201222832.GA25554@dtor-ws>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <8810e197-f071-5a3d-c376-8c365fb60640@osg.samsung.com>
Date: Wed, 1 Feb 2017 19:50:16 -0300
MIME-Version: 1.0
In-Reply-To: <20170201222832.GA25554@dtor-ws>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Dmitry,

On 02/01/2017 07:28 PM, Dmitry Torokhov wrote:

[snip]

>>
>> As said, changing the core is trivial. A RFC patch is [0].
>>
>> The problem is how to make sure that this change won't cause regressions
>> in existing drivers.
> 
> If the concern with drivers having I2C or SPI device table, but not OF
> device table, then I think cocinnelle could be used to scan and find
> them.
>

I don't think coccinelle is a good fit for this since you may have to look if
a DTS is using in its compatible string a device that's in an SPI table or if
a DT binding documents this device as a compatible string.

But yes I get your point and I agree that is just a matter of having a script
to look for these. Someone should have the time to write it though :)

>>
>> There was particularly tricky for the spi-nor driver, it doesn't help that
>> a lot of DT are using undocumented compatible strings (sometimes with no
>> vendor prefix). You can see the discussion here [1].
>>
>> In the same thread Mark Brown said that it wasn't that bad to have the
>> information in the OF device ID table duplicated in a SPI device table.
>>
>> Certainly isn't the best approach but IMHO is better than the module not
>> loading.
> 
> You can always build the module into kernel or load it by hand if it is
> that important. Module autoloading does not work anyway if you have
> several compatible strings, like
> 
> 	compatible = "vendor,new-device", "vendor,generic-device";
> 
> Thanks.
>

Agree.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
