Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795347056;
	b=l90t1sqtA48+Ao58jgobwRBhgwy+DqP0U9Qkk25DCPNXlIii1IsKSlnXUYOEX566RVmL
	 TyUuhLSQ8gJ7TZUpKq5mTVP8A5gDc6LQM9svljutn12gwC8I5e8LOKrs9cNLoxkB+WoHh
	 /zFjVwS9tHJcObPqp8YQ+tV2PXHQekGm76StdVEBhgL7TBcJvDKkxatcY4RJGudYEFixD
	 9XscJbHCuT7Rajku2ieMq/OqpUFqlFFzOJZRp8a97esp1unbN08u7FIO77HgcL2F4WKir
	 lnuEbASgn70CEPAlo6Pc7RlzPc49TwKsh7mxrmx2yvT9jeMBpJvfxl7nc9Ych9QisEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795347056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HTIrhwJl/9ipJcdFd57QjcFO8vQHJXUr0hmcwxLC+cc=;
	b=sYXtuOhm7kOEgDa1u8onyBs4e1XPNmRb9gzTrHe7+bG/y8Nmut6E57purOTwcOdlk5dM
	 XDiFQaUEILJzEiEmtHlHO8KFyt7czZ1+ZN+1DpauBy5JkAM2ql4pGxoSalp63gGUS6nKr
	 Bk4F9oBmdS4KPVZ+hJIg8nj0Hs7PiHKzh/N+7GYlrX9zAoTnMeGvxMwexLSC1YrEeNNp5
	 M0DFWX292sBm2OBxeWgT3lZLe02jpLPZi54Xtvsi8gSnH3s+w20zPLsVWeBYzhJMhTtfx
	 LGYdvVyw2itE5pvOyzuzDmddPMMuw9PN4xxeviOzwNwc7uSr1JVdyZjrjCnIetmjJdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Re6I7jHK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E0606A320
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 11:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 884E0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Re6I7jHK
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so22512171fa.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 03:30:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795347055; cv=none;
        d=google.com; s=arc-20260327;
        b=I8zb3Q5U3UDuacrPyrhZUag3qehTNTVGLicjCvhIgwjUZizPfiJvcKTCFAxxalyK6k
         hyJWERQeH6EQx6W0yglrG6c5M+2RnmlYkOrlQeXTeWPhUkEcj5Qqz3zI5jddY/RGlO4Z
         Hi8whzc8HBANxEEiMC21SpSwc7bN+howocFDFQKUGmw1DrD5rGgDTL22wi4IlvZ3X9RA
         K++cPPqBrVgpWMdG7mi6e5N4sah/VWthg65J0ZBnTWk9vheXqH1wIwBAqtvRjz65/X0u
         7TohnAu+LWbYvFPeH8Bmd4UDs4KNY1HL+AsFs1v1VDVL3VITmji7mtDrcIFok1rNZEwa
         +b3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HTIrhwJl/9ipJcdFd57QjcFO8vQHJXUr0hmcwxLC+cc=;
        fh=FMT5joBCIjvaCiE6mwdc9malY1dgs0oX4BXXtf1QApU=;
        b=DPkOJgq/gMw49YmyicNr/EmLtMsR/5TUd6ivGz4AxVHRy6SzfTLFvDb+rSl3PuD8Gi
         hOaLKQUMWL8bHaI/wOWmMgnxVM9Wz+V4X3slVUaSTanhfYLzp/OS1F1Ia/PG+1bEs7q8
         zpRpUT7KtFNpiIFxrbW1vnhxY+bcFZ33S1DvEJW7b6UNnYaKWd+1MBbjnjwp+tndNzYU
         ONRTfWo7H7sk3ZDjqIcJ1Ro6UXzzgBlc8RwRZqJvhlHmU5Wafc86l0MDbPld9wEj/jx9
         W542R6hlb0IWMfgUodHsSIngtRblCLwbBkz21JsZInGL+5YeZtNoKaleaWr3hxBdOzIP
         MzIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795347055; x=1795951855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HTIrhwJl/9ipJcdFd57QjcFO8vQHJXUr0hmcwxLC+cc=;
        b=Re6I7jHK9+vdc0lUYaTP7u5shUce1zWoTNliKBzI29xJ1G0YpcCBwSl3NB810ns/j4
         thf7iOUognRvFMB6YS5SSTzTMbeb2bYFYL7HTKo2zHRSv835Wk1p2QlfvF/6ndXHkL+L
         hJ5/JEmbt+Dp7xqaUab7+nByfRsYddAXTgP3BJYjyiupy+ixStpqCjaJOL7k3OS022yv
         4chmwOwNaJxQhjNvdyItIe6ybl/H58EjUROgx7fnIsMqrTI4HbHH8Lc0ykBth3vkkoxI
         7oPbLCQjDDjrqL9v19yciwvehcL2dKkM557aO+qoJduIUfcsDT8ObclkWApiGGCkCEuE
         wnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795347055; x=1795951855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HTIrhwJl/9ipJcdFd57QjcFO8vQHJXUr0hmcwxLC+cc=;
        b=y33So2/KJ8ualmrC9SKJIqqpf6SPJ+0kKLtFjS/Nz9Bb3CLIZES/eKiIDj7zVMLfxM
         OppTbNkgtGxGhHu+zvR0yitHu3ZaiPgamchp2Li7vQ/crudlvBNyk2DiB9UU+LjK7Ah2
         aQIFYyOb2WZbJynbGUQ0EDtojPH8oV8/KIsrwHRSLnjqnKl4kvPKl1tkzgp7AVoyfaim
         3Y6ZdoJjsnXsCQsD4+QKvQWpPkHNFfccMjqP68IpJTcNjsn+8KrBTuDfNyTDNHlrfUYb
         G6frgtndP7MmvmiymgR6PkZiDukoOw7kajjcooWc930NR+/BpiSP4OD8dXjka53SlyRC
         QPBA==
