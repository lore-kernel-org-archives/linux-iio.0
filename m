Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BEE41D100
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788035101; cv=pass; b=On6RcToF1wtJmGzne7R2iwd/P4766r6FdbTWTAh67JhgjkoPPxfwFp2B3VZqokf/OEV2//9Bvs2qi2XXJJLQXh92jB86BO3tmWQ3qmJwFMMuQSm7J462Th4RauTyqH9m26/LwX3F47y+uHV6Is/u26Tmw6R/tITSES9s6hYRIWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788035101; c=relaxed/simple;
	bh=vR8EvjCEJMLtos/VE84rwQYG+yZeA5O2G7EFo2i4GmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYZEHUeIHBMvjOEZRXahNNaMIlMkhDWoyaRly+b4Sv727oCLL1ggeSsrQI7DnFlG+FH1FmalZi3hedL9WsN485b91C5zOhBOw0fWr5I2cHZw4AM4//jJAkzd7x+aEdNqaEZyM+WWCJ4sgKhQr+J9RVQY9phvFnRHdCJkEKZpqlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSAD8sKR; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSAD8sKR"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48436668d20so109054f8f.3
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 13:24:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788035098; cv=none;
        d=google.com; s=arc-20260327;
        b=dvMoMqE1lA9FA5GB7rBPUP9vHJZoSuGfKVvVi32qdLfaLzJoqU18XD4xylAdK4QrlA
         iQj83SX0w+JmsfjEI5S1a16NcWj4bapVjaoica1nxbXQ3Xc+/5dE7h5Z+j9IApqChbRF
         o0tRjpa5k2m4NbgtnLMb7dBCykFfzzZORaa3mqy3xQLGntdWijU2nhVRdpkku43UPutj
         En9efTVjKzgYXBhAeY6IymYQghc50N71gjpvBIAog/UVsUI+sNXj021NregSA3VCRIEI
         RpSm/37+RJNy3Oxg1zRIfYx9tNFkGkf/VD+yrRPW/qG5D5OibTPZDrcbuwWksmZsME2G
         CiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tA8MlSVHTHrEwXyCp2VrI601oCpXdup1DNABDFDkXLg=;
        fh=2T9H+LZ6KGUXNpSQebc3qq0xAxceJjxOA4YvuOBpak4=;
        b=E+E4kfKA3U3ln/R64ppgup9VuyFfv1rlGAJcI4/akwHfI4Z4DLE9MyxV90XcSyQ4Ij
         lCSNWNL8TzjcUUc83jewjazmifPrszrgsYMiw117veDjG1zljfTTejnFWXz21LdYqvAC
         KkSnFCONvmlUcDFqY5uuY/7CYa4eTrRcimzjqccVSW/VeXyYi8quCgo9apl5zjwvI2VF
         Ns4UH4yuhkxkmboQP8Hd0ZDAY9hUd5GnrM1RW3W/5KsWPSu5vRx5aMB9gcMOyIdxXjyL
         USmEUwHezDSZc4hR/cppIIyGYUmOqa8q4imuJEwa4DzXGTwdkxOdvK7EpVaCZ5c3GgGH
         Pg6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788035098; x=1788639898; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tA8MlSVHTHrEwXyCp2VrI601oCpXdup1DNABDFDkXLg=;
        b=JSAD8sKR0TzHNNu5z4KZ5yUpsQvMfU5kPlcGeWxS5L76AJhJWm7T/lkrP0tqAEmzAA
         zkdaRt0Mw9MyEBnu8zlQIs/D8QyOj5n6KuxT8aoZ4O2C14GOO4P9km+juri6iKz/vz4M
         z8OX2Y3/dT576NhxhxaS2gGLpr5b0yrdRISAMbyxB/q2+RwI2HIGXuSxaOHvpLwa0VlI
         0nb9z5QyfqHOtY8W5/sRG7kkcpt7LmfMgjXfWihzhNz1MnEs88Plabd9ZYdzKcxcNmB5
         3GxUcg9uZROOwW7o3LJ9YQvsaOs8dHuODESAXGBDXHlCgdFR+2ozOXKPyarm6PJtmrNn
         Yj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788035098; x=1788639898;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tA8MlSVHTHrEwXyCp2VrI601oCpXdup1DNABDFDkXLg=;
        b=ZYU8IkYVG/+sYLQrLCiFtbN2ZVa+4GqcU8gFLtt6YRCfs6tQ9km45valMjnYowDaGr
         KyYC+dHF/leCfofKtb987Gnw7+HWP/lkH5ji/GHOZ9hWLd6Vp0q+g6RJhghSbLFZYZTD
         d7GOLoi35Bf6lobZNQkCJH4ZfNQbcOEsOYylV1TYwJI0rz0CbbdM8sb6RUEJy/aJ2xEX
         UPnU3N4dWE7KRGr0VBgvkEVHAJ3bu1t6x5oCPhxYJuXBx/u+yoyDpSpb/n2HR1q2w+qu
         xSK0Plz22HZP7YUlPySbOVKoezZ5fhfFTSmcSABLflAhrx4VHGyWcePOUX6SfYaLEvsF
         lerQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBmVVkO+SVcwU4E8hUV6VxR21EIoV20Xt55BoQdRoX10OMCM+59eBwc56Y9sbPG5rqQIReIcnA2aE=@vger.kernel.org
