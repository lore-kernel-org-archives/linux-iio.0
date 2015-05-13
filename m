Return-Path: <robert.dolca@gmail.com>
MIME-Version: 1.0
In-Reply-To: <55538D1A.80500@kernel.org>
References: <1429174868-11953-1-git-send-email-robert.dolca@intel.com>
 <1429174868-11953-2-git-send-email-robert.dolca@intel.com>
 <554CD236.4000404@kernel.org> <555230B0.3050700@metafoo.de>
 <55524F4C.90604@kernel.org> <5552FD16.9050306@metafoo.de> <55538D1A.80500@kernel.org>
From: Robert Dolca <robert.dolca@gmail.com>
Date: Wed, 13 May 2015 21:00:56 +0300
Message-ID: <CAFPB+YdW1oQykadkO3AxKDQ42ndiZBhRqe=w==OZvz6rvACiCQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] iio: Add symlink to triggers in the device's
 trigger folder
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, Denis CIOCCA <denis.ciocca@st.com>
Content-Type: multipart/alternative; boundary=047d7ba97780c0f6aa0515fa6552
List-ID: <linux-iio@vger.kernel.org>

--047d7ba97780c0f6aa0515fa6552
Content-Type: text/plain; charset=UTF-8

On Wed, May 13, 2015 at 8:42 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On 13/05/15 08:28, Lars-Peter Clausen wrote:
> > On 05/12/2015 09:06 PM, Jonathan Cameron wrote:
> >> On 12/05/15 17:56, Lars-Peter Clausen wrote:
> >>> On 05/08/2015 05:11 PM, Jonathan Cameron wrote:
> >>>> On 16/04/15 05:01, Robert Dolca wrote:
> >>>>> This patch adds a new function called iio_trigger_register_with_dev
> >>>>> which is a wrapper for iio_trigger_register. Besides the iio_trigger
> >>>>> struct this function requires iio_dev struct. It adds the trigger in
> >>>>> the device's trigger list and saves a reference to the device in the
> >>>>> trigger's struct.
> >>>>>
> >>>>> When the device is registered, in the trigger folder of the device
> >>>>> (where current_trigger file resides) a symlink is being created for
> >>>>> each trigger that was registered width
iio_trigger_register_with_dev.
> >>>>>
> >>>>>    # ls -l /sys/bus/iio/devices/iio:device0/trigger/
> >>>>> total 0
> >>>>> -rw-r--r--    1 root     root          4096 Apr 16 08:33
current_trigger
> >>>>> lrwxrwxrwx    1 root     root             0 Apr 16 08:33 trigger0
-> ../../trigg
> >>>>> er0
> >>>>>
> >>>>> This should be used for device specific triggers. Doing this the
user space
> >>>>> applications can figure out what if the trigger registered by a
specific device
> >>>>> and what should they write in the current_trigger file. Currently
some
> >>>>> applications rely on the trigger name and this does not always work.
> >>>>>
> >>>>> This implementation assumes that the trigger is registered before
the device is
> >>>>> registered. If the order is not this the symlink will not be
created but
> >>>>> everything else will work as before.
> >>>>>
> >>>>> Signed-off-by: Robert Dolca <robert.dolca@intel.com>
> >>>> I was rather hoping we'd get a few more comments on this.
> >>>> In principle I like the idea, but it's new ABI and does make life
> >>>> a tiny bit more complex, so what do people think?
> >>>>
> >>>> Few trivial code comments inline.
> >>>
> >>> I don't think it adds more information. Both the trigger and the
> >>> device get registered for the same parent device, so you can already
> >>> easily find the trigger for a device by going to the parent device
> >>> and taking a look at the triggers registered by the parent device.
> >> I had the same thought. The question is whether the slightly gain in
> >> simplicity for userspace is worth it...  I'm undecided at the moment.
> >
> > As you may have guessed by now I'm always quite conservative when it
> > comes to introducing new ABI. Simply because we have to maintain it
> > forever, the less stuff to maintain forever the better.
> >
> > Hence I think all new ABI needs a compelling reason, e.g. like a
> > improvement in performance. And of course this patch slightly
> > simplifies things, but in my opinion not enough to justify a ABI
> > extension. We can always find ways to simplify the interface, but the
> > metric for ABI should be whether the simplification actually matters.
> > In this case I don't think it does, finding the trigger for a device
> > is not really hot-path. The amount of time saved will be disappear in
> > the noise.
> >
> > And in my opinion applications shouldn't directly use the low-level
> > ABI but rather use middle-ware libraries/frameworks, like e.g.
> > libiio, and that's where you'd hide the complexities of a operation.
> >
> > - Lars
> I'll go with Lars response on this one.  Not worth the hassle.
> That's the nature of an RFC of course!
>
> Jonathan

