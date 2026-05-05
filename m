Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093A2E06E4
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989925; cv=pass; b=MsR0EyJq7BIVI3gIE0qE1AXDDffpWdRg+JopmJ7eAjg6/mRJFIhg4t4O3PcLkYs4z65cCX9sVVv0bwFuIgjNE7J62WZGoer/qkuSyUUjWq61oe9MgsXB7lRjff8bufqbTrL2w6uTMe7wRaJ/VH5sbQG/uCyiOigf/xKNacaUTT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989925; c=relaxed/simple;
	bh=ujDfXMc5ZCRrw2hsG/Z9L332sDe8QEZj/nBRqPpJWDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnXkHpTxQ0bbilssNOF8xzb+XXRc97Q1EmZ+A4IrAMXnh/yXXg9NOiu0c9ZNw5NXWGnOdPcVFjQqKmQMKxGhSKscFYJhDEw3NU4E7Eh1Dqb8LgRjGNdrpwW3oEn3Sv4h6P1kSFw92T+hz9KEFkykCd9Zs5r7gBLNDOejCp6uxMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx7KdPLl; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx7KdPLl"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d7e23defbso3009826f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 07:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777989922; cv=none;
        d=google.com; s=arc-20240605;
        b=HFQMTzDe5UOaBde/JgA8C8f7WI87uQAvuyu2u1tZMqGMRlZxy7gBtRT7dfJqEVy7pf
         t2jlC/K0ld56s+6O4sQpXW7340W2dew+z0sFQvzKOOwj4AHfwzm57s1W46HVb9b9FpB7
         3vxCqeNrWG/qMuIGZ62QoRUfCzp39w2Nb8rMVwSUkelvtIFZ/uE3v4snjZvVdC6JMNhX
         XsQc0w+kItyb1u1dx1IYD7qgqb5l3N7OEvx/u1Q2Y9ECs4T1kiRiOM2LpzTC37+5DP8H
         yhSiTi8m0nvP8uR3aZbARbJDNCFzGbP/vlYcmgoasBfQTX/Z3Gk/XtI1I5uSuHbGq7Fp
         u0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LGmm00NW4LONJqxWqNXj+VcQNhYgNewBu/r1TmRAonE=;
        fh=rrrmZiXy0MUvfBQ3Srbdel9G+KBxWrjx2UsX1OVA8u0=;
        b=lYZvbC8hGnxtpCgWrTc8TrtADw/WPdebNsB6vqptKQVd5FFucgfpuSWObX9lNq2CYd
         +ADbUyYYZuAoS7YvHg7O5VUtm1HDH01aJN7sLeZeuLjh6Po+p9xuqurCJpWhf6NIkG+K
         j4A789W1mqH/g/nueO5kmDjJGgCXBvEg3A7hQbNeDBS/bdSnV4ZqODkJsgySwHdc4YWl
         B9EfGozcgyPpG3VvsmEvYdBwESX4Gr4QBTGNjqyhzgiA+bAXwKBMNS68eKbyXI8CP1e7
         wWmGoTP+0YVCzBmR//i5qYLACks7ZVWX6+vZHBgxWR70aFksWBin9co2rZEMGwF2+Naa
         BD0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777989922; x=1778594722; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LGmm00NW4LONJqxWqNXj+VcQNhYgNewBu/r1TmRAonE=;
        b=Fx7KdPLld4pyGwTJm0XyZOzFo7U3Z4rczpGYLFgc1OwMJDJW0Kcer7MHbjQfYtlIMO
         vU7fzkTGxClojJelo7ptZkMeJ1r12o907e4+Ngi4OiraSaJ8YufYrA7jJP0n5aAFkBWP
         GVf+lhVvShobfxSyw6dmmn9qDjtseoQ4fQdSCGPJWWj9v1RUTU/S0DZBZFfNm+sJI0Wn
         6YSC1Jp5akCeAGm5GuRJ756cnDQbfq2XabQm1RYD6X3SslQ2+fpHenXFbLHLB9HMN7+5
         VGaS0l3wT5swAenq5fJ3/B/UScvs70/N6ewlummqzHWZ2fF449Ot6FUHnGRX2luu7PGV
         WoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777989922; x=1778594722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGmm00NW4LONJqxWqNXj+VcQNhYgNewBu/r1TmRAonE=;
        b=QvKHTj2boKnrUXexZfmijwxaCqgv7+GzKvkXXG9++mAtWy42dQCuGqcSMcb7gp1YlR
         I1h78vyb4YUdgfU9um9RdzcIth9HVLjSUiZxGef1YEMcOolbZgM5m3LFyA009u2yVWAi
         jnkjMfdIQ+lWflwTwI1Qm5esjWdpilTwoQab3QxMe5bC1vp1tesGh/a+k0P82WJwIh7F
         f2VUDnxoaRmqcqyoZlSWfcAtCHv1ow2k2oaVEb+GJSyAeDFouMfGlIQdEDzAmkUCl6Tf
         fg9lrN+e8LQDIWO4pQNfBHFWqbYSKWlaze0eiIKG9FtjIjSYH9sJtRPrcEY/k3qa9hTI
         N0UQ==
