Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EB2365A12
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497663; cv=pass; b=GJxt5ybmXThHS32OPcNcamB1mpER9c3J23E6y3g0GDQySd6nS0Oxax76hBKjHR1UO/NJ7undSWLVGP+VlD3T8dqGkngHqAIjIgGNBs65/xyJdduobOjjXg55teIEs/jb76sLCJ30TC0YybwqhuQdX7LokbJW51NLx1LmQ6GTTXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497663; c=relaxed/simple;
	bh=D4b47IvjhdmzPJ+C9cqyIKEFu+PO7XNc2scPXAKS1Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skD3Jz+2NSx0xxy5gQmgRO5vCbfIs/6g5O6+sOYpv8e4tytfrZGy6XGLopmYIVn/n1BFkghpO/jRlnB9pnyS99de2V55+LJrbUl5ClncbYHtUje5XV6oBKczHNu+Ydg94imJDftcLppIQDNZjz0H8VTpxCO8ZB+kYGyRHCFMrJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpilN30B; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpilN30B"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so3807786f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 04:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778497661; cv=none;
        d=google.com; s=arc-20240605;
        b=BM/gccb18POxZOJArZ8zPPOEyuMmtPyzGjos6T+WryYvr0zSslDVD1e4GcOMqnQGWF
         W+CVh2+Zs3+fV8sDYSZLPgbVhbokgurUQkFn+SiJw50P+6DQxf8v4pAyAZ/BWA8ThqlP
         NNE9ehNx/szlf2SFXCkUoMeyBlh1/UkUv0Fd5dVaqA4rLrIv8bKE/0Duk+IDECjO/EZf
         PJwbkngacE3kiZItlCnRl2FeyGJF4ZYcEHtwU0sb9blyaA+jlITAv6thMCcl3F+Ir98o
         zymbKHokxQYSrFloT77ApjgCmUy2zsJrmVgsOP9a+N3TOC2sgorjaGKW/Ay6z7Zh0a88
         XevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fobcC5woVvT46AnELWY/ShYzlGj35C0N32agKX2y918=;
        fh=T25Mxvvts2HGOpd/F/WCZO1lGH/u5pTd72ppDYbKNe4=;
        b=KUrM34YlIPf72HJ/a8qeS8s4G2Dv5IuYLGLC36mylRa5+CiNW1V3q0CcoqMHE33Yic
         asiXDUyeeBbXO8K1M+qhpki26sYH4CPOvVVrV9+NeZa/00dI1g9IZ57vBNBHIfr56/IQ
         w9E9St9MqS+HNEXxkm31HTxoS0krjzddS+pzlRGc1o+A1OsO69G1HEThEm7QnrZlWb+N
         0mq12Pz+QPcEkbobDDNzZe8y2tfxOuL/t7jScwcFQiA2whWJp2FtthLcWe5xdgqUeQgD
         6l9vDW2bMOrQU5UgGBZ0kzolAsDu+2Aq0PlGwrtWS6ibrcYQ2j/GFtjh3B6g7P2TOJAp
         XqOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778497661; x=1779102461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fobcC5woVvT46AnELWY/ShYzlGj35C0N32agKX2y918=;
        b=mpilN30BUyDPDj4+ja+AJHASCk3nGNPpl6f0LgYw3cYMaTLkZwL4Iq1VdsiXHS4R+p
         Gw7NuOUbAW8ZIhiW0oLx2vHmo8ttL3QtHQA9AJMFkRkWsDeTWZHCfkVSUc4Rw9qQmhIL
         9BWza4cGz0UpL4Gzgp82wDd8H8/AKB9u4oIfz6/H5SVmjsYIpwYexwaGH1gWu2BaoxCF
         BOjPl+Utr6EGqLRtRHLzTO9dONjmQKk8tmpgfqqgINmslCngmxA+PV7b6MYHKwgzKYPB
         B61g4ojG2e+Ooe8beidNYlaYJUDDXWPAj/RcoRjrCTeM7W8gTbJjAOkZbeHnIA4DiA8V
         Vvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778497661; x=1779102461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fobcC5woVvT46AnELWY/ShYzlGj35C0N32agKX2y918=;
        b=BXnfrXk7lluCxp+rsNEjROfipoYjg1RI+HCaL2Niv9xsV9LMx+C7z6LACsF+vaIgo6
         l3BqnHoSCw22IroiTHCfVMgvQn/AGraw1vBOseZgyHMzvI4ckJRJFAyDfXiok9N7z98F
         Lwyvryxc70XH5bP+r3chc++nhYQRa2umP2w/fkvAe98WjQYnO0hXloq+sfYvMdtNT1Vt
         rXQrUa2chdd1puL9EwJahYPnp2iKu7Sif2+US+VwtbbzktKDOcyWwSJJQixgKbcHE5Ot
         keKBSnjXLGTAwzS51T7+vMd32Z9lXTSOxxwzLTM8nZLRJsA7Oy/AjbasoSqi9xLSh2Jt
         6TmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wNI0zUj9nkqkfOJRqaJOk3Qq9tOjgnbTbCUZIMwB+e2jwV4bLiTeZkFqeq5zpaJvSFQX0YD0wS+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQcfi443B24Ec4yTFgyW1td/QsGZ7df5hBamY8snD7Tp9cqca
	PxOGdKFt9wK+0Mj9X4ZXE5y1WFOdnmc6WwM8DVOlwAD5RtM431ySBSed3/xJ/HozY1r10L4YbgT
	E1gS4Yhaka+31kdPOCNWMd2JBLwYfUrC75Q==
