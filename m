Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790517;
	b=PL8cnz7virSZZh78MMdirXCn+r228cY/fDqkuFwOEd7uyGhuddIE8Q5BOlZX0B7TqTjk
	 QgUCSqjXxZ/lVHdTFZGIR8RYnkdZvngAbhdT0m/LO6zFmGL+CjCwxXflzWEY3mp9IUR7a
	 SSbS/vqYhL3V1PzRm6baVfL3zjvsrMon7Dzr19u6bpeO8ipKUv9/r2duHALl24Wao7x9U
	 DMPTVh+GPhpEYAuqojNhGNU6FeHZgX3een5UT/9JKZ49Ja0EKRTRGmluNzUKdIgp9WrBA
	 cemC9Qxl0woNGu181Gv0MbWFshNwGnyhNJFEW+0SnPMFP932e+FyjNOB3lbMjN2BjBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790517;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v2kkoBBpinJ3jfPzo2XnA08muXsaPFPKEp5aH+bJ0ZA=;
	b=izM/wJ4l17I4bmCp7zcXaCxgyrIhR/qy1foNjVwVl5jSp7suECa90QbEKqnViG7qMTBh
	 GuJvEayZqIBsXn+mHYty3GpVp+ZNMYA58WVbFxAyNba/f2Ri8lJDa9eSpq2PF5Dx19ILM
	 N4iUUbdRVRx0XiMNjXdnLhdWrxoDMs0vtkF7B6KbCSOFv+fhBXKaC/gz46zvjN4SUVzZS
	 nNQMVUOWYnzEtkee2iiKWMh95Yp0TBJuRKYMV8h0IhK6QfmCmMEr0zHCbMUxG1jnbyVbf
	 TDYSZpEnxz34BuipDIUN3hCULd4X1Fvr2Jn+dg8rDQJEJA1ZJSb2yaH3ifxKtbLeYsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSU087KA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122C606A31B;
	Wed,  4 Nov 2026 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSU087KA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03131F000C1;
	Wed,  4 Nov 2026 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793790516;
	bh=v2kkoBBpinJ3jfPzo2XnA08muXsaPFPKEp5aH+bJ0ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jSU087KAuu45zyKfvaXitY89KrhnaZcZf7HurTODHAYx8clu6KmScGip5Iv96odOU
	 4gwCE9PnuAo5YUw7ChvD4MTu0CZpE5xNBtEF+GHjRukBuQqN21tPnruSdsaNcnNyHE
	 ly4rDIULMKTvwEnDCD4Fx2RRa9cppGmDEE5vQzukaXru/ff6zjkEcAnGLrSCXJcbea
	 03B/F7VmW9hiiwlML5KfIzLjrpl4x5eGneZu6c1DXyRLJ8750tu8GLpHO3p4zDjI3h
	 tfJ0R8zf46AdBOG4pTm+wctsciOYOCq8HxFg1S2U1rhF193m9y5uNYjF7K3iRP7DmS
	 n0JIGntFLgsAg==
Date: Wed, 4 Nov 2026 12:08:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
Message-ID: <20261104-daffy-infrared-boobook-aeae26@quoll>
References: <20261030031501.130290-1-cwweng.linux@gmail.com>
 <20261030031501.130290-2-cwweng.linux@gmail.com>
 <20261102-bald-mysterious-alpaca-13b8fa@quoll>
 <0f0324f4-48d8-471e-b35f-7f2d541a70ee@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f0324f4-48d8-471e-b35f-7f2d541a70ee@gmail.com>

On Mon, Nov 02, 2026 at 06:20:56PM +0800, Chi-Wen Weng wrote:
> > "int" is redundant, so honestly names should rather go away completely.
> > 
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > 
> > Best regards,
> > Krzysztof
> 
> Hi Krzysztof,
> 
> Thank you for the review.
> 
> I will shorten the commit message in v4 and keep it focused on the
> hardware aspects that are not obvious from the binding itself, rather
> than repeating the properties added by the patch.
> 
> I will also simplify the interrupt description. The detailed ADINT3
> source information can be kept in the controller description where
> needed, rather than repeated in the interrupts property.

That's LLM generated confirmation. Typical respond to prompt. Great way
to get yourself on the deprioritized list.

Best regards,
Krzysztof

