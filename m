Return-Path: <SRS0=jLyA=YO=matheina.com=scott@kernel.org>
MIME-Version: 1.0
In-Reply-To: <ec39ba5e-f797-575f-660f-b3ef9b6234e5@kernel.org>
References: <1482696216-8013-1-git-send-email-scott@matheina.com>
 <1482696216-8013-5-git-send-email-scott@matheina.com> <9e9dafdc-1687-9392-5087-a2b846804b7d@kernel.org>
 <ec39ba5e-f797-575f-660f-b3ef9b6234e5@kernel.org>
From: Scott Matheina <scott@matheina.com>
Date: Fri, 30 Dec 2016 20:40:46 -0600
Message-ID: <CABSyeE7jtci_GN3cQ-O_9Qjz0TnqnzUcgsUbzYBFTz9Z3oabMg@mail.gmail.com>
Subject: Re: [PATCHv4 4/8] Fix braces not present on all arms of if else statement
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Content-Type: multipart/alternative; boundary=001a114496bce5782a0544eb3e9d
List-ID: <linux-iio@vger.kernel.org>

--001a114496bce5782a0544eb3e9d
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 30, 2016 at 12:48 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> On 30/12/16 18:46, Jonathan Cameron wrote:
> > On 25/12/16 19:56, Scott Matheina wrote:
> >> Adds braces to second arm of if else statement.
> >>
> >> Signed-off-by: Scott Matheina <scott@matheina.com>
> > This patch is actually correct so applied to the togreg branch of
> iio.git.
> Ah, patch title could be better. Should mention which driver it is for as
> it is common for people to cherrypick individual patches out of a series
> (like I just did).
>
> I'll fix this one up to
> staging:iio:adt7316...
>
> Jonathan
>
Thanks


> >
> > Thanks,
> >
> > Jonathan
> >> ---
> >>  drivers/staging/iio/addac/adt7316.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/staging/iio/addac/adt7316.c
> b/drivers/staging/iio/addac/adt7316.c
> >> index 2b584a0..e78d302 100644
> >> --- a/drivers/staging/iio/addac/adt7316.c
> >> +++ b/drivers/staging/iio/addac/adt7316.c
> >> @@ -661,8 +661,9 @@ static ssize_t adt7316_store_da_high_resolution(struct
> device *dev,
> >>                      chip->dac_bits = 12;
> >>              else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
> >>                      chip->dac_bits = 10;
> >> -    } else
> >> +    } else {
> >>              config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
> >> +    }
> >>
> >>      ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> >>      if (ret)
> >>
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
>

--001a114496bce5782a0544eb3e9d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Dec 30, 2016 at 12:48 PM, Jonathan Cameron <span dir=3D"ltr">&l=
t;<a href=3D"mailto:jic23@kernel.org" target=3D"_blank">jic23@kernel.org</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 30/12/16 18:46, Jo=
nathan Cameron wrote:<br>
&gt; On 25/12/16 19:56, Scott Matheina wrote:<br>
&gt;&gt; Adds braces to second arm of if else statement.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Scott Matheina &lt;<a href=3D"mailto:scott@matheina=
.com">scott@matheina.com</a>&gt;<br>
&gt; This patch is actually correct so applied to the togreg branch of iio.=
git.<br>
Ah, patch title could be better. Should mention which driver it is for as<b=
r>
it is common for people to cherrypick individual patches out of a series<br=
>
(like I just did).<br>
<br>
I&#39;ll fix this one up to<br>
staging:iio:adt7316...<br>
<br>
Jonathan<br></blockquote><div>Thanks</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Jonathan<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 drivers/staging/iio/addac/<wbr>adt7316.c | 3 ++-<br>
&gt;&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/staging/iio/addac/<wbr>adt7316.c b/drivers/st=
aging/iio/addac/<wbr>adt7316.c<br>
&gt;&gt; index 2b584a0..e78d302 100644<br>
&gt;&gt; --- a/drivers/staging/iio/addac/<wbr>adt7316.c<br>
&gt;&gt; +++ b/drivers/staging/iio/addac/<wbr>adt7316.c<br>
&gt;&gt; @@ -661,8 +661,9 @@ static ssize_t adt7316_store_da_high_<wbr>reso=
lution(struct device *dev,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 chip-&gt;dac_bits =3D 12;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (chip-&gt;=
id =3D=3D ID_ADT7317 || chip-&gt;id =3D=3D ID_ADT7517)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 chip-&gt;dac_bits =3D 10;<br>
&gt;&gt; -=C2=A0 =C2=A0 } else<br>
&gt;&gt; +=C2=A0 =C2=A0 } else {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config3 =3D chip-&=
gt;config3 &amp; (~ADT7316_DA_HIGH_RESOLUTION);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D chip-&gt;bus.write(chip-&gt;bus.<wbr>c=
lient, ADT7316_CONFIG3, config3);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (ret)<br>
&gt;&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">&gt;<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-i=
io&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<=
wbr>majordomo-info.html</a><br>
&gt;<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a114496bce5782a0544eb3e9d--
