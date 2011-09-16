Return-Path: <jonathan.kunkee@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4E71DD44.7030407@cam.ac.uk>
References: <4E71DD44.7030407@cam.ac.uk>
Date: Thu, 15 Sep 2011 22:52:00 -0600
Message-ID: <CAGRJchisN3z8kNpKy39LsoqXhMOh-Z4_dEyHJK-42+WeaW=bEw@mail.gmail.com>
Subject: Re: Does anyone read device.txt etc?
From: Jonathan Kunkee <jonathan.kunkee@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Jon Brenner <jbrenner@taosinc.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

> I'm just wondering if some corners of our documentation are useful or not=
.
>
> So straw poll. =A0Has anyone ever read the stuff in
>
> device.txt?
> trigger.txt?
> ring.txt?

Yes. When I was first looking at changing my HMC6343 driver over to the
IIO subsystem I read everything in drivers/staging/iio/Documentation. It
wasn't all that helpful--partly because I'm new to kernel development,
and partly because it wasn't specific enough. (This was a few months ago.)

> I'm tempted to drop all 3 of these as pointless maintenance
> overhead...

I can certainly understand this!

> A well commented dummy driver would be better for explaining these
> things.

Agreed, especially with these three docs. The information presented is
fairly fundamental to writing a good IIO driver, but would be much more
useful inline with the reference implementation of each part.

I also agree with Michael that the documentation should be a good
jumping-off point. In particular, I was looking to answer two questions:
1) Why would I use this subsystem? (general feature descriptions,
  example applications, comparison to other subsystems)
2) How is this subsystem organized/used? (constants, masking, relationship
  with other subsystems like i2c)

Part of the difficulty I had was in attempting to grok a staging feature as=
 if
it were mature and static (ring.txt in particular confused me), so this is,=
 of
course, just my 2c.

Thanks for all the work you're putting in to IIO! I hope this helps.

Cheers,
Jon
