Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86026F476
	for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779559509; cv=pass; b=Q1NszzVZuF2dJNA9cFtb3tUZ+XvPwyY9Ka2ACLyt7/6qKyIomjFdUI+MH09sZfh9xkg1efYpycIi79M0hMcj+VlNNJqVlbaHGhJWqCK1seBGGvF5MLvceR1qEucS1Ucr3XZtF4Dsj5t7WQyTU4EWFcyyz3gfhGU/G8kJX6DjR+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779559509; c=relaxed/simple;
	bh=pCf8JfX66t768yvJI2x3Z9KDInicyj8gkOg2QVJdCzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaZXq+pwcgEQT080SOJmJJ3XwlEn5n8Qda6Rg3wO+IUKRqLqhYEbHtFE9EvhUtXIhF27bW7ikk7HL60inSQyxOZbNrSf8T6qvisVsR95fNnUrh8ryMfk35X65vEAgTGUzzP3hdVL+XemxZxDMQM6GXJjKzPsZl6+eNi2nYkpKhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKv0+ulb; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKv0+ulb"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65e15fb394bso5930265d50.2
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 11:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779559507; cv=none;
        d=google.com; s=arc-20240605;
        b=cXVYv81kvKVC94yJp+CIDPn22jQ5RS517x/Hu3hqtM2lItjOxsdRYueQ4nnpjGLfcf
         Ni3T1Lc6ilkj4zSsARqDGyYht2uuvg1q5TTck6HFazBLO1JAP62IdCtAfT2geh+rC6/7
         Gc21YwU/IGveXHKT5y1LyV1rv6VXR1CCJ1w+O8xoFQpsz5HFQFOi4O7BVEbRR8I5NXs4
         3pWXM31QTX1HzOYZ40jtdBFeqHYdf1xvM5tvZYJy9zr2ivNtDE6PUiKrW4mh4JFlf/JJ
         xQ/uvu5+z+yl+XLCQFfDCMWYLS6ig1APkAihdYdRtAPbIO5+uF9tgGVhNg8DC2rT6XIi
         6oMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b2E8cU1g4qhYlwVS5DUr8m1PDv5GVSB/Ee16C5FdCCE=;
        fh=RsYC4d/K6UoReVthaasuxNaQ5eNYAH8rWG6DYVuVNes=;
        b=BPn2IbMAxk2aobfD2IDqDRjrX5R/y3sRop8eH1Q+XtlZUeg+hbB47FEt1p6iPu5u1E
         5qokRSLnVN5lvz56TAmWnxgUJINFG/uxbeRVq88KtVh4kvpwPuqKvsLO7dA/xPYbXI6S
         j805PLiORFICn2OgdnA/PKya6FOQRr2hYfDHXjBWdgrejEfwH+Hl/ZCwv4k6PthKiagz
         pNraJmGSjihRKpVIRY1Q2TSXl/Um3Az4HA2RutbSYrbfgdvWpAuIZA2lUfsP2hlwNjDi
         jjz619wMAUkRiq+wfnBKK24WcQA6JJ+s8Szd8KIWDJ6DvZj03mDJEFITKDuL4P7a7L5R
         jywA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779559507; x=1780164307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2E8cU1g4qhYlwVS5DUr8m1PDv5GVSB/Ee16C5FdCCE=;
        b=qKv0+ulbTBhAT3ehZ9gzdcOcuXXRnyF2jviFZ6LxJUNaxFni2nR8TAGsd36bUOTouI
         dv4K6Imjyd+z9Xa5doe0pyr8Z3d/Eusy+xEYjiD7asoFP0sjDFkIqrjm7JdBUcHWzxAy
         YdmNFCKf45WTfyfo2g1bQbTXtyRwrbNThCuE+OWiDNiq8tb2EgapPCyAoIysfsY9XLpC
         Bvrfdx0OckuyPEES2KjYg6l+aiCkOg73h5XLwiq4Tc6WfNovcatzcWq0OnBx79he6STm
         oibCIuvln/gDlPv1CDgjPKdT6NGy+pHy9Q/y9kyMEm7ASXBdiOSS7V9Px8weZmK0ZBJp
         kC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779559507; x=1780164307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b2E8cU1g4qhYlwVS5DUr8m1PDv5GVSB/Ee16C5FdCCE=;
        b=r24569vkOx2k4ZHOFENQ1myqfWNtXytJW1Mg5hILwbt19BUsJ4bsd8dqbbFnXEneyd
         CqnYSOISRpUJeNNMQTfThVUCvN9SJLLwHP5gH7YQFnvivWu5Z7s1VvoOMT4Wm/6LCA2P
         52gEh1u4+3ZRdz52kfNCpRBFjv/Jk1FOZCWtaMVt6rCpoixKxEXhfu0gzhJbMXg98Ic2
         WREGuxDWGdzvgsXdgX54rc6xzag/QZyq+8HXYLnYk1xSdfSwCAeKaX5QHVtR48iL+UlR
         YqyjrPyjJdgiBBS3GDrJGn4urpMQ0s+YHbHX5bRydD6zK9m8XthE26qjUboZSJX+W1Vc
         57hw==
