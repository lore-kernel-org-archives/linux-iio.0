Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50916EB42
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771097125; cv=none; b=LbpUerB6UFEmekDY7oehK4LvfT8UERRy8XdZeI5g7qNpmH392bBX/1MfAphC905U2Gdy7/wLaGpoKjsKxjYLfrC06X7DuMiTM5BvhAqpBjCIE4/YI2+NjiC14EtGaZmHg0cfDKCGGYThwVq8mhnqHhXxXMRD3AKrtMZa9GwQZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771097125; c=relaxed/simple;
	bh=sjBmtYgoNm2L/egRL+9KTyUHzNMn9Pvq3RGushi4848=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DQa6Wo1z3YQDFOss1PVAGANZZSUfY28m+WoRLKHPCLQpQylku7qVOQhWRHYUYkX0mfn69lzlIcqmBK66ABCmnP9odcCJWWvjA1YpjPBcLfD487mn7y9xYuUkbKRBlnQvAV0rAaLiSI+5fup5cje/sf9AWO7tQ+b4zkGEq9vcECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NecvcYei; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NecvcYei"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-794f701a3e6so17828837b3.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 11:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771097123; x=1771701923; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjBmtYgoNm2L/egRL+9KTyUHzNMn9Pvq3RGushi4848=;
        b=NecvcYeiWbwbdMtgH575khy0llKMnh4albeDm503ydMITLMUl+t0n3AQa1QDEN2VQz
         /lAqGWh5TA2w/Wta7cJlEntYJpPayAccHQy5FmJoNiATrEqVG/bb3fTT9kmT9oruswHb
         QgHptCuKb1G0CroBlHu5MM6gzm5N8wDFbEJDZYqj3OMbE6ioAjj6ybgSP+jOdB+3dIDT
         mW+If09G8w0ndeE9CBsjZGW+8LDw+krRtTe5cf9WDrb0RyVN+AyTH9tUPtsh2JSdF7hB
         1ehe8mYJ+EKhbKXJGeGyu2MT7hrrO3iQXb8/1pPRJMwEyZYoR5guxjeJt18D+AMZjUKN
         07CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771097123; x=1771701923;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjBmtYgoNm2L/egRL+9KTyUHzNMn9Pvq3RGushi4848=;
        b=D+k9fWTDh12ypT+WvVxdc6TbNKOsdcIlYYh83n7lyjoVUC4MZUzwB+QOPhQrLqCPe+
         H5+46/hZ1pk4L+MQR4GQBuBFLVD/5FV87DC2xFXb1igeVNpi/91vb5uj6YRTha+mkzZB
         3mV1vQo2yNGGGAxCzrDuvsbAIk++/EGQC3KEZ1Ytlm2tj1FbuQ7jxCHIefRizSeWYRtX
         xfDsFGsbHQhkmanSnZW3hY4G2Un8niQhxiWS88sP6J04w3Ef7XV3U2DGHHfLdnTtY6uW
         J6j6qHW4RG3XpxkU7x8n8xDEc9Gzeu22HcN5WJQRoHUf9XrXXy56yR2CIgGgrEfF3KD/
         01MA==
X-Forwarded-Encrypted: i=1; AJvYcCV0V88cD1qaykEdNVPLMd7yo5yFWj7HW3KJUe6AYYBbUZy2LDFAAAXBfyNs203e2n3oJGcgRLn47tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/xUvVjfwkMszDF4pBZtH3foLsk4g1d/ZeujW4/RX43RIAokx
	oqdsVpD1EeNylns4UJ5B02HG95QBqdRaleWDrjX+Xc6serc4f9vBkaL0
X-Gm-Gg: AZuq6aKwBVmrpBnaRYvAdh9kjesnEZqslRP0NhXy8vDvTPwUiTdjxsPDidtaswQBO46
	WY864rg+vTWwozrgnMOVHpOS1EqxGqZ2WAs47qz94Ngn+ztrx382NpZxsO0g0ZUn5TsIlvLW+5j
	3wu8bpuMEaFuuKje79/kTVIxBxYJ3796nxwsiIkcvN4C9goGfEac9LE5CEdcg/oCqT045Rh6rFC
	biBOpIKUUrLez2Wdoi0N0bbRy7WW702lO2RikoZEEiM0+DuvoCthpZvB9odqlD/9VIE1FkLSEhL
	HPrANc0RONjN3++8F6jE8K9cCUsU2Iu3c+hR8TOv6528pCg3L/k3jvWViEM+x7MKCOFU+pHDIYF
	8UCPDgp/jijRibBrPJXBx/KUxdUyvioLUScOPMXdk4+vMhU1GGqczlkoUy+pxf3Ld+KV3yleasY
	P0EUlT9b/0M7m6Qbod9grMAvHPeGXNULFDuUgvCaetV/d8sNztvLUxvNmQM8cPNkvFbwz1+7hXn
	G83P8QWLynobTU/cb1XmisWemYRXn68VqoozypGaHEMHH0nvK3nIw+1rRUmeQ==
X-Received: by 2002:a05:690c:c50e:b0:797:ab82:7521 with SMTP id 00721157ae682-797ab82791fmr28435937b3.34.1771097123191;
        Sat, 14 Feb 2026 11:25:23 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18a935sm81141787b3.12.2026.02.14.11.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 11:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Feb 2026 13:25:07 -0600
Message-Id: <DGEXIYVWABUD.2RSBMFJHUGAIY@gmail.com>
Cc: "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: gp2ap020a00f: Correct return type to int
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Ethan Tidmore"
 <ethantidmore06@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260211004819.854169-1-ethantidmore06@gmail.com>
 <20260214190829.018b057e@jic23-huawei>
In-Reply-To: <20260214190829.018b057e@jic23-huawei>

On Sat Feb 14, 2026 at 1:08 PM CST, Jonathan Cameron wrote:
> On Tue, 10 Feb 2026 18:48:19 -0600
> Ethan Tidmore <ethantidmore06@gmail.com> wrote:

...

> Did you find a path via which it can actually return an error? char
> and dir are tightly constrained inputs.
>
> I think the error return is probably just defensive coding against future=
 bugs
> and compiler warning supression.

Yes you're right. I was just correcting a signness warning from smatch
and just added the extra checks.

>
> If so it's still a good thing to clean up but Fixes tag and backports
> probably not appropriate.
>
> And best of all, once it's not a fix we can use some guard()
> magic to make these functions and your new checks cleaner.
> guard() usage would be a precursor patch with this one on top to minimize
> churn.

I'll send a series adding these checks and using guard() and will drop
the Fixes: tag.

Thanks,=20

ET
