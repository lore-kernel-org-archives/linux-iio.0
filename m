Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE213AA2F
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778379177; cv=pass; b=GIjrLx62qtuS9I1yKtSm4cY23pIl/27Gcw18Q5gFhcfP9BjgBx+WA6SfRiFFIVOz3381JDyar/nbuJzayoS+0l02ZuTWfQQJ3e0WcmJr+BidWRFtWAKsLJP9VvL8TgC7sDvfrcxaPplGmcc6BuVdc+PWyvsXV41BZ7NVTntE7Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778379177; c=relaxed/simple;
	bh=3jDb3mTNEpyjHA6WW23n78bjF4KkyuBGc/FTG5xMqgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKcTIpX8c0whyT8l5yARe7AYJP1yN674ob5CrGIEHkNm91bGk86h7X2Tkqo+K7nEuVA4c5zLkXcBehDrHTLXgxVL6UOHYKjRsjQmbcf+Aq7X7PTUlFdSKEzRMSQFC32RXSWiMdJZYRHoCgnQIUkAIdHOYuT1sPiR0YnRgs5RL2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyFtctfr; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyFtctfr"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7c0dea734b8so6534397b3.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 19:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778379175; cv=none;
        d=google.com; s=arc-20240605;
        b=RKkI0iojYMLf9xvklX44mBn4YyFugBYF1cG67/tw/gNirZfT1dG2K1o+XLK/EeauRK
         TMbKdozFAhgt74PeDuLWEeOrO4Dwo8kb92SjBB72s9NmaSSRSLFTAZ8j4U5FpQg4fJFQ
         WSYh9pezKXTTmMnfA2rDtnBxyctOw/fKB5HY9rnjPOT0//MqiDaiWp7wA161gQpZxpwl
         agJ/ln7ufyBq1DSgdaZJjUC4QACJoIfRc40TKcLLaZ4HwoRfAn/Bv/JyyOuIF62GIlOu
         C4JvJYQBKfESrKofdplQ5tioxZUWueRHJcxcgvmBIsaTr/AnoOxfLMnUHD4Yx8Fc68ZB
         gHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3jDb3mTNEpyjHA6WW23n78bjF4KkyuBGc/FTG5xMqgU=;
        fh=JpbR87HQNLXjxhKTcgJy8utYtt0kvRziLcuXh+H7JeE=;
        b=FFF2DMYAUdrPCDmX+bZ5glHQApxYpYYQiTGS0FYMLlY/qJwFwVG1zLdTQrn5gnIwPI
         P0yQ4hlfZj6tUgZVsioO7kLnNorAHtxlTDhdBzmzMQ88kz3YlQHB3sjpkAnwdgXciPYK
         DOR9HCKujPBK8swss5pAu37jGuFAs0ciZmpzglTagZW9LPAVBlEGBsC8bz3y3UP9AnQV
         uZpGgUi0jAsM3eB+L235KmpxXSE3rG0DW+MO7FOZo1QE+yWHBuZW+Cbe3IcAMpeKm+CR
         DXWXUYWBPdHPh0G5li9+87PC7BMyAwdx6QEkzpFTZkuVruZTXmr1c8ouli2e4EIVP3Up
         2WJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778379175; x=1778983975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jDb3mTNEpyjHA6WW23n78bjF4KkyuBGc/FTG5xMqgU=;
        b=OyFtctfrRz8SBEJNR7inqDFZcvtS4zb3S8LYPlUyR+Qv30e2ohIXSoEdL5O2vVp0wg
         3X7iACDxLf7V5xeP5LcanH06DzpikL/8eZi6vrKJn8A4PeduM9hm6dzA4VHXB98b0Y1p
         PgHX2h5jtwnzdlKJCb8eBTA/o+qJ5NjWNCqPdPBXRxeDOr0k17n86G3Lqyc8fYmg512t
         3VRsUucEPb28BnAmYyXXYEyK2Xw+cqx+I4+hXSxnF/ukvCKfIbZrbd0Q7Rvlk9r37dAN
         7RRCZ0bNoP2m127QlHnzUbFyh1PJ4rOjU1650QLlLjT8x9LicpRNq+bopJwptrGaLTAH
         u2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778379175; x=1778983975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3jDb3mTNEpyjHA6WW23n78bjF4KkyuBGc/FTG5xMqgU=;
        b=ZGHaHH/Z1ZGW8ZTrmSp0W8LNGW+Zzgr177GjrTTo4U9y+FU6/wclMoVT9J7c7AVmV1
         7abtRyW/myL+04y+eK//qHjU0HuWfUubVB4ZbmOB/xhyd4CGFry8lRtwQ+Fh1aB1WFyL
         /iodT3LjEpdhV+GRlrWE4D0twEGKotBJ4PmddASpl1CVWIXbqFgI4GY+zrg8s8m36YWA
         u192GMF3YFDJ/gsEN1hR/DvlYGGPwg8uYfS4c1BHr7bVXDK9SpsHWYAIFYf91BmGzIaO
         6pbmYxSjQyUIN/Z57eXLY0SpaeqkvG27T3+tqruI0dxOqncZe2CRCp31YS0QKBMMk2I8
         Ng1w==
