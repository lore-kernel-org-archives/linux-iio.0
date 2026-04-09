Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490D2C21F7
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741648; cv=pass; b=cPd85mVIxt4ALJ+s9QqEr1BS3SDzWO+vovIpc9mNMDkx42YVcZLv8mLVFG9HsFAQZ2No1RkQrCx18HPOfyLCvdjk+NGLG+djQJ4JBOTBt8QNbG5WL1SMr6y+9TLX2TZ4RpnSXyGdIWBL1AI8oOsZ0Qn9/TedNXrHSP8GdqvxnrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741648; c=relaxed/simple;
	bh=2PeriTX7MX0tbuSVy3tWdm89iPjHYIvNlwIK9zEkOlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVcNBfNS9Ko7mnjFXiFTjoovRMT9I0TCc09x/fMyt3BvU9iPahU08vd3h3RJ66j7z505HCOpo6IsymhO1t72mm2lDgFXJ8kXybEnSA2TQBXklHkK9JdHfAEgB97xx2Vig85NRN8COTseMN95GJWcCN1sG93ofmAhRgOmXZI6IWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbEI8oTO; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbEI8oTO"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d572f7437so658920f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2026 06:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775741646; cv=none;
        d=google.com; s=arc-20240605;
        b=a+nWJGDoKtFqf7SpRafkuy0qaqvHImDsJXSi1PAi1Hgih5depazQ0du1Lemasj0Q8I
         Cv0erNbkmgEC/w3v2yhE4oa40Cyd5EqhX5IlnBthS4cLFrLwqJz+0SKrRAv9YVCbuNOK
         NdWjPOEDi6oXlhxahBwYRYImAT6joKpa2gEGy4EI11M/cYqbPLsXEg5WunJRGAOdVqn4
         Vp1DyzUv2K+bThMWE7QC4gm5BK/2IrL0pK1EmZKd/JBXGjIrzqjgXNkEm1AnW8rUYijS
         m1OZmxkSbITwNavi33vy9DUm2dO7JRnN7AAwoG1cMYFK5J0kjWMM/+BSr3RzXRupPuFd
         j7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eIemmBZ3pLlz8ppJLiiEXVO89W7y0afNwFKQfoclPgE=;
        fh=AKIyU+AhREUAmdeBeLEzXYiX06r6ZJbFXRx0JdeIRug=;
        b=AqPKUTXRZSVZBE1MqKODV4HpayMhOlCYjoT2UpPmwuNKgH/Xy43ScvjG/n0d3vHbOv
         ObFw6XchaqVyz1ItQ6tcsTe12FoksgJ7sBU1GIBjkWpJHMTGTbUa/4LNaN38btlDlZ20
         zEA1cXK+vUb4vQMCcigYiOC7bKXvrwfdW420Wz6L4qutKKneUAIBJ74B6FFvvMTzaHxc
         anzCJTZd53wSG2jbjq3adjdc1Vc7TWMoZrwWEPeWQ6RjT9LqUZoAmkUuaizKb21fVLqE
         ITeYKsmKyNdBsFpL5xkbsEsFnQpZ29ty8n7NmhMGpAymgmClu3Oz6ie/Z725dzPju5HC
         8jtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741646; x=1776346446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eIemmBZ3pLlz8ppJLiiEXVO89W7y0afNwFKQfoclPgE=;
        b=IbEI8oTOKpb9szolvVADJ/KhYOdAOC29u6BgBW13eexRx8IE1+7gcDBJXj+0MWk0fl
         gEN86Xcau1AMRngC8i/5cr08GBVpdm+dzgCLZC+dTCpSdOKy6/mMCLFD3j0qPW9XSItY
         0YPqGLPfhhF58mhyZ0kmpiclDnpD2v4m7iR/dwl7T45cWEGKxW8SXr5uu7UDSc8xx5IC
         gHmB0DoF6gb04jM7ciuAZS03+liGJL4ONk70dtjASRPJXrOFtXC4HAZUxnifgN4RieUn
         VDUFQSzOHcpvjBI3iflBfjkFDGxxL8mS78gOZxsXvayoZZWUyeyoVz77Ei5pPR30rlit
         pyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741646; x=1776346446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIemmBZ3pLlz8ppJLiiEXVO89W7y0afNwFKQfoclPgE=;
        b=Mx57+uQyVgGJ10VYwxHjagMFOVxXbGlKiXHVBhK2jM0fX4xA0TjBqiCbI+rEA2THTy
         NXCvX3T9CYQ2CCsBP/QrCfbDTrJEsGLAFu7ZPDnwT3zTGHFd6DAKNXrKdRzpebOC4E66
         fTgxzzA9UiYhmmpR0/AMzrR4fMZ2FwGgrCurmUmzihCsYNSP4gQ30roT74rybH93Dewb
         EsFng0H1l03lZRgJ7H01nxpsCO/Unt/4AKsm86JxfdbrNHCk/SvgDUE2W6rxGW39opHq
         jH+j3Ql5PeAK8Qj8OD2Ph97TEpREg5ZDHLqYUSPWN2YcuxOFzemaJlsCn6y4EF41PStL
         kWiw==
