Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31486332901
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424795; cv=none; b=F/5si9x9UMLRlN7Li5D+vvqPkzN5g0rFvlX+HqBouzhKKrfpOhKJckifFcBP8aMxpCRmd62wBl4+SyE/v8Oxfko5gmUbpKmHZH/VKg/ow9Grs+ZhJJ9SV7vDkYpidETWL5H4ArHp+ufqxjgffLWETVYSKI+WH7ISQTFHPEYF7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424795; c=relaxed/simple;
	bh=kxPtlEXFZ9lzbdFRuzXSQejeJO9JqTeeLPP+hygrZgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/JdcHoalkLZdOjTedf5a+ejVPkHTrFOkg56dQJaViLAIEPadgyCBjKurkzGsBrOqGBN1ixZlN2Zah0acxgoJxRm5q2/LCfN/bVCfkrV54hc01mQRJeRKpjbTqgGID+9CTxNTmWZM6aboppd4tcXmTtcpD7ij/WbXc+XMO2oAo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etRmZctl; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etRmZctl"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-385c6c727fcso37856401fa.3
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 02:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769424791; x=1770029591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4K6ETBKLvIoiuBK+sPeSvqfE+sePiRFMG7yACoX51I=;
        b=etRmZctlyi3AMsxIBHAhhiEF1m6jIVPgiQCudusRyaEz5lqdb0RKxpCWJ/aPyBgklk
         gcVmDUFsc9UEOmePtkfNWF2y1h25vIefkTyImXRDB2+a5yGMC5U3oumu7ZIqpejM8+nP
         iB3DOmoHlaQschGUKoKp3OdQlatHa6pPz63FfzEsRzgnVSaBhSYV39NVrhQWfXNqcVl+
         mnml7sldnJ6MRxa8Cwb+1p28B/7qmBUQn7VLvwAUwimRh1fm4JR4a9bu6iMluVr3ywe7
         BVxPlzKlcdAiwHY/KJZBbPm1tqGK5reUcAZgv+M1ZDZrgeX2ZN2emKBs2C5+gAfPquSv
         +oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424791; x=1770029591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4K6ETBKLvIoiuBK+sPeSvqfE+sePiRFMG7yACoX51I=;
        b=BQ+31CBNYW4/idNm6qS5mvDlGCBXJmCMAgWra8rBTIzjqo0LoP1ksE3F+zQ+yENby0
         9RRWjt1GNiN75lTB9KzD02+QcZd+VLQuCvE07AqDTQ4hDEHJvSh7EdhTTVe5CntTzGr9
         1O2nNxgyl7tIbOs2apUA5kAnXP4zQ+fjVuZ0hGV390DsI68S4Hb4tBBI6+aubjWCbX4r
         /Ya49bAmIsmVCnF7m7lRnb28CASHu/+YsRwWmLOXgvnFbDAPFFfivARCm+1rC0QADjFM
         XUYL+yzQqCjc3+IFutO4nRAPsYflT/wXlP+DDJBwpQ5Oy7lHQA1kR9T9y1CGTqo//agf
         s3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUHo6HzzMl7nZxeeqHxTaz8PmGyfxGVP+z3ljNgiKPdU8tHw8BH0kkgUGYCp3NDtzK8saRtHBP5zIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoaaxyYmukgl9wHORXg4GcDvDChijMJZtCFWZjkTmGxIZK1N1i
	jvnBhHC93EQV+RD+ObSX9HreN74B2GZRxARXFEps9TH0wwgmGP8fEKx4
