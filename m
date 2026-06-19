Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F8311940
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860798; cv=none; b=FxPkUXwi2rY5bUawE1jSf0ojzDL5lJult5y6kDmFDrkRY3v4b+Fi6Z5aEpfQACF1lwd72ysAanWhygtB1yaO5LFiPRMYw3ue66B+6S+yaxOLtn1e8Tinl2i8VZxjmCBkb5sb1Y9OCV8yHdtnlT40DoIEtixuycRPQMi2yXqWXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860798; c=relaxed/simple;
	bh=ITR0EAJV4oH/5cLUjFuPZRjTNCAbDIVCQcL/xBUnjtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMmyNEr77cIG4AEE+y8uXt3LBGYtQVloYEDJp4xZQ0dMSZKxcxxmnhecllusMKdUPnrVujzowzscr95sfklfij6NZmNzWB69LZndwH3KdkrjjuprPAKxbK3OsJr7hjQk7JtNji5Qyae1JRenBewamnoVveMYl07Y3mlhHzQUeBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEEMN7Fa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEEMN7Fa"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso1343540f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 02:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781860795; x=1782465595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+fYbHkWsaW2PxLYmY+byBPAizGKwZAbaivlyPXKvt1s=;
        b=sEEMN7FatB2HLbvfDCtkiP42Q43Q5jT65moL8M4yTtPlunzB2ToPomZIyPogg0lWtT
         hqJM+KYtNMfwH5Bq7RekCOA2AhYYn58W8XGXm6BM74f9+wjI0fEztqX+sVWKWLfl0U3x
         1yEa2uNLt37v2V1qZWBxo+E/IyQ+e6ToXHyy0Qch0pRUNVfrh4SiK/2y/eIDK/PRzKrL
         IlVz4ar8H1UH1HuI4yt3TEMF/w2TVrRBqpyUH7RgbDCziGMEmkK6SLIP13h+a5xpRMqM
         YaMYvyejRMr30xQ6w9Z4JA1Z7SZJ+B1EqWBKZqTxuvAAGmat54Owc+hRE6n3ytteqKlo
         OwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781860795; x=1782465595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fYbHkWsaW2PxLYmY+byBPAizGKwZAbaivlyPXKvt1s=;
        b=eYmcf8JTcs73T2prAgUzmFVKve/Q5Jczeq8s9SGC5Ht+QNYkSKU334L/4zGQTzCyko
         iyYbfuWCe64FZ7DgUXRXZXDkFa/iLPh1y15RNzl8UAeS3LjUChBym4ijylLy/B75/VHr
         ua5ytqwejhHY0PAxB9S4KZj5mfo4HPidFYm7VbTqwVINQSYSzQ5s8gQwQ3DN1bN7kFe0
         rAfLr6tMsXFTETRxmq/iF68M5/FbeRNeCUTGUSwPngtijIzdxjRfc+sX8FAfemfQs9qW
         jNz4Iq3GdgDec6DF6EXDCnFMC+CqL9GJqzn+oMsimjwYol9dZ2SiK+WFXwx7HiJFJ1su
         MolA==
X-Forwarded-Encrypted: i=1; AFNElJ9vsyNNrXP66gRPBff8Jm7k1Vy/tGfUBoFOZIfYB6iJ/YbtKsHRDS7R7E59VlOQ8pzC4t5Wu9c1DDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjI66z/Xp1v9/WV0WtvbMV4+AWdrlWGEjUoa6oqbssCKNP1RnK
	1aXV1ltu2eznVQIUiDxsamTOUDnkW4EXd95cHeq+0ltdM3MvlnM/kf8T
