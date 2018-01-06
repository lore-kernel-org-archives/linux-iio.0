Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753071AbeAFNTQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 08:19:16 -0500
Date: Sat, 6 Jan 2018 13:19:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Tatschner <stefan.tatschner@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio/bmp280-core.c: Read calibration data in probe
Message-ID: <20180106131911.15115c66@archlinux>
In-Reply-To: <20180103201345.GA22204@kronos>
References: <20171212180610.GF2590@arbeit>
        <20171212203537.8204-1-stefan.tatschner@gmail.com>
        <20171229184855.2604fd55@archlinux>
        <20180103201345.GA22204@kronos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 3 Jan 2018 21:13:45 +0100
Stefan Tatschner <stefan.tatschner@gmail.com> wrote:

> On Fri, Dec 29, 2017 at 06:48:55PM +0000, Jonathan Cameron wrote:
> > On Tue, 12 Dec 2017 21:35:37 +0100
> > Stefan Tatschner <stefan.tatschner@gmail.com> wrote:
> >   
> > > This patch affects BME280 and BMP280. The readout of the calibration
> > > data is moved to the probe function. Each sensor data access triggered
> > > reading the full calibration data before this patch. According to the
> > > datasheet, Section 4.4.2., the calibration data is stored in non-volatile
> > > memory.
> > > 
> > > Since the calibration data does not change, and cannot be changed by the
> > > user, we can reduce bus traffic by reading the calibration data once.
> > > Additionally, proper organization of the data types enables removing
> > > some odd casts in the compensation formulas.
> > > 
> > > Signed-off-by: Stefan Tatschner <stefan.tatschner@gmail.com>  
> > One minor inline. Will fix whilst applying as it's just comment syntax.  
> 
> Sorry for that. I fired off checkpatch.pl and it didn't complain. I
> remember that, for network code or something, it complains about comment
> style...
> 
> > This was headache inducing to check.  Glad you got to write it ;)
> > 
> > I've also dropped the entropy add that was in here. It should be proposed
> > as a separate patch rather than in here. Particularly as it isn't mentioned
> > in the commit message.  
> 
> If that makes sense for you, I'll send a further patch.

I think it makes reasonable sense so send a patch adding that on it's own
and we'll consider it then.

> 
> > Applied to the togreg branch of iio.git and pushed out as testing for
> > the autobuilders to play with it.  
> 
> Thanks!
> 
> Stefan

