Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279A30CD95
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781818035; cv=pass; b=D1ziKE1hpChrDBBnCU2GkhKzHDzUQKohV5gjPhQhCkQJmS6hc+nIzUH14bxAhV8jYAP222n5m/Ml+lnw+rqh2si+Qz9klFgLxjDF32MA9eJLVjZ1S5ggdEZD8aw47i2yWxv3lL8K5qjWaaFOyHq6tEeoFHQ+1AGZWka5ymLM2Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781818035; c=relaxed/simple;
	bh=uCaE6lpNYfg6rpbBBIUraul0cNxTJ/fXIE3iScgkJIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahdFrac9+6lmkMCrGag6Ff5L9mrsPoVc4tIKBfsb9lxwTCUfjr3s8IqViyoAztAludRFItC/d1B0uoN3IjQjsTy2PYnkAHKqbQ+NpPiZravCYvl6ziQ/o1e+HCcDaktj9wmk4CVZOiJeUx+m/9DuohH8GWn3yXFCpzJYV0iIg/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mheLAP2u; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mheLAP2u"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66061993121so1678331d50.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 14:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781818033; cv=none;
        d=google.com; s=arc-20240605;
        b=j8vPjJPL1ykoznkNj9Ak9wTHoqRq0WpPVve41czMMlqo79TI+fws+4i0K7zQtoC6VQ
         WXMzBMBdp6M5QJp3pQm3APlOGYikR/afgDKAx3Zjq5nFp7WiS0iaVceskQO6i6q8ypx5
         OxLMCtLDJynZTo6eiPwHUGu0yIu8PlLIMb8EEsZWcymd5oI/2O3d6JqUEglNg6k6rwoz
         pw/pUWjDktnbt7pQW9rL+za+jHGpzZ9O3iCZXS+dU9SwvFUfFNbW0ny910LQoUiG718D
         t+2MCiIrvnc/uko7fu1QekPtZE2ab0cVuQ36ecenBu+3XEQQM0A+RRr/4keP920/+z70
         m/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HgEj8OZN6wkNo3us5kJjTEmTYepvy3ZtjSxbxfajlNc=;
        fh=Qiv26Nsno0rh2O3Um/TwGtqRXU1dFH57QqlZ4XF8f5s=;
        b=RUCSiYYY+kPZ0hxIkBXq8TLEzNNs1r9t8P0ob1Em58D5uKOLD5/AaN/7fqSIKiK74k
         NzSTqDMBYsHqcThllUoWhMdhs1piQQ+hTc34ra1+F8FJxNTiXqAyJF67nJlWoC3fIokc
         2gI7lafsZdpqv6e+7YVfC3Y/PDD7juKzuLD5Olahoyedovwyv+wLvSLtysjSOMEo5KJU
         LrA06xxBLIchrDGaNZAq03jnrrlYtuf0gYqP7B+doC9UpDHJMZPL3sesSpBG4jNEc292
         BbYMFM7a259FZbW7MYAXg3WIGdnLV6fGieub1j9EYPZatwLTjB97qvU57AiWOFjzyHxi
         suEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781818033; x=1782422833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgEj8OZN6wkNo3us5kJjTEmTYepvy3ZtjSxbxfajlNc=;
        b=mheLAP2u64dUlHdd+Up7EDVfP7RmpjGcHmKgsQOsMvqjDYTKjJxgvdijZyw0Bv7ol8
         NfTiJx+p8Am7bq3Yb0FkYnEP9YTtdSH1DdbfT54+L/dvgPrDiXM6kfUZCcS1RUugQUJN
         ps4ciqiTadHUd+835OCnAs3Th9UP84KJb6OfdQhIwpOeDg982O5CZ8vfSWoi3qmA0nks
         ttCDzZbgaTNCA51tU1gI6TSKJ1BJksnWTzR/tWoVpXUmlZXu2uwGWCbBTh25PyYsErUN
         g8kC5AVksJYnwNbORalmtpQ5V2Etv6eALK9Ew96IGYvQHZgj1jp/KekldkatowLmYvMp
         q3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781818033; x=1782422833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HgEj8OZN6wkNo3us5kJjTEmTYepvy3ZtjSxbxfajlNc=;
        b=hhNek/veiSVbAk9vqBdG6giJzVAvpkDuTtLXtjkVJ3W/u+YxEKFH48x9v+DrwtXh+E
         6QfncIilkTtlGwn0krfP0IeirFHvE2tPK/pWMRgt3aM8kYBgHXFAwTqfL7q4l7OTJBRo
         qwcFQ/7lppJHcxe1vCmSoI4axC4DeLDfqDQ+fHQoJSdBswEHaOCY5PP7QtU1oOJCj28g
         iNou179BWnPlHNEigqZRcLYRkTK+lH1gH9hY1bC/eToeDyGxZ5JTJi7YJjSgWh+CgMM4
         We6PqyAO0Nb4j/fzAfvpbz0vlLK5ItSguUo9YqOzosQr9hqwPNs9llxpWIPlI8iwXlRq
         F1GA==
