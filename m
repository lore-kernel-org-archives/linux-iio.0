Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0943BD25D
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158979; cv=none; b=B7TATUdU7pNFI1yhG1wjP+tK+s0ix8OGBgniwrHedEaRkJt6Bx1gK+5d2XFnA3oX5udvhyszAZCeXDgI48kmHL4y8LAaKUD+zwG43562T6tbGdc3unAVD12Ace9dD0MiXYooel5mUEa9F6PD6A5oKZV9+zQm8gjW+4RTWdXRyy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158979; c=relaxed/simple;
	bh=KKkFrGAQuLsaKAfGMyDZsQ3k1diSwHCT59e7mADutEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ed3maKL2q5GjeuPN+0QRsPVuaUmIf2BC4TghYshqglvWbU1WhPt6euBPuZwRfFVKgXsB5kMOBXKXET+yf3JBiDIpKwGag9pDZTBRJ7b/eboTUXyVU7F+J0YGmXTJ0Kam9MP/KQXOIzqdyYVyiE06JKR9axGeeXS49L9m4FJtjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRLm7wLM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRLm7wLM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b8efed61so52164965e9.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776158976; x=1776763776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DE30NuWaHREAKnzN3Ic0cEm1QnvslG0UVfsef9rFBsM=;
        b=hRLm7wLMmA9DdiLVJMafBn7MJMBYYN/dJ3COf+cMHEH8ogCuRprpqhSrnPvPbT7IM/
         lrLRs4xC1GO5nA7p2I4qQrfAduY0ZG1uQXIaKhtwQ1GKFz5aKVCYe7hp88V21uBsRW3s
         AOlpru+JJPi1bs7PVBjqDBSTgDtF7230COmyaSK4N9uz/7l5qIKqc7qeV8aPxlxYOwLo
         Fis0udJOUB11QuzS5lUnBH3ZkvbLcP1EkMsyytcciaV/WIxJRNczqOunf+PPDkpTLVNm
         cLq55/0+5lP94M/1PNjQme7iAB6CDaGMjxqXW/0oVC3AQTDNDTLoMsKVA9bRIVev2UWr
         IUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158976; x=1776763776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DE30NuWaHREAKnzN3Ic0cEm1QnvslG0UVfsef9rFBsM=;
        b=JuIWFcq59Q35t+aBkZFZrcyxTYQmSl2jcbn1qPcRcb+Ql1yQ+GBbjU1eWPhJ19as2b
         eSYQsUHqHG/IGuozIrqIQ6CtmKSSVd/U2JGCLeI9kqqQ8bwlsFdjehMR6Oo3HzOS/2T/
         Wgf9B5AYE6L35H5P+FM7t+xkIei4q14znqF6Fz5Vo7tZYgS5jMRyx4qUTspEPuP9kF0P
         arWgyPCh3h7WK4mGqkyFY3uPO+0oEqxR8Y2qmdeZG8XIxh/nQHxa1pAYGRcO+8sPa8xR
         p/oZCmcpC2+rnpClEXGYq25RqT1vn8qY9U1uFuawBh8OttsLTOLZ/NnARdoFWrisLN7w
         FXYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/n5jwZhqVLTcQripFavJVCzKSbgVa5J42Bi/gDBv/A2rbxedaMbVdk51RMQ4MwvYL/NRjKvfulyDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbupfae09hLYgPaq7pWItGEVjhobKUSkDCPXNNDPLJwNqhHxz
	TkzOiEwnZLJL04zeirGIwJosjmRkF7tYzftqlUriVps+71cFrZfEgjbm
X-Gm-Gg: AeBDieuyxkRx3oqpzb63It6o7xPDg9VrOlxwh2dUZc/ZCtMmrm5PV4H5lDwJml+JjBB
	nZ7J9V8lRi4DyPI96y3z9L00W8GxX2tsDYTNs+bTUOk7MNxBhuS6e2OeTgKHWH5fQatKGW7Y61T
	KM2d0bVMZy/nhbGhi0FshAURf/66MQApixJvf5+ONkp53Psgf+vYVyO7FNkL/C0R9/jNUp0TvYm
	GDvorRlM3AlMyoc/FKHrTA+h2kkj2KTz2vDdw5/wxFsItLU3iPEvrfccW234z37NlhAycE1qqTU
	s4L9hsw2XE8II+opUHCPinpikNeL2nQhIed2Cjf091GHNOcJM4+uTcxe361VJlChIB0XiVveU4d
	kYFLYEva6oq15EK4PwcUZYO1INlNT/kAnDs0KD2uMdZQkTElnMPjm4TxOtULIwmHeYIYeqtcxrk
	QtHnbMLJuyPVjicEqDB8TKUsa1lt/W7WaEJkXv
X-Received: by 2002:a05:600c:c10c:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488d68cb8demr138530075e9.12.1776158976282;
        Tue, 14 Apr 2026 02:29:36 -0700 (PDT)
Received: from localhost (hf33.n1.ips.mtn.co.ug. [41.210.143.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488e10d69b2sm84509625e9.8.2026.04.14.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:29:35 -0700 (PDT)
Date: Tue, 14 Apr 2026 12:29:31 +0300
From: Dan Carpenter <error27@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: frequency: ad9834: change sprintf() to
 sysfs_emit()
Message-ID: <ad4I-8ulJuScyHh2@stanley.mountain>
References: <20260414091250.1295-1-joshua.crofts1@gmail.com>
 <20260414091250.1295-3-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414091250.1295-3-joshua.crofts1@gmail.com>

On Tue, Apr 14, 2026 at 09:12:49AM +0000, Joshua Crofts wrote:
> Change instances of sprintf() to sysfs_emit() as returning
> formatted values to user space should be done using this
> function.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Someone beat you to it.  You're working against an old tree.

regards,
dan carpenter

