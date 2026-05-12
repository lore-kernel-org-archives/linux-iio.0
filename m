Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C073859F3
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583621; cv=pass; b=CTAm1IwJohmtPV10cdb7L46LSPhZivtKleomDpYW/2lacVKg7ciJgZNCW7B9h+b7NEZSW2ylHcmO1UuxfQe4mAbgujsq31ymL/MDardJ5eftW5BD0kIKl9kFKKkVPzxB4ytVYSyV1cdL0/KdtAeQ+okHE5GuwRvxfSqMGe85srQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583621; c=relaxed/simple;
	bh=LhDgvl7uPRs3CMEExuv1J69kWjAxPIo3iySve0DDFCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5WjLe5aaIxuGDwmZibYLDgAPONyaCMmeUqFJg8cETPf3D26CpebSPaXjHMQ/bJgBfxDHllZ1ftJC7fIfBKjPQRF1RMBJFKQcN+O3kty5tXRLChj8yIkQCR+hFHMd/PC4aJJyIiM5pERhA2eJmq7x0+QosC58N7gL6SFlXy7rvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=ESwRSZdg; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ESwRSZdg"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67fd8befac7so3874283a12.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 04:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778583615; cv=none;
        d=google.com; s=arc-20240605;
        b=Knxtu7YtHQURfKzK0d4YaxV24G12Pj1V7/bfP8LxNmU2iqs71mt3L5jGCTiXQ2k1Ar
         e57fzELmDf5HThQ652FbxqM/gSD54trT2KztCC9K4KAtus5SbDrB5Xd8OitKuMjNj0BE
         ZEQti+McvbhAFalvnkfEBTHfirqKz7atvelqNYpvR/WdPBMspXPnduEUJOJgs7+bEaA9
         xBUJwOzNKgkWf5g6WPENb6PSglkRIVMb8xAS14sgvCJnxQebOl3Mt/u47W7ykgKdK4j9
         aC+cUP3O/HjTfzZFQCGWNRaNJg9dCHloJfpiTH+hzn3g7ebliret9wLC3guvsgHrLTE4
         foyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LhDgvl7uPRs3CMEExuv1J69kWjAxPIo3iySve0DDFCQ=;
        fh=6hIqnd4d03FXMxMgCXqIOMC3E8wQpwz1O4G7iMx7Sxg=;
        b=U+zNBDYbqqZLpHu9o49dqtCACUpb7aHT1Rs6631HCExjbLo1t9cnELfEs9gkfIMPej
         Wsu/nS2cqpXq4D5s8xOEUrlIvmwMAubnm4a894CcxJVqsjNfix8uWm1eLjm0fATv4Z59
         nvF/qCuQVdeMFl+9IOd5X+7dcRSXoSSaHQJeVoLMbLAhfC008m5/0anZ3d71e4VXfGkm
         mwllNeASvS2vOrg8pPQmNZG6G6/Sb3uhDiRD8FLBZU2vDSuiHMTHUSjtcteKfATaRo8f
         qEbReXPun12TzuwiMQvTdzmBfJZ5nCANCZbrxWjAYGREiQF1UI5HVpDTi1AMLasWescm
         3n+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778583615; x=1779188415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhDgvl7uPRs3CMEExuv1J69kWjAxPIo3iySve0DDFCQ=;
        b=ESwRSZdg5nd0aFpW1Xbsza9P5H+kjbLfRXE8sbI17NJW4of7rrBWa8lt1MF3sBAT2k
         Q2MTZpRp/TQxh0H7Zy2D/yQCubxrxvuW7LqBfHXuYXHwgHS469jkn9Ka2ufuaQNauOuk
         XnlTrzq5q9avtGjNHTh1EkHa6sSx40uqkUJbTvx+ybelrp4dj/UitMVxj4Ly5sSQ3ay7
         vjjkc5ezILENkE9AUs00rQ9f7yI06pKcIt+rZ58OfpobD7MXtfYS4BZeYxMzCzUId/gt
         30jYCjIu+TxkjjIowOIkQoj2Ay2xpkYCbEMFr3NlKG02ul17znOp2KBYbXYa/WsPzkbK
         26ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778583615; x=1779188415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LhDgvl7uPRs3CMEExuv1J69kWjAxPIo3iySve0DDFCQ=;
        b=saVmPxqGfrHdAH4//iBZUEQp0Us8Yfju2aYsTX2a/8NYzzV8osbdpkDEyFWmVHwokN
         +cZTVXEB6fo1ooTl6XJbzGUBz0aXAr7QpkjLQRHFDBi5QABf3/fay9XMNG+8btR32L4x
         n9zOYsY+5OENf854UwiICVsXb5hxfD4HAbbw3Qyqn70pEwxeAaChYb9RlZsvd+p7bRru
         ig1F+tL/9r/gyKhNwtfUxkoz/IfLKnLaCAO4/ERgk9h9+igj0ERnBpYLOyKmv4lqYNYo
         yDJEW1LSKSAjnreBRSvrk0JwEMng/q6/UQyabrX2c7i4jkWYM0MgSm/f6rkCsWTSQJuK
         tRbw==
