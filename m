Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751212AbeA1Jid (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jan 2018 04:38:33 -0500
Date: Sun, 28 Jan 2018 09:38:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFP] iio: Support of gesture sensor as a standard IIO sensor
Message-ID: <20180128093829.1b1d9336@archlinux>
In-Reply-To: <20180128084003.GA23818@amd>
References: <1515197240.26317.65.camel@intel.com>
        <20180118224026.GE17196@amd>
        <20180120151908.1d438aaf@archlinux>
        <1516480282.15527.4.camel@intel.com>
        <20180127220931.GA19668@amd>
        <1517093714.6759.6.camel@intel.com>
        <20180128084003.GA23818@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 28 Jan 2018 09:40:03 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> hi!
> 
> > > > Correct. This will depend on  the firmware expected format . I
> > > > think
> > > > ultimately it will be standardized.  
> > > Is it fair to say that "expected" format is some kind of bytecode for
> > > CPU in the gesture sensor?  
> > Not necessarily a byte code to execute on the CPU in the gesture
> > sensor, but a format the code running on that CPU understands the way
> > gestures are formatted.
> > But it can be byte code for some manufacturers, so idea is just pass to
> > the firmware and let it process it an opaque format.  
> 
> It would be really good to figure out common format for different
> sensors. Otherwise kernel is not providing proper hardware
> abstraction.
> 
> 									Pavel

A common format, if it is byte code, would require in kernel compilers
for the various sensors.  Not going to happen.

Common format for everything other than the 'load magic firmware' part
might be doable. As in we can describe what the magic firmware is
doing...

Jonathan