X-Gm-Gg: Acq92OFap2DytZtnUwaI3Y1J5/8zM3KvkvIZrWw4/aJ3JNoOYrCU2YYngLqYLXEFSqI
	b93o+x7lqBOuoP7w+A2vsaQlvIRdH4NUxXxbvVn4SVVitTwGEn5XaVdgmdXt/J2zpv0mvFvje9q
	7cp6yzV6UEtn4qXj+KDH0RRrfS3AuM2DDaGZ+cM6nIICh5HcSbph5fQSvvTfQCpGyLehXg4xggL
	MTIhhnb/QPrQhj9AFioZ53hnyuL5vG6GYHzJBCUrRHiBO2wgqTMznFsdx6tK1PvAYS1EOi6s6pl
	WPO+GmPTNx7+3RiJt7JXFpPHSrNe6Bo5Jao8STmDmLWmRJDcziz+kOB6Br/M9+92zvqwL8bdeJt
	NmBhLxgpMJVN1oxb8BNrAHblpiTDHOVIuzFMxEkXE0jK+24iSH4Fg2bIczbrAMU3z6BY4L9kltf
	qxxVmcwg==
X-Received: by 2002:a05:6000:1847:b0:44f:da08:18f2 with SMTP id
 ffacd0b85a97d-45696ea7b7emr13448895f8f.12.1778497660487; Mon, 11 May 2026
 04:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
 <20260511-opt3001-cleanup-v1-2-f7879dc3455c@gmail.com> <agG3EdSotUAyHeI9@ashevche-desk.local>
In-Reply-To: <agG3EdSotUAyHeI9@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 11 May 2026 13:07:29 +0200
X-Gm-Features: AVHnY4Jjm97iRqZ6C48Vm-AZ5Qnghbj8cPa3fomn4ZkkmTf8QXi5h0zubYmBew0
Message-ID: <CALoEA-xNyS0Osnk2sEcdos0HHjOzKmeTZ82ivqYiz4J4RHA5ew@mail.gmail.com>
Subject: Re: [PATCH 2/7] iio: light: opt3001: use macros from bits.h header
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 13:01, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 11, 2026 at 12:04:07PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Use GENMASK() and BIT() macros from bits.h header where it makes
> > sense. While at it, remove unused macro.
>
> ...
>
> >  #define OPT3001_CONFIGURATION_M_SHUTDOWN (0 << 9)
> > -#define OPT3001_CONFIGURATION_M_SINGLE       (1 << 9)
> > +#define OPT3001_CONFIGURATION_M_SINGLE       BIT(9)
> >  #define OPT3001_CONFIGURATION_M_CONTINUOUS (2 << 9) /* also 3 << 9 */
>
> No to this and similar changes. It's clear that this is a shifted plain value,
> it's not a bitfield. If in doubt, always consult with datasheet, if there is
> no such publicly available, ask driver author/maintainers of the subsystem.

Yeah, I knew this was a bit of a gamble, will fix in the next iteration.

-- 
Kind regards

CJD
