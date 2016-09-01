Return-Path: <lee.jones@linaro.org>
Date: Thu, 1 Sep 2016 08:24:04 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Olof Johansson <olof@lixom.net>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v4 0/4] Add support for cros-ec-sensors
Message-ID: <20160901072404.GD4921@dell>
References: <1470045278-18161-1-git-send-email-enric.balletbo@collabora.com>
 <b32afa2d-965c-569c-dde1-3611615080d3@kernel.org>
 <20160816124907.GK25844@dell>
 <2a50b180-c6ce-8261-5784-a3713c35b30c@kernel.org>
 <a2d7688d-753d-8c50-728b-f33cc5e31eb9@kernel.org>
 <20160830085756.GB1661@dell>
 <a911916d-05bc-6bcd-0aea-bfd7a3d4ff1b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <a911916d-05bc-6bcd-0aea-bfd7a3d4ff1b@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

> >>>>> Given this dependency I'm assuming the best route for these is via
> >>>>> the MFD tree...
> >>>>>
> >>>>> Lee, shout if you want them to go a different route.
> >>>>
> >>>> IIO looks like a more suitable route.  Please provide me with a
> >>>> pull-request base off of an immutable tag.
> >>> Hi Lee,
> >>>
> >>> As far as I can tell the precursor patch above hasn't gone in your
> >>> tree yet which leaves me unable to take this through IIO for now.
> >>>
> >>> Maybe I'm missing something!
> >>>
> >>> Jonathan
> >>
> >> Hi Lee,
> >>
> >> Any movement on the dependency above?
> >>
> >> Last I can find was you adding your ack to it:
> >> [PATCH v2 1/2] mfd: cros_ec: Add MKBP event support
> >>
> >> https://lkml.org/lkml/2016/8/16/423
> > 
> > Well that's annoying.  Okay, well when I send out the pull-request for
> > this one, I will include you.
> > 
> > Actually, better still -- take all of them on one branch and I will
> > pull from you.  Saves the toing and froing.
> > 
> Sure. Will probably be the weekend before I get this sorted.

No rush.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
