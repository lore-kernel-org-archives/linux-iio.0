Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:48403
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936078AbcKWNWw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2016 08:22:52 -0500
Subject: Re: [PATCH v6 7/8] drivers:input:ads7846(+tsc2046): fix spi module
 table
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
References: <cover.1477557860.git.hns@goldelico.com>
 <54f282e1adebeeb133687b6c430ecbb6f2fe6d5b.1477557860.git.hns@goldelico.com>
 <20161119181824.GB20446@dtor-ws>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sangwon Jee <jeesw@melfas.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, letux-kernel@openphoenux.org,
        linux-iio@vger.kernel.org, kernel@pyra-handheld.com
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <cc450963-16f9-10e6-a8c4-3b4e4771248e@osg.samsung.com>
Date: Wed, 23 Nov 2016 10:12:06 -0300
MIME-Version: 1.0
In-Reply-To: <20161119181824.GB20446@dtor-ws>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Dmitry,

On 11/19/2016 03:18 PM, Dmitry Torokhov wrote:
> On Thu, Oct 27, 2016 at 10:44:20AM +0200, H. Nikolaus Schaller wrote:
>> Fix module table so that the driver is loaded if compiled
>> as module and requested by DT.
> 
> We really need to fix it between spi/i23c core and module utils instead
> of keeping adding duplicate IDs all over drivers. We already have OF
> module device table containing the same data, we should be able to use
> it.
> 

Agreed, unfortunately until the I2C and SPI core are changed to properly
report OF modaliases, we will have to keep adding these duplicated IDs.

And changing the I2C and SPI core isn't trivial since it could break a
lot of drivers that rely on a platform modalias being reported (i.e: no
OF device IDs present in the drivers even when are registered via DT).

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
