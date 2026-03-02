Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB465DDC5
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452835; cv=pass; b=rcPcYahvKtedxifxyGeGxq6BbHSUDDJKuVOWmdHmzfs1tieDTG6gBoJVrzDY/NxIONmqxADHzx9SkgD+0gOhOoG3o1k+Ho/rp6ciBGF4zVl45JTTkW1hNyHmOyjM8iZwTFAqYQMJO2AaJv729ZUbdCxFWStcvKS9O/MJlQ0iSUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452835; c=relaxed/simple;
	bh=8LmPtxyT3YMtIL63fEHFCEyYwnCRKHRTqMjhB0pBD88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Em5qZ7MUsQY4qFgiGBZ7YBPrHyKZ24jfheFvcx7+gqLeK2bU1v+OcAx/C8qJLOzxr0g50pe3repfK5ux07ihU0vQR7jZWUe+zdW8sChKdO04thoY5vM9ngsgX1WEMLm0PNTYojJSsQuRXfMkzec9nR5l2f8FvFCjXlXKdBt2mVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Zj5l+/mW; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Zj5l+/mW"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad9516a653so18047095ad.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 04:00:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772452833; cv=none;
        d=google.com; s=arc-20240605;
        b=gVc03FLs5PGFy72CVPelTb6HxU8z0n8/ojSoOESVCsACRKl0XN/p3fMlOpZK0RihTZ
         G4rxC8RvT+Smqzq9ES8WH5aPvPJ0BFGGPtHspTn7cZImLXQlS+VRLrIxWE3Wai81BvQs
         Fb1wBD3hOLQGyIV2TuWs7gK8F3zUqaZzwWsBdRZ7+Z0eDKt6XrT+qnm7rbcz394hJ0p1
         D9CaPv+w6xHHRvk4jwNywTm+Co4mtMd+1uKp3QgG6wBzBAuFCv6kRl6lm45ZypPm7z7j
         WbcejBIqGSJFHqY5yf1/r5sgfXxX6t3lU6h5bFgnznyIxXNrhdj8kmiSz80xh9DPirXx
         bYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ArgC6tchR6EEgYRqqpyMGswMfqPtVUgik7Fa59Flxok=;
        fh=oqN//ZU/Isd2ZS5lV5xFnu3W8btojpQS1T2bBunJ4qI=;
        b=KQVmsUY8cxI9A1TPv91P/JVN6H5h4pQhn5ZzZd/HFkuPgX7Aavg2HTivuKY0/PD//c
         SEUwvwrg1DDTuLjdZdKe+ZhwtzYVqdfuYwXeZtAZ8TQ0/FbDCiaG0Bh7Lw4P+vFSFkAH
         3a6u7Tsp0eiZdMAwhOyXDA7IMnr6pzxtqRP0q8PlnTAdxigEGErwDVxSBrE484G/mLOf
         Rn0KfH0SDDiAD43YYzJlMqMLDamCmy8Mj8C+/eOQEltGuR+SDIG81UdKw1onnLJHWQ7K
         6PAkF5QGFOtBBs+qa5iLdd3vu1JuF2mE83fesCO0EYoSxVvgpYNM6np8UkMr3/7YYjRv
         Y1Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772452833; x=1773057633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArgC6tchR6EEgYRqqpyMGswMfqPtVUgik7Fa59Flxok=;
        b=Zj5l+/mW3UhkMmH9aIqlKGV4S8Uvjyz2AR3kfRrftWeRCwCkpd/nPzrEx47mXvXeZq
         umjFMANq7L9KF+AGOfYqa1gz4cZ7XH3J1gKRIsEO1Zo0RZ28kmeU66Y3wEQTZqOA1r8O
         WsAv4LyX0ajB5gmwzA4cVSlGBvSZ2me7IkF/weZTMMORNQgtM2YKj2qkGvV4/JW0mHZp
         AFDxpxXn5LANlXVXj31WIn1p0hIJ/thiuAhJ1ogyrzX1Z4n0zOaUu2/ry4mcnmlW2TOi
         N86ypAD0oAhcnoFYmR3jjInTdBJ8or5MCYDYWh+U65GzEcxi6Fi6F4xq5Eh2KGhWRwVb
         Eaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452833; x=1773057633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ArgC6tchR6EEgYRqqpyMGswMfqPtVUgik7Fa59Flxok=;
        b=D1nOd2h20oM0S3P3kbGHdlo9mGHOd0dh4rLX5H9SsQ/UMreN14vEuNzxN5FZX/HVUr
         gzq+Nq8+UeNmOKVSi7i1FLpd+5u1kEaMp5Ncm+inLmiCrsYQAmUBjY0mjk7oh/9EVWE4
         PXMMBxcsCKK6/D6WnywhZBvglc8vB7U//HUTtK3kaBCnuJcQsrMXrfYmoD58pRCWy82h
         +5WAQGFQpTf5mlvWYVVsJTPq/8LTDb3KaJpOVrghbn5Iuka2zVyglLI21iFRd3qqqHAg
         ikDJEtb0CSv67dZ8Dmg0h2vJ7dKoym4N24x92QeUjhKOv7edNdeUbDkE+WMnREeEtEgf
         F7/A==
