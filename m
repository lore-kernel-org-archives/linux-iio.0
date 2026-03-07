Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF751E4BE
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772868104; cv=pass; b=DPUEQ2VW/vveCAolvziajyVWtxQRs4RoTLmPdkmDaWxHvbJHCNwt3G6zzQtKW/G+8nl/x5zpJRWJEy4YfQ6/BFBKGTb/BG4vus8c4xNqvAtocSCR6zrzWfAno+RDvDsvzuzCgSDSOhlBjBnwpwZiqRXX7M3xttK0h7JY/l58hWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772868104; c=relaxed/simple;
	bh=IZJCfVMJLtgnwOd5cUMh+o634dKOuSMmYzwmkF1GQDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jqov8HpRD0jxxOHvaTDGjIP8zjdFjl3BIftCOtxMzpn4ED3fG7cHraSO7I0BBuEcoNDC8K/hpV8EWh8Maz6ZvfvKOPclPBUEky/yEfcCE5jX2PP59btYcl6fKkUOyeYEKmSRRguMfoEHlrWR3BjrAAHJm1LHgkI7wDQL/f+gNZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbMnAtqw; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbMnAtqw"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649d589ab0fso1055152d50.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 23:21:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772868102; cv=none;
        d=google.com; s=arc-20240605;
        b=kCrGwsrENXwWsv6/64bpy1Cqr0Qw94qlDAu9hlrhXERKSwj4N2EDK9WtZoMjN+ru4+
         Jo+Y/kC5QADGg2Np2Caw+hdMQZsZmIy6J6F3QV/ChmUblstT+V7er6R6bWfQ9JYJoYkS
         IgkOecRMgDHjGVUExUL5QMugCwxrjEfpuX1hrV8Sa4ZDL59FwySp+Fj1GKuhDQK9x7U+
         9P+/aWsd5WRp/fNT+zD/zPAz+HpLRncXf5TcHy4O23zzTQNItuGrzyQxuggvGkc2wNkB
         3fTSgde9YD7CO6uzVO2fTqdZBJHcrEt+VjQEPHr4pUlPRfqg7f2WPCrmelH652hpENPi
         krww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LNX5mLuFF0YnnE8Spp3u7nKCiT57MyypCy3pSp8rViE=;
        fh=6n/v3hF0dangtlRD9FfUwuZiAVxqgWSz2HjEUnCzFDw=;
        b=VySIJpMCb9/EI40ZKqzxk91wLTr+aeIrlHiKcKJpENae4CdjBuRMiWdNhFw8gJVzKM
         chv/ZqTf6BD2cFC/gmGOxI23E1njpqf3aVGrGHX+WmFh+yQhnz+EvJAu+19y5aumdl/T
         c8Dhw+iIjsmCiNQSlD5UCYMeLFnujEa48X/ngv21V9qAAZ/uop2EUZuG8A2v/3QSNT/v
         duM+wHccTO71pp2RtlYpBdIqssu1rz/Q9frKuF9V8S8V0sH7mG/VEV3iwTBnJ4Ycw7T9
         A1dYx/Z9r96I6SZTI0ePmMujUPFn9AhSCKh3xnSJoeqPjG8kGMX/2lVzXkjhtwJ+gDS+
         BfbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772868102; x=1773472902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNX5mLuFF0YnnE8Spp3u7nKCiT57MyypCy3pSp8rViE=;
        b=FbMnAtqwqLFul5J24fhJe5K33El+lMe3tagiMFhFxx8Whj7vVGKeVxCwMyRl8+DUF3
         GjiTUSHjOHS+j7257zY68hGjtNw/xSMyTlviAxQkpEjpdUN1+bkrea+VnU9rXASL/AsB
         Zyr460kGC2zEWvuSCCmikgse/cr6nSHN6+eR7tI+2RB+tl8cVz5xhTQYi/+wV6B03Z80
         uAe+AwcnhR3i6pHo/i0E1xpt94gRy6o8h8wCne33DvUUITfpl3kmaymk3lFezmsHaRs0
         ZtoZca6iQ3Te1h5QIfvJKSeHLuR3oYCsGWpvnwajIm728liBkKF/c2vzg/0dfRPT/L44
         xvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772868102; x=1773472902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LNX5mLuFF0YnnE8Spp3u7nKCiT57MyypCy3pSp8rViE=;
        b=lfYenmMaEpxsJFzuXCsFCKGNJZWGENBDXb4iPFdi9lojrx/y2G5eUJpVhiEdSwxiuS
         Ti22CZRTL5fL3WYLeTO9A+V63O0dJr6GAqVI0L4iPJpgQiPs4IbqvR47UMzlZSQSkDu9
         qJqiRxCUUO/nvMta7dA/O4zL4RL8scfRk5LXOAZyWc0CNIJc+5iK69LzIRh8fBklXYYL
         cQQd2MmCS27obG+Vn2SWyfId1jA+BWm5R4bVM6Dh0Dk81gpwIHOl7GC3ogp0RljUbsX2
         JXd+xTiVnTgDls8DNMaOo950p5c5VsWef6eje/cvUj7AOajLHw9/24DoHTiNdtX4qqP9
         HrSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVoqQTz8G7Oc77ngIW/SQmwECzMaANL6Ays2wveYo/mdMDjiOrjpnSegt2fz6bkqB5GqHC7njGCxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Smq2eYimgZrcxJyehKHfTk6TkbxGIPhaBrCRU6O8mj1XfNIF
	9/Dv7AZUyRgTJAJkndBQ5aSSV8DYIHpemTqftRDvtaJ873uljz3KfL3lT74CEnCBJDM7gpJpALQ
	McCE8ulPk6ORN1pFqUKX18eAlOtUE0as=
