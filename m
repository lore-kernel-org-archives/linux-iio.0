Return-Path: <SRS0=NjE8=2R=gmail.com=karniksayli1995@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170307191746.GA22068@kroah.com>
References: <20170307191112.GA29306@sayli-HP-15-Notebook-PC> <20170307191746.GA22068@kroah.com>
From: sayli karnik <karniksayli1995@gmail.com>
Date: Wed, 8 Mar 2017 10:48:00 +0530
Message-ID: <CAKG5xWiuKm2VboRAR2ALz+SnHPbcBTQvH2Hw+Rpkfm2P+GK2Qg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: ad7280a: Group similar macros into enums
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a114949d2f839a0054a3142ee
List-ID: <linux-iio@vger.kernel.org>

--001a114949d2f839a0054a3142ee
Content-Type: text/plain; charset=UTF-8

On Wed, Mar 8, 2017 at 12:47 AM, Greg Kroah-Hartman <
gregkh@linuxfoundation.org> wrote:
> On Wed, Mar 08, 2017 at 12:41:12AM +0530, sayli karnik wrote:
>> The patch groups similar macros into enum data types.
>
> Why?
>
> What benefit does this provide?
As suggested by Lars, I converted the macros to an enum data type, so that
it is clear what their function is-
https://groups.google.com/d/msg/outreachy-kernel/VM6Wu-fJVfQ/VngpohNBAwAJ

