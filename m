Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C498366802
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700655; cv=none; b=C42zFilF920vA1G+PskItrNBG2mIZo2Rd+mGRBjquo6VEhwjzvvfpNHp5oVGzGoShMUVU4G9N4SoXiAOwghxZy0ki7jPDzbeiOJFHDbsmEWqWh7XSyzlDDtc+tCgQlqjKw846CfgPXuW/vWKGDkmYyCxmaOjTP4/BPVg7hHbJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700655; c=relaxed/simple;
	bh=GlTPU8Mt7eFEjXHRyiBvPGsxdFomYGG+0QQB54QGkZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+V8AHw2yFTfvmpk35Og4zDFg5CAGFJZGBqfE42X2CZZ9832/j5DGpkj55Y1Ls4yME8dUdmMyOqMN2uKn4N5lQFiXHwf+H3Hn+9hz37Tbu2X9IpYYldUZiOQ/dCnzW4pHukbUHlZbbRskswIOae9Fot5yLCTdh/BWM6bN3k7spY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qq7gv4I2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qq7gv4I2"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso3303773f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 00:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772700651; x=1773305451; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GlTPU8Mt7eFEjXHRyiBvPGsxdFomYGG+0QQB54QGkZ8=;
        b=qq7gv4I2Mi3d7mMfsiwdwN9C3NG07XlPRLbo1j5VuYobLpNBOW7PbaV7YIKndvzIJ3
         lDIoU1GyCah+QIQMVI4+QBS1MGd8ZbRvLVcGYlHexaiqg6x9hOXBV3djt2Vpb5w1lPRa
         NeaQ3y+EesHwQPg1XpF+uR4X3I8yExjaOg91AlSN0uwzKuzndi+XesTi9P1x/ssnqNcr
         7gHCXFQBqDHNGZlCrcHhHHjRE+roZ+owffwvOdyRPOZrbFe96+FeKwyPYMyrwTeRw5+K
         X2x1zGFpjyQkfIJk2GVzHYDk4oX/K7WWCoarsCEcmPGRxlDkJZFikGkHlVorlShVJFYC
         rVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772700651; x=1773305451;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlTPU8Mt7eFEjXHRyiBvPGsxdFomYGG+0QQB54QGkZ8=;
        b=h9ZZfG5OJBQXm2RsYvor1X8TKLIBu58DyotUmV/hUYFXE0zDH1XU/SorYSTQr8UA1K
         ShP5XKNQPVASnj90v0/CyQthGjVPCNCo10N8Z5TbyED6TYwn9mZFrxexcOiDjpHvDdCX
         +SXl3qMY4ZS1B8QjRNVTiNRl6WugdKLF2nN2ls40lEacADQPmGf10qk7177D5Je1USdc
         R/mmJtU24T1s6aZwK20yS+cC54tWX4HZ4Ma7TrIBQa9mOeUZD8vzPqkInqeZgL57LAgq
         oTPc3Y1Xzn4085dV6m4rYAYVLiPVWmu7I7/xPkTIb6pLBSNOdL2JuK0Wsp1OEnFoq/hP
         yT1A==
X-Forwarded-Encrypted: i=1; AJvYcCXhsqvfEQg+1OPsUpNJLXG6vVMGoV102Eo4D9rEJ9XeapNpzt68po1KflT//9V5ZufbyW6O+HBmqvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeFwt5ofeiKD5P2MEgQUQpPlX1Qq8fNP3IWNT3V+bj8UftRKMj
	DDdAE5PKCYwX4ybyLzeJag4EMObXo7vpiOp0jEZD7uFEvMexGmxp5chObpOuinsWAx+Gz0uAbTQ
	HVJ/ywj8=
X-Gm-Gg: ATEYQzySU50OGa+6LMJCXuOc6Mv8H9egO8RAul3igHaGWX2jVIdoSrsqvMoaBf4lKM8
	LgiVHB7jDkDFhyoiqx7t3H2WBA+hB3jueMtCtSVLuuueJ6ZQsGYicyR5mUXJeBkmh1x026HXWdQ
	BOieXJYx85ZjgFFv4ct6PRxpUcwxdSOfZ6EGtDqGLE/aLqYzQ7+D0lEZr89VfA3L36IKL4n5WGX
	pB2xKCvcY9D5xsh4l3zJKCp3r+wjJ9LNQ+dfXi6QI+VC1z3f4K21+NefZGJ4n1H7lGxJyW8MvLZ
	Iz2Z/uoAVPhglhAhNAueMFr03B+cLhYRYIc7Sy/YSCUqcJxnuqAcsgJRfTuGAOk4r8hotWXoRv9
	uCxsbAk5cwPHNKb14maXeZRkxczs4jVGAqKZfk8Q/uG1vybLCcfo/J2oQ6obr7wQh/tZDq1exzZ
	5jfknIgSJMJqen6VAf