Would it be acceptable to add the symlinks without adding a new API? When a
trigger is registered you could use the common parent to get a pointer to
the iio_dev and then create the symlink. This is a little bit complicated
but I think it can be done.

Robert

--047d7ba97780c0f6aa0515fa6552
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, May 13, 2015 at 8:42 PM, Jonathan Cameron &lt;<a h=
ref=3D"mailto:jic23@kernel.org">jic23@kernel.org</a>&gt; wrote:<br>&gt;<br>=
&gt; On 13/05/15 08:28, Lars-Peter Clausen wrote:<br>&gt; &gt; On 05/12/201=
5 09:06 PM, Jonathan Cameron wrote:<br>&gt; &gt;&gt; On 12/05/15 17:56, Lar=
s-Peter Clausen wrote:<br>&gt; &gt;&gt;&gt; On 05/08/2015 05:11 PM, Jonatha=
n Cameron wrote:<br>&gt; &gt;&gt;&gt;&gt; On 16/04/15 05:01, Robert Dolca w=
rote:<br>&gt; &gt;&gt;&gt;&gt;&gt; This patch adds a new function called ii=
o_trigger_register_with_dev<br>&gt; &gt;&gt;&gt;&gt;&gt; which is a wrapper=
 for iio_trigger_register. Besides the iio_trigger<br>&gt; &gt;&gt;&gt;&gt;=
&gt; struct this function requires iio_dev struct. It adds the trigger in<b=
r>&gt; &gt;&gt;&gt;&gt;&gt; the device&#39;s trigger list and saves a refer=
ence to the device in the<br>&gt; &gt;&gt;&gt;&gt;&gt; trigger&#39;s struct=
.<br>&gt; &gt;&gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;&gt; When the device=
 is registered, in the trigger folder of the device<br>&gt; &gt;&gt;&gt;&gt=
;&gt; (where current_trigger file resides) a symlink is being created for<b=
r>&gt; &gt;&gt;&gt;&gt;&gt; each trigger that was registered width iio_trig=
ger_register_with_dev.<br>&gt; &gt;&gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt=
;&gt; =C2=A0 =C2=A0# ls -l /sys/bus/iio/devices/iio:device0/trigger/<br>&gt=
; &gt;&gt;&gt;&gt;&gt; total 0<br>&gt; &gt;&gt;&gt;&gt;&gt; -rw-r--r-- =C2=
=A0 =C2=A01 root =C2=A0 =C2=A0 root =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04096 =
Apr 16 08:33 current_trigger<br>&gt; &gt;&gt;&gt;&gt;&gt; lrwxrwxrwx =C2=A0=
 =C2=A01 root =C2=A0 =C2=A0 root =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0 Apr 16 08:33 trigger0 -&gt; ../../trigg<br>&gt; &gt;&gt;&gt;&gt;&gt; er0<=
