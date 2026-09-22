Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9806A38735E
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091065; cv=none; b=NI6+S3wXGLJItQtFJlTMyqB0863ZN2s0R8qzlGx+vMu0KLSncfzFXG2TTicyYgA1aXJ6gHv19GPZkPlbp1g0K4TIVKx7D4JqhUkh7gAyetg9frVnKKM/m5mLWZPnOVlaIcCSKT13jjSETM4QrCSwF1ek4mSGaBgr0bcS7+Uny1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091065; c=relaxed/simple;
	bh=0IK9+EwvsBoYDJYGUac8cxaRSG01Rz8fKvCBOkF5H0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwfREZcmN4YgvHO/b4MdVxHYp/L/wYZ73g/RC4jb5bsGZLhkedbWqvJQzDfVw1nFLvHIj4/vsEtpgaVlpXxr89a3tH4xPONTW2BHhrDItmFHxYOJqoeDZFnMpg7JAa0bNgceYbqW6SoryCq1j2sfZBbCk7PB7P+TT4y9NW7tm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78564421fdbso1443523137.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 08:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091062; x=1790695862;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/Ivia3s8tcpv+jz42ruOpNgJ1iPkEln4U/VwumY2Fss=;
        b=vJr72QIvGZF/P0IObE6kqZzdpOc4bMHJ1PUZWlpWdwtvhFpfBB8Xc3CCvrL6nqYyX5
         wi7za68iV8moOlcUV2SOL+cXy3UNOCzDukJRd6yBDTZ8KuRgFHermC0gzcg/491LXp2z
         HCghAj7cNqkIEgS8W6MqBG6Fi+jM+Iptin9Z29DeN9ziUWiUdR/qVALp2jUGjMfM3nBr
         NogOl1Rjb6g7HPrP1OcF7pCX/Mv8vMlu/uHhbYy/+5cCgEGp4QO1JJjJ6zEIDSSXtw9/
         sM3aRg2orcfWJFTXHGWSesE6WrQPAkzO8cE5OLTcfHn7anmjMRe7+b++gmEQnb7+ZxoU
         s9JA==
X-Forwarded-Encrypted: i=1; AKwUvByIak/RXeZyaVim29KO7i7LqWrePB9nsC3S7UDs5RqDoMAQnU17iIiwvv5BLqSy2n4x7jbUQ8umM+k=@vger.kernel.org
X-Gm-Message-State: AFuF++mkhkCAgqkfZkc9fsd6sNKbk2xcGC8pwfXjlrn2M5KKQl4ufy0C
	VFYl41mYPT4+5KzAn9JpDS+YvEUPjbyFkOMmV7/q11lgL7nQ7IbZeZRJTFAHEIYX
X-Gm-Gg: AYBFou3Jd4lgs9MWY2SMZ0yD8PvoWKbKk5pUYxlWn61Rp89Ijy0hfEkpj7t88zqT0AM
	Qqa7l0Yb+CXSzGOHaYnSe8QE8UOvtlavN+hdsCGhc94q8OflQwtjCXrRyKFWlZkDHULkZa68ZcE
	7Gq+btLpNzdfs4rekgZ79BWYQO74GVl3s1wD0Evsol0kDneahO9RJYhxALiSEPkXwVGbxss1ji3
	8Db2veYtYp/FWStxn3AtYVBPFBpLpcY2+7EgnjNhRbAzEc5jTr3kk6Cflo02X7rJsue7OB57ns8
	oGT8sDql5BY2PdkMEeJc6o7CLToakqJTAhAqrkiNLhBjzXgHzW32nORZUCgz/lrpbJqwqxcNrBU
	cPcZ3Y2SWTUKxuv4/Ad+QZrjx1xCFyy+ugEumr4StnSQIu8y5yzmpZv1WyCLDsJDx8Pj1XqAVcS
	mm9i9zrDlb5MJHa7AxkEI1uRqDo4HJg0eWtIflef57C8JIe0+BkFE9m0V3M+HaEKlPE7XTn6Dr6
	FpJ5PAD0EJX0EftsXP5JQSjO5GIr8RUMV7b
X-Received: by 2002:a05:6102:80a3:b0:79b:6220:1c70 with SMTP id ada2fe7eead31-7a55a71a16dmr7393962137.11.1790091062170;
        Tue, 22 Sep 2026 08:31:02 -0700 (PDT)
Received: from mail-vs2-f27.google.com (mail-vs2-f27.google.com. [74.125.227.27])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5a7fb17sm99511137.7.2026.09.22.08.31.00
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:31:01 -0700 (PDT)
Received: by mail-vs2-f27.google.com with SMTP id 71dfb90a1353d-5c963d7503fso1449143e0c.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 08:31:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwVrHhceuAz7zXNM5qpaE/OQKy3VZkkEYxf4nHYgZjoM+8pi2gYEKknNdigaMdxnaILizivy74kmYA=@vger.kernel.org
X-Received: by 2002:a05:6122:e230:b0:5bd:b2e1:e1f5 with SMTP id
 71dfb90a1353d-5c9b58fd54cmr8860951e0c.2.1790091060069; Tue, 22 Sep 2026
 08:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921110144.44425-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260921110144.44425-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260921110144.44425-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2026 17:30:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUX9s1q6SdrgiMciGfHYAvCp1kFzGYL4pHf7PzzipEPUw@mail.gmail.com>
X-Gm-Features: AclHuK_p5w8PzHnOOSGm4t2QYnyy-nd81aSQvB28I4MJvz8KTxnmCW8kHjNnqd8
Message-ID: <CAMuHMdUX9s1q6SdrgiMciGfHYAvCp1kFzGYL4pHf7PzzipEPUw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: renesas,r9a09g077-adc: Drop
 unwired interrupts
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

Thanks for your patch!

On Mon, 21 Sept 2026 at 13:01, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Remove the compare match and compare mismatch interrupts from the binding,
> as these interrupts are not wired to the GIC on RZ/T2H and RZ/N2H SoCs
> according to the hardware manual Rev. 1.30.

These are indeed only wired to the DMAC and Event Link Controller.

>
> While this change introduces an ABI break, the expected impact on existing
> users is minimal, if any, since the interrupts are not wired to the GIC
> and are not used by the driver.
>
> Fixes: 4d8d58987cb5 ("dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