X-Received: by 2002:a05:6000:186a:b0:439:af96:29ea with SMTP id ffacd0b85a97d-439c800f446mr9383025f8f.41.1772700651417;
        Thu, 05 Mar 2026 00:50:51 -0800 (PST)
Received: from [10.203.83.244] ([151.19.52.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a25dsm47644289f8f.21.2026.03.05.00.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 00:50:51 -0800 (PST)
Message-ID: <0e808a2522e4021187ccf6aca5d8baae4beeed6c.camel@baylibre.com>
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
From: Francesco Lavra <flavra@baylibre.com>
To: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Mar 2026 09:50:49 +0100
In-Reply-To: <ae79da24-1129-461f-a8ff-9dadfc863fee@baylibre.com>
References: <20260304080519.2844101-1-flavra@baylibre.com>
	 <20260304080706.2844472-1-flavra@baylibre.com>
	 <aagc1_EkH3cqh41O@ashevche-desk.local>
	 <a265489380e7abc9343c536185bc203688c5bd29.camel@baylibre.com>
	 <ae79da24-1129-461f-a8ff-9dadfc863fee@baylibre.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-04 at 16:42 -0600, David Lechner wrote:
> On 3/4/26 8:21 AM, Francesco Lavra wrote:
> > On Wed, 2026-03-04 at 13:51 +0200, Andy Shevchenko wrote:
> > > On Wed, Mar 04, 2026 at 09:07:05AM +0100, Francesco Lavra wrote:
> > > > This modifier applies to the IIO_ROT channel type, and indicates a
> > > > data
> > > > representation that specifies the {x, y, z} components of the
> > > > normalized
> > > > quaternion vector.
> > >=20
> > > ...
> > >=20
> > > > +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/=
sys/bus/iio/devices/iio:deviceX/in_rot_partial_qua
> > > > tern
> > > > ion_raw
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0Raw value of {x, y, z} components of the quaternion
> > > > vector. These
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0components represent the axis about which a
> > > > rotation
> > > > occurs, and are
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0subject to the following costraints:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0- the quaternion vector is normalized, i.e. x^2 +
> > > > y^2 +
> > > > z^2 + w^2 =3D 1
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0- the rotation angle is within the [-180, 180]
> > > > range,
> > > > i.e. the w
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 component (which represents the amount of
> > > > rotation)
> > > > is non-negative
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0These constraints allow the w value to be
> > > > calculated
> > > > from the other
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0components: w =3D sqrt(1 - (x^2 + y^2 + z^2)).
> > >=20
> > > Just to double check if we really do not have a special mathematical
> > > term
> > > for
> > > that already. If we do, I prefer to have that over odd "partial
> > > quaternion".
> >=20
> > A quaternion is often represented as w + xi + yj + zk, i.e. it's
> > composed
> > of a real coefficient (w) and 3 imaginary coefficients (x, y, z). With
> > this
> > notation, the (x, y, z) components are referred to as the imaginary
> > part of
> > the quaternion.
> > Alternatively, a quaternion is represented as the combination of a
> > scalar
> > value w and a 3D vector value (x, y, z). With this notation, the (x, y,
> > z)
> > components are referred to as the vector part of the quaternion; this
> > can
> > be confusing, since the quaternion as a whole is often considered as a
> > 4D
> > vector.
>=20
> I'm surprised there isn't a common name for this. When I went looking,
> the
> thing that came up most often is that Doom 3 used this in their MD5 file
> format. So maybe IIO_MOD_DOOM3_QUATERNION? (joking)
>=20
> I do think we could come up with something better than "partial" though.
>=20
> My first thought is IIO_MOD_3D_QUATERNION since it is a 3-dimentional
> number,
> but I could see that being confusing to some since quaternions are
> generally
> used for rotations in 3-D space.
>=20
> Maybe something like IIO_MOD_3VALUE_QUATERNION or
> IIO_MOD_COMPRESSED_QUATERNION
> or just IIO_MOD_3QUATERNION?

Or, since this represents the axis of rotation, perhaps something like
IIO_MOD_QUATERNION_AXIS?
