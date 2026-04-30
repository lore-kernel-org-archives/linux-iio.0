Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C234D4CC
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566457; cv=none; b=iwBJQEbc25cWcaVLHBOIbmQ4cZ07xzFGnPzrFmGz+ZV2mtexlRA8AmAcU90eqwBPGNvZ2LqX8bdOB5u3pCyfvdokuvuZDTK6W3gr9J9/DpgCzK7XRnQVg0je+oJXDQqJTk4er4o4lvE6QyRGcvvj+bZTZueekWBP9aCXxTxmz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566457; c=relaxed/simple;
	bh=u1fvRFZSUv2KbJwFGKt093SPsyedKaxAdaLwKNVqWlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTZa9ULr1BLuXtVJx6jBO1HsFHn3hElFqgTrlYqLGgdpUB5UX+vZikZSMBcyO/mDNe/qTDVUm5iaKP7h/x69b1oeCopmKMPAyypuKAF0MpGdmZYiKRHCUtzUmvkfWsi3IeajZjdEhxdGN+dKdEU1pGv1ZkQFw9fc6Yx8/wZBZj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siJkPFb5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siJkPFb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B843FC2BCB8;
	Thu, 30 Apr 2026 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777566456;
	bh=u1fvRFZSUv2KbJwFGKt093SPsyedKaxAdaLwKNVqWlg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=siJkPFb5+QL+B4JAX9QMWQgxeB/iG3QGrrNl2o41cZsJPO6951UCeySZFnJp9yww2
	 01lAyqQvPx5bwkIA37H1Bun19GpXQyZq2YYjRRKOQ1a9/DsvHGQYXONrExBITPsvDP
	 c6MjEHv5dwR1E0jSUNemMomOa0YL3tLoBir393r1yrnTUVIXagvKMP8mgqcg/6jlrS
	 1Y/jsRXj4PEdOPwjC+CpqiOz1Y+BrNt/BNiMWCvZmea6Bgi3GJVYEdbXcPewSTBj8h
	 XxNsWktuU9OApTVSubaRB5vNU8tCYzy1BdSaj7IOFkSTTwRSb4NPmo5GCcrEXKi4DW
	 lV/b0MdAcOAOQ==
Date: Thu, 30 Apr 2026 17:27:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] iio: adc: rcar: Fix up Marek Vasut MAINTAINERS entry
Message-ID: <20260430172729.262fb6f3@jic23-huawei>
In-Reply-To: <20260429192751.543190-1-marek.vasut+renesas@mailbox.org>
References: <20260429192751.543190-1-marek.vasut+renesas@mailbox.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Apr 2026 21:27:23 +0200
Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Use up to date address. No functional change.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Applied to the togreg branch of iio.git
(I'll not push out for a few days though as travelling)

> ---
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6ea8e7212e992..c35e103243b4e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22600,7 +22600,7 @@ F:	Documentation/devicetree/bindings/mtd/renesas-=
nandc.yaml
>  F:	drivers/mtd/nand/raw/renesas-nand-controller.c
> =20
>  RENESAS R-CAR GYROADC DRIVER
> -M:	Marek Vasut <marek.vasut@gmail.com>
> +M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml

