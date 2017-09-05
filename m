Return-Path: <SRS0=sYHX=AG=gmail.com=harinath922@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170903172437.0aaec34d@archlinux>
References: <1503879782-11945-1-git-send-email-harinath922@gmail.com>
 <1699ec2db96b498478b95a3cbcfe73ca@posteo.de> <CAAGUq_ryozztz1B_-zuQ4SgR5Yh7Lznk=mrk7pd4YtDuScLyJw@mail.gmail.com>
 <CAAGUq_rMONY=upVapudHC+fpM2PQC-zUWnm9yJ4YCt4FQ_HjxQ@mail.gmail.com> <20170903172437.0aaec34d@archlinux>
From: harinath Nampally <harinath922@gmail.com>
Date: Mon, 4 Sep 2017 23:06:37 -0400
Message-ID: <CAAGUq_q0u9j5A4P3v6hisQbnXk3KEm_fU_CVAj4MmEMXKO15jQ@mail.gmail.com>
Subject: Re: [PATCH v5] iio: accel: mma8452: improvements to handle multiple events
To: Jonathan Cameron <jic23@kernel.org>
Cc: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg KH <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alison Schofield <amsfield22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> I agree with your understanding.  It's a rising threshold, just that the =
input
> will only reflect high frequency changes in the signal.
Thank you for the clarification. I am hoping this gets merged in the
next window if no other issues.

Thanks,
Hari

On Sun, Sep 3, 2017 at 12:24 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 29 Aug 2017 23:01:16 -0400
> harinath Nampally <harinath922@gmail.com> wrote:
>
>> > We should never say "transient is for rising
>> > direction" or "ff_mt is for falling direction". any combination is fin=
e.
>>
>> Ok I agree that there is no hard and fast rule that "transient is for ri=
sing
>> direction" or "ff_mt is for falling direction".
>> But in our case, datasheet for these chips define these events based on
>> acceleration magnitude rising or falling below a set threshold value.
>>
>> For quick reference, below excerpts are from fxls8471 datasheet:
>> Motion Event: "When the acceleration exceeds a set threshold for a set
>> amount of time,
>> the motion interrupt is asserted."
>>
>> Freefall event: "The detection of =E2=80=9CFreefall=E2=80=9D involves th=
e monitoring
>> of the X, Y, and Z axes
>> for the condition where the acceleration magnitude is below a
>> user-specified threshold
>> for a user-definable amount of time"
>>
>> Transient event: "When the high-pass filter is bypassed, the
>> functionality becomes
>> similar to the motion-detection function; in this mode, acceleration
>> greater than
>> a programmable threshold is detected (along an axis)."
>>
>> Therefore I think in this driver freefall event is defined as
>> 'falling' event type and
>> motion event is defined as 'rising' event type and Transient is also def=
ined as
>> 'rising' event type.
>>  As you might already know that mma8562 and mma8563 doesn't have
>> transient event support
>> but they do have freefall and motion event support which are defined
>> as 'fall' and 'rise'
>> event types respectively. Please note in this driver, motion event is
>> enabled/configured only
>> for mma8652 and mma8653.
>> Therefore if I read/write sysfs node for 'rise' it should use the
>> FF_MT registers for mma8652 and mma853, but for all others like
>> mma8451, mma8452 and
>> mma8453 which has transient event support it picks the Transient
>> registers if enabled. Also please
>> note transient event is enabled(but not motion event) for mma8451,
>> mma8452 and mma8453.
>> The problem seems like we have two different events(motion and
>> transient) that are defined
>> as same event type 'rising' but in fact both motion and transient are
>> pretty much similar as they
>> both raise interrupt flag when the acceleration magnitude rises above
>> the threshold.
>> Only difference is transient event has its own event config registers
>> with High pass filter.
>> If HPF bypassed using config register transient event acts like motion
>> detection event.
>
>>
>> That was my understanding but please correct me if I am wrong.
>
> I agree with your understanding.  It's a rising threshold, just that the =
input
> will only reflect high frequency changes in the signal.
>
>>
>> > Only freefall mode needs one fix: remembering to which set of register=
s to fall back when
>> > disabling it.
>>
>> I don't quite understand what you mean by 'to fall back when disabling
>> it'. Please elaborate. I would
>> appreciate if you could suggest your logic in the form of pseudo-code.
>> Thanks for your time
>>
> ...
