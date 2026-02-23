Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96A1BBBE5
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838589; cv=pass; b=qhl5bv3GJSUQQ8bdtZW+JdjNFXyUOxVKtmFinP6Xa92JucEDV5Eat08aRFRoK403PzUyAcNRATfaKYBjmD4GMYLVoO4IFncSj1Gez/z1jK3LBOGtvT67DbayFOJQxMYWtdTZqZal5//59uJY4zFVZcsvjpBA/QQRtMn8XZKDcoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838589; c=relaxed/simple;
	bh=wBzlz3rMPWqPiW2nTwdRbKc+qN04LxATrh5nSMt5/V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXzFirVJNot/BtH03DkC3If9n6c8mPWztwz3uErZmq89K/oO+rRoD9CDsBM5f8KY2sgX8cg0UTCnMjdDZyScrqvQQ10JE53bLQZl4/2OYkkWzyS+FJl/dX+QgjWDsHLAH/9YJ2I0jZN1hbIZbCxIJxVTK158oPiogtq/sokAmKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZYgAgMh; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZYgAgMh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3530e7b3dc2so4287116a91.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 01:23:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771838587; cv=none;
        d=google.com; s=arc-20240605;
        b=eSLYYeQHgL7NGdRvZrJ8E3XlvL7cg09G6tRGJXxrO31YdGdW2htteYkvE4dpIECDAT
         yWMcud4wrXBLiNgWBshJXcow2OXC806vt+pwZGsA5IqL1Md+qc9txGz0sFYmR59rUeJr
         84GAdNBqCDBNGzyw/X8v6s8gainrlRE6LX74X7chwioiKYd07ZMW2hb4xwOQp1H3otuX
         iGbcJlOJxWUVTnbDD9XeYvzWtaTRm2WiGij3sZ5x3WPDLmeQt3hk3phMrbChVkMw7S6h
         LW9WMRCZfw1mUjXIJm9nO6BtGOXpzwigSAEsI15AaZnPUAmpFko2Zdd+de0eGJFYvXON
         GjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wBzlz3rMPWqPiW2nTwdRbKc+qN04LxATrh5nSMt5/V0=;
        fh=xzVD1tP0xrUmde2AD2VuoLPy/90RKtF6uRNuqdt/rZ8=;
        b=etshCwqsl72jou0+uNAoZv5peacYjUc06F6IjlCb9HotAWjLm/Z1SW3Fw7+pOOzvV9
         sAIQmSYIfie7Jz+vnhaNuYVw74M/SoKUzT2WujCTlm0+jd/8njnAKNfznHZiFAcNutJN
         SgVjKro5yWHTd9SYiv2PS/gACZOxsy8HEUdHb5wympALLWgHudFlPy9Gzg0aUZjREilS
         JJi01IsHyhB+23JGSLHfT+eK4B5EHn4ytWRQYnfYVXaxvk2nsfMUtIGjpv0qdQbuTlWj
         rVCviQbQumruENAAqcNxJUKZ1laUZFD4BL3K+j0jKEQSSfUfAKldJ9OLS4Lopv6VrhVA
         s+qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771838587; x=1772443387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wBzlz3rMPWqPiW2nTwdRbKc+qN04LxATrh5nSMt5/V0=;
        b=iZYgAgMhumDUvF0eHn1r0059N1mBcts3SvqDD6Cf9dBVWfpgi1GOJyZ0OZLE19W4Q3
         RxKi0xF+a5V4K7QZrVcmtIZZoj6T6RAOBEq+zsUbr4O9oUG7+KH7NiDv65iqDz9n89CG
         EaAHhIcUkkFkFEp+HB9+LUzqyyCXYXv0JoIi+3tWKq4u2l9N9CyQKr8C/CYL72KtxSkS
         lxpq0knMD3x2z7t/r/O7PBk0l6kiuvK3hFux6FxP3WCrTbs+1JSUP10gBP343L/LHnWV
         qZbJ/0XOzo+rmghG+NZY+EeAHfYfei41FdxNsqgKRl+nxd7LYWz3nhuJJHXknCWOVvU9
         NGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771838587; x=1772443387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBzlz3rMPWqPiW2nTwdRbKc+qN04LxATrh5nSMt5/V0=;
        b=CTxb5q5JuxKl1PE5clbRu9MnaPxNZMsDnmxSay3Qt6s/BRJlVGVHHX7xF4953OnQys
         Xq/MKE+kw9uyEmi5+Fjda7wEuxjxzythYRSUVmn19XFiK64bMF40zg1tSNvDwHjurxiJ
         9VnJFL7BRHb0ZF4T9DmpQMsryKYs8jq167xd9jptPOI6HGbrqFtWuaLqLlrzVQZL6gQF
         bwIhhUCjCV+uMxOUviqy49jWqXQ62CwYQ/4VgWqKaFpitJgYN2vySyA8c+6fkHNRm27X
         4vPlLrD8XJ/6j7XDhzQ1grLkoFJz8L112afrhJ7mvF3mg7HkR1RyR2JYDwzu4Y8LhDDU
         Tasw==
X-Forwarded-Encrypted: i=1; AJvYcCV4jJRePp763AMdkla0ZT5O/a6ZZF7g9hsXIfYicdFxFIWRxXcKXKugL0SmUBDDNYQgi8tCPjlRCYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Wd1UFBawvM7KHXPHx2FCUgKGvmiodd45eStCvMfvcTOsLmng
	pII01KYZ44fAeiHRyL42rruiC0t35776QO9Q5RxOZJG9ohQ6qISDfNxOriDEBHMVJntiBInAXOs
	1jOjcqopu9lfD3IhTxWkoWq8X3+uS7Ic=
X-Gm-Gg: ATEYQzxjP6gNtX47j10UVKUXdzA7AziEAeGWo1Bc2EzgcKBlj0K5UlZPgBu8/sCTtoq
	YKcfcACG6vCXEzF6/ZqevknF0xTlyuCgf10x2GIFGpreq4pFjyr/dNs1cRUZQBXZy0REN9s0Kut
	JGFmDXc+szDTCZq1CwtreFWMzF1L2ZjjgAJBMEV2TA4TIKmuI7yKlKWPmvAfb1YWIrqZSwcwu/0
	01mIC2Tws4Cw3srlKND0vs2GjSrdlc8PNDGWGAjNpQBTgCSkPhS2k8a7Pg4kfWW4o94UPYhkfp6
	gA3VL3Yg
X-Received: by 2002:a17:90b:520e:b0:353:5595:3247 with SMTP id
 98e67ed59e1d1-358ae818557mr6458914a91.12.1771838587498; Mon, 23 Feb 2026
 01:23:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-mcp47feb02-v1-1-41f80bdbbb45@gmail.com> <aZwVXtGOcA9Jfw5v@smile.fi.intel.com>
In-Reply-To: <aZwVXtGOcA9Jfw5v@smile.fi.intel.com>
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 23 Feb 2026 17:22:56 +0800
X-Gm-Features: AaiRm51FWu83n3R3RZkt06ZkSBNWxKCJaD43sm8p_xrxW2i6-edYt7RKhQL4rxg
Message-ID: <CAN4SLj3P6dTLVAB+FjnjUKbs+NqV8iSSbghnXcMYU1RWhmj=4w@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: mcp47feb02: Fix mutex used before initialization
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> There are several patches from you lately. Are you sure the version is correct,
> id est this one is indeed v1? Sorry, I'm a bit lost.
>
Hi Andy,
This is V1.
It seems b4 doesn't include V1 in the subject prefix by default.

Best regards,
Felix
