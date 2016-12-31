Return-Path: <SRS0=jLyA=YO=matheina.com=scott@kernel.org>
MIME-Version: 1.0
In-Reply-To: <59e63be5-c105-e8fc-91d0-96009d748d34@matheina.com>
References: <1482696216-8013-1-git-send-email-scott@matheina.com>
 <1482696216-8013-5-git-send-email-scott@matheina.com> <9e9dafdc-1687-9392-5087-a2b846804b7d@kernel.org>
 <59e63be5-c105-e8fc-91d0-96009d748d34@matheina.com>
From: Scott Matheina <scott@matheina.com>
Date: Fri, 30 Dec 2016 18:49:32 -0600
Message-ID: <CABSyeE5DyGGfa+f=RQyh+mf+1q4+uUW92GQAKSS4PE3QtjdWag@mail.gmail.com>
Subject: Re: [PATCHv4 4/8] Fix braces not present on all arms of if else statement
To: Jonathan Cameron <jic23@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Content-Type: multipart/alternative; boundary=94eb2c065402154d250544e9b18e
List-ID: <linux-iio@vger.kernel.org>

--94eb2c065402154d250544e9b18e
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 30, 2016 at 5:43 PM, Scott Matheina <scott@matheina.com> wrote:

>
>
> On 12/30/2016 12:46 PM, Jonathan Cameron wrote:
>
>> On 25/12/16 19:56, Scott Matheina wrote:
>>
>>> Adds braces to second arm of if else statement.
>>>
>>> Signed-off-by: Scott Matheina <scott@matheina.com>
>>>
>> This patch is actually correct so applied to the togreg branch of iio.git.
>>
>> Thanks,
>>
>> Jonathan
>>
> Thanks for the feedback. Last weekend I learned how to compile the kernel
> to test my changes, and
> I'll save your comments for my future patches to get the titles more in
> line with what is expected.
>
> Scott
>
> ---
>>>   drivers/staging/iio/addac/adt7316.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/staging/iio/addac/adt7316.c
>>> b/drivers/staging/iio/addac/adt7316.c
>>> index 2b584a0..e78d302 100644
>>> --- a/drivers/staging/iio/addac/adt7316.c
>>> +++ b/drivers/staging/iio/addac/adt7316.c
>>> @@ -661,8 +661,9 @@ static ssize_t adt7316_store_da_high_resolution(struct
>>> device *dev,
>>>                         chip->dac_bits = 12;
>>>                 else if (chip->id == ID_ADT7317 || chip->id ==
>>> ID_ADT7517)
>>>                         chip->dac_bits = 10;
>>> -       } else
>>> +       } else {
>>>                 config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
>>> +       }
>>>         ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3,
>>> config3);
>>>         if (ret)
>>>
>>>
>

--94eb2c065402154d250544e9b18e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Dec 30, 2016 at 5:43 PM, Scott Matheina <span dir=3D"ltr">&lt;<=
a href=3D"mailto:scott@matheina.com" target=3D"_blank">scott@matheina.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D""><br=
>
<br>
On 12/30/2016 12:46 PM, Jonathan Cameron wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 25/12/16 19:56, Scott Matheina wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Adds braces to second arm of if else statement.<br>
<br>
Signed-off-by: Scott Matheina &lt;<a href=3D"mailto:scott@matheina.com" tar=
get=3D"_blank">scott@matheina.com</a>&gt;<br>
</blockquote>
This patch is actually correct so applied to the togreg branch of iio.git.<=
br>
<br>
Thanks,<br>
<br>
Jonathan<br>
</blockquote></span>
Thanks for the feedback. Last weekend I learned how to compile the kernel t=
o test my changes, and<br>
I&#39;ll save your comments for my future patches to get the titles more in=
 line with what is expected.<span class=3D"HOEnZb"><font color=3D"#888888">=
<br>
<br>
Scott</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0 drivers/staging/iio/addac/adt7<wbr>316.c | 3 ++-<br>
=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/staging/iio/addac/ad<wbr>t7316.c b/drivers/staging/iio=
/addac/ad<wbr>t7316.c<br>
index 2b584a0..e78d302 100644<br>
--- a/drivers/staging/iio/addac/ad<wbr>t7316.c<br>
+++ b/drivers/staging/iio/addac/ad<wbr>t7316.c<br>
@@ -661,8 +661,9 @@ static ssize_t adt7316_store_da_high_resoluti<wbr>on(st=
ruct device *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 chip-&gt;dac_bits =3D 12;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (chip-&gt;i=
d =3D=3D ID_ADT7317 || chip-&gt;id =3D=3D ID_ADT7517)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 chip-&gt;dac_bits =3D 10;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config3 =3D chip-&g=
t;config3 &amp; (~ADT7316_DA_HIGH_RESOLUTION);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D chip-&gt;bus.write(chip-&gt;bus.clie<wb=
r>nt, ADT7316_CONFIG3, config3);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
<br>
</blockquote></blockquote>
<br>
</div></div></blockquote></div><br></div></div>

--94eb2c065402154d250544e9b18e--
