Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8658444CAD7;
	Tue, 28 Apr 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392884; cv=none; b=oO0hBvh35mO+PkEtkLLXw/CYLFJz0PPVUIus7Qrax4R7Ko0b828s06CpJMpF6fDXR79fEYEQtccCrNhK8koyw1bjRTxJ5BILsSF3CCU+XOlICVjFDjUePKkSSAeyjHF6kjGU+ILjDujbXue85tq28ZBPmN0e5i97JyI0Nsbdfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392884; c=relaxed/simple;
	bh=ibQFFoVMJwCRVQsKy85H8axOxslgVxHhLiPjETpz8Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkGkS0MipkrhNuou8LFGHv/+soJlSQrELLTL2UmeOgAVZgMMIXC6VFKAolr8vZXhy1McacTnNhkonyKiqUNamdlJTIgTWplqK4b/ZJg5WXM2IBPICEowY/3II3Xeu8O1BHRP2rVryeskR5Zx/f4wCLyJ3ZiAnyiPOKDEqfEt6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmdjEmCs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmdjEmCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3840C2BCAF;
	Tue, 28 Apr 2026 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777392884;
	bh=ibQFFoVMJwCRVQsKy85H8axOxslgVxHhLiPjETpz8Ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cmdjEmCs9zDmCmOuNynCIXqa0hY86ArIb7YMseou0qiF6necZiMXg8XKwvykouXIS
	 HTPgwSUYP8eEcve7MumrNdjqS0HvRRt55XnJBcdrwXKZowx6npTxkgy+Jn0wJduR4s
	 rVIZ+KNKqWjk1sCTBRckexoEsx8cyzjfW255iwrOkCBg3VtU/4v7Iz9nyEdg67uT4p
	 S8VJo/3ffP+kXg0UNAOBVKH0DWyeHcaII5H2VGCArCdE3TCrBeQlKtEIjct+JO0fEU
	 T9eAxQxlxhgrGTQkMNsee1kUoaRDPn1ffoD0CjyDZJIodS/kufEs5LEwkR6afuDMva
	 95kaNnFt81EtQ==
Date: Tue, 28 Apr 2026 17:14:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rahman =?UTF-8?B?TWFobXV0b3ZpxIc=?= <mahmutovicrahman5@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: Fix indentation
 in of_match table
Message-ID: <20260428171437.35203299@jic23-huawei>
In-Reply-To: <20260427202016.1635-1-mahmutovicrahman5@gmail.com>
References: <20260427202016.1635-1-mahmutovicrahman5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 22:20:16 +0200
Rahman Mahmutovi=C4=87 <mahmutovicrahman5@gmail.com> wrote:

> Replace leading spaces with tabs in the of_device_id table
> entries to comply with kernel coding style.
>=20
> Signed-off-by: Rahman Mahmutovi=C4=87 <mahmutovicrahman5@gmail.com>
Hi Rahman,

Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/maxim_thermocouple.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/t=
emperature/maxim_thermocouple.c
> index cae8e84821d7..7f80fa018ab4 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -271,8 +271,8 @@ static const struct spi_device_id maxim_thermocouple_=
id[] =3D {
>  MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
> =20
>  static const struct of_device_id maxim_thermocouple_of_match[] =3D {
> -        { .compatible =3D "maxim,max6675" },
> -        { .compatible =3D "maxim,max31855" },
> +	{ .compatible =3D "maxim,max6675" },
> +	{ .compatible =3D "maxim,max31855" },
>  	{ .compatible =3D "maxim,max31855k" },
>  	{ .compatible =3D "maxim,max31855j" },
>  	{ .compatible =3D "maxim,max31855n" },
> @@ -280,7 +280,7 @@ static const struct of_device_id maxim_thermocouple_o=
f_match[] =3D {
>  	{ .compatible =3D "maxim,max31855t" },
>  	{ .compatible =3D "maxim,max31855e" },
>  	{ .compatible =3D "maxim,max31855r" },
> -        { },
> +	{ },
>  };
>  MODULE_DEVICE_TABLE(of, maxim_thermocouple_of_match);
> =20

