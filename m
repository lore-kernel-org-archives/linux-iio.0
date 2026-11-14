Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621502;
	b=1zEMxuYqxjNp66g/HVQPnPogM7y2Azkqz8Ef35jIyZlOGcav+0EE6arorAO/iVNmj16B
	 Ii1+fvagMELD81xOuNva1jZu3BS6gQWyp657wtvVhupILg8z7Vi1sfZbdFRMcHkiFJPuK
	 DLV66rqAuVJDi2IzB7H67Bm3Me+Ul63NUHjuiIHa7sBlfAEZO325V9i44QgUea658Zbcp
	 NYDESQYcl6sdnfFgemqvPL5+1xKFLMF4KUrCzloZjJS0j6fg/nBDgJf7tsp6oLsLfJYyU
	 HDJVdACEvxpXlw5Tp44tmd76HjEPF8qpJdefJR6SqDRkRrjZETNK+ln3sZntg6X5w2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621502;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fe35Q/3IDDZ6prbELBFxujo3LdlHb87WUsDPKR1hu+8=;
	b=xA8Cs0TOHXFGRIlechSpsI3pPolIWqQOMHmcUB6JYJi8JRYRH/bsYgI8Y0RwoXuASuGK
	 OUdkJwaCAFgo3UiUcoSRmXXpR72Ci29WVKHTVvxrL1O7ksmQAKA6t97ThovzPluBAHaYf
	 cnTvrtQUIBsW/ky3p8YIzSWIS07y1LietnpYehII0lWnDgfFCIVDJma6WrP1omX3uVWPX
	 46riNKJBfoCO/C8zreIgwxurZQGljIZ8kkoU0xakyaYTo/nr7JkIcMpLYiwiAHBvx9Rws
	 vyeVuAFymvI++DaewgYqrYB8CGFvAmLxCEqd6To6k4MklluIDy2FlxdAFbRtGYbOqnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqm2RBEV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A765606A883;
	Sat, 14 Nov 2026 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqm2RBEV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00241F000C6;
	Sat, 14 Nov 2026 01:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794621502;
	bh=Fe35Q/3IDDZ6prbELBFxujo3LdlHb87WUsDPKR1hu+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nqm2RBEVYIT/8qSe0BWBAprWu/scNovkiQOilMI9fF/jSQKLRerbcWExwdlHiHBYB
	 KppI89mbk9CeVcimLTJsCaWFMFaBa1u3gnix7iKGpHgQDwHCGB0LCKz9Vez2q7KkTk
	 Xz9OmB9DnJ38VbWs1BKcck5pSjvH0z1PIx7Z9QhJCD3kT2Ug4vlHPMXb6bq3KINHqO
	 uD+XfccZBQjQMYNlSZtTmONyHTKMNZW2naxsP2Fr/z/+jIJcEBdycoDOVlKfqXFmoU
	 4yNKzcGotFOkhbK1TuVsI2pm0A1Kj+wYni5QRWoNAS3b76WxkiH6mLkF/FuWTc/BCj
	 QYt4589ApMaOQ==
Date: Sat, 14 Nov 2026 01:58:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Oscar Alejandro =?UTF-8?B?U8OhbmNoZXo=?= Lucero <aleszlucero@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matti Vaittinen
 <mazziesaccount@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: fix kernel-doc warnings in public headers
Message-ID: <20261114015816.48c47aca@jic23-hlaptop>
In-Reply-To: <20261113081719.10678-1-kapoorarnav43@gmail.com>
References: <20261112-iio-kernel-doc-v1-0-e382fc9a47c2@gmail.com>
	<20261113081719.10678-1-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Nov 2026 13:47:19 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> On Thu, Nov 12, 2026 at 11:25:31PM -0600, Oscar Alejandro S=C3=A1nchez Lu=
cero wrote:
> > Fix two kernel-doc warnings in public IIO headers:
> > - Rename @consumer_channel to @name in fwnode_iio_channel_get_by_name().
> > - Replace repeated 'NOTE:' labels in struct iio_itime_sel_mul to avoid
> >   a duplicate section name warning. =20
>=20
> Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>

Applied to the testing branch of iio.git.

Thanks,

Jonathan
