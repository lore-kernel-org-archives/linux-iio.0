Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794103460;
	b=pp9Y617d09xWEJiked8fra+gTjmcJHw7OD8gutEzLa34g5NDiSdNnbgkgcORCqKROrdc
	 MmPzRsJEz5Nyb5AjRdx2FwoRYHRI2ZQ2cBpV6p06qpEBHcJ2K88UvYQ/h+nWuCJgCj3tM
	 Ji1om6yjLcWpEvCe+DQw+fPzuoqArozm+qnVBPNLZSIbmXrUuTIdiEGrr7jy+x+75/QPo
	 c5Vh6jA4xMYvCdgTBaPcgmd90v/SHaMP/NBe4TmgnEUM5dAIosw8qAWv0mGCZ7lO9rS5j
	 nzl6M4egihtta4iirTl0YSE7swjzOR+HdxJXSIgrXS1gxNOaKzd4qeOFCu39gr5maRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794103460;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KdK+2Y31YGq/pziwmjaFOQoKLGl1Ioy8FCZaLYsW4Yc=;
	b=czNCvWtYnpWoYAkrxL1EM9YGl6z12vLp52RxlLr0YAvknYF4EZykjTlfFNW+UfvZmX5S
	 3ANsRZEDLEDLbyyf8Jd5kHUGt0PFQuBnM0GKieRJku0k7dQ5pLjDIPUCzyKQfgL+pU+mb
	 Z7v+yAqSmxPCRTXnQNMLOCReDNd9BD/Aqh5WzfYu7aDvphepVq+Xd+gokgxqY0ChM+lN4
	 dRcdZJ9UfRKVQk5sBEJdSDRRHSg0afMCzQG6+5Vsaap/5I7WL55w3Ny5V2MRG5c3c68nZ
	 h+NmGRS26LmqK8m0U37pmYxhN6gKG+Bcr75KBqb7AJcDYOssC692RVyulPEzhBXtiSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQ9+cVLx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFA606A330;
	Sun,  8 Nov 2026 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQ9+cVLx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9A81F0089F;
	Sun,  8 Nov 2026 02:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794103459;
	bh=KdK+2Y31YGq/pziwmjaFOQoKLGl1Ioy8FCZaLYsW4Yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RQ9+cVLxeaJ1CXYlsWl5pI4Rkuo7vgXMMeFTaDljZ6av1cazPPfEihL617klilpxS
	 DIocx9fFBjUR2+LUvy5qHtcA1KoM5f4pd38yGaDijUKrQ7tcguQ260DtVm19nM8V4m
	 V4UGKNuEOYohuwHj4gFnNFzFT3fe2rKpr5t5Vg0qljkYRqtIs6Q6pTaH/5kVIcSTFW
	 WPda/KFke8e3tLSsyxn90zXkVjgKi0jewqY3TyJijGul3mDEVptFUU/UKz6RXyl6EP
	 CjA3mnZS9EiSfU6dAns8+dq7dcC2vaxE9WTJYcbraGKodfYgANEKRCMTpFqITVLF9h
	 O9sjqc2V78zsA==
Date: Sun, 8 Nov 2026 02:04:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: light: stk33xx: add power supply
 support
Message-ID: <20261108020410.171489e5@jic23-hlaptop>
In-Reply-To: <YGYT8qy3NVYYjUfYP3NfqDnjoQ7gdqYMw8opOaTfChdSx2z6jkaYxxJjj1Y4x6E4DMVykIDZzFjWGh_ywapgRTWmRuuCnBajjm89ZsN2JSA=@protonmail.com>
References: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com>
	<20261108-6768-stk3337-v1-1-0340c99b0e33@protonmail.com>
	<20261107223601.0ba9ffc6@jic23-hlaptop>
	<geNqZOyrIjYLfmuUys8cQJU8FM53jylicArPsTGNXPnqSvHPCIc1Jad7dBOBy1GdE38RBEMSYQYDqEmaAqq2PDcglQcRBdkR0yZAjRExEUQ=@protonmail.com>
	<20261107235342.40f2e45a@jic23-hlaptop>
	<YGYT8qy3NVYYjUfYP3NfqDnjoQ7gdqYMw8opOaTfChdSx2z6jkaYxxJjj1Y4x6E4DMVykIDZzFjWGh_ywapgRTWmRuuCnBajjm89ZsN2JSA=@protonmail.com>
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

On Sun, 08 Nov 2026 00:06:57 +0000
Roman Vivchar <rva333@protonmail.com> wrote:

> On Sunday, November 8th, 2026 at 1:53 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sat, 07 Nov 2026 22:45:45 +0000
> > Roman Vivchar <rva333@protonmail.com> wrote:
> >   
> > > Hi Jonathan,
> > >
> > > On Sunday, November 8th, 2026 at 12:36 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> > >  
> > > > On Sun, 08 Nov 2026 00:15:03 +0200
> > > > Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:
> > > >  
> > > > > From: Roman Vivchar <rva333@protonmail.com>
> > > > >
> > > > > On some boards, the chip shares a power rail with other components. If
> > > > > that rail is turned off, the chip can't function.  
> > > > Not sure how the sharing is relevant.  Even if shared with nothing
> > > > else we need to turn it on.  So just mention that on some boards it
> > > > isn't always on.
> > > >
> > > > The only reason this would be optional in the binding is if there
> > > > was internal routing in some packaging or similar that meant there
> > > > was no pin to connect.
> > > >
> > > > Upshot, make this required in the binding. Note that doesn't mean
> > > > the driver must require it - we are simply documenting that the
> > > > device needs power.
> > > >  
> > >
> > > I agree this should be required, but that would break dt_binding_check
> > > for existing boards. I don't have their schematic nor boards themselves
> > > to verify the regulator for the power supply.  
> > 
> > There aren't any upstream (from a quick grep) and so not your problem
> > unless you have some in a downstream tree that need fixing.  
> 
> I found these (next-20261015, 7.3-rc7):
> $ rg "sensortek,stk" arch/
> arch/arm64/boot/dts/exynos/exynos7870-on7xelte.dts
> 467:		compatible = "sensortek,stk3013", "sensortek,stk3310";
> 
> arch/arm64/boot/dts/exynos/exynos7870-a2corelte.dts
> 412:		compatible = "sensortek,stk3013", "sensortek,stk3310";
> 
> arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> 526:		compatible = "sensortek,stk3311";
> 
> arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> 219:		compatible = "sensortek,stk3311";
> 
> arch/arm64/boot/dts/mediatek/mt6768-xiaomi-merlin.dts
> 348:		compatible = "sensortek,stk3337", "sensortek,stk3310";
> 
> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> 206:		compatible = "sensortek,stk3310";
> 
> arch/arm64/boot/dts/qcom/msm8916-wiko-chuppito.dts
> 91:		compatible = "sensortek,stk3310";
> 
> arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> 173:		compatible = "sensortek,stk3310";
> 
> arch/arm/boot/dts/qcom/msm8926-sony-xperia-yukon-eagle.dts
> 169:		compatible = "sensortek,stk3310";

huh.  I wonder how I failed to grep for those!

Oops - must have fat fingered the string.

Ok, I guess that's a big enough set we can maybe just skip
the required.

> 
> > If you do then there is the option of a fixed regulator to close
> > the gap.  I consider a missing supply a bug that we should fix but maybe
> > others disagree.  
> 
> Yeah in my tree I have added vdd-supply for my board :D
> 
> Best regards,
> Roman

