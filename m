Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AB37AA65
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921509; cv=none; b=cMfU94DYbDotF1VLMuTA8lK49J6KFFqrQ798MpIUg/bM0AomtTrzcDa+OvFXS5TqZqePK2BZlMkPvPbw0gDk2a+RgoCpsCJA2uq52pwMQDLAY2WiItgYmlZeiP5umWEbMDijXc+5A9NrxfqnoxtnadHX5N/KAjQF55xzIlokPuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921509; c=relaxed/simple;
	bh=r+iCWX9heE5Z9B8ae1bmRfyMHYbnyQwXWtPlRLXYvBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s68xWI1QiQ1On8RQmZD09zYO2y8zhjXf4Y3gcq8nlJdigwyPEoyBtQcNf6gBHab4qyY1gV7GkdGL6caNB11h12LcP+IeLoSKTiTAqfJZnZcbXCz+34aGjMPwHBkB+DQZ/SzNkLMwb9A4ipu6RkakjOOEG/iHEXTZ2aSlp8L4c08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5EoediD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5EoediD"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68ced97b6eeso5766487a12.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 05:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780921506; x=1781526306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+iCWX9heE5Z9B8ae1bmRfyMHYbnyQwXWtPlRLXYvBk=;
        b=e5EoediDWlEGUE59XVf22ZDBxJp29i+UlU4QZFjUvBayeKnPDmRnKp7UEXNQSPQj+F
         x1NF3sPQwhAv/AmudkPj3T6mloOTurNH4HpAUOwdeuFklsrw+N1PoMLekayLtD2ZQrl9
         4xqAcxlwT4axhnHsQ9Gi1LUye44AgqBNV9UMF6iWlCLaoKviZA5RLo0hVtIEFpRM8Q3j
         jmuWzrHDQehGu+k5SV35+wd0CyG3kdVP6/N7VS1GvLoNENdChtoJRZ7lcv6wIQSBS+LJ
         /LtGhfXQNWlV2zhOZoFUzEW+azfrIMwxJnOS1U4PTco2smTzOJTICO+PiwacJyOX2M8O
         YkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921506; x=1781526306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+iCWX9heE5Z9B8ae1bmRfyMHYbnyQwXWtPlRLXYvBk=;
        b=aR1mBuMyIuFWB+2B3/8JPDFlNMkpznPp0awxl3lNo0lXtmm74KqdDE2EToVH1OHipy
         Hz9zirmwRcFnlZwWOFFlSh8bKDxM5vFNV0fJ1mnInV0rV1LFZ8AWcpSpLtZcQXcNruUB
         lLQmlpjuOwzDQORczTldN6GBkaWBycGTIRryR0EJX04M8O/GtanA1M20R90q7jI5i4Vd
         pUqeayOPujbLBtEK6udi1sIHZu/P4vfw8LLJwI3O0lll/OVJARdvyVWOSZjk/7shBpr1
         jh+D0cd6DVpzZbg8lmRPTHVto1aBXgNSI+USlP27wSH9nK1gxra2wEpDHjlkN0I5tuM1
         OLog==
X-Forwarded-Encrypted: i=1; AFNElJ+cA1poFng+C8cFFT/wfdxXB0TmgxZOm6hxX3zIz3n+BMoieuOgEMozGVziHnJIiMcOwbjfKOVHvuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH0UckXPOf1pOcX3+dXCWLkvKHZau+SNsB3mreSyOFwdoukp7Z
	fnWBeaItMlkBRXfNPRqzgInCG45jZjb2ILLnfGB9VVPQj0tec8nZ2mVt
X-Gm-Gg: Acq92OHE8YxS+fCuTOcIAChVQdJ44Wek61tWTwcrCdSq+yjfu9OPZ9EIkCQh3re2UI4
	un3Mi3fErhw08apw8qfSL2oM3gD2a4OY1B6xGEtcuDTOS0qoZ/8dyTJXDQxrCgycEcOtACnCfAb
	SPLybSetl5HonxzdbxxyHUuun0mqdYH1fmEvboDOFHA1JeplbPDQrQK1qT4+A6qQbGVffUR3ASc
	oFuJg2fDiOWUMEa0FSERnJ2+/uqCr/8xRbPb2x81Fh+n/RNPwJda+7kroSLgA/zoxMG823rLqOD
	jgnjD/ErCe+xEEbLam/HN553zNWXfs0sOhJHHUQLpluDP9susw9aJ65Lk3+TujXqPcN5r9OjpzA
	JvpDLvojx0K9aUVeL1Qr0TzAJif3pl5W/3l8OJfm7N02vYh3ZZr4LXcBTTADgerWUNkxs8j6yEw
	D887ZglwjocqykwxMAT8MxUt20+kdVrXzHvSj0chkTjFv4y1UGdiUUF14bedfiKuNt9/aDB0t+d
	zyB
X-Received: by 2002:a05:6402:3484:b0:691:ad86:ac51 with SMTP id 4fb4d7f45d1cf-691ad86c033mr3034671a12.20.1780921506170;
        Mon, 08 Jun 2026 05:25:06 -0700 (PDT)
Received: from fedora.clients.cmblu.de (p5df027fc.dip0.t-ipconnect.de. [93.240.39.252])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65851fa2sm6954145a12.18.2026.06.08.05.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:25:05 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: types: add IIO_VOLUMEFLOW channel type
Date: Mon,  8 Jun 2026 14:24:59 +0200
Message-ID: <20260608-slf3s-v3-reply-unit-decision-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <6at5vkw3byvbdw3przfchwrqscghdfhuwkv5xf6v6dkvfpplt5@3k3gjxn2ua26>
References: <20260530205435.37326-1-wafgo01@gmail.com> <20260530205435.37326-2-wafgo01@gmail.com> <ahx5cuM1xlOVP6DT@debian-BULLSEYE-live-builder-AMD64> <20260601104233.310ac930@jic23-huawei> <20260602-slf3s-v3-reply-03-wafgo01@gmail.com> <20260604094436.3c50f123@jic23-huawei> <20260607-slf3s-v3-reply-femto-wafgo01@gmail.com> <6at5vkw3byvbdw3przfchwrqscghdfhuwkv5xf6v6dkvfpplt5@3k3gjxn2ua26>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 8 Jun 2026 09:53:28 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> v16 is essentially ready to be accepted! I suppose adding the FEMTO format
> could be done here if needed.

Thanks Rodrigo,

then let's go with m^3/s as Jonathan prefers. That does need FEMTO (the
SLF3S-0600F scale is ~1.667e-12 m^3/s), so could you fold
IIO_VAL_DECIMAL64_FEMTO into v16? I'll base v4 on top of it.

Thanks,
Wadim
