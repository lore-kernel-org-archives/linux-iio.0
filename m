Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551230;
	b=0wLHDtnbIiLSSk3uzmO2tOdZNdoV90KdhDYPLAq9TyEUctdbq9uD1YvGf42QfRtK4Kbu
	 6H+fDI3izvUEA8WBXf/W14XSNzPz6UqSg3s73UIrQbsAZwTXzfcTUB6KbC2EyjjNptoM9
	 OgNG8QpUqdH8nnwajNxlrOj6IwK/iixd0tXqRariBZs1ReZiWBtuUt+2vshCabeNcwL00
	 wdrMDtPBLSlvYmNpRZrnErmZK5oXZxdfxrLssJtdBNwhdmU955F86AxSPMrUJfgHk3cMQ
	 CKyzy10L02C7QlTsJhf+0NtCkt3JU4b3nrWXUuyCTBAxqfLWj+EibyK81c6B4MKyMeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XltNWiKtwG9iBw8+GH1SYk3VMgJFEJVDDOL9ejVnQFk=;
	b=QaE/E6MHpGB+05arCKjQLhsDJdYjZRHpUFFkSTAcGviUNMicY9+N0uwSyHforwRuib2Z
	 d0LH0+S7YEiyHLcIp/s6frv7ipcACQqg402Ix0TbuedyeI2V16iFBnzQdFgDGtB6tUi/K
	 ekoFSnvCT+C9wKYUTw94Kh2/528WL9DOoqbeYk5THT+TOn1CVJrWlfnCTl0PfjY/eamz4
	 X25qHOaybWBVNd0hUUS7uiWTy0oyVd65G1s5ZfE1WYBmG4TzVRGEei0tSMb+M/FgtiONQ
	 xb6IDAoAaiRnPoXvAuhH312KxZHX++M4OOMa8cAQx0V5oS/x3zBdYM7PAadX2E7YbPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MUvxZhYm;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0BE606A323
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 06:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C0BE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MUvxZhYm
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so3681905e9.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 22:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794551229; x=1795156029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XltNWiKtwG9iBw8+GH1SYk3VMgJFEJVDDOL9ejVnQFk=;
        b=MUvxZhYm5+xi+SJfP8nHhsZ1GXHZRgKcmtYpFlDoXTjjRpAAhHrxK/sL0p5zR3UDxZ
         zoFe6J+qpK86Rz4t3v2DUKvCLnSK0WziR5goLmM6ybJ96s52a7n4l6ssjhqsUYaR+Jm/
         Xs9hOLXj9PE+uwryRlkvLuERCrqJTf3zLvvS2FCslyTZTd9wswIAMULtnwF8vJn7f2H0
         3wTzjD8Hp6/wsmtQJ0eNgdgUe4JwuhUhUM8UnvqdKeyZwp2YYRSg+jZBqsj6tEhsE3zD
         Pz/u5C9YRb5rfcke4Gy7OJXnRI/iCfjiVWknhEe2HE/M51peV4kwHUDOt1TkMoov2shs
         xFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551229; x=1795156029;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XltNWiKtwG9iBw8+GH1SYk3VMgJFEJVDDOL9ejVnQFk=;
        b=zl4BB/mXCSMfds/tvG+DMUc3sTXAyMpmV3B9+z0QF5j2+JB65k9Fc7JICab/BYyoJ8
         F8vtwmnatRWZOY8yrsFrYeFDLr/oGnp6jiOOIptohSNSFOQTHhJ/rIbJ0qbxxm3J3IDg
         BeavmvNCPqlt+i+JGPteD6Jm2qRikuDYZaSy9xJlBuzqDgdZ/gvb4KSBbKW/glsESOGP
         TNSEu++jjRsINHNZJWBLTcDVV9AS0vscTlz7ksuhYJHQND5kR+ebWHnpYeqQnrzYG3GQ
         z2AWgS9U19Sq+EQeaa6KgLU4YxAPOAZfoJPizNm4upps0WLMWODhpF3bMPTZ3sa6RiO+
         mZow==
X-Forwarded-Encrypted: i=1; AL+hErFXwADEASdLEwe7JNPEK1WSEo/8zseRETC88H8m2cSNkGw5j8oWC/aCt8VWfnbXxA7+Wx7J1FRhba4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8eZ51Vppyf1hRv/mXmSbPHXSv0eFwzrYEODJecuiZ2EJscLGit
	yTJK21LpwsD5K3IQ5rDU5yHb2HtZmn8socixRodjKHvE1qy6i8qojiW7T23AoCGTEI8=
