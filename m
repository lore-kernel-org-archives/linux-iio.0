Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4728934F
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769929314; cv=pass; b=NIGdu1WWTYaFy0aQ3u0CI18mhuMAzMPCtNCjnCK4u1BlHPFRGa2j7VoPfPPkhvnQ/3sfjbzoUPrNWkNduC35mnLxmk3oquhq/1EknT/JcPJdEkql/yEoWy1N9wc+TWrTxxMjBxq735JEneNgaqP7kAYsS5J4/N5dzp01pgaUoLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769929314; c=relaxed/simple;
	bh=bHSVbRQDobR7C2o5P+eolgEypYFQdOgjv1IYhW+8fGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5ZJQVon+Hr5KHmgqmlEqyN5SxAcDyKhIjc/SF21RQ3BEhjAJPQWvZqvD2H5S7sYTLUMR+QUHl6KdG+v2o125VYGRrRCYNiOyDkmau7h1AHxgxmSv2xHpaAjZrd76l+eRXJKokA/YsR0P/LG2kcKwqxKncDyZJVCK2PdWr7s0M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBKejBmS; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBKejBmS"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-658cc45847cso5205707a12.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 23:01:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769929311; cv=none;
        d=google.com; s=arc-20240605;
        b=j5z6eQuKwF+orq8qATDAsGzUWaMDITwZxlrRUguFyOeFmoitm0HlvDriVME+gJiUP1
         babyVQnmEmfhlFiOAiiNFRkQcC4dROwKym9qk8SGBtMKRdfbycvHhtqPrgV+z74NVW3s
         JmDRSDNfsu//Sr98WG098ifZxwFNtr02skzfX45fQlrqryoVschrUkMofknnGtjFRYek
         via0WVaPEk9BY4sDnRfBDF1quXnwze+z5B1if1WvU5VSJgBoCJlk1WW2XKn0Nk6jtbei
         RDdql5KDvY6Ubpstb4JSij8Je/67DVwWaYV197luzgSEj2bdZpwlM8hULBOxtHc3s7nF
         AY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iAWzb9BbFNy/4m/w6Zwd+njIpZ8M14O9H5IZPS16EzA=;
        fh=rNxM2TxbpV0lJ+m429oMZVVIDKc/qycZcaFboL9hB+w=;
        b=hv/eGHPFXc581wfJrsyoqBjmmfv0GHi2ywcjpRJpWQ2Oe34jrvYYvULnCkUx37F+Dg
         OU1PMOYUcC9W73Y1IcTGcen5DhhpS2X/4dZEnc5oRDSjWfj5Po1LNEJsf/zvaqNtlAyE
         6ycKmsTqvIdhEj6UDerjPiNyIqVPMjnKm08wv/BCvI/F0EHOTrHK/GKmbJhwfNp9537E
         e1YHGI7yn0/pig5smD/qo3yUCIVohMyIfTepiWvZFoTTPnOOZwW0TYMFOmfIj+C4+cg7
         0yv2cSu/Pum2ao24B/owOo0Xo22LyjKkyekFnlmlLQdbSNhbeqxNX8mWYaR80FGw6NhY
         6w4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769929311; x=1770534111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAWzb9BbFNy/4m/w6Zwd+njIpZ8M14O9H5IZPS16EzA=;
        b=JBKejBmS4EnrDrrSgo2TZcaWiwNko6dejhSRpqB3coSugLXxkgr19crETgfRrA4ZSE
         oBeD6xlYTYLcRVe2j8yQARiozYUaqztOdjRsLRnjw6x9GbRq/pcR8txFh+Rq9MsR7Bvq
         euACVxPmpd4Isp2GhT0aYyLA09r5034g7/jP4q7uEbA7mFfHOA8o7JzdvcKNESIbixqx
         Fhbqy4+MS2BPYXyhurlRpX1od+D8JrHooCPqHJphyqFoq4ML6c8cbhCeMY5Bqk99Mayv
         PgrnLN9InlhN6UYWN7gwPNxX1hX7WZ99HRl74jlgql3p0F0F9SZfHUTQo8XsqafLeuRN
         F0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769929311; x=1770534111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iAWzb9BbFNy/4m/w6Zwd+njIpZ8M14O9H5IZPS16EzA=;
        b=DpeBoOt6afNwJDAq+8VAqqRDdcCLmp4AG62uS7f0P3Ai/ypfQI4LXiTz58JHgiuh19
         KGjQrWfqmrVdO2ae873ag1sUQfjQSeqN7VTM8WB/7RBMZztbSAfxDtZ5yRjru+bFQDff
         C0WPSmZdZ2cOxWi6FJVZPyfOY4ZkeWIw7NjSnfPedjLk0pR3nYxozTpACq86/T5f3OZs
         R1szSC6vq0itYOqn4oo+k2dPvbEHxhQr3w3OppKvCEW6ASec9qBfLofgPUW9HSgm+izo
         5THPyAHJnZRV51ew0Md0+F7eyYejg1LHhL1krti0ePiy/Kkg2qgQffgKIqrO+2mSi/W9
         IlFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCnD9BZ+XVvZ8zf5jmzXziI+FdMFdFgP0qwIirizhDq8f7gVUQ7reEqiJ3Ft9mLH73p9sCIQhOb60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl1kVjbzt8LcK43sXTelsYtSwMZz3U1nxRWeZJg6W5b7KaN957
	U511W9wi2jAuDrIdkJ8P0v1HXP51xE6klv6Z1I/Qq7tMICJ+RvS95C5NY62GM9Yuvp3FPx6npvY
	v37NtzYkt/7BDTtcW/mvgvmMhFKjirs8=
