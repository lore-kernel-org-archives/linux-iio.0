Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837E36A367
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779432843; cv=pass; b=ISqOmOkCBZZDH/qdrlStl7Q5vhMqy4dPEJ9pU0oCiUYaoGhADj662vOI02ftzboGCDocDGDvIA/HNYJ1buSDrXk0uVIBWdXzqwoEVUgRizWPF/5l/AJie6kC342nNWdZzW3Flh7rZ5IAWGINPM9+20q2XnK3Gghe1exVMNlxYvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779432843; c=relaxed/simple;
	bh=gGOJVk7z/0bHuCZeBb5r6GzmiRrj9XZI3ych7Xl6Bp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDC5VZH77ZFSxnPkinwuHQv2ThvISR+GzikwdXM03MtUVlkFsmzRsJo0Yic0cF8EJrX0R7N6UGi/C/4tyKUfgismREodTABJV44TvLgAQCvEYYO8z799O2qeTk6n0VgrztjUrYOLBxdA3DJXnbl5odvQrUjiMNEx/cimGEB73IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDiXJHKz; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDiXJHKz"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so8017826d50.0
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 23:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779432840; cv=none;
        d=google.com; s=arc-20240605;
        b=VIEJe8fqhDNoYbhDMy+pWs4SPMtPffG7NMNnGVJeCtFEduEoD8Vql9O8Fb9rsHpmiA
         w1cuyS5i27DgdlsGPkrEKejxCRUtxh/a6YHJTQfgoWlOFb1ok0Du0Z3PsuVH8PJ5AXvQ
         t+j4dzNt4tpKPhFExSgKL10mIbyh4oiVxDIAsRJVTqliKRUrvc8gZsZyCmB8GKQda2jr
         M1xaVsh+0WhhZJDjgmofqhBXEtNtqlfNWSrpH1y2dzzSanpqe7byS31Wi67g/0tgMwhI
         HIj4MKqGLKRMLVfzoXM93Odra5XLLe+VAAf63Ybyo6I6cCSG2/MchnX+TxilDgl+Wwmi
         63OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SgpFTk10t6UmrN5VG3GdZGPKd86DU6wqQUEcEkqw0eI=;
        fh=xA3QKHkTlT+H9T5NnfUqlNQmmZD5+JlwT35GjfFv3t0=;
        b=XpAG/+SzGvHkQEhRx2PHq4532FzR5e2qvBeClk7x2Qc29In5bnsHMbxfGTtml/Bp4/
         JTKutTl9NtaShljgSQCxfXrNQX+w0B3YD/6mRYasN48qpdzvqmI30PLvSxdVYuIZY9Ui
         qKR2VMaAP7flm56QNFaPwrMQPd9SN183L2JRe6flcMiMYnkq9wSqjU7krOQ9uJKs+dZW
         X6U6iz6Wp6aBYOj0C0SeLnSe8qDCGFV9tqpbi07S91uayG8tyK7obur2jXtUAzdXeaa5
         rtHzTxszih3D+o3VM4lvZI/6KsIwPInNAKkJcNKcU9DifbAAzGBJJje1Mwh3+IZWNWqt
         kPNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779432840; x=1780037640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgpFTk10t6UmrN5VG3GdZGPKd86DU6wqQUEcEkqw0eI=;
        b=ZDiXJHKzsTSTC9+8tM+7RsR4E9CxFxw+56rnh6n97QOff6Y97/HCAzfLGcNU1J3y86
         PmaI1lT/l5z0MW+vYceA+i6rJrhnqI8Sl6pneAv4B04YLHcr8j+RHYapSsmpJuJ209GI
         w97b//ITZ3fbujnm/q0INSEeFcH77DkcVfDU1yzAKwaE1oRlGKAfOXGmXmYUaOWJJDWc
         Ai3drihPDp053IMuX2eKruikW7l9SvbGTKbmRdZO2DEUAP00oL+/A5aW8mo5W+FyjKcY
         CyIm6Sfl+Y1ZJoZpmo0cSgqVfTZrj59wTCJzIYhZTR18kxcOyav41VDCAVPg5t/FEcpD
         sT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779432840; x=1780037640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SgpFTk10t6UmrN5VG3GdZGPKd86DU6wqQUEcEkqw0eI=;
        b=ZFHf5hLemWsz7BsprCBo/VwOedPNVffh7vpucpsW3qL+p5OqNDweyY9kf89cgFMvWO
         gw/wY7ZgKoLMurCRQ4yVq1z5HGcFTQvUXJ+mqvLgt6x1ZNCWIKr3p1GUuMG6FeFPXiCa
         inSz6dv4QKFzPq0zSpyufbTMFF8C3xih3UgxIn3kTg4uTpnBu+ARSE3XmsaHdWVLG1Xd
         o8MYs59xUFo2+RY2R9qCQbcuitPJHvKsORuK4zSGV6bMT2kY4FQLasZhYi75iQLB4xob
         qymSus4SvvBKUU+sPfSGRmT6wv2oa7p/doe1fd+EvJOS6XN/mxEXJJVUw3yrWW24+5xK
         fHew==
X-Forwarded-Encrypted: i=1; AFNElJ/BZtOglG+4SxoWT1gLH5CuXx2ToMp8LKiPxbMP9kNkGQJidIrN2UPLYR32fluZL7Gls2YHHlw9Xb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgTuFEFb5JkaUbRWTKzaPi3kKfpAMlhCdDAr4MLuDIfGzgkrb
	Z7MN/8xk+rZZ0y3BjprgzuhKfqk3xGMzSivCNcIXANlLi3vc47QFpLqx1a6aTifddWbkH3YGuo+
	/hizeHLnf9Zo4y9OS0yeuUU+jVKjlIVA=
X-Gm-Gg: Acq92OHtVjZC21tfeOrVakInOSg2pCO+uAnfI6y7uijIAZbGZ2zzfJzg8Z87q46Ur9n
	CE4QJL1NMUyXRxR/DfNxZ5VARAqXAaVr1+1hsPBrA3oLufV86Kkwiw95dJigZlpJ3h/FDUPLIfu
	xUUhYVdFUkpUFw1mXEIIFqUmx7P+0m2sw9EPD1RpJrn8s/sUAvipF7YxbcLaWc0x8POkMTvtXOR
	1a1srj32vRnrEtub5et8n/UHGUT2Var2XebHOFX+FFBwzBpL6evVKXUlrU8I6b8jrlNVaQ3RKfz
	EZNTQOOT2WQRF5o=
X-Received: by 2002:a05:690e:440b:b0:65e:b074:c6ec with SMTP id
 956f58d0204a3-65ec9639cbbmr1678301d50.9.1779432839990; Thu, 21 May 2026
 23:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com> <20260521-opt3001-cleanup-v3-3-820169dec8c3@gmail.com>
In-Reply-To: <20260521-opt3001-cleanup-v3-3-820169dec8c3@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 22 May 2026 01:52:24 -0500
X-Gm-Features: AVHnY4Jmd-kq12qOePKXxo8nukea7hXvUg-KOlkE0r-rYQpYzfPMtWbUcNmxHvs
Message-ID: <CAKqfh0HMf0Xw2VS6HgYXK9a25Ni1Ly2VcR+Nn60yN=15tB55rw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] iio: light: opt3001: ensure correct parenthesis alignment
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:10=E2=80=AFAM Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Ensure correct parenthesis alignment per checkpatch.pl report.
>
> No functional change.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/opt3001.c | 73 +++++++++++++++++++++++++--------------=
------
>  1 file changed, 41 insertions(+), 32 deletions(-)
>
[snip]

LGTM.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