X-Forwarded-Encrypted: i=1; AFNElJ86fAeOY+5mA9uXjltnojOXfD7zAuaMeJ/lTgWwNgKc4Az8PiuHxUKxkb7SkRFHkUmgUzu6TrEMlik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZ007yvF5pxZiNXxZWLhA+xtl3pIcbpeq0ws3AlONSkGEl2qm
	6hO9dXALrOklMHw9rnqrtO7EENj8s+jTOKwiMo6a72hyeZDCNJks0xxzIliHsm3hUqLRtsjzGPl
	6VHazSSbmXb20aU/8rduxH0OU+VvTj/g=
X-Gm-Gg: AeBDies99/6eD/UVMNbddL3qO4PU0eB7C6yL/jWzDN2fIhaCrJdrYxotCAQTGf83byA
	s2EjGV0idYTWU7xl2scMH9OK8KyqyP65uq13sHmFJHl4NGOJUvBQjANQK/iRcn3A4HYsDCzHEDG
	B6IZ1muToTI+bpOOx/y6CI6mWgeVLuDbbJoACPdQK4ZCmJ/GVkpeIErfz5PGzzaFdc7S7BFZINQ
	l8/tJEl3oxS4aiycAVr071EkUAfVO2VoIf7Dnj3sR+9A1JwpGN2poFJ29UhNQ8vHTg0fsxHU3Bc
	ruioYU8ltIEEoyOt4VheMAD0dm/LUVXMir4ljtgdPq9z5OQBQZ+YKZ3praqcwvuPIkCVGoR4AaF
	SJXfMnn0i+fBoQ606nFHhCe93rXeCpCek9u+iGfiwoBw7/wgf1ZYonHSqD6OcKyQVrhUaYkE4v7
	4SSpnF41VwCbBBHKeDur2YemyR14s=
X-Received: by 2002:a5d:64e9:0:b0:441:1fa5:4577 with SMTP id
 ffacd0b85a97d-44bb601b9afmr22941068f8f.26.1777989921326; Tue, 05 May 2026
 07:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com> <20260505133443.4e345627@jic23-huawei>
In-Reply-To: <20260505133443.4e345627@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 5 May 2026 16:05:09 +0200
X-Gm-Features: AVHnY4KcaZG64MhAi5FMZHXHGM6eDVw8un7wadEpnLuJDwxn55jQEye36R86erg
Message-ID: <CALoEA-xaCwz9BtVgK4bqGPZo9=s3tU=hs4XsdpunhcMmMExC3A@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] iio: light: si1133: driver cleanup
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jean-Francois Dagenais <jeff.dagenais@gmail.com>, 
	=?UTF-8?Q?Maxime_Roussin=2DB=C3=A9langer?= <maxime.roussinbelanger@gmail.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sashiko-bot <sashiko-bot@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 14:34, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 05 May 2026 09:31:25 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> > This series deals with the cleanup and modernization of the Silicon
> > Labs SI1133 UV/Ambient light sensor.
> >
> > What seemed like a simple checkpatch cleanup turned out to be more
> > complex, therefore I've ended up doing a patch series instead.
> >
> > Changes include:
> >  - adding missing headers
> >  - removing unused macros
> >  - adding guard(mutex)() support
> >  - code style fixes
> >  - race condition fixes reported by Sashiko
> >
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Applied.
>
> Sashiko is far from happy but I think what it is picking up on
> are either wrong (like the i2c stuff) or about other potential issues
> in the driver.
>
> Correctly recovering from every error case is fine so I tend
> to think of that as best effort only rather than worrying too much
> about the more complex parts.

It seems that Sashiko ends up finding more regressions after fixing
one it reported. It's a bit misleading when it reports multiple regressions
and once you open the report it's all "this wasn't introduced by the patch,
but - ".

> So applied with that one tweak to where timeout is assigned in patch 7.

Thanks, it does look better this way.

-- 
Kind regards

CJD
