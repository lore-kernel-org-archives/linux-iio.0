Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3E50128D
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745170; cv=none; b=I6oKyjxi0bf1BoRunLbYJQhMBTxSrMoO0+7lHEDFmfQh0k7KW8kjicZpCm2f6K6Nggs3lylEGLwTmyq6eiVoHknQb0bXdVF0o2MFmV5RlT1pCsIfqtAaQm0s1UPgaCMwLpcJ2y/ec/5+bK/EztEcvTi5Nqu1QBMSmFws8AEgt0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745170; c=relaxed/simple;
	bh=S4BbbDlFMvSPl2ab6YtXb/KsV0JNn8z1b6pr9Asc0Ds=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JhnxYPWmQskkLSYLCmSTQH44nkz+QFuXE3v4XchGiHPuvHWtRxvwu4qOEiXqN5gTO7aad4j0VKOMw5EvrjJYCvxog0v/ilS+gia12HnAQUBgyW10nT2efplF1msOiwynrBoWwby9QBJiZc5XlCUdprMZ95bTpCnEqj2bJDOGzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=srIiNcV1; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srIiNcV1"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2953a01240so138097766b.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789745166; x=1790349966; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S4BbbDlFMvSPl2ab6YtXb/KsV0JNn8z1b6pr9Asc0Ds=;
        b=srIiNcV1+31jY3wY5Zs5IYPLeYz9lw0Ixf6yqZAcU9auUHyoYPk44X+k+GgwoMw1eg
         KFHwAdkBYIbhjwTAnejc/qh0YmrOgBXIzJc9/0h2jo9OCStsX49YsYPfzstwawsr0l0L
         jJ/th+JYr6zLIWgymC+2fkJdbMtsVqkNHLgD6GalEYkZcWeZAFI8v7bGm10fycOTUwhX
         L7lSqs2QI7oJprUuQfgM5Z+aGdcsGlB9fWCrvQ/Qsco/dZi4tZCwQlxvYYCJ3tZ+2lsc
         WpTWMF/7u55nBfg8RP1jWklCf8G9J2rmM3BtfVMPpbpiyCPLQIbXzqb65WD/q6PSSUa1
         B1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745166; x=1790349966;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S4BbbDlFMvSPl2ab6YtXb/KsV0JNn8z1b6pr9Asc0Ds=;
        b=xNQzS69lS/16JDO5d9WVGxjxkTat64MaQwreZn+mGL4xPY91GP3Ik0Au6gzDJEqxsW
         YwofUeOAq4/UJCS0m6z7m5VpqR6apk1NTVooQng6ncy9bfjG7QxPNLgkymMwDdZ8PyRb
         Qb50OloLfFB0FOB3hjXByBJPoHpKRg3mAlgvSTBZogkhpdvUTImaZBZKQ5oEqFS1YwGV
         XLsvs14IQyz6AhDSZ+DHo6+eCpykUIStOLdEF9VKcctdonzBT2YJPxGfZJWjnSp4+SSk
         iGPfYR7xZcTGU7POWMRXnTjvElHEBrY/0ntL+ajrx0ZNHmBTa9VR4UlRYbvBUH/2kEXZ
         o80Q==
X-Forwarded-Encrypted: i=1; AKwUvByVfreUGQMEsVEdLF+kCY3mbnNss6bsxXWhy36kDc/PtEtXH8irHzV5iKzOzACLYAP3u4YhyfhzG6E=@vger.kernel.org
X-Gm-Message-State: AFuF++mWYVw4Kf5h0Ygo9HbOpoB5tuOAITRSpciQ0aesjUtbiWuxTfm2
	zmNtlm4uJr8wgQsdJcO+iN/271tpFP1yXA7HIPQT1Rsoxtt3FVWSg5L0
X-Gm-Gg: AYBFou3q7mde1VxMTCohYrKAoDfdX82aU1qXW7dWQRmsgaOeEWhsqHsaEJGIcK0A2Nm
	IOzzVrlLc6DuuA3MYG4h0DieCjQY7pZ08byQggPfBCC3ypVpoVoxwAjDjwyUHr+eF/e/ZS9aLgH
	dF+K4kC1bpaFhm4CuU/4iv6L2Oxb5fz7rR0TfN7yQqfUN6e48cIDO028AkH4Ry6P29X5JQ/HyS9
	hx1vR5Y91yqpEmrtuVtGqty9zVu3KIMXOUvsWymcdJZ6dwlRGEZxFQUB0/6iIknid4PMFqUgdpC
	+8T1TVdHBwinPOB9Xxfp/uoxR3e85tph7IvGL95YadMl4NZCl/1THacSENQvvnPH01zwtrTWUe4
	JjFwG8QGN9scqlnTOoPey7h0hytgZRX0GITN3Ze4ji1sg7sxQVbRn9rT7cpXOyiwA4DF1K/9vSS
	Jw12ulR2EYy2HcbILeoRsr8CrdB22N/HDWZm3xpx87d9oLESDPwihFJQ+Mfhwf9S6QhUlAtNWhS
	Aqb6brJCVdRzWTMcNxuqb9jgAP5iB9uKJPo6mzIKhdrlmvOzm94e/cA9jy5rTDX8IBBTAg4ezLj
	BoqWiA==
