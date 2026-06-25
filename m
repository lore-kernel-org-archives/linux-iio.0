Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF3373BE8
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374138; cv=pass; b=poiTBS7larIs6fo5Z9s6JCWGmDF8J4JO/eolyenGkHXlREjNVM5ijkyVH36d1cFSYTRKmWIzluhIlMnBAfh7MO6t/gXRcFiIWr3M6eqzbFuDjl29ygn+v1wsqY5A6DUO/YB8/IC3Ro9cKSuY7xsGKp6sdXgaBtNZ+poVd5RTDAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374138; c=relaxed/simple;
	bh=UeixKLDd1bxLQVD2tdQf18Y4CR1YFUz/5IolhY6Scdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLtNYPq5QlG6Ik0ut2otEaLPLIezterVpoF0wbbH5Y+RUP4nPmHdzkH+h9z+tL4fRpVgyZzoaFqgNmyS0zWLLeEMwai+l+xqiKMGKyxNG6J/B2nuF85cLdrAkbrZxPFQteovyQ9FbMJLd8zpAvDygqe3By8QJnIMagu7RuhguxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=1CWqQZZr; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="1CWqQZZr"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9204711e831so203053485a.2
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 00:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782374136; cv=none;
        d=google.com; s=arc-20260327;
        b=GeuqjjNbK3We8tPmbrGE8Bywa1xuGl1FOO3ToxUByo8zxg61gSB6gYDC6+0t4QeBhh
         C1/fDJFnBYBidnt89xTiIFsLdmnBwLpbHLKq9+vw1SpBSwV3zA8AeQ+KsddWBfjkswdo
         Z6MQJ6suVHz2RPLNjIVVWnW8Arnzn48vBtvSVQP3OeHJh12lFB/9kK4rdhef5eRufNV4
         LMkvP08OrkQ5pp86SNRqYH63AhckVxbdJUda0ypAWFghVODRdzxK5KdvoYuGfN4x8TNq
         qRBqh5U2/BMeX+Qg767E9DDiteCPkcW4jQTkGpVXjX0fgEgh6YVNF5tPo9fukdM80x4D
         E+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UeixKLDd1bxLQVD2tdQf18Y4CR1YFUz/5IolhY6Scdw=;
        fh=oMif+kxu6hs0qxy6jQgRgF2PuS1oQHUxQFAaCEV/9v4=;
        b=jxmvrPl2PkFix4o0/atU85l3njebS13ep4TUAgaafqvhvKMVPmHXuv3NGqnWTY2nxb
         9hFkbveNmafY+jVP1+DPcftJw2dL3VQY0B8ltUZPMhkrtM+8dkBHJxizQpy2Lg7v/4Cd
         IKuE5Egk+IaBNlfZoKcuiu8kDHaIpFIjbYb7igzMf/YDW3R11BNtg59LeTl+wL0yVB+N
         wsxAGjsTaioiuK+z/YsbUYGaJtva+CnRc8r26Sne5AfG/8YuvvQsN4kkfLfTkdFcCnfr
         N3utXnZ49DrEsQfwHtSxwLp9bBRmYr5m0Pf9nD8rYPLTw9MLV87CNN946kIb7qeW/mPr
         X3yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1782374136; x=1782978936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UeixKLDd1bxLQVD2tdQf18Y4CR1YFUz/5IolhY6Scdw=;
        b=1CWqQZZrZRfJWTcyZ9Z+tZVza4eR5QbVhJcDmuIvP+87DTN73i0WeXLF7qR8ajFHrO
         W9F0oJJ23MX42n1DUvnBCsARqXQe2deL26DjfyWRY51kTiqFiW7vprT+KyV2+Q2l516z
         CdxkQuTYn42Paef64UUSVQ8zlevcKLwpZW31pzu4bPnnp2aJcYM38vy5/4BUeTVmamgI
         cBZ8alAKH9kCewfzqO+OYhIHMbHWwsPCfrPlF2Pecp/VXaFheMz9ihs6MYBfams+w3Vx
         eDX4tbR/Oy2ZrAwLRVzTf8SNAYCVuMAzwSfVZK4cDl5WA/zSUYb/Z+/ICI9DNPUONqo1
         mPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782374136; x=1782978936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeixKLDd1bxLQVD2tdQf18Y4CR1YFUz/5IolhY6Scdw=;
        b=Fnp4X+65J7JLEo4g1nMIkEs6a45DW65e/YisCda6VIk2kJgyE+hN6VG+9MlUKH+ILi
         Sd9ZM9b/1TaOtB3f1QDzqLLbCacXja9Tm0bM6ExIn/A9fswVlwNA7Z8dmSlHgLn5Ce49
         FUGj2i9TMR4OnGjRXNu64lbmIMCeU8c9CNjQl26P1OdLzwaD1XAGB1xaDX4UtrBZqri/
         EOhbI2wYmBWwUmU7SbANcN6rxsCSMstwQjeg1KJInYquawFmPMoecbYMaCPzBNVH21lH
         quTYFgw0VypzF5AmiPvp1xbTvYBwsPhWJxmX6IbBDvKdAEOAJdESv/cffZg5cBUPssgK
         9f4w==
