Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF4145B27
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577307; cv=pass; b=HFLe+ppeRhIufFuqAedN9W7jOGQ4UXddRjggRfvAP1Ty7mH+2Fs3xv6aCzPoQxzTXnVLo08qA0O2MvTNsia9gpTxlbZS0QFFWJWrXrG/PhIyXiEyGcqaA5fvfv8T+dVdht5nOiYd86scxryiE0fIkz5ZLcoufBgAZ4X8q+AqsQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577307; c=relaxed/simple;
	bh=yDdCC2gJpmh8RSRaOdLS10NNVR42+0UHq7MG0Zy8EN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePKih6h0cWipCJjLHABYJZ4vV7RTIdVOFB7jpwOe/e7mL4BxO9f+O1/CSV4E4FVywiJNkLj/ryhmqrQXvn79jKoPGETZsaieofkdM2sJzdUq4OcIB2/jTqno9NAVOA9RJyTWeVJJ0Pm3XCt7mhJw7nIB8T0B9CzTy/oFs2m5cRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6cgCGQ5; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6cgCGQ5"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2bf3cc16baso192612566b.0
        for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 23:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790577304; cv=none;
        d=google.com; s=arc-20260327;
        b=X6Metp4yT/D890hdrZYvGN8PBv4HWfM3f27xQtBD5EfK3r7pnTgC6l+Gdkz6/sLKky
         osjTyTmocOWd9wnkI4wWJ8jyE2kgEtLjyyMKOWRYEESVEYAoweFEkL8f94Z9vbs/C+mu
         Hc4smtwPC9CaBXKzRjRkVpZj0jJw5UE92+k9alRIh9n1sPgbRM97FzxeD1zSpPDWDVFD
         dX44nbPpsz2upn9kxcnlqQ8ZWkKHs25/0OdCMNUUyuKyL2CgeQN6dK2M67difK703Wxy
         gsvdx/Mrqd2aWgdwpAY3magQbTKjIyMjJIrG0fK8Wrrz14RvkDjstf/Pf0wtpfgIlF55
         n3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yZTtdVLRfkgpVK+w+5QklAfGSFmOHJAvSd9BCYS3KVk=;
        fh=RSMI/tVoDDk/Ia1L4HlDKLXY+2qS2cvwZk2lJxVMtnc=;
        b=h7yOAqhdsYnUHhsEBTLoY1zFVQhBbabrR2yRK6b8ETojusN3NKfoCoEyYYVM16ttQq
         JRUBmH/hP5Xm26N836+954QRy900dqXzBHzR5luiKakGByKgioJ41dBpw2BFXTJqbOs0
         01NjcfyZ4LK69Mz0KxNL50uHy0QG3JZM7UoEq03FGllcIGyTQNQLaGJc83k5UFtw8sEw
         p6QVExN6aL+jvuqA8bvPIlBvU2kvfVk7YzvL5BuB9UYD1F9yXMNtxwlGvg7pF5sEARag
         epOG1iDcBIpyRVLLzy8OK/QKgzA+bJDIyWJQGI7HjueTKTE7pNLZE4RTpgBlM2AjzzQV
         Zp+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790577304; x=1791182104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yZTtdVLRfkgpVK+w+5QklAfGSFmOHJAvSd9BCYS3KVk=;
        b=L6cgCGQ5+SNbMpAxCb4WLIRF9m6eCnERNC8iAI3JW7q3yy+KwQ6/3hJdHGl89tP8Dl
         OsSDAldKwwZNVNlEtXQgGcz9w+D/tDK2g6f5Lvch5+0nui2CSVz6BPPM+8jeUc1konQH
         yWhrMs/9Kp6/d5YqLN67u0n0mwE9xmiERng0cKswPnBOjVnSQgQTEztVAFLB+FYIXnJr
         M1LML6mdF6GOLpOi9B+QP/nb6iwshhi03x0YyFdVkTS1Az0uG0JN7lmg4JWRV+NgtWYF
         dvmgh23fnkdTcS63O8j574owzVPIEHx9nsDGazrrAbWQCMfLZ/qEiyfiOTHzTlGHxxUP
         TlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790577304; x=1791182104;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZTtdVLRfkgpVK+w+5QklAfGSFmOHJAvSd9BCYS3KVk=;
        b=nCPoTKWoe4wBFp99mN1uIweakZpnhLQbmfg1MRCBiIomo5VgQMB/eEzM3mVDCy65fZ
         Lp0JwwST9j88hIttQhaToAyWGYpddZ+zwnHw5CiDBkGy/P4QEpiksE3rQH+SoQECcFMB
         Oq/LxSnt17oz/lnxt8PAqYxMovOsBFpV2vJPSFj/qmVxMx45/8Qg6GQ7eEh9c9FbUBGc
         91ADfto2kZl2iAJdtE+eAU8ThvCpfha/FClQGXfoNlGgUAzmpI5uel3BW9UfFXNbKE4T
         Z+v/tAYdgVuiTXH5peURMhbsAfJcH47x1TT3zMxs6ZC7Ov4UovFgKfm0YiL4K9PcFfPE
         lCXg==