X-Received: by 2002:a05:6402:a0d7:b0:69c:6547:518b with SMTP id 4fb4d7f45d1cf-6aa577f4a28mr1746463a12.12.1789745165596;
        Fri, 18 Sep 2026 08:26:05 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67c6d71fsm35507a12.2.2026.09.18.08.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:26:05 -0700 (PDT)
Message-ID: <9fc012985151b1b79b5d6e3f16738397ac9f837f.camel@gmail.com>
Subject: Re: [PATCH v2 0/6] iio: adc: ade9000: add ADE9430 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan	 <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Joshua Crofts <joshua.crofts1@gmail.com>,
 Radu Sabau	 <radu.sabau@analog.com>, Salih Erim <salih.erim@amd.com>,
 Jishnu Prakash	 <jishnu.prakash@oss.qualcomm.com>, Jakub Szczudlo
 <jakubszczudlo40@gmail.com>, 	linux-iio@vger.kernel.org, linux@analog.com,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Date: Fri, 18 Sep 2026 16:27:30 +0100
In-Reply-To: <20260918073537.1572-1-antoniu.miclaus@analog.com>
References: <20260918073537.1572-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-18 at 10:35 +0300, Antoniu Miclaus wrote:
> The ADE9430 is a polyphase energy metering device from the same family as
> the ADE9000. It is register-compatible with the ADE9000 but omits the
> on-chip dip/swell detection and has no on-chip digital integrator; it
> relies on an external analog integrator for Rogowski coil current sensors=
.
>=20
> This series adds ADE9430 support to the existing ade9000 driver, reusing
> the dip/swell-less channel table introduced for the ADE9078 and adding a
> matching chip_info for the ADE9430 full-scale codes. A precursor patch
> gates the DICOEFF register write behind a has_digital_integrator chip_inf=
o
> flag so it is skipped on parts without an on-chip digital integrator.
>=20
> Patches 1 and 2 are standalone fixes carried with this series. Patch 1
> corrects the ADE9000 full-scale RMS/PCF codes to the same family-A values
> the ADE9430 uses. Patch 2 fixes the DIPC event never being handled or
> cleared, found by the sashiko review of v1. Both carry Fixes: tags and ca=
n
> be applied independently of the rest of the series.
>=20
> Changes in v2:
> - new patch: fix the DIPC event never being handled or cleared, found by
> =C2=A0 the sashiko review of v1 (patch 2).
> - new precursor patch: gate the DICOEFF write behind a has_digital_integr=
ator
> =C2=A0 chip_info flag, split out of the ADE9430 support patch.
> - reuse ade9078_channels for the ADE9430 instead of adding a duplicate
> =C2=A0 channel table.
> - reword the documentation intro to "The supported parts are..." so it do=
es
> =C2=A0 not need updating for each new part.
>=20
> v1:
> https://lore.kernel.org/linux-iio/20260907101623.8730-1-antoniu.miclaus@a=
nalog.com/
>=20
> Antoniu Miclaus (6):
> =C2=A0 iio: adc: ade9000: fix ADE9000 full-scale RMS and PCF codes
> =C2=A0 iio: adc: ade9000: fix DIPC event never being handled or cleared
> =C2=A0 dt-bindings: iio: adc: adi,ade9000: add adi,ade9430 compatible
> =C2=A0 iio: adc: ade9000: gate the DICOEFF write behind a chip_info flag
> =C2=A0 iio: adc: ade9000: add support for ADE9430
> =C2=A0 docs: iio: ade9000: document ADE9430 support
>=20
> =C2=A0.../bindings/iio/adc/adi,ade9000.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 22 ++++++-----
> =C2=A0Documentation/iio/ade9000.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 36 +++++++++=
--------
> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/iio/adc/ade9000.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 39 ++++++++++++++++---
> =C2=A04 files changed, 67 insertions(+), 31 deletions(-)
>=20
>=20
> base-commit: edb91bc566576f6664a3efbad6bd4205aa1d5259

LGTM

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
