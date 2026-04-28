Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5773F23CF
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375086; cv=pass; b=MBBO8jUjApVoghSm+olsLYBEFf6Wq/TBeACfYpRTs30DOWhct3ggO55dVFOeKScoD59mzltci020VWwcWYu4dofqdZbpNhaIzFVQ5/Dr8o2KyYni5A6zGIASHo1ZcPIR5X0lUiKkdETjlg44LhB5hLcgrBT2/5oXnQ4NVwLes10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375086; c=relaxed/simple;
	bh=diMYsSvTborcsw79tX2XGDpdpcZAwLsnJ5NUfjZllKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V43DyUQKpu+lsLRzzj3aAq9C7PjFUdEau0kBpik2pb0xFDkJ1b/DXAGXlGZKqeHzzuT46doT3gGV0apUJWH0y3hY2x1S+9NRiRw/UI7yAuUggW7/6rSa1/ZPFlEZF9qQzMODfEc8wQHArGDrDtK5jRg9IADmgkBZIKlyCDXgjm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oEywf+SZ; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEywf+SZ"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651c7ddf514so10234532d50.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 04:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777375084; cv=none;
        d=google.com; s=arc-20240605;
        b=agUv5dYHeciexCuDul/LkX2D5Km8WlxVRWE3IQPFjyr/p84pyAJFWjKyxZqzBwjF1v
         ZR2w1+aJPw84/Dn+1ZIpHGNIe6waEhWK7zmQq+mObsfwjoWtYApT5nPh9Jkt7Yj488X5
         BJkbpPll9hkK9+l3Uugs03rZQ0I3fu2TN+SmA9Hv5SJ+Me4Dj1jkFZUf4aDk9XBjtLk1
         FNgSePWetfXjyLq9JxuoX5ZGT5S0tPc+bY9QHZpqTViEW7XYaDzQUffsZGQLyWrodCyI
         QFuUmkcE0JdTGpZXiPVL61hm416SptRYo3OhCm8tzhhyI9LULZJ/504nqrnFeSarBy85
         94Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K2JDmDW7B6i2byWW0osyPjunlda3Lsyk2odGkmyWuAE=;
        fh=09LoV3RQS1m8GNeE522pT4/2aBA+e8/CzD+r0Nh8I/8=;
        b=cP0voDtbgzHyv0rb6IuraU3XqMCCPYFjmwB0fz8ZcAJzWXiPG3OwDqag0v/qmurLXP
         6z8+WPOXA2DTQR5GcREvB1a7AoQWMyXVDpaRAf1gxGizRnZ1tYqm6RneHpU8jxDOdBhu
         cfD7Nj1MoEs7pzg7xJRsY5bVv7P6U6EA/tZpIK1MiCFnxnWC2Am8NefZAdnGgD95NqYP
         X0zKcPp86P9qFDQjaouGhcKJ/uKI5b+hkJVryRU0kVvfxvKL90oM/3dKQLfyFWMV0Taf
         ps8k3xkpsExOiff+Ac6+T4E6ZbvZqn30JOpk6gfVoeTMFmVjPSVyyQ+G+zBsVUvF9Aly
         rgXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777375084; x=1777979884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2JDmDW7B6i2byWW0osyPjunlda3Lsyk2odGkmyWuAE=;
        b=oEywf+SZPoxLVSD5XjWwFz+e+VbcjvB7JJLDkW5fxesXSMi2eAxn0HdUIgitWFLiC8
         MfAmedN9ZnjCJ0bIv8ei7u3yZidKXFoe4YppU/xJ7UqPy1v2aWg6E/t+luc9Ai6NKOKq
         Wp9Hscth6aWlv6/A+idoGqsLu2nkFVfLmMwra51QSRBTfan6cTU9hYLSxod19y10/Cnq
         OcZnABkpmLl2uepWftLDPNAi4AOGVYWNlNvRhUQh7lgc2x5tHXWzoWAxdvRHQRfFvhEP
         OgkvuHNAn5V5iupuU/QpXR+nWe8SLp+tY8sEgENtrIrA6EwBEc9YFGvGMw047Kq5LyFY
         7uFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777375084; x=1777979884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2JDmDW7B6i2byWW0osyPjunlda3Lsyk2odGkmyWuAE=;
        b=XbqnDU+Llec/Hx2rsRkjgjsCKL5X3tNg+UczrWFhfOR3GNwmJRuoPrXBQdJgkgJ+Vq
         HScZ7vtXcjkTQ77ygjK1jkv+HlmGgAT0G/Y63NipENT5ifrEk1g5IAwkdeEdCxHIM7nY
         IsfX6sMfwZFyBWIJo4hKijjwqf+6//t9Qs4TxqvYCEI3lhVFYPJqpQ/i09h1LwXn9h+7
         aQ93Hr4CuNq/Kya6pb5eKzZKzA/CNr/6gW6edH7zIdtVQgd+snogTYHLG7o7WXKffnu0
         SEFsYngdJHLF+4NMfQhhYTb8yLNOMVJclMHlsijIpC0Bv1bVEBXaUdvp7HpLXCvGMw5g
         ZFZA==
