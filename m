Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4653195FB
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779742192; cv=pass; b=TrAHHdciT0rEi4oruDQvD80HOO05vmXOrcM2O7BsnWvrcvWFsJ3L+vjXg2NFS3HEhFqEEK+uJec285WBaHmqyBMu/fr0KoCVaA4QubCH5kBrbndtLQ2A/a1T20VcE7go+9THLM9R5yo1X4XD1XCXcYTYl8qMCrllscbv1HNV0w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779742192; c=relaxed/simple;
	bh=8s9rn7ax9uozNRCIYDa7OH802wOH1vxS4H3Tqp9Apcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtNzA+QfXXERBvRDZZZ9259aJNzt+toubapP072E9i655DBeVN9AjBVF/kMQKytm4r/TxVJLy9z2yvRRAbmL2rZnqNM8jjC5xxknHfCCArXVPIUm1rWC5QEKSOISae31efVbqgB/JYDFxxsnmp9fEa239U7UBN+Yk4Kl4V6Dfi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0Y6Dclr; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0Y6Dclr"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65dead17c24so9126102d50.2
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 13:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779742189; cv=none;
        d=google.com; s=arc-20240605;
        b=WHc1bob5nGkBcK8eEpm8HdW0l+5KYOvkcfXL8zVDBEjPY/7/nHCH90xC3KoOLv+LlM
         UXC+qU5FoGHwY8gV1Ap0lI9ST9IY/lNMWCig4DA6dAUlZigR6Id2l+o0/r4g/oEDs+Is
         cMdilahy6nwdEYEiTyWw7H/Qd1kcGgewRF3S/eODkxh671uAlSZTie1Cje07ZB96r6dP
         bU/wbjRDXmGx3+OJ6E43R4htxpdLtbDncb4CjEsw9FAkK/jAImXgfQdL3j8TFGYmD/jp
         X+ONOvKLE+aB4JSmDHhvZ5hy4xjv/FjUq4G0N+NOOIX9d2nSg2T70NSDJIk/P3qrVxVO
         yA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L7/crOvyZvNE8H7WYlujexRkC2lv1o4SudvkWejd31o=;
        fh=UIBTfaUgctvJWYluCJeJnZIglkmfUZUJPEVGJXEuA7Y=;
        b=gwC7wUd8WyuvSVxlacRFzw+7cSZTk5kI/aZLsEDnTjn864/t/oRp6lkYSeQmC3QSCv
         JK7dEAGx4G2iDbHh42zlESsEpwohIWZUoloLLUbcAgdpgZ7Q3wL0c5JYwQG1s7U1D7Q+
         S4vHB7CdB7EycsfZUkT/r9hbmHQ1ZFDh1T82u2qDo3t3pFQF/hjniiX5qcxcN1nltdwo
         sh/tgqUZyJ5liklPgr7se4SOEnVSWYm6PqqNnSmAbLUgPvt9qTb65rOCyi6oRZlka+Qj
         Hwyo+F20z3UDvJxSiUAHtEOkwqMgIewG3iWAc3Gz2K1+Wj1cP4c1B2dkuYWRqd/cfuzW
         aiuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779742189; x=1780346989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7/crOvyZvNE8H7WYlujexRkC2lv1o4SudvkWejd31o=;
        b=f0Y6DclrjNJAFX1HrtQnQUlYww2oTM5UE6Q93xt5HNg1Wp99tcomge55Hzo1aULxGX
         59xM+NC7t7IEL5gamC1S0EwgkKV/h7ge7b7Yohe/YJT5UTK5JUcDePRmkajy1WARTKoQ
         vEMTS4BTgpKYfk5w3L9qZyR/egFmDhVSS1EL9l/PI5+GxjJ0sGHwj+sRfDlpob8IkxXL
         CdhGQP1DvbfQxAQHiaANlL8pPlIsNhJRZ9L27gDaK7bZ+1cbcwQ/hHFK3O8q1iZfFWJT
         s//Gnu/XO2jufxRTrossvGeXsmLKIDCQAMZt42AgS8a0/V55/EACLlalhextxBBwOelA
         G6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779742189; x=1780346989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L7/crOvyZvNE8H7WYlujexRkC2lv1o4SudvkWejd31o=;
        b=G4Wjqo8tMnlzLbRkuRp36uhF9/H50qRDYLHRG3LThG8FtAez8kwsSygIFDzoTLIHmj
         7SigeT5C+PW1WOHa2RW3x8/SQJ5obGGXE5jOAoyFVHHpt18HPAAb/MqD8clX0Cfh1Qcd
         htmyNBmVy/uqJ1NY4eXHWGnSNasUVSvblQfwfhDamcwkexTcvTkFFtJHlW3aWJpoCoPY
         kruWis4fSCucdU32fcjDv85LyFrR3CpcQTX1YhgCV6aALWyzRXehvuaL56Xc4q1P0lir
         qtDyCRyvTEU7I1yTLW6CAJGlMcU9+p8cmrvLikEtjeFEs+HWAlwedth/V1wsVTDQdLMT
         bMnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Nq0tO1DQ8oblsViVKeEwBk9hYbUOLeZOyC+A3SfQU7XyPVwAFQ28ooEGzuxyYbbzlcHXj1IeTVzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZI+1ZzvJuQ7NKAApTMXC/EK0URTyVksch3YEWsJFbUOT2CaL
	r7Y6ykC2gyfJ1PXYadj0HM4fjxXofKE6vYoef5IQAoYB+P7AP4+GjoQEofUsqJKj/q2KZ7W93WI
	KIGb1fNik+IweXaD/uvdF+Equ1YX0dL4=
X-Gm-Gg: Acq92OEAAegu8PqakBSxNWfd19s1qUsDEDo2V4PvJ8cfJIPRJc6CP8nTM1EWk3SInIS
	2ugzwD2eDNqeUKtilDafe0+Kq3cThL6WLyPNzSdjNNTFes8wOWOOIopATNrWnaO6wzF7Lgw7xNK
	QvQ+tfDN/Apbpe5AEnscD85iAEXFNiFtxuvNPXIKPPygddwHcVABIWdrQomDnEL+4gvPhadDC/R
	XTpSGfN1DJz3kJQx0WWp/uKdf4jgdNPpLIqJhCTyjw2Bfafq5dSocyE5P6xraOI7WGhSQmOyOqS
	OOWJ4BKfGLjcxUBsl1ve5UXu20RbKQ==
X-Received: by 2002:a05:690e:251c:20b0:651:b73f:2046 with SMTP id
 956f58d0204a3-65ec99e0337mr12738888d50.59.1779742189084; Mon, 25 May 2026
 13:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com> <20260525-opt3001-cleanup-v4-5-65b36a174f78@gmail.com>
In-Reply-To: <20260525-opt3001-cleanup-v4-5-65b36a174f78@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 25 May 2026 15:48:03 -0500
X-Gm-Features: AVHnY4JvqS0rWZlQPBZJ87fedZWlv5PUf2gkF0FFcdXpKqWKIaoLeTw26XpglZ8
Message-ID: <CAKqfh0EfYf9fA2ysyOoddufU_99GAHJTk20TurZ7zLVcLBWdfw@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] iio: light: opt3001: prefer dev_err_probe()
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 3:20=E2=80=AFAM Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Switch driver to use dev_err_probe() to unify error messages generated
> in *_probe() and probe path functions.
>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/opt3001.c | 56 ++++++++++++++++++---------------------=
------
>  1 file changed, 22 insertions(+), 34 deletions(-)
>
[snip]

LGTM.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
