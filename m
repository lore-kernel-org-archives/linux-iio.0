Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2.gnudd.com ([213.203.150.91]:53126 "EHLO mail.gnudd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759649Ab3BZWzg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 26 Feb 2013 17:55:36 -0500
Date: Tue, 26 Feb 2013 23:48:05 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: jic23@jic23.retrosnub.co.uk
Cc: Carsten.Frank@haw-hamburg.de, linux-iio@vger.kernel.org
Subject: Re: driver interface for usb spectrometer (like OceanOptics)
Message-ID: <20130226224805.GA5448@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <512CDF35.8070204@jic23.retrosnub.co.uk>
References: <512CDF35.8070204@jic23.retrosnub.co.uk>
  <5127353B.1040801@haw-hamburg.de> <512B381C.1030201@metafoo.de>
 <512C904A.10703@haw-hamburg.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>> I did look up the IIO API and userspace ABI and I do not see a good fit.
>> However,
>> 1. I may be wrong
> My gut feeling is that there 'ought to be a better option'.

FWIW I tend to agree.  IIO is designed for input devices that feature
small sample sizes with individual timestamps and relatively few
configuration parameters.  I don't think it's wise to continuosly add
new data types.

There already is a framework that covers every possible input device,
and even output. It's called char driver.

> [...]
> If you handled this in IIO I think you'd have to have a matched chunk
> of userspace code that knows rather a lot about the sensor.  Normally
> we'd do a our best to avoid this and as such I suspect that
> these devices really deserve a more specific home.

Exactly. It's great to treat all accelerometers alike, and all
magnetometers alike. That's the kind of device you have in modern
cell phones and supporting all chip vendors with the same interface
is definitely useful. In this case, I see the thing as a custom char
device, where the application knows what it gets.

/alessandro
