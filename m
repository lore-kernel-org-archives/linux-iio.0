Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30071348C7D
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188869; cv=none; b=evIMLEQtY3HLwIw+kdD19p5pZW2Qgs+Ed+M4LRzUwz2k+eE/fmSZhuKTbq5C2fr/w9CRMv+ztaea6oewdoJvMOCIwkCTT193n/hoN+I6aIdKIjMCYdio4qxhAzviQQerhfOQZPoY6wVKW+UOs5CKo6It3K48efI24frpYdwECyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188869; c=relaxed/simple;
	bh=10dtEl8DqsLcGMTEBaEaAAa305THp9iKjli02M4Po4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uibw5X+JPGWaUlOlg/Wic/Actu4SYjzRAJFT2bus2hjQSWgYy0KkpEDPVDzLuGEbkiEle2plBOIegNPeT9vNZUI7cQUwKbOhU/06R3i7rGjOjS0Dd42yZwoo/uO8Jvaq4Us4wq0ddTgxkdKi/a7hVcB2UvYucc2v3YME9uonekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYeuSMrR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYeuSMrR"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4720d22c94aso3268661f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 01:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784188866; x=1784793666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nh4w7M6v6hQPs0TFPANWHP3vh4YcpbdfpnxWq0TQP4E=;
        b=PYeuSMrRfkfo+sGCiEJjUsUfzjJTK93Oge+Z1V1SspkuzigkTqMAKIlGQYBp6IUM8l
         G0rjy8KN7iilKD7dydun7NC5SZt1SipFHt7mUESjMmx5TqZAnxwPJ/2FlWnioTqC/NFN
         E7UdG/yNSKiI53rkrSlilJXVrWb39RRZvR/ezcdnAFj0Xxsd+lpfzr8iGah3dLviA/yr
         Mr9iI+ZdYBHdTIrv6kBkEubuzFYxi4cUVnMRFWEFOSdV9xPfvI/luXltuN6wtvNw7hmI
         hRkMr+TNG0W4KbyA8r5UniL7kq0qUmuwO+whiS0VPjKsMisM+DZN6GBatWym/k+JR0Bi
         QeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784188866; x=1784793666;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nh4w7M6v6hQPs0TFPANWHP3vh4YcpbdfpnxWq0TQP4E=;
        b=HPHnGz0wjc+KJUEj2fs9GlFdXAWSzW+wfL0mmR/WqmeO81uyDntrHt7nBLobKVBb0M
         Ppq8lAKjmVw2pmTNEqMSVvju1KaQWfOvK+rFhVR3ryaqx9n8FUP4jwyuem5SzhEOZf3W
         h/xTkfqtj4BefHdIlBYd1UNwiZd0mdaTSlbJQPK0Mqy/YDvlYWyrL5zUl559WewNq1Uj
         dv+wv5Dh7IWvyLpno2v1J3YARr7OntN4lMuPcUfk2fWjoQavQww5iTzMTC0JjGPcsW0U
         xxxOWmFk7+0+k7fEaVhcCrJGg0WRusgoo8c1uGVhMha6vUX/B87y7i1kaaMddYMMw0Gy
         dPRA==
X-Gm-Message-State: AOJu0YyaoEBfk20o/8hnei88OfEVaFpQxw1T/cMDz4t39fUEA2IwGUwz
	jJk96r/GPa9/Lz/7ht2/jdyFILyj4G1mRodryLoO2KWvBff3wRo7hZ6xLFWnKjz1
X-Gm-Gg: AfdE7cm18QroIH8UKg7attX3x6Ae7bm8dn8fnGlUKTCBPWDdTLjyfnof6Uz6ahQCP1g
	rbHAMljboCstHyq6tzdm5jtJQDzvk/UXEu0HlHBkgweOjBYTm4ExlOYnWJ/VOYUX8caG3wERlrw
	OGu6kGgFuVQIkgKS4/3P7xVZC/3hIXREb17V8jplDYRob4mn6q6vTRN85t8KAZivMhJ0GffAtyb
	xJDqB7F/LcaaeuVoiYcoNDOgUxXxHaJycereyrBVGTLTEenapCXB+bxEiPFtobF5Z/UEJqAsPa8
	b4Eqlj7KzY7swE89nu2gpQgZ31sAGGT3n+UtGMJ09Km9saAosW1dK4BRzE2/YwgTTJSmQWcODEl
	apgltnrIKHB6puEQ+o0E2Jr7eUbu9n5BZnd5VKEXVaIS4IBiwI+2tQhQOJ82I7m2tztDszaRHaC
	CfON3apOOhSI2ittVKvuBfpGIVq46RSL+WzPTslIeLzYYISWUUFw84jiGB7ROQN4902h8ynzMnY
	/AWapmz4hZVirdniMNjnCuWUUzojr68mvLZnGg15I6tIulXqZXTkmON+1MJHEQLDeGLRkH+r6HQ
	tJSmqn4vRYEf/kMJwdOS1MS6O2hHTA91ELcZhxaTpuAXpegtmthQeF4gpMbo9n5g5ku03sI8Sn1
	Q24lT3kpkCPoo
X-Received: by 2002:a5d:64c4:0:b0:473:c18:f2cb with SMTP id ffacd0b85a97d-47f2dcc03b2mr26659879f8f.18.1784188866051;
        Thu, 16 Jul 2026 01:01:06 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a9cesm22944096f8f.14.2026.07.16.01.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 01:01:05 -0700 (PDT)
Date: Thu, 16 Jul 2026 10:01:04 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [RESEND PATCH 00/22] IIO: Clean out superfluous I2C checks for
 single transfers
Message-ID: <20260716100104.000059f8@gmail.com>
In-Reply-To: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 17:57:15 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Resend to include linux-iio. Sorry to all who get it twice.
> 
> This came up in a recent review and I realised I have been giving incorrect
> review feedback for years. Both i2_master_send() and i2c_master_recv() plus
> the dma safe variants only ever return either an error or the full buffer
> size.  Short accesses do not occur.
> 
> This series (also my first upstream series prepared by poking claude)
> removes the redundant checks from all IIO drivers.
> 
> Thanks,
> 
> Jonathan

FWIW, for the whole series:

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Also, as trivial as this change is - if you were hoping on Sashiko picking this
up then it failed to apply, as you didn't add a baseline.

-- 
Kind regards

CJD
