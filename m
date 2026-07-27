Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D23546D6
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136045; cv=none; b=EOdQn1zypkpKXxauDI+Cv8QDq0g6lDg6aFKAp5KQfIMJuPVXCYi1pvtTDwdH+Xbhd+Z4z9lbs+a5FA2MtRWn1PvMXqaeIlvdAAVI9o2ZVz9JVHNELm9/wyRzHMF7YiSNpTZZKywjfkk5T1vogGPii0VKaE+6R5ZinJDsXBpfT8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136045; c=relaxed/simple;
	bh=9pTGhlTmlIKGhwr3wvxYizndPJLOqZo1bmmXWszlNcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6Pz575ULsQRi/lqZLGhU9BQayDz6XTJQ1oqlMJPPjFBA/r/5BYHBO1kQ1Zd6xNnRlFL93y/l1J89yyDKeHNrs3ppsMPblZJl5VaCenJkqRYgLqaUlCMLeU0q6ooixxWymtYj05C4hEbNZ4t9VvD/F6HytktCaMUgLCYgK+qdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g62AQfyR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g62AQfyR"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-476a130c138so2298782f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 00:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785136042; x=1785740842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oUPot/fwY6gLD+qftqL8dQWQ2hoz4VMz3cCKQQaaJdU=;
        b=g62AQfyRn5Js2/cUFpnDwfrvjo7GBRXsMxJC5be1CIaTHfrdetjSNNL99cimOUwXqK
         u1+uIA17uv+7wPL3kn91MmnIijtjYny+CsHYgsV+HGXIzlOn9dsI/qQZIxD72PWejgWs
         IKwfCwwxEE4nW8EuJmn4NTXk+hNdsk6L4OMFkw5NEU0PWWrafZ4y3/lmSM8BPPbev2uE
         H+FQe9UvvSCYd+BRnxqYKdzEu1lxyhZ+zhnhYbhpw8z2G4wxr3U74VSXsf2YFjCm2TBP
         /J0I9ML/LFnM+kGYM9zrxRnO90P9lbLpj1xaJiKhVFmLLRtpzjealb9wIeSStCgyCU5d
         yKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785136042; x=1785740842;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oUPot/fwY6gLD+qftqL8dQWQ2hoz4VMz3cCKQQaaJdU=;
        b=Km1YZQXeAvn3DhSno9LKWNtNPvFfz+Mja8MlGsEBh1QDF7CnYIJRMrtOOAVFa9ko2+
         aZmiPTTEZvUeuxfz0T4xOtBc7bDB9EPdZdR+cGJGBuhgQ0IMF+laZI+TbUu6dOh2y5Rc
         ACQ4en78VC8aN+lew6BsGB1iSHNvWeYXZ3HZosZF3H9wiVCpUYEzausyv21ZQaF39AlQ
         /xAwfiqBJl1uLaDJFDedArEqWyaSaBsHm2mLnJJMvzb0OV2hS75/qm4Y0PsLd1QsQ8bO
         8vvQmKF/g1aVuR9r901LbivS5cvFSOZZjqS9b9/4EQrlB9z9791yAmVrtJ37HpkqiKsM
         vhKw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9h+nWkbNOTOxk0DcJTa3zccCJyInGPrRM510tw4kjBaIfzZs2t9G/QFrld0Tp1iF14oLAqSGU6I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKOulF9x23DE9cDWeu3DSJ115zwxH88jxvT2PQzIkDS6aIL8A7
	rQojS3/j6N2WilfA4pdVpLPbKhFVy9M7LEYZncBMGSgZq8e8zTzyYbx+
X-Gm-Gg: AR+sD13Q36ZWW630AZbLP7Lwv2NPhdlMvIWhw4RzROcSoNu0JGS1D0qsR5ai9WlbD2m
	LHuRhiXM/vmwINxMZiHP5Y6WnhNaHtBi9GlOW5xVguHRde15Z/gtVYOwPPYQfIHjwwOaPB39YDw
	5WIe2P2V3cuiOX0sI/yyVvReITml+0Vl/6GXI59GCNVRWq/4YBtsh43TgJze5k2JTNl3B9Rjw3N
	9WAYEmqYASnNLezxLKwXyUiIimUG+WQxcIUi6ntkRksY0hNXjW2bbeq9lrG3f2o6kpNPCbUj0xV
	FMphWdEiwG/SLzwTkdp80OIdqXsmGaJa0fqAB+73zusNXz8oUhLCntQAnMpZeVYql0xMiKpVglf
	VMe8E3cec583G0+HtcACSVwdV5Xz22+i2rLU7iUt+qrrIuxpdGl2PGZSFjOrUM3wFvVRLfXgj0n
	WVTAfsSHLhX7Lazy65pJjK3BbzUjL/8q7zBQWTTsKp+OnFRicqKynvVUC27UAjIkAY3/X/cjpxU
	uBKzHNmf2Ykr/7KUVGOzI40ZLrIo50LsA/z4GI/Uegr5kjUWDN4bL0aLh5t9L1tavbSHmxQTGGz
	PWD9BKZJTQM1K4kj5BV20CUQXHfJt3obISP0++CqAcXMEUENsmecgOwMfgSk7gBkjRkikvpKtyl
	8zDSdyQO+xP8s
X-Received: by 2002:a05:6000:2508:b0:47f:7427:8ce9 with SMTP id ffacd0b85a97d-47f9fea2a71mr9363447f8f.51.1785136042358;
        Mon, 27 Jul 2026 00:07:22 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a6d7sm46444037f8f.2.2026.07.27.00.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:07:22 -0700 (PDT)
Date: Mon, 27 Jul 2026 09:07:22 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: veml3328: remove unused
 i2c_set_clientdata()
Message-ID: <20260727090722.0000031f@gmail.com>
In-Reply-To: <20260726201525.0aec2c28@jic23-huawei>
References: <20260724-veml3328-cleanup-v1-0-240ecf3e5097@gmail.com>
	<20260724-veml3328-cleanup-v1-1-240ecf3e5097@gmail.com>
	<20260726201525.0aec2c28@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 20:15:25 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 24 Jul 2026 00:07:08 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > The I2C client data is set but never used. Remove the unnecessary
> > function call.  
> Yes it is.  Take another look at how that works and how else the resulting
> data is accessed (or just look at Sashiko)
> 
> I was hoping it would catch this one :)
> 
> The combination of different interfaces to access the same data has
> been much debated over time but we never came to a conclusion on whether
> it was worth the effort of stopping doing so given i2c driver reviewers
> are far too familiar with this particular hole.
> 

Ugh, I was too hasty - I read Sashiko's review a few hours later and
realized what (very stupid) mistake I made.


-- 
Kind regards,
Joshua Crofts
