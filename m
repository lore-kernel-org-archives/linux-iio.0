Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34680 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752580AbdATPgc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 10:36:32 -0500
Received: by mail-io0-f179.google.com with SMTP id l66so64011808ioi.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Jan 2017 07:36:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170120142242.GC5241@amd>
References: <20170116225436.17505-1-robh@kernel.org> <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com>
 <20170120142242.GC5241@amd>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Jan 2017 16:26:20 +0100
Message-ID: <CACRpkdYi=OQ2fyvOvmo+8b4nAOsSjW_-EdHXyGnYf2PNZB5C9Q@mail.gmail.com>
Subject: Re: GPS drivers (was Re: [PATCH v2 0/9] Serial slave device bus)
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sebastian Reichel <sre@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Loic Poulain <loic.poulain@intel.com>,
        NeilBrown <neil@brown.name>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

oOn Fri, Jan 20, 2017 at 3:22 PM, Pavel Machek <pavel@ucw.cz> wrote:

> Switched subject: Rob's work is great for GPS and bluetooth, but this
> goes beyond it.

Sure why not talk around a bit.

>> In my simple opinion GPSes shound live in drivers/iio/gps simply by
>> usecase association: streaming out a series of accelerometer readings
>> periodically through IIOs chardevs and other data about the physical
>> world is not any different from the GPS usecase that give you a stream
>> of coordinates on where on this planet you are.
>
> That is... not quite how GPSes work. What interface would you propose?
> It would be good to support error estimates in position/velocities and
> AGPS data upload.

Sorry for my ignorance. I have not had the opportunity to work
directly with a GPS hardware.

> Now, NMEA knows about some of the complexity (not AGPS), but gets the
> details wrong. In particular, it would be good to have error estimates
> and velocities from the same moment you get position estimates.

NMEA if it is this:
https://en.wikipedia.org/wiki/NMEA_0183

Seems to be a high-level format such as XML or CSV or any other
$FAVOURITE_ASCII_TRANSPORT format.

What we want to push into the ring buffer is of course the raw data
that is produced by the GPS hardware, whatever that may be.
If what we have is this text format we should not reverse-translate
it back any more than modem AT commands, it doesn't make sense
I guess.

So NMEA processing would be in userspace. And if the GPS is just
streaming this text data over to the client, like Marcel says, it is
more reasonable to just feed that up to userspace (no policy in the
kernel).

I am however aware of certain hardware such as the ST
Microelectronis STA2062 produced for Garmin, which is *not*
connected to any external chip, and is not talking over serial
to any RSx port, and does not have an embedded firmware running
on another SoC in any special GPS chip. And it is unassisted.

Maybe that is an oddity. In the mobile phone business I guess it
could be more common to have a separate SoC that by way
of standards just stream NMEA data.

Fusing that with other sensor data (accelerometer, compass, etc)
is again indeed a userspace task. I hope NMEA includes very good
timestamps.

Thanks,
Linus Walleij
