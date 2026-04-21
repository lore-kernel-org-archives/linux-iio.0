Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D709377ECA
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789527; cv=pass; b=jvbGJKeOlaDgrZiuiMK9UkxrVOA23f2Oyd5xIerBeaxbvR3ztjKYF7FBVgaamdJ6c4y7DnoHS4dA4OZYs0iTGnXS5N7sEBDbgUp8jj5HqCG/IyDwWhsDYhKT9PwqbZsxkfSb6msaCKbWEhcpwmzRId/ZB0rKuE5gWb3NhZoN6yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789527; c=relaxed/simple;
	bh=ZJSEOOHCk2dT7LKocvL7+bfdrxyrbrG/jZbdDCyTHlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlQ1F0ZbTQmDSox1iH6CmItBDiz1bXwJ2ba3sccvfV2gkCpuB6voSE3FXLooW97qBkUINP4RShetclTtUkGcq0n59Qrxz1FCaku5x8636016lIovWm1IaFFNBG+WJBKE36fQmp0AhI63XYsp8dpMGE7CDb+fd89iomky4nTU69o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbgvHQjF; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbgvHQjF"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65318dafbcbso4431690d50.2
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 09:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776789525; cv=none;
        d=google.com; s=arc-20240605;
        b=K/1YUPyn86TT+Kce5LWTUVwc72ZxFbDMKZzJHDTqKhj1T9lPms4RYER51rvxGR84ts
         LzIId3xg65eiluj/VjrbbqQTwp4/ESCPn8/ONWS+XlnsJ5uwqWbDdwCy4BTHM0VLW9jr
         vKV70A2GUpEyWlfDTKCqEQJvWPtmo6Raqkqj67yKMeoWWaTK6o2HDqRz1bnfruEBf8OV
         tycFrs3tZCkaznErxwlxhm1uo4PkPYXaiO8p86R9Du/eitxUsuIi6fPQMxrBiJHd0s2h
         9jn0AsdKxmjOgjd1mMLbfqM2dvQZ8q5XWr/kFXyopjHB/xewJxpFsebfrJymIKDbMaAA
         mmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rr/xePsNro1Lnu5d1y/IC7C70vqvxpV/l3qzvyXji94=;
        fh=dOMBPe5KvBVNNL4+9NL4LHo+tEKfvTivBH5J8aVDCCE=;
        b=U9Zhw07FcDS5lFbH5I2cIVO6B6A0t+ogKUSvPKvvXVNVkqK5dTUYH+lRfFX579hMct
         4AMpixEp8HmOt2365kUUjfZPzGfkWYDzDP7CLAwQ50tFN0DQlMofMo22f2+zxcBbnkeF
         QW2MBqLD4StRVSAHlDZenm+vbr+jwhhZ6wV/3LpqmZiwuRDe6T39/NMeIaozecBGHPT6
         C8u7Of1cxIEJayQN1vCLeonYJzIxoK7X4MEImj1/FC5DIyYE748808FGpO6x3pqbBgPo
         gOYOXXUlUHuC+tCoLGb1dV0vTX5EJxuFuz4sCjrvkTN/FU7uPzByPziWmpFvc2p7q2Kl
         YEyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776789525; x=1777394325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr/xePsNro1Lnu5d1y/IC7C70vqvxpV/l3qzvyXji94=;
        b=rbgvHQjF3/x3SgiDDBc79CwchtQL1aBFr1sYEdNrPjdw9o+Z7eRqbnxY0XQsEJjK5r
         rlsAuN/7Kte1IUTE3IXT6SG4GcGZ4fG/G1kfPVc1hKr+Jh2akiCcZH6FLaIPC4+IeYfO
         bfIdcCivZcrWufuOv4+G1SHyMC0EVZlfQqjR2uWsU5VXt5hjYZKeiLyS+SKP+iLmPB3x
         ZLmiIfcPIAE/3VHBylqp0fQwCXxFLbyfaEZYrk+UIfa926mPKviksEOGd0N2E2vs77n8
         6fJ7plyMbt5mZpV3v5WYJJwheXYvYZa331kLk1Pp/0aNb0mZT8ECQ72QFQ/YYVdyx3QF
         r7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776789525; x=1777394325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rr/xePsNro1Lnu5d1y/IC7C70vqvxpV/l3qzvyXji94=;
        b=rgbKga3S55AQ8Gc97tUR5xTbeFbHKoauW9+HJDQORcr4aBSyC5biBKCYz2mI6d6sFc
         yHMK+1T0InLnr3f5tnz1YjcpGG481e6j1TJPWQMmtuBT8hshmpJTNn2znKIHwBZiYzFM
         2x7Gd7L5pHOl+eNG5hhxwQ308IvjY7xn2hhCj/mRy49rnM98JktnHeyNgQlQDTbqYv4I
         L5b/IVF2TVvGjrZItvnrmtoJ3DPvRvJS5aZBnOS/s4d7WU4PcOa55292jLkUGMEwK8TN
         Rm4No7DCiAgIxUZZAJE2wDa4g/Fu0GHA6h89xcLoqlL6eix+MUqDc8l1ZkF1AOXf5LPC
         WqSA==
