Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7664751DAE9
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909909; cv=pass; b=rLf5XGwiQwcUXlTDPFM2H1WaOrnjwnqWhHEALR80Ljo94cM5thRFgMqywylEKZTABPc1jcMTmhpJRErZkWIDSq84wmt31NLL/YNQuVWiFNxZdghEi3DOPcGDQ4kS5OZchEeLivgsOITWOZxJXZsAfY1wMME7TXfOrKQ6mB+DbAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909909; c=relaxed/simple;
	bh=T0J5BYuAnT3Xdi9Jj3WCm+YKqnN6H2/WrFA4Kd+XVcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMZgp24F8EtOCdTaFnNcGp+EVZK0aSvgxobTsJg6WTrMBq2orM1FpKudKGgtQe9uAdSaDAtS9+V78hS1kx+K7Jz1h8e1vS3uFiDlmURvMiO0nNRM1eU0OhgaC6QSaUzoS/F8fKCs8PLVamD0FxM+0+vGI2E3ry0MQ9LCQ+o45zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bu6oCxjW; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bu6oCxjW"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b21f71613fso2115926b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 09:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791909907; cv=none;
        d=google.com; s=arc-20260327;
        b=LodPJdtZsxR1C2CzMSNxSh/I4NNXN3d30Zq8k4zQGGs/fetgoWybx2EhRU0c3B2fXf
         tTCquKvlKfi7EWlOE1tK4Rb/WYOR77pQf5Z2r846/FrT5i6Jy2/y3FkQJx+kqbrycg8W
         NiTc0UHKuNcoSHBXfGBj1TcRS9j6TPHRscHTxcsusw68AmsNgbQi7mKzzH/wAXVqPXYv
         yG4/DTRDpF7FLJfGPIqvVERF5XeaLZR+QHmXxwh2snsOT9ksiTfrUCSTpnlWD70gOWYw
         MxlvGMhriu1XfXwDVu066F9xjmCr1GBtRzaj1blMs4fl+ouph9YtBRwg4pRl9fRSIB6q
         23RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=T0J5BYuAnT3Xdi9Jj3WCm+YKqnN6H2/WrFA4Kd+XVcw=;
        fh=yO6xp03yfwejx9XuWGTsnRPEVEA+KGvVngbUXbEeLy8=;
        b=klBCRk/5t63ycL/Etk4TW6hTK+gjo1i6Lq2Ey2vnF/GNvMM3pS5pRu6G34it1Fg46j
         RMIAVypbjofl0cBfscsu6s5zZp/62+L8tu7ABGYjnwljEx+gLhi9AL59NLZ2qjybFA6Q
         V10rxTSRtA7jqMINIRTDoizNtpl/LYdCdVbmO+wE3ruEWRlAE1TOCGH64COnVpV8kpDx
         9R21RSi4DHOexkJgMf3A5j3SlnC4GdBNv3urLpF6hAUZ0xAjmsrErKBR7QMiS2/u4iHu
         n2goKYXVu4igGsLhH6P41yHjUn3rHq/7l8U0fpyN/jB7T4lYOfiv217zNuzqILWAxHyu
         x7TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791909907; x=1792514707; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0J5BYuAnT3Xdi9Jj3WCm+YKqnN6H2/WrFA4Kd+XVcw=;
        b=bu6oCxjWhaGntr+VM13rF2COOHxrghPdcW2BylwKxNYEXaQVVYbn9FBBxGhgVsmsgj
         XUfheH0UTD/OFTx+hzPK0grZDg/AosqB0748Za5Z6c7DXdJxE3nQN58/6evJYbzqyfmv
         kYXvOGuQOv0FIKaD6kixsYMQElxwiXdnoqRuIGMdpk/7Z5GH0UXvvO5UvTpfV2f8ZXMy
         y0IvfAfRvef28HHOyN4J3mb1jNRqfPfyXdxb020z4w/2gF3mYgLpN3UAJV5v3m0VatLG
         4hH6hyCVGRhBd+Byflx7lmp6pInZAKAJari5nQ6rdauiBVmxVXNaQQeNoXXwQ0EPKNZj
         ueHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909907; x=1792514707;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T0J5BYuAnT3Xdi9Jj3WCm+YKqnN6H2/WrFA4Kd+XVcw=;
        b=OH1PBRXk33iKP/CHDIzRwLzxL1xpYmxbHGvkLrJK4MNBRXmd7qmHOCdK0RKg6n7UFc
         K2oKaO5pNFLxuPBfGZ0jk/AmMAkvrfA3Kb9RBFB2qZy55KebIAvO6Mi4qas3Jrq3Bgnr
         pGdDt1AAf+qtZj2lK8KOT2HjeRbFEgu6T6xU6qS6mmfTczUUgGuZS/CzfgczvdQKKTTZ
         3WkwOBdp+1JjC2ss3IlZnUAnHy6wH+0P6WNMBj5GOI3tUKOIUQ8XSSE8jifFnMiIxdp0
         0z7HkR/iftzJ4bvZ/I3YaZUxOAedkQelv6g1vxbMPyZAAHkJlRdWxzGkH7w08SzUkGwL
         AbDQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9/m4R/MFcTYTQoc1kinMjKm191dbQo1JoKd0Pf/uCQG4BpskAukxecqn3Z8FCX9TOmVRWqTSL5OQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtmkQgwlgDWnqhwnP32vyOMDstXEHM1psgGLOOqQFBtUxkRFg5
	9rUOtYVi5X99qpnVGuJYZM1GIMVYLGi8Dj8Oc5YWcEuM78iDI0o9XGDnRuMClXRZsjGQFPw2VPc
	PBKepF3bv2ZBh2w/4gocd75jykdfZb8C18jhc