X-Forwarded-Encrypted: i=1; AFNElJ9z0bxBgDlRqDvEFs+ESLWLt9kae2Lw+3m1Y8qExh6V9isi4Q7LFxNdBAkyKXJDj1fbRHwsbaWp+jA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBcM+XgN3PGhjBo6pUPPBC9YSSoeJUlugyx6oL+MI2LVW4vV9t
	Qo/GknbsP8HaLPC8+UMbEa4KuETDCJiwlCwtNanRi0e4DO/qydeFI6/iLozzvjhjOSlmOq4SdBz
	YuInbMw39CDblSvadP25qu+nZpGyRyV2CrkwwuoUSAA==
X-Gm-Gg: Acq92OFOcKz6FE+O2mtB5j07miQexpSvKscxrtvWnMiGycBsHvxg8INU07NxHRAQjSu
	E4KF3P4BjmIjPgFKglmDt/kwDAkWoJAJJEKt487OjuOE+HjwPR0ct2bxM/KBeiFWiTAnpVWg9DA
	P9rP7I8ZiHP1tgo7+W5yXaZivo/E9TycBCAYxNfPxJMbEY3dmtvFqUhGRVpqgdOdvkBbU5pih6t
	7avr3RUH4eSyXY5ywJJ6I7V2zOUo3dwMEqsJmQVLdlIVVjBNjDBYLY+G2B05gfsogxbdp+ehzX/
	MTUFxK8OC3qpNrGzBppOdxsGCvBE3W05XSY/ODpglc3uNzWfEx1JKPtaAhpkZsmbr4okj+dqiVd
	1RCCAWerW2HthsFworbr3MW0y
X-Received: by 2002:a05:6402:404d:20b0:67c:4e1b:9134 with SMTP id
 4fb4d7f45d1cf-680cfe24becmr1173638a12.14.1778583615257; Tue, 12 May 2026
 04:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414224245.8493-1-guilherme.bozi@usp.br> <20260425163449.547b7ed9@jic23-huawei>
In-Reply-To: <20260425163449.547b7ed9@jic23-huawei>
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Date: Tue, 12 May 2026 08:00:00 -0300
X-Gm-Features: AVHnY4JOYBBFrty7L67g9NKspgD2Gbz4Gg9WVL7Yka7j0SH0JfRIOzMv0nT0aZ0
Message-ID: <CAJgF-xv2SpaOu+6K6k3CzFVNfWTx8LyeGJMZjLheCSETOR3Yzg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] iio: adc: xilinx-ams: refactor alarm handling to
 table-driven design
To: Jonathan Cameron <jic23@kernel.org>
Cc: Salih Erim <salih.erim@amd.com>, "Conall O'Griofa" <conall.ogriofa@amd.com>, 
	Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This series looks fine to me.
>
> Given the AMD Xilinx folk are fairly active reviewers I'm just
> waiting on them taking a look.
Hi, just checking in on this series since it=E2=80=99s been some time.
Any updates from AMD Xilinx review or anything else needed from
my side?

--
Thanks,
Guilherme Ivo
