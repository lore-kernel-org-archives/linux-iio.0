Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F23FB067
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535922; cv=pass; b=t15Zio80nkdmH5K33/BXinlm2d65QrCp7F52yBT63jAGGmaR8/b/RK84loEMLaBh8EDpvsoeMbZhmRjrSicUruukBHoxnCeexCD86TOiUhXfMgEN1V3OAK/ySnALE+1eoJid4aAeq6M7NkZhOIED0dODfWSz3EAWaQCQ+EcX/x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535922; c=relaxed/simple;
	bh=20S3Jd/kwYLw9AS6ULBpkjItx0joGmcX/Z0fXXLVX/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGtVyD8P9ycG7jlSALweQrhmhdAQ6nUe1iX1w4X+OGFdsrKvcUMivjZWkJbLBcDCEXwcFzOc1sphgQV5edl4vCcdquL0/pvwdbPzPp1KsoGywUwCtB2KOGBtnJ27TxqGHqW+uXS/wesPMHqHSxPX92UGcivOd7M2+ZcqrOQjR4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCY+7X/a; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCY+7X/a"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ba840146so4311815e9.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 00:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777535919; cv=none;
        d=google.com; s=arc-20240605;
        b=iEciRrdwzFrPxG6puu09HPX+Y1soBiJb5v7dHduZQoOzG6WxgUMCzevPY0nG5D6qFg
         b49mvQD4LWelOcv+0aZknTUWUfbq++D/K8foyaR5OgWcJwQ6QPKLzKFJulh0ME1+Z8bX
         IMJRQYvmwhr8+NjXDGyKX1HLbD8xOdJVcah74OmJb80XaA7l59thsfXm8L7PUC1gi5v5
         4Z6fAvhMW6vmLBumOmmzH7cs6WfMb5nLjvrkZIy3iMznJvw2f87lL2tBN/D9AHB9Z+V7
         o5H6uv8jMAXBYJf+jNAWlt727WHlXoWi0enqttr6vosjEDYdL4ppQDnpU5p2MMhSZ7cF
         2CSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y+EkSWdM0Fd2f03JHwtJHEXI396MdcEfemDkQeu9+pU=;
        fh=X+ngDvKL2nfFVP1JwbEC/cXdB5ar0SKdSMk7z+85qiM=;
        b=dhKaoJmPF+bFTJwiYnxs1w/sgDjRFeoIs3GRE/4nFP+7a7M6H6sdBWVorqgmhoCxq6
         7SZ8ihhTCaVd+mVkf8LRy5rJaerrdxkicZonJQZKicGEP4C5kRwBF942+TIf6bkmINvv
         nst3VjqxYnMwmzQxnhtWwYEM9lB4s3dwiLATAm2Ur9jf9DhLx4ns3Re32P1jdxk+0Ui6
         JMXSUe6sJ5TdkAr2h/2YUu9/JCfu7o2j9ovpSKGRliVLXwlcld0rZ9t75Rp/nbQ0FBNF
         xd6vugu7pOQjt49JX3INGDvfF7bC2Ye7W103jfJsQbOKAhcbdysogv2Vyl4zoVEeL0Wo
         nMAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777535919; x=1778140719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y+EkSWdM0Fd2f03JHwtJHEXI396MdcEfemDkQeu9+pU=;
        b=ZCY+7X/a7CxJreSQeV9nVfGBiYtd8SCGjyKZZo6RfMtSF0jW5qL3OZlwSfJbhEb1/n
         2+z6k5v+6sVHPK/dpV5Lhk2UH+RL0Ce2DuGwVwdcBDLd3Kx7rP3NBhrt3QpXj/3y7qXn
         ENBgvFP0ndvyWHUrEl9uZgg3Nf0kMywPN/jyqQWnU/naDeQcP1RgSlSHZhe45E56LvvX
         s/Ebr0uHOjto+CjI+tLN9NjvZZ8xaeA77933FOXVW6S24wUJhZqMbh8yNvwekLCQl59/
         SgZu7A2nQzTSdZjEaj8o6ULvl9dQ0q3ZO4ay4KVlnN8YvIzp6g3YBFAOCGA3zhsHxP2t
         DLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777535919; x=1778140719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+EkSWdM0Fd2f03JHwtJHEXI396MdcEfemDkQeu9+pU=;
        b=SU0gbn/EU/hAyjGFZxmzfiZtrGa4sXXhIarna8/+kHOS0B5NeiokWuUY2jNQOoSNjQ
         jeQ5HQr++5jeBK/lCBb6xTKYkwxLRXHiV6hWQtYl9zHOA8caaGL5K1XFZ40Q1Cg7AcfG
         mHoO3Ik8Ef/xFrQzrV4Ei+JC83Po2QL6AB3/oiTfVyK8ROxvIqV+r8oP/ojgwA50ljlo
         ObLYkoBY4JWBPI2ocYM1ZChjNpaQx/dkqCzeC+SEd1Z7m6BUEFF2E3f9JFATzNxeYT9X
         RU/tLZjQhvUPh6dnjw9nxCsJslM6ehjwpwkATktZVHBFtoznBAhjs+D6BzSboVpRpMs0
         R/1A==
