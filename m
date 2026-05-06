Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76793286AC
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778027949; cv=pass; b=Z2WhpcaR2l9xvQU3uGlsDrrQnZIcXgZL/11BpeQqT74qcPaJsOienlKBZNKDqf+Q5ebqeBQFu6hnlFc6Nzo1MFUhc9co/Ord2l93iH4fqtfJxw87XFH4PWjX+yNfU79HCJZz5/mInytfUutWMUVijPxZucCCYZcekBywkJh0rcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778027949; c=relaxed/simple;
	bh=E6wk6x3feqMGqNvWZ6HGjh2i0gau5iLbDqN7UduJEUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPzXFlznstHS+6BFZTrC720tqCM3Yf5ur3kO9z5Qv9IPVSrmNhRkDXap3wFHw8ZVPtQGwXGD9xzboKt7OGcIA8mZ2w65F85BGSkJuKrQSM03sOhCZgRp1JZxOK7VVUPpvP9MLaCW5FXgJI0FVrCLsw1FL4caVg9wBHFoaWZd8rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyQrHlB8; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyQrHlB8"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bd5c582c47so52584077b3.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 17:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778027947; cv=none;
        d=google.com; s=arc-20240605;
        b=RhF9UVWSPbs2ClANxDD2uOlqfGqzZ7Im4COTFbDqQKL5cUOy1Z/eerS6TBjaD6m0BQ
         Q3dICcVvuMDNrnk4HToq0262gkFbK/b76L4VUJHAswVCQ3OvPMZ8ucjGpNda8sRB9X1N
         IF7YUR+9GkoP+DfenZ8dKHBNZQSOnQu7sfwOVvSMVEVes8+klJVwIsNIP1CBOKdDCRGD
         f8HzI2Iiclamq3cfi6wtB+GZ1jKnKmlNQg06bM2ClS5z+Z10lye68WHVsglbB5KVxpGD
         Apj4sMUZBJi+9s/3wLAsCQqRehnmaQ1insTZw5WwnoD4wtnpEvriJnlXkNBZon9YG/wh
         WAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FjFnpsiLmhJzvlbu0qu69qyy9E1gza23/Vj/JX+sAeQ=;
        fh=jjtUJsZz0HvEPDfO18pOqPnZe6PSo6kEZZFxD/Vql24=;
        b=RYZwB0+Nk2r2eQ++5rOMOFUVc3uDToh5Qjgl+OSy5c4XxAKpzrhrtKY6j66XE4REAi
         AeRaMI+PQyeJuOGFW+dCiEuKTwHjU0wuggVHA1uNXLkoz3TGXCZKSVvk+hQuI7f2/q5I
         MKKpDPcKDi+fso3iKUqXRv4seFnye6Ns/u9nrnM6tprI4+azUOL6+PIaR95aouVj5oA6
         xTVM1vYi/zetNfMHeYayg+83fe9pQEe2y3ysoSradYmSIhn/EYI1dV52ggrQOMsnmBPD
         w8ucFvoZICUSGcCOZ1lNdCA+ZGVEZdtPSpQNEuFJzjdZNbIgoUYLLbWuitDpftVd3VaV
         24dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778027947; x=1778632747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjFnpsiLmhJzvlbu0qu69qyy9E1gza23/Vj/JX+sAeQ=;
        b=hyQrHlB8MYqpp/6XMW/smoamoSiLgnRERxmLNYWOpvBNYN/gLrcJmbJkkryiRPPOhy
         Jz7OqWqxPeygEnJ3Be6wi9UoiQbNa3OBf+CN2ah52frfrJ7f0E+BK6dq/dhclWn2PNm8
         yc7o7STpI7ePzjdSAr4oOqS5UGYufkO8l2VLK/YXPFwYAaxyidtG7l/MSttbV1MIHi2e
         Gk7DtoEjLbS7yibuW55kHVWbUeEgyh6Ba6K8HmYlby0NQraZ/6wXFgSaVVEQ9g6KQ54v
         Sv4B33gAGgixBNPN9PXR5TGDyi5d9zvHE5/kMz6VRgdzQ5TkdAy7D4enb38XSjiwtI8b
         M4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778027947; x=1778632747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FjFnpsiLmhJzvlbu0qu69qyy9E1gza23/Vj/JX+sAeQ=;
        b=ondq+OGNJbvcIwmtfesdNdemPmoUmRU2B2XiV4vWmJbc9flYB/Hk1W8I2byiMZflfU
         6lQff02a63UM2PBpJpW+go3qowpYY6Lm4HXjbRlrSBRHnNvwbqAX68dfKR1xeVT/jaDl
         g3nftJdRFn4/Q5caLi9EWSoUUqKFa0m+So/VJQWws5v54PPP8izKOpMGZmmMpnYMLnh2
         cpx2k3i8XXXzYZltMZn2lre/uQiD9gKFEZRTeqxkx/uO2WmQGmZV7yIPUGu6lEw2PVzw
         tHjGevuSCbJsK0q+CqmLL9WAXitheh4dDsWROVdHZXFaHhffdP0uj+efBPuXfqxmDBIz
         yebQ==
X-Forwarded-Encrypted: i=1; AFNElJ+slaj5+fqcDeMoSZZbSA7Qpcz2YM500RIJXEuALyTXnPtRX2Y76qyDfcDdkaUe7dzDabyOejlfa6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw84mpYAItTB4sOUVtrmkpEhfBgspfzHKOEeSjRE00vkq7F13Nk
	S28/xyfEn0dlHYYP9oW7LZ0fQc3XL1qDjvUVBnOeP3RZbBGKsDd89He3pt8XOhxXY9DmbBiGifg
	0EV6xNY83m6iFwiOvUBWqRpEQUu9Ty9c=
X-Gm-Gg: AeBDietTjcghzG5NR+OibFxzMfGBdqDJ9W2HCmqiiQhioeKb3kQkIoluztIaKhRPT2G
	vewG4jW1lvg7UeMMMFnfOetcAHHnwZD9fvMd+P3kBwIPmaWKQPaOdrB8JROaQbPzJog823JZQGw
	D7VNtKLkhqxX1UDMlY2LVpnOgGDAKacfQBL9/VAuNHTSmoU15eF3awWkQfrrFGpetr06Lb7/09l
	AoAZBF5ENqhXhxIyMoSEgzBoj2WoG1VYQIdW5qrrBXat6nbOZ4Tvvp+zCnbBy+o7iDT2qJcQEwk
	o+PRgoQL9BZwQn4=
X-Received: by 2002:a05:690c:12:b0:7b1:2c46:9480 with SMTP id
 00721157ae682-7bdf5ed84c2mr17362477b3.34.1778027947393; Tue, 05 May 2026
 17:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com> <20260505-magnetometer-fixes-v5-2-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-2-831b9b5550fc@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 5 May 2026 19:38:55 -0500
X-Gm-Features: AVHnY4JhVgfpLlQH9KFRYbTj8a5mIY46vDmC3CftLfPmhERTwrq9JkXiM5o0JOk
Message-ID: <CAKqfh0En+CuUFPttGpb0x26sMtnTS=u1c6UvqUUYiL4bN+yyyQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] iio: magnetometer: ak8975: update headers per
 IWYU principle
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 6:58=E2=80=AFAM Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Remove kernel.h proxy header and unused headers (slab.h, iio/sysfs.h,
> iio/trigger.h). Add missing headers to ensure atomicity (array_size.h,
> dev_printk.h, asm/byteorder.h, irqreturn.h, minmax.h, property.h,
> types.h, wait.h).
>
> Audited using the include-what-you-use tool.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
[snip]
>

LGTM.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
