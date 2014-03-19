Return-Path: <alecaberg@google.com>
MIME-Version: 1.0
In-Reply-To: <77ce5285-713f-4f2e-97b0-702c93404d82@email.android.com>
References: <1395255044-20173-1-git-send-email-alecaberg@chromium.org> <77ce5285-713f-4f2e-97b0-702c93404d82@email.android.com>
From: Alec Berg <alecaberg@google.com>
Date: Wed, 19 Mar 2014 14:33:48 -0700
Message-ID: <CAGgO2Lgka8-S70ydrNRErwUPYNmTXvpNk-k6ApFNpqjGRVjH4Q@mail.gmail.com>
Subject: Re: [PATCH] iio: querying buffer scan_mask should return 0/1
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alec Berg <alecaberg@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vincent Palatin <vpalatin@chromium.org>, olof@lixom.net
Content-Type: multipart/alternative; boundary=089e0149ce3cae108304f4fc69ce
List-ID: <linux-iio@vger.kernel.org>

--089e0149ce3cae108304f4fc69ce
Content-Type: text/plain; charset=UTF-8

I'm using x86, not sure what other architectures, if any, that it affects.

Thanks.


On Wed, Mar 19, 2014 at 1:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:

>
>
> On March 19, 2014 6:50:44 PM GMT+00:00, Alec Berg <alecaberg@chromium.org>
> wrote:
> >Ensure that querying the IIO buffer scan_mask returns a value of
> >0 or 1. Currently querying the scan mask has the value returned
> >by test_bit(), which returns either true or false. For some
> >architectures test_bit() may return -1 for true, which will appear
> >to return an error when returning from iio_scan_mask_query().
> I'm curious now.  Which architectures?  Change is fine BTW. Will pick when
> I get a few mins...
> >
> >Additionally, it's important for the sysfs interface to consistently
> >return the same thing when querying the scan_mask.
> >
> >Signed-off-by: Alec Berg <alecaberg@chromium.org>
> >---
> > drivers/iio/industrialio-buffer.c | 6 ++++--
> > 1 file changed, 4 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/iio/industrialio-buffer.c
> >b/drivers/iio/industrialio-buffer.c
> >index c67d83b..fe25042 100644
> >--- a/drivers/iio/industrialio-buffer.c
> >+++ b/drivers/iio/industrialio-buffer.c
> >@@ -165,7 +165,8 @@ static ssize_t iio_scan_el_show(struct device *dev,
> >       int ret;
> >       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >
> >-      ret = test_bit(to_iio_dev_attr(attr)->address,
> >+      /* Ensure ret is 0 or 1. */
> >+      ret = !!test_bit(to_iio_dev_attr(attr)->address,
> >                      indio_dev->buffer->scan_mask);
> >
> >       return sprintf(buf, "%d\n", ret);
> >@@ -866,7 +867,8 @@ int iio_scan_mask_query(struct iio_dev *indio_dev,
> >       if (!buffer->scan_mask)
> >               return 0;
> >
> >-      return test_bit(bit, buffer->scan_mask);
> >+      /* Ensure return value is 0 or 1. */
> >+      return !!test_bit(bit, buffer->scan_mask);
> > };
> > EXPORT_SYMBOL_GPL(iio_scan_mask_query);
> >
>
> --
> Sent from my Android phone with K-9 Mail. Please excuse my brevity.
>

--089e0149ce3cae108304f4fc69ce
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;m using x86, not sure what other architectures, if a=
ny, that it affects.<div><br></div><div>Thanks.</div></div><div class=3D"gm=
ail_extra"><br><br><div class=3D"gmail_quote">On Wed, Mar 19, 2014 at 1:31 =
PM, Jonathan Cameron <span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@kernel.o=
rg" target=3D"_blank">jic23@kernel.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D""><br>
<br>
On March 19, 2014 6:50:44 PM GMT+00:00, Alec Berg &lt;<a href=3D"mailto:ale=
caberg@chromium.org">alecaberg@chromium.org</a>&gt; wrote:<br>
&gt;Ensure that querying the IIO buffer scan_mask returns a value of<br>
&gt;0 or 1. Currently querying the scan mask has the value returned<br>
&gt;by test_bit(), which returns either true or false. For some<br>
&gt;architectures test_bit() may return -1 for true, which will appear<br>
&gt;to return an error when returning from iio_scan_mask_query().<br>
</div>I&#39;m curious now. =C2=A0Which architectures? =C2=A0Change is fine =
BTW. Will pick when I get a few mins...<br>
<div><div class=3D"h5">&gt;<br>
&gt;Additionally, it&#39;s important for the sysfs interface to consistentl=
y<br>
&gt;return the same thing when querying the scan_mask.<br>
&gt;<br>
&gt;Signed-off-by: Alec Berg &lt;<a href=3D"mailto:alecaberg@chromium.org">=
alecaberg@chromium.org</a>&gt;<br>
&gt;---<br>
&gt; drivers/iio/industrialio-buffer.c | 6 ++++--<br>
&gt; 1 file changed, 4 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt;diff --git a/drivers/iio/industrialio-buffer.c<br>
&gt;b/drivers/iio/industrialio-buffer.c<br>
&gt;index c67d83b..fe25042 100644<br>
&gt;--- a/drivers/iio/industrialio-buffer.c<br>
&gt;+++ b/drivers/iio/industrialio-buffer.c<br>
&gt;@@ -165,7 +165,8 @@ static ssize_t iio_scan_el_show(struct device *dev,=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_to_iio_dev(dev)=
;<br>
&gt;<br>
&gt;- =C2=A0 =C2=A0 =C2=A0ret =3D test_bit(to_iio_dev_attr(attr)-&gt;addres=
s,<br>
&gt;+ =C2=A0 =C2=A0 =C2=A0/* Ensure ret is 0 or 1. */<br>
&gt;+ =C2=A0 =C2=A0 =C2=A0ret =3D !!test_bit(to_iio_dev_attr(attr)-&gt;addr=
ess,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0indio_dev-&gt;buffer-&gt;scan_mask);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, &quot;%d\n&quot;, ret);<br>
&gt;@@ -866,7 +867,8 @@ int iio_scan_mask_query(struct iio_dev *indio_dev,<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 if (!buffer-&gt;scan_mask)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;<br>
&gt;- =C2=A0 =C2=A0 =C2=A0return test_bit(bit, buffer-&gt;scan_mask);<br>
&gt;+ =C2=A0 =C2=A0 =C2=A0/* Ensure return value is 0 or 1. */<br>
&gt;+ =C2=A0 =C2=A0 =C2=A0return !!test_bit(bit, buffer-&gt;scan_mask);<br>
&gt; };<br>
&gt; EXPORT_SYMBOL_GPL(iio_scan_mask_query);<br>
&gt;<br>
<br>
--<br>
</div></div>Sent from my Android phone with K-9 Mail. Please excuse my brev=
ity.<br>
</blockquote></div><br></div>

--089e0149ce3cae108304f4fc69ce--