X-Gm-Message-State: AFuF++moFIJC27uGyT6qDiTqK3Q/XG4U/rq3x4gMSwx6exKXxzknIr++
	y8Mu+3qIuGjbaRWHuEKoqS9NCA1CEwZqgWINEWzpYNCcGMs8e8DcPvTiYnojSvK9Ne2zGVmtfaO
	og1Eh1sw7pVYKsDZB05rbFrq0SE2ljvfOXMtI
X-Gm-Gg: AYBFou3/O+3qbT+ErVqW/LYvo6mwgGl/RFApSr872VgqD0IQwIpC9NJoodnEt2yFHX7
	s2vN6OpcDT9PA5mzSYpz+RfA2kfF9GvrCDB/sS77ajjOs4QRePqraXbONvQm2rbgcjO9VgEO5ae
	HHyHa2tGJoearQCEh3l0innjgDr+N7sJ5NX+xAUgcaQwPI0e1kpcdHChoAWB2oS/Mho6loHdopR
	IWgeSBMms9P/UaWQ0oO5dicWmd7X43Sg2kpM1YUtapeS4ef2x7Vm6o3ZdYVBQuvvLonIfMcNu7/
	IF2oJH/t4OPqibxzU2M/34Phj3TiHjFgQsWJoSunsM/8tDnoTYmvp5NbdayzpE8JfhYf0mbD6GM
	A7CKQeApOA59+g0BYeRWevKnqri5qIZPlrus+y4NhmWsOOBTZ8kVm3x+tctIPFxzHJHBB7eZVPw
	w0gWGbHkYTCSv3RNv6LcuH6foQ2z79F0KOtTl3iwUoNzK1ZrxzBA8KLxBxeTby2xrUm8HRzrqH7
	qrm4lEkhn4L
X-Received: by 2002:a05:6000:4910:b0:482:a8b1:aa6d with SMTP id
 ffacd0b85a97d-482f79c1923mr23546979f8f.10.1788035097619; Sat, 29 Aug 2026
 13:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
 <20260829-kernel-header-removal-v2-3-c67739d5dedf@gmail.com> <178802625991.2637008.10318808016519364966.b4-review@b4>
In-Reply-To: <178802625991.2637008.10318808016519364966.b4-review@b4>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 29 Aug 2026 22:24:47 +0200
X-Gm-Features: AcwNN1UOj791Z1vlAg1YaooJdLCUQ0l1Xa0KFU0QjisAdMWvodwAm00Eev2aVw4
Message-ID: <CALoEA-yLuDJFfL4MszuY5GAdOL5ZyLK12ZLXE=-tQbtQswhoOQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] iio: temperature: ltc2983: make headers conform
 to IWYU
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, Puranjay Mohan <puranjay@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 29 Aug 2026 at 19:57, Jonathan Cameron <jic23@kernel.org> wrote:
>
> > Remove the catch-all kernel.h header and add the missing headers to
> > enforce IWYU.
>
> Sashiko correctly observed that this wasn't really IWYU.  So, to avoid
> confusion we should be referring to something "approximate IWYU taking into
> account some headers that always include others".

On another note - since we paste Sashiko outputs regularly into patch reviews,
isn't it time to send a pull request to the Sashiko repo to Cc
linux-iio on reviews?
I remember the last email thread discussing this died out unfortunately :(

--
Kind regards,
Joshua Crofts
