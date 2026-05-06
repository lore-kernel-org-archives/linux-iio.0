Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB9428474
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074034; cv=pass; b=sagikLV1GZbP9a2kZNymIatOHLLLhi3651OQWu2HSx5eK2rcL9LKWn81sy03lZIvvL/VW88+/zh3ODauwFUCJU9UljgD59wHbZZhPQt6GEDncwfcZez6bVrRBdn4M4hm00KbKQgVJlfekIasNiJRU9KQaNPLODxCCogU15QgVVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074034; c=relaxed/simple;
	bh=ZttEGwRG6BvXaKhO5hZe1t1mv41D0nIlKx8j6dwTSWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3dwUexkf1Z3OsyaNyAcZeMRsQ/Oi823QIPCRUT8WmuDBsPVw5AYkQ8pLF2PHipxeO3LJXsNjafFcLoD2mtnhAxDw1kwvgkCUQO3VC1yKKFb6RYNoPqh59NiJIWyXjK2HreztTVpme/O7cUKUfTXcrQuMFm1hkem4fxIrsq8hac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoK4qc0H; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoK4qc0H"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bdec52f48dso10901957b3.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 06:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778074032; cv=none;
        d=google.com; s=arc-20240605;
        b=HTiVRENf48RFyiNUQ74EmAdbCp2LbguGD2FXlpogwI5nn97yDsoNrwaNHEiU80pC/e
         eFrqbxL7zlG8gil8FqOmVecGwIKY7j6aP7hYMnUd5q7/RkPp/aE27DRTR5wseYHTacH1
         EU6Y7eE+WCNs6ldpT3bvqeqNWNhvUtQ/VdLv29YG9qD++CQuDFXZvaNynKSdXxlkJFk/
         rBQutfZgmUoAbdIfX1+sjTSTWOBtmDxS0U6LysHp1jv+nIzIxBnVxdbGv35a40wdUX1e
         YatfCJgH1IeUsREbJxbL9osvq6ggxnQN703GnkFTEvHlMZu4KtbG1rLxRpslOdiXykqz
         ScmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ITRX6h8VK5TWeXB90cJ0dP/H7zt7FheayI3E4fFA2tU=;
        fh=KTWq+B9oL2mcBHbVQ3qVRbPwQ007ZwD9rGwSq6fgdqw=;
        b=cjD6DPKx+rsnBlbakJa+suMqjw1p+SS86x4FCXppRHoE1DYLICvY4zAtZ4VktYxh/p
         sYXCk0CsOb4zxcLCc/D+jVXXag+B2UBNcEigRfI8InY5xl6qisiutlVz6+x43i9Ixdnh
         qTTrK7ITcE50U5ZAxCH9rxGr4zIJrrFPkUkKJvVOkSj+yge+WryhY5FY60oK6Vrp4+Xc
         a71n4fBie/ZgIsobQzoNwUDoQDVz/7yCuSVdCe/Mn2yrNtibKrPOVHSty0nu+devdcFy
         Etiu9cvyvoxAgesqYBzOuVdUsNikb1e9KS1hcS/+R4GASgaj90GrN2rzM6aBBLjJyvQl
         j4ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778074032; x=1778678832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITRX6h8VK5TWeXB90cJ0dP/H7zt7FheayI3E4fFA2tU=;
        b=OoK4qc0Htnfn4Te9kj7HOW8J1LwC927dtC5YMYIdf3VR0m8rHlGf1dLYlWaxEQUmF3
         YHXqgNqOS/Veq9NHw2QMZd+5f1Yg+qxZk6/brsoiB5zhzRUlGXffRlrFC2hO4o4NouOb
         0otxzsExbGct5mWj21m85K2aTJnBhRBZj8SgDay2tjVOGXHwJeZwCi7hYiPgPa2TK2QF
         cGaLNNu4mYqzopWxMeqQdQLBIO5gQ5ZxJ4AQYbRip1dUNhacLkdWuM/xPjL/BYJHy/WY
         6arpJFhnJyGrPiJpH8kcL7yIq909KE8gZ9EbqSrqXNtMnZzosk7QxsIWlRAwszKtwG0y
         0W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074032; x=1778678832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITRX6h8VK5TWeXB90cJ0dP/H7zt7FheayI3E4fFA2tU=;
        b=qTrLAyTTA/N6kLQm3Fr4Hjqv/denJXqw2o+Fs5S2G29jspsW3emkvcnh7U4V97zXxa
         /nmlZlqbNGw3u3QkedTlzxOKgVfDKU1I7hD1e7SkcLxWonV7zynlYCTsCqrZr6DVoylt
         n/9Kvrkvjjlkt8kvJxfOJMmCD30PfCVpF5/FAY0J0KI3L03c+Zl1ODlf/t6rmvwS/fsB
         gNhO/jiHCFpuAuipw5+1LueUftVllqxnG2OGrZ7IgHvO2yoiaNBo+yg4KEOGnz+EH4QO
         ficZZ2tvUJE85nIgS14dROwIAeB1mu25gpx5IKGdODTJlRh4gtCsM+LpK4WxbqBzZdDj
         lx2w==
