Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1573C33D6FD
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797259; cv=pass; b=aIcb5MrIbPvsHnDENO+9bAYSmSfARdngmI2jaWTGKFNKLGkcxKsIV2W3B/zDoMB57WOo6wACOYRah8AG/J8evyEmRSqKXkhRREFYQtewMMMTcw3U9VUwsud3jzoihLzPCw3uXMwOqztCYfWIrY0ml7LgWaHnZIynbrTgFpasoGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797259; c=relaxed/simple;
	bh=bH0s3I8uAjVhRbt+5kOsWPBwDSe0CzGUOsqb48H4IN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJHsa9MEgFaZ28RySOQIGRrdzkgx7g5nGpi5Jpvihn5EC1d4x2T/TMHw2XXd9fjIGvQhiStmsWTGybVXWIxkgfAU+LnF2egdIxdgaeO9nKfbm8pJd9nhHFKnjIB/v/iljA2d+EJjDYWnLbXZFlEEuotH/3TF/uU6TCDnBUnvVz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VywOGo7o; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VywOGo7o"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-662d484ff3bso1367361d50.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 08:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781797257; cv=none;
        d=google.com; s=arc-20240605;
        b=c/1+zzhxO92EARq5+qivbMDhFTK/ywZrQOXJaysXcxdXEtmTakgEhKD4F+tanH/1re
         0OOQ0QYEXutLo1mLOIPOFyPWrm51nEiu4+xAR8UO5x5XyZFPovEOcWxbWXyk4mv/WQgA
         0NSLNLh2lohX403/3IqFFFWPfYqVjnL4l9sjXdFfllhK8cDc4GeyBcrkpnAE+Q0uc4ZC
         9nmUxxN8kuTRK4XS4c8e4d3LUPYt/yTGXWlQi5rVtKO8jzXns5yGDQICTOBjmiO+GT+F
         ZjiFZMBM5RlmWHsCUTxTlgvlRpcosUf3ovjVpW7EA10/Ws1Ts/yWEEwM7pOEnxFYWDHy
         FJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QUnKFAun+VZ1ihCAo+ffngmMr2gsAu1etA0aeXeUDe8=;
        fh=KiUUM9CIhRifUOz7koPtX1UbprkeRTyYIY3TUz+TBew=;
        b=WfjRNxrreJ5RIu2pM5HCrGjFpZvioA7a6OIky7zqanPF6unC29AQhRst35BrY7D4N3
         oGFITJInIp5R+GEeFwTbVhumn/XAAX4FirOoI8p1GZJ1yTy0NstdczdAdLHGNRKmL2eN
         v6rY9VMLPWIqS/SgHwuKDrMXNHm1NRv1xxP2bvsk5jUe23tzgfj8XG6/qiZiQbLbcaXU
         OGa0e3mRBkR7KDpOyTur0/LRF3aIYyOMyjZjzWzm5Ne0Y9TRQKqcVvz5nLLRMlDz/Wr6
         PGiNITu0OstzxSazmdNmE8J4Gz+Blkd0SljTnSLk2a2aEE/REbe4bTO068Ram9Ojyj6/
         yDfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781797257; x=1782402057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUnKFAun+VZ1ihCAo+ffngmMr2gsAu1etA0aeXeUDe8=;
        b=VywOGo7oXHU0yxHm3qs351s+7t4XKkK9Ih5EqvYFgeLbwQOPPjZBGNkZOjYSdwPflW
         cC7FjMnsqYaafpydB+jUcpQYcOdz8RHDIDnvxrSoR0klobJvzN7zr25NsBrmk4QqAdr6
         RwJki2Kq28viWlsqgGi789e9037gfujsLSiBPBP2MxTSRJjF7g6juaEi4MRIvclEpdra
         mdaBKYQ6FAMSKl2dVS3Eq8ts93r0UZBOecrwtpAs1ihRe8S6+0wmGJM6CcnjCESthY6f
         vUSSjGPNI2Y5zecgA6Cx59s9BU4NxXskhyHJdUMIVjyNG6ovGVvs4/G958sAXGlUbi0j
         CeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781797257; x=1782402057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUnKFAun+VZ1ihCAo+ffngmMr2gsAu1etA0aeXeUDe8=;
        b=jEUPoEogjxuFHQwhEGxz00vYZbmVVbP95v5hnb/ySfMDGB3BkwLkd0hYhrPy37VTRr
         VlC+P/jA/yX+zEK8PBH1zZptRdrPQAhzFHrqVG5RidEM1nd2hojtXSETffVS6p7uxmHi
         3Ieiqzsp1dbsV8bMYFD1rVA6S4qKJH+MTRIbNlFnKpmsO22jDJkTFza6di6dUE+sdsYm
         LjJMtBR1DcTl4p+VtZwoBG0zh6tqEiop8Uqnspdu1ekQgda67I1W7cgkco8iiG5T8crB
         /Y2THQn1N5Wzn0fMAFyYM471am912vWGx+dujMkEEn8tvnwuCJT1fXYQiy/ICuvtvSCZ
         d2nw==
