Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606788;
	b=b6nkFt6GYWEfv+RkzqZ0+ytVqWO+6rhGtLkN1ykvymvC//U+Z01tcR1NNE54jt2jNf3x
	 dO05NRc6wZBN4okGv5J18CzMmtEHEgbSMPuiT8QLMy02OCCvxCShZKHCequQWeKJGpg/N
	 PWTZ6Mx7t3BQixOCLLs+994ej4rGnNFbCt/1wkvMaL8JDXZp7JvdS0vN0XkaZ+cJFKt9M
	 pmhN7/x0jSewsYyhJNBrjAruD47pU87vX1DTdrkTvhnXkxnie/fLeoJDSg6P/MO5Ob+K8
	 /h1Iu4jm7nNkabGHjaFRgxWZOSykqudv0jSNrE7xeu9OnU0S4m4l8I/UAugd9IOac5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Nco9E6pnxf1U90wQWWUGgERQdyljr6gpJ4DY5U+hjP0=;
	b=yQGDCflCX1Fv+l94dcGqWMRhZji9C+43W7d65LgxRB+hJ0aV+cSQ8uu0yo78degjunnT
	 9o0SjlteEX2Ph14Wo8Z4LApj2zK5xNgiEL4Hiq2qhdBWOPiZ6o+P9o9pIagKGH99Z98wc
	 aX/mY7HpF3ZAwtFTrpOd4xjyecw0tcyk9pZBjjmdzhJpgD/DgaoTPUjkhTtHPTaMcaiHL
	 Th1nXlR973s0Li6fxGZqpyJ7ZD1BIOWKeFh8rxOrtzFy4IC2fAtOzgwQoDpNu7OsXN8hD
	 ovBC8bLwqQgIB4micvQCY1Kh35IqGgB829vFX2ogM7T0+Fj4uK1tX/GbxDWgnxq4Faw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qAGpfHyV;
	arc=none smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2236F606A319
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 18:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2236F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qAGpfHyV
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so180909e87.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792606786; x=1793211586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nco9E6pnxf1U90wQWWUGgERQdyljr6gpJ4DY5U+hjP0=;
        b=qAGpfHyVfaMIH7CJNiBwxj9rv0Qe6qb2Bz8HH8EBd7DU/Gjg/s5+p/zxDysVJdoVt6
         gHm750RlBqNpmLp3R2mVgZtSwqCnC0mWd5rSRkHqtSt84k55Wem2s13Y8Tqt9qR2pvTc
         amDxGM37Q1biWEVVa3KpRTDLEvBhyEsuBj1Wu+N/uzl3RODyG/at0S/jTNUmGum9GgqG
         yFqFiS8iKcOn1B0og2Q6mWoyM7sF1uBmIH4fPOrt23TZadX2ELc2fy3pYnR0e9VRRekp
         9aQUnX2VNlMqn6+hspMHTJwFuaPFnV0IqTAxeQ2RZGFtN/tP1+FnB7Ra0ekHtOztob7u
         4QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792606786; x=1793211586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nco9E6pnxf1U90wQWWUGgERQdyljr6gpJ4DY5U+hjP0=;
        b=oSdZ8evfIC3I2V5mi0LHHdhekwqmF4FnIoiH17f7WPMlrGvp/lCtLNIdZwXYsECPsh
         c1HAN5fEaFYBCaoKRAiFYiPr/DPv4cn5dxEs+zntlOdTBY1jd9zMP5RtDhMYWGjYbdET
         IbnsaKP+kcSTERUfX+MaSWo2Gp9r6tgJfv6fUavc0Qkmu5n0JxrWyvao+0Jaw5CXiCsF
         IFnuDTfQfEp7YG4mu2j+HeRZTND08L20Da/vF2ce4PeYvqKLW+crLlLS8xBtTDl37Ty1
         uWmvDOBD13jJhrKjtahlUtmi0rLG89nPeYuFVDWbRZ44mNq0ZWkxnrakGTgJiTr/VvZ1
         3XjQ==
X-Forwarded-Encrypted: i=1; AKwUvBweEWRdkIsw/LheoxF3DPaSklPC9DEKsUN4Y5yUvfgXWrvaoW3FaACaCQ7omjuiOAfL8JWiW05vCgI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHNzPvq6ZuBiGFLDNa110iBl5Tcf4JuxSTRGU9pzhh860k1VsM
	LwPxfFpFjkuOpnYgTq0lQuBDSa+XtfBhnRLCM/+3BsCN/oQ3RYI9wg+a
X-Gm-Gg: AYBFou2pIajfiBtrCwgDGgvuGT6VPVL0FXYvNo1bXBB1AVnbh7Z8j9G1g1NTAommnFM
	vN31830RexjVm3A34FZNRlDqLnb/ATlDUAjDQN8Cv6ucn2XbUqYH1tc67rnMCN2s6Bh7YsYj9kK
	QZHSQfbCqAd0fLSlGKj5rw1aN8YrCOodBG/QwDdXRvvjgl1saw3ReK2qgZJMA6cXeTP56fPbWFM
	qZ6I2aPxaXODGwKKlVwyaYCQB8yLRtsT9YZH5SsKILCtvrPZ/xYovLRVQMrAD7aVajERYEBJFTr
	PIEq4k7PQiGgwHzz/y7laycuA58yP08V5/9dlSTWR93uYMsIdkh6QVCl2S3qOsj23vW16F7A4VA
	ooxaF6JW5Dz3YHbucwbUaSPY3a6ZkWU1oY+fXcngKUcwcMo8xQYUDoCMY5MP+QIcDJWzONZ5jLG
	lqQgbTSbVmHVS9U2wpcQrInRf3c0ZLqxslDDxZa1+eef0UdfNnq/KdJXEJCmxGMJpHZd0DU1GOH
	+1tlopfcXw7wVHzGl3NTTUfuYQtdS2YvtaDdLrUcUwadoLd3tBmXWI43eIUOjVPdMSrMJ9WDCr1
	lIDslPD5JcUvrgINW48kK8JGwE8I862ljFPgm/mBbUyLvSmVUgMRhXT6ARYEGQc=
X-Received: by 2002:a05:6512:3e0e:b0:5be:488f:6008 with SMTP id 2adb3069b0e04-5bfa1ccefb3mr1270192e87.15.1792606786005;
        Wed, 21 Oct 2026 11:19:46 -0700 (PDT)
Received: from yantra.. (nekmmqsaylkikwvppw8-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:10fa:2e9e:78b7:e58])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfa123120asm649718e87.69.2026.10.21.11.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:19:45 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Marco Elver <elver@google.com>,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on mutex helpers
Date: Wed, 21 Oct 2026 21:19:44 +0300
Message-ID: <20261021181944.14272-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3f41338e-fc47-4306-b68b-5a81c26027fe@acm.org>
References: <20261021052435.112686-1-zoone.rupert@gmail.com> <3f41338e-fc47-4306-b68b-5a81c26027fe@acm.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 21, 2026 at 08:15:20AM -0700, Bart Van Assche wrote:
> Why doesn't this patch set CONTEXT_ANALYSIS_qcom-spmi-adc5-gen3.o=y?
> Shouldn't that change be included in this patch?

Fair point, without it nothing checks these annotations. v3 will enable
it as a separate patch, so the fix can still be backported on its own.
