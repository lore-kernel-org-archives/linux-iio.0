Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12DE3E3C48;
	Mon, 13 Apr 2026 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109512; cv=none; b=E21xadNf1P/TYjK2pmz+5I2wKlYFpCN6WsR0D4fd30J4yAQWTteKPLLo4SlOQ7RYgtCssM013Hmjs6YT+iJ17OuijghLkwQsj5t/jCmq1OBT3JfIR2sLcsGncEmYrHpCkLxjv2wUbSauoJAIczgjxFA+x8F0iUc8aPqaa4Ne+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109512; c=relaxed/simple;
	bh=Xzf3ggL1FDtaOntJ7X8LJh18CfZgywP2PKlRL6D4aXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP6xLlwiNkmUF7nlp5WB/7ox49tcX0W2L4I0kw5LvDbE5BkYofhSLDPNSjIs8elUz/16mzq3R2wG7OOjAat+Cn1wUPYpIDNPLCsEqFkFcgkWt6QAqt424qcxCx6q5uJDEBoDYarzB7Pj1SK0IvCCMtRY3++7ofHdD5kI7Sf/H+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aELn3pAh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aELn3pAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212CBC2BCB0;
	Mon, 13 Apr 2026 19:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776109512;
	bh=Xzf3ggL1FDtaOntJ7X8LJh18CfZgywP2PKlRL6D4aXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aELn3pAhNgeziFQaGuFSXVImlzqrLKtJXU4OkST38W55JMKhMt/6e8tQbsv5fTgWI
	 KBrfzYraHQf4kEOrczck2YTokSKH3sBhntmsfCPW08G8P10AUyQ9RNsvkjtMXadAnH
	 wxS/FA8TV2CUBqbnecvclOCQoUHnEa9qjTtwLq+3y7keIvdM2iQc0rqRY2+FgfWFjX
	 L7H2uAEsD83LR2f/oyU2X3D1ewfF9m6WVbSVKNUZTFAR7HY2miQ8AZ8KDIRgnsamLW
	 RYZvGJR4c0eGqWyEsS5i+bqfNhR57klTHd86NBbEt8W8r7aaWA+joJuBlt91LdOY8M
	 Hfgpm+PB6NXhQ==
Date: Mon, 13 Apr 2026 20:45:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Greg Kroah-Hartman <gregkh@suse.de>, Barry Song
 <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: adis16260: fix division by zero in write_raw
Message-ID: <20260413204503.444cca81@jic23-huawei>
In-Reply-To: <acuqM42TLd4edTWZ@nsa>
References: <20260331101300.15853-1-antoniu.miclaus@analog.com>
	<acuqM42TLd4edTWZ@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Mar 2026 12:04:45 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, Mar 31, 2026 at 01:13:00PM +0300, Antoniu Miclaus wrote:
> > Add a validation check for the sampling frequency value before using it
> > as a divisor. A user writing zero to the sampling_frequency sysfs
> > attribute triggers a division by zero in the kernel.
> >=20
> > Fixes: 089a41985c6c ("staging: iio: adis16260 digital gyro driver")
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

>=20
> >  drivers/iio/gyro/adis16260.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
> > index 586e6cfa14a9..91b9c5f18ec4 100644
> > --- a/drivers/iio/gyro/adis16260.c
> > +++ b/drivers/iio/gyro/adis16260.c
> > @@ -287,6 +287,9 @@ static int adis16260_write_raw(struct iio_dev *indi=
o_dev,
> >  		addr =3D adis16260_addresses[chan->scan_index][1];
> >  		return adis_write_reg_16(adis, addr, val);
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		if (val <=3D 0)
> > +			return -EINVAL;
> > +
> >  		if (spi_get_device_id(adis->spi)->driver_data)
> >  			t =3D 256 / val;
> >  		else
> > --=20
> > 2.43.0
> >  =20

