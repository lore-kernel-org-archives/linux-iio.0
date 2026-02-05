Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DE36E483
	for <linux-iio@vger.kernel.org>; Thu,  5 Feb 2026 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291166; cv=pass; b=Ka794F645YxI3Inaez1dzIiX36jQJKz0tz3FZSCJOhVpklL0owUj8WLGSnehkOjfsVt4zEcXVomu9/XWAB0wHIy054qHy5ZKe039lSx64Cy25eAKBO8AW7uhPWy+KSl8+dJ65qSagLrooVWRS2XYeYw3xGuNjFStdZS3nyOfxSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291166; c=relaxed/simple;
	bh=HUFONjuQLtbcVub/kPg3eEuVXzFRYkS/YmMcr8CvBmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cnl2HK+cSCr7M7nmwnKKWcDPhdkoQXaNJbjbKeAs2zMhQeAEyW63wr3VxILauzPzBiMIzqhcNeF4qD8BzEY34KgSyh9deVgytVMCA6VWQmbuCfknSaipHTwyY2beUIEsZazWRRWBFSbVBD6mBnlUJn2W03BzceWjOd27L5G5FSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1R8NPXJ; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1R8NPXJ"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b884d5c787bso147025266b.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2026 03:32:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770291165; cv=none;
        d=google.com; s=arc-20240605;
        b=Pj90ZlwvnFvR/G8TUvIe3X57geU3GMi4JDb2lbFSf1W3424uPIBPu9ok3eJKHdKcer
         ZYkxFGWsfEIyYTWfbdE8jBTZc4Kj2KLtWAmOlyaQphE9KHcGuNea69AsqLRvqZdugecO
         /ZS+6ofEs0iO/ZTrL3Otyf3mARGaWUj/4MijZ2u/oDUCeS4b/BSDCYd48kSlWn60ndV5
         4wERExe0UIQU4X2t661LtO4ldyT56AW3RzckYXBjqWV8eEXbhpn2ytCL3X0v0Q3+03Ef
         lOOrJSRMJpZu+Fz2xstWoy1twUp9KUFYgfTv1SIUaox8rq9CmFYDRyflLkjLc+2t2yll
         AL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HUFONjuQLtbcVub/kPg3eEuVXzFRYkS/YmMcr8CvBmw=;
        fh=XR6V+cJxnq6Je9vxkbcN/+uF05d0XJrRRmypvH7Fo6I=;
        b=IoCVXJ87EuKqaTXlUtDniwzp7XCzLlXGNp5uZ+KZmDGNnH/AO10BIswleg6ql8XWO2
         3sDq3+9zCyeQocEVh6V+oJYPNXIRdq5g0opkU/V2E4qxhIK4tfqsBdFsRv+MckqKJHF/
         xWeFPqpp9OSIMauSMYcW4iBHfgyesABXcp9JmJV8YOYscqqLPEbtM0detpc9DA9Ns7UR
         9L/08PQmakP2qk6jsYiSpds+QZQOT+mig2y8STQNJBdyCsBGNintTBNnO2/wcc3LZ7xQ
         MzS+du8RnGPeKMtBBOeuD+fVhSaUrOu69G7s0Yg2nPf4srKsWODCYtu473ENvIdmh8mg
         Y4Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770291165; x=1770895965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUFONjuQLtbcVub/kPg3eEuVXzFRYkS/YmMcr8CvBmw=;
        b=g1R8NPXJmqlbh0s6QNCVaexLZnsZreCXZAPFsB6BNxojxrfe9fBHAfchjFwIEzvGZt
         nYc0z4aAa29qE9fbGN+GaP+WSuo6Dn+xsSNbofoOYLGPzIpbTscCPZVvYWcwelVnYBdE
         ERlf9SUv3+M0tr49ppwJ5X73VjQEuCCFQxjLhHMbWCwYJJT/3nWEy7G5bR7836ORTDWW
         umizugVxCg4JrUAm1p5BsmymiuGj2VOvaKB/4Ds2xD5ByjANV7/GjTFIRGFi8fIUrTsL
         EoKLdYMlqGj1YwBC0BmAdL3TmFce5YBp2DIZyysu5JOpD0m378Ndbd1Tb4ieugCyoyC/
         5Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770291165; x=1770895965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUFONjuQLtbcVub/kPg3eEuVXzFRYkS/YmMcr8CvBmw=;
        b=u8gWBbV8H6zG/zIIi+SKiiHGC7lonWRR8qKmSZNanlnHqruz/vt/Nqx2HV443I55F7
         dxO1smh4wH7FXGuY25w+j7ov8O62VQwP8Yq4zsIX7XjQZjV4VGxR2g2IT7IeKpYGE9CH
         2d4rJYZwoe2jgOiSmXCppMDYokNOCBvEQDKDV9ohC2P0y+nefOxOVadA/6HRXmZFrywi
         jcpmm12nX0pWCyOKWU1I5mwziMUiUqUpFX5/EG0oY1Z/sFl+BUArvOmDy/8lLpNE4YyS
         t1/j1QjIHWFqFZo+xMzdF+8UV+dMFBqFI1Z7ysu91j7Az9yOpG2UdYHbqotBUKKzh333
         aN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDytU+WNgK3EbmKxItH0f9IQM7gcmK3uJUO9aRF8ciIG+lecpyyPbKR66ZqEqoLdQfwLmXcX3EMys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlCgYkUomdEZhmu8UUEILpnakBWypDU33wxeJKkuusGokXoHgb
	BylgTRDQUGtx3seOgb4AYRVFo1qCRbGuY6Ru4400ETjR8podKvX1eIHG/u0qDHj6+iuz4LuCdiO
	BJMufXf5+X/Hv8HZHL33dueoCAZz3mkU=
