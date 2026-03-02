Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EA62FBDE0
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468264; cv=none; b=nglCNbke23e1CJVKHKq3RD2elUDlN/Xa3df+z4BHNk8ZY1jIUYyhNQUrGf2+zIzFkgEbKxxzgikLw6a8IGT/g3FClvo/fKgyM76w2Xq9arJIvmk0kOIOo1/1eS/NbajPLau8laYZybN140MCRRMYQBaUNNKeF4Zofts3tiNJxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468264; c=relaxed/simple;
	bh=e/+mYq2Nz6VcjAwwIILZSkOoopVK6vrvEtovOF7xZAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eCvpkuTBXbohMggW8Ogx2tWbyURMhFSnZ8V1nnRQjFBv75zJCmys4etulmTAncgg9nBZPzCjHiqmA9CE3yJzA9rxuiv3LXu2JkTL+E5ABiCOw/caGfJ6MbdyZ9RGqiyOFmytUP7aMzxTqSJdxUFl8WtUng3JcPzxLI7woteIc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwDyeBun; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwDyeBun"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439afc58ac7so1738387f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 08:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772468261; x=1773073061; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wezhi7CF4L9D6nvvGOyC3SwPE4r3g5VxDfDZ4qYyA+4=;
        b=UwDyeBunsIk8Xc3PZok+Ykwhr2UqS4vav0CGBBiDidRhvm0NF/DxT+q2WzOnUE1a0p
         7SSXF02+utXuHYpFz8aY1Nv3MCNz7mErRZ7cmfrxS1f0ZRFRFeO/JJY86wIq1WTsS4i9
         GG3kOr5dd53m4y0Xb4ONU9cFgU+/tc4LcQ1B+sWa6dW0SZwGrv625VMkarMpk64vXBQ3
         zcC1yjuNhrF92XWk3/a75PU/V80JMizW0ONuZksjyG9NB52U8YpDm14HJPlz9CJATtOx
         SD3YKCxAgpytNFV7RmkTCXCYpxhFDLK8kOFILMuFgUPGJi7J0maoYD6W3Dr2sJBPTOjs
         kssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468261; x=1773073061;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wezhi7CF4L9D6nvvGOyC3SwPE4r3g5VxDfDZ4qYyA+4=;
        b=k8AfU5+Z5wJhwFAR2BaWZaZOHQ2Gtob2y6OWWnoTPHVnlM1U5TdMuu/0OmE84YShLg
         JXrzuR8gT/NpemCoBI0BhrfckxJ5lLMIbGp5+QjiXI/7AcM/+/LXxDuH2l/cIgpBy1qV
         v67R7XKDa9SJlVI6FvKSvM2Fe82SNoskzh0wU1DUajEP7Tmdk53Cv0UeXXx3oR+oHQpv
         uFAHoIm4NrrD9Kglpc5VG7w6GmTZOsWKjgRs3BmYxBZR9FObY3qC4PQxVFTrq2Whzj+E
         o0fNCf0m/RYrJwpffqV49UBfpUOw4YwF2jUjFS1yKWAqL8u/IFbv0u5ZOOrJ6aYqVzzR
         kKMw==
X-Forwarded-Encrypted: i=1; AJvYcCW2AebZX+20ihukSJR7HOk35IcYq4aCkVt8A7NL+h6WztpLtHcutDizgAxrPzIFnF4dK9q/YSq2+00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXjXGwSgr/2gbZ3c7BCFI9aMOFosYnWa2G7aavWDD8LOWnVkL
	tKV35ZpCEl6khH/WJFmEA220Iyw16xHjFfuTUmCWJMQYCm8JJTs2dWO+
X-Gm-Gg: ATEYQzxPcS6IgbGJeoFTV9zjnp2adxOahDK9ONSqyLGojMkM9o8zO4IgeXFo27NnYWG
	PTcPsOpZCxfzOe3zeSMjVy8XAhV2ew90thevGyDdQAg5auv7wziomocESyIGm1DQLxBeEOwdTf9
	A081Z1MTJm5ng6OO1c3PBKtpnjcV0IQAFUkiOX7vYSme5FnWnHE0B9koDpVIKnomoNhJ9O9HRQF
	FhqxODaMXctVtSPYgbqEqlP0TDu92uxOTu/5jHI6gSed5zDJubXssf97FZFjHIWswUD2qngif/f
	ZUZGCuB0Em3Si5LK9s/ZZgmxRoTbXETGAGP5Hv4gltTMimuB5FG+6Fk0E8Gx2mssZ8ap3giGT/A
	LkJNaR1b8YBGQWB0iw2oc3zrRF1FK5Zl0yA3QQ4vtRhQTJW0g+lXy1Ve4aS1AD8OlLeKc/BU38X
	SDx5BoHRTpKrw7/UKXB/yd5oQYYZZYJSw=