X-Forwarded-Encrypted: i=1; AFNElJ/Olvan/dZN4Ux2kgR4QokzECqXQ9Vacm4Aoy9nqXkWbhcUrGJbp1iGhit8nW5uV6JDxyFHGrq1uCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy94YjiaXR3satBr8WoF1RD3kOFn/FfIjVocbuP5BA2GOz+sSBB
	iS2S8OsNvH5NR2oVz6abiS4bE/iwtgjjSDMSfdhso5opHudxJdQ/Vpm2MP3Yffxo1aWo0oXRoja
	OEdo703X0knjgIOG1tpbm2KVka+zPrPI=
X-Gm-Gg: AeBDieufOwzFyx4m6qw2rWuuBAkuoUBPIWuu6fdOkO7ZJ/f6n6MzmeKHNQbnTcrERcR
	S1gAoao2fmKdJAZjava23EMB5PLhz4n7r6x7nbHCElBYSjqNxpewtlKkBzL9IU76K/rZJZTbx4f
	0IEzFNSq+H2HM1gkhxWOoyMNZk2lKzeSogiRsEn1sRsXZ4O6FWeP95/Texc2FCAuEc4Q45s2VNm
	l8YF9HQNIEpgMMK4Q4nZ/EJ8iQikORVHegQBIMLUyK8rJE45DQYNmOO8g+itfn8imWkXPeT1bu3
	6ym9cUO+F+Y8wnGoypzw
X-Received: by 2002:a05:690c:39d:b0:7b2:9347:7ba7 with SMTP id
 00721157ae682-7bdf66810eamr25983617b3.22.1778074032485; Wed, 06 May 2026
 06:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506082755.860523-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260506082755.860523-1-andriy.shevchenko@linux.intel.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 6 May 2026 08:27:00 -0500
X-Gm-Features: AVHnY4LEZo1CbHuZFVP6BHuZa_qYHzNgRNZ1txIVd8ZaDp8wif24AUyLl7Gs_bk
Message-ID: <CAKqfh0H=EQO8DQ-2fUKjj76yX0Csgj+FvWFq+WiKC8Fa5D_tgg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: magnetometer: ak8975: Add missed
 pm_runtime_put_autosuspend() call
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, joshua.crofts1@gmail.com, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 3:28=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On the failure in the ak8975_read_axis() the PM runtime gets unbalanced.
> Balance it by calling pm_runtime_put_autosuspend() on error path as well.
>
> Fixes: cde4cb5dd422 ("iio: magn: ak8975: deploy runtime and system PM")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260505-magnetometer-fixes-v5-0-8=
31b9b5550fc%40gmail.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 1 +
>  1 file changed, 1 insertion(+)
>
[snip]
>

Looks fine to me but I'm not in a position to give a formal rb, as I
can't compile-test it right now. If Jonathan gives it the green light
then if he wants he can add my tag but that's at his discretion and
not totally necessary since Joshua already gave his rb.

best regards,
max
