Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF089402442
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572784; cv=pass; b=t49zAkB0tVVE6rSdYMq58gUzfVPPttp8T+F1q7i91LZiWecBAj7+kHyGtZm9OTyNmuqeuoR4RD6hzYnda9eNaBKobCXnM7Psfbda8R1En1qZpl7Cb+sPx+p1jLhLshQ7O9QPF1N4KZhocM2q02pkJbscRCTbB6aKEdPHsePz6Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572784; c=relaxed/simple;
	bh=ZfKEuWLlMX0icAotpBmb6Gj8rMmn0WuhWbONlf/UNZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGXTBKKzUKoTsO43/m1kt5K5pvgz8BabOB6Phd7sukOr+FBQPQvnPJFFAlbvwzLZMPsJWD/H+Qf32cE9bLYrCfjvzT4u1rKs3pyg59HwMZ9bJTKW5FCh6lTs5xzNpow8BxJhCy8r/Ze8rujzTnxEtVO5pVA4tn+Go7GP6mZLN2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCAHCWfp; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCAHCWfp"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45eea68dd6fso316820f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 04:33:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780572781; cv=none;
        d=google.com; s=arc-20240605;
        b=ZgXXxYcS3ZIZ89xRbhUNUyT+91wWGtHSKB3ZPPFm94yGsnjfBcgBYq1yssJKb4ITrx
         WfDk8wRmuxW/v1L0ZndU8zChmS8vbYLLW49gX9B0Rduvdxr8U9y/cE08hvKt8cNx39KH
         2tLim/SuiMk3D5nTikVqp7phKbhVWIy00mi56l4E60DD2XwCjpiWXaVXBrZ/ToYu92vi
         fh7cOedSKwgc3y5wTU3ZuBYRqVHWuHmWTjRjCkddG2BF7ic3C4kd/Eh1Ah6SozL07aeJ
         qnXmWiWDwWTA1H0YW/w8PUIheQ//RmfnuZCwUC3pL9Ib47YoNrLo1zi+BLmBIm7Mh2JN
         hM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZfKEuWLlMX0icAotpBmb6Gj8rMmn0WuhWbONlf/UNZs=;
        fh=hN54YNWJ2gFuxL4BRhe7qVwAf8/04ACTndomMl9WdxY=;
        b=cEPXtGwuWPA4hPmaQSrlp9DT803cCWgFjyLzFrWfE45Ddx66Ox9plYNTXfFjXDY5dZ
         QGH3LlpPG4JUxbN3lPK3vlUzFq4Z3iMHwxX5KMn+KM/GEuFthN3um0jfsRf4F9FyNyAk
         YRh8BCC/c0Uvh7O2W6uYioVZcFhbu8wkVpRHxit70aX1KHbr004gIE0CrzNw3RM33I3D
         MAavQUY/3qwSNvpLQ0uHhkNOzU42l6YhMGNu03uGZHrj7yL8wLbfZACbgBWG9/cXsFQ2
         KmNcVHVhCkA5jXJtylzbHME34Xyfu+LAmSyoz8wxHAONLj6D6E59edT/B3D1J6miedua
         Oftw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780572781; x=1781177581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfKEuWLlMX0icAotpBmb6Gj8rMmn0WuhWbONlf/UNZs=;
        b=UCAHCWfpFzyKZL9ZO8hTTIh8ASGm7oJmGPt6DDdTDv2FUu7qESG7IBHgbymJ9E+OMf
         aFRso9X8MuPVuKKwA7Trv9PKh/cGPKKAFyWGtgnpnllkUQa4NRIXvKrRoe55LultBeUE
         0gpzTxWfoA3+MxD0P6gm76zLYa7j1ORuYA605jxwyiCQbEoxU6FJ9FPTHmfGHKro19kD
         4acUOXyGR0yk0yR0oIE/8VmshPxOqtX03ldf7Z+Ys+2Stb7gnRQrwhZOLNlezzlrcvaq
         uzT/QDFc17lVc2szI13lJWNINrS9Y9WO5RhOiBHziI8j9+a8HtYyU4CPo8auL4mgkR32
         7ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780572781; x=1781177581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZfKEuWLlMX0icAotpBmb6Gj8rMmn0WuhWbONlf/UNZs=;
        b=TtGJAJQpQvyJAGYxPJUn0bFTos9f5+yDleyJGFPfu5SXW8u95sC8ZCGotJafuw2nF8
         yMUUAAoJ8dXzVtBqRyUlpi86l3scAsck+W9Lv9CF0olJMHX8rYCIndaL0TwGkx6aSd77
         qdQukr1RPi5oeMAfrVBr8CSv/Zjq72U8BYq3qqggDD2lTUwGnkcwwuDuCJAb7/8dgqL0
         8yySpIOyMcL5tQ88+3Pnsp+VxFExL5BBamkWNU+mbpurEkkPrvrhDUIZqoV5mldCWtTQ
         sKxFRN6s0lCbxYU3m+Gu+HZGMCUo5U0lKGCLxlGIb+uQYnHDrEaLtiLMRtdsPDsKTu0o
         f5bQ==
