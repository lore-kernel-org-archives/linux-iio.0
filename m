Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB9158DA3
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788207; cv=none; b=q9Xl8U5GH8Z7zrbMGtTnbNd523EqdkclDRC6mIPKl9typlDPfmYwIV6tacmLQsbMXirFh290cLRKgqEIAf7LQoSXYfA2TFtCSaIKh2s7ZBOU2QCIY7jSzhBYS/jN7sp0KRTrZk+wk+gzuu2ay2+hcpLA3MP1D1nomYG6I8oYJsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788207; c=relaxed/simple;
	bh=uwm0bSCXmxvpSNZUShveuIwJcCvk78nSTrVPBeuWho0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmt3T6dRzfoV205wGQIf4sKd1xcNalbDQ26AMY3rMcbaSQrkbsrghaFREW9rrJrmBr6c9ZVT9f0icR6x4+hdqX+agsxjWw9xe07khxal2kgV8nUGMyxy5c7PzunKlKIg+seV/cU5bFCensfnLN6OMyroRQRALQQCW6e8GO2Dk1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56a857578a8so3071236e0c.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 01:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772788205; x=1773393005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3nZIv+ouWgmKG3C/K0jHTIxk5om4dQA+zY3E5ywYQ8=;
        b=uBdNzq2BIs7oyCamlhD2YetPm6RDEfYUzU387/BDS2qm74VMWfX09rXrR8vEhXg1gr
         rJwY81eUmiaYpmov+1swIfAXOQn124DeHF5Jj9PtprcBLLLEf0k4iFSabYfDRBYcL+Zo
         vYd8tmVPJ3MTdbz5sy3NJtW/p9mXzXWZCRimQEqPcLW2pyHfzxSHMmHMnlMTKSG+kTw9
         v4qX7zvZAuhOJ4Q2oj8cQ8g3g8rHyT793Q2nnZmjlh0G2c8ZlSHdk6ZeTw0meDUWwzF/
         iwN87CpoznwZD3qX/LObpr6g3QCYEqHl64aT2UaZiV21iMXZazkQHcrqpyLwMQVIpJib
         7P7g==
X-Forwarded-Encrypted: i=1; AJvYcCVdIXvrBu1lnm+zYWtclpFpIjeSdhuNOzg5vRzMqPlweaK3UckVAfDzdX7aA4Jqr4Siqms168hScD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnSRc9ZlYMjK1wCSrmQEfWFDfRovb0vSSfa0RXfJPj0mogOcN
	DiLqZnIOJh0PRjmiVJ1VNO4yFru5e7T3QjtIeJhWF1C8aMFTT6+Knxra1aKwDO79XxE=
X-Gm-Gg: ATEYQzyokbj/D9rq/HFt0PhA1ZSt7zOypx49+0ZhD4Y/AJXsCNbMvFHcdC1FnMVeo7Z
	fSOtboMzconWNrSGITrNB+CZ1C5HTT0JImx9i90WsTq+d67aYshUrGHOVgDKL/2lDpMdwDDB7xs
	aUisn2Scseau1Mlk9Cighu9mQnpwMpegu351wBcvaFYk0mZ3HL90dt8RDH8hV57tB0aDLJEW+zL
	qrhu8u2htdiuyjQ7hubzKbhEFq4OM91KdDuazHQEyXsvtQLKn3FR6b6D0WnqX6nqzEEJ+bhpdjn
	PjT8BO32lLe8gku7QMR/ELlMuKIrKxGHSY/wZOGbdTyWMCOwCTOweAFhYsuVqjB7nNjj786eAx8
	5SE1Juh3dCPD3Lv23/B6xJuXNyR9ENuwR4AQRNfmi7MpLLzh8JdqEGmqaiWq5dVatTwFpmxTh8K
	WqhfsNK2ogPCfnYdF0BkLgp3EdvjaqkgjZ0zH3ibzYpxtNCBLZdoJqtTR6YU9T
X-Received: by 2002:a05:6122:1699:b0:56a:f348:9b8b with SMTP id 71dfb90a1353d-56b07dff8f9mr383905e0c.12.1772788204722;
        Fri, 06 Mar 2026 01:10:04 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b09b20d02sm795950e0c.15.2026.03.06.01.10.04
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 01:10:04 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5ff05af29b4so3226121137.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 01:10:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUa3gEau8LJBGqhTMMVeWjRV4QpTn1JqP0iNRpEuly2Y+jIQCQGmAsT/urtcMiYWniBJLzleHMvam8=@vger.kernel.org
X-Received: by 2002:a05:6102:161f:b0:5fe:626a:a51b with SMTP id
 ada2fe7eead31-5ffe5f89dcfmr438378137.14.1772788203846; Fri, 06 Mar 2026
 01:10:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d42ba403c1fb1aca88b82ba3020ad0ec442a455f.1772705608.git.geert+renesas@glider.be>
 <20260305193152.253dc267@jic23-huawei>
In-Reply-To: <20260305193152.253dc267@jic23-huawei>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Mar 2026 10:09:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVtNPU8fhznYmgnC_55xdqdd545eD5nHtiw_P4AD1v69g@mail.gmail.com>
X-Gm-Features: AaiRm50dI1vKfZ-T0zEsv62f5Tr9uck-3NrMp4NLVNXCnJh4Ix6huEV-NMCebHs
Message-ID: <CAMuHMdVtNPU8fhznYmgnC_55xdqdd545eD5nHtiw_P4AD1v69g@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: rzg2l: Convert to FIELD_MODIFY()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan.

On Thu, 5 Mar 2026 at 20:32, Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu,  5 Mar 2026 11:13:55 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> > Use the FIELD_MODIFY() helper instead of open-coding the same operation.
> > This requires splitting the double OR operation.
> Hi Geert,
>
> Looks like similar can be applied in
> rzg2l_adc_conversion_setup()

Which case did you have in mind? Note that FIELD_MODIFY() needs
a constant mask, so it cannot be used with e.g.
hw_params->adint_inten_mask.
For non-constant masks, we first need to introduce field_modify() ;-)

> FIELD_MODIFY() is useful to shorten code, but if we are using it we should look
> for all good opportunities in a driver.  Please check to see if there are more.

I did a full scan, and it seems I did miss RZG2L_ADIVC_DIVADC_4.
Will fix in v2, eventually.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