X-Gm-Gg: AZuq6aIrovGcvEyjh2qypQJlDWSAeYTIVL2jzoUPoeZmOyQZ8EmpAVj6oVqJrgWiQ1B
	NZq/EX69b4E6kc/FHJ/56bJ5N0EueQ6KCzclNnr1Kl5GPrKO/nliLA7OUGYwRp5617Mc/2A4xUO
	el3QOis9Nmpf6BtoS6JyWOb9+Kf//4bPsFiMdyt0cpQOcveMC1wnNwjjSXRhJXJ74GHt6/HZFDD
	luOS50jwGKgNBcO4AaLLFYU0SJE29jTEAifeVgyJKwfxDkrkSFg57iX6GazotbISYPv4zWgXb9L
	dlci8J6mVxfwO7yRjaRevnfWZIJrehWJoAvTd09mqkTyCdVVCJufWla4Ef0ZIfNCBDkmvXM=
X-Received: by 2002:a17:907:84b:b0:b88:448c:be01 with SMTP id
 a640c23a62f3a-b8e9f0a8c35mr390932366b.18.1770291164318; Thu, 05 Feb 2026
 03:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-inv-icm45600-fix-int1-drive-bit-v1-1-72a78cd07150@tdk.com>
In-Reply-To: <20260205-inv-icm45600-fix-int1-drive-bit-v1-1-72a78cd07150@tdk.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Feb 2026 13:32:08 +0200
X-Gm-Features: AZwV_QiXOqOOjplTg2gMyP4sKVgxsZvWFdsBXBYnOUNPtfQwvHW7PXHB16Yg_2M
Message-ID: <CAHp75VdmVP45+3r6HoC-Gf7FfXMJdmfTV739LLDAtdX_f_xu7Q@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_icm45600: fix INT1 drive bit inverted
To: jean-baptiste.maneyrol@tdk.com
Cc: Remi Buisson <remi.buisson@tdk.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 11:55=E2=80=AFAM Jean-Baptiste Maneyrol via B4 Relay
<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:
>
> Drive bit must be set for open-drain mode and be cleared for push-pull
> mode.

Any pointers to the datasheet? (to the particular section / table that
explains this bit)

...

Assuming it's correct, with added reference to the datasheet
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
