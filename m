Return-Path: <olof@lixom.net>
MIME-Version: 1.0
In-Reply-To: <B9807854-374B-417C-9685-E230B89579AA@jic23.retrosnub.co.uk>
References: <1470045278-18161-1-git-send-email-enric.balletbo@collabora.com>
 <b32afa2d-965c-569c-dde1-3611615080d3@kernel.org> <20160816124907.GK25844@dell>
 <2a50b180-c6ce-8261-5784-a3713c35b30c@kernel.org> <a2d7688d-753d-8c50-728b-f33cc5e31eb9@kernel.org>
 <20160830085756.GB1661@dell> <a911916d-05bc-6bcd-0aea-bfd7a3d4ff1b@kernel.org>
 <20160901072404.GD4921@dell> <6ae9c49a-c354-b3bd-a4d9-77bf81915615@kernel.org>
 <CAFqH_53q+0=RBWeTTb1FkML5PudZx8iOAFZ6xOkTec+ciwj0pQ@mail.gmail.com> <B9807854-374B-417C-9685-E230B89579AA@jic23.retrosnub.co.uk>
From: Olof Johansson <olof@lixom.net>
Date: Sat, 22 Oct 2016 10:48:36 -0700
Message-ID: <CAOesGMiMs-5_OKdih9Sgv5oviPuu8bGnChiK2zRuGkJOiJ8Wvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add support for cros-ec-sensors
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>, Benson Leung <bleung@chromium.org>
Content-Type: multipart/alternative; boundary=001a114abda4bb8dd8053f77c40d
List-ID: <linux-iio@vger.kernel.org>

--001a114abda4bb8dd8053f77c40d
Content-Type: text/plain; charset=UTF-8

On Tue, Oct 18, 2016 at 1:56 AM, Jonathan Cameron <
jic23@jic23.retrosnub.co.uk> wrote:

>
>
> On 18 October 2016 09:35:06 BST, Enric Balletbo Serra <eballetbo@gmail.com>
> wrote:
> >Hi Jonathan,
> >
> >2016-09-03 19:21 GMT+02:00 Jonathan Cameron <jic23@kernel.org>:
> >> On 01/09/16 08:24, Lee Jones wrote:
> >>>>>>>>> Given this dependency I'm assuming the best route for these is
> >via
> >>>>>>>>> the MFD tree...
> >>>>>>>>>
> >>>>>>>>> Lee, shout if you want them to go a different route.
> >>>>>>>>
> >>>>>>>> IIO looks like a more suitable route.  Please provide me with a
> >>>>>>>> pull-request base off of an immutable tag.
> >>>>>>> Hi Lee,
> >>>>>>>
> >>>>>>> As far as I can tell the precursor patch above hasn't gone in
> >your
> >>>>>>> tree yet which leaves me unable to take this through IIO for
> >now.
> >>>>>>>
> >>>>>>> Maybe I'm missing something!
> >>>>>>>
> >>>>>>> Jonathan
> >>>>>>
> >>>>>> Hi Lee,
> >>>>>>
> >>>>>> Any movement on the dependency above?
> >>>>>>
> >>>>>> Last I can find was you adding your ack to it:
> >>>>>> [PATCH v2 1/2] mfd: cros_ec: Add MKBP event support
> >>>>>>
> >>>>>> https://lkml.org/lkml/2016/8/16/423
> >>>>>
> >>>>> Well that's annoying.  Okay, well when I send out the pull-request
> >for
> >>>>> this one, I will include you.
> >>>>>
> >>>>> Actually, better still -- take all of them on one branch and I
> >will
> >>>>> pull from you.  Saves the toing and froing.
> >>>>>
> >>>> Sure. Will probably be the weekend before I get this sorted.
> >>>
> >>> No rush.
> >>>
> >> Ah, I see you ended up with an immutable branch of this anyway:
> >> your ib-mfd-input-4.9 branch.
> >> I'll build an immutable branch on that
> >> ib-iio-mfd-4.9 in iio.git.
> >>
> >
> >Nice, I just saw that the dependencies for this patch series are
> >already in mainline, thanks.
> >
> >I don't see the patches in your iio tree, need I to rebase the patch
> >series on top of mainline and send v5 or you are already taking care
> >about it?
> >
> >Cheers,
> >  Enric.
> >
> >
> >> Unfortunately I don't have an Ack for patch 4 from Olof yet so
> >> can't take that and until I do, the rest makes little sense as
> >> it's not enabled.
> Still looking for an Ack from Olof I think...
>
> Perhaps pm him to get him to take a look.
> I doubt much reading is needed but feel free to confirm that!
>

