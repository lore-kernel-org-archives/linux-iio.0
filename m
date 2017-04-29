Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx-out-1.rwth-aachen.de ([134.130.5.186]:38322 "EHLO
        mx-out-1.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035207AbdD2Uha (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Apr 2017 16:37:30 -0400
From: Stefan Bruens <stefan.bruens@rwth-aachen.de>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>
Subject: Re: [PATCH 2/2] iio: adc: Allow setting Shunt Voltage PGA gain and Bus Voltage range
Date: Sat, 29 Apr 2017 22:37:27 +0200
Message-ID: <9342701.uSTzCLhmiO@pebbles.site>
In-Reply-To: <5135aead-65d6-35b2-8fed-f8ed2024cd51@kernel.org>
References: <20170412030140.9328-1-stefan.bruens@rwth-aachen.de> <c94eddda-9d22-2f9a-a31d-9c7ae5e58440@kernel.org> <5135aead-65d6-35b2-8fed-f8ed2024cd51@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mittwoch, 26. April 2017 08:59:47 CEST Jonathan Cameron wrote:
> On 26/04/17 07:19, Jonathan Cameron wrote:
> > On 17/04/17 23:08, Stefan Bruens wrote:
> >> On Freitag, 14. April 2017 17:12:03 CEST Jonathan Cameron wrote:
[...]
> > 
> >> 4. Any user of the gain settings had to be made aware of the possibility
> >> to
> >> change it, no matter how it is exposed. Making it part of the scale, and
> >> thus changing the meaning of the raw values, would be breaking the
> >> existing ABI.> 
> > The raw values should indeed not change.  That was a missunderstanding on
> > my part.  Usually when a device has a PGA it is not compensated for in
> > the output. So normally it's up to the driver to 'apply' the effective
> > gain to the incoming reading.  When that isn't the case, it can be
> > considered some sort of internal trim - hence the use of calibscale for
> > this case.
> Mulling this over, calibscale might not work either in this case. The
> datasheet helpfully sometimes uses ranges and sometimes uses scale factors.
> There is also obviously the calibration register kicking around which would
> also be handled with calibscale if exposed to userspace (currently it isn't)
> 
> I'm out of time tonight so will think it bit more about this and get back to
> you in the next few days...

hardwaregain may be a viable option. For the shunt voltage, available values 
would be [0.125, 0.25, 0.5, 1.0], for the bus range we would have either [0.5, 
1.0] or [1.0, 2.0] for bus ranges [32V, 16V].

Does hardwaregain have the right semantics for shunt voltage gain and/or bus 
range?

Kind regards,

Stefan

-- 
Stefan Brüns  /  Bergstraße 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
work: +49 2405 49936-424
