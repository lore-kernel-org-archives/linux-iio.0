Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44A17A30A
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957004; cv=pass; b=lM7L+U4ZYkFNmiFBBhyO15xpeeGMRAYP2yPTSqJaClKYmJ7EpjhimysT9CTXrCRoczJMvdMV/yVo/jUDAVcD7iX7I4lMcKvwXbvWhoxkrhM9PMf9vRmTl+iYGc2VNpVZoi6UClEiKIvKzPBI/nFznP2j5zigtWODg6IVyQyMgJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957004; c=relaxed/simple;
	bh=9A8NDFIOttujxgEPXIMc1/yM9qNPFKvJImLYCRjJLE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRaONkVxrQcRadkd3FD0tVZoINbWySqCRKEE2cauUsNXTYt9UEAUWKnNE0ePeGogQ5LKOiNwoHjdjbKWN/Cx6VwDOx7XD05smtoVfslhzwQ3Wn7I1bszjBF131uv6XzBNTlmyOhjN26S4LYDEPWtQtTBxrLFLxxKLUkv/eLwEmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK+JW1qj; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK+JW1qj"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45edc09f51bso980506f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 01:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779957001; cv=none;
        d=google.com; s=arc-20240605;
        b=AO1EiohNbcMf5h66jk2uUURk/NwLjCX0x3OcQUnCLVI6Ig4KEuVka+v91sfL+G59mc
         hkIdGN4bmRj7w8CbfeGZGKeaGMPvm2Hex96t/IFAgqpTL2uQaSl1G4wDoLa/CN8xiVvh
         Hg1I3xOumHXKnyDm6HpbgWgeIz1tPYbRAeoC0fI5jGWBu4LSOb3W60F/hzS1oL39Lvd4
         zzFAFK4p/mxBhKnK9pNtb/FZBdMa+EuRRO90g1JEwb5rzQC/F2GN087ivDpgV6UQxbJS
         YLungREO5NqsA+r8IONiyHrBWhhcZCzJJ6Waxk6Cbq9hTvavw+HQpAQ69srPYGAzcyp/
         2Fpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ID4UwDlpCCXcsLMnyjkMfD/ZISHe+vJrAY1E/iAzyuo=;
        fh=3DWPm0iTYUEWxzQhC2RwfH6tgpfSqyp6UlWy/R8dE7A=;
        b=eXdtPJy8NsQII+emZGP4havVuUbgz38lzxat0+JQnmGc1Ql6YoadgWrxjVs3YygIRB
         kanLbZcSBewBdDPs72ADvRwnvhGYWRXlcptRTViDzkWA/Tn0cen0LBLqhWeDrjexN8kU
         7pPYxTJeF8D5m9Pc/j2PGp0u1LboHtMzYvnXlgPWNDnJuKiw+5pydbrzstYF4TRkeLa4
         bdBARSkNP0ngC8TQlGaQLoOyrN3/IqrfwkfGBCYadJVieoJHeGOR7gPvzUh30T9jGRDU
         LmwS5pirz9YGlodmhsMWIRu9sql3FL9LAD631heikyClCxMo3ORonbrrabOA+XRDbgQb
         c+Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779957001; x=1780561801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ID4UwDlpCCXcsLMnyjkMfD/ZISHe+vJrAY1E/iAzyuo=;
        b=aK+JW1qjL//QJmsrPAZnsq3ljscdPYm5bFHlSy2NF9y8BO+4DgjQWlJDYinKk+fwNM
         ceW6pk9QtGbuYOxaCng2oDl3DV85nlgB8NDDcb4YBrhrSdNzbTpjnIKaC3hz9/b4tAUR
         frrwRydwn2Q45hGInltnq9RNhNe4HtkCE8lGnzYvxCZkdkDIQkhbPQd1abfJ/eNClYDC
         CWTjI+bTegUb9+pfQ1j30gTLEoL5I5dT5yr7ii1P730yUn+ee2620AzCBrO8FVLdFS8k
         ndvnMz2C1AJ6zcao2UjxD2TjdL2dYCPyI64F9anbL9UOG+RBWuJE4Xo2gtmELZe5IDqP
         NY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779957001; x=1780561801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID4UwDlpCCXcsLMnyjkMfD/ZISHe+vJrAY1E/iAzyuo=;
        b=LUpEIXQlHJFk/j2OzZIKJkkpNzSjDxJ+2FbyK9AYyRxGA3s6/bFLNfe/RoP2sRHMpl
         GiMpZWDhZxIQdgklFSmvfpotBm63y3R08iGHpdyYEPgYoR4tGYH3CLYHFtvyELgefK6q
         SX/I+tzv+42suYPmzIbLyDLakT4iDqKfC2BffWLiA650gnsMB95Sce8D74qCTu3v9hkt
         BcVmPLAjNsAR1oM9zgyENnYUTo7hHIWYlR37yK4ZlybA38RrDsCOALGypZzFaD133AdB
         1nm5tPIMO9wH+t9NwCIDzzJOzdVhPrXZDUD80VkkMpKA8WNZ9eXU5lANkp7ODB/Tfv7r
         nu0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/7Dljulj+qU9qocWpCflfUNKCZglH2BH7/boOUcHeK1HoOibOi0Ed2U9IPIcRA2SYyYrERrqC4xGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxo9PMK/Havdub8Gf3JMGp70uiuvAGMQt3YNkyOReZ3T1/30tB
	3xehjINEQQgXuPlujI0gSTTW0XwN/EWDhr20FvLLlE8CH+V2qaxGZp7FAB1htdjMSlWfHK6sUY2
	C1dyfa9Pksnt2DdxPrQ1EzlBxgw+FAkc=
