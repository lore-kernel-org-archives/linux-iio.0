Return-Path: <wrona.vy@gmail.com>
MIME-Version: 1.0
In-Reply-To: <54CC014B.30004@kernel.org>
References: <1422642358-30473-1-git-send-email-jic23@kernel.org>
	<54CBFDD2.9020604@kernel.org>
	<54CC014B.30004@kernel.org>
Date: Sat, 31 Jan 2015 02:35:38 +0100
Message-ID: <CABj4xxnitektifnbv+Tcf6T1YZETEusvE-wHpwPrF8bUj-yTpA@mail.gmail.com>
Subject: Re: [PATCH] iio:common:ssp_sensors fix warnings due to 32 bit instead
 of 64 bit passed to do_div
From: Karol Wrona <wrona.vy@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Karol Wrona <k.wrona@samsung.com>, kbuild-all@01.org
Content-Type: multipart/alternative; boundary=047d7bf0f66606bb90050de8bdca
List-ID: <linux-iio@vger.kernel.org>

--047d7bf0f66606bb90050de8bdca
Content-Type: text/plain; charset=UTF-8

I apologise for a such mess.

For me the first fix plus this:
-#define SSP_INVERTED_SCALING_FACTOR 1000000ULL
+#define SSP_INVERTED_SCALING_FACTOR 1000000U
is better. I think there is no sense to do local 64 bit val to use
specially do_div.

When converting the other way I think we can cast first value to u64.

