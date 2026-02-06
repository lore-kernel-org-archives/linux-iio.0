Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F110C330B12
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382066; cv=none; b=MSLlN4ELN2VqLkqlg6dZYdZMzbsEwUCVLM4YsN1oFaWZzlQ5ZHLwtFkZu0+/gMGdcsoFnyI5T3BQXvwqtFMLwvnBs6n3nhpiKYDEF+Z2U8P3SBP7y9nMdxrr20dUi0orlV0SK7ETK9OHXkEwMwEzveBPTTjmWNRnpXjWaIH6Ouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382066; c=relaxed/simple;
	bh=DmYewFQkG8Br+yJkli7xvaJVDKaHxnJu52vf06s7BMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtNijF/hPlrPVoZBlD7HPoHCzX6mshMDqpSoyeKGLHlYi6f45OSJJGk5WyZsMIi7BlYPrHNZ0CKnQnqIIDFnxg3Ev9iVCDWYitj237G6o5HOxHEFtChnWN/VNtCxxZRKS6tHJwa+qqssUZt3rGwN3OJMFC8LmcT194Qn2WeiNHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1DU+eoP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1DU+eoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5015C116C6
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770382065;
	bh=DmYewFQkG8Br+yJkli7xvaJVDKaHxnJu52vf06s7BMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K1DU+eoP8rIZpSx/tmtvQZiBNZ0PIui62dlkjpjAcpO4Cjt/RXugdT0t013M4RlSP
	 MYOOOcXe7zE7QJ+JkRfLFQZCLusuABWp+yBM5hToI88UgsM3PL6F/CPVldc2FxWf4q
	 RveHxLyhYSpjQflpkTVPVLnjW43ezUNkT2MW5xmIeOQGOK7S10gyAZfmlEnmpUqvQc
	 HG0CCQmmFtGPbfDFyDocGcpHbPFbrtn8uJkSvRhxDX9G27u7VraEYUqUjIy5CnLn7c
	 YtxVOWux8SjocbcwoZ8rjnVIbCXDaYSb1N5lbO5lmGFg7MnQ8On0rUMVEUS7qQ4qj9
	 qgmLXBDKD0syg==
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649bd1f08acso2111274d50.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 04:47:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWageFtioZuI/l4C6HRWdbPgenBfdXO4zY/y0pgQQI7kB8gc//AnPCoN8KYUPzyrEox9L1SMAEpFzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzknciW4jJbJNHU/VgdlFFKFDeni4nD0RYKYNzUhv3m/pHVYbKV
	blqSLIESVxgDEQV0NsWsTwvkkP1QzciZT+zAMYEcp7cCDl30Sq/PhhCyHjIm1GzYhKtAoaX1kCF
	o5mT8uD2egmH9KLW24QmaIKZs/ZtnE/I=
X-Received: by 2002:a05:690e:144b:b0:645:520d:31bb with SMTP id
 956f58d0204a3-64a0b8f8c85mr1664544d50.23.1770382065009; Fri, 06 Feb 2026
 04:47:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203143946.301233-1-jerrysteve1101@gmail.com> <20260203143946.301233-2-jerrysteve1101@gmail.com>
In-Reply-To: <20260203143946.301233-2-jerrysteve1101@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Feb 2026 13:47:33 +0100
X-Gmail-Original-Message-ID: <CAD++jLn4akBi7opOKdZjtAt17+FjK-y8UqKXbX3fQkAS7hC0_Q@mail.gmail.com>
X-Gm-Features: AZwV_QhVy1-igVoJGFT_GiltoocheA0dz011h4GikRyAw3kiKYlAJeCgAPVYMoo
Message-ID: <CAD++jLn4akBi7opOKdZjtAt17+FjK-y8UqKXbX3fQkAS7hC0_Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: accel: bosch,bma255: add bmx055
 accel binding
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, stephan@gerhold.net, 
	hns@goldelico.com, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 3:40=E2=80=AFPM Jun Yan <jerrysteve1101@gmail.com> w=
rote:

> Add the device-tree binding for the Bosch BMX055 IMU (accelerometer part)=
,
> which is compatible with bmc150_accel.
>
> Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_dat=
asheet.pdf
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
