Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:38185 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeEGQoc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 May 2018 12:44:32 -0400
Subject: Re: [PATCH] iio: potentiometer: add driver for Maxim Integrated
 DS1807
To: Jonathan Cameron <jic23@kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <1525613447-32734-1-git-send-email-michael@amarulasolutions.com>
 <20180506183745.325e67b8@archlinux>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <96251f75-6a0b-9668-b103-8d2453bf8bba@metafoo.de>
Date: Mon, 7 May 2018 18:44:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180506183745.325e67b8@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/2018 07:37 PM, Jonathan Cameron wrote:
> On Sun,  6 May 2018 15:30:47 +0200
> Michael Trimarchi <michael@amarulasolutions.com> wrote:
> 
>> The following functions are supported:
>> - write, read potentiometer value
>>
>> Value are exported in DBm because it's used as an audio
>> attenuator
> 
> This is interesting.  The problem is that there is no way for
> userspace to know that it is reporting in DBm rather than
> reporting a linear gain or a straight forward resistance.
> 
> This is rather closer in operation to the analog front end
> driver I took the other day than to the other potentiometers
> we have drivers for.
> 
> Anyhow, how to solve this?  Two options come to mind.
> 1) Look up table mapping to linear gain as per current ABI
> 2) Add a new channel type to represent the fact we are
> looking at a logarithmic value, letting us handle it as DB.

Yeah, I guess it is a bit difficult. I don't think this should be a separate
type since we are still describing the same thing, just the scale is
logarithmic rather than linear. Translation table doesn't work either since
your values would get ridiculous small/large. We could add a db suffix to
the type, but that's just terrible. I guess the best we can do is have a
scale attribute that says 1dB.

On the other hand we could ask whether this should be a IIO driver since the
device seems to very application specific for audio. If it is only ever
going to be used in an audio subsystem you'd probably want to make this an
ALSA driver, so you can easily integrate it and don't have to write an
additional bridge driver. ALSA for example has native support for
logarithmic controls.