X-Gm-Gg: Acq92OGTmmbguNVNWoBkg8NKQFRcV92hMRM7KvDeZL+75SmXM7W16vZt5H09/jZZ+2Y
	EC0FmyYu8JHHUIAgbo5T3hD3/QYoPs/9D94Y7JxR3OYL3r8riSKu1u5nObywN08J/lfiOZH3WFd
	E9ZAYaYnGTn9gFOOaNyESOwfM8PW+cqTrRGOrSrsZGOw0sPkid0bGJmnybMtXQGjmIthYY8fxmX
	l6plvHoabhn8OtJGU4olSpjKytYQ/F2bA9YZZHTi6F0F4Kms4eOGkUz8+F3EuCeNc9alZ1obN6H
	0bxLVI2Jh9OhahqnlUOC75PnOmrkGPtPKgKkRiO4JBxT6Vw5rPYokROvm6qgbgXuRZgkTz1fuH4
	PIHP5gFC0+uXaqFjt9V9QIr2FPeMVzP8waFDsTUDVv2R9LIqOWW/agy1Mf4qIoHpIh3ovXrLRfS
	Otj3KEtQV0EJzqCa9F
X-Received: by 2002:a05:6000:4803:b0:45e:7c19:a328 with SMTP id
 ffacd0b85a97d-45eb38a10ccmr42056774f8f.28.1779957000834; Thu, 28 May 2026
 01:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
 <20260528-axiado-ax3000-ax3005-saradc-v1-3-345dd5f6608a@axiado.com>
In-Reply-To: <20260528-axiado-ax3000-ax3005-saradc-v1-3-345dd5f6608a@axiado.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 28 May 2026 10:29:47 +0200
X-Gm-Features: AVHnY4JEcnrAWjy5oZLP4EwsnJKky_x459dwwxnNTUDnAC-f8N5TJlVzJGRJzhE
Message-ID: <CALoEA-z-X5p1dfNpcqxQ7ACU7m9o99i-YZjg56+wdPSv8TiFjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: add Axiado SARADC driver entry
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 May 2026 at 10:21, Petar Stepanovic <pstepanovic@axiado.com> wrote:
>
> Add a MAINTAINERS entry for the Axiado SARADC binding and driver.
>
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2040011a386..e6dadfa65ee0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4312,6 +4312,14 @@ S:       Orphan
>  F:     Documentation/devicetree/bindings/sound/axentia,*
>  F:     sound/soc/atmel/tse850-pcm5142.c
>
> +AXIADO SARADC DRIVER
> +M:     Petar Stepanovic <pstepanovic@axiado.com>
> +M:     Akhila Kavi <akavi@axiado.com>
> +M:     Prasad Bolisetty <pbolisetty@axiado.com>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml

Fold the lines above into the dt-bindings patch. You're adding a new
file, so it's best
to have any changes to MAINTAINERS in the same patch so that it's already
documented when the patch is accepted.

> +F:     drivers/iio/adc/axiado_saradc.c

This line should be added in the patch with the actual driver code.

-- 
Kind regards

CJD
