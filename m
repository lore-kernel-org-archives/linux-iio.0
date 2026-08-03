Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC53E5A20
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764558; cv=none; b=TbPywjJL39xmwWVS9qz3W7ka6/FfOI6i5fj45xI8nun4l4NKcly2+ECo5qOl/aBaEt8s6F2o3O6SyrmKtqm3YABh6Ie/MT2GlN1TFSL8+6CWZ86+8ewOoz4zpaRGhqzsG3kgcVQrTox+CQUqO1JrHWYkHQ5nYA2vJsx/VVfOa+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764558; c=relaxed/simple;
	bh=6IOKZsfWbl0KdHo6yBZWTJ5hCBVC2Ohi71h1zoTz6F4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCfrzj+anD90bs4qt5mX+3ywveDuNW+3gSanIRCoAWvZDzim3VE4X3UkTVCjNTRhJBCnhxMIbq4V+Fc02y4mZTUFrV1coVjYq6S7gdCtUCRMrSDCrIwFnALaQAM5vLqp6X3OgFlpPp97ICsoC6jFQKNJ18BMU/kVBy3Ewpaliyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYcPQrmp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYcPQrmp"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso23635935e9.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785764554; x=1786369354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1X+ykpLdd5ThCtWEVokoM38JgTmEtcRmlEOdlCScJxQ=;
        b=lYcPQrmpYfXseZ9OOLWG/2f3q0vSWrjKUI/TDO4ufSXEHmgpo3/bPaC23kMzE0gs1e
         n46hz2LZ5fFcc5nzzdeJjcW24KbXowirrMTB4QmexfLg0XY4qocSn82H+TTAuRrnZzRL
         FsuGIckzjpQ+zSxJL3Q09wOH0Qv0H9ogsjHCT1H/0gZE8OQv5WaybsGRwbXg0CJmV6n3
         r1SzPJOAl+QUaNqCQHMqna80vbqUGsE5zK16CepRF/ETdnp1Zkqeic6QOQtaHjAEmbt4
         Crr8BY5GSQI+AnKbI825/q27n1yC9CL0VgulfYDs5CGpVA5LG/6x++++aFo1RuMthiD/
         eL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764554; x=1786369354;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1X+ykpLdd5ThCtWEVokoM38JgTmEtcRmlEOdlCScJxQ=;
        b=iV6Jo2/agiIRc18cE8n2Nzp0nEONasn9evADHaWN5R0z960578CYzHLkDoF7Y9nXqF
         dZ4ZsHnJ4EtCd5G7PepmrYZaZ2csIlpGpjk4cpKJb4/u1ayvDVptdm82Xha8OO54MZ96
         LWcwveEflCbOl2QqujCHz4kgGdFh70hPmflJlYR691o4Iptkg9U9kBFsHOhUpTlZVEtn
         5ByGCiYGB9K8y2pFAL1XoYsKOhKr5yWDuoon09TeDeDvrj/Ui+n8J+e8po/bFDaJxy6L
         r1Tu0r++L80JbcbyTXXN0QLTa8JGhIPF82O2aSWv6Ak61v6ehFEeg1+Jjpyvj+V0i7fH
         QjHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpH7LnZr2dNn/Kr47CjqkY15HeXr/z3DItXHGB5q64EvLvTcdO04X2mdtFYU3Cvdpp7r7k4ug2/vfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPK53cOf6KpJIWHi9qRKo4wipqfifsNCTqAEeMVZZy/FxQCdGS
	7ajUX5Ry0OLtavoCR8oj5CtkCgltN2KD+7NQIB4ExWEE26H/Z5sHYFZ2
X-Gm-Gg: AR+sD11pCIT/uT9Zmf5fWOQzYSPmeP6pCE4z406I8isRLWkUL0rxJePPNvuIXnVW6up
	R5WJ/DCzOwTxAemWW9WIuisvRqVy0ywqD3cZM5t1mLRBEVNkigueZu0+fJKA3mcAGZizSvRzuUE
	WyqFy8NKHcW8oIsUcBgbA0rRVOFfEtV/Gbexp8FVytyuRGJAzlF8hnypD9H9eLdxSOHGL1+2kq9
	TcvKXkPxVnbiAAhMUFAcftnZIouvaR2QSrDOeqJ/BtaC7jGRI0w7qIronACyjwh/2vdveqUcS6e
	tqDH3raPyDAJqKJN2VxatGVKgdPAV4f5GAJjS8uXbxbuGhFK7zpuJJ9NIlZqpV5KEz1LgeZEASz
	6pgrLZEb2KYN+rf1ZT7zoZt9rdQWWAob4DhPvdFJIow+i4vCAjatLAOIrNIoHSJ1POqScGwQqCm
	Exov8OmFd7YzW/L+lf6SLspXyFHBOXprGAnIVC3EHahVS0Ez8Y6fuEUVdnfjALF5V8EkP/csIGH
	9kOZjQOQ1ys1Bni37t1gCeQB1+Zf0HeRFwGwxjo0I5VeLUXFGppILHeNX1fE/vXmqrefIn7g1oc
	2/uRfF09gsNEwMIXq9Rpab/z7N8bHZh0fD/LlRTOwTg3veW4U8huDt+3PdtWNBjdtXs/1Py+IxV
	0fEiEa7bT9Lxydw/+Osfd+iKQbGnvbhoPdEEPmAjHlOKtVulPmixgFdQW/1BaijDsakPK2xE=
X-Received: by 2002:a05:600c:840f:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-4980c66d7bbmr193854515e9.2.1785764553379;
        Mon, 03 Aug 2026 06:42:33 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dcb4sm376529765e9.13.2026.08.03.06.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:42:33 -0700 (PDT)
Date: Mon, 3 Aug 2026 15:42:31 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-staging@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] staging: iio: ad7816: Fix DMA from stack and
 race conditions
Message-ID: <20260803154231.000070ab@gmail.com>
In-Reply-To: <20260803121520.6274-1-abdelnasserhussein11@gmail.com>
References: <0bde2343-8a70-44d4-9b27-8ce42c099309@baylibre.com>
	<20260803121520.6274-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 15:15:18 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

>  drivers/staging/iio/adc/ad7816.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 

Please don't send new versions as a reply to the previous version,
it breaks workflow tools like b4 and there's a higher chance it
won't get reviewed by others.

-- 
Kind regards,
Joshua Crofts
