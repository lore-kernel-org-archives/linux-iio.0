Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1BE3859F3
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419331; cv=none; b=iMw3dsc5ymJXIdKw/PdDT6LIJMIa1BoJRR5taaXbObEqAc97tE81HRebWLcgRYZuv34dVd1dtAj+AJ2ZtFWqq5yKXhUfB3Q1rG5wdYkX1zdqZG5vqqWt9GiHoZbNotbbuFIpbdfQpMKo5NA16YpIL6Qd0BGf2zEnovHBKb7f20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419331; c=relaxed/simple;
	bh=7M6qQwSwD+XrHhy1JS5GMZiaeqWwjrdH7qVYXbsQEsU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yjps0/cH+roHk4KIhL/0eKlalXVQw10guQjEXlZEAfaWt2mWtYAgNmnXHjDe91PnmuzOXZ/uG0DsGS3qViH12qXQM0G9Z2i1tcdtP0ht81LnldLhFNlXuBkmZGjN97U7bQPCZjTk4nXT9/OIUg5AM44QPERAO4TQPow7pgmJCGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbUN5+uK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbUN5+uK"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so11868725e9.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780419329; x=1781024129; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lR1aiUfHvK9pACcDS8heDpRLK9T5JqYjX9U4vnMG5Yk=;
        b=YbUN5+uKTXcpMd9xhLVeeQZGG5docKseXHF5TmwoxiE4nMYMAJxfsKQTg37mwoJYcH
         xaU3G4ehkfD32MKuXv+mfyhUx0ifb6S2jMfccJFIoqCmCLw1dP8cFu5vzQmcEwBIYgli
         K93N/VnsTsn8sPFrtA7Ft125FayhLyryQqncEA0D8fn+oetH3feBHqVsozFJQaXMTjS6
         taA+0vLN6tDMFI3Lbj7QFOPwreLZMj3WyX/NtTesXV955YiafHWhDjfhgNVJjNy1ViTh
         s4JN0xytM+5k/+qwiukNaJpMkgp0pePOS+DjUHMInIyDgLUJGWc6gaLZgjKQfNdeYtxo
         sbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419329; x=1781024129;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lR1aiUfHvK9pACcDS8heDpRLK9T5JqYjX9U4vnMG5Yk=;
        b=qPJsrezAFE+Xu6v43BeKaqI63k79ytNDWQLrZEW2nbpgSMAgkSGzLmYeYTrj71lHSX
         siegDTiXTwRQBBQz5SUjfwNqIj4mscE6DcydXFfOqaRphgSIIPFhYQR+fCJH8rbOfMBw
         0sZk+i3fvZgMBIlTtUENb9W/UG9403/2eDlnU1mh2Du5vaRdpGHf37D3U4GciOEErY/5
         k+JBPFKmVPj/ABSlS+n1g32/EJxaebGOk8dbcfEI58FyW7lGPwgKaYOJF8wGBUrPDOdo
         +U97Swq4+viklBO4Jz3mI+zaBkLJjYd7GCDQhVv/chHJDtcdSxgaj6Ld9hASv+BrrIrA
         B+aA==
X-Forwarded-Encrypted: i=1; AFNElJ/QsUKkFV3RwkD/IqbDJD3a3loixAyZU6TB9kaqM++0Wdq2qFSCFgWzzMqv5LKUdp8IgI7VR1Qk9Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrOvPP+maBbekM58+Ry3sawW0yvp6pR1D2N771p352T+lX2cA7
	rvPaRAbunm/HPqRM+vjSVTu0sBhdDeH20iVzE2woZCuebc7fL+9A5DVd
X-Gm-Gg: Acq92OEDM16xdjWGIfHV3OZKQuHP+pG6G2Xn0bGxShgPd+RS+R/BAzFFJ0Qo3GPyl0A
	VnQnKqASycKbaNkEcZZBV1LqLnkRwKc780kJPlJF2+XjEoj362/6YBwtnMSLUAs1F6QgTvykEhu
	be0ILDvacois/3psu9OH1weIM8+wI4PYqXwhhU9c523BmLAbC+/DgrpeXqQciHtFulQesFros0S
	qaQ388GarnIYdOuYWZSKQZlo0t6LoaeitD5Bp2cfYiuP0/RJj19VcBriDwC0kKVjwostYG9w1QW
	PcmceGJLD+DaE9Uqa5Q1N7yKYbgb1KzPseIJHiwowaRs0l8edLidD/OIjOpF1dtqh29IHdNop3O
	PureQ27BZhzRDSSqnJIclT57dU9IwrBdaQbsjpanP7hqPHbYJ003q0igFUTuAeBR7+lUhyx2Tyf
	97Xyz6LeGpvroOCysFcgIRjxBXmdnUDWtiDh8XiaIW/isc1mq4HtKCJfacUljd/vWAIppLNrQWT
	iqT63Pqarn4
X-Received: by 2002:a05:600c:c3db:20b0:48e:5fb8:f80f with SMTP id 5b1f17b1804b1-490b50bfabdmr7086835e9.24.1780419328608;
        Tue, 02 Jun 2026 09:55:28 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e0f343sm82850455e9.1.2026.06.02.09.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:55:28 -0700 (PDT)
Message-ID: <a607ff15c5a9c6edd6be1a40182b16b5dc48c151.camel@gmail.com>
Subject: Re: [PATCH v15 06/12] iio: core: add decimal value formatting into
 64-bit value
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko	
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,  Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Date: Tue, 02 Jun 2026 17:56:32 +0100
In-Reply-To: <u7p5ndqqh3ngnmmzoir37yuc3hfm2llenaihuekwuwoji743mf@itbbdxfo4qan>
References: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
	 <20260531-adf41513-iio-driver-v15-6-da09adf1c0dd@analog.com>
	 <ah1SUD_QpRLD2WGV@nsa>
	 <u7p5ndqqh3ngnmmzoir37yuc3hfm2llenaihuekwuwoji743mf@itbbdxfo4qan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-01 at 16:12 +0100, Rodrigo Alencar wrote:
