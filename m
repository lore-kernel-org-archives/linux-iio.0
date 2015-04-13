Return-Path: <imsaurabhrawat@gmail.com>
MIME-Version: 1.0
In-Reply-To: <B74F5E0D-FE1C-422F-9D2E-985137E684E7@jic23.retrosnub.co.uk>
References: <CALwa49vRGN_VaJ147PVF8Cf+8vnBotWVh7hmxLj=jaAba5QTTw@mail.gmail.com>
 <5526BD63.3080509@kernel.org> <CALwa49st7A1zSdCmy8Sq8KgAMXiGJySdpoxALTUNEubgvXqyWg@mail.gmail.com>
 <9B863FBE-8332-47EB-8E6C-C8943EF5D185@kernel.org> <CALwa49us7JVeYYga7fJxMx0=EbyLMuaAASGhU8=9AWYV2u96uQ@mail.gmail.com>
 <B74F5E0D-FE1C-422F-9D2E-985137E684E7@jic23.retrosnub.co.uk>
From: "s.rawat" <imsaurabhrawat@gmail.com>
Date: Mon, 13 Apr 2015 15:21:34 +0530
Message-ID: <CALwa49t1z_CFW4j-p6g0UUwk_pD9i2Ep+U7W3nNXtGOkdqZaug@mail.gmail.com>
Subject: Re: Regarding generic_buffer.c Application for Android
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: multipart/alternative; boundary=047d7ba976c871233c051398103e
List-ID: <linux-iio@vger.kernel.org>

--047d7ba976c871233c051398103e
Content-Type: text/plain; charset=UTF-8

+closedir(dp)
+dp = opendir(scan_el_dir);

This seems to work fine.But sometimes polling accel throws error : failed
to open /dev/iio:device0

On Mon, Apr 13, 2015 at 11:56 AM, Jonathan Cameron <
jic23@jic23.retrosnub.co.uk> wrote:

>
>
> On 13 April 2015 04:40:17 BST, "s.rawat" <imsaurabhrawat@gmail.com> wrote:
> >On Fri, Apr 10, 2015 at 11:49 AM, Jonathan Cameron <jic23@kernel.org>
> >wrote:
> >> Hit google
> >> http://pubs.opengroup.org/onlinepubs/009695399/functions/seekdir.html
> >> So for POSIX compliance they are optional.
> >
> >You mean seekdir(dp, 0); in function inline int
> >build_channel_array(...) is optional?If I comment it, will it have no
> >effect? This function is called inside main() of generic_buffer.c and
> >I cant get it compiled with the tool chain I have.Is there any
> >alternate code I can replace it with if it is Not Optional?
> The functionality is not optional. There is no obligation for the
> operating system to implement seekdir.
>
> Here equivalent is probably to close and reopen the directory.
> >
> >I can take care of le16toh/be16toh.
> >
> >Thanks and Rgds,
> >S
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
>

--047d7ba976c871233c051398103e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra" style=3D"font-size:13px"><div c=
lass=3D"gmail_extra">+closedir(dp)</div><div class=3D"gmail_extra">+dp =3D =
opendir(scan_el_dir);</div></div><br style=3D"font-size:13px"><span style=
=3D"font-size:13px">This seems to work fine.But sometimes polling accel thr=
ows error : failed to open /dev/iio:device0=C2=A0</span><br></div><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Apr 13, 2015 at 11=
:56 AM, Jonathan Cameron <span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@jic2=
3.retrosnub.co.uk" target=3D"_blank">jic23@jic23.retrosnub.co.uk</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div cl=
ass=3D"h5"><br>
<br>
On 13 April 2015 04:40:17 BST, &quot;s.rawat&quot; &lt;<a href=3D"mailto:im=
saurabhrawat@gmail.com">imsaurabhrawat@gmail.com</a>&gt; wrote:<br>
&gt;On Fri, Apr 10, 2015 at 11:49 AM, Jonathan Cameron &lt;<a href=3D"mailt=
o:jic23@kernel.org">jic23@kernel.org</a>&gt;<br>
&gt;wrote:<br>
&gt;&gt; Hit google<br>
&gt;&gt; <a href=3D"http://pubs.opengroup.org/onlinepubs/009695399/function=
s/seekdir.html" target=3D"_blank">http://pubs.opengroup.org/onlinepubs/0096=
95399/functions/seekdir.html</a><br>
&gt;&gt; So for POSIX compliance they are optional.<br>
&gt;<br>
&gt;You mean seekdir(dp, 0); in function inline int<br>
&gt;build_channel_array(...) is optional?If I comment it, will it have no<b=
r>
&gt;effect? This function is called inside main() of generic_buffer.c and<b=
r>
&gt;I cant get it compiled with the tool chain I have.Is there any<br>
&gt;alternate code I can replace it with if it is Not Optional?<br>
</div></div>The functionality is not optional. There is no obligation for t=
he operating system to implement seekdir.<br>
<br>
Here equivalent is probably to close and reopen the directory.<br>
<span class=3D"im HOEnZb">&gt;<br>
&gt;I can take care of le16toh/be16toh.<br>
&gt;<br>
&gt;Thanks and Rgds,<br>
&gt;S<br>
<br>
</span><div class=3D"HOEnZb"><div class=3D"h5">--<br>
Sent from my Android device with K-9 Mail. Please excuse my brevity.<br>
</div></div></blockquote></div><br></div>

--047d7ba976c871233c051398103e--
