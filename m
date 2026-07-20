Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887328726E
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514428; cv=pass; b=fhBlV1rqy3KDMuymBCirEsZZBaCDxSH8uJKu/8WXN+NhMZAdW4wlONF1dnbqfqS7JaF5IcjNbzjTc34aLWY0PQuL4g3LWlCTyfsAvyF1SdVpN0GvQiPEiQGo6zH7s/tFxdEkrRaXQbAe8x/nhD4u3KsG/y3pz85BJt4CIKNW8x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514428; c=relaxed/simple;
	bh=gyoYwJn9c0nIEAroGsaLZs4irS+9OiiRd+4yaMN/EaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISJdBt0QG3BTYij9rjoPACdO3Cc6ZKe2aqVz1QWwFGRF1A817m9vWw9bIYDOM6Tp3tUuoOlKbVsIBlVZoaQMgiR9D3Zocn2CHSH37LWoYbIrRRdKBMQihcoU36bPHDVqNKKDUCjAR1BKxGvaCw6R63aTom9jeS5YNeC+AReUIYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sag5U6OH; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sag5U6OH"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39db07589caso52414471fa.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 19:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784514425; cv=none;
        d=google.com; s=arc-20260327;
        b=T6KulO7xF0t6w27z7V2pFPWgmC7I9IKhUixufXqUXiTKIRpRmqU+bEMr5J5C9CRpiR
         hPSA8F+/JcATPuKy7EvQkz+CNv/fh54XgX7fgVdTcR/ppNl6UUSB8pnp3GX7whvD4DXv
         /GGzOFD1V+zvPCAUSumYx4CT8rOMeQumJH68Npa4twp+C1TqU9ygwDg+547ZKAh7oY8A
         MX4ytS5/RlIe6ubJXA37n0xhU6C18cE1UpIztKUDzKcV8Kj0M0rR5OcngVNCfEZAA52N
         wWsbESA3lzJ9VEF5gb07v9KM3dGnVE6zoqwSQ7F/xJsQfvEQC15yl0Wkus+w41p4Pghh
         vuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gyoYwJn9c0nIEAroGsaLZs4irS+9OiiRd+4yaMN/EaQ=;
        fh=6jza20OHSZEhvj9caf+G2XWrvJIIKTpu3jvPLiG5Ldw=;
        b=W0MoG++Aq13ogmEpl84HUFuxPO9v8EhK8CJXOS/2FcAycwQBVC0jeXt7q1qvBJQjpB
         uE6cIVUrDZAYGvW6Hx0lPrZcMRa6qO5gRW85QEr2F2P0W5h272AowSnayexVqrnkt+bZ
         vX9nwJiplTdZfYYgRRIMQHKb5QKGgD6jutUQM+UFR/o2Ieqoopd18mLn4qtGkoa3frUu
         JJoVjaUa+SKF/hYziy0rWIHdS+QT67X20xyG2id0jFYGKYxHfQcuvYdRGO3N8OpaIeZl
         pW8hBRIDoMXX5mohTB+1PaTZTBZNS74GdL8kvnLYtodePxP+9oU5egtaSUK3hPuCNbuc
         6ygQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784514425; x=1785119225; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gyoYwJn9c0nIEAroGsaLZs4irS+9OiiRd+4yaMN/EaQ=;
        b=sag5U6OH4q0P0q5ooSAcQc6LPEyYvrOn09iZrhEQtS9NnZQqKFeDdHy5XHREGFmnHv
         6Pg8CPBQVj3mlDqBfuROOKxiPMvpWXMv9mxKqp1TdDkGQCqI80zEX6CIT6hNKcdEQtcK
         oqlZcDYCZT3jkKDsmbv0J/PmVqrrNaBh9rUb+qi/kgeUGwnMgJ4sQVgUj0ABH4L1AyfU
         gkz6RbihZ0vPKOzTCkZFdbVUwtVpH/WDeoT9WkiCHqG9qEQOyD0P9y95ZaR1QiEpW/DP
         PwJCiA6zH4piJ2XNiwkfEHJNKgRcfFsnoeLdioIAZkqLJgoWPphtJ67U5h820fYpRgx/
         JE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784514425; x=1785119225;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gyoYwJn9c0nIEAroGsaLZs4irS+9OiiRd+4yaMN/EaQ=;
        b=p0hRKjsLM5bHkz9B4ny84UgY0pwmNhC28/FlqyVYW2+JAx7bR1RP7nvXCqMi0WwF43
         QjIKkEDa0vCT0mN9gKRdU0AuPJO/z/VrODo2y2J7oBc1vgE46VNoYuWpt7fX8i57zhk2
         Td/qAuA9eTV69Of8B3aq3CTaPtmzfjrtWuJZxLHFzMbLdqVtC1U9gqacmQrYuxPRvRoN
         lgyGiJ8j1ZXUDmix+ZFpqybxt/a1W6IYl7DW2dAE6qrDYfeT9wvFaQTzWVHDS2VRyBzr
         ydTbv1PDZ/v3Fga25QhibobJ95gWhMx7taNrgaSWEmPvBTgPhgOw6ddjsRzAyKXzU/kw
         wO+g==
