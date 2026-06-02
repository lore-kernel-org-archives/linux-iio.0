Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84E223DC6
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408983; cv=pass; b=dzt1FjaREJa6x33gai9yjasYBexOE2tJA8TDaq/BCjj3i50MKewr0PKBLMevtgduXTbj7+4hFifXEg2VHSGG4BjylsjUTIUpqHauUfaEnIDMw2x2F6EK1IhVZ1V5u/aaiqT0fUqq9eXrRAAT2TAT+1YFbC1gPI6IQqoH8bpafII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408983; c=relaxed/simple;
	bh=dGTdD7u2Au4u19815dsTr0/geTahdkxaoqqG4eIz5VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G41SOILo+uSS9EGsFGbaMIOEYglPzDxBeircRIBBvK3ixViyPh1MAPfQLfDvN1suxh85iFNKmx4dWdT90Fbla3JpRojlwJWEbRFzh4hM0PYtWjN1Xh39rx+MauVvuuCRmJAJAqryyYta0hVkMNGZD52KwaforbZraFovYFx6PCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWrv3iw8; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWrv3iw8"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-460166910e6so1009810f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 07:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780408980; cv=none;
        d=google.com; s=arc-20240605;
        b=VFm/dy0J06jAc7hhi4VhPkcN1GXskkKmVZ9m5I+2MnVr4GFftu4sR5foNGhVI9tZd/
         2zXtn/vYTiRSoOZREEvG4tjaXhSnU6krJftMBizOrD/7tEac/i6X1UErug78zh0b3a4Y
         UitGmWHAG7Da0It1FFNf+lEWZc0SEtiUcisrh410jLwMO3pcH6MzFcs4POm5dTh2D9VG
         jNL3sGetv1Ub9DxVy1b9Y9BQudZGZrdDxwcRnRNKkpWM0rgCp2CEtL64yS3Mwuj7sXKh
         KgLt06AnPpv6BBmZxVWi5R/bvC9U5pRfIP3bHPQ3FQywLQzwjaYw8J0KcW7VYIdKXjDp
         C8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9drhNiEJ1JcL4xmdPUusc+jhKOJLQn6wCyzznnyEgUU=;
        fh=RdR0cpZaKYNdCXv5AQBqj+Xfg/hGCqEd5I9baRgMKfU=;
        b=D19aqEyTm/1lBEO3gA+O9CymuXr+JStQmGhatlOE6CP8exC7PARUdHyKpdVkk+vDn+
         t7xwZXbu7Fj278b49SBn3kal0Dj5WtdMjkNZVNUDlsJrsTvxK6W6OXj+CZ3SdGvQY82G
         3q70Bcs4hr2hGDEOZzEij+HIdsnwA57+N4WtvnGTnpbB81DDNn5YBLN+LoH2CFQWhu46
         rkBmBhxXDqJ/roYHDI4xmTeQ8Hau2WtCguN+RcVQoCsEQ+9uJc9CLUDnbdGE7/GX43j8
         W3yJlMvUdCqabiI7DFmg7IWz9NL8ZxG0rRAqyavXOWOOoGVluviPkF+LP/RuUX+XUVak
         c6mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780408980; x=1781013780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9drhNiEJ1JcL4xmdPUusc+jhKOJLQn6wCyzznnyEgUU=;
        b=UWrv3iw8uc8R/6KyoMoYUH3PGAgo6LWGNXq5On9ihtPhNPaiX+DxI4fBgAXiWsCTQB
         K9/BVPenTDJk5dChZPpik8q1SFXB87kYUd7RAI82n6J7b62GweBFEWdo4G1dpT0h5qmo
         yMqHj2pC/dvVMuUdETS8+YkNB2O5Eojw6gLWhMPD3JOVVQz1V1y2jsYwXNROWO+bQ/5q
         Hhw+V6HXZogVvy9YT30OkLMNP5+/Xxyt5kDMEUrWsqaoEUNaAtYCx8kAtQdNbytCU+uW
         +H+I5exUKbSnZz9Zogn3fl5J2yP9YSlyiEwjxy9FZIcbDuFuNm9EO+0Po6mUV/AqV0mP
         zVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780408980; x=1781013780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9drhNiEJ1JcL4xmdPUusc+jhKOJLQn6wCyzznnyEgUU=;
        b=sBTsdtRBhpCx7wBX2Wksg+nQiQADFhpf3LwaBqo/N3P+hk6K7CTYziqD/aiURMo2qb
         VZyy09BfGn39l/S0LPxUwp0HctzBIeOAmiONh8MwJebdz2uY1u6BTlu3DIUKlPN1INAe
         mLKE5nVyI9Awl4eEDflg6NbYOB8JRggcEvCZi2qPHbuXa1rcwlElB/L9Wp1B7SfhXOmx
         ciZbUrnpBBTuMim4jJZcAlJq+jYlCuymUbjNLKWh1wh/x2ib6qkqndGf1yF+pgo6tQkU
         xOIU8PzwcepnHIulrFZ/NNhEyQJjNOc0dUh5D4ENLlTDFhsLS0qvtDk7kBfA5PSN58M9
         y5cA==