Acked-by: Olof Johansson <olof@lixom.net>


Apologies for the severe delays here. I don't have hardware to test on for
this, so I have to rely on others to vouch for functionality. I hope to
transition maintainership to someone that can pay closer attention soon.


-Olof

--001a114abda4bb8dd8053f77c40d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Oct 18, 2016 at 1:56 AM, Jonathan Cameron <span dir=3D"ltr">&lt=
;<a href=3D"mailto:jic23@jic23.retrosnub.co.uk" target=3D"_blank">jic23@jic=
23.retrosnub.co.uk</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On 18 October 2016 09:35:06 BST, Enric Balletbo Serra &lt;<a href=3D"mailto=
:eballetbo@gmail.com">eballetbo@gmail.com</a>&gt; wrote:<br>
&gt;Hi Jonathan,<br>
&gt;<br>
&gt;2016-09-03 19:21 GMT+02:00 Jonathan Cameron &lt;<a href=3D"mailto:jic23=
@kernel.org">jic23@kernel.org</a>&gt;:<br>
&gt;&gt; On 01/09/16 08:24, Lee Jones wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Given this dependency I&#39;m assuming=
 the best route for these is<br>
&gt;via<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the MFD tree...<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Lee, shout if you want them to go a di=
fferent route.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; IIO looks like a more suitable route.=C2=
=A0 Please provide me with a<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; pull-request base off of an immutable tag.=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi Lee,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; As far as I can tell the precursor patch above=
 hasn&#39;t gone in<br>
&gt;your<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; tree yet which leaves me unable to take this t=
hrough IIO for<br>
&gt;now.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Maybe I&#39;m missing something!<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Jonathan<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Hi Lee,<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Any movement on the dependency above?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Last I can find was you adding your ack to it:<br>
&gt;&gt;&gt;&gt;&gt;&gt; [PATCH v2 1/2] mfd: cros_ec: Add MKBP event suppor=
t<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lkml.org/lkml/2016/8/16/423" re=
l=3D"noreferrer" target=3D"_blank">https://lkml.org/lkml/2016/8/<wbr>16/423=
</a><br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Well that&#39;s annoying.=C2=A0 Okay, well when I send=
 out the pull-request<br>
&gt;for<br>
&gt;&gt;&gt;&gt;&gt; this one, I will include you.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Actually, better still -- take all of them on one bran=
ch and I<br>
&gt;will<br>
&gt;&gt;&gt;&gt;&gt; pull from you.=C2=A0 Saves the toing and froing.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Sure. Will probably be the weekend before I get this sorte=
d.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; No rush.<br>
&gt;&gt;&gt;<br>
&gt;&gt; Ah, I see you ended up with an immutable branch of this anyway:<br=
>
&gt;&gt; your ib-mfd-input-4.9 branch.<br>
&gt;&gt; I&#39;ll build an immutable branch on that<br>
&gt;&gt; ib-iio-mfd-4.9 in iio.git.<br>
&gt;&gt;<br>
&gt;<br>
&gt;Nice, I just saw that the dependencies for this patch series are<br>
&gt;already in mainline, thanks.<br>
&gt;<br>
&gt;I don&#39;t see the patches in your iio tree, need I to rebase the patc=
h<br>
&gt;series on top of mainline and send v5 or you are already taking care<br=
>
&gt;about it?<br>
&gt;<br>
&gt;Cheers,<br>
&gt;=C2=A0 Enric.<br>
&gt;<br>
&gt;<br>
&gt;&gt; Unfortunately I don&#39;t have an Ack for patch 4 from Olof yet so=
<br>
&gt;&gt; can&#39;t take that and until I do, the rest makes little sense as=
<br>
&gt;&gt; it&#39;s not enabled.<br>
</div></div>Still looking for an Ack from Olof I think...<br>
<br>
Perhaps pm him to get him to take a look.<br>
I doubt much reading is needed but feel free to confirm that!<br></blockquo=
te><div><br></div><div>Acked-by: Olof Johansson &lt;<a href=3D"mailto:olof@=
lixom.net">olof@lixom.net</a>&gt;</div><div><br></div><div><br></div><div>A=
pologies for the severe delays here. I don&#39;t have hardware to test on f=
or this, so I have to rely on others to vouch for functionality. I hope to =
transition maintainership to someone that can pay closer attention soon.</d=
iv><div><br></div><div><br></div><div>-Olof</div><div><br></div></div></div=
></div>

--001a114abda4bb8dd8053f77c40d--