X-Gm-Gg: ATEYQzwhNPltABjgYS7Tbbr2ZU89Wqz38LqhFUzckja4JTbymcqzQQZt5Rqi/nzeZLs
	iqoZqFb08q/YV8lMxQmWRXmXoG84up9nmV7zdts0ESuRL9cehYEy6HVgOSGsfvbvlySPbjCg9FX
	YfRrspKmSSxSXlQ3uU9GEFZNsLsM3OaMDIaxUmqM5dBc8aKoHQWEmGAKQvDPID14mj3R4ypD332
	xwo6LMayX2x+mF+XmacFyx2akP9ezzNNgdJQ1XuNmuNcqfltLANe2TdRPh7z2A1++6hPuB1wlg2
	Bz6ILcM9APbWMguPmS/DubYt9aVScN6i/gEIcU8TLCH572fAiMs3xNFUKv2Y2Q6PiTOfTKCrscx
	QzUx26ER5BLxDTbaKbGvDNw==
X-Received: by 2002:a05:690e:419c:b0:64c:faa9:4261 with SMTP id
 956f58d0204a3-64d14297552mr3914102d50.5.1772868102151; Fri, 06 Mar 2026
 23:21:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306134332.746728-5-giorgitchankvetadze1997@gmail.com> <8a3f7f55-8d76-476b-9768-5c5a3c4a570e@baylibre.com>
In-Reply-To: <8a3f7f55-8d76-476b-9768-5c5a3c4a570e@baylibre.com>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Sat, 7 Mar 2026 11:21:31 +0400
X-Gm-Features: AaiRm516XKHfebjXzgUMKgBwnWwyuDTBF42fki9TINEG14AYs37t0yBC_pDsoZA
Message-ID: <CAE7dp2q+YJSkh+NK=Oh=NNfvZM6CxwRoQuhh-paHo9xwq5fA6A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: max1363: Fix leading space indentation
To: David Lechner <dlechner@baylibre.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 6:40=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
> >  enum { max1361,
>
> We should also move max1361 to a new line if we are cleaning this up.
>
>
> >  };
> >
> >  static const int max1363_monitor_speeds[] =3D { 133000, 665000, 33300,=
 16600,
>
>
> And would be nice to move these values to a new line too to keep the styl=
e
> consistent.
>

Thanks Andy and David for the review.

I've addressed the comments and sent a v2 of the patch.

Giorgi
