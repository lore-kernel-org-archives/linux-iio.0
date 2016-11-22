Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:35474 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756789AbcKVU6X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2016 15:58:23 -0500
Subject: Re: [PATCH v3 0/7] mux controller abstraction and iio/i2c muxes
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1479734235-18837-1-git-send-email-peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b132143c-259b-6ed2-58c5-b223cc2e72df@metafoo.de>
Date: Tue, 22 Nov 2016 21:58:12 +0100
MIME-Version: 1.0
In-Reply-To: <1479734235-18837-1-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/21/2016 02:17 PM, Peter Rosin wrote:
[...]
> I have a piece of hardware that is using the same 3 GPIO pins
> to control four 8-way muxes. Three of them control ADC lines
> to an ADS1015 chip with an iio driver, and the last one
> controls the SDA line of an i2c bus. We have some deployed
> code to handle this, but you do not want to see it or ever
> hear about it. I'm not sure why I even mention it. Anyway,
> the situation has nagged me to no end for quite some time.
> 
> So, after first getting more intimate with the i2c muxing code
> and later discovering the drivers/iio/inkern.c file and
> writing a couple of drivers making use of it, I came up with
> what I think is an acceptable solution; add a generic mux
> controller driver (and subsystem) that is shared between all
> instances, and combine that with an iio mux driver and a new
> generic i2c mux driver. The new i2c mux I called "simple"
> since it is only hooking the i2c muxing and the new mux
> controller (much like the alsa simple card driver does for ASoC).

While abstracting this properly is all nice and good and the way it should
be done, but it also adds a lot of complexity and the devicetree adds a lot
of restrictions on what can actually be represented.

There is a certain point where the fabric on a PCB becomes so complex that
it deserves to be a device on its own (like the audio fabric drivers).
Especially when the hardware is built with a certain application in mind and
the driver is supposed to impose policy which reflects this application. The
latter can often not properly be described with the primitives the
devicetree can offer.

And I think your setup is very borderline what can be done in a declarative
way only and it adds a lot of complexity over a more imperative solution in
form of a driver. I think it is worth investigating about having a driver
that is specific to your fabric and handles the interdependencies of the
discrete components.
