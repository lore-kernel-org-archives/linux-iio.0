Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:59692 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdATOOH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 09:14:07 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 0/9] Serial slave device bus
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com>
Date: Fri, 20 Jan 2017 15:14:04 +0100
Cc: Rob Herring <robh@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sebastian Reichel <sre@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Loic Poulain <loic.poulain@intel.com>,
        Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <41321720-85FD-4CC0-8710-BB044DA37F6F@holtmann.org>
References: <20170116225436.17505-1-robh@kernel.org>
 <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Linus,

>> There's still some discussion about what to do with devices that pass thru
>> data to userspace unmodified like GPS and could still use tty device for
>> the data path. IMO, we should treat this as a separate problem following
>> this series. Drivers we want to convert to serdev and already in the
>> kernel don't need this functionality.
> 
> In my simple opinion GPSes shound live in drivers/iio/gps simply by
> usecase association: streaming out a series of accelerometer readings
> periodically through IIOs chardevs and other data about the physical
> world is not any different from the GPS usecase that give you a stream
> of coordinates on where on this planet you are.
> 
> The fact that vendors like to defer GPS processing to userspace because
> it is considered "secret sauce" is not the concern of the kernel community,
> though problems like that in general is the great tragedy of our time.
> 
> It would be fun to see a pure, reverse-engineered GPS driver in IIO.

except for the pure NMEA devices. Which are pretty much defined as terminal devices using RS422 and 4800 baud. For anything non-NMEA, I would agree that using IIO might be a good option. So instead of a GPS subsystem, might just have a GPS class / type in the IIO subsystem.

Regards

Marcel

