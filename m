Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EBC44D033
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183827; cv=none; b=LR+OxDBZ2nUSqKoCbP+paUHdanWHdvh5ko9b7gthRxnh1WC+UkyuAUCDKifjPrK6C50e4CckaOb41xmCw6nc6okzYmv1sIst8svwPLvfU6bzLVkzI3Eb+6L0vlNu0mhdGsdBLp9hFh0DowLnPG/jQja9vjHJeJwwILOPrv2ZwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183827; c=relaxed/simple;
	bh=VV0WQeCgbPqBTi7yab+uEYQeq6u9LFtTUX4clbsM2Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuwJb+pSMU2hTto9CY9MjpRi3TR6toyDfdUUu1tx85jKKYZ2VGYd+HQEceSMPb/egBB3IWK7UKwujtZUZP4ewXHRig8cqDlSSTcslkbgJpZQNAxBbft/CWIi6u5gdwAGzVzszC2aPgmPXnFVYMTpEEwwokxrutg8lSrC1JGU388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-956948531a1so707671241.2
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 02:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183825; x=1779788625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+2SZGl9spcuw3ZVraVsNeWL62/l5e6HnqNdDh6fCso=;
        b=GDM5AiW0Q44H1FyiyTRtwextFh/qcWpzDrstUOQ7sPjjQl7xCqt/awdtxmgH8o+bVe
         wBbRxfeYuQH//VVm0g4mOr/w3ODAbFONnqnyRNGjzSMcA/gDLw3DVlsw22c/nJbILts/
         I8iWVlqIedfVI9Rf8KF3hG1u7K085B8fkB10LKxyWOHGmdHoP0fpU6h9JV3otiSY59zL
         eCbvHaK3R4wWX25CXFHFGgfZZ7eY9YUjYVwADZiQStfafoYo77hUH1WUf+GPc3CVFPVg
         noE6h66UNxfDOWZKbCSZTYul+2YkBjGp+TzSiWEQS3sEe0B8pB7jSU3vde8zO4R92VdE
         tZPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nu4uKqcprULDkgVhaSapDD5Dp9Quc82R/CvN+ASarQRPzIJ9S2GgQRVRmHUf+o2Fyzj440pqoz5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zuD2YtdB8ynUa+B09zODicrlGWZSsCeE+ZcUcsq6w47n0H3O
	DljY5Kj4eDBDc1a0pKQkicsTN89I4Q6PmmuMUjpYG5P+p0K3KehkNUwFGC2rqCiT
X-Gm-Gg: Acq92OG5rktzi0nwc4RDkuR9+ixXWWKXUvxcwTyHQuPZ5XqPUO7kVgOre2+l9FvznhH
	M2SBKRZN5/VX5QAC/vx5k/gURyG/OJVUEOy5xb5QHn1aQmg32983Fj8I7M3guMLs0McS52qpw7f
	oLEmTy6PZMT1vvh+foYQr2ZS5+FzEyt1azoO/dCsZ70AoZDR8ahXlSmMVlAqxdTDSsxswVPfcjL
	qHgpcf85590U8dvz6zEurWJkwQWbi6bsQipIjAM2FsucfewKJOjgYRW+nI61yaSWZylLV9hkxpU
	3s1AA4D9SIdxNp+KzlQXxfnt4PlMEcyRO4uMFqf4Ma8bG+GHZdqbMFNdm2cmT9+AEI8jvclXa+l
	Rdqf2q+sTQUlHiqmsIw4JXimuCxLV3PpgNOChgabKXW/lBA8YLqaYKqN4IO+EfeU22tAO2/k/YA
	/+YjxUWrhtMqRUxq3Mo2wPgJB5xaLft3EyyM2+wP0izkF5LpelEtXpashzFUMKelMaPD8MmZU=
X-Received: by 2002:a67:e114:0:b0:631:4191:6f7e with SMTP id ada2fe7eead31-63a3d1212b9mr9090436137.4.1779183825221;
        Tue, 19 May 2026 02:43:45 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2f874easm5921252241.9.2026.05.19.02.43.41
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:43:43 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-956948531a1so707658241.2
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 02:43:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+hFTjQ2RNM4STUim8lif7GKoyGi0mHT2oxuCwxIDa00wb+owP6zTBu93hmsA0rmrWi3FPWbk7rdWM=@vger.kernel.org
X-Received: by 2002:a05:6102:511f:b0:634:d42d:15e2 with SMTP id
 ada2fe7eead31-63a403ac9a2mr7077474137.26.1779183821499; Tue, 19 May 2026
 02:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com> <20260519094820.1f05ab8e@pumpkin>
In-Reply-To: <20260519094820.1f05ab8e@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 11:43:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lfn8Mcrjf-CZtgFTL8ilhwbGlXFwz-O3Z8xcIZpla9SRL4d3C994HiNs4
Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: David Laight <david.laight.linux@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, workflows@vger.kernel.org, 
	linux-arch@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-csky@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Dinh Nguyen <dinguyen@kernel.org>, 
	Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Tue, 19 May 2026 at 10:55, David Laight <david.laight.linux@gmail.com> wrote:
> The company I used to work for used 4 NIOS II inside an fpga.
> The instruction timing for one is pretty critical, it has some code that
> has to complete in 122 clocks (worst case).
> Our solution was to spend a few man-weeks writing a compatible cpu!
> I think it came out with fewer pipeline stalls (in particular it 'lost'
> the one for a (predicted) taken branch).
> The maximum clock frequency might be lower; but it is ok at 62.5MHz and the
> higher 125MHz in just impossible for all sorts of reasons.
>
> OTOH I really wouldn't run Linux on it!

Sounds similar to what CoreSemi is doing with J2 (nommu, also for
predictable latency), but their products do run Linux.
See the video from the LPC session at
https://lpc.events/event/19/contributions/2097/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
