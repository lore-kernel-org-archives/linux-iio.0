Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49C3BA24E
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711948; cv=pass; b=ORmeE7QKQrwXbLN0lXi87rmbYOrOEzx88W0DaLDFZU+btAK8m4NHv/W0JgnL9JXiSsvVjUc5H9HdNNV5m76NLZvy5zTccWXO8N73b06HZrzzVw3FzsliKsuCk5yhYNBmlagdeQp4q5v5N/yFyUp8h2mI0WWRIu+UlZ8+aAJqMog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711948; c=relaxed/simple;
	bh=674vgAKd/RTrOQNbWGbCczHU/j07DbjYq/3YPxgjVqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqsNK1ZH+Dm/ZtC1bqlSRXDvn5Dlk+L134wL8WrjneZqxDeI4/yHDlxQ+AUF2zBu57hHam/liioJGocirLa21xeLPlM6aD9WRtI9z/d0yS36ZF4MA81ylqYCphzPyp3aZWI5qhRPI2fMyLEaG0O+MJHdOW3VhWWpEjuSPa9/JBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixKiGoY/; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixKiGoY/"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-478c01da5cbso38554fac.3
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 09:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788711943; cv=none;
        d=google.com; s=arc-20260327;
        b=icBAGbTAhvrUtI4STHlGZG6p1fnuO5R9L3pFbOiF8zsYIne7mDiW+01GjiVoqohi3K
         +zbnVi28Cp6IXzg65UClRGoXVLeHWZn0RcVf7XPJSMyY2/t0YGqnB3L+XaJ64PFLBd4J
         uobCCfn6ei5h59Xl5nIUoZ2HAZUn6S5xVSAl3NIQ9nCZkR7lVoXgGVfD89PWdyCb2S4o
         S2nwuB/Bpkfb3m+JhKc7JQu2KE5HOJABKiMWpbmKHlApXgQFPpuHk3y+LOJvzcow7Woa
         NXnokY+F/E0AYaL9RsTGhhjcxAu0MQqJ77en9Yz6+jUxzp7rCRYMUsoGLLlLiNWNrIg3
         QDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=674vgAKd/RTrOQNbWGbCczHU/j07DbjYq/3YPxgjVqo=;
        fh=DERkDMWNzELDu2Ozg0V0dcJjk/cAnDfsLX+iVeh9thM=;
        b=Vev5hcdNgdBmC/VKf+BLuST5SKdgIGzg01K8A7Lgs63Pxja2TFqgcwxBgRY86yqJTA
         7n71gclEQGRB3Laoi6f6lPbTZEyMwmd83lbDILHIN+ZDLTMH1i7Od2PYtVoLT6Tmgl3Q
         Vp8udqAr+hOC2o6VkGFkKYbnEhE/5AuxNHxdewMlAhRAIifR7oYNcPDwxiKg9432FEqL
         1hEahh1jVHMnu8sVIDp9h8kUcFELLgH0jh5ZLwppO/Wyb8OovE1gP3Ebc3unbsFA1tCh
         Xitt81r24RcTEWgAp6smCcHFJfINZ0TMhYcSUZ/HJOdkJowE/YaPRGPRakU4MQkgjtcy
         MEcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788711943; x=1789316743; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=674vgAKd/RTrOQNbWGbCczHU/j07DbjYq/3YPxgjVqo=;
        b=ixKiGoY/P0+kNU6+ashWjq7fr8bzVKsPutWbZAxhf8tmOSrwYhn5TsZInS0la/1b6B
         kp4AnpJjt9moz83ssBBn5VHHvDNF0THsyFsWBmEWcrnjlU/igKIy/VPFAIZsVUf9BgnM
         bUYiqpDOUfWfzyFKjtk8ZiI6vZOzrJefkadZMVBoojh1J9JjZDDdPHiM9LTOawJyzN0K
         pQM20rBHrPAROzWSahU8w3vtOvK/M1R4zIKdfJfGMtTp2hGCBUsHe+2gavbUC0YebbTO
         QM8m+F9gb6wdOH60yTU3v2OO33Wfd2Yu4j6kzZuVdokq667uxhSc4BJ2vHm8atPhl+/E
         35BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788711943; x=1789316743;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=674vgAKd/RTrOQNbWGbCczHU/j07DbjYq/3YPxgjVqo=;
        b=Dqs+TAUUytfwWHKxBWZmGwybZGAy95Oxy13smkk5q3H9A6UQXXO6rSY2QqdbPe8pSw
         5GxCu7XUDeYke8Q3CkoZsP5Pvgi4DIP0rdVgOBVvunyJ/zysS3WsXbJXwy4BcFcYctmY
         QP4OmQcx2mY59QOYD5d/J8zIXehKVj/GK28huEEdjb5UF3IfTslhhy45fr12kE6w9aT9
         3V1TTeir3aLDSL6CyAp9fxdCCgl69SaQMzj+zRVZfc9LdG70MEDohOqBBlOxeP0G+Myt
         AdwdbV0/rXVfLQOLU9Peg3WXwdLOJ/QvctBgpbQKMEh46TIOeZdxIFVfBds7qxhJ3bFC
         IRcg==
