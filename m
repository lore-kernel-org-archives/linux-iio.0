Return-Path: <srinivas.pandruvada@intel.com>
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "Jonathan Cameron (jic23@kernel.org)" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: KFiFo Poll support
Date: Mon, 27 Aug 2012 17:24:29 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A9193ADCB4@ORSMSX104.amr.corp.intel.com>
Content-Type: multipart/alternative;
	boundary="_000_4FA419E87744DF4DAECD5BCE1214B7A9193ADCB4ORSMSX104amrcor_"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

--_000_4FA419E87744DF4DAECD5BCE1214B7A9193ADCB4ORSMSX104amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

You have circulated a patch to support polling on KFifo, but that was never=
 merged.

I have used in my tree with your authorship:

commit ae09253bf19a607ea0614051ba0bdb04d5f23689
Author: Jonathan Cameron <jic23@kernel.org>
Date:   Fri Jun 8 13:08:53 2012 -0700

    KFiFO : Poll support

    Implements poll system call support on IIO Kfifo buffers.

    Change-Id: I6739382b7b81951e5b4498fc04356b3652941058
    Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 6bf9d05..e8033a4 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -6,6 +6,7 @@
#include <linux/kfifo.h>
#include <linux/mutex.h>
#include <linux/iio/kfifo_buf.h>
+#include <linux/sched.h>
 struct iio_kfifo {
               struct iio_buffer buffer;
@@ -35,6 +36,7 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
               kfifo_free(&buf->kf);
               ret =3D __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datu=
m,
                                                                  buf->buff=
er.length);
+             r->stufftoread =3D false;
error_ret:
               return ret;
}
@@ -97,6 +99,8 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
               ret =3D kfifo_in(&kf->kf, data, r->bytes_per_datum);
               if (ret !=3D r->bytes_per_datum)
                               return -EBUSY;
+             r->stufftoread =3D true;
+             wake_up_interruptible(&r->pollq);
               return 0;
}
@@ -111,6 +115,11 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r=
,
                n =3D rounddown(n, r->bytes_per_datum);
               ret =3D kfifo_to_user(&kf->kf, buf, n, &copied);
+             if (kfifo_is_empty(&kf->kf))
+                             r->stufftoread =3D false;
+             /* verify it is still empty to avoid race */
+             if (!kfifo_is_empty(&kf->kf))
+                             r->stufftoread =3D true;
                return copied;
}

Thanks,
Srinivas

--_000_4FA419E87744DF4DAECD5BCE1214B7A9193ADCB4ORSMSX104amrcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Jonathan,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">You have circulated a patch to support polling on KF=
ifo, but that was never merged.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have used in my tree with your authorship:<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">commit ae09253bf19a607ea0614051ba0bdb04d5f23689<o:p>=
</o:p></p>
<p class=3D"MsoNormal">Author: Jonathan Cameron &lt;jic23@kernel.org&gt;<o:=
p></o:p></p>
<p class=3D"MsoNormal">Date:&nbsp;&nbsp; Fri Jun 8 13:08:53 2012 -0700<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; KFiFO : Poll support<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;Implements poll system call =
support on IIO Kfifo buffers.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;Change-Id: I6739382b7b81951e=
5b4498fc04356b3652941058<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Signed-off-by: srinivas pandruvad=
a &lt;srinivas.pandruvada@intel.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/k=
fifo_buf.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 6bf9d05..e8033a4 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/iio/kfifo_buf.c<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/drivers/iio/kfifo_buf.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">@@ -6,6 &#43;6,7 @@<o:p></o:p></p>
<p class=3D"MsoNormal">#include &lt;linux/kfifo.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &lt;linux/mutex.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &lt;linux/iio/kfifo_buf.h&gt;<o:p></o:p></p=
>
<p class=3D"MsoNormal">&#43;#include &lt;linux/sched.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;struct iio_kfifo {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct iio_buffer buffer;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -35,6 &#43;36,7 @@ static int iio_request_update_=
kfifo(struct iio_buffer *r)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfifo_free(&amp;buf-&gt;kf);<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D __iio_allocate_kfifo(buf, buf-&gt;=
buffer.bytes_per_datum,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;buf-&gt;buffer.length);<o:p></o:p></=
p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; r-&gt;stufftoread =3D false;<o:p></o:p></p>
<p class=3D"MsoNormal">error_ret:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -97,6 &#43;99,8 @@ static int iio_store_to_kfifo(=
struct iio_buffer *r,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kfifo_in(&amp;kf-&gt;kf, data, r-&=
gt;bytes_per_datum);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret !=3D r-&gt;bytes_per_datum)<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EBUSY;<o:p></=
o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; r-&gt;stufftoread =3D true;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; wake_up_interruptible(&amp;r-&gt;pollq);<o:p></o:=
p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">@@ -111,6 &#43;115,11 @@ static int iio_read_first_n=
_kfifo(struct iio_buffer *r,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n =3D rounddown(n, r-&gt;bytes_per_d=
atum);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kfifo_to_user(&amp;kf-&gt;kf, buf,=
 n, &amp;copied);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (kfifo_is_empty(&amp;kf-&gt;kf))<o:p></o:p></p=
>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r-&gt;stufftoread =3D false;=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /* verify it is still empty to avoid race */<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (!kfifo_is_empty(&amp;kf-&gt;kf))<o:p></o:p></=
p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r-&gt;stufftoread =3D true;<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return copied;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Srinivas<o:p></o:p></p>
</div>
</body>
</html>

--_000_4FA419E87744DF4DAECD5BCE1214B7A9193ADCB4ORSMSX104amrcor_--
