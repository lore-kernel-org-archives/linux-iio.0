Return-Path: <SRS0=3LEA=4O=gmail.com=harinath922@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170508043228.GA1553@kroah.com>
References: <1494216977-26852-1-git-send-email-harinath922@gmail.com> <20170508043228.GA1553@kroah.com>
From: harinath Nampally <harinath922@gmail.com>
Date: Mon, 8 May 2017 01:35:33 -0400
Message-ID: <CAAGUq_rn1SA2wAH8vs_bHWFsKMi-0tYaJAV7rETM7TzcEb97nw@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: meter: This patch fixes warnings found in ade7753.c
To: Greg KH <gregkh@linuxfoundation.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	Michael.Hennerich@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, jic23@kernel.org
Content-Type: multipart/alternative; boundary=001a113a90c0a84d45054efc9b88
List-ID: <linux-iio@vger.kernel.org>

--001a113a90c0a84d45054efc9b88
Content-Type: text/plain; charset=UTF-8

Hi Greg,

Thank you so much for your time to review.
Sure I will break up into multiple patches and create patch series.
But I wonder 'one thing' per patch means one kind of warnings per patch?
For example if I have multiple fixes for similar warnings like 'Symbolic
permissions'. Can they all go in a single patch.
 So patch 0/10 for all 'Symbolic permissions' and path 1/10 for all
'alignment warnings' and so on and so forth.

Please let me know.

Thanks,
Harinath


On May 8, 2017 12:32 AM, "Greg KH" <gregkh@linuxfoundation.org> wrote:

On Mon, May 08, 2017 at 12:16:17AM -0400, Harinath Nampally wrote:
> All below warnings are found and fixed by checkpatch.pl:
> CHECK: struct mutex definition without comment
> CHECK: Alignment should match open parenthesis
> WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred.

You should only don "one thing" per patch, and no, "fix coding style
issues" is not "one thing" :)

Please break this up into multiple patches and send it as a patch
series.

thanks,

greg k-h

--001a113a90c0a84d45054efc9b88
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><span style=3D"font-family:sans-serif;font-size:13.6=
96px">Hi Greg,</span><div dir=3D"auto" style=3D"font-family:sans-serif;font=
-size:13.696px"><br></div><span style=3D"font-family:sans-serif;font-size:1=
3.696px">Thank you so much for your time to review.=C2=A0</span><div dir=3D=
"auto" style=3D"font-family:sans-serif;font-size:13.696px">Sure I will brea=
k up into multiple patches and create patch series.</div><div dir=3D"auto" =
style=3D"font-family:sans-serif;font-size:13.696px">But I wonder &#39;one t=
hing&#39; per patch means one kind of warnings per patch?</div><div dir=3D"=
auto" style=3D"font-family:sans-serif;font-size:13.696px">For example if I =
have multiple fixes for similar warnings like &#39;Symbolic permissions&#39=
;. Can they all go in a single patch.</div><div dir=3D"auto" style=3D"font-=
family:sans-serif;font-size:13.696px">=C2=A0So patch 0/10 for all &#39;Symb=
olic permissions&#39; and path 1/10 for all &#39;alignment warnings&#39; an=
d so on and so forth.</div><div dir=3D"auto" style=3D"font-family:sans-seri=
f;font-size:13.696px"><br></div><div dir=3D"auto" style=3D"font-family:sans=
-serif;font-size:13.696px">Please let me know.</div><div dir=3D"auto" style=
=3D"font-family:sans-serif;font-size:13.696px"><br></div><div dir=3D"auto" =
style=3D"font-family:sans-serif;font-size:13.696px">Thanks,</div><div dir=
=3D"auto" style=3D"font-family:sans-serif;font-size:13.696px">Harinath</div=
><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On May 8, 20=
17 12:32 AM, &quot;Greg KH&quot; &lt;<a href=3D"mailto:gregkh@linuxfoundati=
on.org">gregkh@linuxfoundation.org</a>&gt; wrote:<br type=3D"attribution"><=
blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><div class=3D"quoted-text">On Mon, May 08, 2017 at =
12:16:17AM -0400, Harinath Nampally wrote:<br>
&gt; All below warnings are found and fixed by <a href=3D"http://checkpatch=
.pl" rel=3D"noreferrer" target=3D"_blank">checkpatch.pl</a>:<br>
&gt; CHECK: struct mutex definition without comment<br>
&gt; CHECK: Alignment should match open parenthesis<br>
&gt; WARNING: Symbolic permissions &#39;S_IWUSR | S_IRUGO&#39; are not pref=
erred.<br>
<br>
</div>You should only don &quot;one thing&quot; per patch, and no, &quot;fi=
x coding style<br>
issues&quot; is not &quot;one thing&quot; :)<br>
<br>
Please break this up into multiple patches and send it as a patch<br>
series.<br>
<br>
thanks,<br>
<br>
greg k-h<br>
</blockquote></div><br></div></div></div>

--001a113a90c0a84d45054efc9b88--
