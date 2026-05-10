Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08184270575
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778405561; cv=pass; b=eJassH6VeT7jPAzP6hQnMLVOPDgdo1fnWO6xZu0d5lV1OCO+QV/KBfldoSjmrdMZFfCMm3Qbi0RfpplKu47siX1RRFM7GIJdbDNbqMy1rxfxq3pQrSTKpWLX1JabL2JEpq9ChpTi78PCUKSgOOm3ceBpSw6/dxddd1WOMXu+nyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778405561; c=relaxed/simple;
	bh=qwi5BUgLlMvtLD/R0J+MHsRi+Ay5GqDmU6BG1y3Npbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnJBp2JOZXDuy1DtKAyatXkFJ9EtGEvtkCiLDLwL1UZzFwGu0d1fQxrYRt9rkRnz52CVsg583MwnolTk0ULhWqsODP04g7XIpEcFeY3Mzv/FH+gFozoYmaxhU0LmdheQ4iqMAX6b9TXv0gIxv+NoatHTkU8niaudpRBXnYtkCHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJ8jhM4v; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ8jhM4v"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-449de065cb3so3108461f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 02:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778405558; cv=none;
        d=google.com; s=arc-20240605;
        b=UMGTdMg2T2QcfqMUXrxYt4ualfmRYBx2HAGzapjq9rWxPTnfqSLIUG9Kzx6WiGFxbk
         GukQQ5KnaQA8itJOJj7JObqQnGKfdzZiSz0d3vAwWbDxKt09HnQG0NZLU33mGys7Ehll
         ytmaMo/QHTztERDzjC3kFTWCt9ngitCguk+utQhrrEaLoXTwhCLbVXj8wFbir3PJPjk/
         Hig8tafM+qJFQaIOrCBDjGBBmQYF5hIC5reYEQC8dLs0rnN9b77wCnYQjtkYMemKS2vk
         ubm2TnuryAPo7hhICNgP+psG45UfcwOaUQ7c5Eu2apCZS/Qdle6iQzGLKIH9EQB6yy6e
         cxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qwi5BUgLlMvtLD/R0J+MHsRi+Ay5GqDmU6BG1y3Npbc=;
        fh=TR2WlK+9JkuUu3JG06G8K9c4XnRFUF+b+YoASbx06JU=;
        b=gOOyMjPDv9jN4bdJF1rS07mIPaBze7qSdsAGchKtqy0OBllCDkqBCb+yxH679/rNIN
         V6YZuj62CPhIX6z/zTMq/mwtw1ebxsldCX1w7OUBRbQwDlQ2vyFfDSnTogzOf08b/NqN
         8Bx9dPp3S65HaE8rpc2DBdolzYkFbCkP27RHvgZdJERB+9S99cakbUpwlVH394tlzbNX
         H1e8r/Qei6M6wdCQoyM4SsNa/W1+ePqlte4Q1OwXoB5+xw91eAibecfdmS4WA+MbGIGe
         63vJc2YLL/B4RfW1z5QyPK85rwvHkhYcaFojSA0dKHbWBeAHnXDhX4gIrPgN0qCAlg5S
         XcyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778405558; x=1779010358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwi5BUgLlMvtLD/R0J+MHsRi+Ay5GqDmU6BG1y3Npbc=;
        b=jJ8jhM4vDcr7TkFAovm8Qzo/qwHnQ/UMwy/XvKd2GfrH6AFAzy2AOrzZGKiEUKDK+S
         UM6CYiMxSAy9MYl6uPXzM6dGlbKPEGJevqCRKeMxcXjYCv4RTUsl0NGywqEwiPyM/GsX
         cplfF4Aldj7wuDETzZM3IhWBGVYMpirNdMhdBZJTQ6Foj7hbHKbrCKBEPWIP2lynlIHO
         FmPIBd6hwd6rZWBo9WB4Mj/gdLn9EYmwQBy12/281oLWU+ajHbN6rAplHp/fdaGY0IR1
         FcELWlMxamawEcl7IXxRaaKgv4cgl6ej9bgEpyRpmPzUbI/72dfzElSrpfTq8NL7s0E9
         3lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778405558; x=1779010358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qwi5BUgLlMvtLD/R0J+MHsRi+Ay5GqDmU6BG1y3Npbc=;
        b=Ts+sPqvTsGc0iJkRyH3TDW7NLdzdb5f6OUX4xxL8lhVMklrxPTrvbEDEZwP+kyCnhT
         CAAdIG7G9F8mlVvDil7wwzysaQ4UHM8n019+rBtpYBZs7qlITPiV66RikpPUlVvQr7FP
         wvwJnvU65mDhcAfKtKg7pvNHVqERh7SI8wuK6e69qQ8wNY2ASVYajUYcZtDZvjiZFVLd
         FtcAY0TEq2X1G6gW71kCdAPUBfA3P+lj+ilBiTjafEOkRK2yOW2UHILfEA2oe/giapsO
         Ay7yolGRN15QDOGP3ChketVK67zIyzrQoPs5S9q7XiZfWyCvuVzVntoRc/AqcV8TmQoy
         29vQ==
