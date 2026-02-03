Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A539B48E
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112824; cv=none; b=rURd7mkYfUXvEXtJiTOpn0xS5aBb3djn7V8O4el5gfWFjc1rG3HPgdqIzY1XGIPkLztuj4rakYkoLJXlCxRuTWAJ//rRvBhbVZ9tilikhyZ11zwy0auWKceWO2y4hIX2RqQmpV45MbO5abVlqPYYKZVN+Bb2kxcmQFf5Rpu5c/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112824; c=relaxed/simple;
	bh=iz24nR5NMqwSrDzIRWRtWHL14HbCI+xVTEpjTjZ3dg4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ErHPLuWdXIlFy7DSY1f86YDhBj+1/JnEpOz3pCJ5JSIn3pR1sOzoaZgWwcsp7s0uwrrII8rWKTs6sTM1jIowUBsvmiAD+oDzvMZnwaWqa4ZP3KcnJ+QNWUSl+cVB8drNSjkgtIQl0YZEH2ngxnla7S2tXOme/sul5QW59OKz3Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HivoMLZX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HivoMLZX"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43284ed32a0so2891316f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 02:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770112821; x=1770717621; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cyM4dj54s9l5Yb4t6lpV7sb0GJU5YCf0GHIh3AwADRQ=;
        b=HivoMLZXU/2cd2ozdOnYJAbcFiPy05C95HPXahmmCahf2h7mhlNoFIuYbKxvMFohzF
         Kwj6H1gRADlzqlGgGOrzEL8o2UsUXsoK6qCAK6YP99nDEHF5oldG1TLk4H4pQmUnjJ2q
         AunOfM8FKEkfB8t1t7Oh/I4MFZxMe+5yNatAqsFIxb6EMY+BcWmhFQARewlp4lEQYI86
         lZzAPnDRG0wcGgYhr1OZFMo7Mcnccd2lDTj8EuCS2ut8BDNPpqO7HtII4dJgHqbHFa97
         yp81mLMgmlB4RHtnwkCGMeetkQB3koFNj9aXF2ZZfsJQfd65fEsaeL42QLiIi0pY+EHp
         rd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112821; x=1770717621;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyM4dj54s9l5Yb4t6lpV7sb0GJU5YCf0GHIh3AwADRQ=;
        b=GjDdPaoZIpLikz4jjBKxgTQmd3Sise2/zQR6/10gKKCinwJbLYrDRS/P6rpgljHfPQ
         qcixZ7b6kIkkyLOlgeAnIXfbnW/8DxOgZ3Snkv4CWbB1FsjioebtZ8rUwTpmrYzpQZSG
         bVmgF0h/88SebfvSdOeLA89mBn5Xq+M/Jg+R/GPJdol/fO38Ijl7XmXsg8gJ5nfxAnMH
         EcXaV+an8DN60syM4oQY1DADKLvdr6CE96A6xVT1BH3aIeFHDZwqV6UcyV5Ez1cFUUlN
         vQ/tcazMhzFK/JZVCbrYTk7tN/vFLuJEFaFy/grc3X+1WFoJYFoIraDw1cOMUgIlxrIq
         H8hA==
X-Gm-Message-State: AOJu0YyLPBSnxf2rcWzhZBhaMcQOx4z4tihT1AHk6kyr+tG3xRI1sQpN
	Tog3NOs03GaRqvO4x/dnpHU/FFY4BBH44IqVAlYX1hqnBrWbAes0Hih6
X-Gm-Gg: AZuq6aIxbzZzlb3qRw1HUhsI+J1aFSfQ6m6rY4diCcgob8g/vXWsgrhI8ezBGlBoxrB
	4cxrv3GUj5pLKCafKvyj9DoLHGuzZ/uzQhyVgvMJhgz2v/6+bnVq105EsqDIe/Lk0eTZC5MgDuv
	CengUI+A9AR5BXWzrSTqgamuHFrnNojZdSE7ayLzBjD69mth5Uqe+i8TQF1izAA0Yj7mF35o6xx
	5gh39ekiZiQ954nHNph2ip3lkTsXviif2sYpXSCGqzyWOWrS/I2XqEcPN9lzSv++FZX3uBJzSBw
	RHAW5yUTxLraGpAilPdCFjv3MQUCtb7AojPof5wGW46U//Nt9qhPSC0kGRZ10GAyqN3J1B0df11
	oA7NyY/IxY73oTVKusVpA5hznn9QTWSmRNxVljjXW05zY3JmpOuBl/dRMDdNsH60ZMbkGaStZjo
	ltyaRkPJENaTPZdmhzwNAUQez1ZI/d2w==
