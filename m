Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35093DDB16
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389966; cv=none; b=OKxnsyXs2kEVjZTjx/OnjQNCXpePRUGJJ++M1a5v8dccWEFesIIv3v8WpkIkCWMAqlADksVJjmq7ype/A4jfeul1PPTjeqq11othCl5UtoBrTab+JikBqsTA2CxckrFg+0O8VeJp+xX/XOOsR8TjHSvc4KsUjrqPsku3GiADr7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389966; c=relaxed/simple;
	bh=6LwTmVt0WwD7hvgGsw8DPupUoKZXFuHF3AJCdQqKNqI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UVpHhuFnZRlBXBA06CQ6gK+RmotfisOuX+sqBMLXkPMX5iyj+KaFHGvG9/8zT18ZdjADNzwzt4L+7rvi+PMVyrb9UbPZbvv+GBxRIzyw6T/EIXjRyX1RasxIFSCH3yu1qv4OJ0WN9u/JhOWjSG0B0q8c1MVOOxXGwJUNKVgPWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pC1tnusJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pC1tnusJ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b060ec084so1043187f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 23:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792389963; x=1792994763; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xfNDVcCLMyws7NZEalRZx3KM792JOu/3dZx8XrnMr4E=;
        b=pC1tnusJeAN0rPNSgLi4hLJc0Wg88TU6ItH9cSzTX1joY4XVrY4oqe4IY8UHMeahYt
         6lskKdFBG36Ka6OV1lF9vHA5U8uY6DoAd/8u+jyeAKPlK6H2uvxjrs+6lF13d2lNh9Vx
         eztzIakkkHZymu3Ky5Gvg5vsOSf9k8ZUyTfneKDciXS7M5LANrzoVXHgrAcnhRw+jRQw
         TkPv73zSjpUbcJjoTLQUwWQ+UWHSXz6Dh6cDu9Ydw6YYFSAfTBZwifHjh0gRGzIMS3Mx
         1XhwZ050GXhOiIj8Wh7IHtTlBjMhXr784GXn+lerBAa50Vj9WV6hS5bUSjgdxh/h834+
         ++3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792389963; x=1792994763;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xfNDVcCLMyws7NZEalRZx3KM792JOu/3dZx8XrnMr4E=;
        b=svS1ZRk6HoXY0IX5wuT3XVx+oARV6hD0EB45cRG3HpTVW7hnzQItUGV8nF2eEcvpGH
         /MNBnhWN03ktpV5g+Xgr0oCBUC5q7YgGGq1fG6mlGZHd11xqzDtIVQAN/fYEc5atm9Jk
         Vj3Xx0EZCkE3vx7fiNslwyW2zlwCMMWN43l4SgImKMbqkUUKkDil++wm/ozGjuL52zXE
         zgiLb5SHuDjkWq0oarqMXxH36DnWU8IwjA/YJq/viEi8oQX5aYRBVsuoBOxwn16HyV8R
         5VpFLJH8uUyRQVp5/rozty3CyA9QK2sEFRrGZTga2LrbESWUSH1goauT0v+SK0W1LndO
         dhkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdTu++50uZr7SgUTZjwaZVKkJeLfNahUlnA15SAXjdmdeVhVb4f6dRiUfm6/l7+2KHuprxmmNmFzc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkBJ+C7Dtlzxg4hIEh7xuz/0zULGvQLSmULV8ChDwJXADQz67a
	CBs+V+kO3f8mYW1viUm9CUJQZsv7VZRBjjG6fqftcjDA1Eus+A+qqjMI
X-Gm-Gg: AYBFou2ov3p4EayovUyaqmjQvoX4q7GzYY2uW/4rj2gc2wgWUpFZviveCa+MLE+1V+e
	vhXdMNQ+OAhWqdxzjhuMrD8ufP+TcwRyf/Vcb7LP/3xzz7pxyfGKss0Ef84exRLedd4kDWiwHhx
	C1gLxALgimIGC2zS2IMrk/XuunvBk3ro63iRCHLiiE2YXWqPO4iE+ZU2xZyw5aBBy+hr09JSU4y
	G8tyyOCmoAd9snBN6UogYbdJ5cY+urc4YbM3FBvBOBsDbW9vAypKJWTm1r25AmqtNWnFrSF5sBi
	irVt/RMAZnvGACkpOcEQl8fHIHUETiVkiqvFeJPuPAofHCGTo5lR3EKWm1J4tJcY9+koGIUwyDi
	4kU0ysUJZFvFkLLrr5ND8L2bBOy3N4ZNDlhpYasTo9QDNi2XLJB2bDIhbD9+yXAfgLdnUVwB6jV
	ZuM7FPRgu7GpTxvOmi6aCWjcvG7q0lyUctq0kMI9aPnFlTWP5P4I5qdwaxPT/kMu+c/UxmTzOyP
	/vg+s4lGdnH/Db+HGyfLj+i8n+3TNCiZnLj+FhvC//NwUeYxpRzXxgJrB880OTCfC5lxzHV033Q
	XCUwTw==
X-Received: by 2002:a05:6000:4549:b0:48b:69d4:bb35 with SMTP id ffacd0b85a97d-48e07bbe545mr7818984f8f.12.1792389963039;
        Sun, 18 Oct 2026 23:06:03 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd540bc4sm21248191f8f.2.2026.10.18.23.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 23:06:02 -0700 (PDT)