X-Forwarded-Encrypted: i=1; AFNElJ9TMCG0YGMeKmPiwz1gWTh8wBpyVJIGqI6MyOUt54/pzqbnexcVOZXr6ESAFydfiL/+t1wkzJ59alw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3u7CZjkJGy3LIBE6OfylrrzgE4EEHyX4i+U02VustyMwMiLBc
	yb3J+FKJhwwCAWtmDIouJ4bOwIYpIl3eXbdS9Tv3sW1JEoyG6B9dSjeMI0BnEAjJewKHrgcqheC
	T0bMzOszGFSqSuHW5js3LB3uFIi77+NqTk7LtEs8P
X-Gm-Gg: AfdE7cnZQ6y2NxBwgJG+oKjs+LCeuitbEqLsZyPpszgpv+vTwk9gJOVFBfp/FTCdm/L
	/5bGKs7oYFu+h/NB2n9WmJNJZQdaT6WcAW+vA1xdTXjlOrkj+F5utPVmbkF17uyWNZPl+gs0Qic
	2hUqAwgg3qZKCwaslupZqmhrYq+VIbMaTKzU484vG9uNb56n2i3es4Ng5FcMgAX8sAmTgdK1B5q
	QioFqzOoPi761Ywjk9AHPYDo0FIG1zSd2JEyvBAL1a/WJMAgZbqPt/XImY3FH43XZLl0w==
X-Received: by 2002:a05:620a:3912:b0:915:745a:70fe with SMTP id
 af79cd13be357-9293c11e3cfmr179731185a.28.1782374135581; Thu, 25 Jun 2026
 00:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624081309.77805-1-pengpeng@iscas.ac.cn> <20260625054259.76774-1-pengpeng@iscas.ac.cn>
 <ajzOA3MGaCqrgCDp@ashevche-desk.local>
In-Reply-To: <ajzOA3MGaCqrgCDp@ashevche-desk.local>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 25 Jun 2026 09:54:58 +0200
X-Gm-Features: AVVi8Cf0Kq8KvxED7bUTegw9DwvGkx-iAJ0WMlc-jUAjlQ3zb6kIh99CFD1m9KI
Message-ID: <CAKv63uupUcUGXwXJQL957YtUmP+OZ5makvGROvFuvS8BWF-sPQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: temperature: Build mlx90635 with CONFIG_MLX90635
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for spotting this Pengpeng Hou; it's strange that nobody
noticed until now. I would like to apologize to everyone for this
mistake.

Acked-by: Crt Mori <cmo@melexis.com>

On Thu, 25 Jun 2026 at 08:43, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Jun 25, 2026 at 01:42:59PM +0800, Pengpeng Hou wrote:
> > drivers/iio/temperature/Kconfig has a dedicated MLX90635 option, but
> > the Makefile currently builds mlx90635.o under CONFIG_MLX90632.
> >
> > This means enabling CONFIG_MLX90635 alone does not carry its provider
> > object into the build, while enabling CONFIG_MLX90632 unexpectedly also
> > builds mlx90635.o.
> >
> > Gate mlx90635.o on the matching generated Kconfig symbol.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