X-Gm-Gg: AYBFou3g8q6WxAPkxDlul7WyNZJ91FpiHqtm7Aq5ywzg2DmYY1+tRL0ae4/fy2yoElT
	cVNdK8zCKH1UJIfuKzKPg+ecZEah19/qbBbwWIPB6UXdmJzG+ZXLJr+Lr5Gjwc5YOklIVGegoDJ
	78tUlv44nLFjDLSgbuZIhI9yXOfoXfhhWWF/mPNx4UESw/+rIoK131GyNafCzymq0L8XHie/lLp
	CSp9SwwNTz3AfFv1TSKdshymMgnpXn2gHXanzs3NOB0HoxMh/Yfe4SwvQ+NoeuDnCpYWDHDrZ5A
	rkKTrq5qIr7u0+331L3U+2tfG/BTe2p89LS6G1Yv9VhBgiXSaWxO8+Cl1gIb2lBLm+nTMHB53Yh
	0+OY/9R3qwc9PydEJk9t8Ou+0K+/I0b9TkJrn1xE1G2Afgg==
X-Received: by 2002:a05:6808:182a:b0:4cb:f21c:a79f with SMTP id
 5614622812f47-50c516defcbmr14456725b6e.39.1791909907159; Tue, 13 Oct 2026
 09:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928142450.103799-1-vidhu.linux@gmail.com>
 <CAHp75VcW3ADQdf68Whmo7yhqu9rdi54YVYgyh5PRLPccH6aUBg@mail.gmail.com>
 <CAFqz8LL0bgOu3TKfxz0Ri=qw09wVHC68CbVS2yZZjv7oKTGwVw@mail.gmail.com> <arrgEPs779q9ck8q@ashevche-desk.local>
In-Reply-To: <arrgEPs779q9ck8q@ashevche-desk.local>
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Tue, 13 Oct 2026 22:14:56 +0530
X-Gm-Features: AclHuK_TBpGn7NoEBdw6LC_e_JC6BfcP9OOGjC18pYWAlajojr0JNuJQwN-0-7M
Message-ID: <CAFqz8LJbyheyXmf9i6v2cqMgVti_jii5OVe0WSkLvi4sSJXmVQ@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: am2315: fix negative temperature decoding
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Siratul Islam <email@sirat.me>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 28, 2026, Vidhu Sarwal wrote:
> Decode the sign bit before storing the temperature value. Positive
> readings are unaffected.

Hey,

A gentle ping on this patch. Please let me know if any further changes
are needed.

Thanks,
Vidhu