>
>>
>> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
>> ---
>> Changes in v2:
>> Corrected the order of both the enums.
>> Used enum data type names instead of unsigned int inside struct
>> ad7280_platform_data.
>>
>>  drivers/staging/iio/adc/ad7280a.h | 24 ++++++++++++++----------
>>  1 file changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7280a.h
b/drivers/staging/iio/adc/ad7280a.h
>> index ccfb90d..e22694f 100644
>> --- a/drivers/staging/iio/adc/ad7280a.h
>> +++ b/drivers/staging/iio/adc/ad7280a.h
>> @@ -13,15 +13,19 @@
>>   * TODO: struct ad7280_platform_data needs to go into include/linux/iio
>>   */
>>
>> -#define AD7280A_ACQ_TIME_400ns                       0
>> -#define AD7280A_ACQ_TIME_800ns                       1
>> -#define AD7280A_ACQ_TIME_1200ns                      2
>> -#define AD7280A_ACQ_TIME_1600ns                      3
>> +enum ad7280a_acq_time {
>> +     AD7280A_ACQ_TIME_400ns = 0,
>> +     AD7280A_ACQ_TIME_800ns,
>> +     AD7280A_ACQ_TIME_1200ns,
>> +     AD7280A_ACQ_TIME_1600ns,
>
> Before your change, you instantly knew that the 1600ns value needed to
> be 3.  Now I need to count an enum.  Does this seem like a better
> change?

Hmm we do need to count.
But,
-I feel grouping into an enum organizes similar #defines in a better way.

-You get free compile time checking of valid values using enums. For example

public static int VALUE_ONE = 0;public static int VALUE_TWO = 1;

does not ensure,

void selectOption(int value) {...}

will only accept 0 or 1 as a parameter value. Using an enum, that is
guaranteed.

-Also it avoids the repetitive #defines.

>Are you _sure_ the compiler sets the values properly?
>
> thanks,
>
> greg k-h

--001a114949d2f839a0054a3142ee
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Mar 8, 2017 at 12:47 AM, Greg Kroah-Hartma=
n &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">gregkh@linuxfoundation.=
org</a>&gt; wrote:<br>&gt; On Wed, Mar 08, 2017 at 12:41:12AM +0530, sayli =
karnik wrote:<br>&gt;&gt; The patch groups similar macros into enum data ty=
pes.<br>&gt;<br>&gt; Why?<br>&gt;<br>&gt; What benefit does this provide?<b=
r>As suggested by Lars, I converted the macros to an enum data type, so tha=
t it is clear what their function is-<br><a href=3D"https://groups.google.c=
om/d/msg/outreachy-kernel/VM6Wu-fJVfQ/VngpohNBAwAJ">https://groups.google.c=
om/d/msg/outreachy-kernel/VM6Wu-fJVfQ/VngpohNBAwAJ<br></a><br>&gt;<br>&gt;&=
gt;<br>&gt;&gt; Signed-off-by: sayli karnik &lt;<a href=3D"mailto:karniksay=
li1995@gmail.com">karniksayli1995@gmail.com</a>&gt;<br>&gt;&gt; ---<br>&gt;=
&gt; Changes in v2:<br>&gt;&gt; Corrected the order of both the enums.<br>&=
gt;&gt; Used enum data type names instead of unsigned int inside struct<br>=
&gt;&gt; ad7280_platform_data.<br>&gt;&gt;<br>&gt;&gt; =C2=A0drivers/stagin=
g/iio/adc/ad7280a.h | 24 ++++++++++++++----------<br>&gt;&gt; =C2=A01 file =
changed, 14 insertions(+), 10 deletions(-)<br>&gt;&gt;<br>&gt;&gt; diff --g=
it a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h<=
br>&gt;&gt; index ccfb90d..e22694f 100644<br>&gt;&gt; --- a/drivers/staging=
/iio/adc/ad7280a.h<br>&gt;&gt; +++ b/drivers/staging/iio/adc/ad7280a.h<br>&=
gt;&gt; @@ -13,15 +13,19 @@<br>&gt;&gt; =C2=A0 * TODO: struct ad7280_platfo=
rm_data needs to go into include/linux/iio<br>&gt;&gt; =C2=A0 */<br>&gt;&gt=
;<br>&gt;&gt; -#define AD7280A_ACQ_TIME_400ns =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>&gt;&gt; -#define AD7=
280A_ACQ_TIME_800ns =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 1<br>&gt;&gt; -#define AD7280A_ACQ_TIME_1200ns =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>=
&gt;&gt; -#define AD7280A_ACQ_TIME_1600ns =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>&gt;&gt; +enum ad7280a_ac=
q_time {<br>&gt;&gt; + =C2=A0 =C2=A0 AD7280A_ACQ_TIME_400ns =3D 0,<br>&gt;&=
gt; + =C2=A0 =C2=A0 AD7280A_ACQ_TIME_800ns,<br>&gt;&gt; + =C2=A0 =C2=A0 AD7=
280A_ACQ_TIME_1200ns,<br>&gt;&gt; + =C2=A0 =C2=A0 AD7280A_ACQ_TIME_1600ns,<=
br>&gt;<br>&gt; Before your change, you instantly knew that the 1600ns valu=
e needed to<br>&gt; be 3.=C2=A0 Now I need to count an enum.=C2=A0 Does thi=
s seem like a better<br>&gt; change?<br><br>Hmm we do need to count.<br>But=
,<br>-I feel grouping into an enum organizes similar #defines in a better w=
ay.<br><br>-You get free compile time checking of valid values using enums.=
 For example<br><pre class=3D"gmail-lang-java gmail-prettyprint gmail-prett=
yprinted"><code><span class=3D"gmail-kwd">public</span><span class=3D"gmail=
-pln"> </span><span class=3D"gmail-kwd">static</span><span class=3D"gmail-p=
ln"> </span><span class=3D"gmail-kwd">int</span><span class=3D"gmail-pln"> =
VALUE_ONE </span><span class=3D"gmail-pun">=3D</span><span class=3D"gmail-p=
ln"> </span><span class=3D"gmail-lit">0</span><span class=3D"gmail-pun">;</=
span><span class=3D"gmail-pln">
</span><span class=3D"gmail-kwd">public</span><span class=3D"gmail-pln"> </=
span><span class=3D"gmail-kwd">static</span><span class=3D"gmail-pln"> </sp=
an><span class=3D"gmail-kwd">int</span><span class=3D"gmail-pln"> VALUE_TWO=
 </span><span class=3D"gmail-pun">=3D</span><span class=3D"gmail-pln"> </sp=
an><span class=3D"gmail-lit">1</span><span class=3D"gmail-pun">;</span></co=
de></pre>

<p>does not ensure, </p>

<pre class=3D"gmail-lang-java gmail-prettyprint gmail-prettyprinted"><code>=
<span class=3D"gmail-kwd">void</span><span class=3D"gmail-pln"> selectOptio=
n</span><span class=3D"gmail-pun">(</span><span class=3D"gmail-kwd">int</sp=
an><span class=3D"gmail-pln"> value</span><span class=3D"gmail-pun">)</span=
><span class=3D"gmail-pln"> </span><span class=3D"gmail-pun">{</span><span =
class=3D"gmail-pln">
</span><span class=3D"gmail-pun">...</span><span class=3D"gmail-pln">
</span><span class=3D"gmail-pun">}</span></code></pre>

will only accept 0 or 1 as a parameter value. Using an enum, that is guaran=
teed.<br><br>-Also it avoids the repetitive #defines.<br><br>&gt;Are you _s=
ure_ the compiler sets the values properly?<br>&gt;<br>&gt; thanks,<br>&gt;=
<br>&gt; greg k-h</div>

--001a114949d2f839a0054a3142ee--