X-Gm-Message-State: AOJu0YwRi7O0kelYxSh/EcONrrsoomF5zgYQ7wlA4Rk7CbKhvztCfE01
	Ddz71JAgRhriWgijauaw0/zuOIV7GZTr1Dm0CyL/3ObW+C6SHiSUNA1CYlqzBwOmz11u7TyAe6I
	t0qszo2ppOGqFvRBlxb5gnYRAFNn+tEfhoPnR
X-Gm-Gg: Acq92OGiADtG430Z14I/Fr2sxlBvo8eUb5+WwXQbXE/8SPOQd16G5Tp3kzO0QfCIR8K
	au84wo5noiWVQryxpoAtsjAeN9Uh/FZbzhLWR12+sM2zsMMCow8FgnIWSckOSKPRyIgaXU0eGSU
	E+s60u2z52Tg0wNQIBT7LXzV5sFc+ZPua6+ZV5qsqKUCfGvw+F187gfHyPfqz6/gIE14W8c5oB6
	qvP+wwZRUaefm3AxVQy+5HjNHl3ybn8s4qP+Y6zczANOIzU2SqP7I4gfPWaQL2wUx8iT6bX9Tu6
	LeRX
X-Received: by 2002:a05:690c:9d:b0:7bd:a6ea:c4f0 with SMTP id
 00721157ae682-7bdf5d9900fmr201868697b3.1.1778379175389; Sat, 09 May 2026
 19:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509090320.85481-1-dennylin0707@gmail.com>
 <CAKqfh0F+rAqAwdu=BtagPa2D-F-TANm8Tx3RCOoLyZXkYAn2pg@mail.gmail.com> <CAGEkeHcqG2_c7Ls_=ZMkKfR_MpSNiuRO5d159oWfuN_A6qNEoA@mail.gmail.com>
In-Reply-To: <CAGEkeHcqG2_c7Ls_=ZMkKfR_MpSNiuRO5d159oWfuN_A6qNEoA@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 9 May 2026 21:12:44 -0500
X-Gm-Features: AVHnY4LMH6WvX4zqy0BvUavMS7RDKEzSzDKDYvu3-Nxe1FV8HgIar59z8ZP1SfY
Message-ID: <CAKqfh0G+vLjOHhpVi_CC_eWmEfw26ZW71ptRA1WKAhmY9HJJJA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: addac: adt7316: check SPI write errors
 in probe
To: Denny Lin <dennylin0707@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 9:00=E2=80=AFPM Denny Lin <dennylin0707@gmail.com> w=
rote:
>
> Hi Nuno, Maxwell,
>
> Thanks for the feedback.
>
> I agree that just warning is not very useful, and we should bail out on
> errors if we check them. However, I currently cannot test the failure
> case and I'm not sure how the device behaves if the switching sequence
> is interrupted.
>
> I've reached out to Analog Devices to clarify this. For now, I think it's
> safer not to change the behavior until we have confirmation.
>
> I'll follow up once I have more information.
>
> Thanks,
> Hungyu
>

Two things. One, please don't top-post, and two, from what I've heard
the switching sequence tends to be very error-prone since (I think)
we're essentially spamming the bus with spi data while we're still in
i2c mode, so we may want to ignore error codes anyways. Just a
heads-up.

best regards,
max
