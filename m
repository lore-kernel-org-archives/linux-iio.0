Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423382F8BEE
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260327; cv=pass; b=StE9ZTBRlcUuOZE4kzBbNlrtjprUm1NqfimVKB/BT1H6BjSSXIBI5D6gBwrk4qvftQg/wwqNRk4Tmr5FafWWs+evTov0+An44gjMhug1YdZEC4DQt50RDXZP/etYHjm86S2pNDzTCo2R8kWw4AKl84s+rlViv5leBMaUp7z5eg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260327; c=relaxed/simple;
	bh=E8jOnk+OV3CBlGh+i4MV8jYIJFhMbjnNvmBl9LFBYW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjS76Ubc5byqTBl4mQd7kRo8H+hs41vRpU2IeLlg+pS50llIxmWra52O9l59OFE9Sp65QnRdWBFT8o1eNHj7d5yMdnJR/Wn74vnVwFJPciJaWeiQGgJL0omP2Nn3fQ6UenDI/Sv6s0oM1C7is3HXA+4hdWtuzH7yWVpYw7C5P6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL4vzp/n; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL4vzp/n"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b96f02b4329so36699266b.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 13:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773260325; cv=none;
        d=google.com; s=arc-20240605;
        b=FzmQqTcnWm774LZNjTVQnGiI5M1rrCl8VPbUurCrH5n5m4RCY4RagZaaPSOvAj5ajN
         Zl23OGR31jSCcR1fR5+SDxKWsmBX//gMJ+pCdDsU7d4sxlQKNWRyCrEo31p3xpyPzV/2
         Lc0ynZDFAPy3pa8MPWqc3MAd24H59RaZETmWy9KD2j3vjW4K007qlKp0ZuDCtBYuPelz
         RfOJJkT5I5XdrY0xBFy7oxiNpcnCBhgc34NWE5fxWW4MU3ViQsLDXuCNSfaBtv8ieLBp
         3HtyLLr6dC3tas8Z2qM8gCifyRrU4+X5JbL2jLMdOQ/rJwoyx1Hu4AxevVsbA5FP9seD
         GtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E8jOnk+OV3CBlGh+i4MV8jYIJFhMbjnNvmBl9LFBYW4=;
        fh=L65Z21lw/DxQGeW6dznNzLo5Bp6Tz2B9wZkTbbhNG44=;
        b=JkDsiUeNLElf/7ZiNF/3Uy8B4RnrnTd9INK26M0H4EWGI/0QfWZC+Sws9uGFUelHei
         nYUODQoRo5r37Vqrx/0+J1S3oDM2rqcleeOnf3CZMfU8JhqZwdfNLG/KcpEg6YFgoXvj
         GbQsSpIJ0COv35c7KMnvTePnr6Y71cFpkue3A5QpaOZ4W6k1/oON2mI/iepZSCGRT0Xh
         ALB9PiYByPfjoK1CIJzxkYTocB9WKB0G0WtC0bokRlVjXwK79jvGsleFrPfIeHEHx+MX
         //2NkV2xUD9RLunVqjsviKdVwXt5LBX2MSSNs+wEf7rN3tK2GApoXtuSuAOBQH+rZJYs
         7WrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773260325; x=1773865125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8jOnk+OV3CBlGh+i4MV8jYIJFhMbjnNvmBl9LFBYW4=;
        b=UL4vzp/ndXcROpE5qV2QxqpA3kdkCiOnNhjO300VUQzXbdZfwHtStbjrU1ruyTUYWN
         fx/CFxScfpNt6Bbfmz9dUXKDzXXxt0x1eA5v9WZgtWY0V6FVU31KdNw1zb8K5MIUiX9x
         6YFXhR19PSAT5unRJouwgshFv3gbwq5lZ2NjzLm6l8Q85vDr1/wY7WcQAXf23fYnN6Q8
         F3JGL6uKBwdS0uETWeemJr/TTG5fkFRWxeta/BS8SVxsl5S0cF7RcsjYScBKouyyAflq
         YeDDb4n4ZnjQXmAJK8WM9kmdjrQHfKC2EvlhA7d5E+GWBj0lg1Et/SCCbIY3l9l5olJR
         CMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773260325; x=1773865125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E8jOnk+OV3CBlGh+i4MV8jYIJFhMbjnNvmBl9LFBYW4=;
        b=fZ9osG0MN4YCcBzyN77l4ltIdSnwMZTjc5lI0Jo/WL/vpOVN3ST7IDseRprMSvdvcT
         TpDVrgd+iri9ok/cOhE5l/VKjn809y52b83Xa5xnQ7oTe2bGWieTRg/Trqj1JEmP//cU
         55ddGqwH1YsT9Ki8297HnO7vO/iMpIvZCn4+hGodtG/0Qxg6EFX15VtvKr/w+mD95Way
         xf3bZLBhbG5UGym1dDADPpUjv1xir5ep0ELBKFbMi4fMPsXsZwiD/BorXVrTon4qYhFb
         fcVAaOMIbppg5J4CoucKlutbd4Xuxd0NE7c0AAgjx1tqa9Ce9Ry/IJJR/qMngd5+GWPf
         mUgg==