X-Forwarded-Encrypted: i=1; AFNElJ960Q9w7y7Ljboo3TMGM1cgg5FU7ZeJuzURYJwr24+Qbbdi3xY61iMJ+6YzUXBwtjSHA+sEZB5Q4Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZYBwFuR38SCrfDFOVBYgXe+keUaryqt9Sk2LDcIiWaYaKlN7
	JdBZMk3CjhoFhuyEZV5C6I+3GMdM0bEvnDT8HxGgi6wksx5X2fOdjDdJczIgG/WUx4mGLe7e3un
	PZSk12MHwdnI35sB0ccIjWxK6Thxn0D4=
X-Gm-Gg: Acq92OFbzFZwqWL3lt2jeAIBqpnnF3GmbU7w4xa7zIYyFjfiLNuiOATh80cdW7jY4nn
	N9mmo2N4uBnThIhWY6yt+HxiZW8z+qQtdpUgjuhhLrUMZhb0974b0EXtM/u0DfR1HLk6BztTy1i
	aATtCfKLOqRhsE27adYoYNE+S2ZOQO3//8u8/PTlTuBfHcJKrVwrcjh9egqHN94Jvk1ez4LpZGy
	7Vwc0dI+KkB2VVmPwl4JMniJ78OwtPnVIQ/7olzv1P/RcBbcCIiJdEahmk9Rw9lB3FDCVT8LeFw
	MOJxxFcCOBB/PZQ3EiGGQkN5pfWfZcTkv/J5kfk/nZnDaSEi3AZqLI7OLqKSOne6yR2TJe4HiXg
	l7rdJzgriMr0c5WbnDamvHARqVuVYb/NmwlZp+A2+EJehQtPL5gxAo0v63vmcek6iJI62y51bsn
	pmBAXrgorfSrCji6hDKkkKey+EK7WiBc279BsBOn/36Tyboiy08w==
X-Received: by 2002:a05:6000:1868:b0:44f:da54:da6c with SMTP id
 ffacd0b85a97d-4515ce1c84emr33669119f8f.26.1778405558200; Sun, 10 May 2026
 02:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509125201.29872-1-m32285159@gmail.com> <CALoEA-xo=0T43Nii5mNi+jwpXNgSf-3LVwO2Xy-0EMyQ227Zkg@mail.gmail.com>
 <CAKqfh0G_hWNPTLjhrEyG3KAVgsC01WWXk5u8t-H8iycSW3UyyQ@mail.gmail.com>
In-Reply-To: <CAKqfh0G_hWNPTLjhrEyG3KAVgsC01WWXk5u8t-H8iycSW3UyyQ@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 10 May 2026 11:32:26 +0200
X-Gm-Features: AVHnY4L4rCiUprn9XdeZtsFiVOPUQZdblVOjzkbSFo3mPAAfSgsKx_UWRP_lplI
Message-ID: <CALoEA-xozzYhO3p9KGvyd_0UwMwkSAm3m8Y9vRxxLFmnO5QRhQ@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: sps30: Replace manual locking with RAII locking
To: Maxwell Doose <m32285159@gmail.com>
Cc: tduszyns@gmail.com, jic23@kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 10 May 2026 at 01:55, Maxwell Doose <m32285159@gmail.com> wrote:
>
> Hi Joshua,
>
> On Sat, May 9, 2026 at 8:04=E2=80=AFAM Joshua Crofts <joshua.crofts1@gmai=
l.com> wrote:
> [snip]
> >
> > LGTM.
> >
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> >
>
> David asked me to make some changes. Will I still be good to add your
> rb or do you want to wait and see?

Hi Max,

Yes, you can keep my rb, I agree with David's changes.

--=20
Kind regards

CJD
