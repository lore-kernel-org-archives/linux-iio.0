Return-Path: <SRS0=XxgT=AL=posteo.de=martink@kernel.org>
Date: Sun, 10 Sep 2017 16:00:35 +0200
In-Reply-To: <20170910144424.28e97d1d@archlinux>
References: <1503879782-11945-1-git-send-email-harinath922@gmail.com> <1699ec2db96b498478b95a3cbcfe73ca@posteo.de> <CAAGUq_ryozztz1B_-zuQ4SgR5Yh7Lznk=mrk7pd4YtDuScLyJw@mail.gmail.com> <CAAGUq_rMONY=upVapudHC+fpM2PQC-zUWnm9yJ4YCt4FQ_HjxQ@mail.gmail.com> <20170903172437.0aaec34d@archlinux> <CAAGUq_q0u9j5A4P3v6hisQbnXk3KEm_fU_CVAj4MmEMXKO15jQ@mail.gmail.com> <20170910144424.28e97d1d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v5] iio: accel: mma8452: improvements to handle multiple events
To: Jonathan Cameron <jic23@kernel.org>,harinath Nampally <harinath922@gmail.com>
CC: knaack.h@gmx.de,lars@metafoo.de,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,Greg KH <gregkh@linuxfoundation.org>,linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org,Alison Schofield <amsfield22@gmail.com>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <71459A58-C26C-4956-B8E6-655841F219CB@posteo.de>
List-ID: <linux-iio@vger.kernel.org>



Am 10=2E September 2017 15:44:24 MESZ schrieb Jonathan Cameron <jic23@kern=
el=2Eorg>:
>On Mon, 4 Sep 2017 23:06:37 -0400
>harinath Nampally <harinath922@gmail=2Ecom> wrote:
>
>> > I agree with your understanding=2E  It's a rising threshold, just
>that the input
>> > will only reflect high frequency changes in the signal=2E =20
>> Thank you for the clarification=2E I am hoping this gets merged in the
>> next window if no other issues=2E
>
>There is still the open question to Martin on what he meant in his
>review to be addressed=2E
>
>Martin, any comments on this?
>
>I'm really looking for an OK from Martin before I take this one=2E
>Plenty of time though given the merge window is still open!

I had a look at v6 of this=2E

>
>I'm travelling this week so response may be a bit random depending
>on conference wifi and how interesting the material is ;)

enjoy,

    martin

>
>Jonathan
>
>>=20
>> Thanks,
>> Hari
>>=20
>> On Sun, Sep 3, 2017 at 12:24 PM, Jonathan Cameron <jic23@kernel=2Eorg>
>wrote:
>> > On Tue, 29 Aug 2017 23:01:16 -0400
>> > harinath Nampally <harinath922@gmail=2Ecom> wrote:
>> > =20
>> >> > We should never say "transient is for rising
>> >> > direction" or "ff_mt is for falling direction"=2E any combination
>is fine=2E =20
>> >>
>> >> Ok I agree that there is no hard and fast rule that "transient is
>for rising
>> >> direction" or "ff_mt is for falling direction"=2E
>> >> But in our case, datasheet for these chips define these events
>based on
>> >> acceleration magnitude rising or falling below a set threshold
>value=2E
>> >>
>> >> For quick reference, below excerpts are from fxls8471 datasheet:
>> >> Motion Event: "When the acceleration exceeds a set threshold for a
>set
>> >> amount of time,
>> >> the motion interrupt is asserted=2E"
>> >>
>> >> Freefall event: "The detection of =E2=80=9CFreefall=E2=80=9D involve=
s the
>monitoring
>> >> of the X, Y, and Z axes
>> >> for the condition where the acceleration magnitude is below a
>> >> user-specified threshold
>> >> for a user-definable amount of time"
>> >>
>> >> Transient event: "When the high-pass filter is bypassed, the
>> >> functionality becomes
>> >> similar to the motion-detection function; in this mode,
>acceleration
>> >> greater than
>> >> a programmable threshold is detected (along an axis)=2E"
>> >>
>> >> Therefore I think in this driver freefall event is defined as
>> >> 'falling' event type and
>> >> motion event is defined as 'rising' event type and Transient is
>also defined as
>> >> 'rising' event type=2E
>> >>  As you might already know that mma8562 and mma8563 doesn't have
>> >> transient event support
>> >> but they do have freefall and motion event support which are
>defined
>> >> as 'fall' and 'rise'
>> >> event types respectively=2E Please note in this driver, motion event
>is
>> >> enabled/configured only
>> >> for mma8652 and mma8653=2E
>> >> Therefore if I read/write sysfs node for 'rise' it should use the
>> >> FF_MT registers for mma8652 and mma853, but for all others like
>> >> mma8451, mma8452 and
>> >> mma8453 which has transient event support it picks the Transient
>> >> registers if enabled=2E Also please
>> >> note transient event is enabled(but not motion event) for mma8451,
>> >> mma8452 and mma8453=2E
>> >> The problem seems like we have two different events(motion and
>> >> transient) that are defined
>> >> as same event type 'rising' but in fact both motion and transient
>are
>> >> pretty much similar as they
>> >> both raise interrupt flag when the acceleration magnitude rises
>above
>> >> the threshold=2E
>> >> Only difference is transient event has its own event config
>registers
>> >> with High pass filter=2E
>> >> If HPF bypassed using config register transient event acts like
>motion
>> >> detection event=2E =20
>> > =20
>> >>
>> >> That was my understanding but please correct me if I am wrong=2E =20
>> >
>> > I agree with your understanding=2E  It's a rising threshold, just
>that the input
>> > will only reflect high frequency changes in the signal=2E
>> > =20
>> >> =20
>> >> > Only freefall mode needs one fix: remembering to which set of
>registers to fall back when
>> >> > disabling it=2E =20
>> >>
>> >> I don't quite understand what you mean by 'to fall back when
>disabling
>> >> it'=2E Please elaborate=2E I would
>> >> appreciate if you could suggest your logic in the form of
>pseudo-code=2E
>> >> Thanks for your time
>> >> =20
>> > =2E=2E=2E =20

--=20
Martin Kepplinger
http://martinkepplinger=2Ecom
sent from mobile
