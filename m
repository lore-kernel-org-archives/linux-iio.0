Return-Path: <SRS0=494S=A7=gmail.com=harinath922@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170930190511.2832064c@archlinux>
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
 <1506336008-4480-3-git-send-email-harinath922@gmail.com> <9e6c13a7d4a6cd342a650b3bd626a162@posteo.de>
 <20170930190511.2832064c@archlinux>
From: harinath Nampally <harinath922@gmail.com>
Date: Sat, 30 Sep 2017 14:18:42 -0400
Message-ID: <CAAGUq_oSzMHfEYHAaWUrQTEThCVSchuy1fbWp9u4p9S_6EA9Xg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: accel: mma8452: Rename time step look up
 struct to generic name as the values are same for all the events.
To: Jonathan Cameron <jic23@kernel.org>
Cc: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg KH <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alison Schofield <amsfield22@gmail.com>
Content-Type: multipart/alternative; boundary="001a114b30724130d3055a6c2e69"
List-ID: <linux-iio@vger.kernel.org>

--001a114b30724130d3055a6c2e69
Content-Type: text/plain; charset="UTF-8"

>
> Obviously drop any patches that have already been taken.
> In this case it will be a v4 series containing patches 1 and 2 only.

Sure will do.

On Sat, Sep 30, 2017 at 2:05 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 27 Sep 2017 08:51:26 +0200
> Martin Kepplinger <martink@posteo.de> wrote:
>
> > Am 25.09.2017 12:40 schrieb Harinath Nampally:
> > > Improves code readability, no impact on functionality.
> > >
> > > Signed-off-by: Harinath Nampally <harinath922@gmail.com>
> >
> > Please make the headline shorter and put some of it in the git commit
> > message.
> > (And please just resend it "--in-reply-to" this conversation, this patch
> > nr 2 of 3)
>
> From a patch management point of view I actually disagree with this.
> I would prefer to see a clean fresh series.  Otherwise it very rapidly
> gets hard to be sure that I am picking up the latest versions.
>
> Obviously drop any patches that have already been taken.
> In this case it will be a v4 series containing patches 1 and 2 only.
>
> Thanks
>
> Jonathan
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--001a114b30724130d3055a6c2e69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-im" style=3D"font-size:12.8px"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Obviously drop any patches that=
 have already been taken.<br>In this case it will be a v4 series containing=
 patches 1 and 2 only.</blockquote></span><div style=3D"font-size:12.8px">S=
ure will do.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>On Sat, Sep 30, 2017 at 2:05 PM, Jonathan Cameron <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:jic23@kernel.org" target=3D"_blank">jic23@kernel.org</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><di=
v class=3D"h5">On Wed, 27 Sep 2017 08:51:26 +0200<br>
Martin Kepplinger &lt;<a href=3D"mailto:martink@posteo.de">martink@posteo.d=
e</a>&gt; wrote:<br>
<br>
&gt; Am <a href=3D"tel:25.09.2017%2012" value=3D"+12509201712">25.09.2017 1=
2</a>:40 schrieb Harinath Nampally:<br>
&gt; &gt; Improves code readability, no impact on functionality.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Harinath Nampally &lt;<a href=3D"mailto:harinath92=
2@gmail.com">harinath922@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Please make the headline shorter and put some of it in the git commit<=
br>
&gt; message.<br>
&gt; (And please just resend it &quot;--in-reply-to&quot; this conversation=
, this patch<br>
&gt; nr 2 of 3)<br>
<br>
</div></div>From a patch management point of view I actually disagree with =
this.<br>
I would prefer to see a clean fresh series.=C2=A0 Otherwise it very rapidly=
<br>
gets hard to be sure that I am picking up the latest versions.<br>
<br>
Obviously drop any patches that have already been taken.<br>
In this case it will be a v4 series containing patches 1 and 2 only.<br>
<br>
Thanks<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Jonathan<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-i=
io&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<=
wbr>majordomo-info.html</a><br>
<br>
</font></span></blockquote></div><br></div></div>

--001a114b30724130d3055a6c2e69--
