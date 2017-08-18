Return-Path: <SRS0=yyGB=7U=gmail.com=s.abhisit@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMV_pUYqGnDQmn+j9y85e9y8f7nuewAHTnDxm-goJ+mW-kMhUg@mail.gmail.com>
References: <1501578742-4501-1-git-send-email-s.abhisit@gmail.com>
 <alpine.DEB.2.20.1708011317000.5987@vps.pmeerw.net> <20170811143847.GA19152@localhost>
 <CAMV_pUa0XvzNYcR0ryHSt=qsdLKCtOLfQNz3LsWxaj9VGmFxLw@mail.gmail.com>
 <20170818025835.GE19152@localhost> <CAMV_pUYqGnDQmn+j9y85e9y8f7nuewAHTnDxm-goJ+mW-kMhUg@mail.gmail.com>
From: Abhisit Sangjan <s.abhisit@gmail.com>
Date: Fri, 18 Aug 2017 14:42:59 +0700
Message-ID: <CAMV_pUaM5MAYL_R+0_9uW52fmp+c5XjBNyWeMFZqCx3MUWD59g@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: Add support for LMP92001 ADC
To: jmondi <jacopo@jmondi.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	fabrice.gasnier@st.com, Lee Jones <lee.jones@linaro.org>, robh@kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>, marek.vasut+renesas@gmail.com,
	jacopo+renesas@jmondi.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a114076ac32a4a8055702472e"
List-ID: <linux-iio@vger.kernel.org>

--001a114076ac32a4a8055702472e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jmondi,

After I removed those cases, I got warnings "no handled in switch".

On Fri, Aug 18, 2017 at 10:15 AM, Abhisit Sangjan <s.abhisit@gmail.com>
wrote:

> Hi Jmondi,
>
> On Fri, Aug 18, 2017 at 9:58 AM, jmondi <jacopo@jmondi.org> wrote:
>
>> Hi Abhisit,
>>
>> On Fri, Aug 18, 2017 at 09:34:16AM +0700, Abhisit Sangjan wrote:
>> > Hi Jmondi,
>> >
>> > Thank you for your recommend, I am testing the code will be send the n=
ew
>> > patch in soon.
>>
>> [snip]
>>
>> > > > > +
>> > > > > +        switch (mask)
>> > > > > +        {
>> > > > > +        case IIO_CHAN_INFO_RAW:
>> > > > > +                switch (channel->type) {
>> > > > > +                case IIO_VOLTAGE:
>> > > > > +                case IIO_TEMP:
>> > > > > +                        *val =3D code;
>> > > > > +                        return IIO_VAL_INT;
>> > > > > +                default:
>> > > > > +                        break;
>> > > > > +                }
>> > > > > +                break;
>> > > > > +        default:
>> > > > > +                break;
>> > >
>> > > You can remove these default cases or return -EINVAL here.
>> > >
>> >
>> > Abhisit: Okay, I will remove it.
>> >              Could you tell me in detail. Sorry, I do not understand t=
he
>> > Technical.
>>
>> This can potentially be reduced to
>>
>>         switch (mask) {
>>         case IIO_CHAN_INFO_RAW:
>>                 switch (channel->type) {
>>                 case IIO_VOLTAGE:
>>                 case IIO_TEMP:
>>                         *val =3D code;
>>                         return IIO_VAL_INT;
>>                 }
>>          }
>>
>>          return -EINVAL;
>>
>>
>> But that's definitely not a big deal, there are no optimization in
>> this code change, just less typing and less default: and break; here
>> and there
>>
>
> Abhisit: Thank you so much.
>

Abhisit: If I remove those default cases, I got the warning. How do I would
do next to fix warning?  Should I leave this code as it?

# What have I changed.
diff --git a/drivers/iio/adc/lmp92001-adc.c b/drivers/iio/adc/lmp92001-adc.=
c
index 68f7a6c..ebc6423 100644
--- a/drivers/iio/adc/lmp92001-adc.c
+++ b/drivers/iio/adc/lmp92001-adc.c
@@ -92,12 +92,7 @@ static int lmp92001_read_raw(struct iio_dev *indio_dev,
                case IIO_TEMP:
                        *val =3D code;
                        return IIO_VAL_INT;
-               default:
-                       break;
                }
-               break;
-       default:
-               break;
        }

        return -EINVAL;

# Compilation.
  CC      drivers/iio/adc/lmp92001-adc.o