> On 26/06/01 10:43AM, Nuno S=C3=A1 wrote:
> > On Sun, May 31, 2026 at 09:30:49AM +0100, Rodrigo Alencar via B4 Relay =
wrote:
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >=20
> > > Create new format types for iio values (IIO_VAL_DECIMAL64_*), which
> > > defines the representation of fixed decimal point values into a singl=
e
> > > 64-bit number. This new format increases the range of represented val=
ues,
> > > allowing for integer parts greater than 2^32, as bits are not "wasted=
"
> > > in the fractional part, which can be seen in IIO_VAL_INT_PLUS_MICRO a=
nd
> > > IIO_VAL_INT_PLUS_NANO. Helpers are created to compose and decompose 6=
4-bit
> > > decimals into integer values used in IIO formatting interfaces, which
> > > creates consistency and avoid error-prone manual assignments when usi=
ng
> > > wordpart macros. When doing the parsing, kstrtodec64() is used with t=
he
> > > scale defined by the specific decimal format type.
> > >=20
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > ---
> > > =C2=A0drivers/iio/industrialio-core.c | 47 ++++++++++++++++++++++++++=
+++++++--------
> > > =C2=A0include/linux/iio/types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 30 ++++++++++++++++++++++++++
> > > =C2=A02 files changed, 68 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrial=
io-core.c
> > > index bd6f4f9f4533..a88088cac641 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -19,6 +19,7 @@
> > > =C2=A0#include <linux/idr.h>
> > > =C2=A0#include <linux/kdev_t.h>
> > > =C2=A0#include <linux/kernel.h>
> > > +#include <linux/math64.h>
> > > =C2=A0#include <linux/module.h>
> > > =C2=A0#include <linux/mutex.h>
> > > =C2=A0#include <linux/poll.h>
> > > @@ -26,7 +27,6 @@
> > > =C2=A0#include <linux/sched.h>
> > > =C2=A0#include <linux/slab.h>
> > > =C2=A0#include <linux/wait.h>
> > > -#include <linux/wordpart.h>
> > > =C2=A0
> > > =C2=A0#include <linux/iio/buffer.h>
> > > =C2=A0#include <linux/iio/buffer_impl.h>
> > > @@ -655,6 +655,7 @@ static ssize_t __iio_format_value(char *buf, size=
_t offset,
> > > unsigned int type,
> > > =C2=A0				=C2=A0 int size, const int *vals)
> > > =C2=A0{
> > > =C2=A0	int tmp0, tmp1;
> > > +	int l =3D 0;
> > > =C2=A0	s64 tmp2;
> > > =C2=A0	bool scale_db =3D false;
> > > =C2=A0
> > > @@ -698,7 +699,6 @@ static ssize_t __iio_format_value(char *buf, size=
_t offset,
> > > unsigned int type,
> > > =C2=A0	case IIO_VAL_INT_MULTIPLE:
> > > =C2=A0	{
> > > =C2=A0		int i;
> > > -		int l =3D 0;
> > > =C2=A0
> > > =C2=A0		for (i =3D 0; i < size; ++i)
> > > =C2=A0			l +=3D sysfs_emit_at(buf, offset + l, "%d ", vals[i]);
> > > @@ -707,8 +707,25 @@ static ssize_t __iio_format_value(char *buf, siz=
e_t
> > > offset, unsigned int type,
> > > =C2=A0	case IIO_VAL_CHAR:
> > > =C2=A0		return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
> > > =C2=A0	case IIO_VAL_INT_64:
> > > -		tmp2 =3D (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
> > > +		tmp2 =3D iio_val_s64_from_s32s(vals);
> >=20
> > I might be missing something but can't we just call
> > iio_val_s64_compose()? Likely even inline in sysfs_emit_at()?
>=20
> There is a compose() already.
>=20

Yes and I was suggesting using that one instead iio_val_s64_from_s32s() :).=
 To be
consistent to what you use in the other path (which is decompose() if I'm n=
ot
mistaken).

> =C2=A0
> > It would match your call to iio_val_s64_decompose() below.
>=20
> here are the helpers prototype:
>=20
> 	s64 iio_val_s64_compose(s32 val0, s32 val1);
> 	s64 iio_val_s64_from_s32s(const s32 *vals);
>=20
> 	void iio_val_s64_decompose(s64 dec64, s32 *val0, s32 *val1);
> 	void iio_val_s64_to_s32s(s64 dec64, s32 *vals);
> =C2=A0

Yes and it feels that iio_val_s64_compose() and iio_val_s64_decompose() are=
 the only
ones we really need? (Maybe with other naming if you prefer iio_val_s64_fro=
m_s32s()
and iio_val_s64_to_s32s()).

> > And the above makes me wonder if the compose()/decompose() are not the
> > only helpers we need? At least in terms of parameters? I mean, just
> > assuming we only have two integers instead of allowing s32* and opening
> > the door for misbehave :)?
>=20
> I suppose we would really need some sort of:
>=20
> union iio_val {
> 	s32 val32[2];
> 	s64 val64;
> };
>=20
> or even add a:
>=20
> 	struct { void *ptr, size_t size }

I just meant using two where we just have (s32 val1, s32 vals2) given that =
is
what IIO has anyways. No need to overthinking it for now IMO.

- Nuno S=C3=A1

> > - Nuno S=C3=A1
> >=20
