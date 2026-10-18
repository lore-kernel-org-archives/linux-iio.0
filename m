Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCEE39B49D
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338008; cv=none; b=W567tEml2H+hqBxYtpp9GVsR07ZLUChcbbH5qvORGzkvBtbR93ytuhFrh/7PJGUfi5/z/cdTobt7nAZUopP4mvKw/2I+4c+a2nnFNb3UE/W0+/0w05g1ceizcI3heauY7vfDpwHKWA5gztNWF4OGX1z7FGJEOpkLrE090b8QlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338008; c=relaxed/simple;
	bh=9kce7fsbYEg8ixtIkmlAmfJH7Iu01tFp4/06C6lwBc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tea0F19AO3Lw3SwcV6k16f8t3VY4O5N/cQIKuluAXds+ZuUw6q34Vjn0L5p5f0KxWc0oNpvz3X/yQ+9Ng6NmQpfH8IdwVfGZBWx2ukmcAskuBbER7/l7aiG7t38kAgGFTmfv+rk6DCoDOF6iw81xVhFd6s5+RTxLrtUyFpJcdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw0fSaXM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw0fSaXM"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c423b145922so88017766b.3
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792338004; x=1792942804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LpVfLiNPs0OQlpSkKCUQyoFk2dyYHH/SWsGcZu3oWUo=;
        b=lw0fSaXMH8D2qo/O30jDyePsj4Xc6M/lJygMKqyWRmMKdwJT/KdoCvyH7duVriYVxT
         ajGcJYqHQJQWo7h6UWFEoCdQLZPHqxqLLFbFvMBbAlt5Jxd7/5nO8+9XSC+K2FMaQEFM
         HlfM5MAfVS046fY/G9g66KSi4MdLFPRCWbrEMXbLHGB+RRkHHf/YbquLkym/VMq80bJe
         rSVQ5ZHCsJXKIyl1/3RGDvh8Uzquqle3F9Apc8IqDyQrrRQCPzeYcQGNoQy4VkAEpzdU
         q7OeKP2QvR4TjtaN2CO5+cDupJrB6buoPFkETJLli6mt2+VJd/nQ++0TqFCmZOIWy+z0
         Ej3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792338004; x=1792942804;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LpVfLiNPs0OQlpSkKCUQyoFk2dyYHH/SWsGcZu3oWUo=;
        b=iWOI38Jd06ZsNCmCfxpZyFD88nLDy9AqUW8NwjnnAnYYN+b9mpZfn8n2QAuttdGxSG
         wcShqFfIKsNASMYAKBfHgKbjXpwbHSZ2VfMvsXUxlVcBaXRAAgAoztOh2tgd+YKeMUr3
         z42fGMcg6RPXq4pxE7tpWh4Z3TpQvKiubuAmc0acPtJ7gJh5UrOpRVrGI/3vzhOUFSaf
         EmBoWkZ4WCgjK/8PdEGU5e4R5EVehwlp+D0pCNUVA4rSWYuQWt3CJCEwWGWMr12AatEn
         nZy+98AE9yJw0KXlDrmfnSUmF3cWg2Eszwjoh1dB8TvjhL+hIMAb/HwYJdktnfcFtZgW
         kq/Q==
X-Forwarded-Encrypted: i=1; AKwUvByxhhuB3cdpLkRmMePNJyr/QN01H2EC0YwAxan5nmOVY2dZhHHHneBajqDAqtY0VZwTVySBKK+DdfA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoWirkubXerzHHXwFmU9kwovmjZc8lWZJ8qmMNPyaRvOSSMlqV
	fW49Gw4Vk4eEQ6me9EiWzSl4i48ONyEMVGf7e+axILqayKWwFqUwxepv
X-Gm-Gg: AYBFou1/hXtTftjmcAQO3bwIiRtazmCEgbqvE77xN6u2mhvX3KZV6tSSvANru5kJzzC
	i6dMPQtx+4w7Tx0PnT33x9Uu6KpFIMKMib0gTnn7NwDH1L9uLGr0GHmJ8RT5220IpsWHcD3y3H9
	kHofeBT3w+nly162CD4HzrnTgrA5ZQgXuwxkstuwMLvFVnW7yrL26o/oQWwCkLe91dL22ii63FV
	UPP2PtbzyMEHJGyu6woQCYMgEwiTTemKTahMPM4eEJpXW121h12x2zQQR3CWbQGav2Onkr5g//g
	AJet9zJjHr6QRblGE7vsP/7Q6tw7wfvK9pmSbksjzQx6LtXCxnoe0OZvKX1VYpEQMwxiVW4ploX
	bfFxd1tVEkTlLllXLt3/BTkQ4+RbDKYL+3yPW1Mw0vgYoLnyjpT0oRWBsuOuMq4TB1FPlFBrDM8
	aTBrmBB6lJ06BDEOr/SyIGWx3h+sH2B8KJVx0yVAW3/Yn2TKYnMMfjZmEEKcVKUWUsHbrtIoXVz
	8GUHlK1yyFjzMXxUXmsCve+7Wv3Uqe79lcf1mfEJwBGAPefBU2fVR1UrH48GY9htn/dAOScxbOh
	PUMUCH+W+dAKj4Ulkaecy9La2NF1Wr7h8Tdl1RBBFjaTBMLJlLRDXsn5VfMlzox4cghErmkBwvf
	HauAfWI2RtSIDrEY7bQd3Ga/T/k61hymA4+N+FDt5pXgRq9W7FhvjFhUlb9bglpTE
X-Received: by 2002:a17:907:6e9f:b0:c21:9b4b:2690 with SMTP id a640c23a62f3a-c419d34fa71mr381776866b.17.1792338003922;
        Sun, 18 Oct 2026 08:40:03 -0700 (PDT)
Received: from systembl0wer (brn-rj-tbond05.sa.cz. [185.94.55.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb4ba6sm268672066b.75.2026.10.18.08.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:40:03 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:39:44 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: wrmfwv@163.com
Cc: nuno.sa@analog.com, jic23@kernel.org, robh@kernel.org,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tenglong Guo <admin@micronull.cn>, Sashiko AI
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iio: adc: add documentation for
 adi,ad7816
Message-ID: <20261018173756.35a0eca9@systembl0wer>
In-Reply-To: <20261018110015.39497-1-wrmfwv@163.com>
References: <20261018110015.39497-1-wrmfwv@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 19:00:15 +0800
wrmfwv@163.com wrote:

> From: Tenglong Guo <admin@micronull.cn>
> 
> Add a YAML binding document for the AD7816 family of ADCs.
> This fixes the checkpatch.pl warning about un-documented
> DT compatible strings in the staging driver.
> 
> Reviewed-by: Sashiko AI <sashiko-bot@kernel.org>

No, an AI cannot be credited in any tag (except in Assisted-by
but it will be deprecated). The v2 review returned several
issues as well, so it's definitely not worth a Reviewed-by tag
either.

As for the binding, I've sent a patch removing the AD7816 from
the kernel [1].

[1] https://lore.kernel.org/all/20261006115119.1416-1-joshua.crofts1@gmail.com/

-- 
Kind regards,
Joshua Crofts
