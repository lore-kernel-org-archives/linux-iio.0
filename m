Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483AE1A0BD0
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296990; cv=pass; b=WfZ6fRehIbESkfBSGipAbKh+beoYEJt5t7DtbDeBJoV4YmmmSz8qT6vT0MAVnuugIXQfr4in1DdphjhiGIFh5zvo0pc8oRTcTNj5cB0gIfbevP7wd5NzdlX5Lguzk+B4A9QMfWtPm98Q0ANePKSNnbx9WdxWk5iPCqAEi4turAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296990; c=relaxed/simple;
	bh=8Ab12z/D7dD3qz3v4bjUPqVyBL8xw+pAf2xD+edhf6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihbo2K0kxxY0bfrDNoLF/Cp+yUi0rVXjpwBrMh38brig2Ksc7aJKQ7XJEsZ+i/QfQxYrNiezOG3fqAvhma9AmgOOj5lCXCb1iVNi6TldQMyTNUIuHnZ258048oIvw0DRTE79QQZv9XYZbFVJ49mw+cZH5sGr60O0qXnoEhsCS/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJ1Vwmsm; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ1Vwmsm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a7a9f81bso6849005e9.1
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 23:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780296988; cv=none;
        d=google.com; s=arc-20240605;
        b=OC5yqihYXCdnva1gupPjm3JOww8nIitYEEysjgGVJfd7nL9Cp9L3VX4EQB4hfbjTG4
         k3wURXvf4JOsWhujT3hbi50OdvPMod32kjdJ92LtZJAWpzqcZ+U1ZT/NZKgv6dyZPu9W
         S0J43D0etg8SZlxezqeKqTLL9epkg02GEDwsvWV1M+nakLaKhWV7oDyDANE7qH5TdVl0
         A9ev69P9e4/srqdO3prucadT7zDQDUbuJeEHfNn4+18gNRUD8TstvYBzW6UwfBiKN8n5
         zLKJuBg11pS4zp4gEPLbydC0e8ogfBVMg4PQbZMKjJZKUqrXCX4wXurPnCs0DxmrP6Vl
         FL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=43qpCIHXvg02vOIiV3SVHpTCHSKFpgZfLjuxybaTwdQ=;
        fh=bT33wTVkg10kTEL0iMe8D8rmVwfxmOjsFp4JlAHoubw=;
        b=CR3ia0vLtWQMGIV836r3Q12zx76LrP7l7rgAhZZukI0ocUFoCIIgEW6Y4WzVRcsyVy
         FWIZ91W2CPumNmc7rF4n5qjCloGH60gLtkHMB8FZsvVEj14YLznK9f7q8dA7FjQRkCkv
         +B/QD0vdGHQO/rZxdzUOIo/vwSHYZi9y4zeclyXJbXSu1PVC9QbWYZF8iJQYFCjTN/Lx
         JM3BJ8tbzjm7dlGkst85bzI5emUjLyea9nlzpM+iE6m/FXh3gi1/DtDol8KC7FXJM/Gg
         bhBvS+fNU7s6LYIrPYyRXQy5y9K4Rm545uEYSNTG99UQvNYUW1aSPmgZ+lAeLKngP0EG
         gfxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780296988; x=1780901788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=43qpCIHXvg02vOIiV3SVHpTCHSKFpgZfLjuxybaTwdQ=;
        b=GJ1VwmsmBRqTTJpf4q1iXzPIE1ZZucmv1bdYjFa03uqbO0xOouzp3bBwIayB5aMjlj
         sSJ5g3ef9jdPBYCmpzCA5GgUye3xFqQiELhXmxf5NYJ8+/drMoMsqbX3xCaVOAoELdKN
         NTCcuLEv96/EzP8jnZ1h5nE6VNqC+GkhRb0tH/hJzqreiXFXBwCxgRWdn4sHsFGEZztA
         ARK6KZ1JRbgRcxd5yB8b7Oejbr3TDQB/dzlLQ9ISmZEEMkbAyFnjB0T+iuN881W0QItV
         LfvkXLLpFrb3NB7sr+H1svPkZTSVww7RI60T/2/HIujn96WAHiU9tl7RxLrf+jgtt8dn
         ndtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296988; x=1780901788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43qpCIHXvg02vOIiV3SVHpTCHSKFpgZfLjuxybaTwdQ=;
        b=PUdApWyu6MUyTpdjiGdUw4Lz0AEEPzJKTplL6ICuOIgIa3ghBFsco78PUB7a9Yju+E
         R3EUeKoasvxrxhU8NfhNKG/pqj6qUtuA4m+Sac1Pg+/JPg2nFcZSyf3XHUM3yyku23EP
         d1K5QKmrSCBE77/4AVY+IUTauCPakbfdE4EBwaBvKvPwaGW+ZJTT0o/VHdRX9/W8eSfE
         niQtX9PQsQ5rz+v1ZHB1fQMvro8cwRU7OafxwSQtfr6cUaIE7qUZUhMuhE47ZCs7G9Wz
         dnWU4UVZ1Hq0juALuBUgU4m3yejE+/SSW4x3ayq1sqsm6hAPrb8ZMvSHWAIpqxrfIv/l
         xfdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7/VH3BRpH6UBCrpCPjR2WQbXBB7PLRN4tq19Pox8mcDwUCMaC4njNcZaLy71ho8W12Xw7GjhMjL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqF2NIsTlJ0LeNFhy711wFVx5uhHR8jVeIzn0wES87eLtbm8Pw
	UMmmWy/3wFtSBERHQ5D2VijmXHwIlDa678aFbWQ+oZ/Ky1dUJc72ZfkFu3wzV8qLA4ScDqjXJkR
	bcKQI1IdwNJhTLpLYlK5OeW1JW/6T6q0=
