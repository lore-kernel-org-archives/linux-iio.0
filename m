Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f169.google.com ([209.85.213.169]:35285 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdFHBKX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jun 2017 21:10:23 -0400
Received: by mail-yb0-f169.google.com with SMTP id f192so6518149yba.2
        for <linux-iio@vger.kernel.org>; Wed, 07 Jun 2017 18:10:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9164eb64-55cc-f175-b4c1-3fe2288e0e12@kernel.org>
References: <1480929198-13671-1-git-send-email-thierry.escande@collabora.com>
 <1480929198-13671-3-git-send-email-thierry.escande@collabora.com>
 <alpine.DEB.2.02.1612061223550.29508@pmeerw.net> <9164eb64-55cc-f175-b4c1-3fe2288e0e12@kernel.org>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Wed, 7 Jun 2017 18:10:02 -0700
Message-ID: <CAMHSBOVPFVoB4aJAmua8ib7OFReZC9WP2YaOEKyGjPS+7SyGsw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: core: Add double tap as possible gesture
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thierry Escande <thierry.escande@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, nvaccaro@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

[+Nick]
Looking into it again, given that overloading IIO_ACTIVITY is not an
option, we need another channel type for these type of events. (single
tap, double tap).
Also to reduce the CPU load at idle, instead of polling an
accelerometer to detect orientation change, we are looking at using
accelerometer built-in capability to detect it. (portrait, landscape,
inverted portrait/landscape).

I am proposing to add a new event type for tap: IIO_EV_TYPE_TAP
IIO_MOD_EVENT_CODE(IIO_ACCEL,
                                                x,
                                                IIO_MOD_Z,   /* if the
tap is on the Z axis, if the sensor can tell */
                                                IIO_EV_TYPE_TAP,
                                                IIO_EV_DIR_NONE)
where x == 1 : single tap, 2 : double tap, 3 : .. triple tap ....

For screen rotation detection, another event: IIO_EV_TYPE_ROT, this
time, x will be an enum similar to the W3C  Screen Orientation API
(https://www.w3.org/TR/screen-orientation/#screenorientation-interface):

enum iio_orientation_type {
    PORTRAIT_PRIMARY,
    PORTRAIT_SECONDARY,
    LANDSCAPE_PRIMARY,
    LANDSCAPE_SECONDARY
};

Gwendal

On Mon, Dec 19, 2016 at 1:11 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 06/12/16 11:25, Peter Meerwald-Stadler wrote:
>>
>>> This adds the IIO_MOD_DOUBLE_TAP entry to the iio_modifier enum and the
>>> corresponding "double_tap" string to the iio_modifier_names array.
>>
>> I don't think we should have gestures as channel modifiers
> Agreed, though treating it like other activities (walking, running etc) gave me
> the thought that maybe there are exercise classes out there somewhere in
> 'double tapping'.
>
> We don't actually have a good way of handling this at the moment, but it's
> definitely an 'event' in IIO parlance rather than a modifier of a channel type.
>
> It's irritatingly non general, but perhaps an event type is needed for
> gestures with some abuse of the event code format when one turns up to allow
> us to encode the type?
>
>> probably a middle layer between IIO and input subsystem is needed (could
>> be in userspace?)
> Could do it in userspace, but we probably ultimately want an in kernel
> consumer interface for IIO events, and do the translation in a input
> bridge using that...
>
> Certainly bridging buffered data in userspace didn't turn out as neatly
> as the in kernel version.
>
>>
>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>>> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
>>> ---
>>>  drivers/iio/industrialio-core.c | 1 +
>>>  include/uapi/linux/iio/types.h  | 1 +
>>>  2 files changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>>> index fc340ed..82ce05f 100644
>>> --- a/drivers/iio/industrialio-core.c
>>> +++ b/drivers/iio/industrialio-core.c
>>> @@ -120,6 +120,7 @@ static const char * const iio_modifier_names[] = {
>>>      [IIO_MOD_Q] = "q",
>>>      [IIO_MOD_CO2] = "co2",
>>>      [IIO_MOD_VOC] = "voc",
>>> +    [IIO_MOD_DOUBLE_TAP] = "double_tap",
>>>  };
>>>
>>>  /* relies on pairs of these shared then separate */
>>> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
>>> index 22e5e58..47d2768 100644
>>> --- a/include/uapi/linux/iio/types.h
>>> +++ b/include/uapi/linux/iio/types.h
>>> @@ -80,6 +80,7 @@ enum iio_modifier {
>>>      IIO_MOD_CO2,
>>>      IIO_MOD_VOC,
>>>      IIO_MOD_LIGHT_UV,
>>> +    IIO_MOD_DOUBLE_TAP,
>>>  };
>>>
>>>  enum iio_event_type {
>>>
>>
>
