Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26972 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752663AbdATQTp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 20 Jan 2017 11:19:45 -0500
Message-ID: <1484928971.2133.273.camel@linux.intel.com>
Subject: Re: GPS drivers (was Re: [PATCH v2 0/9] Serial slave device bus)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
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
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Loic Poulain <loic.poulain@intel.com>,
        NeilBrown <neil@brown.name>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 20 Jan 2017 18:16:11 +0200
In-Reply-To: <CACRpkdYi=OQ2fyvOvmo+8b4nAOsSjW_-EdHXyGnYf2PNZB5C9Q@mail.gmail.com>
References: <20170116225436.17505-1-robh@kernel.org>
         <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com>
         <20170120142242.GC5241@amd>
         <CACRpkdYi=OQ2fyvOvmo+8b4nAOsSjW_-EdHXyGnYf2PNZB5C9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2017-01-20 at 16:26 +0100, Linus Walleij wrote:

> > Now, NMEA knows about some of the complexity (not AGPS), but gets
> > the
> > details wrong. In particular, it would be good to have error
> > estimates
> > and velocities from the same moment you get position estimates.
> 
> NMEA if it is this:
> https://en.wikipedia.org/wiki/NMEA_0183
> 
> Seems to be a high-level format such as XML or CSV or any other
> $FAVOURITE_ASCII_TRANSPORT format.

Not exactly. It depends on device settings.
Old GPS I used to play with have AT command to switch between ASCII and
binary format. Some of the devices might use non-standard binary
protocols (however, representable as NMEA), etc.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