X-Gm-Message-State: AFuF++kIGhTMpI7XgDDjvsz2BsiPMBYVcnoGTAiL9cVH6huJW/5q4LRm
	TI4R7736XrQ9vRngnMS/Kr2HnTkvn0okOgmQUkLqNniv4DXNUhXr7nGARchpRK/3Ql7g2dv2+tW
	dlN4Ssx1s5qwzx4BEvqBvKdtxK8R/4IQ=
X-Gm-Gg: AYBFou0z0nsKhDme0pQWUwBFz/Ro6Wgy1bbLkWcbjqiWC0O/K5KLsGCh8afDhTo+Alo
	s8CJG35yKxbuXAcVJ4C+T7NQfuFtImzwhbpATNzWjK/gauqMkjG1UDoIVueoNRSL6BeJnd6q2Jm
	p9A939vZJhhWDfjnw6lD4E0ChDZvh9ekCP6dtZ+xwhkLvoECB5XgBwcU7jEmfv8gybWvCygaZ0E
	9X+4F2FvervDrx4fmq+3zj4mCm2zV3RSqZL7d5m73LCBQ/VGW6WqiAuH2KWlTy+v7yv+wK6UXNT
	LkYGm1adSLYy1YBj5zYcYGeWCOxGgE61B6D40v7h6Ru0c6waKOLkGMUVKdEpq4HBM6UQi7np0b/
	WJ8o3yVpXMf7J40XGgixCUU9UwlALvdW8sM/gUmOzEM3GP9THElG7Co+6D/WUHb3EscoRi1Y0bL
	BujvsbVwbyNOC4fUPU/AqKxwfnpYQuGyMnHrSkc338
X-Received: by 2002:a17:906:9f8d:b0:c2d:b9b4:f4e9 with SMTP id
 a640c23a62f3a-c2db9b4f73amr376187266b.30.1790577304065; Sun, 27 Sep 2026
 23:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928000824.0c58cd8e@jic23-hlaptop>
In-Reply-To: <20260928000824.0c58cd8e@jic23-hlaptop>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Sep 2026 09:34:27 +0300
X-Gm-Features: AclHuK_Iyx2hR-z_em-TY99AUpkkJHNRvoPjhQM9DyH_sMPvSby7Vk7VWivR_5A
Message-ID: <CAHp75VdoqXy=8N9K04rr-tFoMgf_zQjb4yYtFSahqaPBaHEK7A@mail.gmail.com>
Subject: Re: IIO: Likely disruption due to travel.
To: Jonathan Cameron <jic23@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:08=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> Hi All,
>
> From the middle of this week onwards I'll be travelling (rather indirectl=
y in
> both directions) to the Linux Plumbers Conference in Prague.  Hopefully s=
ee
> some of you there, but it will mean that my available time over the next =
2
> weeks will be a bit random.

Will be there as well. And I will take more days, so for me it will
also be a disruption of like a week long.

> My plan is to send my main 7.4 pull request to Greg before I set off for =
Europe
> and possibly follow up with a small one later (all subject to Greg who ma=
y also
> be travelling.)
>
> Don't look on this as an invite to rush lots out in the next few days.
> The first pull request is effectively now closed.
>
> Unless it is already something that is in a pretty clean state I would be
> unlikely to take it for a second pull request either.  That will be about=
 sweeping
> up things that are just waiting for minor tweaks or an Ack / RB.
>
> Looking at the stats, it is another big cycle for IIO :)

> p.s. Feel free to email me directly if you are in Prague 5-7 Oct and want
>      to grab a coffee.  LPC is a little crazy but there are always some g=
aps
>      and I believe it is in the same venue as OSS Europe this time.

I believe Joshua wanted to meet us in person.

--=20
With Best Regards,
Andy Shevchenko
