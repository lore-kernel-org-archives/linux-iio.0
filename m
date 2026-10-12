Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C3372B2F
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812819; cv=none; b=s3NnjwWd1hblaE6fYnSjbbLgZTNDpOQAbeOfJSbu3FMp4B4Lsu3QgQmuK7gmr9b9gOz6hm30il6uNYBbLtzOXq0sBa0MUFgbyOOR/t0x9F1OFKxbC0a9MB085aSoQ08dtonpdH3qaTcj6e2d7VWPPy/grL/2CTLjAs/0ROXtPjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812819; c=relaxed/simple;
	bh=qjaI97jXVDe8RUjWaIZn/0Z/bG3SM2HUqYlAbco6hkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjINEaDYj4ddQlrkKOqJ8fTLcaolG4kBroCQJVk2pgswUpm6Kz23nlJZYrBvjL4HwT4rV7Xes9hh+67LmZx28SwIneb9mz5jTQu0TWFaarBNW5Dr+SciIOBVIJIwV3ShUGVUbA3V5B/ECWOAZXnQxJjXaOs3/bt1UpLvYBiLu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gA8ujL9J; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA8ujL9J"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1853624f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812816; x=1792417616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3qFNfYV+xp2TW71TFMQFiYJu/H+Cb9LjfXq783Ex4Js=;
        b=gA8ujL9J7sKs00uG9+ognaN/ZhA4HLhKQxKPbcifuFCvdHzvpk7dRXx1iHXKbPyVW2
         LkHtBp1oH5Ozs4KNutcxzZyiH4wfnnCifYmw9Cl25Xcn2nJBuYEawNylcYlbQqPpeNBC
         +4HsZtO1FFVNKKjmnf7ZRa8lHFGM2uBNoFbTXELEtUU44dfys22vifsROEgylpihJIlo
         NymA3iS+HXw+zu6rCwdMqPAg6HWsIABHuQcEZsnkxZkKeLg1/jDLLpIkxnPMgDjPtUNb
         dWNokotvCKC8DH8NjJX6YC3NYmbmnRl7exHK+JmyprO8Mb2pceu8ZaN+/2V51Cl3FhG2
         XqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812816; x=1792417616;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3qFNfYV+xp2TW71TFMQFiYJu/H+Cb9LjfXq783Ex4Js=;
        b=mob47qjJiVBi7DsPTcQrnU+SDI2LUu1dtagmq+Lo9ZMl9DNSG8Zu1qPfDX+9c4k5v/
         7jXPR7wk8Bf9v8idfk4FPahMfQE8gniar1KbyIGrueK0xL06hMoiUbv8GLy53Etq+ykc
         mPtcQ165SmS+Yr8FiYLnDBDHPtt1txFicAX6n5nd4/LESkKq+f7W51JFh7xZW/H8zFVK
         fYe2EdCjxlIkoMTLIMcYpKobu6GDKZpOiP241gnkkQAiw2a+unwgy7lLXBfMsJAUFZCh
         sc0+PCSgtvumZAkQvJOsyYfTtU0LUvyCop3cgednu+1hIXrjF3qPYoX4gHaRVaFObiG1
         Ahfw==
X-Forwarded-Encrypted: i=1; AKwUvByk/UaoK7BisT7+gwE6HUOUUfFAOUvnmKEzK6eiG8GyHyE7AsWOuOnRgscb7ukn8ldxnwrKMPMRmRI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfnVBt/QpULjHPof9gBelfD2lHNwNhAxbx227SSRbya/XnoBdt
	hrlzbBEqmE48unnYdoVpgRYfrAGNqMIC+VeVUrP0tVeBtP1bO6EqtVDZ
X-Gm-Gg: AYBFou2sA2T0sPaGloyJyCA514OOPNY+/TqRb5RnZv/fGIH4ieWnmRtq4lljd3jBFuu
	ctlGsrGupXhEYt8dQl3dkeEBVYx/D3Hht+X7ilwTaGF8JkMMpMxjPIOJj/nq0N5bxToD++nBRDB
	dOcY8CQMqnud904sjaEWRgi4XzGA7lPWB5p9dbCkRj4U/NRY9Nwm0C8hODztcUzjytE5ryYwc5c
	084/QJ8g0Sc5PD2ELp74cP/mclC4QLvoKk+o/GtvqItQpy1ZgfZkmBfLJjTSpKW6bbPucda7geJ
	9HvhVNAKGwEY5NVR2Ly9zMScpGxDteSU+QntN4WSSfMXmiQ97qyNbYTZYYCAZEpin5iv8Z39kh/
	8QMMQvs1Gs3LPIyH4z76ML1m76Oq4JCnqqta5PlfXKpG03+YInpfm1HNpqdRYehoGpAYNggkN3U
	YDw0+ipDC1AHU4f8p8/laumU7q30INLxF1M091+1EVYnYBDFur5DbO8+hi60iLkddTRMtpYmB3v
	KSCwl3OPsE4O2aRPyVqqeqe0GWDoWXqfj5p/EYp9POpTUOAgveMR7ZvrBdZZS7ewP1GnL7jJ6SV
	JOGKCBF6im9DyuPLloJk4JJV29jnHk8xmefGTmCQJ9avkiLEfKcpLLp52QTmLeQG1gKv3EJ1pNa
	pr0+XYcWdAeeHy1zyoVOG1Ovz0dd3ukeDnDbxbviF8gQ7gIaziBsa5DfY7YhlmPuC91u4swUpuA
	VSET/p