X-Gm-Message-State: AOJu0Yxv+J1LSARXsdMoVB850BDYciR38uyW5NK3eDFvegirJQaQqG+k
	h0H81WD2hNL5soHm0pIFMsY5cWCEKyjKsAu7DOKF0ctzJhUpc10ZIllV4s4IcexQL5+dMrgLSxA
	NH4VJbZV5RqH/mep/nlZoEUtmB4rauks=
X-Gm-Gg: Acq92OHT/zdKog3Y5FmiIeyWMILmEzrAv5kQrf07/NfqZASxYFiIEMwm/JyTQSMfFuQ
	Irx6w6yNBIOGf7JiHptyPW/NuW8XRiJ7oIjRVU6IlZ1HaeYbMl4EwgM6+3CcQcjP8J0KJp6dIHy
	PG5z+dJKX4WdV2GKR0v5bVjXwqiZujb2WRwja1PCfhX3O8lCHNRz3VK2m1EXgwgkAsEnUKILz+P
	Z9ERelAwY3Neidn58Hjdotbc1uZ+YPKK7a4DllxP4Ipd0Ee5/0z/5fn0+I07mU/0f0vJsGe/kWR
	oK9HqEEzsz6OYRRV0sM52RTcV8Hu49uTpMdMwNsBJi7bsialE8vzsjAj8EMmFaZleme9iRfMzjk
	g94jGPQiGa7/spBWAWJ6cnJOXfc0az5UxMsxFB+dDxlPr8Zl7kjlQ4IrROIj3SJFj30h9YkYFjS
	TeBpuu59nRsbaYuBGL
X-Received: by 2002:a05:6000:ac4:b0:45e:93ac:769e with SMTP id
 ffacd0b85a97d-46021780205mr9208507f8f.6.1780572781106; Thu, 04 Jun 2026
 04:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604111921.106936-1-vo.kratky@seznam.cz> <20260604111921.106936-3-vo.kratky@seznam.cz>
In-Reply-To: <20260604111921.106936-3-vo.kratky@seznam.cz>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 4 Jun 2026 13:32:49 +0200
X-Gm-Features: AVVi8CfoZLnTGoETl0CJhkGIIbb1KDhaAW7xm9hsTUc-Ub-1Ro-4VH7oR6golPU
Message-ID: <CALoEA-w1W+p4gLawWrFxe_sN2cJnQ25yRBFPh02N_2NPVQbkaQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] iio: chemical: change from %ld to %pe for PTR_ERR() printing
To: =?UTF-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jun 2026 at 13:22, Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kratky@sezna=
m.cz> wrote:
>
> Found by Coccinelle.

This is not an adequate commit message. Summarize what you did
and why in short. Keep the rest though.

--=20
Kind regards

CJD
