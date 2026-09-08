Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679553D0BA
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871324; cv=pass; b=fsa9huzq9LmMU30aPg+LxpsV5880mLTssURgSVe0pw7zMsyKHl9JD84nXTZc7D3LLjRv0V7iWOWz8su3QiQ68Vok3wPEvporVk113SijnHm2eyReuO7zFW65LebuS/KZQrtjVdJhNsLZXDnuQEG3vYcnd3Zs8kU63/faXdWQ8l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871324; c=relaxed/simple;
	bh=FoFrigmlvBCol4gAOv1BVVUy6nOClXwHsZRUnMO/Rck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJZGumDf1LlHoS5NP4S2fd0NvKGKUZGH197mGTvb+wJHE39nqu7kKZNdS3G/uBOMKWx2amsySTRgtKoe5AsFscjCUOnEv1nXp6r/BIBFubodaEDrDhHj23ZjBJefYnxZ8CgeEUngC0WTOsA8IxakiPuEg7A7u81OzBHm5B8jj18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPln5Zp3; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPln5Zp3"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so6791789a12.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 05:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788871321; cv=none;
        d=google.com; s=arc-20260327;
        b=QOK7NlAfBS6InL4akmUvutHIoJ0Jqyu3m+SV/76RaDvbPF11tLdzurS4qDRSBcDck5
         YuFsiUltoXOzQQUmfLnvFSf6QpYpDh7xlN33z7EBVCMJf3syZ4eZA0kJJlN7LEtm5sFp
         xWqIT9HLfQdifg326e75fANuxAFLh89Dyg07YJSkc/kixK2ALSMT/ChfitdGhp7DJqja
         d8VFv+md2+eO30MM1D7tdue/+tW09jYBF51Bb5H6KI0oMxyXHkW4Xf0wGPkOom5g/KH2
         s6lI10DVMqc/XV9e0/sVT3Kj65KuCfIYWK+TeGs1Y5CNMpPQL/0GDI5TOhmQ5BH+lP3s
         5hCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FoFrigmlvBCol4gAOv1BVVUy6nOClXwHsZRUnMO/Rck=;
        fh=xUiQ08Aox3VcuXVVqyQUD16lmOYhcQQGpMuTH0zR35o=;
        b=XREBu2hPfc6FFLp5PpLO7ZErBugiyzh4p9famOD+v5Hi/yGrc22/M9TXdrgjdGLA/7
         dy1S98hqydJogZi88eCx6Ohwxj5g+F06JV/l8307x+ocW3qwRtM9kgp75VrIeyEbwmBf
         lU6WAP/qto/wgIuWy4/ONLH20Z8xwyZkNh5OHz6h9tYf/DzUB5dpf8QWSk9DQ3kU6m+P
         07F/mIUgrhc9JoGckiiulp5lTLfozH75f5xjQKFKPgNW0zYjaIwdjB+2cHQQdttJaKJM
         Ch8C2SM54goyWCBQCrjlQwWRihj0ezSmeWyMmbesXS50WbDLzv/Z8mgCoW9N+ScoeJbT
         uLTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788871321; x=1789476121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FoFrigmlvBCol4gAOv1BVVUy6nOClXwHsZRUnMO/Rck=;
        b=hPln5Zp3VVx4vs2pVzL4csIiFAbHnF3Hja+WUxbfU5mD5AWmppMCIVB4nAERESixV5
         3IYV7rqGZR6inPt+16Vc6ZtwRCDHjYUJ/kcmBf9CHPPjyTdLAnF3O8cumPFops1UMNW7
         JydV98T4ZEbVbcwLpTf5X17h/WPT+PMFc2Igc4aE7iQY0DiOW6rfyxUIs8QIylQ6PigJ
         YPWWI/TH7j40y7jJZS+gSl5qmaa3u49SFkYrO9k5lDlC81mPun0Ejp50v2vUQaH0qiXA
         CTOWch/1QEqi1iTVrBIeiurtjl6VUXcJBb8BrJnYZbXA9tQfYdwCKNPm5aqckandgYJO
         4inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788871321; x=1789476121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FoFrigmlvBCol4gAOv1BVVUy6nOClXwHsZRUnMO/Rck=;
        b=OuQMO9tCL/ejy0OTXijpHXRndUoQUMSkXcnUFsDI2BVokOtl6Op94Q59vBkcwvWxMU
         aC3Mu/ohyBiGrhuqaXIzXuV4soV04WCbLACq7v/eyOLvLFYaBPehpcauSjyMSf5942nJ
         EJlCDfTJoeOX/4dvLYgYx3ZI5Yf4MadtFEuXv+BV8r6vjDGgLEILpvpEoMAnyiRPbbka
         +TFkJaQHdr6KA1kAkh150v3yGPJ8YYVOaFmDz8oSIGDme8Be25TDiocL4YspX8noBb5X
         XzLO9MZ4nhpNnsZK4z+qLal8yWrkIxYN5RZyJvOwPOmSkpRMvdYGt8b+1Q/dn2JVqiLZ
         uzVw==
