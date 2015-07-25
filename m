Return-Path: <jasaw@dius.com.au>
MIME-Version: 1.0
In-Reply-To: <55B28DB7.3050906@gmx.de>
References: <1437751409-28837-1-git-send-email-jasaw@dius.com.au>
	<1437751409-28837-2-git-send-email-jasaw@dius.com.au>
	<55B28DB7.3050906@gmx.de>
Date: Sat, 25 Jul 2015 15:00:41 +1000
Message-ID: <CA+0Dg4rN+o5SU9Db4Bj+Kt8epE92FO0rhpZqKym7udZ5PecOyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: iio: Set caller's ci_array pointer to NULL
 after free
From: Joo Aun Saw <jasaw@dius.com.au>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Content-Type: multipart/alternative; boundary=20cf307cfd3c94664e051bac00cb
List-ID: <linux-iio@vger.kernel.org>

--20cf307cfd3c94664e051bac00cb
Content-Type: text/plain; charset=UTF-8

On Sat, Jul 25, 2015 at 5:10 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:

> Joo Aun Saw schrieb am 24.07.2015 um 17:23:
> > From: Joo Aun Saw <jasaw@dius.com.au>
> >
> > On error, caller's ci_array is freed and set to NULL to avoid
> > potential double free. Counter is reset to zero for consistency.
> >
>
> Hi,
> I don't see a second attempt to free the array. In here, just dp gets
> closed and the scan_el_dir string freed.
> And in generic_buffer.c where it is accessed in the main function, there
> is a jump into the error handler in case of an error, which just frees a
> few strings (datardytrigger, trigger_name and dev_dir_name).
> Any opinion welcome.
> Thanks,
>
> Hartmut
>
> Currently, there is no second free attempt in those examples, but
iio_utils is meant to be used as a library in the future, and therefore
should not leave a dangling pointer (the caller owns the pointer in this
case). There is no guarantee what other users of iio_utils might do. For
example, a caller may have a single clean up routine that frees ALL
pointers upon failure (to simplify error handling), and will encounter
double free problem if this is not fixed. Additionally, it's good software
engineering practice to set pointers to NULL after free because the caller
may still reference it in the future.

Joo.



> > Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
> > ---
> >  tools/iio/iio_utils.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> > index 1dcdf03..8731905 100644
> > --- a/tools/iio/iio_utils.c
> > +++ b/tools/iio/iio_utils.c
> > @@ -529,6 +529,8 @@ error_cleanup_array:
> >               free((*ci_array)[i].generic_name);
> >       }
> >       free(*ci_array);
> > +     *ci_array = NULL;
> > +     *counter = 0;
> >  error_close_dir:
> >       if (dp)
> >               if (closedir(dp) == -1)
> >
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--20cf307cfd3c94664e051bac00cb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
On Sat, Jul 25, 2015 at 5:10 AM, Hartmut Knaack <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:knaack.h@gmx.de" target=3D"_blank">knaack.h@gmx.de</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Joo Aun Saw s=
chrieb am 24.07.2015 um 17:23:<br>
&gt; From: Joo Aun Saw &lt;<a href=3D"mailto:jasaw@dius.com.au">jasaw@dius.=
com.au</a>&gt;<br>
&gt;<br>
&gt; On error, caller&#39;s ci_array is freed and set to NULL to avoid<br>
&gt; potential double free. Counter is reset to zero for consistency.<br>
&gt;<br>
<br>
</span>Hi,<br>
I don&#39;t see a second attempt to free the array. In here, just dp gets<b=
r>
closed and the scan_el_dir string freed.<br>
And in generic_buffer.c where it is accessed in the main function, there<br=
>
is a jump into the error handler in case of an error, which just frees a<br=
>
few strings (datardytrigger, trigger_name and dev_dir_name).<br>
Any opinion welcome.<br>
Thanks,<br>
<br>
Hartmut<br>
<span class=3D""><br></span></blockquote><div>Currently, there is no second=
 free attempt in those examples, but iio_utils is meant to be used as a lib=
rary in the future, and therefore should not leave a dangling pointer (the =
caller owns the pointer in this case). There is no guarantee what other use=
rs of iio_utils might do. For example, a caller may have a single clean up =
routine that frees ALL pointers upon failure (to simplify error handling), =
and will encounter double free problem if this is not fixed. Additionally, =
it&#39;s good software engineering practice to set pointers to NULL after f=
ree because the caller may still reference it in the future.<br><br></div><=
div>Joo.<br></div><div><br>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span=
 class=3D"">
&gt; Signed-off-by: Joo Aun Saw &lt;<a href=3D"mailto:jasaw@dius.com.au">ja=
saw@dius.com.au</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tools/iio/iio_utils.c | 2 ++<br>
&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;<br>
&gt; diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c<br>
&gt; index 1dcdf03..8731905 100644<br>
&gt; --- a/tools/iio/iio_utils.c<br>
&gt; +++ b/tools/iio/iio_utils.c<br>
&gt; @@ -529,6 +529,8 @@ error_cleanup_array:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free((*ci_array)=
[i].generic_name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0free(*ci_array);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*ci_array =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*counter =3D 0;<br>
&gt;=C2=A0 error_close_dir:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (closedir(dp)=
 =3D=3D -1)<br>
&gt;<br>
<br>
--<br>
</span>To unsubscribe from this list: send the line &quot;unsubscribe linux=
-iio&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/majord=
omo-info.html</a><br>
</blockquote></div><br></div></div>

--20cf307cfd3c94664e051bac00cb--
