Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751636AbdFKOqN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 10:46:13 -0400
Date: Sun, 11 Jun 2017 15:46:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thierry Escande <thierry.escande@collabora.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, nvaccaro@chromium.org
Subject: Re: [PATCH 2/3] iio: core: Add double tap as possible gesture
Message-ID: <20170611154608.5bb8584a@kernel.org>
In-Reply-To: <CAMHSBOVPFVoB4aJAmua8ib7OFReZC9WP2YaOEKyGjPS+7SyGsw@mail.gmail.com>
References: <1480929198-13671-1-git-send-email-thierry.escande@collabora.com>
        <1480929198-13671-3-git-send-email-thierry.escande@collabora.com>
        <alpine.DEB.2.02.1612061223550.29508@pmeerw.net>
        <9164eb64-55cc-f175-b4c1-3fe2288e0e12@kernel.org>
        <CAMHSBOVPFVoB4aJAmua8ib7OFReZC9WP2YaOEKyGjPS+7SyGsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 7 Jun 2017 18:10:02 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

Hi Gwendal,

> [+Nick]
> Looking into it again, given that overloading IIO_ACTIVITY is not an
> option, we need another channel type for these type of events. (single
> tap, double tap).
Could represent them as an any access event...
> Also to reduce the CPU load at idle, instead of polling an
> accelerometer to detect orientation change, we are looking at using
> accelerometer built-in capability to detect it. (portrait, landscape,
> inverted portrait/landscape).
Makes sense - I was wondering when someone would propose something for
that given the number of devices supporting it is increasing.
> 
> I am proposing to add a new event type for tap: IIO_EV_TYPE_TAP
> IIO_MOD_EVENT_CODE(IIO_ACCEL,
>                                                 x,
>                                                 IIO_MOD_Z,   /* if the
> tap is on the Z axis, if the sensor can tell */
>                                                 IIO_EV_TYPE_TAP,
>                                                 IIO_EV_DIR_NONE)
> where x == 1 : single tap, 2 : double tap, 3 : .. triple tap ....
No on the use of the index field for the number of taps.
That's a channel index and there are dual accelerometer devices
out there which have parallel accelerometers and use this index.
Not to mention we want to keep it generic if we can. 

Do we get directional taps?  I.d. would direction ever be set?  Seems
possible in future that a device might detect this so I suppose we
can't abuse the direction field and that wouldn't be any better
than the index field.

We have 8 bits for the event type.  Perhaps we should just use a few
values to represent these tap counts?  So have
IIO_EV_TYPE_TAP_SINGLE
IIO_EV_TYPE_TAP_DOUBLE
etc.

> 
> For screen rotation detection, another event: IIO_EV_TYPE_ROT, this
> time, x will be an enum similar to the W3C  Screen Orientation API
> (https://www.w3.org/TR/screen-orientation/#screenorientation-interface):
> 
> enum iio_orientation_type {
>     PORTRAIT_PRIMARY,
>     PORTRAIT_SECONDARY,
>     LANDSCAPE_PRIMARY,
>     LANDSCAPE_SECONDARY
> };
Hmm. This rather feels like bludgeoning a continuous value into an
encoded event. As before I don't like the reuse of the index field...
I also don't really get the whole primary / secondary in the w3c spec...

What we are really looking at here is bounded regions in rotation space that
are detected as the various orientations.  It would be lovely to describe
them as such, but I fear we'll never know enough about most devices to know
how they are defining these regions - and I suspect a lot are much simpler
than they would like us to think ;)

So another option would be to do these in a similar fashion to the
gestures - thus allowing a wide degree of flexibility.

So we'd have a set of channels representing the 'probability' that we
are at a given orientation with a new channel type.  These could be polled at
any time. in_orientation_portrait 0 or 100 (%) on most devices - one
day we'll get a probabalistic output reflecting the certainty that the
underlying algorithm has on the orientation - it might stop the
jumpiness to you get on landscape / portrait on phones when they are
near flat by providing the information that the phone isn't all
that sure...

To achieve the event type interface, do the same as we did for gestures and use
RISING and FALLING events to indicate coming into and out of various orientations.

This should also allow us to cope with the more 'interesting' orientations
one gets with jointed devices.

Does that fit reasonably well?

Jonathan
> 
> Gwendal
> 
> On Mon, Dec 19, 2016 at 1:11 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On 06/12/16 11:25, Peter Meerwald-Stadler wrote:  
> >>  
> >>> This adds the IIO_MOD_DOUBLE_TAP entry to the iio_modifier enum and the
> >>> corresponding "double_tap" string to the iio_modifier_names array.  
> >>
> >> I don't think we should have gestures as channel modifiers  
> > Agreed, though treating it like other activities (walking, running etc) gave me
> > the thought that maybe there are exercise classes out there somewhere in
> > 'double tapping'.
> >
> > We don't actually have a good way of handling this at the moment, but it's
> > definitely an 'event' in IIO parlance rather than a modifier of a channel type.
> >
> > It's irritatingly non general, but perhaps an event type is needed for
> > gestures with some abuse of the event code format when one turns up to allow
> > us to encode the type?
> >  
> >> probably a middle layer between IIO and input subsystem is needed (could
> >> be in userspace?)  
> > Could do it in userspace, but we probably ultimately want an in kernel
> > consumer interface for IIO events, and do the translation in a input
> > bridge using that...
> >
> > Certainly bridging buffered data in userspace didn't turn out as neatly
> > as the in kernel version.
> >  
> >>  
> >>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> >>> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> >>> ---
> >>>  drivers/iio/industrialio-core.c | 1 +
> >>>  include/uapi/linux/iio/types.h  | 1 +
> >>>  2 files changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> >>> index fc340ed..82ce05f 100644
> >>> --- a/drivers/iio/industrialio-core.c
> >>> +++ b/drivers/iio/industrialio-core.c
> >>> @@ -120,6 +120,7 @@ static const char * const iio_modifier_names[] = {
> >>>      [IIO_MOD_Q] = "q",
> >>>      [IIO_MOD_CO2] = "co2",
> >>>      [IIO_MOD_VOC] = "voc",
> >>> +    [IIO_MOD_DOUBLE_TAP] = "double_tap",
> >>>  };
> >>>
> >>>  /* relies on pairs of these shared then separate */
> >>> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> >>> index 22e5e58..47d2768 100644
> >>> --- a/include/uapi/linux/iio/types.h
> >>> +++ b/include/uapi/linux/iio/types.h
> >>> @@ -80,6 +80,7 @@ enum iio_modifier {
> >>>      IIO_MOD_CO2,
> >>>      IIO_MOD_VOC,
> >>>      IIO_MOD_LIGHT_UV,
> >>> +    IIO_MOD_DOUBLE_TAP,
> >>>  };
> >>>
> >>>  enum iio_event_type {
> >>>  
> >>  
> >  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

