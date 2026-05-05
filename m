Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF40C3A2546
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 04:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777956377; cv=pass; b=O1IUYyRsipFDmlXibBX8CClpbdF/Zgv1BW1X5pUjjTwOc/GQG7rkAFwzU27Ogc+GSojRO3/H3VBBnNI5Ck06WNoAWKlZzrXdXJQtAfhbil4XP0UQ79NDyjlRjyJGUuxe7CGMFg1kzGIBrKNIOJhAVRdhvUHKUNL9wUkZnDsaE5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777956377; c=relaxed/simple;
	bh=h3FaQIptBGu4OefXtirfBXoKuX3VoE1f5ESK1ihBDbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzkSIBCgdIlk2uMz/XTxTpugqznfGw1XhQK1fMETip3hVa51Pw6MQq7Us5TU9tryzRBXUBq/7bMU2tuHD8sr7AvBpBQvi+FgN2RlDWaEvnZ4XJCzsoc/Gnqpcp+CzHKZTyqyiZVjo7uemZOCMW5sMX3OSchVbZVCuHeakMRykqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeaUjhmR; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeaUjhmR"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a535e7c00so57453807b3.3
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 21:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777956375; cv=none;
        d=google.com; s=arc-20240605;
        b=Z37tExk/Jjl+/MhaIG4vTE2RM6tMzVnOENJ78Pq9QlTNx0v3bXZJSXxHt4rkhDH2QS
         h1YEpXZOEI8LGopby/xFMI1G2qetkWQ3oNp5magIp3OgwY7roy8Co9x3B09D4i/7yNDJ
         dSNs8GO+ZEbjdbLvZNUJlnS6hBCdefgqd/GWtAuBKYPuaOfSAwZ5HlkAdmrcKwTg/agy
         09twocZ8YjYBtnjZ85kS3ZDdLjJmGjqesWb22+/zrDlVaggGdEfUl6AyPh9Un3i/UfsT
         FyjTy+bw28gxrrS9PFEDUyas8y8RSF8kVL5LPast/NE7dKnmVOVQX0XGXi+drVJ2QNon
         gWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MiVayWLGAVHnuz276bVFEcNqNE0ZYQFjkAoV9bmrZYs=;
        fh=9F2bR2996cB8dyvBIssMZuEX8WKEyTYHkdmTk86wQLg=;
        b=PgXNy5nC7MsBCuUQIeabGS4nwN+gjYCnC4PFXP2SrJpgWiM7/WkIv+fWB3wYqRPMAQ
         4fah6dSkDjXjE0NY2PC8UuJdpj4MCpoTBj67mqWTXvfSar4OYrgvQlgDgsKE9l/fzbcZ
         r2WtW+Q609j4crFbdaQNZMpg+1HNWwTmRaZvwQvIa/3XF5c3wqo9+fYqcIFhef3dbhS5
         Iq2y6axIuRtX10/v06dX0Z35ve/zgxePqqMIg6Z4MjHq3/OTnh+YlVSH9VhmgiIzdcgC
         N2q5dtcoyYTdjxc47jz2D8HAOFOExaDm04TLB80MTZRjHHol6H/mXcoi+dkLfMVt+5Qf
         luaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777956375; x=1778561175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiVayWLGAVHnuz276bVFEcNqNE0ZYQFjkAoV9bmrZYs=;
        b=NeaUjhmRiAPro4Aa3O4rg+53YN2wfqPAbHxBLivUg/t49xsVpBtYMgN0nQdINoNeLs
         /28k3ck3+xsD/zy1cqVndTt0H4elqxU3QqnnPMU7K+4EdIVHsgi1R512culgXj9g5eP8
         p9dGiTh+uiey5lhqG8fhUm/FM2DEr2kRihTXi9meOw/03Xtuf/gwKUFBxKlVckgHG2Sc
         gpkiB6YvaM6NPZueHPVjZzyGpQKp2ZyDVq9YHG4auOQzUFyfgWUmysLEGKm/onXGx2cM
         MNMjQ2etUD7VVr+Wxr1MdrzvvuQroXgN3jt7p5WBK+bdqRbU+4IxzqSIbXm4HfEtyzl8
         4p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777956375; x=1778561175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MiVayWLGAVHnuz276bVFEcNqNE0ZYQFjkAoV9bmrZYs=;
        b=LspUXjJQlEKdLASVEAaBPTM3UXrlkCpMz0cbHpw99jVNcRmVaVOwp/dymdsdYDlo5C
         WembIv6oJC8lrkDItSavDjzuqWKonR5qba6LDmotXasU1anZ0dyKomIYdumcIPfKDniz
         f6FPps+YCuuiYRrDsAF+sz6UzV6F6/Bza92Xb8AXujHZ5XNgBGXWrWq8/qXrMM5VfSE8
         p8jWTDeu3oqoX+aR/i12KUcaakVgQ48xo3hJunZ5JJb9++Fjun1TWy1mtCzLx0YQ2bsQ
         rpmmAuADHH1OcBiEEkrxOPCf9jx293r6NO5ePvvV7zQ1TqQomRGwoYPUeJ3ykYFbMI5y
         yvug==
