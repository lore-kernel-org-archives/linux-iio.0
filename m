Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB692D249B
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160236; cv=pass; b=N7g93S34ZTgjgvy8R6uwrbXlQvzKeJvZDt/nP4QA8+GG/jmxtvPwNPa67TPNkQN6dsd2qZ6ClP4FsSifmOwFQjdmzYV1wCGTgJnMuIrRfN9BatPc+0E5a94khuGsRnF7deDPgmrz4HQzRQx3+Fo5JxX7OS9HQ7QZ088tIeKjliA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160236; c=relaxed/simple;
	bh=gUAcvDj0Z5UxopQLEUn0PjKEO9lWPOYo3eLeateQ3oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRKEF0WdwaOYBR2Al0CWzL9Mvog+6PogfDDu6t7UlFe9/iTfRfhMPlImsjrUpPJr06CpG187WE5tc6zvrmIYBclT9m5IYxZxXsv63RhLkRJnkGGXkQ216aR2WpdrdcmXvX+E+RU7PuwkjP4vYUOoSBmgCbQX6wEELuxHZcHKrGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf4X2ngP; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf4X2ngP"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-668bec50cc7so308291d50.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 06:50:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785160235; cv=none;
        d=google.com; s=arc-20260327;
        b=oM5kIOjZmlgxhp9oQcHrzWb7vLO5JerAchj50Ru2OxMyLF0VY28oIb51+D21S4uKqN
         WqbtrrErur8rEzXu0WyP/GBmSudpHpX89a2LPV5Mbol2t3mp/K+gq6vkKXVvr3XSkuJA
         rm6usZOG1fNAB1LCOp/Df5oktMh9TFPTZOEJu1AY3Yo++Jwwo8oQs1dXFKqMizBbVuXu
         Ff0HWxBGntP714lY8zHL4RcLFAs6Lqrcuig0AkD1qy3p9dxl/wkd+cwhTNLDgfVfwoug
         Ezil4D6o7KFp3YvrlmWkKVICfKk7SkDaAqmlns+Gj3QHbP5uB7+4CMy0W2XQPPltJOtJ
         /LVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gUAcvDj0Z5UxopQLEUn0PjKEO9lWPOYo3eLeateQ3oo=;
        fh=aAGj2FMoVrh+6d/S6F13SSOSVWybm2PnfHyaLJJN5cI=;
        b=o0F24eDpmaMJxqjxBhcQHWZnkivLO9miTEaVgVKyZUmJCvOQMu7AOO3O4INcePa2i4
         hU9KDA68q8kn8xW2y7kEDMDiLbg8xxSf51j2ZaKdDHgaeaAfoX/a91OiJmyBLoRQLkux
         ypCrLABU5fyMwV2mBg3upntDjarj19huERzwBgrIgAKcAXvGRgCxYXpDZrnKm1uNXMk8
         Pz3/aNMim6pmQhsMKkSrATUtLF6hcHSw3cFDTLClrKhDcG8wnkpiAyRhp1x5eiFkwfVP
         sNopgVATvQT3BiZuKNe0L2npTRh+4sRzl2EaAmBbqSnpNvTcHxRx7DsnCOPuA/gWxgia
         fbbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785160235; x=1785765035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gUAcvDj0Z5UxopQLEUn0PjKEO9lWPOYo3eLeateQ3oo=;
        b=Zf4X2ngP8lm/0nnyMB2l2i+ZmpjvInbFTI3qZNdb/e3VmCDZzevbB0ERcRPWzPXXWh
         yqw398NlGewA3UcbrjtnQCErEU05VQ+P7hmVh9zwwRw+47d/O9714WSndhqDGGfiIkoq
         ZDbPFfu54OsvKzFsYXjhToCd6Abbd3/E7d542fbb247/nqLyAABOCJWZPDIZD38L3u/8
         rIbktYLzbu8M/7bzG8giSBbWcf5DUdgAycNzhQL/Y4Rqfcco3WBa/36U0bl0hzBUrZIa
         ri1B5vwdeQq+z8AJhRNCtPPXYi4SmPLjn8uKbHLId8q7Q/k65urcP+00AQ6Sc1Z9Q6ZB
         2/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785160235; x=1785765035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gUAcvDj0Z5UxopQLEUn0PjKEO9lWPOYo3eLeateQ3oo=;
        b=RUNl/VM70ET6Nrw4cQ2CdJz4wiI0hZxLREcurINMG3EiRrFMrHm7jAvAa3Rt+FJnnL
         i//pKc2CXdOEjHpe+hVWReNWIwpQYV7/znrr1R2BynRzhj4099/De/Y9VHrugNSxNZZo
         lClg8is3ydNZivi3C9JTZ3NMps6HL2iUrsVBwbczzS5b2fC1Gf70vUvgaAieLIxGnxvb
         qbN3V2MNBpJ3mxuCJx49bum2bS13/t+5jUvAxuz9Z1ujNsXUrPrm7YH6zHBTcViMHdHE
         td/mmrisROpDh3n8U+amb1++hUmUAV5OZT+bxZpXhREKGE5zDOaCzveQUZJE61IyAXaX
         dAnA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0VFTuy44/+8R46Ehjd4HrS8lOWEma4BISpp7cEmCu26BKNxGWxIseElhbmWniqMvw0/JaKr9idHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZiFaJHd0JFtG2/9yrG7NpOiYWvf4wv6L1lPZeGS34u5EywIHV
	XU6Zz9GGDF6cBCb8ieA7lnzuZLqQw00zr8KsIvG2lfBMiHUNPhAzCdJa1GczVzrq/nHy0UPYD9p
	4Owj+4yVCx5U5K6FVaAeqmd+qoz+CVsY=