X-Forwarded-Encrypted: i=1; AFNElJ8jLTOC0bhzUelESlD/w2kkkSIBVF2EuCDQNb5qXJ7Gk+lyo3uYRBQWXFy6T2l5TqrV3SSSMhAb2LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWUvgDacYfK97y2k2j9oHLGIwK/NyKmarv3E07XXOKQI2k147w
	KzCC8v0zUOJ3qJRocUwW1DN6/MOUatKY3z82HAIoQmWnQRGopLUw21A3VO1ueKxUmlqY/jQc6Ls
	20bujTZarZXr40B4P/OAAG1101N3S4WXsnBxG
X-Gm-Gg: Acq92OEcawNgdFB75+fAzxNnYER3pb1jv9uhLmykVocgYizrx6XJGM3o/5ckQhCiZXV
	A2RhSeFMcpbxb6UyyAaNSMzConz6coXYnnboZaBUUdzvLVti85W3XoVyc8ovtmtYVaAP07agvbn
	CLzbrIt3QzsBCIBL2MKGQVNSsSHihDeolXFe9RJnOk+F4xU4UQyx1MWPvmR17j/Tb0+qfvEH6uX
	AFA1GmFffGaXRAtdMgUcUswPe550SoR06OZvjJsnD0qTcN+jkr1YWrWeg6XLdujFEH4Kghz6lUJ
	c4db9VF6YT33/IFG9GXy/gq1rTQcfpnVfi9QnRwrUEa17X9xJBWnkCVMk7x4sYnj8sC+yGQ78F5
	00gATwDuaMifYi3IjcaW9yMaIjC44d6LY4xXZjzpR6IzUMFzABYEpsF0rntT88SVHmpIls/fZoU
	/z9gQ9OVHUJuXFaq1j
X-Received: by 2002:a05:600c:c3cc:20b0:490:3ff5:737f with SMTP id
 5b1f17b1804b1-490a292fd05mr210014425e9.18.1780408980066; Tue, 02 Jun 2026
 07:03:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602084019.2564-1-antoniu.miclaus@analog.com>
 <CALoEA-yz-kJGHXDC=Fwmi1C9P_EpEcimxt=9a94vv6eAHQ-TXg@mail.gmail.com> <20260602134417.5fd78512@jic23-huawei>
In-Reply-To: <20260602134417.5fd78512@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 2 Jun 2026 16:02:48 +0200
X-Gm-Features: AVHnY4LT6q7sSEnE86-bkfRyw2gFytHPMye9hF6QX-tbcOujQNCida0cOOI_xe8
Message-ID: <CALoEA-wZhXnLrAcW+k81p8ifFp=WpF7DVA+35H9oLDhGKR6cdA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad4080: fix AD4880 chip ID
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	linux-iio@vger.kernel.org, linux@analog.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 14:44, Jonathan Cameron <jic23@kernel.org> wrote:
> Applied but I dropped the fixes tag because it causes pain for me to have
> references within my tree near merge windows and it will all be in the same
> pull request anyway.  Note it had changed because I had to do some surgery
> on the tree a few days ago.

Hey Jonathan,

Just letting you know that your Signed-off-by tag is missing in the commit
in the togreg branch.

-- 
Kind regards

CJD