Message-ID: <c1cb1b7ca3f69d5d456d6940f5dd8d93a0a91e8e.camel@gmail.com>
Subject: Re: [PATCH 02/10] iio: backend: add devm_iio_backend_get_optional()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Rodrigo Alencar	
 <455.rodrigo.alencar@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org,
 	linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, Olivier Moysan	
 <olivier.moysan@foss.st.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,  Jonathan Corbet	
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap	
 <rdunlap@infradead.org>
Date: Mon, 19 Oct 2026 07:07:34 +0100
In-Reply-To: <20261017212834.002392c6@jic23-hlaptop>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
		<20261015-ad9910-backend-support-v1-2-3c21648c8e26@analog.com>
		<atEeZPOLASHAcnjF@ashevche-desk.local>	<atHjHqyxXj6jkObW@nsa>
		<w7waqang6lriwbcq6o5s5yuedouuwgacmnj55qsjpzjrv3jut2@cthvkakgyhpi>
		<atIkZa0noHjcl13X@ashevche-desk.local>	<atIt3eXNeTT7cqxH@nsa>
	 <20261017212834.002392c6@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-10-17 at 21:28 +0100, Jonathan Cameron wrote:
> On Fri, 16 Oct 2026 15:07:02 +0100
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > On Fri, Oct 16, 2026 at 04:19:33PM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 16, 2026 at 08:18:08AM -0300, Rodrigo Alencar wrote:=C2=
=A0=20
> > > > On 16/10/26 09:45, Nuno S=C3=A1 wrote:=C2=A0=20
> > > > > On Thu, Oct 15, 2026 at 09:41:40PM +0300, Andy Shevchenko wrote:=
=C2=A0=20
> > > > > > On Thu, Oct 15, 2026 at 01:49:42PM -0300, Rodrigo Alencar via B=
4 Relay
> > > > > > wrote:
> > > > > > =C2=A0=20
> > > > > > > Frontend devices might not need a backend driver to rely on. =
An IIO
> > > > > > > device
> > > > > > > that supports backends can behave differently when they are n=
ot
> > > > > > > available
> > > > > > > and that should be acceptable. Such parts may provide basic
> > > > > > > functionality
> > > > > > > solely using the control interface (SPI for instance), being =
able to
> > > > > > > have
> > > > > > > extended features when a backend is present.
> > > > > > >=20
> > > > > > > Add devm_iio_backend_get_optional(), which returns NULL when =
the
> > > > > > > backend
> > > > > > > is not described in firmware, i.e., when the io-backends prop=
erty is
> > > > > > > not
> > > > > > > present or, for a named lookup, when the name is not listed i=
n the
> > > > > > > io-backend-names property. Other errors, such as probe deferr=
al, are
> > > > > > > still returned.
> > > > > > >=20
> > > > > > > To make that possible, a named lookup that does not match any=
 entry of
> > > > > > > io-backend-names now fails with -ENOENT, the same error retur=
ned when
> > > > > > > the
> > > > > > > io-backends reference is missing. Also, the missing reference=
 is no
> > > > > > > longer
> > > > > > > logged as an error, leaving that to the caller.=C2=A0=20
> > >=20
> > > ...
> > > =C2=A0=20
> > > > > > > =C2=A0		ret =3D device_property_match_string(dev, "io-backend=
-
> > > > > > > names", name);
> > > > > > > +		if (ret =3D=3D -EINVAL || ret =3D=3D -ENODATA)
> > > > > > > +			return ERR_PTR(-ENOENT);=C2=A0=20
> > > > > >=20
> > > > > > No. Please, use device_property_present() instead.=C2=A0=20
> > > > >=20
> > > > > Oh right! Totally forgot about that internally :). And it fits in=
to my
> > > > > internal point where I don't agree much in treating -ENODATA the =
same
> > > > > way as property does not exist.=C2=A0=20
> > >=20
> > > +1
> > > =C2=A0=20
> > > > Say a frontend consumes multiple backends, but some of them are opt=
ional.
> > > > If we care only about the presence of the property we would fail wh=
en
> > > > trying to acquire the optional ones when the required ones are defi=
ned.
> > > > am I thinking correctly?=C2=A0=20
> > >=20
> > > If there is an empty property for names, shouldn't we simply fail? I =
rather
> > > would consider the firmware table to be broken in such a case.=C2=A0=
=20
> >=20
> > What Rodrigo is saying is that an IIO frontend driver can have multiple
> > backends. So in practice:
> >=20
> > io-backend-names =3D "foo", "bar";
> >=20
> > But we might want to have foo as optional while bar is mandatory so tha=
t
> >=20
> > io-backend-names =3D "bar"
>=20
> Not sure mandatory or not is relevant.=C2=A0 Two optional backends where =
the
> driver can run with either or both of them would hit the same problem of
> present property but particular backend not being there.
>=20

True.

> >=20
> > So if we treat all errors (after checking for presence) the same we wil=
l fail
> > in the optional one. Note -ENODATA also means match_string() failed.
> >=20
> > As of now there's no such usecase in tree or oeven out of tree (that I'=
m
> > aware of) but to support it is also fairly simple that I don't mind to
> > have it now.
>=20
> I'm in two minds over this. It's unused complexity, but it also makes the
> function behave how a user might expect.=C2=A0 Definitely needs some
> good justifying comments in the code though as it will look weird!
>=20

Agreed! Yes, already asked for it as well special because of the non common=
 -ENODATA
check.

- Nuno S=C3=A1

> Jonathan
>=20
>=20
> >=20
> > - Nuno S=C3=A1
> >=20
> > >=20
> > > --=20
> > > With Best Regards,
> > > Andy Shevchenko
> > >=20
> > > =C2=A0=20
