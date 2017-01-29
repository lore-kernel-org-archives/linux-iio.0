Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34875 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdA2SBM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2017 13:01:12 -0500
Date: Sun, 29 Jan 2017 10:01:08 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Eric Engestrom <eric@engestrom.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Petr Cvek <petr.cvek@tul.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Nick Dyer <nick@shmanahar.org>,
        Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
        Michel Verlaan <michel.verl@gmail.com>,
        linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com
Subject: Re: [PATCH v9 6/8] drivers:input:ads7846(+tsc2046): fix spi module
 table
Message-ID: <20170129180108.GA10743@dtor-ws>
References: <cover.1482936802.git.hns@goldelico.com>
 <c79bdd79a22dab877b8a80136ac253c951698745.1482936802.git.hns@goldelico.com>
 <20170128193558.GC38136@dtor-ws>
 <F39E49DD-45AF-4491-A26E-F3A9D86F30F6@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F39E49DD-45AF-4491-A26E-F3A9D86F30F6@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jan 29, 2017 at 09:39:39AM +0100, H. Nikolaus Schaller wrote:
> Hi Dmitry,
> 
> > Am 28.01.2017 um 20:35 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > 
> > On Wed, Dec 28, 2016 at 03:53:21PM +0100, H. Nikolaus Schaller wrote:
> >> Fix module table so that the driver is loaded if compiled
> >> as module and requested by DT.
> >> 
> > 
> > I believe I already replied to a similar patch: we alreadyhave necessary
> > aliases in this driver, we need to fix module loading to use it.
> 
> Yes, you did comment on [PATCH v6 7/8] (19 Nov 2016):
> 
> >> We really need to fix it between spi/i23c core and module utils instead
> >> of keeping adding duplicate IDs all over drivers. We already have OF
> >> module device table containing the same data, we should be able to use
> >> it.
> 
> And Javier Martinez Canillas replied (23 Nov 2016):
> 
> > Agreed, unfortunately until the I2C and SPI core are changed to properly
> > report OF modaliases, we will have to keep adding these duplicated IDs.
> > 
> > And changing the I2C and SPI core isn't trivial since it could break a
> > lot of drivers that rely on a platform modalias being reported (i.e: no
> > OF device IDs present in the drivers even when are registered via DT).
> 
> Therefore I didn't see a need to change it.

I agree that changing I2C and SPI core is not trivial, however this is
no reason for piling up workarounds in all drivers. Are you seriously
advocating going though *every* driver and copying OF data into I2C/SPI
instead of doing the right thing and fixing the root of the issue?

Thanks.

-- 
Dmitry