X-Forwarded-Encrypted: i=1; AFNElJ+e1CrhERbG60Z4X8PCUFjdmeTtmPqpH/C9g1evnuaB+qUbnRE30Q7rpPRXyJ1I0GXtIMHnzMl9n6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtiIbUQWQoLPXI4sf529ozhEA2PShcWpnJlxdhwaE2Oru81kpA
	D0VzwjhzI7wsrvMnnbIA3DkRtYhIxc5E30qP60XnDGn4Po9CYVOyRcjbzvFGuw+js6nCoNxdmmV
	iUbb2GJFVEQG7A3V7k+ARyoDD0M7wKdg=
X-Gm-Gg: AeBDiesryFxHlWp7ABebI/rGR6qB5A283SUwttbxnS30kGg64PlDplv60zoVagrIrV4
	SnC1tT8RxyOoRV5ifYEAiwf3J3yTm/BTHHzf7uDz7Qu3Vy2qeLO/Ctgx0TqK0ukd38dOZvVUdiE
	6cBM2Vn/5bZJGC5O8EsYC/Ic27pPwLC+404had1tJkH5ePUlErIQzYHZK7X1/QXZzryDAuauRFl
	YMm0bB5Kvl/qEvu9i3fS37JFRuwSpNBYh5pOlhpmDZyRmK5y0L+WfF9Oddyx7e3SUx3+HHwAU+z
	CyU07I2b1MWR/jjQAKGfcWTeNQ==
X-Received: by 2002:a05:690c:6e85:b0:7bd:8782:bb5d with SMTP id
 00721157ae682-7bdac5b70ccmr15884717b3.25.1777956374892; Mon, 04 May 2026
 21:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505005506.160891-1-m32285159@gmail.com>
In-Reply-To: <20260505005506.160891-1-m32285159@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 4 May 2026 23:46:04 -0500
X-Gm-Features: AVHnY4Icf3f27uJ-wdQFYhaxZrmwCe85IGxGct8Bjl_fRwstXABI6JxnkSmQlMM
Message-ID: <CAKqfh0EgLxEnX1MxuKNqVU-y5d6O6zQWSctb_hHzF8_-WMQSKQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: kmx61: Use guard(mutex)() family over manual locking
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 4, 2026 at 7:55=E2=80=AFPM Maxwell Doose <m32285159@gmail.com> =
wrote:
>
> Include linux/cleanup.h to take advantage of new macros.
>
> Replace manual mutex_lock() and mutex_unlock() calls across the file
> with guard(mutex)() and scoped_guard() where appropriate. This will help
> modernize the driver with up-to-date functions/macros.
>
> Remove now redundant gotos and ret variables, as the new RAII macros
> make them unneeded.
>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  v2:
>  - Remove redundant blank line per Andy.
>  - Put kmx61_set_mode() function call in kmx61_runtime_suspend() on one
>    line per Andy.
>
>  drivers/iio/imu/kmx61.c | 76 ++++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 51 deletions(-)
[snip]

I just got the report in from the CI bot on the v1, and there are
still things in this patch that need to be fixed, consider this
superseded. I'm going to be writing a v3 in the morning (my time) to
resolve this.

best regards,
max
