Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793113761;
	b=gyxZLxl/FVLxvCRwu0xjgOmgntta3mNcmaQPxt40KvNnwZ042m/qvA72BzRvzfGPJfw2
	 BARQGVWRGPSqW+omfMjRC6SWLn3vOMJCw6rKI+rvQoE7nnARls/u6F/LGcxFCK8IauEkM
	 20sspu1T201bQQkzMeQwbu4YGJ0UrntfntGPFNrWKcBy7VURABwZAsjVOukv3NTc6j8wC
	 bY8HB0wrznpviKwY1T/FDo8aXWPwBJDpMGGPjpnAphrXm+jfKoUC9JV44Z+vOcIg//o6s
	 5ZTMEz7JoadzxBgXDW6gVui8gy4Gb5CV2z0hZZBfDcBaj6bhVVjc2SUDG0WyNyfXvdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=oAHxKAOEiqLhGsEJj6uWGojbuVaoZYDv1iJ7mHdZGsA=;
	b=l8fBDMKKxsKi1T10Ie12vdKyE0mRdE14nLLJdyi+ozxlpB4E6pIe4MmF/jDE/K04exxv
	 4KBJ9BLzfJhEtSfFsLxDSXo2F9qqbS1n5dLec/McDUOgqosL5pM5aX2dfarjFHO12fJli
	 3tuZTIrSE5Jsv3KFKc7dFA01ZGmmX9ndBPOHReh/N7to2lEhIJcXbILkQhmFlS4E8gLPh
	 oDy/lZXaGcCwxaL9o/r7m3u86NE9eJEK8y0+LEJFGHMrczRVuaHwVz+08IxoAixHnJv3z
	 ikDqRMAI79ZKp0qDFPnaGane7IPxOhcecsf5xGCRVLlgxxBQuQjO22ajDPTpGfGWPoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=co466oFF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE3A606A31E
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 15:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AE3A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=co466oFF
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535a54bed9so6545085eec.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 08:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793113760; cv=none;
        d=google.com; s=arc-20260327;
        b=gCsRmodVbM6ysIyw7JEOCNdL3Ze/Ron4dvZ8iTbqTbCF22z96VyKVFeVWhLW2rA5T/
         wPhDJ5gFpsgLPV4IiunSCFvemlfzqNL6yT7Xc51x5yUQDTYgxwQJBWKRZ7uDoKa3Q1rd
         hfJ+W17rw4vFXhWuzEj9l/PHmzyxSZcXXFTE8FzT7PnZKBRCrrRqlZi+Y2NScelZKy0d
         0aWJqJHCS5/ncNEvjSNTZRYIq3AaqFuzQjk+mMdJ5zQ2Hus4ePWhpOJFSxUFP9Igq15L
         n1nDX6tYmyycKGs09pLg/24CXbsY1mjba/4Bv0MQ10/B4WoNuUIOpKzExJgRlpDSiqdD
         TDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oAHxKAOEiqLhGsEJj6uWGojbuVaoZYDv1iJ7mHdZGsA=;
        fh=cq7HgoakbvK7uWxDcxmKmcub5fsz8w8tial0cGHIu60=;
        b=FLFo5af57mgngIu/torydBtlwVVStiqWJlvaOUHHaEGRhMbeITPCCK8I7da3pBX//Q
         MNEqIMp0zxO3lasRbdVjAFHSEfHMq5oDmv4yPC32OfdF+zkVY0SJledjUuyinD7AYukS
         5Ou2LxKsbZPDrwXe+x6AME4CAlHS80BNHZ9C3W1oIGefQbaTnLUXQ2PSFCQyYyxBsrZU
         Rp/E8GKqukQM0IE73ke/J8Uf8zz8TfwvR/ik5ocPIKbKODP+zurw1E6AniBSbz9O3vGZ
         ylYUnAgtY1NUE3wWcK7kwwVN+Ymgncib6nsdNpjxcis8JRoW4v8pJmUP6jY0TWLzW2J0
         SmXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113760; x=1793718560; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oAHxKAOEiqLhGsEJj6uWGojbuVaoZYDv1iJ7mHdZGsA=;
        b=co466oFF1dhQmr2N8vEvSlNncCSXO6JbBOpXu3AWET4ZRArQ0r5TFsh3JtzIiCijJs
         xuVELQBeufrhTzCRwaLyL8IJ94XYqwLjwQ3N+cMEQtFXinnkOenaRTKVr8WkgE73/iUL
         gbZbuqionHz7tYdmAQP1py0nt116nJIadBvAhG6AzwmPkwVa6rXM7EM86B4eB8T/7V7g
         EQarfMCisspF/8XzNwrt4NZ8cAgg0yWxLsM82t7x18XK4CkIdCNTCRscDbHeWKY/iGJT
         gDPIv5zAgn3MCyG8o/2beygcMBwF9PfRJb1KNZIMoKB6X7pHl5zKVUfmZWYKrj7NMVAL
         aBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113760; x=1793718560;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oAHxKAOEiqLhGsEJj6uWGojbuVaoZYDv1iJ7mHdZGsA=;
        b=KdVXMxKLl7dIzTcFgWHBZNtm8MbvKwVUX1US/vZmXif9RXzvwtb6+NxoHeEQnt39YL
         152C0wYV0wdg4WmKJGx5X8g7E6vOH0mQjKrDSxiliYuN40CdUN20eEfy/AcAe9cX5Z0Q
         82qOPpATloYXy1cy9gq/nM4XF2z9XcMCLRWhJMXeuoVaumxsW+WWQgy8FpeoXWNeXEZf
         fXpMRrKAv5w7aMs4jWnogXLk+4bcla15JihmbTkZsmhls8SWOPqo22Av7g4NtmpiZd9L
         FefojROhNDccJRCO+qsvtie7q6r4/7C+M4i+ZB/WUCIwViwsEuTpxuchIQtTKlwKi6ks
         9E8g==