X-Gm-Gg: AfdE7clU3NqF84Jvz4y/Y/DcE4mtFWFKwKi8b0JxkTMIqUYKL6CT8dr9kfTgAEgMTHW
	a3thKDJQL1HDmfyvrHpkF5L499/2/4KIM+DoqUNBJ3XRkMMTMuDo3lQbcTcRL+ceMp0luFyiUoy
	FQtf2TWQTlMcDZNoaayaJKq2V6WFRzIjTE4Gz1SwH736KNxDfxJbwc1smB1vrDJer4jTr0q9k8o
	HVjZ/A7JUqOQMvcYzquH/RR67Z7y1mtbhQ5H3kCmpck0zfzxGx1pk9sgdvCbEnnQRX+FK6G8Swd
	bosZH2iqWa3WLM7aT1Efehb4ISZ4aoIqMKeVdMn89wlsgGhwGo+4sbcAoNKEv5j3uZtzBYJYYTy
	8eBLqfW8nEl5X8D/8hm43PLG0LK2+DMdsC68Jd+gINxw9jPiWy7E9IeMlxGbTB/entdh1oW80KN
	8gixlS
X-Received: by 2002:a05:6000:46d6:b0:460:3233:66fd with SMTP id ffacd0b85a97d-465097891bamr3238584f8f.40.1781860795025;
        Fri, 19 Jun 2026 02:19:55 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650bc41d01sm6304049f8f.25.2026.06.19.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:19:54 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:20:56 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 06/16] iio: core: create local
 __iio_chan_prefix_emit() for reuse
Message-ID: <ajUJm_Q6Mm3o2NlL@nsa>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-6-79125ffbe430@analog.com>
 <ajQGTQ1_qcOwfzne@nsa>
 <x3aijvc4buo7aqbchikuoyyrgiq3afidtkla37h2rg4tvfdbc3@h42qp3estg2s>
 <ajQ1bZSNHQ96pyJx@ashevche-desk.local>
 <dlisetsssjoyodmv5ubl4rzhxtla3g46mrrzv2f65nqecel5fu@dqiqsayr4aip>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dlisetsssjoyodmv5ubl4rzhxtla3g46mrrzv2f65nqecel5fu@dqiqsayr4aip>

On Fri, Jun 19, 2026 at 08:43:24AM +0100, Rodrigo Alencar wrote:
> On 18/06/26 21:14, Andy Shevchenko wrote:
> > On Thu, Jun 18, 2026 at 05:14:19PM +0100, Rodrigo Alencar wrote:
> > > On 18/06/26 16:06, Nuno Sá wrote:
> > > > On Thu, Jun 18, 2026 at 02:27:22PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > 
> > ...
> > 
> > > > > +	dev_attr->attr.name = kasprintf(GFP_KERNEL, "%s%s", prefix, postfix);
> > > > > +	if (!dev_attr->attr.name)
> > > > >  		return -ENOMEM;
> > > > 
> > > > I don't oppose the change. Looks like a nice cleanup.
> > 
> > May I oppose it? I found use scnprintf() is harder to follow in comparison to
> > nice kasprintf() that takes care for the dynamically allocated buffer.
> 
> In the next patch the function is reused in a sysfs attribute read handler,
> a context wich would not be nice to have dynamic allocation. vscnprintf() is
> the main building block of sysfs_emit() which limits the buffer length to
> a page size, so I used scnprintf() trying not to deviate much from that. 
> 
> kasprintf() it is still used in the caller, where the logic was a bit confusing
> as it tried to avoid multiple allocations.
>  
> > Also there is a chance to get a name silently cut due to insufficient space.
> > Besides that this function can't be used (again due to 'c') in kasprintf()-like
> > wrapper. I do not consider this as a good approach. Have you looked at seq_buf
> > instead?
> 
> NAME_MAX is not the maximum length a filename can have? I suppose there should be
> enough space for the channel-prefix. Indeed, seq_buf can be used and it cleans up
> things a bit as it tracks the the position in the buffer.
> 
> > 
> > > > But bear in mind this very sensible as any subtle mistake means ABI breakage.
> > 
> > Which immediately raises a question of test coverage. Do we have one? If not,
> > this code must be accompanied with one.
> 
> Agreed. Will see to have tests for v7.

libiio now has an emulator backend. Maybe something that can be used to
test this. But ideally we can have some kunit for validation.

- Nuno Sá

> 
> > > Yes! I tried to be careful... this is dangerous stuff!
> 
> -- 
> Kind regards,
> 
> Rodrigo Alencar
