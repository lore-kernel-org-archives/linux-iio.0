Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220F35BDD5
	for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774187565; cv=none; b=rrlJdms57F1Fjsx208V4LvrAalVQeoWr6A8BIbeWBpUDejH8KFzWHECDC0nQBgn4LOhpyXmTvXayzbsF18JmwH3tqHinyj7KQuEYTPCTmpSvC45xAHkmlUNlgXMNOwEimVHgtba8D50iGR93CbcyNQnAHauDM51iNHgLG8yph1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774187565; c=relaxed/simple;
	bh=w+DQX1w7FFlPVsKbazN8qiswzg+87TvbKsY2zMl+ALs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTvoeBYRubE9ufsBl2ekZL7A6CI52Lw6ZjQ8Og0RknNNHY7JU/0jjtLKa+H+Io2E1vvNvjJp4+8PkqLCvvq66GwAB5xJ/I67QXWMi1/vNI9tNU7PSLA82VbwyuN4HuAKbV74HcYCyExtqXIFId70UBk1ymYly9n2ofyiXISoO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a3ba1653fso22645877b3.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 06:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774187563; x=1774792363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+DQX1w7FFlPVsKbazN8qiswzg+87TvbKsY2zMl+ALs=;
        b=rmuqpKBcZUxYpTNQ/GgvcNShex0kqfw8PeHisQmjTrAcGBsvMNkD3tX+IJRwbiIrxG
         jgHtgwqrRqAE2BrHnndoHAUI4yMAFbZR4dDMPMvmVNqQwyaz8NRxOUda3IWo/qtDCNfT
         wwuh3dV4sq25xDcLvQRuyjWHW/Nrp7FoYcY1/3g8Xv09BvVZMZBSsTMCinCIO3lr6uYu
         Du0pug9Mcjceb3cGRD27ipTfn50MRdJUo9nH8epqucoh2TvZSZBqhWtY/ksT/EGuwcTi
         k53kyzEzQy7l8MVEZ65067cvtt0ZrWOIvyDl/HDSEqiR98ocB9YtDLiAhOe45y+XjalI
         bWtg==
X-Forwarded-Encrypted: i=1; AJvYcCVAmFl4NwWMIFvpbC2zLDBoX5aOoFRO0C0KKoVW5o5tuhvPWkExcX7JtuKjPU5e+uTwtqHZf87W9OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBKSoJ+eXPPdw3tT5vlISmooZlKZ/1gCmevJf5/Y5HyflZ3FX
	u8F1zwiH1TSWw8gg/zOVFafLVp8aKzr0DvCGkxab1Hln94OrrQJCCXwUY6nw6ZcfARA=
X-Gm-Gg: ATEYQzy1ggtj8DKdfZCSISrPUYr2rPtfE2a4gI+TsyEW/2dDTcpmATqeKnb0+c9zMY8
	juIaJHrP6ElJLmAqRvhdWIYhZd6LVgbUywpjxx8v4Gsky9wpDKFXdYYw5HinwGoPInMe4wTfCwt
	lK6k0kxBZcD6MjwLrORNn9Ep4P0VwoMOqc9V5qitfIQLlPCQNqFbw5zjVMyGi3Fleqg4j8K/AXP
	IczTtgoZKXjemwy+rkg5sb0Qh8BgqL4DmthC4m4td8Nva8hYG4KybsQsZqbhHCX2UFQjXeND1yC
	l9UCXRKAv2uy4h10vfAm5gySmouF21czsX95dY4/d8rvsoSw6MftF6+nn2qrv+RBSYtqUdj9RMd
	LZovYiztXHxkZGceqxgfMHCXi1lGZSSi/Z4fkT/bH3JvYiHSDRPEttAjYaQ2p7C9sYYv8qzCZmH
	ZAHPBCBZPZoBABtUhBPWCAddMVi9vpPd+GgjrsUNioJKMQUx/eCKMqxAH5dbvhSL9UEdXPCBtft
	TgACFl6LPN1qCpznuxtQRWimzJiOpG63qH0sVIZNA==
X-Received: by 2002:a05:690c:6d83:b0:79a:526d:9123 with SMTP id 00721157ae682-79a90c6d14dmr94416567b3.62.1774187563377;
        Sun, 22 Mar 2026 06:52:43 -0700 (PDT)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com. [74.125.224.50])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a90580d7csm43344147b3.37.2026.03.22.06.52.41
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 06:52:42 -0700 (PDT)
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64e8c7f5082so2960745d50.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 06:52:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWg0iyvWHwZe3WdrZsA4xg33Zof5oyCvkyOJR3VxtcNfsna+KQFnea/1WkVzFY9gNT7NdNfBr+f87U=@vger.kernel.org
X-Received: by 2002:a05:690e:2557:b0:648:f57b:d07c with SMTP id
 956f58d0204a3-64eaa7a3d25mr6790302d50.50.1774187561442; Sun, 22 Mar 2026
 06:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190738.151614-1-email@sirat.me> <20260319190738.151614-3-email@sirat.me>
 <8502eb51-53c9-4f1b-92d0-21b06fa4802e@baylibre.com> <CANn+LWJEJJoGQU7p2P2GrOcA_g2x7jEnvjcTJYG1hDRUnRw3UA@mail.gmail.com>
 <b1da32d2-e1f7-4fea-82a7-a40e8073a100@baylibre.com> <20260322110319.7d7558f3@jic23-huawei>
In-Reply-To: <20260322110319.7d7558f3@jic23-huawei>
From: Sirat <email@sirat.me>
Date: Sun, 22 Mar 2026 19:52:30 +0600
X-Gmail-Original-Message-ID: <CANn+LWJwPUiCkz_godEeBvZnXEXzNmCW_-ou=wHL+kjfn0zF_Q@mail.gmail.com>
X-Gm-Features: AaiRm52NweY6HyFIQby7OSMCCfV58Jsxo_o9z1JQPpqAQeFp4LsvOu-yTm0_v6Y
Message-ID: <CANn+LWJwPUiCkz_godEeBvZnXEXzNmCW_-ou=wHL+kjfn0zF_Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, nuno.sa@analog.com, andy@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 5:03=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 21 Mar 2026 19:37:58 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On 3/21/26 5:39 PM, Sirat wrote:
> > > On Sat, Mar 21, 2026 at 11:09=E2=80=AFPM David Lechner <dlechner@bayl=
ibre.com> wrote:
> > >>
> > >> On 3/19/26 2:07 PM, Siratul Islam wrote:
...
> >
> > If you do a buffered read, which stop ranging when it is done,
> > then how can the direct read work after that?
> >
> > Can we just start and stop ranging momentarily for a direct
> > read?
> If the latency is high, then worth considering whether autosuspend
> and runtime pm can help. That way a burst of reads will see low
> latency after the first one but we won't be wasting power when
> no one cares.
>
> J
> >
> > Otherwise, is seems like we would want to have ranging always
> > enabled.
> >
Maybe we should go with continuous ranging then since it's the
vendor-intended behaviour.
Since there is no hardware single-shot mode, by design, I think the
driver should just behave
as the hardware intended.
> >
>
Thanks,
Sirat