I wonder what is turned on in kbuild robot that it shows more then during
normal build?

 @@ -61,7 +61,7 @@ static inline int ssp_convert_to_time(int integer_part,
int fractional)
 {
  u64 value;

- value = integer_part * SSP_INVERTED_SCALING_FACTOR + fractional;
+ value = (u64)integer_part * SSP_INVERTED_SCALING_FACTOR + fractional;
  if (value == 0)
  return 0;



2015-01-30 23:10 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:

> On 30/01/15 21:55, Jonathan Cameron wrote:
> > On 30/01/15 18:25, Jonathan Cameron wrote:
> >> Fixes warnings with asm-generic/div64.h do_div such as:
> >>    In file included from drivers/iio/common/ssp_sensors/ssp_iio.c:20:0:
> >>    drivers/iio/common/ssp_sensors/ssp_iio_sensor.h: In function
> 'ssp_convert_to_freq':
> >>>> drivers/iio/common/ssp_sensors/ssp_iio_sensor.h:56:16: warning:
> comparison of distinct pointer types lacks a cast [enabled by default]
> >>    drivers/iio/common/ssp_sensors/ssp_iio_sensor.h:56:2: warning: right
> shift count >= width of type [enabled by default]
> >>>> drivers/iio/common/ssp_sensors/ssp_iio_sensor.h:56:2: warning:
> passing argument 1 of '__div64_32' from incompatible pointer type [enabled
> by default]
> >>    include/asm-generic/div64.h:35:17: note: expected 'uint64_t *' but
> argument is of type 'int *'
> >>    drivers/iio/common/ssp_sensors/ssp_iio.c: In function
> 'ssp_common_process_data':
> >>    include/linux/iio/buffer.h:142:32: warning: 'calculated_time' may be
> used uninitialized in this function [-Wuninitialized]
> >>    drivers/iio/common/ssp_sensors/ssp_iio.c:83:10: note:
> 'calculated_time' was declared here
> >>
> >> Fixed by using straight coded version as per the description in the
> >> div64.h header, thus ensuring no issue with 32 bit integers.
> >>
> >> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> >> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> > hmm. failed the build tests. I'd missed SSP_INVERTED_SCALING_FACTOR is
> forced
> > to be ULL.  Any reason for that?
> >
> > I can't immediately see that it is necessary. Being rather tired and
> > running out of evening, I've pushed a version with the LL dropped out
> > to testing to see if that causes any build issues.
> >
> > What fun,
>
> Had one final look. It looks like we might need that constant to be 64 bit
> to force integer promotion when converting the other way.
>
> Hence, perhaps we just need a temporary u64 in this function?
> How about... (and I know it is ugly).
>
> Karol, what do you think?
>
> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> index dda267c9bd2a..40dac417734e 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> +++ b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> @@ -46,14 +46,17 @@ int ssp_common_process_data(struct iio_dev *indio_dev,
> void *buf,
>  static inline void ssp_convert_to_freq(u32 time, int *integer_part,
>                                        int *fractional)
>  {
> +       u64 integer_part64;
> +
>         if (time == 0) {
>                 *fractional = 0;
>                 *integer_part = 0;
>                 return;
>         }
>
> -       *integer_part = SSP_FACTOR_WITH_MS / time;
> -       *fractional = do_div(*integer_part, SSP_INVERTED_SCALING_FACTOR);
> +       integer_part64 = SSP_FACTOR_WITH_MS / time;
> +       *fractional = do_div(integer_part64, SSP_INVERTED_SCALING_FACTOR);
> +       *integer_part = integer_part64;
>  }
>
>  /* Converts frequency to time in ms */
>
> >
> > Jonathan
> >> ---
> >>  drivers/iio/common/ssp_sensors/ssp_iio_sensor.h | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> >> index dda267c9bd2a..fdf61a8c499a 100644
> >> --- a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> >> +++ b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> >> @@ -53,7 +53,8 @@ static inline void ssp_convert_to_freq(u32 time, int
> *integer_part,
> >>      }
> >>
> >>      *integer_part = SSP_FACTOR_WITH_MS / time;
> >> -    *fractional = do_div(*integer_part, SSP_INVERTED_SCALING_FACTOR);
> >> +    *fractional = *integer_part % SSP_INVERTED_SCALING_FACTOR;
> >> +    *integer_part = *integer_part / SSP_INVERTED_SCALING_FACTOR;
> >>  }
> >>
> >>  /* Converts frequency to time in ms */
> >>
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--047d7bf0f66606bb90050de8bdca
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I apologise for a such mess.<div><br></div><div>For me the=
 first fix plus this:</div><div><div>-#define SSP_INVERTED_SCALING_FACTOR<s=
pan class=3D"" style=3D"white-space:pre">	</span>1000000ULL</div><div>+#def=
ine SSP_INVERTED_SCALING_FACTOR<span class=3D"" style=3D"white-space:pre">	=
</span>1000000U</div></div><div>is better. I think there is no sense to do =
local 64 bit val to use specially do_div.</div><div><br></div><div>When con=
verting the other way I think we can cast first value to u64.</div><div><br=
></div><div>I wonder what is turned on in kbuild robot that it shows more t=
hen during normal build?</div><div>=C2=A0</div><div>=C2=A0@@ -61,7 +61,7 @@=
 static inline int ssp_convert_to_time(int integer_part, int fractional)</d=
iv><div><div>=C2=A0{</div><div>=C2=A0<span class=3D"" style=3D"white-space:=
pre">	</span>u64 value;</div><div>=C2=A0=C2=A0</div><div>-<span class=3D"" =
style=3D"white-space:pre">	</span>value =3D integer_part * SSP_INVERTED_SCA=
LING_FACTOR + fractional;</div><div>+<span class=3D"" style=3D"white-space:=
pre">	</span>value =3D (u64)integer_part * SSP_INVERTED_SCALING_FACTOR + fr=
actional;</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</spa=
n>if (value =3D=3D 0)</div><div>=C2=A0<span class=3D"" style=3D"white-space=
:pre">		</span>return 0;</div><div>=C2=A0</div><div><br></div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">2015-01-30 23:10 GMT+01:=
00 Jonathan Cameron <span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@kernel.or=
g" target=3D"_blank">jic23@kernel.org</a>&gt;</span>:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">=
<span class=3D"">On 30/01/15 21:55, Jonathan Cameron wrote:<br>
&gt; On 30/01/15 18:25, Jonathan Cameron wrote:<br>
&gt;&gt; Fixes warnings with asm-generic/div64.h do_div such as:<br>
&gt;&gt;=C2=A0 =C2=A0 In file included from drivers/iio/common/ssp_sensors/=
ssp_iio.c:20:0:<br>
&gt;&gt;=C2=A0 =C2=A0 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h: In f=
unction &#39;ssp_convert_to_freq&#39;:<br>
&gt;&gt;&gt;&gt; drivers/iio/common/ssp_sensors/ssp_iio_sensor.h:56:16: war=
ning: comparison of distinct pointer types lacks a cast [enabled by default=
]<br>
&gt;&gt;=C2=A0 =C2=A0 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h:56:2:=
 warning: right shift count &gt;=3D width of type [enabled by default]<br>
&gt;&gt;&gt;&gt; drivers/iio/common/ssp_sensors/ssp_iio_sensor.h:56:2: warn=
ing: passing argument 1 of &#39;__div64_32&#39; from incompatible pointer t=
ype [enabled by default]<br>
&gt;&gt;=C2=A0 =C2=A0 include/asm-generic/div64.h:35:17: note: expected &#3=
9;uint64_t *&#39; but argument is of type &#39;int *&#39;<br>
&gt;&gt;=C2=A0 =C2=A0 drivers/iio/common/ssp_sensors/ssp_iio.c: In function=
 &#39;ssp_common_process_data&#39;:<br>
&gt;&gt;=C2=A0 =C2=A0 include/linux/iio/buffer.h:142:32: warning: &#39;calc=
ulated_time&#39; may be used uninitialized in this function [-Wuninitialize=
d]<br>
&gt;&gt;=C2=A0 =C2=A0 drivers/iio/common/ssp_sensors/ssp_iio.c:83:10: note:=
 &#39;calculated_time&#39; was declared here<br>
&gt;&gt;<br>
&gt;&gt; Fixed by using straight coded version as per the description in th=
e<br>
&gt;&gt; div64.h header, thus ensuring no issue with 32 bit integers.<br>
&gt;&gt;<br>
&gt;&gt; Reported-by: kbuild test robot &lt;<a href=3D"mailto:fengguang.wu@=
intel.com">fengguang.wu@intel.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Jonathan Cameron &lt;<a href=3D"mailto:jic23@kernel=
.org">jic23@kernel.org</a>&gt;<br>
&gt; hmm. failed the build tests. I&#39;d missed SSP_INVERTED_SCALING_FACTO=
R is forced<br>
&gt; to be ULL.=C2=A0 Any reason for that?<br>
&gt;<br>
&gt; I can&#39;t immediately see that it is necessary. Being rather tired a=
nd<br>
&gt; running out of evening, I&#39;ve pushed a version with the LL dropped =
out<br>
&gt; to testing to see if that causes any build issues.<br>
&gt;<br>
&gt; What fun,<br>
<br>
</span>Had one final look. It looks like we might need that constant to be =
64 bit<br>
to force integer promotion when converting the other way.<br>
<br>
Hence, perhaps we just need a temporary u64 in this function?<br>
How about... (and I know it is ugly).<br>
<br>
Karol, what do you think?<br>
<br>
diff --git a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h b/drivers/iio/=
common/ssp_sensors/ssp_iio_sensor.h<br>
index dda267c9bd2a..40dac417734e 100644<br>
--- a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h<br>
+++ b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h<br>
@@ -46,14 +46,17 @@ int ssp_common_process_data(struct iio_dev *indio_dev, =
void *buf,<br>
<span class=3D"">=C2=A0static inline void ssp_convert_to_freq(u32 time, int=
 *integer_part,<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t *fractional)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 integer_part64;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (time =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *fractional =3D 0;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *integer_part =3D 0=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*integer_part =3D SSP_FACTOR_WITH_MS / time;<br=
>
<span class=3D"">-=C2=A0 =C2=A0 =C2=A0 =C2=A0*fractional =3D do_div(*intege=
r_part, SSP_INVERTED_SCALING_FACTOR);<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0integer_part64 =3D SSP_FACTOR_WITH_MS / =
time;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*fractional =3D do_div(integer_part64, SSP_INVE=
RTED_SCALING_FACTOR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*integer_part =3D integer_part64;<br>
<div class=3D""><div class=3D"h5">=C2=A0}<br>
<br>
=C2=A0/* Converts frequency to time in ms */<br>
<br>
&gt;<br>
&gt; Jonathan<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h | 3 ++-<br>
&gt;&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h b/dri=
vers/iio/common/ssp_sensors/ssp_iio_sensor.h<br>
&gt;&gt; index dda267c9bd2a..fdf61a8c499a 100644<br>
&gt;&gt; --- a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h<br>
&gt;&gt; +++ b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h<br>
&gt;&gt; @@ -53,7 +53,8 @@ static inline void ssp_convert_to_freq(u32 time,=
 int *integer_part,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 *integer_part =3D SSP_FACTOR_WITH_MS / time;<b=
r>
&gt;&gt; -=C2=A0 =C2=A0 *fractional =3D do_div(*integer_part, SSP_INVERTED_=
SCALING_FACTOR);<br>
&gt;&gt; +=C2=A0 =C2=A0 *fractional =3D *integer_part % SSP_INVERTED_SCALIN=
G_FACTOR;<br>
&gt;&gt; +=C2=A0 =C2=A0 *integer_part =3D *integer_part / SSP_INVERTED_SCAL=
ING_FACTOR;<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 /* Converts frequency to time in ms */<br>
&gt;&gt;<br>
&gt;<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-i=
io&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html<=
/a><br>
&gt;<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-iio&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</div></div></blockquote></div><br></div></div>

--047d7bf0f66606bb90050de8bdca--
