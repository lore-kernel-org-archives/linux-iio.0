Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D79388E60
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284010; cv=none; b=hmmjQ8uv8CMANov4RCxf5BY+8Q8apuyQm/bXxKqIH+k1L4/cBinBqZXTO/MhtKzd/cvjz+KH4mXgYwmg8kOJVCpibANqLfGmdT6Sdkn0rPxdD3OmIpw09rZcIWUJGixpHFf5ULqJOYIPJHvZPsL00iz8JoFnUApYiKGL2eujMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284010; c=relaxed/simple;
	bh=8tdWPRE0pVXGZ58tQOSYcN2XJM1zzZQa50Q7iMBweQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiCnuOHcN2dZi5fMH4ZB7FOuw0BzGltwA2XDAwjau5owIvZum0cOt/M5qjvtoXyQvu187SaW/7NwY1akcZRo78GyD1x+jE5hd1MU61WvIY7ekbXwoJI0ibo/iP9BWz0QxCNTvTnXVVERaG3DpatfEW06hP9YSlGA1v5VgNMYJvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qC1/0oRK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qC1/0oRK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so6347975e9.1
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 23:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782284008; x=1782888808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQLimcB24UVWEnsefG7vB3o2aiCLX+pbO4V7JdAkm84=;
        b=qC1/0oRKcVTEO63v3W/ROJkYEFU8OdQelaDNt1dwHzmht8xosq/F2Jcl7C5sBhupd3
         T2NKz3PmHsWYGau+UhzK09vZJWBuh5+Bo6CZ/FzOOpsLOaxTtxA3jmq7SPFJt/OJQQHv
         M3hyVpHJCBAhFojQn8O1BwfVQK/i3u4pOoiFyiSb78Xwn7abGaX3vZyBjxLV0FTOAFp8
         BtRnJ3zIaUDbbsDTxjX4nbDcY5OZ8y6e7SQHhQpDSXRcHL9jb0P3SULmwIrTczyfsMzG
         TG3LBHGtDpnI9GwATqLYxP3ez1MjMWBSzhGgCMWkNveaxa7GGOLMwUpoTBGgvmRi83GH
         tC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782284008; x=1782888808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQLimcB24UVWEnsefG7vB3o2aiCLX+pbO4V7JdAkm84=;
        b=T5qh2ABg5e3pN84UBvNA/li+D5Nt02R60RKe2i701fppIwPor6MDWccSPF4r5nGW//
         5RBrRqxyg4oXVlC16Hon5U2oWcdFoy15BP2W1OLau99tUTAyKEJsEyf+YJdPgxWT19R0
         OgLdV47tcCFGepZgJ913/BIb13IlLPhL27enf2aICB0Dn5sy6p0n9aR+nQQswg1IWZNs
         89NvzcAmFQ8mo1uhhJM92F3JyAOwq2XJmj7Hcrf3uw94GBPxPEDJsog97NfSNrKY9o8C
         TmzJTtojCtkcynzsDbvhMAFtGPzbAiKersxjW4tjeedx81T8s7BEVvlo+sGCVk3Varii
         3k0A==
X-Forwarded-Encrypted: i=1; AFNElJ8WfUbrl36IWvi2QQDVhO79AY4WUz9GNRJORKEDmdlP792oXtGSTYObUvyl0kWQZe6V6GzZe7lws20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMhcOFOq13SVysgdojxAfz5mG05fXlt3RGGXE6Su6hJaZX5Cs
	6CEPf8GatOt1KetzpSN+yKZL/80H+mGrHo2RnMegEkXGgXUEnBejHPVP
X-Gm-Gg: AfdE7cnJs/Fmq4YelChl6uM/Lthqw6FgpT8Q199d/jLkFZnpmnHyZiBaQhsuaW6wE7X
	MwaN++c5wfpPwWC1nvMzdiCvBYY6Z5yQM6geZlOGT4DNGFXeIBlCKbcTODYQO51T2e5FUTb17SS
	jhkUPHVHoxcJcV5Utn/DHykERg5fdTor1QpUkhYT/+0Ge3qMp7FENqauQpkgjtUgdB6Zf1/d2EN
	Mcdz5m9K8jG7dR2Xva6SjxrUqDrhGiT+WoudlMyefzJSPkUiS/tlXCfHjaKyjO3XWPqrl1I525i
	cvKTmverLvBGCgYXRpYRVZGXnf4Pf4itEUt2CR8cgHEegKybEpnTdnkcgnTTwMfhziavfK965lU
	ERGIN04hTuWBfprx+wRLgjwLmYf4YaijixM61H6fIoP30+jpmvuy5d+6S0kGshp7qN3BMylg6DI
	6xn6imkMMH+oX4jTsCzHkHuG3oAXaliG92GPsDM1sBsfSQrdLb0120VoGofmZp1yckE/R4RnQ60
	2F7i+fL2PNweprXIu9MD6n2MsNdB7KM7NjAmLGWB3C3IJijwDraVI/+MmEpDtp9z6NhhAvRNGp0
	2rLfI9YowbhAbRNj7/NdnY4xWkESh80MvjhOAE3yfjapdNgLtnSeJ3s=
X-Received: by 2002:a05:600c:4455:b0:492:5bc8:5e77 with SMTP id 5b1f17b1804b1-49260878051mr20659095e9.29.1782284007872;
        Tue, 23 Jun 2026 23:53:27 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249207dabsm634295175e9.0.2026.06.23.23.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 23:53:27 -0700 (PDT)
Date: Wed, 24 Jun 2026 08:53:27 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 jic23@kernel.org, lars@metafoo.de, conor@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] MAINTAINERS: add entry for MAX86150 IIO health
 driver
Message-ID: <20260624085327.00007e3d@gmail.com>
In-Reply-To: <25846cbb-8318-43d1-a57e-16734cdad6bd@kernel.org>
References: <20260623174600.17100-1-shofiqtest@gmail.com>
	<20260623201124.18271-1-shofiqtest@gmail.com>
	<20260623201124.18271-4-shofiqtest@gmail.com>
	<25846cbb-8318-43d1-a57e-16734cdad6bd@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 08:22:48 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 23/06/2026 22:11, Md Shofiqul Islam wrote:
> > Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> 
> 
> You need to slow down, please. One version per 24h.
> 
> And the last one is not even correct anymore...

Additionally, refrain from sending a separate patch for MAINTAINERS,
fold the new addition into your dt-binding patch, and then add the
F: entry for the driver code in the actual driver patch.

-- 
Kind regards

CJD