X-Forwarded-Encrypted: i=1; AKwUvBy89pE0Hpbx37dNwEqxnjhw3Zat0466pxsh71PiapWDIT44xQYb1gsVZcQxxxhGKp0fIOJM3fzkhSo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/UXphwxF5oGdWZF+BiaAydsU5VVQhgjVxgSP3pzLp0Al/B+2s
	h66s28anSLo2CqY5sQpq2O/IlvsTe24zSQ8cYovndm21cWHA5gRqFMF5AB5Y4hlV7OYdRu+gD3r
	00t3RkKzpVcFEr/2/MFhtGZ+J1buIODE=
X-Gm-Gg: AYBFou11+n4HA9FhwM21EvRszW/hTF7m+18CrtflX8e3Fmh/533jAa+P9ptEt2EfSED
	4OuhmEiLh9h5u8gfRrq46DAprlb83inR0AjWNXqFlrMbTalN7Uwv7Phdv/gxYExaXm6qoIHHVUY
	YVCrwZruCBlwRc5wanJ/JS7hFgBhhVmaAV/08QmZPjSez6sZYnglmv4PDVyjCrKlxgM8VM3DruV
	/tBli7pqUGr0hrKE5agl1+XwKNNxTmsG1e/fcXIAZk9vWwae3lyDwy0wOlfdppbNoH/ARHWwq6y
	qK/pth8qBufO+bKAs8a5L8cSLU+rY8Y1yOP27+HMMbWTNYmTr+Ce/NgATVoEEF9vC3vCg10tgcI
	e59fU5cgtH1H+LplINoriXzhNGnOeQpVo03ogJFtUtZnt3U9NFqaEmJPKVun++0pxNIxEin2ugZ
	3VryrMvrcXeVdiRuhisEexAhY+w6ebY5f2xfPB0nX/BbBhSuLkVAnPqA==
X-Received: by 2002:a05:7300:e024:b0:36a:158e:f917 with SMTP id
 5a478bee46e88-36a158f021emr2604437eec.6.1793113760079; Tue, 27 Oct 2026
 08:09:20 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027124954.110697-1-zoone.rupert@gmail.com> <20261027124954.110697-10-zoone.rupert@gmail.com>
In-Reply-To: <20261027124954.110697-10-zoone.rupert@gmail.com>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Wed, 28 Oct 2026 00:09:08 +0900
X-Gm-Features: AclHuK8H6vSFxFswuEXecNS4oxgF2wzBLnY17J5ZgNNydJKg-55kp3rBfAwA1Kg
Message-ID: <CALMSew+nhZp9BoqS5tOgFdiVy13U1r2f4UQa9Sd5zc9pSt_YcA@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] iio: enable context analysis for all drivers
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
	Benson Leung <bleung@chromium.org>, David Lechner <dlechner@baylibre.com>, 
	Guenter Roeck <groeck@chromium.org>, Jagath Jog J <jagathjog1996@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Remi Buisson <remi.buisson@tdk.com>, chrome-platform@lists.linux.dev, 
	linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>, 
	Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"

I independently build-tested the full v4 series (1/9 through 9/9) on
top of jic23/iio.git testing at 7d80b4b383bc, using Clang 24.0.0git
with context analysis enabled and W=1.

Results:

  - x86_64 OSF: 5/5 translation units built, 0 warnings/errors.

  - ARM64 OSF: 5/5 translation units built, 0 warnings/errors.

  - x86_64 allmodconfig-based IIO: 723/723 selected translation units
built, 0 warnings/errors.

As a control, enabling context analysis with 9/9 alone reproduced 256
warnings and 2 errors. Applying the complete series eliminated these
diagnostics, including an OSF warning resolved by the conditional mode
claim annotation in 2/9.

Testing covered compilation and static context analysis only. Final
module linking, module loading and runtime/hardware testing were not
performed.

Tested-by: Jinseob Kim kimjinseob88@gmail.com
