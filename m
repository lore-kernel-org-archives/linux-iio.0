Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FB822B8C5;
	Sat, 28 Feb 2026 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772280497; cv=none; b=I4fbKkeTy5trtndqXNL5pB7NfaLLJDNVBlSrY1sqnmB1RbEOlT8tGngVekJxxeylGCwDwFuxZF0WB+TxpqxIXkceyHE3gojyEZ0CD5JDbvbldyrISOFy1mBbqK3LC0x5hAUd2dUfPgcGQA9ksE6GtKeyHP/8OAD/k6ZT0KMyaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772280497; c=relaxed/simple;
	bh=Ct82yAkjBV96tZZ8zxvrniU4pd5pAyfMResFmxMDoAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/0Ip3W1h8Xh2E6SNd89hKek20yPMCoeihJQcvWy5DumDOCdMsbtezhozF9dxBjCPvQcN/llnq3o4TEOAfXnnqlRwvnH7rgSsfqAjCvGnpbNDyonC7GQmI/poqnStNEAq+dng4rfW1L1Y3t5eskXtGygS1DkHPRJMuUDNEP0nJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pITghd6g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pITghd6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2248DC116D0;
	Sat, 28 Feb 2026 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772280497;
	bh=Ct82yAkjBV96tZZ8zxvrniU4pd5pAyfMResFmxMDoAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pITghd6gTpKMAwY0U+x2vxf+2FmLU9ZAG/RvdStDNL/J6bCb8+JXDUgJ4rvlSGvJt
	 yUU4YewF6xwEvQ9C54bthqSgrkv/0CzlFtOP3JfvdSIQygzHhyHAL9rxBdaJPfXeTn
	 KtzUEOxcmmuXFlG9CSw/XMoEychPC407vVTJcJtxKd9yfqQKkVz/KPqrJFLxa4B0tE
	 LOtGosYtmPdB6Xhf+i7A2hYHGLeC4/F5rL9TL3N2R6B1JQZj5/1UWbp9isGR2dgSAt
	 UAri3ifJpbRZ7hea+a0qMYwme6c9nT9AUYLRWtds2gf5atfEoCJH/KG3QUmQEWDt2a
	 DE1DdAre8hmsA==
Date: Sat, 28 Feb 2026 12:08:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ade9000: fix wrong macro names in
 ADE9000_ST_ERROR
Message-ID: <20260228120808.64f8299b@jic23-huawei>
In-Reply-To: <aaGt38ePGhonQRmd@ashevche-desk.local>
References: <20260227100900.72980-2-giorgitchankvetadze1997@gmail.com>
	<aaFy3JVVL_nvSGsZ@smile.fi.intel.com>
	<CAE7dp2qN4mxJfSYXxFQY9sdLR3eQemwDOEur3QxcMU2TNBZTig@mail.gmail.com>
	<aaGt38ePGhonQRmd@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Feb 2026 16:44:47 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 27, 2026 at 02:52:45PM +0400, Giorgi Tchankvetadze wrote:
> > On Fri, Feb 27, 2026 at 2:33=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> >  =20
> > > What about the current code that uses it? Is it even in use currently?
> > >Please, elaborate more in the commit message that we clearly understand
> > >that you spent time and investigated code and/or datasheet before craf=
ting
> > >this change. =20
> >=20
> > Hi Andy. Thanks for the feedback !
> > The macro is currently unused in the driver, so this does not cause
> > a build failure. =20
>=20
> Drop it then?
Agreed.  I'm generally in favour of complete definitions of the fields in
a register if any of them are used.  However, in this case it's a define
of a mask covering multiple fields that we have no use for.

So drop it for now. It can come back in a patch that uses it.

Thanks,

Jonathan

>=20
> > Reference: ADE9000 datasheet (Rev. B, Page 61), STATUS1 register (0x403=
),
> > bits 28-31 define ERROR0 through ERROR3 status flags. =20
>=20
> Yes, good, this should be in the commit message.
>=20