X-Forwarded-Encrypted: i=1; AKwUvBwNOT4NQya/niU9BcqdLrXE/iD/ZHPOW7s9fSA0hXypNeuRsNu5tQipwYAmdiPrd/+xURRtQrYrZmU=@vger.kernel.org
X-Gm-Message-State: AFuF++mAAfEWOQvx+1qAVuxgz6uUwt9/HfUu6X0DmHDMdNxpuzaE9Jhg
	auJZ7A6a8H5uNYrsl4sVWY2HFGQZS+h21zDskLwfRJjS6RTaBVdC/5PmayxTf4tayrfeeOEqkQT
	sBA8xaU5N/xffUa1XWyevuLdUaTiBxPA=
X-Gm-Gg: AYBFou3xkIHx9eQ2LbUhjhEFgtzRNjsKJUnxiYWQ/hv36v1Occ9ZrGVNBqATJOJDi1c
	GxLYgfxgIJmsQspxEeOPW0FJmWAhaQOMp1AbRzzWGi+s5weVF1b0s+eXY+2vPFi4M8AgC7Hx7yP
	sifxSTLFFUCX5SOjJBrdc9NtnXilxCsPEKC6lUkc4ew2OBZH3KABiB/345QvGwIpsI9u6f5y8ij
	ugg8fh2HhLCwhngjvOodBY6If2vIAfEIeVZ7WiMfb04pBa3VHl03u9be3z/hLjPz+7BjBRSfWmI
	+Kj/t+ex94baZYVT90G+l2LvMn1Yyzxnj/uxPNeULuCXDS6P0+O0o8lU9nK6rPLziw4vShqcq16
	E5Xwyiij7paQpmp1KZZMVaK3QF521Yo6BcCxADiTyHCEzK8l9WW823IU2jpZ7+OSzWjvrDlkZmE
	CrpVv7lZavkQ2n7h91UeAMUQVuxpKq5A==
X-Received: by 2002:a17:907:a892:b0:c20:3402:bd35 with SMTP id
 a640c23a62f3a-c260c988d8cmr1050021866b.12.1788871321161; Tue, 08 Sep 2026
 05:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908114047.1360-1-joshua.crofts1@gmail.com>
In-Reply-To: <20260908114047.1360-1-joshua.crofts1@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 8 Sep 2026 15:41:23 +0300
X-Gm-Features: AcwNN1WS1TCR78p_ZCpT7YYJ99OzAPGWGJrL9p5fNGsCglr8Gtv7IcE3tK5sR_c
Message-ID: <CAHp75Vd-LTwJU-SvVug3MNPzFYsOQFc7qQ5AiMDjHOx8XNkHow@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: max14001: add missing MODULE_DEVICE_TABLE macro
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, 
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 2:41=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmail.=
com> wrote:
>
> The MAX14001 has an SPI ID table, but is missing a MODULE_DEVICE_TABLE()
> macro.

Is this a problem?

--=20
With Best Regards,
Andy Shevchenko