drivers/iio/adc/lmp92001-adc.c: In function =E2=80=98lmp92001_read_raw=E2=
=80=99:
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_CURRENT=E2=80=99 not handled in switch [-Wswitch]
   switch (channel->type) {
   ^
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98II=
O_POWER=E2=80=99
not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98II=
O_ACCEL=E2=80=99
not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_ANGL_VEL=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98II=
O_MAGN=E2=80=99
not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98II=
O_LIGHT=E2=80=99
not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_INTENSITY=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_PROXIMITY=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98II=
O_INCLI=E2=80=99
not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98II=
O_ROT=E2=80=99
not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98II=
O_ANGL=E2=80=99
not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_TIMESTAMP=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_CAPACITANCE=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_ALTVOLTAGE=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98II=
O_CCT=E2=80=99
not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_PRESSURE=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_HUMIDITYRELATIVE=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_ACTIVITY=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98II=
O_STEPS=E2=80=99
not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_ENERGY=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_DISTANCE=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_VELOCITY=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_CONCENTRATION=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_RESISTANCE=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98II=
O_PH=E2=80=99
not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_UVINDEX=E2=80=99 not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_ELECTRICALCONDUCTIVITY=E2=80=99 not handled in switch [-Wswitc=
h]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98II=
O_COUNT=E2=80=99
not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98II=
O_INDEX=E2=80=99
not handled in switch [-Wswitch]
drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
=E2=80=98IIO_GRAVITY=E2=80=99 not handled in switch [-Wswitch]


>
>
>

--001a114076ac32a4a8055702472e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jmondi,<div><br></div><div>After I removed those cases,=
 I got warnings &quot;no handled in switch&quot;.<br><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Fri, Aug 18, 2017 at 10:15 AM, Abhis=
it Sangjan <span dir=3D"ltr">&lt;<a href=3D"mailto:s.abhisit@gmail.com" tar=
get=3D"_blank">s.abhisit@gmail.com</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi Jmondi,<br><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote"><div><div class=3D"gmail-h=
5">On Fri, Aug 18, 2017 at 9:58 AM, jmondi <span dir=3D"ltr">&lt;<a href=3D=
"mailto:jacopo@jmondi.org" target=3D"_blank">jacopo@jmondi.org</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Abhisit,<=
br>
<span class=3D"gmail-m_-4953535802396394356gmail-"><br>
On Fri, Aug 18, 2017 at 09:34:16AM +0700, Abhisit Sangjan wrote:<br>
&gt; Hi Jmondi,<br>
&gt;<br>
&gt; Thank you for your recommend, I am testing the code will be send the n=
ew<br>
&gt; patch in soon.<br>
<br>
</span>[snip]<br>
<span class=3D"gmail-m_-4953535802396394356gmail-"><br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (mask)<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_CHAN_INFO_RAW:<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 switch (channel-&gt;type) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 case IIO_VOLTAGE:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 case IIO_TEMP:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D code;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IIO_VAL_INT;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;<br>
&gt; &gt;<br>
&gt; &gt; You can remove these default cases or return -EINVAL here.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Abhisit: Okay, I will remove it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Could you tell me in d=
etail. Sorry, I do not understand the<br>
&gt; Technical.<br>
<br>
</span>This can potentially be reduced to<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (mask) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_CHAN_INFO_RAW:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (channel-&gt=
;type) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_VOLTAGE:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_TEMP:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *val =3D code;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return IIO_VAL_INT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
<br>
<br>
But that&#39;s definitely not a big deal, there are no optimization in<br>
this code change, just less typing and less default: and break; here<br>
and there<br></blockquote><div><br></div></div></div><div>Abhisit: Thank yo=
u so much.</div></div></div></div></blockquote><div><br></div><div>Abhisit:=
 If I remove those default cases, I got the warning. How do I would do next=
 to fix warning?=C2=A0 Should I leave this code as it?</div><div><br></div>=
<div><font color=3D"#0000ff"># What have I changed.</font></div><div><div>d=
iff --git a/drivers/iio/adc/lmp92001-adc.c b/drivers/iio/adc/lmp92001-adc.c=
</div><div>index 68f7a6c..ebc6423 100644</div><div>--- a/drivers/iio/adc/lm=
p92001-adc.c</div><div>+++ b/drivers/iio/adc/lmp92001-adc.c</div><div>@@ -9=
2,12 +92,7 @@ static int lmp92001_read_raw(struct iio_dev *indio_dev,</div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_TEMP:=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *val =3D code;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IIO_VAL_INT;=
</div><div>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:</div=
><div>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }</div><div>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b=
reak;</div><div>- =C2=A0 =C2=A0 =C2=A0 default:</div><div>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }</div><div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIN=
VAL;</div></div><div><br></div><div><font color=3D"#0000ff"># Compilation.<=
/font></div><div><div>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0drivers/iio/adc/lmp9200=
1-adc.o</div><div>drivers/iio/adc/lmp92001-adc.c: In function =E2=80=98lmp9=
2001_read_raw=E2=80=99:</div><div>drivers/iio/adc/lmp92001-adc.c:90:3: warn=
ing: enumeration value =E2=80=98IIO_CURRENT=E2=80=99 not handled in switch =
[-Wswitch]</div><div>=C2=A0 =C2=A0switch (channel-&gt;type) {</div><div>=C2=
=A0 =C2=A0^</div><div>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumera=
tion value =E2=80=98IIO_POWER=E2=80=99 not handled in switch [-Wswitch]</di=
v><div>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=
=80=98IIO_ACCEL=E2=80=99 not handled in switch [-Wswitch]</div><div>drivers=
/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98IIO_ANGL_=
VEL=E2=80=99 not handled in switch [-Wswitch]</div><div>drivers/iio/adc/lmp=
92001-adc.c:90:3: warning: enumeration value =E2=80=98IIO_MAGN=E2=80=99 not=
 handled in switch [-Wswitch]</div><div>drivers/iio/adc/lmp92001-adc.c:90:3=
: warning: enumeration value =E2=80=98IIO_LIGHT=E2=80=99 not handled in swi=
tch [-Wswitch]</div><div>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enum=
eration value =E2=80=98IIO_INTENSITY=E2=80=99 not handled in switch [-Wswit=
ch]</div><div>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration val=
ue =E2=80=98IIO_PROXIMITY=E2=80=99 not handled in switch [-Wswitch]</div><d=
iv>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=
=98IIO_INCLI=E2=80=99 not handled in switch [-Wswitch]</div><div>drivers/ii=
o/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98IIO_ROT=E2=
=80=99 not handled in switch [-Wswitch]</div><div>drivers/iio/adc/lmp92001-=
adc.c:90:3: warning: enumeration value =E2=80=98IIO_ANGL=E2=80=99 not handl=
ed in switch [-Wswitch]</div><div>drivers/iio/adc/lmp92001-adc.c:90:3: warn=
ing: enumeration value =E2=80=98IIO_TIMESTAMP=E2=80=99 not handled in switc=
h [-Wswitch]</div><div>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumer=
ation value =E2=80=98IIO_CAPACITANCE=E2=80=99 not handled in switch [-Wswit=
ch]</div><div>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration val=
ue =E2=80=98IIO_ALTVOLTAGE=E2=80=99 not handled in switch [-Wswitch]</div><=
div>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=
=98IIO_CCT=E2=80=99 not handled in switch [-Wswitch]</div><div>drivers/iio/=
adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98IIO_PRESSURE=
=E2=80=99 not handled in switch [-Wswitch]</div><div>drivers/iio/adc/lmp920=
01-adc.c:90:3: warning: enumeration value =E2=80=98IIO_HUMIDITYRELATIVE=E2=
=80=99 not handled in switch [-Wswitch]</div><div>drivers/iio/adc/lmp92001-=
adc.c:90:3: warning: enumeration value =E2=80=98IIO_ACTIVITY=E2=80=99 not h=
andled in switch [-Wswitch]</div><div>drivers/iio/adc/lmp92001-adc.c:90:3: =
warning: enumeration value =E2=80=98IIO_STEPS=E2=80=99 not handled in switc=
h [-Wswitch]</div><div>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumer=
ation value =E2=80=98IIO_ENERGY=E2=80=99 not handled in switch [-Wswitch]</=
div><div>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =
=E2=80=98IIO_DISTANCE=E2=80=99 not handled in switch [-Wswitch]</div><div>d=
rivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98IIO=
_VELOCITY=E2=80=99 not handled in switch [-Wswitch]</div><div>drivers/iio/a=
dc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98IIO_CONCENTRATI=
ON=E2=80=99 not handled in switch [-Wswitch]</div><div>drivers/iio/adc/lmp9=
2001-adc.c:90:3: warning: enumeration value =E2=80=98IIO_RESISTANCE=E2=80=
=99 not handled in switch [-Wswitch]</div><div>drivers/iio/adc/lmp92001-adc=
.c:90:3: warning: enumeration value =E2=80=98IIO_PH=E2=80=99 not handled in=
 switch [-Wswitch]</div><div>drivers/iio/adc/lmp92001-adc.c:90:3: warning: =
enumeration value =E2=80=98IIO_UVINDEX=E2=80=99 not handled in switch [-Wsw=
itch]</div><div>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration v=
alue =E2=80=98IIO_ELECTRICALCONDUCTIVITY=E2=80=99 not handled in switch [-W=
switch]</div><div>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration=
 value =E2=80=98IIO_COUNT=E2=80=99 not handled in switch [-Wswitch]</div><d=
iv>drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=
=98IIO_INDEX=E2=80=99 not handled in switch [-Wswitch]</div><div>drivers/ii=
o/adc/lmp92001-adc.c:90:3: warning: enumeration value =E2=80=98IIO_GRAVITY=
=E2=80=99 not handled in switch [-Wswitch]</div></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div>=C2=A0</div></div><br></di=
v></div>
</blockquote></div><br></div></div></div>

--001a114076ac32a4a8055702472e--
