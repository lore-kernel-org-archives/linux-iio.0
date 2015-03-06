Return-Path: <somyaanand214@gmail.com>
MIME-Version: 1.0
In-Reply-To: <54F9704B.3040501@metafoo.de>
References: <1425630960-7142-1-git-send-email-somyaanand214@gmail.com>
	<CAEnQRZB9hGx1jR9YVJgQUPRzewNrj4TQ=_SnPLSK4rHvUtcU=w@mail.gmail.com>
	<54F9704B.3040501@metafoo.de>
Date: Fri, 6 Mar 2015 15:25:25 +0530
Message-ID: <CANPzvBCpHMntJJROETYw2=1AeBNkURjFmsXkk+1PF39t0kCeTA@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] Staging: iio: Change data type in
 adis16220_read_16bit to u16
From: Somya Anand <somyaanand214@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, outreachy-kernel@googlegroups.com,
	Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a113655b600cc1105109baf7e
List-ID: <linux-iio@vger.kernel.org>

--001a113655b600cc1105109baf7e
Content-Type: text/plain; charset=UTF-8

On Fri, Mar 6, 2015 at 2:45 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 03/06/2015 09:58 AM, Daniel Baluta wrote:
>
>> Hi Somya,
>>
>> On Fri, Mar 6, 2015 at 10:36 AM, Somya Anand <somyaanand214@gmail.com>
>> wrote:
>>
>>> In the adis16220_read16bit() function we earlier used a s16 value 'val'
>>> which is used by the adis_read_reg_16 function to read data and takes a
>>> u16 value as a parameter.
>>>
>>> So, this patch changes the data type of 'val' from s16 to u16 for further
>>> simplification of code and thereby avoiding unnecessary typecast.
>>>
>>> Signed-off-by: Somya Anand <somyaanand214@gmail.com>
>>>
>>
> Patch looks ok. But it changes the semantics of the function, the reason
> why this is a s16 instead of a u16 is because at some point the function
> was used to read register that contained signed 16 bit values. The code is
> essentially the short version of:
>
>         u16 uval;
>         adis_read_reg_16(&st->adis, this_attr->address, &uval);
>         sprintf("%d\n", sign_extend32(uval, 15));
>

    I have asked Daniel regarding this earlier because while reading the
code, I could not get the exact purpose of using s16. Thanks for clearing
my doubt.

>
> This patch removes the extra sign extension. Which is ok, since the only
> user of the function uses it to read a 10 unsigned value which will lead to
> the same result in both cases. But the commit message should mention this,
> since it is not just the removal of a unnecessary type cast.
>
>    Sure, I will write a better commit message so that it would be more
descriptive.

> - Lars
>

  Somya

--001a113655b600cc1105109baf7e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Mar 6, 2015 at 2:45 PM, Lars-Peter Clausen <span dir=3D"ltr">&l=
t;<a href=3D"mailto:lars@metafoo.de" target=3D"_blank">lars@metafoo.de</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 03/=
06/2015 09:58 AM, Daniel Baluta wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Somya,<br>
<br>
On Fri, Mar 6, 2015 at 10:36 AM, Somya Anand &lt;<a href=3D"mailto:somyaana=
nd214@gmail.com" target=3D"_blank">somyaanand214@gmail.com</a>&gt; wrote:<b=
r>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
In the adis16220_read16bit() function we earlier used a s16 value &#39;val&=
#39;<br>
which is used by the adis_read_reg_16 function to read data and takes a<br>
u16 value as a parameter.<br>
<br>
So, this patch changes the data type of &#39;val&#39; from s16 to u16 for f=
urther<br>
simplification of code and thereby avoiding unnecessary typecast.<br>
<br>
Signed-off-by: Somya Anand &lt;<a href=3D"mailto:somyaanand214@gmail.com" t=
arget=3D"_blank">somyaanand214@gmail.com</a>&gt;<br>
</blockquote></blockquote>
<br></span>
Patch looks ok. But it changes the semantics of the function, the reason wh=
y this is a s16 instead of a u16 is because at some point the function was =
used to read register that contained signed 16 bit values. The code is esse=
ntially the short version of:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 uval;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adis_read_reg_16(&amp;st-&gt;adis, this_attr-&g=
t;address, &amp;uval);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(&quot;%d\n&quot;, sign_extend32(uval, 1=
5));<br></blockquote><div><br></div><div>=C2=A0 =C2=A0 I have asked Daniel =
regarding this earlier because while reading the code, I could not get the =
exact purpose of using s16. Thanks for clearing my doubt.=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
This patch removes the extra sign extension. Which is ok, since the only us=
er of the function uses it to read a 10 unsigned value which will lead to t=
he same result in both cases. But the commit message should mention this, s=
ince it is not just the removal of a unnecessary type cast.<span class=3D"H=
OEnZb"><font color=3D"#888888"><br>
<br></font></span></blockquote><div>=C2=A0 =C2=A0Sure, I will write a bette=
r commit message so that it would be more descriptive. =C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><span class=3D"HOEnZb"><font color=3D"#888888">
- Lars<br></font></span></blockquote><div><br></div><div>=C2=A0 Somya=C2=A0=
</div></div><br></div></div>

--001a113655b600cc1105109baf7e--