X-Gm-Gg: AZuq6aJnCR+wguFKOUoIKzRqvCNofoV8nV/3ZyeAKZJLicqTsbxsdpMCitUkbTxsXpA
	XkgrzRCW15by0s59c9PaOOjhuiASOUsnCwpIqWQFDyHx5+S2aWbbOTrMUN3nDx82TZ6wXRmGmfR
	xH3EO8EYI8+QeHcWpC7hcNSM3582REqOAoC24QHN0YviEhPJXg/UBiPCSEAbg55Tf+AXOX3V5G8
	xxNmoUfiBYWgPdNHLaOm/WmyUqt6e6gr97wYi54sPPM98sVrg4/BFJv8KJGdt0wVXjpMBq35yB/
	lA4Z42Y1Atqhyh/DO7l9pM1xXxy70P6kHdQ4h+xlsGam7odORCaS9Eriy549sqO4yG+k9vXoMQ6
	mc2B70V6teG4htbcBwm1f8OyZFfyDT6oxGtQqqgyt7ilrCS/ajlsZqroH5ermSFRnkPIt8yQ+nh
	Tw5Ukh4aUCAKhOVltwQWza3YZyebElk2WSsGvFH3D6EFj8tu2d
X-Received: by 2002:a2e:be08:0:b0:385:d0b6:6c44 with SMTP id 38308e7fff4ca-385fa0f5429mr12559791fa.18.1769424790834;
        Mon, 26 Jan 2026 02:53:10 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385da170f70sm23745981fa.27.2026.01.26.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:53:09 -0800 (PST)
Date: Mon, 26 Jan 2026 11:53:07 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Kent Gustavsson <kent@minoris.se>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Message-ID: <aXdHk6qvotpHkILx@gmail.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S2Ed6By+aLORiQHU"
Content-Disposition: inline
In-Reply-To: <20260123113708.416727-19-bigeasy@linutronix.de>


--S2Ed6By+aLORiQHU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 12:37:04PM +0100, Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
>=20
> The intention here was probably not allowing forced-threading for
> handlers such as iio_trigger_generic_data_rdy_poll() will intends to
> invoke hard-interrupt handlers.
>=20
> Replace IRQF_ONESHOT with IRQF_NO_THREAD.
>=20
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Puranjay Mohan <puranjay@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=E1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
> Cc: Kent Gustavsson <kent@minoris.se>
> Cc: Gustavo Silva <gustavograzs@gmail.com>
> Cc: Nishant Malpani <nish.malpani25@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

[...]

>  drivers/iio/adc/mcp3911.c              |  2 +-
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Best regards,
Marcus Folkesson


--S2Ed6By+aLORiQHU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAml3R4wACgkQiIBOb1ld
UjImrg//VoTe74He2xr9a7a4xXooL9varAfZBITrKKUbEhWNiXZYsrKwKYIFgayM
oiz76OxUT5o9+SL4XCXq+yTXfr+7bwd67uPCrUoZAiSAeNtrfbw3fvftierrKuqI
DZm7pXQ4pnsaUKqX+X+KpQ2YJsFM4CfaO3ueAG5wA+vSbiRHnp3gF45JTbo+Ic2K
A4nqV39QMG6tzUXy0Pe2SYoXkRU7nS7u7OUjrQj/YCICXL9jaTdPpbeYtBVZic45
8lu68gFEYN0f5SOPGgNXc0As+qfbbpghpwMSlJyv8zATlKYtj5qgrDHskKxuk3R1
kqTF5iZEUOir50yR/KCLMnO+fXjhMdiDrWnUMAmPhYuWVAOB8n5xSO0s/khVzpBH
rf8/ekFo5afL5bqwSQo3xK+ROk5SpgdLo/a0NIfLCMSdFna2PjIUsE5LOEZzleLG
zlezgO9dVZOCHYzZJ6nNw/ELI3s5h9Wr/WAcMFnGPkOttC+oKcL1RIlHITYRr/U9
3oFgssVbPffoyvQ3fKZ0xD7ur38AUJRGE1SctWW63MXd4rYxkt2PBpqRj9dOo/zx
LEiotKRG/skz9Dx+m83SLuJUugRCz9IU80x1WIgKLv5HMRzWOCNRmpxbZEwFpkWL
SRnZvXdjh1XMvuogBQ/DBIexesCxYIgD1wT1eOK84xzuFw0zyww=
=/+VT
-----END PGP SIGNATURE-----

--S2Ed6By+aLORiQHU--
