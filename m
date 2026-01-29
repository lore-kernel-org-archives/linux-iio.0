Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859028B407
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705232; cv=none; b=Ykb2WPK0/hKAS0FlznVWmVc+gp5EgrzASI22vDlgMJegNzeeaBybC2yyE4R19ctlI2y/J7zGsUXWOilLsAm/NMGKWZayCnlYV1ieUWN107nSt0pYwgUdvYVqjVRhm62h9te7uaaT5UK3yrgx3W/MM1wBovDHCETbqcYZea94rzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705232; c=relaxed/simple;
	bh=MNuq80u8+0XUqZnhQp5dy6hX+LXyccg5B9Ki3oLa42E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQFepjIzd/4pUrFra9nKyKlAm6q4038oRIW4dd2t8wy8JIVFn+lAnozAgC6JGVoOzK21oER6Utz/OHy6dtwPhekh+ostBcrLg3hPk5kV/AcKJAd/cMdage1M0xzEG2UhF520mM7ewL9RJxF4/ApTqc3PutgBWeDZ4bkIq2m+wPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEgtUlIr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEgtUlIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F3FC19425
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 16:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769705232;
	bh=MNuq80u8+0XUqZnhQp5dy6hX+LXyccg5B9Ki3oLa42E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eEgtUlIr17upILUAhvn2nSLybR8lXEpc+95pOu0zLiWPqbRIV5JgY7/QC1a5nG1MS
	 Gb65qKyyLHIydwac/SK1xbR70goEJsEgpFU2b/laBG2kgArZu3cIS/gjBaWPHI77Uy
	 lsNNIc8KYRPFRd7w0lkzFfBEiBNMJPBDmz5rLyklPnrhJCHi6x9T9lHBlZa+Bu157a
	 gyuj8Ij9Mqa7ayqeSZnKVL6zDMp6yZYK3XbjVV83x85CuuHwJtQEJXmwsTwxuFNkl2
	 eZ13LSeV7Sr190uJA7PugDDM+nivV02arWsKM6k3A+OSW8eZU/ryExkeKmHwq9fMwx
	 6qBzMh0Uzw/Dw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so1925779a12.3
        for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 08:47:12 -0800 (PST)
X-Gm-Message-State: AOJu0Yxnl1579bJlPLFTyHvK3oZ3ZOpHYfeFkD2ITmav7XLOvaxVhT48
	qZza6wKjwka+LVAX0tlXBgxJ5selWpctTAL00qDmkz6NUvmK7KmWfUJdLqhpQ1HfD4nwcM5PGmB
	Zg9i5FHLZVvIhg2V8uw8FCmDqxp3FwQ==
X-Received: by 2002:a05:6402:3488:b0:658:31f9:9aba with SMTP id
 4fb4d7f45d1cf-658de53d19fmr101073a12.3.1769705230747; Thu, 29 Jan 2026
 08:47:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129071105.389493-1-jerrysteve1101@gmail.com> <20260129071105.389493-2-jerrysteve1101@gmail.com>
In-Reply-To: <20260129071105.389493-2-jerrysteve1101@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 29 Jan 2026 10:46:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJHbT9j4hdz141bzurc=CNcapfWhNg23YwLuptvdykHdw@mail.gmail.com>
X-Gm-Features: AZwV_QjTJ2R9nJB70o-Zi3m98OzR13EKOEglNd6iQ6_Vl1wv7XP8H3YNKXHCNoo
Message-ID: <CAL_JsqJHbT9j4hdz141bzurc=CNcapfWhNg23YwLuptvdykHdw@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: iio: accel: bosch,bma255: add bmx055
 accel binding
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 1:13=E2=80=AFAM Jun Yan <jerrysteve1101@gmail.com> =
wrote:
>
> Add the device-tree binding for the Bosch BMX055 IMU (accelerometer part)=
.

Please use get_maintainer.pl and send to the correct lists if you want
this reviewed.

>
> Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_dat=
asheet.pdf
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yam=
l b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> index c1387e02eb82..78f043c38e98 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> @@ -28,6 +28,7 @@ properties:
>        - bosch,bmc150_accel
>        - bosch,bmc156_accel
>        - bosch,bmi055_accel
> +      - bosch,bmx055_accel
>
>        # bma180 driver in Linux
>        - bosch,bma023
> --
> 2.52.0
>