X-Forwarded-Encrypted: i=1; AHgh+RqUa47mMcJn0sMEA+De3Wc/vfGTyhDZp8k/B+jDh4nO9e6o0bdCxySaFSLoSvohn25CUeF7dL/jiqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXqyYpH7qgScjl99221EC3vjtDNjBHYU/mNbn5DZofmYr6tYZU
	BYjTMuUTct/k4Dvxy4VAZ3trTab51fGTeH2dNV8p54HXmatNZmL8O6wqfOL+nlPcDIUCjP0Uiwx
	BLIdZVyk8B2U/GTBoPuRnM7ggMtAV034=
X-Gm-Gg: AfdE7cnck3Ljv/qM7d/2YA6MjlGz2CzK92p8clcsb2ufDjwQMHlkB7qlecH9TkbJ4+T
	p+0SXDlYSVAjz6QM2bdvM2g8HMCoHPpJqdb/Tatbx85rX4jZl/+u1O6ZeMY+P2LyZxaRRc8hgj4
	dztkqxcbRXZUlySXdmP1mCqCNKTYszNWLcfmPprEJoRrq/Ut7eDifVCkvQv7AHItxZDHiEz9J4m
	MjeW/7yet6zHd253VP+iMmaRqVV1GMiInIjcrp2gzBzokkDSGMeNENqzeQR16q8
X-Received: by 2002:a2e:b554:0:b0:39c:650d:2f63 with SMTP id
 38308e7fff4ca-39eb27bfd13mr16775171fa.1.1784514424490; Sun, 19 Jul 2026
 19:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-2-muchamadcoirulanwar@gmail.com> <178376430529.16552.7043868463863908196@linux.dev>
 <CAO26r3Ttyfqhs3_jWDFym7FpswqFW4-UA8p1pQBcuWzDGGzstg@mail.gmail.com> <DK2X7WBPOPWC.TY09ODVGYUVM@kernel.org>
In-Reply-To: <DK2X7WBPOPWC.TY09ODVGYUVM@kernel.org>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Mon, 20 Jul 2026 09:26:52 +0700
X-Gm-Features: AUfX_mxO2nw8yshtd2cq0NKG1rKFw6860AP9INvd-B0IXOj42RQUBgfvJzIRFAQ
Message-ID: <CAO26r3Sv=ZZkq--POXmwh+XrAB34COL=A2Om47tnM71MTwNwjw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
To: Danilo Krummrich <dakr@kernel.org>
Cc: Igor Korotin <igor.korotin@linux.dev>, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, andi.shyti@kernel.org, 
	wsa+renesas@sang-engineering.com, ojeda@kernel.org, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 at 06:02, Danilo Krummrich <dakr@kernel.org> wrote:
> The patch series is merged in driver-core-next [1]. You can check the
> MAINTAINERS file to see how patches for certain subsystems, components and
> drivers are usually routed.
>
> If unsure you can also check the linux-next integration tree [2] which merges
> all development trees in a daily effort.

> As mentioned, I/O projections did land already. Regarding the FallibleIoCapable
> change, please feel free to pick up the diff I posted and send it as a
> prerequisite patch in your series.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/log/?h=driver-core-next
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/

Thanks Danilo. I will rebase on driver-core-next and carry
FallibleIoCapable as a prerequisite patch in v5.

Coirul