X-Gm-Gg: AZuq6aKqtjSUkS86zVXWIgsznwkxVl+Kcy9N9ZSOfrPCtSfyF90CbRxVJtHHY1/G6B4
	9F5jk0SphrvfSYKvA7qQJ/9TDYZXE5NKypkEmuR+Y1h77A+CE9qZ0oBgYu/avwc12cfQMA/zX9n
	Qe7BZnkc/uBu+uIiPRdvy6mVBwFXvTnkty1j/jH5x9sb+cOlMkcMUWo7YidimugZ0eB1jhR1+D8
	w9Us+10PRhBRLEOzivxmx+bGnCKcxfPN/3ml47vX18F23xBofgtE22wiw7FmuNDvcNcDYZj
X-Received: by 2002:a17:907:94d0:b0:b87:1839:2601 with SMTP id
 a640c23a62f3a-b8dff6969b7mr517593266b.40.1769929310797; Sat, 31 Jan 2026
 23:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-2-clamor95@gmail.com>
 <d7938728-fded-4d5e-b23d-a8346e3fab46@baylibre.com> <8cedbb9c-9f72-43ae-a23e-705b3feb85fb@baylibre.com>
In-Reply-To: <8cedbb9c-9f72-43ae-a23e-705b3feb85fb@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Feb 2026 09:01:38 +0200
X-Gm-Features: AZwV_QizrzJwmFJ9K3HDRK05t0a_0kaNB1Vjer8WbyjV6HsHfDqBvgFrLolg9pY
Message-ID: <CAPVz0n1uv=2Hhue2zjnXdG=_PyofBBqEhdU+S84+ysYq2PV+qg@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] dt-bindings: regulator: cpcap-regulator: convert
 to schema
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dixit Parmar <dixitparmar19@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 31 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 21:55 Davi=
d Lechner <dlechner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 1/31/26 1:46 PM, David Lechner wrote:
> > On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> >> Convert devicetree bindings for the Motorola CPCAP MFD regulator subno=
de
> >> from TXT to YAML format. Main functionality preserved and added compat=
ible
> >> for CPCAP regulator set found in the Mot board.
> >>
>
> ...
>
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - motorola,cpcap-regulator
> >> +      - motorola,mapphone-cpcap-regulator
> >> +      - motorola,mot-cpcap-regulator
>
> This is what caused me to get confused on the order of the later patches.
>
> motorola,mot-cpcap-regulator is a new compatible, so would be better as
> a separate patch.
>

Rob already cleared this up
