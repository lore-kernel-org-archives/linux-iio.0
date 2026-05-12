Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A3A135A53
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571431; cv=pass; b=oWc/Td9FUp9BQl+teP8Ds4+EXmyz1ibytUZab+WivkhaU526c+haqot8mJz1gUu2Xw1D7x7FVJ+Y74UdVDUYEcC/spzxG4sma6+UirMT7a7n5ZrYpq4wQc24t0WwsAHAFbIpHeTpeiZxniLtdy2arSk72gjQAxsHp3yqzFSItwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571431; c=relaxed/simple;
	bh=Mmka9Yv6ZSH5q7yQGJdSY5bVhZw7nmiozY9rhGBDOg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gg3sdOGPqPWBKyOL/Gzth+lLJNex39Y5EziX2lI/v744WW9xfHetmYRd/obpm+uJD3emwFNet9jo6g17VBaj4MdwQ5iwu+BtL3sc/PQTQb+0d680DXEcX7kIIJoFmXwl7s14xJE+G6ihkMgdfzIeFjMAtd/C6i8xJNpkCrEtBF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlUWbFtF; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlUWbFtF"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-444826c16ffso4494376f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 00:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778571428; cv=none;
        d=google.com; s=arc-20240605;
        b=Af7fJojrzgSMrDeiE7oqNptn25PyqinICKavgGW6huM8mC+XF6IZs+xMtkL4JOzfeO
         uFAbrvbgd4yOvs9yNDJhD6Y7GgwPgDf0oClpV+1ilNJZqOoByLG4yW/Y2eDWM0lRvXp7
         I0DVAT2G34TNf/s+fH+KDA1gZSTfyfi0csjs2LWm+RwB00f5iw+VTA+8SorJeGu+Hl2I
         Fx3dsDh96XOIMKmNXIZ7uV8NXWpTfO+UZCEvJ1WeiYqNGHbz+H/0cHl6vsshfOLnx6gu
         zTL6gzObpM6Mx63/kcczmH/vS1SVbn/tq6adbPBy5Ivr7it2nMdFIAyWIgSnW7K+f7cd
         ax/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=um47eZ+BzDPsOdFFS+52pFfCk9Ztr5o9+n4t0JoWQYU=;
        fh=jOjkcEsaj8mrMKFaNvO2W1P+SAnM3HGQ/Zlked3FP1M=;
        b=HeoOW7gznyH3NAAqWlGqQCqvs4Cbvr9CbCljQcdjQGo2PYj6lb97N70n0KcXDJOYcx
         ykrfC/BKKZxy2P7RxXDO/jo9Hxqb9Ewksl8PBJlCtN1DwFitKsCPRp6ZIPhT1eiaN7Ig
         nhV3nfvMEL/vu+exReUBBukyDoPV/ICWqIVIcK6g/IVzZY3ptigNNop0r5WyTMxBKXf7
         n0k964HQiWmLBrP1S5HT7+xE4JRB6k62uF3k9D/pZVx9wf83Q8Jw1qL/MZzf4rfCr7Tw
         ad/qcCStARIxg+X7FcVWpyZ8L8XbrWgi9EELUFeQVSGhzPF59I4IEWXhoK+YytuTFy8c
         tmxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778571428; x=1779176228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=um47eZ+BzDPsOdFFS+52pFfCk9Ztr5o9+n4t0JoWQYU=;
        b=AlUWbFtF0phLEQEbkeuyAvTza7mtz0s5yzCrQUv+JNCtbChlaAUVyDQ9N6pjlUaBt6
         8LEREMjCRmecga25jUeZL9UOR7X6xiBW/yBbAytsUN9zayFtd1GvWOLtZpF/1QGHceOd
         L4Os9mg0T3KOyjlRROxhcuVAXNRxO39BWh0f+I1/QK/hl6pSvNimvIAcoUQYpdogT9eY
         AIp1QjYQC9nX9V7efqymEr8JY2HfuGrQYzZx4yClCJBn4ZhAIEmPpTL5KZ2MwEDS1sFQ
         NHX9dzZOP3kDK3ad9garnwLqpppQ4Juwr5x49L4RzjHgdNhKOa0rYydMkXu2GNjLKmt2
         mEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571428; x=1779176228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=um47eZ+BzDPsOdFFS+52pFfCk9Ztr5o9+n4t0JoWQYU=;
        b=OuBx3DdxlcXvpLS+UZ8blhG3Nh5525y2+pTh5LKQIkZObAl8V7UrtktFIQJJ0USGL9
         SJdLTdv304Obld9/W7WHyY0qcen7M44kTyCBc/rrOoYONjpNHkWnCPLTesg32cwOHtP0
         ATuCWhu1Iu/pqrcvHnXwMLMxD5zY1AKsdyMkOdrZPlAuMgSB2xXhwt7wCPCI8KaeQok6
         0JOfUiiDfNckbdGizYV2WvEtVIlczIyxbzcwVkqlDd0Bxku2LCdcbCDXvPwcQ+Ruu3Og
         lHt+vtCzFaG0BUNmsk2NdgUgwDb6+eAP4BAIS1zU+WwgGNmFJHMaDk92B1ybuHwJ7RUQ
         TE0w==