br>&gt; &gt;&gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;&gt; This should be us=
ed for device specific triggers. Doing this the user space<br>&gt; &gt;&gt;=
&gt;&gt;&gt; applications can figure out what if the trigger registered by =
a specific device<br>&gt; &gt;&gt;&gt;&gt;&gt; and what should they write i=
n the current_trigger file. Currently some<br>&gt; &gt;&gt;&gt;&gt;&gt; app=
lications rely on the trigger name and this does not always work.<br>&gt; &=
gt;&gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;&gt; This implementation assume=
s that the trigger is registered before the device is<br>&gt; &gt;&gt;&gt;&=
gt;&gt; registered. If the order is not this the symlink will not be create=
d but<br>&gt; &gt;&gt;&gt;&gt;&gt; everything else will work as before.<br>=
&gt; &gt;&gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;&gt; Signed-off-by: Rober=
t Dolca &lt;<a href=3D"mailto:robert.dolca@intel.com">robert.dolca@intel.co=
m</a>&gt;<br>&gt; &gt;&gt;&gt;&gt; I was rather hoping we&#39;d get a few m=
ore comments on this.<br>&gt; &gt;&gt;&gt;&gt; In principle I like the idea=
, but it&#39;s new ABI and does make life<br>&gt; &gt;&gt;&gt;&gt; a tiny b=
it more complex, so what do people think?<br>&gt; &gt;&gt;&gt;&gt;<br>&gt; =
&gt;&gt;&gt;&gt; Few trivial code comments inline.<br>&gt; &gt;&gt;&gt;<br>=
&gt; &gt;&gt;&gt; I don&#39;t think it adds more information. Both the trig=
ger and the<br>&gt; &gt;&gt;&gt; device get registered for the same parent =
device, so you can already<br>&gt; &gt;&gt;&gt; easily find the trigger for=
 a device by going to the parent device<br>&gt; &gt;&gt;&gt; and taking a l=
ook at the triggers registered by the parent device.<br>&gt; &gt;&gt; I had=
 the same thought. The question is whether the slightly gain in<br>&gt; &gt=
;&gt; simplicity for userspace is worth it...=C2=A0 I&#39;m undecided at th=
e moment.<br>&gt; &gt;<br>&gt; &gt; As you may have guessed by now I&#39;m =
always quite conservative when it<br>&gt; &gt; comes to introducing new ABI=
. Simply because we have to maintain it<br>&gt; &gt; forever, the less stuf=
f to maintain forever the better.<br>&gt; &gt;<br>&gt; &gt; Hence I think a=
ll new ABI needs a compelling reason, e.g. like a<br>&gt; &gt; improvement =
in performance. And of course this patch slightly<br>&gt; &gt; simplifies t=
hings, but in my opinion not enough to justify a ABI<br>&gt; &gt; extension=
. We can always find ways to simplify the interface, but the<br>&gt; &gt; m=
etric for ABI should be whether the simplification actually matters.<br>&gt=
; &gt; In this case I don&#39;t think it does, finding the trigger for a de=
vice<br>&gt; &gt; is not really hot-path. The amount of time saved will be =
disappear in<br>&gt; &gt; the noise.<br>&gt; &gt;<br>&gt; &gt; And in my op=
inion applications shouldn&#39;t directly use the low-level<br>&gt; &gt; AB=
I but rather use middle-ware libraries/frameworks, like e.g.<br>&gt; &gt; l=
ibiio, and that&#39;s where you&#39;d hide the complexities of a operation.=
<br>&gt; &gt;<br>&gt; &gt; - Lars<br>&gt; I&#39;ll go with Lars response on=
 this one.=C2=A0 Not worth the hassle.<br>&gt; That&#39;s the nature of an =
RFC of course!<br>&gt;<br>&gt; Jonathan<div><br></div><div>Would it be acce=
ptable to add the symlinks without adding a new API? When a trigger is regi=
stered you could use the common parent to get a pointer to the iio_dev and =
then create the symlink. This is a little bit complicated but I think it ca=
n be done.</div><div><br></div><div>Robert</div></div>

--047d7ba97780c0f6aa0515fa6552--
