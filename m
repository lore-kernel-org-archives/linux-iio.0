Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608980;
	b=i74ZN1TaVsPNQ7IDuWLfaW3HiOE1l0/KgKRnaw/PICtE7smg1ONAbavxcSX1MCVP+TOm
	 F5nGWUosS7kHBai0cFAeEM8XZqXCc8e/4wrJt3mPYsdCMvMlp7yXr33ZFTjyTOJUlTG1L
	 4joWIS7XvFZsGDBwYQm/aj+M9kUgtO5uAxC9nM/AS2o/n78pjJr9sY4qIf7SWM70GRNGH
	 LGmS97nXDJZW3GcpG+u02HXay3WgUqgFtaIk0qnNgF4hZhg+YHzQOoe/yiVaWnsFoAv4M
	 Y0kzlbOSFduYi4Abwv9LSJ9n/G2lqHqM77VvuGq6uZ07kGxXk7gxbxxD/oxIhaIr0Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608980;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=knRn+3sr9mXrCZcyGIH6NLdUHpEKhFcrM1DoEB35T7Y=;
	b=u3T4l18uWlhEc57zLEIonwzFD/x3CcwYJ4laM8VCH8eGjvHQKw0Mm+2cxRKJR/A+P1rP
	 IIqIkwPO4WlFF+WpHlLJBIELtWP3Dp4bgURIGKUV5YLd6NwIeQOKGHi5JjVP/UC8Q0tMg
	 WYrUi1dONUh9wtVhwHjpVFOXSpb6J/xzqIuu3vwbKMZL5A9J/ic3LU5z0W5JxP+LIQuE9
	 7lZpiOor8c6j8IY9L2MR6v11FRd5SPL7QmsSahFyak2Slyc4j0m3tHI7WMe9Ti45iLWev
	 XapXgggDrels43rzCvEIQBZ9v3VjxZuhw6gS2H8NT281MxF19ELMFNdI1vKZGH4z45Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyZIN2zq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A201606A319;
	Wed, 21 Oct 2026 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyZIN2zq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56311F000C1;
	Wed, 21 Oct 2026 18:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792608979;
	bh=knRn+3sr9mXrCZcyGIH6NLdUHpEKhFcrM1DoEB35T7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZyZIN2zqAc/0d39aWeCqUXNdD52jBRRS5I23SWHd7ufiq4hcz+egrLzdxUpW4oKXs
	 Vjt8ykR0uvZh8OxeQmqxd8/oHbSiJDgxZqDYGLG6oRpKVGHVNU5nR2nwFWG66OSqvp
	 P1lOvidyyuOB1Zxa20gOKyFTIbNmxCH7GaPEGuZw8MFIuC/YIcyHZ6jgR34somw+Xs
	 x0ABGotVVnKOq+8urtHMgOJn25xS0z86mc2bvXQAmx13jwHUNwm1dkzVbLcEBNvGE9
	 EYUHKkJ50wmA8wHbv6wtNuGzCdD64EH+tyswZkpT0KQ+hOuKBb5L1ppb6hKAFWo8wI
	 BXBb/9PXsOxqw==
Date: Wed, 21 Oct 2026 19:56:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 00/10] iio: adc: Add TI ADS126X ADC family support
Message-ID: <20261021195611.14cd0a2a@jic23-hlaptop>
In-Reply-To: <20261018023129.3abeb679@jic23-hlaptop>
References: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
	<20261018023129.3abeb679@jic23-hlaptop>
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

On Sun, 18 Oct 2026 02:31:29 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 10 Oct 2026 03:52:39 -0300
> Kurt Borja <kuurtb@gmail.com> wrote:
> 
> > Hi all,
> > 
> > I apologize for the long delays between versions. This month has been
> > very busy at university plus some personal stuff. I expect to have more
> > time now, so development should be faster. Thanks for your patience!
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>  
> 
> I took another look through and it looks good.  However, give
> the sheer scale of the driver I'll leave it a little longer before
> applying in case anyone else plans to give it another look.
> As normal, if anyone has it on their list but is snowed under
> just reply to the thread and I'll let it sit longer.
> 
Long enough I think.  Though given I'll be rebasing on rc1 any feedback
people want to give is fine after this.

Applied to the testing branch of iio.git.

Thanks,

Jonathan

> Thanks,
> 
> Jonathan
> 
> 