X-Forwarded-Encrypted: i=1; AJvYcCW5tTKJhqkcaNELa/RP09m0rA3kHqhxb/MPPMJfNxFz1jfGQ9k1Wa/KRvpvRshtU1nGsaxZdfaWewA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZV8P5/jA20RwlgwwZY03N3ftXMBlC4E4cXaZV6T7OrnMQLvJz
	Sl7oeFxs73NJ9dpjWZCXoZn9GpvzlUyIkN3IZcsDCAhWtW5cNbv6VffMObyzyL6l4GdClI7mAE+
	yOblzztzi0MAkhHos/LwSEjBHOwQl3Cc=
X-Gm-Gg: AeBDiesxQKCaMWQagMt5W4wKK4viRbHE7NXZW8QkCjB4iG07mnDleHRLDe+SeWZoQZk
	IQ/G+hJxWe93P2BYdfzjPQWr/SH7oEKcaWFyAfXcaeewGZBk7Dh466ibB7YY0pbbdso/FX+5Tv4
	BX0owQeVoX1K5YRUZ5XDVP0Nf+Tma77bvqoOW1HQywZzS1eAOrAw8WnlQ9PBD9tnNL/kXI/sc1E
	lqjVaQVEXPIn010tLf0g/J/X0SsvlcO61v3iBydTiur2KiztLhoP1JYMnriZvAKPI0xx0/XGDSS
	td4WB3kRJJPwLzjITallbPLKjC6DMrTkx7cF2nKj1RrSVCjImV1yan7JrmDpLzuh2YUBo8tRNKp
	l7DDz3wpRXtjf/tjuffd1vA3cRg==
X-Received: by 2002:a5d:5f91:0:b0:43c:fde7:f4 with SMTP id ffacd0b85a97d-43d5a129b1amr4809509f8f.3.1775741645768;
 Thu, 09 Apr 2026 06:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409131823.1289-1-joshua.crofts1@gmail.com>
In-Reply-To: <20260409131823.1289-1-joshua.crofts1@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 9 Apr 2026 15:34:02 +0200
X-Gm-Features: AQROBzB7z-34upBtwQp9GXXo8paMA0qshk6phPef30jROSYsQ15JY22dxBSxK1s
Message-ID: <CALoEA-zR-4xv4UkHqZmwHodVzNu02xRTJ+RDcfaU_EbnDdQahg@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: ad983x: replace do_div() with div64_ul().
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	Greg KH <gregkh@linuxfoundation.org>, nuno.sa@analog.com
Cc: dlechner@baylibre.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Apr 2026 at 15:18, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> Coccinelle reported the following in both ad983x drivers:
> do_div() does a 64-by-32 division, please consider using
> div64_ul instead.

Apologies, I typoed Greg's and Nuno's emails in the original CC list.

-- 
Kind regards

CJD
