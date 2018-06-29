Return-Path: <SRS0=0Qwl=JP=gmail.com=karim.eshapa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180629074532.cbwwjx2lh6cc3f72@mwanda>
References: <20180628234928.4205-1-karim.eshapa@gmail.com> <20180629074532.cbwwjx2lh6cc3f72@mwanda>
From: karim eshapa <karim.eshapa@gmail.com>
Date: Fri, 29 Jun 2018 12:12:22 +0200
Message-ID: <CABf4As8GRZmKZ0F3J+BvzHK5aKFoENWiYftiUcK6WiXoE-OnEg@mail.gmail.com>
Subject: Re: [PATCH 4/4] staging:iio:adc:ad7280a: Use GFP_ATOMIC in interrupt handler
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: lars@metafoo.de, devel@driverdev.osuosl.org, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: multipart/alternative; boundary="00000000000086bf50056fc51547"
List-ID: <linux-iio@vger.kernel.org>

--00000000000086bf50056fc51547
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Jun 2018 00:45:54 -0700, Dan Carpenter wrote:
>This is a threaded IRQ so it can sleep.
>
>You should always think about the impact of a bug.  If this were a bug
>it would have showed up in testing right away.  Most of my patches are
>in error handling and so the impact is zero unless you deliberately try
>to inject errors that's why they can go undetected for years.
>
>Also you should always use the Fixes tag to see how the patch was
>introduced.  I often see bugs where the patch is new and it was
>introduced by someone doing major subsystem cleanups and they don't have
>the hardware so I know it hasn't been tested.  If the patch is a couple
>years old and the bug is in the success path which every one tests then
>I wonder if I am misreading the code somehow.

Thanks Dan for your precious advises, I'm always trying to find
where it may causes a problem or improve performance to make
the code looks good and bug free.

Thanks,
Karim

On 29 June 2018 at 09:45, Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Fri, Jun 29, 2018 at 01:49:28AM +0200, Karim Eshapa wrote:
> > Use GFP_ATOMIC rather GFP_KERNEL in interrupt handler,
> > as GFP_KERNEL may sleep according to slab allocator.
> >
>
> This is a threaded IRQ so it can sleep.
>
> You should always think about the impact of a bug.  If this were a bug
> it would have showed up in testing right away.  Most of my patches are
> in error handling and so the impact is zero unless you deliberately try
> to inject errors that's why they can go undetected for years.
>
> Also you should always use the Fixes tag to see how the patch was
> introduced.  I often see bugs where the patch is new and it was
> introduced by someone doing major subsystem cleanups and they don't have
> the hardware so I know it hasn't been tested.  If the patch is a couple
> years old and the bug is in the success path which every one tests then
> I wonder if I am misreading the code somehow.
>
> regards,
> dan carpenter
>
>

--00000000000086bf50056fc51547
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On=C2=A0Fri, 29 Jun 2018 00:45:54 -0700, Dan Carpenter wro=
te:<br><span style=3D"font-size:12.8px;text-decoration-style:initial;text-d=
ecoration-color:initial;float:none;display:inline">&gt;This is a threaded I=
RQ so it can sleep.</span><br style=3D"font-size:12.8px;text-decoration-sty=
le:initial;text-decoration-color:initial">&gt;<br style=3D"font-size:12.8px=
;text-decoration-style:initial;text-decoration-color:initial"><span style=
=3D"font-size:12.8px;text-decoration-style:initial;text-decoration-color:in=
itial;float:none;display:inline">&gt;You should always think about the impa=
ct of a bug.=C2=A0 If this were a bug</span><br style=3D"font-size:12.8px;t=
ext-decoration-style:initial;text-decoration-color:initial"><span style=3D"=
font-size:12.8px;text-decoration-style:initial;text-decoration-color:initia=
l;float:none;display:inline">&gt;it would have showed up in testing right a=
way.=C2=A0 Most of my patches are</span><br style=3D"font-size:12.8px;text-=
decoration-style:initial;text-decoration-color:initial"><span style=3D"font=
-size:12.8px;text-decoration-style:initial;text-decoration-color:initial;fl=
oat:none;display:inline">&gt;in error handling and so the impact is zero un=
less you deliberately try</span><br style=3D"font-size:12.8px;text-decorati=
on-style:initial;text-decoration-color:initial"><span style=3D"font-size:12=
.8px;text-decoration-style:initial;text-decoration-color:initial;float:none=
;display:inline">&gt;to inject errors that&#39;s why they can go undetected=
 for years.</span><br style=3D"font-size:12.8px;text-decoration-style:initi=
