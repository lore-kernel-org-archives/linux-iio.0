Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49229 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1763988AbdDSNtn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Apr 2017 09:49:43 -0400
Message-ID: <1492609756.2970.131.camel@pengutronix.de>
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        kernel@pengutronix.de
Date: Wed, 19 Apr 2017 15:49:16 +0200
In-Reply-To: <da90526b-7274-c52c-07e8-9f0d75cf1cbf@axentia.se>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
         <1492101794-13444-4-git-send-email-peda@axentia.se>
         <1492592817.2970.14.camel@pengutronix.de>
         <da90526b-7274-c52c-07e8-9f0d75cf1cbf@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2017-04-19 at 14:00 +0200, Peter Rosin wrote:
[...]
> >> +int mux_control_select(struct mux_control *mux, int state)
> > 
> > If we let two of these race, ...
>
> The window for this "race" is positively huge. If there are several
> mux consumers of a single mux controller, it is self-evident that
> if one of them grabs the mux for a long time, the others will suffer.
> 
> The design is that the rwsem is reader-locked for the full duration
> of a select/deselect operation by the mux consumer.

I was not clear. I meant: I think this can also happen if we let them
race with the same state target.

> >> +{
> >> +	int ret;
> >> +
> >> +	if (down_read_trylock(&mux->lock)) {
> >> +		if (mux->cached_state == state)
> >> +			return 0;

This check makes it clear that a second select call is not intended to
block if the intended state is already selected. But if the instance we
will lose the race against has not yet updated cached_state, ...

> >> +		/* Sigh, the mux needs updating... */
> >> +		up_read(&mux->lock);
> >> +	}
> >> +
> >> +	/* ...or it's just contended. */
> >> +	down_write(&mux->lock);

... we are blocking here until the other instance calls up_read. Even
though in this case (same state target) we would only have to block
until the other instance calls downgrade_write after the mux control is
set to the correct state.

Basically there is a small window before down_write with no lock at all,
where multiple instances can already have decided they must change the
mux (to the same state). If this happens, they go on to block each other
unnecessarily.

> > ... then the last to get to down_write will just wait here forever (or
> > until the first consumer calls mux_control_deselect, which may never
> > happen)?
> 
> It is vital that the mux consumer call _deselect when it is done with
> the mux. Not doing so will surely starve out any other mux consumers.
> The whole thing is designed around the fact that mux consumers should
> deselect the mux as soon as it's no longer needed.

I'd like to use this for video bus multiplexers. Those would not be
selected for the duration of an i2c transfer, but for the duration of a
running video capture stream, or for the duration of an enabled display
path. While I currently have no use case for multiple consumers
controlling the same mux, this scenario is what shapes my perspective.
For such long running selections the consumer should have the option to
return -EBUSY instead of blocking when the lock can't be taken.

regards
Philipp

