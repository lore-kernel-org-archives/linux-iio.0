Return-Path: <vivien.didelot@savoirfairelinux.com>
Date: Mon, 25 Jul 2011 14:48:15 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Greg KH <greg@kroah.com>, "Hennerich,
 Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] staging: (iio) restore macro IIO_ATTR_2
Message-ID: <20110725144815.4d654942@v0nbox>
In-Reply-To: <4E2D9673.3040602@cam.ac.uk>
References: <1311373619-19188-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	<4E2D53E1.90305@cam.ac.uk>
	<20110725115125.199f8f11@v0nbox>
	<4E2D9673.3040602@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Mon, 25 Jul 2011 17:14:43 +0100,
Jonathan Cameron <jic23@cam.ac.uk> wrote :
> > But I've found the ad7291.c driver which is 8 channels as well. 
> > It might offer a solution that avoids using this second parameter.
> > Is it a good driver to refer to in this case?
> > 
> > Regards,
> > Vivien.
> No.  Look at any of max1363, ad799x, ad7887 and indeed pretty much any
> of the others that have undergone chan_spec conversion.
> 
> Usual principal with drivers is find one that has a lot of active
> development to copy.
> 
> Michael is the ad7291 on your cleanup list? It's on another planet
> abi wise...
> 
> Sorry Vivien if you wasted any time copying stuff from there.
> We decided just the other day to start maintaining broken out TODO
> files for the drivers. Sorry we didn't have those in place already or
> it might have saved you time.
> 
> Jonathan
That's ok, I understand that this new subsystem is moving fast.
By the way, that's why I've proposed an HWMON version of the TS-5500
ADC driver in the new set of patches for the TS-5500 support
(https://lkml.org/lkml/2011/7/19/220, which has no comment yet). As it
is integrated as part of this platform and functional at the moment,
those patches could be applied initially, then a future patch could
move the ADC driver from HWMON to IIO.
This discussion could continue on the TS-5500 patches request if you
prefer. What do you think?

Regards,
Vivien.
