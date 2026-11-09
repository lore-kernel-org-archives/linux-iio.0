Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186441;
	b=H2nHVs0BkVbPtdYKqVP/wAMMdKTY2WUe2fHOTwpqSpLWzcTYr3Ou3hiv9+bJq6dB7M0X
	 BqM2TZcmuyJvFEhzbVVzr5oLDIieilIqa9OOtcW37UryODmUy7KCpu4lVdwTVxXK3i8ef
	 EAvrB1bkPL+pOEGZpgTpykC3Ytzl0Ayy3QEPI462WntNCC+edPlrJyd9GCghEyPBiYFQ9
	 +zq7Mo6Nh5EdR1XdDNWAXPgbWbnXskPlQWO90iUuGaDdiHe0QogwDdUlPGwFNSvTueGCO
	 kNoPYMSbWv8uexQ7meQ9lugxnOsRu8obAtDXFt+IMd+ZOZ6gaj0AEehmYT3bkH0RMtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=H8LL4QavzVaz8U86ha91aoM/kohbLJcMtYgGD3jemMM=;
	b=QZBvtV/a8HNCa4apDtkidAyImKMggpui1d9VLycMb/vtzZV5qexKSP6cAJtUD2iYsgYJ
	 ZiQSmiKzhI6/31c4HNkHh1scGNA96LK5yiZ/7EX58UM9mg5t9Eft+721+j6iPH9r+SemA
	 7HxUJyPKXdKM7zdj20hnNws73BVO0Ysdj40ZDqoeKDeFaP8SO3Gs8+0LqITIH0E/HNOHY
	 QEQlDsY59T3Tld92btO0y2Pn1u7KEyB3cDTuQBjWiXTe5iwq7zCJDY3BLb6yoiHRkecZ9
	 ap4xhiTOOa/CorgS9WHCiiPnbBWSzB2tmYPgmfpNTp6E0pV/KDozqewFa/lUfP0YDow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qMw1bSYd;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D876606A321
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 01:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D876606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qMw1bSYd
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67be9601f31so259312d50.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 17:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794186440; x=1794791240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H8LL4QavzVaz8U86ha91aoM/kohbLJcMtYgGD3jemMM=;
        b=qMw1bSYdA2G4Ithpx0ZGJFx93ETFKzisXZ2X4c8mjE2FWRjXSvf5mc6udtFkC33REk
         8hHVm/RzeleJFxt1kVDP/AkmIDGZzySGZmvpqjOMTVksT62q/RLPvnITrD92RKLmIHof
         2NO1TDeVh9W9CFbOcR+Ky+dSeOBGWvrib+FpwYmnXEk7nRIs3kjYTy/XQpif9G4jp0xr
         mHCNZ+aWbxhskpiAZPqW04geXtQTVYjioEFWnx+6lZiEiXKktwBOVg35z3bJZMBf9e4i
         jXpMpLFk28+wCCxjoxtFKrJr9JRBNZuKbSyanY96M5oZ2oi8Edkxg1w81boUEh9jFqMn
         y0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794186440; x=1794791240;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H8LL4QavzVaz8U86ha91aoM/kohbLJcMtYgGD3jemMM=;
        b=v30hBOU6QEbM8J0ooYgDCwckO35xWz2UQPzF20dp+p7qFZJ2JYsqz8i6fxBqQagFvT
         audRHSj6axpO/X/4gQkhLROXJ4SRRV7SJ+TF1ORO+NKFsl4W97HKgS5sPNHSozAMc8j/
         iG1z6DQ8s6UJ4+UryC6xgvP4h9MQWFGz6DYgn8ZAxCcWPpmRirBE2gt1swx0MLuZRIuI
         9cc0g99u4l/LBqtzGUdpNtrFMDjdRghXI6V/6amj34oJylIKgnlZ8UArgZgbG6eqUaal
         UMCGw1TuPPVmSLgf4LCLmXL/mM4vUTMAaeHnlaTbQykyuRL7XVAjOHoXg0x75BRSqYLL
         kxtw==
X-Forwarded-Encrypted: i=1; AL+hErGrmmuKSt557VQM3Sfjd0+eumqbDB7k+ged50fb0v8mNa7lckeNWR6gzKxEebytME6PTeDNgtW/ly4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rqb/pM0HB6s6tFadj0hl2ycju8/u4FviheiGW+nq3PDmbkXvY
	KcTtXF74tuD4aTWOnnKvg9L7gL2R9Ymt2UgKuHxsH7Jrt9+67TszwL+S
X-Gm-Gg: AYBFou1NP+eYTAHBySxgT/wxu5wzkOkFHpJRDkIS74irD100I54HQiw9boLoDzVmoL9
	N3F8Hte+1a2xSJKF4BxuQHBJE7URemgaZkNwdBk9/uiAqGrqulVzkGOggVJryTZjx2Vz/5kk3Yd
	ENHbHiiTfsSSs4Y6UOS2j5JN0p6So5s1ORWDGVDWOmi9ayDQItR553035W86T55ga96T7NBKZ2m
	K+DkZqoKaJCBVUgE+LnAnZ80tRUUSpu6JYZshC4i3yvNgkhaBAucTHr/qW+8prRk5JeJEH8H4q8
	HxUSdjIi8oxQm8O90N7RgS44I3hJzRAbdAC6nq7uNRmDSoQxkbrPuXRXOHnKmD0/kyaqoJVIEr8
	dxNoGFb1uk8hBnMc+C0XAJfEldHKKiCLsUgRXHViBZ9FH61RBYOsrBs39b8sRfWS57uDIscndKL
	C38qw+s7/ISby98LyUvUE9RBeRLuFspZ0MnwYcPMCy5wOJFuxpHuC+lXYQbJ34jUe7zXvYwU/2C
	k85l58vz+ZD1tIJuSrMi++syMxpZbvFB/O06C2k1KmZnIL/wzLAgg2pQNqWBHd2Oj3KWlFKZIuy
	znIAe1AVfk9c+jw3Ql2YsyKAWGRgDpFDKHA=
X-Received: by 2002:a53:ed43:0:b0:67b:ff6c:bfd7 with SMTP id 956f58d0204a3-67c3da5d148mr1145159d50.73.1794186440116;
        Sun, 08 Nov 2026 17:07:20 -0800 (PST)
Received: from localhost ([2804:30c:2705:e00:f991:19e0:eea3:4f90])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c3b83d780sm2931938d50.3.2026.11.08.17.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:07:19 -0800 (PST)
Date: Sun, 8 Nov 2026 22:08:37 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joshua Crofts <crofts@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] iio: adc: ad4134: Fix duplicate data_read mux state
 request
Message-ID: <avEdFaY6xtzGaGTu@debian-BULLSEYE-live-builder-AMD64>
References: <20261105033120.387616-1-nichen@iscas.ac.cn>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105033120.387616-1-nichen@iscas.ac.cn>

On 11/05, Chen Ni wrote:
> devm_mux_state_get() is called twice in a row. The second call's result
> is stored directly into st->mux_st[AD4134_DOUT0_INPUT] without error
> checking, and then immediately overwritten by the first call's result.
> 
> Remove the duplicate call and check the return value before saving the
> state.
> 
> Fixes: f12ecb3e147b ("iio: adc: ad4134: Support SPI 4-wire mode")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> Reviewed-by: Joshua Crofts <crofts@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
LGTM
If still worth anything,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Thanks,
Marcelo