X-Forwarded-Encrypted: i=1; AKwUvBwS97mufjgpSSRf7AkQBsNGMuKyPvfchMdA21GLipPlstnQ29+j8szVI6wDIWosSLp4p0K56tDhx+0=@vger.kernel.org
X-Gm-Message-State: AFuF++lT8qFmV+10AYxbaVdv+LMCuvAOn4Y6BXxfiexjhr5iEox6Oht1
	1na3i5mpkRnIN3/IBI4bPtktvq1Z9VY2Ssc6P0W2CVujKEm+J2hPD/lDR+v6r5j3hPufrEDjGZL
	oKoEt77OToaENoWeg8XHiBgnH7ghr7rn8B4iA
X-Gm-Gg: AYBFou0vKOgJXb87dokQNNDuv1whZUrRL5UVNKPQy8ddg+1Km1vfWzuf3BokbmdYrCK
	ziLZaokY6P+u0LK1HUlYAz2fuWOaBcTACrIqOIeBGNBkikCz0Ztg4rKpsnSwTFdkH8gsFoeK0Kr
	DRNqPT7KWyoPW37j1xLZGH9bfa8KXkK2fkNzmYqcZJAMQd41RJsZHcCP/EcnjuTxjx0miDGFmHz
	ZymKShOzFqx5kUjqpuHRKKDve19jtLM+qmiwDDxE6SMoXlgB3WSJB4e4IIclZDGzLRSaGLT0/Bf
	HLFvB5l6QzMPn1cPes+3f4v9GiH4QKHb2huxZqzZqjt0pEFQlV6pzL6O
X-Received: by 2002:a05:6870:aa9a:b0:449:bccf:bb67 with SMTP id
 586e51a60fabf-4755157d71amr13380565fac.5.1788711943580; Sun, 06 Sep 2026
 09:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906114049.32912-1-abdelnasserhussein11@gmail.com> <20260906162010.07781ebe@systembl0wer>
In-Reply-To: <20260906162010.07781ebe@systembl0wer>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Sun, 6 Sep 2026 19:25:10 +0300
X-Gm-Features: AcwNN1W60xdRW7NqkHxR6ohHNio2xhsVYb3KM6Hg5RkJycqi7OOnjevUnUQBUhM
Message-ID: <CANpqX3aFVx1KgF_THty7ba_DVZf869cto1F=qkikjjSCjkueEQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] staging: iio: adc: ad7816: Fix SPI read operations
 and VMAP_STACK issue
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hi Joshua,

Thanks a lot for the detailed review and for catching these issues.
i apologize for the bisectability breakage. I now realize that
removing buf and missing the lock declaration in patch 1 caused the
build errors.
I will fix the commit splitting, adjust the commit message wrapping,
sort the includes correctly, and add a proper cover letter
description.
I will test each commit separately and send v5 shortly.

Thanks,
Abdelnasser