X-Gm-Gg: Acq92OHi7UQOVkiYTl/BqgWILCm4L460jXJEBPvtSn/W6npn63EafKa0Aq2DVe95Rcw
	zhKOwrK9kh/YlzZdFJ6CoPBAspokBvKElHV701HbJUJSoAmV9AlzUK1X7hIdSWun20DhYYqdUmb
	xJTOb6Rc91Y+aUcKYw3fGSFWi6rvNkHRHKLchXOfGiB6sWLze9nQttQGAXZDSfHjkSQeeQ1bsWa
	oRoehN7yJEsL9IhmQf0tEgyS1k2CxdtwViuFjMrGe5LVZlJ/LLF4VQA7Yvy2vDsme0apctFYds1
	5AvaUDVb4wdksQkP9dj08IoxzDhC557w9YkInkMEKNfGTQ0uFH4MQmni7FippApU1qUIZh6hAKJ
	BJ8AJIwyB1Ag2Mvg+lsfVrdo7Cz3Mjkxj7OAtFlmCXtq2LKlm6mzoveKiz5QldsuDIBA64mMKuU
	jEUz8BcGmT5I0CkTtw
X-Received: by 2002:a05:600d:6414:20b0:488:a502:8955 with SMTP id
 5b1f17b1804b1-4909c116917mr137259915e9.4.1780296987555; Sun, 31 May 2026
 23:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-veml3328-v4-0-f9b65d71d917@gmail.com>
 <20260531-veml3328-v4-2-f9b65d71d917@gmail.com> <DIX3Y0PCFW9J.14RSKP23REFBO@gmail.com>
In-Reply-To: <DIX3Y0PCFW9J.14RSKP23REFBO@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 1 Jun 2026 08:56:17 +0200
X-Gm-Features: AVHnY4LTHat7tTE5D1RjIqkHLfa1fzh4fC6JsS4mAl-GXhLn9Voa-V5QUOjJkfU
Message-ID: <CALoEA-wtEVO0+GaabshH03FLGBJu0JkyQi_FjSETzcAySAKERQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: light: veml3328: add support for new device
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 31 May 2026 at 21:26, Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> Hi Joshua,
>
> Just a nitpick I caught on the fly because it was missing in a driver I
> recently sent as well.
>
> At least linux/mod_devicetable.h is missing to include of_device_id.
> Probably that's the only missing header, and it could be added without
> sending a new version, but that is not for me to decide :)

Hi Javier,

Good catch, I completely forgot about mod_devicetable!

Thanks!

-- 
Kind regards

CJD