X-Forwarded-Encrypted: i=1; AJvYcCV17H5I8sG8wHmmEeLCymO7pGHf6AYR10l4U48mUDATIOjFXQh5cUd0Y8Buo+3kg5GIKdrHPr0n5p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSutzq8wriQt0Vfmf7K5Fhs9O1gyfL9Lmcy/iIZnyXUT5Fyge
	P7JUXSFHCZyJ4WMErp7BCQV8Y7GS3FE+CFPIYqGV+dG6WqpqXJa9jU8HX2OYIaQbEDsjsntYhsU
	vHo7awR15EhjsRF0xZrsZ/81NDk6RKfxISIQ5
X-Gm-Gg: ATEYQzzEAzPwQlD0dIuURjQlpxTA1/BJQCR212KE9Q8A3rLIaRcS8LdhWFu6W4eth+5
	rmEAK2KQKs+1/344LOwiTUTqlXlmcOFmtOF9fEs3RJVONwKqHF+dPYXmSKFFKLzhggMXHk9IVV5
	0qWXcJfy09m7I/lO1Ee3l2zTR2EEzApUSUgfhPk6nqUZ89+oEIn2EKZqa3jOVpI8yo0XDCGP48D
	A2zU8tBZbhTjvXJwA0I2fex24aSDSmMePTjVwSAg2ju/1sigLMD3TzCST3DUC9MjiBhfomgrY/w
	BrtlO8HLf9g/fd8FvoxRz597ByDj9rN5luDVxnMlpYTFo8Hho1WP6CWq8oFQB1A5tMuphEo9qiX
	Ydm/SCfQ=
X-Received: by 2002:a17:907:1b28:b0:b96:eb7e:bc3b with SMTP id
 a640c23a62f3a-b972e530602mr218474366b.49.1773260324392; Wed, 11 Mar 2026
 13:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311194624.1521-1-ethantidmore06@gmail.com>
In-Reply-To: <20260311194624.1521-1-ethantidmore06@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Mar 2026 22:18:07 +0200
X-Gm-Features: AaiRm501hcMrfYgbOIJ6iqPXC2ZcxsKgtf_suleunN1jnU0LCEmxuYNY6IzkL4o
Message-ID: <CAHp75VeZb0pSiAkHo9QUeS+2L-qP_83-dKKRSp7-1VfZrtr1bw@mail.gmail.com>
Subject: Re: [RFC] GSoC 2026: Transitioning IIO to guard() and scoped_guard()
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 9:46=E2=80=AFPM Ethan Tidmore <ethantidmore06@gmail=
.com> wrote:
>
> Hi Jonathan, Andy,
>
> I'm proposing converting the entire IIO tree to use guard() and
> scoped_guard() instead of manual locking. This would greatly reduce
> boilerplate, the possibility of lock leaks and modernize the entire IIO
> tree to current kernel API standards.
>
> $ grep -rn "mutex_lock" drivers/iio | wc -l
> 874
>
> This would have to be a "Large" project according to GsoC due to the scal=
e
> of the IIO tree. If this is wanted, I would like to know how these change=
s
> should be submitted to make this easier to review. I was thinking per
> directory per vendor.
>
> Looking forward to hear your feedback.

Most of the cases can be automated with coccinelle, so you can even
create a script in one day and estimate the real number of corner
cases (id est that require manual work). That said, it's not a big
project from amount of drivers point of view. It might be still big
depending on corner cases and if you wish to target them as well.

--=20
With Best Regards,
Andy Shevchenko
