Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06247B413
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120010; cv=none; b=UUy+9shmA3P0J6oqWmg9o+2No/hpY0748sodD3skOxGrQgDI/RgyCXC3n/phd1ziIhHGS0dSnhfg8KaC8d08mOXFJ74sbRV/qyGYMsaxDCXuA0+axvVg5j/UUsyjbcmsP3r1Jz55XAz2xc89U/nFbto0oqLfRQJkRfSQfKtawGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120010; c=relaxed/simple;
	bh=hWz5XuNNH6IsELRjB/pr17epEqauWvX8kaZ2l3hPuZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6oaHFrMSkC3e1CsL+xdgTRPK5WFp6kcvQTqvVZBm/LzMzZD81OAGIJp/PLqd7/NjuPYQKftNg4latnMXuTEcR1KPpiXstAIrQoBY/WBNIUGvKRJxFnl1zR8bmzbVLgt4yn/hDAMwGAc1NAOxBJGrWN9cXYl0QhqgI6um4r13qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+5IplrS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+5IplrS"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so22437695e9.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 05:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784120007; x=1784724807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hP7wIP17IllMUj2NiPW3mgVs5U+s5JJ48RRRp+m/d5g=;
        b=g+5IplrSq+d8mCe7g/wdx9efOv03kjXKMZe2lacoSEExozbWiZUzw7JI6yfytFDaK5
         NtPLjisa8F2UPv3tkmfzqbBxuJv2sVrjNgcSkEH7bE0ujoj2M3/O+ozAp9HQDpXhBoDY
         ek093hwF6fCXcCfozmx3+p6++b1qUgyqZz8tQoKjohdjgvk+4vPJsgzIcJw5hF5Stgcd
         Qn2VO5x9jXv49IRr/8KuRRhRmjLkpDlSXdeckWL+Om5w5HXP/Ano5CRTzdtDP9XbtJz8
         HCu4U3bjgnLpOAcNsR7VpbPbRhao6jAnZnv/4qdWaK5ATfoNrjAhRyt1aJxZxWqasaZK
         NFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784120007; x=1784724807;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hP7wIP17IllMUj2NiPW3mgVs5U+s5JJ48RRRp+m/d5g=;
        b=TGSmmmelRazxAQAQZbBVpfwN4Rnw05El3cbk9gpzJy/qkWgGImRj9XU+eJkBF2Bbuu
         RBfxz0dZ5ewFWembr4eFi7yYPW4NyK6ayAS3nfLThv5KUsLsLn4ngIC6pvNSFh9aRppg
         iAhTeRa34IonrLIMUoMPnCG4m+MY65iG6jTu5MkA+Ge47gtalLf+ztJyfmdlP79Tk/Tl
         QbVqZjE2h1yl9Ug20O+CJ7i6uBgi+SKOdnHA1OQ9z49z7oarXGQexAAs0YnPUemCSSPB
         S7AkuKERPOjJPGFGX91UFUzwSuiEVrG4qifnSsXVI/LvNNvMOE3i5LwV59cg5+FtTFl5
         sZ+A==
X-Forwarded-Encrypted: i=1; AHgh+RqP+FoOUIm1vPkUFlRYoLVoW3moI32koMKdkfw2q8yE0Uo3GqwVa2qnxiEV6KJOT52DkJhwA07QG7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJkEz5xiM3yEtvGX+490ZlvYCJQ8FVv5oA50LFowtAcfZkRv4
	cu2ldJg3Zazy0BUt+PSuMjBTRlMyTDSkZIh2AvJ9alIwnx5oq9PcEpZ5
X-Gm-Gg: AfdE7cnuA4JHJPGWvhRQ5h6mzC6feIZ+6RDufrn2LRmMfSeSIIULuvqmv1OfRstH7+8
	1odW/NfrkwvJrHn92LDtL1N1Cd85zvK/w7ikwhZxMpf/gN7AUCYArF88ZjmhcOLufq2vPy3t5FO
	1CBLjfEGmdj8ojfDsVTSfbNPdmiAvL4VDuytYoXftXVlLQnQMUDsCKpSfUP2unf7gmyn0ttMaIV
	LgoLrpsjFQ9ssMI8JiTIIEhLyJhzDAx5X6Y60dYsuLWuYFlqGQ/Gl0NpYgMucwLugH245PvEbP4
	3k/o0mwDfp6ZC/4LI8glzkx5BkuP34tWE9aJ1eBUFeYUlGQ0H/wUkResBRkhwofria6unyZfkUv
	apYM318FYo33M+hGHBykgbpkRsG/T7F1QaGTiq8eNn/AtdlRSU0IbwbksFjCHJidO3U3fzibedG
	LxSRFkMZEhQJiS/fWHCXeiNthqO9BwcQO1KhaXKRsEhYzmH+bnIAefvbvemgn4cPd86sn1YFn7+
	8v7eOROpB/aCTawtoKIAb9iD4ekXu7i63UeaYxAu9Q/IvmRNsdZSuGmbe7Qs6UcJYpdDWuSKHvd
	QpEt9TDpxoTwGPHqWDs0aB4rGrfyQ5GZVUBwVUCpYv49cCYFQ7KYvk8Bb+TyYdsO2CsoGdS/SSp
	/PwxACvanrR6M1SilGRgSpRg=
X-Received: by 2002:a05:600c:37c9:b0:493:bc4a:fb55 with SMTP id 5b1f17b1804b1-4953c28951fmr30630675e9.38.1784120006763;
        Wed, 15 Jul 2026 05:53:26 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c6ff429sm38564585e9.1.2026.07.15.05.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:53:26 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:53:24 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nikita
 Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: light: ltr501: Add ltr329 driver support
Message-ID: <20260715145324.000005c6@gmail.com>
In-Reply-To: <20260715-liteon-ltr329-v2-3-d18af55edab5@geanix.com>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-3-d18af55edab5@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 14:27:25 +0200
Esben Haabendal <esben@geanix.com> wrote:

> This adds support for the LTR-329ALS-01 chip, which is similar to
> LTR-303ALS-01, except for interrupt, which LTR-329ALS-01 chip does not
> have.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/light/ltr501.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 7d045be78c6d..379e57ac5f5b 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -15,6 +15,7 @@
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/array_size.h> // for ARRAY_SIZE

Just a small nit, even though the list isn't exactly ordered, please
try to add the new include approximately where it would be if ordered,
i.e. array_size.h goes to the top. Additionally, you don't need to add
a comment.

Everything else seems fine otherwise.

-- 
Kind regards

CJD