X-Forwarded-Encrypted: i=1; AFNElJ9tgPQlz8iLsM65Gw4/JT+PFnsOylWtzlkOTWGw0snipLn7q3WTkgq39AnZaXLSkWyqpqj2DaOtTcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBnOfEw7huQ/RRvDOKM/Xx5Ufa8LKuXLZ9uW+Hj+JFzrZJblLP
	EOR+lH07DehZCuLlUBt2TjZRDoqvv6L6ZA9oUjbV/s85lRO1PhXJbTWuHV+XhHw8cVjCGXlp9Jt
	q80T0lEcOm/WMKQNpTFfp7J8HSrLg+mc=
X-Gm-Gg: Acq92OG3zZE2hociZex6InlSmXESuzau+I2zl1W8rtYkSR3Q3W06RII+k7RgoXrc82D
	s0v8VTISz0xEs+00oAG0on+FOXwRSTJFR5Oa8JtaEvUoAM/BqdfkD8f4/akuC61/6j/0ChDnqCq
	PLNete1mqyjzVJT8e4IkvTzQpaegIWFbU1kD5+vhhfgy5Exo2DgddJLWp6kp1+zKKzn2NkuDRoX
	9f2nWk85YL2FFXGEwza9zKMXLGTxbp1CT6KOnUalRvACwJFWaTcbQotrQ2zKnWwlCDBCKpyw8/A
	KiqEyhDpSmBONdW/o9ANOBBwh+vBtHTfzp0FsN8tOQifar8TUBLuMab3WdBdig==
X-Received: by 2002:a05:690e:43db:b0:64e:db50:37fa with SMTP id
 956f58d0204a3-65ec9929a77mr6060823d50.47.1779559507578; Sat, 23 May 2026
 11:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523045610.30925-1-m32285159@gmail.com>
In-Reply-To: <20260523045610.30925-1-m32285159@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 23 May 2026 13:03:31 -0500
X-Gm-Features: AVHnY4KtFZU3lE1KjNxHpAJ0gRbES8bPM7gZHZ3yDU5dnGIoFPlE8J9lsWCrLaU
Message-ID: <CAKqfh0EBD_xRr7PbYrt4RWky=AfqSEE8ife8g7W0GJmMi1_+0g@mail.gmail.com>
Subject: Re: [PATCH v3] iio: chemical: scd30: Replace manual locking with RAII locking
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 11:57=E2=80=AFPM Maxwell Doose <m32285159@gmail.com=
> wrote:
>
> scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> calls. Replace them with the newer guard(mutex)() for cleaner RAII
> patterns and to improve maintainability.
>
> Add new helper function scd30_trigger_handler_helper_locked() containing
> the critical section for scd30_trigger_handler(). After moving
> scd30_trigger_handler()'s critical section into the new helper, tune up
> control logic to return ret early and not memcpy() if it's an error
> condition.
>
> In addition, small refactor to replace "?:" operator with regular
> if/else returns.
>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  v2:
>  - Fix callback issue as noted by Jonathan v1.
>  - Refactor critical section of scd30_trigger_handler() into helper
>    called scd30_trigger_handler_helper_locked().
>  - Revert removal of goto in scd30_trigger_handler().
>
>  v3:
>  - Tune up helper to return early on failure condition per Jonathan's
>    suggestion.
>
>  drivers/iio/chemical/scd30_core.c | 66 ++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 24 deletions(-)
>
[snip]

Disregard, I'm losing my marbles haha. Apparently I forgot to commit
my changes...will fix very shortly.

best regards,
max
