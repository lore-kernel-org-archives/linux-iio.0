Return-Path: <jic23@cam.ac.uk>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org> <1334754834-13622-5-git-send-email-jic23@kernel.org> <4F91944F.3070701@metafoo.de>
In-Reply-To: <4F91944F.3070701@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----7Z4WO889FZXC5PQ1P57FWPSEOD6JBK"
Subject: Re: [PATCH 04/14] staging:iio: add caching of the number of bytes in a scan.
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Fri, 20 Apr 2012 18:02:22 +0100
To: Lars-Peter Clausen <lars@metafoo.de>,Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Message-ID: <0a602972-fb5c-43b6-a1ff-ec292dea5ad0@email.android.com>
List-ID: <linux-iio@vger.kernel.org>

------7Z4WO889FZXC5PQ1P57FWPSEOD6JBK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
 charset=UTF-8


Odd will chase that down. Probably wasn't on a clean tree. Thanks!

-- 
Se=
nt from my Android phone with K-9 Mail. Please excuse my brevity.

Lars-Pet=
er Clausen <lars@metafoo.de> wrote:

On 04/18/2012 03:13 PM, Jonathan Camer=
on wrote:
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
> [...=
]
> diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/stagin=
g/iio/industrialio-buffer.c
> index efa44c4..f6cb0ab 100644
> --- a/drivers=
/staging/iio/industrialio-buffer.c
> +++ b/drivers/staging/iio/industrialio=
-buffer.c
> @@ -536,13 +536,13 @@ static int iio_compute_scan_bytes(struct =
iio_dev *indio_dev, const long *mask,
> int iio_sw_buffer_preenable(struct =
iio_dev *indio_dev)
> {
> 	struct iio_buffer *buffer =3D indio_dev->buffer;=

> -	unsigned bytes =3D 0;

This line didn't apply.


------7Z4WO889FZXC5PQ1P57FWPSEOD6JBK
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><br>
Odd will chase that down.  Probably wasn&#39;=
t on a clean tree.  Thanks!<br>
<br>
-- <br>
Sent from my Android phone wit=
h K-9 Mail. Please excuse my brevity.<br><br><div class=3D"gmail_quote">Lar=
s-Peter Clausen &lt;lars@metafoo.de&gt; wrote:<blockquote class=3D"gmail_qu=
ote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 20=
4, 204); padding-left: 1ex;">
<pre style=3D"white-space: pre-wrap; word-wra=
p:break-word; font-family: sans-serif">On 04/18/2012 03:13 PM, Jonathan Cam=
eron wrote:<br />&gt; Signed-off-by: Jonathan Cameron &lt;jic23@kernel.org&=
gt;<br />&gt; ---<br />&gt; [...]<br />&gt; diff --git a/drivers/staging/ii=
o/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c<br />&g=
t; index efa44c4..f6cb0ab 100644<br />&gt; --- a/drivers/staging/iio/indust=
rialio-buffer.c<br />&gt; +++ b/drivers/staging/iio/industrialio-buffer.c<b=
r />&gt; @@ -536,13 +536,13 @@ static int iio_compute_scan_bytes(struct iio=
_dev *indio_dev, const long *mask,<br />&gt;  int iio_sw_buffer_preenable(s=
truct iio_dev *indio_dev)<br />&gt;  {<br />&gt;  	struct iio_buffer *buffe=
r =3D indio_dev-&gt;buffer;<br />&gt; -	unsigned bytes =3D 0;<br /><br />Th=
is line didn't apply.<br /></pre></blockquote></div></body></html>
------7Z4WO889FZXC5PQ1P57FWPSEOD6JBK--