X-Received: by 2002:a05:6000:469b:b0:487:f31:8037 with SMTP id ffacd0b85a97d-48dba9db1a1mr11110656f8f.14.1791812815713;
        Mon, 12 Oct 2026 06:46:55 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9aadf9bsm19148872f8f.29.2026.10.12.06.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:46:55 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:46:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Radu Sabau <radu.sabau@analog.com>, Janani
 Sunil <janani.sunil@analog.com>, Salih Erim <salih.erim@amd.com>, Jishnu
 Prakash <jishnu.prakash@oss.qualcomm.com>, Jakub Szczudlo
 <jakubszczudlo40@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: adi,ade9000: add adi,ade9039
 compatible
Message-ID: <20261012154652.00004ed4@gmail.com>
In-Reply-To: <20261012111342.48040-3-antoniu.miclaus@analog.com>
References: <20261012111342.48040-1-antoniu.miclaus@analog.com>
	<20261012111342.48040-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Oct 2026 14:13:38 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADE9039 is a polyphase energy metering device from the same family as
> the ADE9000. It is register compatible with the ADE9000 for everything the
> driver uses, provides the same on-chip dip/swell detection, and shares the
> full-scale codes of the ADE9078.
>=20
> It computes only fundamental reactive power and has no total reactive pow=
er
> register, which is noted in the description. Like the ADE9078 it supports=
 a
> maximum serial clock frequency of 10 MHz rather than 20 MHz, so extend the
> existing spi-max-frequency constraint to cover it.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/adc/adi,ade9000.yaml         | 29 +++++++++++--------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b=
/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> index bcc166aad713..70106dd052ce 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> @@ -5,26 +5,28 @@
>  $id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Analog Devices ADE9000/ADE9078/ADE9430 High Performance, Polyphas=
e Energy Metering
> +title: Analog Devices ADE9000/ADE9078/ADE9430/ADE9039 High Performance, =
Polyphase Energy Metering
> =20
>  maintainers:
>    - Antoniu Miclaus <antoniu.miclaus@analog.com>
> =20
>  description: |
> -  The ADE9000, ADE9078 and ADE9430 are highly accurate, fully integrated,
> -  multiphase energy and power quality monitoring devices. Superior analog
> -  performance and a digital signal processing (DSP) core enable accurate=
 energy
> -  monitoring over a wide dynamic range. An integrated high end reference=
 ensures
> -  low drift over temperature with a combined drift of less than =B125 pp=
m/=B0C
> -  maximum for the entire channel including a programmable gain amplifier=
 (PGA)
> -  and an analog-to-digital converter (ADC). The ADE9078 and ADE9430 do n=
ot
> -  provide the on-chip dip/swell detection available on the ADE9000, and =
the
> -  ADE9430 has no on-chip digital integrator (it uses an external analog
> -  integrator for Rogowski coils).
> +  The ADE9000, ADE9078, ADE9430 and ADE9039 are highly accurate, fully
> +  integrated, multiphase energy and power quality monitoring devices. Su=
perior
> +  analog performance and a digital signal processing (DSP) core enable a=
ccurate
> +  energy monitoring over a wide dynamic range. An integrated high end re=
ference
> +  ensures low drift over temperature with a combined drift of less than
> +  =B125 ppm/=B0C maximum for the entire channel including a programmable=
 gain
> +  amplifier (PGA) and an analog-to-digital converter (ADC). The ADE9078 =
and
> +  ADE9430 do not provide the on-chip dip/swell detection available on the
> +  ADE9000 and the ADE9039, and the ADE9430 has no on-chip digital integr=
ator
> +  (it uses an external analog integrator for Rogowski coils). The ADE903=
9 only
> +  computes fundamental reactive power and has no total reactive power re=
gister.
> =20
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
E9000.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
E9078.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
E9430.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
E9039.pdf

That is a very short datasheet :)

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

--=20
Kind regards,
Joshua Crofts
