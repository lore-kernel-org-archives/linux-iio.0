Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45549 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1169932AbdDXMiZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2017 08:38:25 -0400
Message-ID: <1493037481.2446.32.camel@pengutronix.de>
Subject: Re: [PATCH v14 00/11] mux controller abstraction and iio/i2c muxes
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Date: Mon, 24 Apr 2017 14:38:01 +0200
In-Reply-To: <2d978956-d247-917d-4150-a6723917a733@axentia.se>
References: <1493022995-16917-1-git-send-email-peda@axentia.se>
         <1493031179.2446.9.camel@pengutronix.de>
         <2d978956-d247-917d-4150-a6723917a733@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2017-04-24 at 13:37 +0200, Peter Rosin wrote:
[...]
> Ok, so the difference is probably that the rwsem locking primitive
> don't have any lockdep checking hooked up. Because the rwsem was
> definitely held in the same way in v13 as the mutex is now held in
> v14, so there's no fundamental difference.
>
> So, yes, we can use some kind of refcount scheme to not hold an actual
> mutex for the duration of the mux select/deselect, but that doesn't
> really change anything. Userspace is still locking something, and that
> seems dangerous. How do you make sure that mux_control_deselect is
> called as it should?

My current video_mux link setup implementation looks like this (it is
called from userspace via the MEDIA_IOC_SETUP_LINK ioctl):

----------8<----------
static int video_mux_link_setup(struct media_entity *entity,
				const struct media_pad *local,
				const struct media_pad *remote, u32 flags)
{
	struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(entity);
	struct video_mux *video_mux = v4l2_subdev_to_video_mux(sd);
	int ret;

	/*
	 * The mux state is determined by the enabled sink pad link.
	 * Enabling or disabling the source pad link has no effect.
	 */
	if (!is_sink_pad(video_mux, local->index))
		return 0;

	dev_dbg(sd->dev, "link setup '%s':%d->'%s':%d[%d]", remote->entity->name,
		remote->index, local->entity->name, local->index,
		flags & MEDIA_LNK_FL_ENABLED);

	if (flags & MEDIA_LNK_FL_ENABLED) {
		if (video_mux->active == local->index)
			return 0;

		if (video_mux->active >= 0)
			return -EBUSY;

		dev_dbg(sd->dev, "setting %d active\n", local->index);
		ret = mux_control_try_select(video_mux->mux, local->index);
		if (ret < 0)
			return ret;
		video_mux->active = local->index;
	} else {
		if (video_mux->active != local->index)
			return 0;

		dev_dbg(sd->dev, "going inactive\n");
		mux_control_deselect(video_mux->mux);
		video_mux->active = -1;
	}

	return 0;
}
---------->8----------

If a mux state was already selected, this should return -EBUSY, until a
call to disable the active link deselects the mux.

> What I don't like about abandoning the lock is that there is still a
> need to support the multi-consumer case and then you need some way
> of keeping track of waiters. A lock does this, and any attempt to open
> code that will get messy.
> 
> What might be better is to support some kind of exclusive mux, i.e. a
> mux that only allows one consumer per mux controller. Then the mux core
> could trust that exclusive consumer to not fuck things up for itself and
> thus have no lock at all for select/deselect for the exclusive case. Or
> perhaps keep a refcount (as you suggested) for the exclusive case so
> that mux_control_try_select still makes sense, because you still want
> that, right? 

In the case of an exclusive mux without lock, I don't see any need for a
try_select call.

> The question then becomes how to best tell the mux core that you want
> an exclusive mux. I see two options. Either you declare a mux controller
> as exclusive up front somehow (in the device tree presumably), or you
> add a mux_control_get_exclusive call that makes further calls to
> mux_control_get{,_exclusive} fail with -EBUSY. I think I like the
> latter better, if that can be made to work...

There is a precedent for the latter in the reset controller framework
(reset_control_get_shared and reset_control_get_exclusive variants).
Since this distinction is a matter of usage, and not a hardware property
of the mux/reset controller itself, I'd also prefer that.

regards
Philipp

