Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211720;
	b=nor/fjixzosrm+QnAEhONfvC13I0N6+ev4LfZUYDRxg/jerWkZmFCxk3IQNpjbtU2D4R
	 /b9tzAYDIV4yyEdFZRDgx1PWuM6IE29sxXy8k4CBfwI+6ieUl3fPbj433fOThiPGMjpc2
	 vIcELJoQs3IH89BUoP0VqDaZLS0GGMdLL+oKe1262lX0FC2JUjRpfCHiOgKvlOVUk/bmo
	 xB7PVXQGqS2wjGdtpfpXxFBQgfXhKTtu4Toeju4mVsQgT+40VhxcknUhSDhEDnQ211eyF
	 xhaDIGfkxUdgcPA0IjSurTfEeDhMI+Ec8oJhmYftHZQ5/XZBWL5mEA454dPnq1rw9/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211720;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eGzyAaF/zB/C/wRsxxWtk1asQcdxUNh3L0EMf0RlAmM=;
	b=jOHKlmcGXnVIB6rEOVOwQTL/Gj0udquwDifwxquKBRJVg9DgvH4JjrKXgHThpaWHI22C
	 Rs4aRdDXFMDHpwR3sGZ9gaPTrS2hWGW/rjElEAbfcW5xjMr5F6IsE9P9dx0tqb4Iw9x/p
	 SVlMxl5/oX7SNX2/YXdAvrylC45AWXEKYEl8XrjTG6jnGcY+V9nP15OR7qD2dqf9kdm1y
	 ywFhEjdKZiBrHEtmWCTIy/PMozDWw670pTFvcXF37xGTZhgFni2JVQ5kKZvihHbAO/Frm
	 z/y0RbnveUtu0feRCxN4ZfeKgoMidF8GiVHl5niYQCVVwpMBYZZjPAX+0j9nRxiQbBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDIvgnRi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CFB606A336;
	Mon,  9 Nov 2026 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDIvgnRi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794211720;
	b=vbRU+W3EEJ6+BhCTI+nzQRYKCzOjqGnaDHR3rOt52tCfvRxhBE6ytW9DKbfZucO/Y0aM
	 a+a5/ajgkyvI6GEV2WodsxCtM5cX5IIeHff+5HTrn+vtRaAeBfJEF+VViIxYxiAWNAPpk
	 iAilbp4mzMErDeiOGnNrkSyJ+SXzm3AXRu6pFzc/8aW9psBjVTtGOc4P88VrnmfFzQ+dK
	 EwZXBCAe9BRCbEEZATpKQdkJznDSFdrwXGzTWQnSDjgCV1FLza35Jd/0Hu49+LE1SKJ7u
	 4wm2IyDDuRkN5FghffbUEKQFNtzBvCTvBn45HKUlzEDoI8B+aGSHL9YNcIgLWybcd/w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794211720;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eGzyAaF/zB/C/wRsxxWtk1asQcdxUNh3L0EMf0RlAmM=;
	b=YTm+JkoVdvsU/KUWrdSw6N/SwxaLZ2AAk/L76+gs1qCm3ien7fq8YXOgZLhSkzDFoQbU
	 xrTaRaueicZsW+jyUlFlFdFdVVpC5F1pAxS9bC5/vTS9EuxJLY0ZjNdjpjsfKLwddmrMi
	 G+WfB+gtCwncG0TqOcW83ukPf4qarR9T1cCo5pN6EGCNEtbkp0xvfTDjMuVmyO2s6YuuM
	 dnRFVheKjTt8WfWHPCQHrvmGuMhlSaZ+fusBEOA1X+XImtjkTyZonWPDD77VUbc5lYX2Q
	 JI9ri1p6AIEwUXX/sW3dj1gxaL5bAhRQglwmG3BZlqg2S7R2KGRiBJaLPMTLhuOtE7Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 0DFB51F008A3;
	Mon,  9 Nov 2026 08:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794211720;
	bh=eGzyAaF/zB/C/wRsxxWtk1asQcdxUNh3L0EMf0RlAmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fDIvgnRiCOkOR8uJ4aiVv+uMG6OtOl2PfxwXsMXp5ygWpfF1gprsTjMhF3MOKl+Zq
	 ViL8mhLzwsWIe+fAj1wmE0Jwc7tMg/JvYoM6+My4lZ8j3+XslstK4hLGdWcxQ5No0D
	 KDyJGue0q3lI/7J18TgcMokcI0L6UhEkLTk/lizofR6inyriAw/iXjAqfEJpd1XcnH
	 gWf82TY3n6stXNz0k8GEOUagI+KIgeu5LzFbQ4mdT7KxmYJ19n3RC70Gkh4Z/jfZoW
	 vNbpz9YFb2bWqjDr1GZMoNz1CxZ5uEBecw7v21cnD7akChhxm2IVGv0OgYp9PyVZAE
	 H8Sx+/kAvL1bg==
Date: Mon, 9 Nov 2026 09:08:19 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Akhilesh Patil <akhilesh.patil@linux.dev>
Cc: jic23@kernel.org, andy@kernel.org, akhilesh@ee.iitb.ac.in,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 akhileshpatilvnit@gmail.com
Subject: Re: [PATCH] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <20261109090819.00000318@kernel.org>
In-Reply-To: <20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com>
References: <20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Nov 2026 06:39:24 +0000
Akhilesh Patil <akhilesh.patil@linux.dev> wrote:

> Move to my new linux.dev email address akhilesh.patil@linux.dev
> I plan to use this email for kernel development going forward.
> 
> Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 7fb33babc931..54238d2f04dd 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1030,3 +1030,4 @@ Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.com>
>  Zijun Hu <zijun.hu@oss.qualcomm.com> <quic_zijuhu@quicinc.com>
>  Zijun Hu <zijun.hu@oss.qualcomm.com> <zijuhu@codeaurora.org>
>  Zijun Hu <zijun_hu@htc.com>
> +Akhilesh Patil <akhilesh.patil@linux.dev> <akhilesh@ee.iitb.ac.in>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 222b7fc2c3aa..3aa8fa3c068f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4095,7 +4095,7 @@ F:	Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
>  F:	drivers/iio/chemical/ags02ma.c
>  
>  AOSONG ADP810 DIFFERENTIAL PRESSURE SENSOR DRIVER
> -M:	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> +M:	Akhilesh Patil <akhilesh.patil@linux.dev>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml

Grepping for your email address in the codebase, you should also update your email
in the dt-binding and driver for the ADP810, and the dt-binding for the M41T93.

-- 
Kind regards,
Joshua Crofts