X-Gm-Gg: AR+sD13pohwNhvxUbhLGU6LwQPLysP/sVZTjoey05jKIDoQg/PijfodmjBg/5dsqwQR
	InIiHVTwuiolz1fbCczQKjUgnTB1UE1fx1GBZIR5uFUXgeUid3t2Lw1zEIl8CggRiFXGDxeig+E
	6dpV4gpRiwa9kp2eT2voKYDaRiPgnqnLwofz/6B/coTQ0E2sDHUm7hR8lT3EB4Ig12QTaYg9GlA
	d2NClpli/wuyVBGuI8Zv8IFCZ9+pLtCvxx9tGfVNoNMY/JQCy7LeRa44NDkEByUCBTuCG7Kapq/
	r4cOC7JWCw2afX8+zoQM3wM3gpZR5H+2NIRUjbC49dtEKhEzakiXPNXvCO1wGTfG7jpHUVOASrm
	8
X-Received: by 2002:a05:690e:bc8:b0:668:43a3:9de3 with SMTP id
 956f58d0204a3-668c7922eb1mr3638073d50.3.1785160234667; Mon, 27 Jul 2026
 06:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727112726.211344-1-giorgitchankvetadze1997@gmail.com> <90018da7-8d84-4bfd-b2e1-f832ca03f764@baylibre.com>
In-Reply-To: <90018da7-8d84-4bfd-b2e1-f832ca03f764@baylibre.com>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Mon, 27 Jul 2026 17:50:23 +0400
X-Gm-Features: AUfX_mx334-2Uvj8PwNQbPKIVYKTCe-t3WcWlU7u3_yPq6LgPUgzWuKm5xATpyc
Message-ID: <CAE7dp2qeg=Zzrr+cqOEJOnn7UudiD=a=_578T3OzKCPTX28JmA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: veml3328: remove redundant cast in read_avail
To: David Lechner <dlechner@baylibre.com>
Cc: joshua.crofts1@gmail.com, jic23@kernel.org, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:16=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Usually, we would declare the array like:
>
> static const int veml3328_scale_vals[4][4][2] ...
>
> in which case this cast would be needed.
>
>
I intentionally kept the patch tiny and dealt with the obvious thing,
but yes, I agree this is how it should be done.