X-Received: by 2002:a05:6000:18a6:b0:435:b732:771b with SMTP id ffacd0b85a97d-435f3a7e7c7mr25504053f8f.20.1770112820708;
        Tue, 03 Feb 2026 02:00:20 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e483asm49068216f8f.3.2026.02.03.02.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:00:20 -0800 (PST)
Message-ID: <fc350d2605ca6d95facec1a67858cb0ac22db917.camel@gmail.com>
Subject: Re: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, David Lechner
 <dlechner@baylibre.com>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron	 <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Feb 2026 10:01:03 +0000
In-Reply-To: <aa5010ba-27bc-4c0d-9fce-8264216d4aa1@vaisala.com>
References: 
	<20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
	 <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
	 <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
	 <812a8c408c2e3a87ebe1ddc983acdc2cebe3b36b.camel@gmail.com>
	 <30cf63eb-50ba-445d-a78b-d6532aacdc8e@vaisala.com>
	 <177d62446d9c2098bbfe8b0f7fd9418d5afb60fc.camel@gmail.com>
	 <aa5010ba-27bc-4c0d-9fce-8264216d4aa1@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-02 at 15:04 +0200, Tomas Melin wrote:
> Hi,
>=20
> On 02/02/2026 14:40, Nuno S=C3=A1 wrote:
> > On Mon, 2026-02-02 at 13:08 +0200, Tomas Melin wrote:
> > > Hi,
> > >=20
> > > On 02/02/2026 12:28, Nuno S=C3=A1 wrote:
> > > > On Sat, 2026-01-31 at 14:30 -0600, David Lechner wrote:
> > >=20
> > > > >=20
> > > > > Do we actually need this one? Alternative could be, for example:
> > > > >=20
> > > > > int iio_backend_enable(struct iio_backend *back)
> > > > > {
> > > > > 	int ret;
> > > > >=20
> > > > > 	ret =3D iio_backend_op_call(back, enable);
> > > > > =09
> > > > > 	return ret =3D=3D -EOPNOTSUPP ? 0 : ret;
> > > > > }
> > > >=20
> > > > I would prefer not to assume we can ignore the backend not supporti=
ng
> > > > the call. It opens up the question for other operations.
> > > >=20
> > > > My preferred way for this kind of fundamental operation (enabling/d=
isabling)
> > > > would be to check with DT maintainers if we could have some kind of=
 fixed-backend
> > > > (fixed in the sense the HW is present but not controlled by Linux) =
dummy device that
> > > > with implement a no-OP enable/disable().
> > >=20
> > > There is also use cases for the always_on cap with a configurable
> > > non-dummy backend. Some applications are such that the driver should
> > > leave the enabling/disabling up to the user space consuming the data.
> > > For this case it's great to have the frontend leave the backend enabl=
e
> > > alone using this capability.
> > >=20
> >=20
> > I would argue the above would be something to take care at the frontend=
 level. The way
> > I see it, the always_on cap is pretty much saying that we can't really =
control the on/off state
> > of the backing device and we just assume it's on.=C2=A0
> >=20
> > If we can control it but we need it always on (for some specific usecas=
e), I would say that
> > should
> > be handled at the frontend and just enable the backend once. Also note =
that as of now, I think
> > all
> > of the users (or most at least) we have just enable the backend during =
probe and leave it on
> > until
> > we unbind the device.
>=20
> Yes, this is debatable. It's not necessarily always on, but should not
> be enabled/touched by the frontend during probe.
> But anyways, having a capability that says if the enable/disable feature
> is available, is in any case useful and what I was planning on
> leveraging in my use case.
> Fundamentally, with the capabilites as now proposed, it is possible to
> select what features of the ad9467 are available, in addition to the
> basic requirements.

Yeah but this is just tweaking for your special case. Like you said, if we =
ever have
something like "but should not be enabled/touched by the frontend during pr=
obe." then what David
suggests in his reply makes more sense to me and clearly fits the usecase. =
That's not what we have
here. Here we have a fixed, non (linux) managed hardware and we do have a p=
attern in other
subsystems for HW like this. That is why my preferred approach would be a f=
ixed-backend kind of
thing (naturally to be discussed with DT maintainers likely).
>=20
> The ALWAYS_ON capability could be inverted, like CAP_HAS_ENABLE_DISABLE,
> but to me, the ALWAYS_ON naming still seems the better option.
> >=20

But ok, I don't feel strong enough to be pushing for the above even though =
(and for the record :))
it's not my preferred approach. If every one else is fine with it, I won't =
object either.

- Nuno S=C3=A1