X-Forwarded-Encrypted: i=1; AFNElJ8/RfexJuC0I65665iO9Ar7F3g5djR2PC366RVwWDz88QVutJzZL6c7i+OlUzFWml0R/NXi3CzfSpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGZ5t1zFfnI/dZQ59NLTUZo26f3DJJEuqn6AV/qbqqRN/8GqC
	ILKjJOrYv0feBCa4r1wFKYFuH6xSeR2NrsH+I2BkIf1ToAzzEuz+5H94wMgU0HhrJKfduaJOgVA
	7CxoCRLXb2Yq9T/szEAofnNr8sHWwIzc=
X-Gm-Gg: AeBDiev49TJaSMNFBTw8j77aek3pzh5gDYUxxT+Dztt2AQsdffD/oxAt0cOdsdqJn/A
	VIfW2k4jX/FbRirQDu++KLG4anmlc4MVUWMTEC6P/3alDHyFoOiD9K77MTDgeWCk3gtdjdEkWsH
	mt0TgFRGIzfiPSbEAiEskiDIbSDDJPy/VAMNwp1KR9yrAG+2JT5e0+Kme3IVpjZ8kpCl6t8sBvx
	/jD20T0Tm6ff8l5kRGH1H+eFtOVEP/at6gVEffwl/0QSJNc9zEX8Ne54zVPMeNq8TnloFKz2wcU
	hFjcUJrHT+kDcQduD3um
X-Received: by 2002:a05:690e:1c6:b0:651:cd6b:8e59 with SMTP id
 956f58d0204a3-65310b2583dmr13303736d50.62.1776789525214; Tue, 21 Apr 2026
 09:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420230813.25985-1-m32285159@gmail.com> <20260421154201.041f03c5@jic23-huawei>
In-Reply-To: <20260421154201.041f03c5@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 21 Apr 2026 11:38:34 -0500
X-Gm-Features: AQROBzCJP2Lvkhr29ItBie-rUf6TrdFv5ifC1cow_2_gynIrH4HtT9O232fiPYY
Message-ID: <CAKqfh0F+6URvDhtjkrBnsSMqnOBLsjVCbAFZL+=QTg49UK17kg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: proximity: srf08: replace sprintf() with sysfs_emit()
To: Jonathan Cameron <jic23@kernel.org>
Cc: ak@it-klinger.de, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 9:42=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> Not true unfortunately. Now broken differently.
>
> Should be:
>         return sysfs_emit(buf, "%d.%03d\n",
>                           data->range_mm / 1000, data->range_mm % 1000);
> Or
>         return sysfs_emit(buf, "%d.%03d\n", data->range_mm / 1000,
>                           data->range_mm % 1000);
>

Sorry, still figuring out the indenting for the multi-line parameter lists.
I'll get that fixed in a v4 once I've got free time.

best regards,
maxwell
