Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1F184;
	Sun,  2 Aug 2026 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785629101; cv=none; b=OQwtqIx/I1vaJ3E5uSYbaMPfA6SQ98RktlSoXVPocZ3ojiMU01Q7BYTaGZYEH42azyVM7EBoRmdL2HsFzfVxH3l2qTPp6jRp/L6N0zx08LT63jZeS8BzzNI2ZMgvT61hiwst9tQjhl+nthfKqefv4Zl0KmTdimAZn9NMywaRRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785629101; c=relaxed/simple;
	bh=L5kznM85eToe0a6YR5NzaMZxejxflXCvsllI8APaV44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJ6GpNbZL5Cxjmq69zVDppUrshtvF/WhBsgs1Jbp2/QWIy6Z5wK4PJ9Eb/SrjMCU0r64M4lLNRqJrTcWW03SSIcahIp773mEBjtkrGoa1/S5nT29y/Fmb2bKqetVKcBHC5gt0+E65+XloYx5ukw9E18/x6D3SgRgZTu15rm5uPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkzlTgb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkzlTgb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4198A1F00AC4;
	Sun,  2 Aug 2026 00:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785629099;
	bh=L5kznM85eToe0a6YR5NzaMZxejxflXCvsllI8APaV44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GkzlTgb4YS49zcdWhYKg2TFDFfaku/CUx1K7OoqtffX0/lKyrkbVUWsgGJAJyaZm8
	 hmJvMyHEGnO1u5hk9z7woCzvTLD39kcqZQi+XFkpsSCxILcsDBeoUtD5e+LsBrPavL
	 VaOX7L0NSlQTmfhFd+ArgzpfMd2bGoX2pp+vxGRJ+BipA7vrBGIq+Uk0jZSkzhKZt4
	 Zvur83u0uIU587EZLrz5HKvUpRTs6uIdULNOeU0w1wT+uoufi1ek3tyvuwIN014+Z+
	 AaBPbq3yYmZTSZwsWxyjzGIcwLL0YMxIow+8nWQv/wbJipZHSOwsBXMXGjuN3Qvyum
	 zdn90ioKY8DSA==
Date: Sun, 2 Aug 2026 01:04:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Wadim Mueller <wafgo01@gmail.com>, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, maxwell@maxwelld.cc, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt1@gmail.com, 455.rodrigo.alencar@gmail.com
Subject: Re: [PATCH v6 4/4] iio: flow: add Sensirion SLF3S liquid flow
 sensor driver
Message-ID: <20260802010446.484ec259@jic23-huawei>
In-Reply-To: <amnvxnjaDZRrLEte@monoceros>
References: <20260728214943.29820-1-wafgo01@gmail.com>
	<20260728214943.29820-5-wafgo01@gmail.com>
	<amnvxnjaDZRrLEte@monoceros>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jul 2026 14:21:15 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> On Tue, Jul 28, 2026 at 11:49:43PM +0200, Wadim Mueller wrote:
> > +#include <linux/i2c.h>
> > [...]
> > +#include <linux/mod_devicetable.h> =20
>=20
> <linux/i2c.h> already makes sure that of_device_id and i2c_device_id
> are available and <linux/mod_devicetable.h> will go away soon.
I tidied this up whilst applying
>=20
> So please drop the latter #include.
>=20
> Best regards
> Uwe