X-Gm-Gg: AYBFou0WQw+8LJ9uR3HA75WWEVbRPN7SX1CrPBLKnZRxk469U/ie1vOl104PYo1gh8y
	S26piNnWz3xOHoIJWu1bOSBacFLoKmdRRLUefxbDcNX1K+PdHEk+66UNHCUqjZcRmtAZUufBT4l
	91SsiH/+XrQ0l3+YcqAe43f7STwm44W6lpuAdD0ZbeYMLSt9p6cubUi9B+zkIgcEqQRY+Ng8keh
	AbQV+Tg2vWd/MIpAhEgyOkPSgtzyRyJdODqfftt358dIAkLcVcNuCjxJA0auyGadhl46fjfe2OP
	6wzyie4nXJP6LFkg1sOZ7lMREgIwR1OVkdzJ9Mq5nVOqwRCmCmVknfZhu9JL3m8wPlpFZHbHa8u
	SAXt0bupV8GzPn5Wj6hNfIP7Bx650c9TvBNKsVv7OungRFk5h4S/YnRSOb3g24R1VNiFhHyHCRG
	9nHZrpHSRYjv7Ab2YeGeFyCKhT8gdDPltcYFnreZuEGTXJaMO6J8tV/QRZbUvPd80SQ1xwyjTmb
	p2z2H2bvytIb2gC3davIz67a+JBvv+7RuIUAvYKXIPNoZ9ZAqtW/VQOp8KkPoDGJwai2+NMUlft
	r88FBA5tIP2Joj7o7I2OlY9W0OzdWta9HqADujPYZPcn38IelmZpMJg8M5y2zBVXL7eZLoiHVg=
	=
X-Received: by 2002:a05:600c:4ecd:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4bb5599a73fmr36037725e9.0.1794551228841;
        Thu, 12 Nov 2026 22:27:08 -0800 (PST)
Received: from localhost (ip-091-089-005-024.um28.pools.vodafone-ip.de. [91.89.5.24])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb4e29daa5sm133039875e9.12.2026.11.12.22.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:27:07 -0800 (PST)
Date: Fri, 13 Nov 2026 07:27:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Val Packett <val@packett.cool>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Marc Lainez <marc.lainez@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>, 
	=?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, phone-devel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] power: supply: add Qualcomm QGauge (qcom_qg) fuel
 gauge driver
Message-ID: <avatRCrAgoPjV7rP@monoceros>
References: <20261112170841.2189322-1-val@packett.cool>
 <20261112170841.2189322-3-val@packett.cool>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwyna4jkd5v6s5iv"
Content-Disposition: inline
In-Reply-To: <20261112170841.2189322-3-val@packett.cool>


--mwyna4jkd5v6s5iv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/5] power: supply: add Qualcomm QGauge (qcom_qg) fuel
 gauge driver
MIME-Version: 1.0

On Thu, Nov 12, 2026 at 02:07:28PM -0300, Val Packett wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please don't include <linux/mod_devicetable.h>. That introduces a bunch
of unneeded build dependencies and of_device_id is already provided
(without these dependencies) by <linux/platform_device.h>.

> [...]
> +static const struct of_device_id qcom_qg_of_match[] = {
> +	{ .compatible = "qcom,pm6150-qg" },
> +	{ .compatible = "qcom,pmi632-qg" },
> +	{}

Please make this { } (i.e add a space) to match the most common style.

> +};
> +MODULE_DEVICE_TABLE(of, qcom_qg_of_match);

Best regards
Uwe

--mwyna4jkd5v6s5iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr2rbYACgkQj4D7WH0S
/k7nbgf/b6/rA4kIW1NyMoOtnNVBeGIHHHNfMkct33HHb1h0CiT6Hd1RLEJ6HH+F
sW4pjg7G0QStID55MbOeFsfsHKUaOEsaLwutZ3fATturnz7k7RZRvLfAjNtR3k18
hiWFbFdsTjH6SuQ/g7OijXpDO+E2v/5FHg8g/V0U5xwL0w4sWAME2Gxrc9Aed+1Z
yb1H38UcmdaYkNs0WgAyYt2rGVtGDyt5nQqLm9gBfrCvoxDzCIxgiXJ61C9JMF0t
UIk/sLbujBcPF2qrtmodX0CUE07kBKD7PV1TOWjB7Gcz+f3E/X3eQGPNNOk8mEQn
pqgA7hr5DNGO6zRenFbDHgtssAhenA==
=HgBt
-----END PGP SIGNATURE-----

--mwyna4jkd5v6s5iv--
