Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365348C41E
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573569; cv=pass; b=mbowE10rnmncVUQn9IVk43sJ7Gc7yPyaUS6Kwkh9Sa7Us5pTjOYObjq3DyMBkxrFE1/dTRyN4tWcQdM5NYR/cceXidjKJOEgkgxaQsyLHTGMWFHzoVVw4bZW3Ha06laReE+vIsROy+mIW94BrlWbw/ZJFQ1IgP7BjCId7mNE+GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573569; c=relaxed/simple;
	bh=sGH+NCmWPRca5JfbIyaIsuTGu3IucXGsdcBDVqBzJHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJa/RjLBe1gcElaT9KYP70uoPTcfxdr6lX05tVgO4ucelyAuQ+j63HZCx+dKAGV/K4z6tbbEk58J6DugFqnuMjctbYUWnDITvEQ3ePUOsnqC1lchxiaKsZ+nmNeuzt/5TzPZhcQTir7/eUtc5eeoJXwiZdglhg3NdwNC/lWBok8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgGi1at5; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgGi1at5"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44e1860558fso3345791f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 01:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778573567; cv=none;
        d=google.com; s=arc-20240605;
        b=SdKC1dWfCIOxiix7Z01XLSgf3CGIFPHdsRHfrEHA6Sck2QsHdRQGuA6rqBI9YDMOXF
         X8G1CqExaBKIBwye/M4rPoRPc8C5DKaI0GbaS1p5g43Wj4DMDwmhSP9iYYcLfRvev+PG
         ZXKkc7BjHYluDbFyhy6T2XukSPlKbW9Giy47l+/VKg0T/Q1cO7eLdP8V1zOoPZbNH3Ms
         EJ5qwW36DyVXVBjqnfwF5TYYJqEk0Z34FaN0yvda8BgnWkwUx9/nNY3Pxtd1ZKkAajMX
         1WXjgzfUHUClyTk9mOB149RLvmyvdnJI0mC1kjT7xEfJxR2IWxMlOCFXwuE8TcPgnYdY
         BLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sGH+NCmWPRca5JfbIyaIsuTGu3IucXGsdcBDVqBzJHg=;
        fh=fqrL4b31USDTPTMdd+7yWmiVtya8JrtAI8HTC79sDzE=;
        b=Oft6Dz8+2uXdNUjRubsw7b0rxoH+hZ8b/6ujJ1inx8F4J9Py0PIujcwGKsnOuEM1J1
         /Pgdc5pdwYPaUFABlTjh4lbDjZz2UlA/g/ZxGxrwxsvYw8U4T7SCOm8iYfJ6gviULi0p
         8sVIontI90qkERUI/cn9ylGQ6RFfiL2Q9HaT4ojeHAU7L2pBKiBosw6wlaKGzhVDFGBb
         LBWZoXf1Y6Yl+MB7phpFjeocPSWcu9NWQTkQpmdhDl+a9kPebYetJi8JQfWiasGEKMJI
         2IbMJP8BxZWGuOYzplsiXEHap5EyDYIpoUXEL39RrnN/RGt5ud0i/MVcx3dQmZeH6zlI
         rRIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778573567; x=1779178367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGH+NCmWPRca5JfbIyaIsuTGu3IucXGsdcBDVqBzJHg=;
        b=NgGi1at5tGI5Tgwk5fvjcHKhUcATpIiGLq1QrJEBSeBUJqoxU8HRH9DJb2AGWftbDP
         dOJokdBjryJDa64ow7p+ZMBQkoQFT+//mhm1zVTB3KdoYgr+x1e38Gh6IbfZWqrIArnX
         WnfirSjlqsHQ88qOjcOmySCxQnIymmu/jr+O4zx2Zj3Wj2OdFIbIVxjKYGDXlcldbpr6
         BA/Dy07rmeki61GjWDyF7idi5PC6rVFnP+zld1hAcUWuSLG+M2DbibCvooUmNuHwXHp/
         fBlNrRU+baKbdjnC6SdSwX0YezXl1mRSB1FH3M6aKVswKYLbWruwc3HS/e15qvjmA3TP
         8beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573567; x=1779178367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sGH+NCmWPRca5JfbIyaIsuTGu3IucXGsdcBDVqBzJHg=;
        b=OZ3HEyriGMUbt7zgAbBGe3/sQcDMbJ+F1gRbFWD1p5igzW/aREZINeoOU+p6EQOzC5
         p5Nbz7yICoYRFYu/jnchWmSyVWHXSwm/zPsZNQctH1+myMz7IpOrhFT8pQrTW6gISdQ+
         XfCy8Np2hQP4eNKSRE1va/ECH3nBQelQsdLKama+4iFAFRZnTbACTMfk3gWYQ7at9HWU
         t938qkDHosDh3t8Y/QMY0GJHgTAf3aqIW+E+9N15umxoszh7uy9NsSLpJ8kZUF+i20UY
         FT7TH8Uar6Ud3bcugfaaul3s37jMHNf7H/RkF1eY6/yRd9gBH2D8HFKQhzK391EKzt3P
         kHRw==