X-Received: by 2002:a05:6000:40dc:b0:439:b736:bd0e with SMTP id ffacd0b85a97d-439b736be50mr7224386f8f.44.1772468261230;
        Mon, 02 Mar 2026 08:17:41 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b485a0b6sm12554176f8f.39.2026.03.02.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:17:40 -0800 (PST)
Message-ID: <81abde86bf147c8a38794732354030761a216759.camel@gmail.com>
Subject: Re: [PATCH 3/4] iio: buffer: cache largest scan element size
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Cameron	 <jic23@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars
 =?ISO-8859-1?Q?M=F6llendorf?=	 <lars.moellendorf@plating.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lixu Zhang	
 <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 02 Mar 2026 16:18:25 +0000
In-Reply-To: <d9b14aaa-5c03-4769-b7e5-0a6b3dcbe1f6@baylibre.com>
References: 
	<20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
	 <20260301-iio-fix-timestamp-alignment-v1-3-1a54980bfb90@baylibre.com>
	 <091936ced74a1eb051dfda009e27bdb8f32426b2.camel@gmail.com>
	 <d9b14aaa-5c03-4769-b7e5-0a6b3dcbe1f6@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-02 at 09:35 -0600, David Lechner wrote:
> On 3/2/26 6:16 AM, Nuno S=C3=A1 wrote:
> > On Sun, 2026-03-01 at 14:24 -0600, David Lechner wrote:
> > > Cache the largest scan element size of elements enabled in a scan
> > > buffer. This will be used later to ensure proper alignment of the
> > > timestamp element in the scan buffer.
> > >=20
> > > The new field could not be placed in struct iio_dev_opaque because we
> > > will need to access it in a static inline function later, so we make =
it
> > > __private instead. It is only intended to be used by core IIO code.
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > > =C2=A0drivers/iio/industrialio-buffer.c | 14 +++++++++++---
> > > =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> > > =C2=A02 files changed, 14 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industri=
alio-buffer.c
> > > index 71dfc81cb9e5..83e9392f949f 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -765,7 +765,8 @@ static int iio_storage_bytes_for_timestamp(struct=
 iio_dev *indio_dev)
> > > =C2=A0
> > > =C2=A0static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
> > > =C2=A0				=C2=A0 const unsigned long *mask, bool timestamp,
> > > -				=C2=A0 unsigned int *scan_bytes)
> > > +				=C2=A0 unsigned int *scan_bytes,
> > > +				=C2=A0 unsigned int *largest_element_size)
> > > =C2=A0{
> > > =C2=A0	unsigned int bytes =3D 0;
> > > =C2=A0	int length, i, largest =3D 0;
> > > @@ -793,6 +794,9 @@ static int iio_compute_scan_bytes(struct iio_dev =
*indio_dev,
> > > =C2=A0
> > > =C2=A0	*scan_bytes =3D ALIGN(bytes, largest);
> > > =C2=A0
> > > +	if (largest_element_size)
> > > +		*largest_element_size =3D largest;
> >=20
> > I might be missing something but it seems we now have two paths:
> >=20
> > 1. Go with 32 bytes
> > 2. Go with 24 bytes (natural alignment)
>=20
> Hmm... You are right, but we are safe for now because the only repeat is
> a quaternion, which has repeat of 4, so we don't have a case with e.g.
> 24 bytes right now.
>=20
> I can do a follow-up to future-proof iio_storage_bytes_for_si() to
> handle repeat =3D 3 (or any other less likely value).
>=20
> Without the repeat, the size is based on .storagebits, and .storagebits /
> BITS_PER_BYTE is always a power of 2, so no problem there.
>=20
> >=20
> > ABI was not clear so I'm not sure if we do want to enforce/treat repeat=
ed values as one single
> > element
>=20
> It has always been this way and we had some recent breakage because I did=
n't
> know about this. This patch series is a direct result of that [1] because=
 we
> identified more bugs when analyzing it.

Hmm true. If we shrink the buffer, userspace expecting timestamps at bit 24=
 will not work.


- Nuno S=C3=A1

>=20
> [1]: https://lore.kernel.org/linux-iio/bug-221077-217253@https.bugzilla.k=
ernel.org%2F/
>=20
> > If so, nothing to change. But if not, we could re-think the approach an=
d save some bytes.=C2=A0
>=20
> It's too late and breaks usespace as we have seen.
>=20
> > Marginal savings though so If having the smaller buffer is not straight=
 enough I would be ok
> > with
> > the simplicity tradeoff.
> >=20
> > - Nuno S=C3=A1
> >=20
