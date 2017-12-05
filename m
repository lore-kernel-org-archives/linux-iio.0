Return-Path: <mfornero@gmail.com>
MIME-Version: 1.0
References: <1512161180-30116-1-git-send-email-mfornero@gmail.com>
 <20171202115257.5e561988@archlinux> <d260e712-ec2f-33d5-e368-86c2e7ffa19e@metafoo.de>
In-Reply-To: <d260e712-ec2f-33d5-e368-86c2e7ffa19e@metafoo.de>
From: Matthew Fornero <matthew.fornero@gmail.com>
Date: Tue, 05 Dec 2017 18:01:13 +0000
Message-ID: <CABdUomw1Z=CTq5m5jBic-=PNtn3DGU1L3b3O6bhzX-MOo2iCrw@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer-dma: Expose data available
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, linux-iio@vger.kernel.org,
	Matt Fornero <matt.fornero@mathworks.com>
Content-Type: multipart/alternative; boundary="001a1144b57a81aead055f9b9f97"
List-ID: <linux-iio@vger.kernel.org>

--001a1144b57a81aead055f9b9f97
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 5, 2017 at 1:32 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> I guess one question is whether this should be generic.
> iio_dma_buffer_data_available() is a generic function and not specific to
the
> DMA buffers, so it would work just fine for FIFO based buffers as well.

So it looks like we could implement this generically as a member of
iio_buffer_attrs, and have it simply use iio_buffer_data_available()
instead of iio_dma_buffer_data_available().

This would also be a bit cleaner, as the iio_buffer_attrs logic already
has code to append existings attrs, allowing device-specific attrs to be
easily added.

What about the case when the data_available element in
iio_buffer_access_funcs is undefined (e.g. industrialio-buffer-cb)?
Do we modify iio_buffer_data_available() to return 0, do we make the
sysfs function return -ENOENT or -EINVAL, or simply not expose the sysfs
interface for this case?
-- 

--

Matthew Fornero

matthew.fornero@gmail.com

(734)-846-4968

--001a1144b57a81aead055f9b9f97
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>On Tue, Dec 5, 2017 at 1:32 AM Lars-Peter Clausen &lt=
;<a href=3D"mailto:lars@metafoo.de">lars@metafoo.de</a>&gt; wrote:</div><di=
v>&gt; I guess one question is whether this should be generic.</div><div>&g=
t; iio_dma_buffer_data_available() is a generic function and not specific t=
o the</div><div>&gt; DMA buffers, so it would work just fine for FIFO based=
 buffers as well.</div><div><br></div><div>So it looks like we could implem=
ent this generically as a member of<br></div><div>iio_buffer_attrs, and hav=
e it simply use iio_buffer_data_available()</div><div>instead of iio_dma_bu=
ffer_data_available().</div><div><br></div><div>This would also be a bit cl=
eaner, as the iio_buffer_attrs logic already</div><div>has code to append e=
xistings attrs, allowing device-specific attrs to be</div><div>easily added=
.</div><div><br></div><div>What about the case when the data_available elem=
ent in=C2=A0</div><div>iio_buffer_access_funcs is undefined (e.g. industria=
lio-buffer-cb)?=C2=A0</div><div>Do we modify iio_buffer_data_available() to=
 return 0, do we make the</div><div>sysfs function return -ENOENT or -EINVA=
L, or simply not expose the sysfs</div><div>interface for this case?<br></d=
iv></div><div dir=3D"ltr">-- <br></div><div class=3D"gmail_signature" data-=
smartmail=3D"gmail_signature"><div dir=3D"ltr"><p dir=3D"ltr">--</p><p>Matt=
hew Fornero</p><p><a href=3D"mailto:matthew.fornero@gmail.com">matthew.forn=
ero@gmail.com</a></p><p>(734)-846-4968</p>
</div></div>

--001a1144b57a81aead055f9b9f97--