X-Forwarded-Encrypted: i=1; AL+hErFDsgcEljW6KHgzHkhtxpddtE8TqdKTxV61TtF/2H0G5SHse2a9YwUJHj/zCjjy3HnwhPvU1SOnsaU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BSsbrdfki0ku5EQ02Wjz1Q3BmFKL71BRouz2r92N9v/OmiihS
	INUttisC+5xbS1vQdxR3MMjUq/QQKz7pB7hSEHVIY8z+ULzIVstES97RT/N7n9AkBXz6zBFn8ij
	cpu7YVjtngZ610r8UstGPTdB6MLQCNlQ=
X-Gm-Gg: AZFdTZeyzAMnApcSvqcK17mlUisav/DKsskATJv7QdnqIRA9q7scP54vNCe0RLWhXhl
	dpFkBPWX1CLne5Dl1uqXK0yl/9Qs8gL3VxFpzxDjZF3BDKmUy0FHKOVAIAnAQjzJDT4oPYMM22o
	QcM8DaPS+YTDCtUH3hL+63AFxZA9iyfzm+RRkHcQCLcLqNIvzPD8OAuEtUPLrrA4JlF0NlrPdzY
	9crSp1XG0CehySGOE0RRFiu/Ng0LJxwsHAvcpusC1x8ieKM1TKp1kDDEsCQB9NPWe+DO+IZfpjA
	bXWNOUkgSs9gS680KhTVwL4iYgr+PmLwnpzBssKDN+xDGDEf0B09s/T4JvBJpAFEnPECzyT/e5b
	OvbJp4/kbzIUfgcuxG9aVgSLmWrCRwdnVZUDKt/ok5GH7hwNiWGhhQf3nXI/b4q0GvpLCcbN9R+
	ZJaYNdc/NmZ+X+8p+gazl9TVQx0Zq/UkGh3J0/2JfslwJzIIA=
X-Received: by 2002:a05:651c:a32f:b0:3ad:fb2d:a757 with SMTP id
 38308e7fff4ca-3ae7fa45871mr24883491fa.24.1795347054437; Sun, 22 Nov 2026
 03:30:54 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119134041.16611-1-festevam@gmail.com> <20261121231726.71aa1aba@jic23-hlaptop>
In-Reply-To: <20261121231726.71aa1aba@jic23-hlaptop>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Nov 2026 08:30:41 -0300
X-Gm-Features: Aa3M54qp-5FUOe8r1ZuLPebMgOZXGH2Yo_N6UQqWLwX2mQ0uaPQ4PbhpovaTi3g
Message-ID: <CAOMZO5Dp6KYkd6=hsK366x_83ji9tdumq9k5tWXJGvW0EeRpDg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: mxs-lradc: Fix interrupt order
To: Jonathan Cameron <jic23@kernel.org>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-iio@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, crofts@kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, Nov 21, 2026 at 8:17=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> This bit belongs below the --- with the change log.
> I'll fix up if you don't have to do a v6 for other reasons.

Please fix it up. For now, I don't plan to do a v6.

Thanks