al;text-decoration-color:initial">&gt;<br style=3D"font-size:12.8px;text-de=
coration-style:initial;text-decoration-color:initial"><span style=3D"font-s=
ize:12.8px;text-decoration-style:initial;text-decoration-color:initial;floa=
t:none;display:inline">&gt;Also you should always use the Fixes tag to see =
how the patch was</span><br style=3D"font-size:12.8px;text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"font-size:12.8px;tex=
t-decoration-style:initial;text-decoration-color:initial;float:none;display=
:inline">&gt;introduced.=C2=A0 I often see bugs where the patch is new and =
it was</span><br style=3D"font-size:12.8px;text-decoration-style:initial;te=
xt-decoration-color:initial"><span style=3D"font-size:12.8px;text-decoratio=
n-style:initial;text-decoration-color:initial;float:none;display:inline">&g=
t;introduced by someone doing major subsystem cleanups and they don&#39;t h=
ave</span><br style=3D"font-size:12.8px;text-decoration-style:initial;text-=
decoration-color:initial"><span style=3D"font-size:12.8px;text-decoration-s=
tyle:initial;text-decoration-color:initial;float:none;display:inline">&gt;t=
he hardware so I know it hasn&#39;t been tested.=C2=A0 If the patch is a co=
uple</span><br style=3D"font-size:12.8px;text-decoration-style:initial;text=
-decoration-color:initial"><span style=3D"font-size:12.8px;text-decoration-=
style:initial;text-decoration-color:initial;float:none;display:inline">&gt;=
years old and the bug is in the success path which every one tests then</sp=
an><br style=3D"font-size:12.8px;text-decoration-style:initial;text-decorat=
ion-color:initial"><span style=3D"font-size:12.8px;text-decoration-style:in=
itial;text-decoration-color:initial;float:none;display:inline">&gt;I wonder=
 if I am misreading the code somehow.<br></span><br>Thanks Dan for your pre=
cious advises, I&#39;m always trying to find=C2=A0<br>where it may causes a=
 problem or improve performance to make<br>the code looks good and bug free=
.<br><br>Thanks,<br>Karim=C2=A0</div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On 29 June 2018 at 09:45, Dan Carpenter <span dir=3D"lt=
r">&lt;<a href=3D"mailto:dan.carpenter@oracle.com" target=3D"_blank">dan.ca=
rpenter@oracle.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<span class=3D"">On Fri, Jun 29, 2018 at 01:49:28AM +0200, Karim Eshapa wro=
te:<br>
&gt; Use GFP_ATOMIC rather GFP_KERNEL in interrupt handler,<br>
&gt; as GFP_KERNEL may sleep according to slab allocator.<br>
&gt; <br>
<br>
</span>This is a threaded IRQ so it can sleep.<br>
<br>
You should always think about the impact of a bug.=C2=A0 If this were a bug=
<br>
it would have showed up in testing right away.=C2=A0 Most of my patches are=
<br>
in error handling and so the impact is zero unless you deliberately try<br>
to inject errors that&#39;s why they can go undetected for years.<br>
<br>
Also you should always use the Fixes tag to see how the patch was<br>
introduced.=C2=A0 I often see bugs where the patch is new and it was<br>
introduced by someone doing major subsystem cleanups and they don&#39;t hav=
e<br>
the hardware so I know it hasn&#39;t been tested.=C2=A0 If the patch is a c=
ouple<br>
years old and the bug is in the success path which every one tests then<br>
I wonder if I am misreading the code somehow.<br>
<br>
regards,<br>
dan carpenter<br>
<br>
</blockquote></div><br></div>

--00000000000086bf50056fc51547--