X-Forwarded-Encrypted: i=1; AFNElJ8DMn55IHFqVcQ/huGjCRA75JlhGrru3UCDQZlD6b2IjWuQx01v7z5daLxeUMuE4L7BRkQChUTcoxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGjnNvblaZVQbKJ3LVT/S3oIikO5FKHZPHbiYvqOxaJeUBUc4Y
	DNEstl1Q/NVb2QQv+x+8yGHXAcAONKSOm+ltotjIozln++cbga+U8EYrgGedeAmAcvZNMeLl6tA
	uv9hBMy9qSQMgLbZ0QCjhPJftQqVex74=
X-Gm-Gg: AfdE7cmqP4T/rKGigrp/Yn9ywY1AebItReOHN2ROxYuwPem+SIY7qZ20ow4TFemMDdn
	IjOkhZPPBMc2qxGpj1XJmStMI6loPdOlHW/IjsRUd80BoGvKX/2FGAWoTywoZ032bZoVH0fHXCL
	ASllOoOQsu7exBBSS8hoocYmAE0KxRf5aOnNr7Fv8QnPXRMqKjmuiFTtaP0Fb5K6epuHu1nxB7Z
	8Ix3L8ccVrU0oJeumi6upy6oawgoR0vAjVr4WEwMCiqPMH48DLHKra/6nQIk03VnqzVvg==
X-Received: by 2002:a05:690e:1585:20b0:662:d9e2:1c2c with SMTP id
 956f58d0204a3-662fca3c9bdmr1496917d50.36.1781818033041; Thu, 18 Jun 2026
 14:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617172138.114572-1-tduszyns@gmail.com> <CAKqfh0FgB0v8i81_oTcdfvQMqXHpx9sUY4txcz8oeMMDoMPtYw@mail.gmail.com>
In-Reply-To: <CAKqfh0FgB0v8i81_oTcdfvQMqXHpx9sUY4txcz8oeMMDoMPtYw@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 18 Jun 2026 16:27:02 -0500
X-Gm-Features: AVVi8CeIsjyqaAI_LMj24pSMcFfOW5Jcvd1e5z2R0YFSXkA2G0sEcqXlQrV-wq4
Message-ID: <CAKqfh0GF1WCF_85r4F0FTvwEdBPoihynx2VHmT+CtyDfYoRDbQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] iio: chemical: sps30, scd30
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com, 
	jic23@kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 10:40=E2=80=AFAM Maxwell Doose <m32285159@gmail.com=
> wrote:
>
> On Wed, Jun 17, 2026 at 12:22=E2=80=AFPM Tomasz Duszynski <tduszyns@gmail=
.com> wrote:
> >
> > This series replaces old email addresses with a current one to
> > make sure changes show up in my mailbox.
> >
> > v2:
> > - add missing mailmap entry
> >
> > Tomasz Duszynski (2):
> >   iio: chemical: sps30: update email
> >   iio: chemical: scd30: update email
> >
>
> Even though you were the previous maintainer I should probably still
> ack this for the scd30 for good measure, so for scd30 patches:
>
> Acked-by: Maxwell Doose <m32285159@gmail.com>

I also neglected to mention this but I updated your entry in the
dt-bindings for this so you may want to go and add yourself to that as
well.