X-Forwarded-Encrypted: i=1; AFNElJ8YiPIiJ8+LqGRSU8cB27/B3BZWDXkVmpwUZZIZwtkj4mGQJiQipPwabwTqlbN+Cvjr4Ke03ejBgDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3xuw+XE8Xz+cZzISdz0DLmULkX9ZvcNafxHENXmK49dZLTXkb
	zwfqk743k5GoEaHfdtj06VY2V/n3yxxV2fUrJb+W/fKbIYKXZUKummYnn91bVvp1g+9AJMNlSTa
	A8yuqZi/pbGBDJRvLDAkK2lClEkbtRC0=
X-Gm-Gg: Acq92OGBU9WEI5abRtoYkaTmdH0UBmtadQvhxYY/rxii8YuW0JzoP0WtSg643EuKnBL
	3xYqWEJAA2xd07PGKsb9XpcMUP7Ls7cLShdp2gtDQZzpdZ6gH/KlXrHsSSs8EcacFE5GtiGPU3U
	iFeK71UKx3HH4Acbgl0MPzs67AWpQkxeWUtO6aXNuqPntu+lmU+IRG+V4Jc2ihNrbUsONi5aH/j
	HHaNdzqAKTNupl3TfJwpxx9aa3ahH9AxF8dRSFJ5psDeP2fO4N/fY+6XwgKrFTdSHJxPVWedqST
	G4S1Mu+So06nxxmsZsuqlFQGX27ljS0KSi9CR4iWoq2tzOcPXLN0SdT9v5egV4vaANAi+eyYSu1
	dFPX01VGyLf9mSVFuHWU64PwZO67X6Wr8992YPqlnM00DjySMpuWxA9I9/FQkPyriDeO25YYk4I
	FNqUmIK/rgeubkUGOX
X-Received: by 2002:a05:6000:4013:b0:43d:6787:9934 with SMTP id
 ffacd0b85a97d-45460e3f3d6mr26899381f8f.9.1778573566511; Tue, 12 May 2026
 01:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
 <0a3e455c86cef14fe3481019031ebf04f98470f7.camel@gmail.com>
 <CALoEA-x9TtnWbGCtTo-jhrJ7Zic1S7J=xRYSL0VZgOvTb1GGCA@mail.gmail.com> <agLd7t10HBjbEzYq@nsa>
In-Reply-To: <agLd7t10HBjbEzYq@nsa>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 12 May 2026 10:12:35 +0200
X-Gm-Features: AVHnY4KsWBXuUr9abznGcg5cjULx-jih10w5H0YiQMeFMTxOaIK__m5c2U7uMjg
Message-ID: <CALoEA-zJTJ1nA7-7nyeMnF7m87utM8SZvTBcMOY6kibZPA4-hg@mail.gmail.com>
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed resources
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 at 10:06, Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > This is to prevent a resource leak. If we register the power_off
> > function at the end,
> > any potential probe() failures will leave the regulators on.
>
> Okay it does make sense! I now see the action is registered after
> ak8975_power_on() which what makes sense. Still would like to avoid that
> weird pm_runtime_set_active() call. It would be nice if we could
> guarantee through PM that the device get's suspended on unbind. Oh well,
> I guess this is ok.

FYI, there is a new version where I addressed some of your comments.

https://lore.kernel.org/linux-iio/20260511-magnetometer-fixes-post-pickup-v=
7-3-9d910faa28b6@gmail.com/T/#u

--=20
Kind regards

CJD