X-Forwarded-Encrypted: i=1; AFNElJ//6rcJuW8dbcOJHuncSNCe5r1S5j7Re+OvoVujTi5YvkicjFiyAF2yYaR0S+paMKjIrpO6uaDM7CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4V12CC81Pan70lPHRcHgvUruqrUCNkbDhYwppm/xp09eJJdD
	MTT+/Qsw67blB1Otw3QlgrphNKhTljVTedzkIRn8nkKRd2lWa9Nkmm7FEham1yMFHnATmT5lcs2
	CcX1PI8o8qqUomk2V1UyBndtse1+UXwk=
X-Gm-Gg: AeBDiesMzgNfwC/53ZAN095kfd6ua920iWUTBmFGwLeiz4sh3zJTqAhOSAbp1bQNXTw
	SlVVm5S9wYLhqscA+I2NOBMXsUloW5QeLDUuuxDIrtxHxdEvOo4biv1lV0kFo1IAiKv9BteKE9C
	P1I0emRdKVbMSs5nfp9afVjOUmY3EuKiQp8rgN7IROrR4SavgcWAe5nB5nua9JlUYoEfGOhIi+J
	AjwtRAqHxxuolwUNAMAOcQ580756vNu50ThIolgsE+7SWlouPTrnxj5482ltLKmECwrJtBqtC4O
	Zh5nQ8XApuF2LsA=
X-Received: by 2002:a05:690e:4842:b0:651:c8af:53c0 with SMTP id
 956f58d0204a3-65beee43c58mr1575882d50.36.1777375083954; Tue, 28 Apr 2026
 04:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428024339.45109-1-m32285159@gmail.com> <20260428024339.45109-5-m32285159@gmail.com>
 <afCGTCygrPDYs2-C@ashevche-desk.local>
In-Reply-To: <afCGTCygrPDYs2-C@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 28 Apr 2026 06:17:53 -0500
X-Gm-Features: AVHnY4LN_IZF4xLuhcUP9EVV3-41MJ-7rrKASdHlVcPfaHTis-qrdQ-9ZMXElXI
Message-ID: <CAKqfh0G_yx2H7aThFPxWHFkXKvqO6pbfpPJyFH3+6mv=nYA-fQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: magnetometer: rm3100: Use scoped_guard in rm3100_trigger_handler()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 5:05=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> > +     scoped_guard(mutex, &data->lock) {
>
> > +                     if (ret < 0)
> > +                             goto done;
>
>
> This is simply wrong.
>

Sorry, didn't realize goto was so blunt as to bypass
__attribute__((cleanup)), I rarely use it myself. I'll get that fixed
right away.

best regards
maxwell