X-Forwarded-Encrypted: i=1; AFNElJ9Dc5K5AHZUCm3CYaCjkBTLl+y/8q+/Rv9vSxpLTnrsl8n5RV7/eFCIQdvcUr+wTocp3w3LJi0PuvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzperEWyoVdS/tMvc8hSJBCfQvSIAL0UcNwXPM+yarXKq6/Wuiz
	w+JwAOJWPLRHURSlx51OSUL6mEb16wSyQnNXUwT570ttndBzXFXzwPkTbqpGjKKfhAD6ItOHoVy
	ViPg0jIvjOEOyI5Gc2Pshlm8rapdJDvk=
X-Gm-Gg: AeBDiesYZ12cCgG21RdnW69UyUhH6ZOsq1DqKI8Q2HZHct2cAxKhfM1RCVfkr5jQX7w
	LZpntvviVD+x+7O2bLlBnDB+xllTklSuIQ3zkj4+tS7Gt/ll6W1txGrysqaUmEISq7VQcKA1MEP
	BamUJPrWXgMxVZRXZNEg6i7X/3pgVI6FCo/Tl/oVIGgWKQtbbteQ0VSSnNWhLSRxvR+IO7rTTRB
	mvvQNN7O6dmzqmx2A6TIzN8C+AVVlB2y/KAGleevEBrOHubBr5+FuuzagXjWFBm6aJr9h2DDqBw
	LRgyDmfbsHlsZulNny8zkGGyuqHU/Cp+jKZRxroTn/7cRo15uJPkMyi4tF4dXrpL0JYHQ1ZE0LB
	ttAp4smYBG3vpAnzHLFEHEQI5cCUKfjq9FQFeApwBSw12y8/KjRrtiscrExX/5q2TtIHkDPXkW6
	4Vcuvbxk9tWsTVZVC8
X-Received: by 2002:a05:600c:3508:b0:485:ae14:8191 with SMTP id
 5b1f17b1804b1-48a83d6e22fmr26651815e9.5.1777535919370; Thu, 30 Apr 2026
 00:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com> <afJb5P5njuUkUPwS@ashevche-desk.local>
In-Reply-To: <afJb5P5njuUkUPwS@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 30 Apr 2026 09:58:27 +0200
X-Gm-Features: AVHnY4JirmY_b-_UFGQ8Moidfh1cpR5Zws_hUKDNpH-BSq3VX2rP2MbLUcPqSuQ
Message-ID: <CALoEA-yiJyF9FtX-uNkF6CyOKxauWpPtFXFyYeUOFtOAtt2L=A@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] iio: light: si1133: driver cleanup
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 21:28, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 29, 2026 at 05:04:48PM +0200, Joshua Crofts via B4 Relay wrote:
> > This series deals with the cleanup and modernization of the Silicon
> > Labs SI1133 UV/Ambient light sensor.
> >
> > What seemed like a simple checkpatch cleanup turned out to be more
> > complex, therefore I've ended up doing a patch series instead.
>
> In general LGTM, but there are several nit-picks that needs to be addressed,
> I hope the v4 will be final.

Not really nit-picks, the majority of your comments stem from me ordering
my patches incorrectly, it would shorten review time.

-- 
Kind regards

CJD
