Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411C1B3B19
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269200; cv=none; b=syixPjJOMQpCMlES7edgwxn5bQDkhKgVG6XN5frvUdMkzXmzhubwFWzaMuHcQOXPoBt2BAmnZv5uPnMbqWKF7RlTygdoRuEDiDMNTvPMtDfah8N6GxwfzvQPaUAjcJw8tMNlRK7IwGBnHv+dYHEjy2wMUUZfbJBQkEsB7l5eB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269200; c=relaxed/simple;
	bh=PlZFNT4DSHsplnw5ObQRPTaQ6kHLu1/oVOvgaR7oOYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMds5jyPcDUNF3varOV8KJDEncq3wAJSTdLkn7oB/KiJzLhmyceRRfV0GfVYflYfEgpMcgs8x1cFmpm5soIJOJ/ltjJre0ouzHLANlyvJhK29JJXleVEk5dGio0RqpeBz1yivir4jT2POm/kQJfhjg8EQEk/aOdc8DzhUJpnMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nczwjA+I; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nczwjA+I"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso1786615e9.0
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 23:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791269197; x=1791873997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RdJK5FuNUR00hsXJgZNxiTMk9OAmiaJF7mlmoaqH+4s=;
        b=nczwjA+I+1+PpNUHPI3vkEsihEHuDIQhPzi5e1fOWwYzJ801P1g1uL4aC7KqdK4mi4
         DP2C5yqNL97CACLPCw/FZTSiY6qw1IwTknZu7NOpJ1Wo1XDYPH3mxJ7xhNmSKe70OcG9
         B7h4jeFBl2pX4Acqa1XXqCfvmaQrtLs/tnxE7KaJJwBUoZ/GMJ3w6b0GmMtBcOd39ZNl
         MGec3UhI6qUVGOnz4WIO4AW4DX1Wsb1+emiJQSqhEIIQpmPkM6MkWi+OVIUIyjENZU8Y
         e2kRf7dQV8Oc7gzY7xN127hIbitgYDaotJ+GrMMs/s3swHcAHy9YdnYBF1nrSxh3DPxW
         +HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791269197; x=1791873997;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RdJK5FuNUR00hsXJgZNxiTMk9OAmiaJF7mlmoaqH+4s=;
        b=xdl3W9Zdxf21+J09VR5NruT94S03uo6pGy/vqavcbumu6bgzhiU1ric78K4N/I5yyU
         mwgjEnpjLSliAvw9UsJs5NIsdzCRosaRVzYvX/OZDM5rtly0LAMQd/2xu7USxwjl8UOG
         erL3TMbY2fA+k6Rh/0lurNL3kuti7vvkYf2TkY/On3GHySUWZ3IVvKIhJjHKCpbRebHs
         90FisIIDkmpghnSP2aDPDJHaIhqANfNB8eYTKDo+8gR2RC7zh0XzNN2hO6pl5aNaTyLh
         EZP+Uyrw1iJHO6aGMGQrkfJYIp7/eQWOkb0Tj13843sDwmOqDHgqHkLxQL+Au7YHJ4YG
         8E0w==
X-Forwarded-Encrypted: i=1; AKwUvBwnbkYIgDImlLdfLenbSlKaYZvcfJ+SC/bFqMRQaiv7RSdIY8NYk4lSPlisQN+P9CyxrVHHvn3nBWY=@vger.kernel.org
X-Gm-Message-State: AFuF++l5aaO+bZocFFrLYs59tQ7yNQzgw4/5t1feWADQu/QR3ST9YRoW
	TUTlLjD0JnqK7+DXsyp+fu2PugfrwwSLZ1h7WqaGiB6echDAKZEpmiHe
X-Gm-Gg: AYBFou1qcKb6mZZCmVWZkbPXmZNMIc6fr8s8oqqgQK8wCpiQsFr32CB9LVPZ6B9uc30
	gPAu5mZXiBwT9SSvMaOY+06MjGpiOH4IWoddX2tM3VCH/Fb7oXGcngvMyoR0CoF1KhGFUY557zD
	ydCYq4s6zjlTmtLygv3OWhYJgs6eks0VtzAMEXi0GuVANAutrPGnRHnmlLh54WfrOPNjZEfCxdY
	Ij0SwPNwvTRkEjU9rPgGWnWr7XEU7DfmN76dZEPZOprOudKa/nZ3fUiLYeKikNlnim13KwvBRu2
	mBKzve2q1PyyDyLixbT+nPwqMwN8nPyEhnkQYGAH9MJp+jQJazYHUy9GL7r+emYDL5CHMl1utRh
	C9wAECHt6JuBls2aTQlqAJwFwwWuEYHXWIAUSwem/uNMlsq8PIINjPILFCxB9hgPRhO3zdjZHS6
	P20T+wv+VVi5jOpaZ4CIJMbqEezU0XT6pXU9GnwOob4N4dwzH3sYwYTSluCFRCkxk1NcYq5jJvL
	vvaXSnvjNjLgMDHl1DBCYw6pvY+zEaa9DuFfzpW99mJ3z3vUtA7SSB4cpMC7tYto/tEWiWKF1VI
	gbzWzkieZ588/A4plPVPEFniHUOc/RUNGIrHEad0twuEa8v/EhB+DH/tBooqxFQIr4VvQ9/A5/H
	nlhbbe/wVsWOjlDP6Hy81lXzw62/i1dvXI3n8jLNxwz+Tk8sVGEm6PgrgB5/oE3Z6z2x+XL6Mj/
	6jinpO9BB88yWxPMw=
X-Received: by 2002:a05:600c:4443:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a17b53317cmr9187395e9.5.1791269196896;
        Mon, 05 Oct 2026 23:46:36 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178daa115sm48960775e9.9.2026.10.05.23.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:46:36 -0700 (PDT)
Date: Tue, 6 Oct 2026 08:46:35 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, Sean
 Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: imu: inv_icm42600: fix kernel-doc Return:
 sections
Message-ID: <20261006084635.00005bef@gmail.com>
In-Reply-To: <20261006045413.14320-3-kapoorarnav43@gmail.com>
References: <20261006045413.14320-1-kapoorarnav43@gmail.com>
	<20261006045413.14320-3-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 10:24:04 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> kernel-doc expects the return value to be described in a "Return:"
> section. inv_icm42600_buffer_update_watermark(), inv_icm42600_setup()
> and inv_icm42600_irq_init() use "Returns ..." in the body instead,
> so scripts/kernel-doc -Wall warns for each of them, e.g.:
> 
>   Warning: .../inv_icm42600_core.c:511 No description found for
>   return value of 'inv_icm42600_setup'
> 
> Convert them to "Return:" sections. In the watermark comment, move it
> after the description, so the description is not parsed as part of the
> return value section.
> 
> Assisted-by: LLM
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
