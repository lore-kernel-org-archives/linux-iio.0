Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794102749;
	b=CVuE1mVD2y+aMdGQDXJNLhKSMSG9TLAlzVAULmvmzZdWV3l4FbMcTSKr2lrhGUuBdPUo
	 3DshpI3yQ+tu9fR+DIAHxL6KlVM+29tbX6IRdLELfM+GxQoGaQvftsfMij4GhQUZ1/3Mr
	 193dOWtNf8ZUffezf72smzOK/xGxPXEM6SOlmwD7PtvFSwN4ziLtaaXVBwpQO3FDLQkAn
	 cK5XOo7FtGOOR5zNVdzauMTODLHuW3EycLUo2WPzqK27a2hLyLUKBjMHvwswsoZIjFjIm
	 8YeOEdMtEcXcZ23v2j1kwmMT58ozusFLmt0ng9/RSTBi8RUWlcwbLWboXGiA3elFaJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794102749;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wRjAg+ka47rjN93TZXrPtjGopEDUOpnlYdiInVar/pc=;
	b=0ZlwTbMO/MNzekEJSY8TDVsjww/oN2hIj3Ez7BGc29mG+L9BBkpIGPDLPe/yLEhPhyzj
	 Q88kYHal/kV2/1JPPBwQIzliH4wV6v1vM8zQyQDv43tQpl/2xC48bNglOCwHBZH2R3/Be
	 z4grqyCXCrDXgwGGfaViJQKdR2YvyCyZua1AD5peGBkgU73X9dbyyjA8GL+w+eFyBpiSZ
	 WNUEXqVdDWoOZ1qzowK9hjeB8ygWufWaDEx2gh7e3ChFIQRSRFvYQnfd1g5SwH0Z79BFd
	 YYpkZiy3qgdb6vLRbtLvqP5uA4Q6ahXoLdAt3Z9hxpzraRjs0vkVTjO0nx/AvZ2HxwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/e1DjG/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE62A606A31A;
	Sun,  8 Nov 2026 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/e1DjG/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822E41F0089F;
	Sun,  8 Nov 2026 01:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794102748;
	bh=wRjAg+ka47rjN93TZXrPtjGopEDUOpnlYdiInVar/pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E/e1DjG/A5xQ/FRHtLPSm1deEYeb/s5P4xjSgfrhBsf0g6rUoKRIFf2bq2Yxd7Nfs
	 Eh/32d2omLbPSxpYxyUKUABG7qbZd0twUML5533zRSS0OoUZeDT99zmKZdrgPhkbVA
	 dGItt9lFinL0h09s/vmfBt+NY6eHi/O5PaqcmI9glfLI5n66zXc5waaQ6ewe+k42fL
	 VRCFaSWGkbjc0zhcprusmuCfQ2ktib7AB46wvqAnkbMd/BfcKt0cO7El3NZHAU4W59
	 agxbLTCtl45quMtfhIwBUxkNH6vjG0mFTpGkmwLtXIvMLpxDA3ckbOGG2EMDgsXxLK
	 LE77BFebVTeSw==
Date: Sun, 8 Nov 2026 01:52:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 petre.rodan@subdimension.ro
Subject: Re: [PATCH] iio: accel: bma220: Fix trigger reference leak in
 bma220_common_probe()
Message-ID: <20261108015221.327af6e9@jic23-hlaptop>
In-Reply-To: <179396508376.2291875.4312877838122457985@iscas.ac.cn>
References: <20260916160823.2082283-1-vulab@iscas.ac.cn>
	<20260917011518.297868ca@jic23-hlaptop>
	<179396508376.2291875.4312877838122457985@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Fri, 06 Nov 2026 11:38:03 -0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> Hi Jonathan,
> 
> I am sorry for the very late reply and for the extra review work caused by
> sending many similar patches without first waiting for feedback.
> 
> I understand that mixing devm-managed resources with manual trigger
> cleanup is not an acceptable solution here. A broader solution needs to
> account for runtime trigger changes from userspace and distinguish the
> references that managed cleanup should release.
> 
> Please disregard this patch; I will not resend this approach as v2.

I have a plan for a more general solution to these trigger references.
Hopefully will get time tomorrow to try it out.

Key I think is that we need to stop setting iio_dev->trig directly
but instead just set a iio_dev->initial_trigger and then
the get() can be done at iio_dev registration time - lining up with
code that drops the reference in the remove paths.

Anyhow, you got me to finally spend a bit of time thinking about
the lifetimes of this stuff, so thanks for the push!

Jonathan

> 
> Thank you for explaining the lifetime issues and how this work should be
> submitted. This has been an important lesson for me. I will personally
> review and respond to the remaining feedback one item at a time, and I
> will keep future submissions within my capacity to follow up promptly.
> 
> For transparency, we use static analysis tools to identify candidates,
> then DeepSeek and GPT-6.1 Sol to assist with auditing and preparing fixes.
> I am responsible for verifying the findings and changes before submission.
> 
> Best regards,
> Wentao
> 