X-Forwarded-Encrypted: i=1; AJvYcCUtfokuccIdZFOEIRqyuLtPPSJ309NZPsp9y4ohi7WZuYPCGs8wQ2WHongq7aI0y6H5kA7SClBGIYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4oC/gJXrEF27MD41Ivqzm3WT5VuB0sJyis5iGwNeGZoOI6s2y
	rar/BgLEelKyieYFwJ/VD28oyIV86jGO0L+voatTfze/TiSXamEKcGn8sUyrtk3qgUzcfqyj2GS
	jeOQXbuX0l1qR+g6wgHN/lKISOFzsr8g=
X-Gm-Gg: ATEYQzzOCuZFFHIMd53s9QhybP6+LnBYIYB8ydEQ0Qa0iIfs/44UXNGx68mphboSzVx
	744rhIZ6luCaCT2ghw4/xZE2fMFAhq5UzcjrAD95sZqaNthlLskkHxLCO3U7Y4sCmjA/oqXvBXT
	BM0ryscpQKwiUMNJ+xPJ1euOXYPua34E7mlD1/HCwaqpiganZgjRcl8PpYwAwNXg3lECRqKuVqS
	X1ZL6pkZtbvwiZJ6o0j8+Nqw+RUsIyDcNzzMxBOs+IErEsQM/kFXwzUsjmd0ApG8emI/g7uBIDJ
	YCcB3NF7wGROLrFSaAL4YJlxVhTdTEmOsDZLXbG2
X-Received: by 2002:a17:903:2b0b:b0:2ae:5a44:ea73 with SMTP id
 d9443c01a7336-2ae5a44ff28mr9115965ad.30.1772452833138; Mon, 02 Mar 2026
 04:00:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228065840.702651-5-nick@khadas.com> <202603010009.VfPuPoeI-lkp@intel.com>
In-Reply-To: <202603010009.VfPuPoeI-lkp@intel.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 2 Mar 2026 13:00:22 +0100
X-Gm-Features: AaiRm506ikB27OOPsiZaHy57remzQl6Z49Wi7FBnTFU4vfPVcSRrRPvLCZYsf3Y
Message-ID: <CAFBinCDBR=cgQjhv9VxYLFAmTp2p+Fm_mWCZ5o5P_SA=Rb0R+A@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] arm64: dts: amlogic: meson-s4-s905y4-khadas-vim1s:
 add Function key support
To: kernel test robot <lkp@intel.com>
Cc: Nick Xie <nick@khadas.com>, neil.armstrong@linaro.org, khilman@baylibre.com, 
	jbrunet@baylibre.com, krzk+dt@kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-iio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xieqinick@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 5:16=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Nick,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on robh/for-next linus/master v7.0-rc1 next-202602=
27]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Xie/dt-bindin=
gs-iio-adc-amlogic-meson-saradc-add-S4-compatible/20260228-150346
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tog=
reg
> patch link:    https://lore.kernel.org/r/20260228065840.702651-5-nick%40k=
hadas.com
> patch subject: [PATCH v1 4/4] arm64: dts: amlogic: meson-s4-s905y4-khadas=
-vim1s: add Function key support
> config: arm64-randconfig-001-20260228 (https://download.01.org/0day-ci/ar=
chive/20260301/202603010009.VfPuPoeI-lkp@intel.com/config)
> compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9=
a109fbb6e184ec9bcce10615949f598f4c974a9)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260301/202603010009.VfPuPoeI-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603010009.VfPuPoeI-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    Lexical error: arch/arm64/boot/dts/amlogic/meson-s4-s905y4-khadas-vim1=
s.dts:50.18-24 Unexpected 'KEY_FN'
> >> FATAL ERROR: Syntax error parsing input tree
It turns out that this series is supposed to be applied on top of
"arm64: dts: amlogic: meson-s4-khadas-vim1s: enable LEDs, Keys and
Bluetooth" [0]
When applying this series on top of the other then there's no more build er=
ror.


[0] https://lore.kernel.org/linux-amlogic/20260228063750.701887-1-nick@khad=
as.com/T/#m2f4d30878fc8252f853bdb3005042c3aad97961e