X-Forwarded-Encrypted: i=1; AFNElJ+aeKhhCz36ntD0zfQbLsGtpEG7lukM4O6sgr/PblXjDaZGIpzKd3aA+4f5WTwwQsuxJ35ANS5jM+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyspZoeDUGJNDyFK+lkdNU2AoA66upYtHvKlXm7f0+ym0TajkG5
	Sk4bS091tlSuwdZ5MEsMvbXiSLTEXFJXaV9vkvFV+Scg2Y33tCow4c1z+9I45afWfjUHoK/ehmU
	lH08Ybhn3/+5iT8K/PpZY4lTDOA+s9Yg=
X-Gm-Gg: Acq92OEyWTGqFXCdlOgYcQtMA8G2sbowKmhMuyH6u1ZIQKBhHpGavHH3Hu0iYJtwKNo
	u2No96SMYqPsBc/S6K6UKHo9GIuEj1TYp8tF03Pwz5xms2wKSiVJopHSABwCBhSuzByuCY6j9IB
	flodKPUwKxIlOQPr7E+ff3gD1P2v6Rx1QvGFG2Qg0GgJ0c7kev4l3Fr46nAfDsr1v2+LokUfY4j
	Mf5rhRRIuU/JvQaB3IhUmhCzUsTsOfYy4a+ONpzeiag5XJTh2vpS+ArZttjJHW+9/BFXzcO/Lta
	l1qlzzC6hiu8kgQAUalwZEPeUl8HwLUWVAM0hDrvEuexqviy9UsNqKsuVImLkSDtB4Ed+oug4BQ
	uVDM6IseiD9TWCVGiEIchl/d72DheHiUQ0jsetxwbbayZmfSJAHC6Fq7bGtpQd14vtNQt7cOszG
	ftdh7fQw==
X-Received: by 2002:a05:6000:400f:b0:454:af3:33a0 with SMTP id
 ffacd0b85a97d-45b12443017mr2264257f8f.17.1778571428243; Tue, 12 May 2026
 00:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512073505.1310-1-joshua.crofts1@gmail.com>
In-Reply-To: <20260512073505.1310-1-joshua.crofts1@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 12 May 2026 09:36:57 +0200
X-Gm-Features: AVHnY4JI0KEFPMuZFNFAONwdi4seCEpylF-lloYwqHHpYejJrJsEJPZ602ZJjfk
Message-ID: <CALoEA-x8XVqx+S9Kue7VsocO1Ca1wQS10nt=COF-pGOQ_qa_jQ@mail.gmail.com>
Subject: Re: [PATCH] iio: mapping file for include-what-you-use tool
To: jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 09:35, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> As promised, I'm sending my IWYU mapping file, based on Jonathan's
> version with a few additional tweaks by me.
>
> Other than adding support for more assembly file business, I've also
> experimented with individual symbol definition (see BIT() and GENMASK()
> in the following file) - this is to prevent issues such as the tool
> wanting you to include <linux/bits.h> when you already have
> <linux/bitops.h> in the source file (I agree, doing this symbol by
> symbol is tedious, but BIT() and GENMASK() are symbols that especially
> do this, and they're included in most, if not all drivers).
>
> Feel free to improve this file and pass it on. I wouldn't really fully
> rely on IWYU as even with the mapping file the results can be weird,
> but it definitely serves as a good starting point when doing driver
> cleanup.
>
> I'm making this patch an RFC - this is not intended for merging.

Annnd I forgot to add the RFC tag... Either way, the above still stands.

-- 
Kind regards

CJD