X-Forwarded-Encrypted: i=1; AFNElJ9UosRN5Q35VFj7eKbEa6PqjvW8F0KDkGIljB/8Caf3HjOEYB9W37+9+dShd/x6Z4xb233Al1maJs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyh7dZGHVDrg+fh6AXS6YdFj8ZHdyvE4nsSuoWFqEvpaJBXg2t
	gnJD9Blld/JbrCwdFZd8GLU28RHupjWkkoli3B3/docc9aLByJU7Sca5vVhXJWFbkCNDavF3G9S
	BGblvJ9SuXDZ2cEGOUWmFpcsIzxY/hkIqDhov
X-Gm-Gg: AfdE7clhiSBEo6hDoNpnt5DAF9sfbKVRrnWxazthscKPb/ChNxRyq1NkQQWjvKA1HMs
	RTsxZCd+0FEa6P3OvjrXqc4xOm28b8kPoRWg6BLoZScmtA66rdoy/oiVyVm6liZKfOU4YWtgxxr
	5qwFj9Obt8hUF/M/MFxxQyk1uN67C10iqnXGgUI7Cui6n9PeYWAgzsrNQ5Ly6DeB+T3hokKGNED
	9dc3Cszc8Pv6MUnPfh60p5vvbc383LMPUHEF1T+RMN7auXyzpjERBmNTCaW+Ku/OWm/7g==
X-Received: by 2002:a05:690e:4295:20b0:662:dbac:87d0 with SMTP id
 956f58d0204a3-662fc9be1c7mr123728d50.27.1781797257094; Thu, 18 Jun 2026
 08:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617172138.114572-1-tduszyns@gmail.com>
In-Reply-To: <20260617172138.114572-1-tduszyns@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 18 Jun 2026 10:40:45 -0500
X-Gm-Features: AVVi8Cd9u28JhNGdjIPuaLGGCVAwBR8w0ehXTLJQ0QNY3kALa3gkROOg3MaETFM
Message-ID: <CAKqfh0FgB0v8i81_oTcdfvQMqXHpx9sUY4txcz8oeMMDoMPtYw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] iio: chemical: sps30, scd30
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com, 
	jic23@kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 12:22=E2=80=AFPM Tomasz Duszynski <tduszyns@gmail.c=
om> wrote:
>
> This series replaces old email addresses with a current one to
> make sure changes show up in my mailbox.
>
> v2:
> - add missing mailmap entry
>
> Tomasz Duszynski (2):
>   iio: chemical: sps30: update email
>   iio: chemical: scd30: update email
>

Even though you were the previous maintainer I should probably still
ack this for the scd30 for good measure, so for scd30 patches:

Acked-by: Maxwell Doose <m32285159@gmail.com>

--=20
best regards,
max
