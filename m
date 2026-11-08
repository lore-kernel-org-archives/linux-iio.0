Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101436;
	b=5lGW93u8NhIuM1TGeVx7tdPhCKqRnx+f+Czq2hQ+Ge2GU8BjUNxOywBz3LBWMzmuuoCu
	 BY1gR56e1UUXvNt8PajwL/5TwxafhGWqOGL0ZZrdv8b2X5z/nJ91mL7EQOdMCyVT/gKb3
	 ODZY7V+guJ40BN5fvtH/Wp2RL1Wh8MUiscMO/vMMwATbv9b/HbKyQFP8tDaulUnd/pwyo
	 BLpV8AHYtoFx80DxhhlzRe7+mVSkcWlOuWZc58zIFyIbZeZZg9IsTc3oIc/Dp6bGovvXH
	 3r6LFbDh3KVszmMPk3tPewLYLCkV0FIuwHC+oTO6kN9NLoPLGyb9xQIOP1e1XtZsZcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101436;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cxolDekYi/UpNdRDGBoRVJhDPItFeUatyKLS8M2gJd8=;
	b=0NAtXSZTbLfx4OKruoTCmHY6A54AvhygV0XMl9DcnBEl9RKQPm8L0zESboF/G6CjmJdk
	 6XXDmlE/HRLtazSHxwptjz2TUlfTPxw09hKFDqw2CfsLTX+6DbdiWzTyIUBBc3PHzizJt
	 oigpknTPFHc4dfFFLfz7IcAOERLhY9uCandczWCl8FMFdFCjSUsgrOV0WVHqccAUA6iHh
	 48MHUBnUeYKe8m3KDAuClGdp8sZtgqeYnhqathD9i+UZUFlYu8RGl+ErZqWn7qMVJUByh
	 n4CrSq/Xw71B/pOybGG4RUOE/j6WZd4oUpxs1wELm8hAVkLhcKbI097MZQrtkJnPa0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tw9X5/QG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD87606A326;
	Sun,  8 Nov 2026 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tw9X5/QG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3461F0089F;
	Sun,  8 Nov 2026 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794101435;
	bh=cxolDekYi/UpNdRDGBoRVJhDPItFeUatyKLS8M2gJd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tw9X5/QG378HL3UXqjnxQX0TMDoKQRQ/FFnl55QeNxaImlwSCIgnzVX7WUvDIEymB
	 P7WGd+KS774yQdxm4BQ+5jJylK4wOFeGjiBqFLBeEyMOa6unRaddZNs5L93sr5cd+F
	 5yrVlKF5zo+sKkNYTUtnsDIpP3qDiV1BVnFlvQFYHFPTRVr9WAE75iPGo5PwlQCyJi
	 3YhLGsPAREjTUNjJqsHqVh/RtLgk0+BKYP6NuBQ4P7Ly5Pr98XnFgds+w607MkQ/Z3
	 DniI9hGXwcp5/aLaAU0ub04c5HvchRnJxKjpnOznyEtb21Z16tqpNW7B2i9Qv4B7/p
	 4p+ok4OGD8hqA==
Date: Sun, 8 Nov 2026 01:30:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Vidhu Sarwal <vidhu.linux@gmail.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 0/3] iio: proximity: Add Benewake TF-Luna LiDAR
 driver
Message-ID: <20261108013028.5d68c966@jic23-hlaptop>
In-Reply-To: <20261102222056.30f23d75@jic23-hlaptop>
References: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
	<20261102-massive-busy-woodlouse-8d0bbb@quoll>
	<CAFqz8LJZQ+tw6wmLS-1FXvt6OxBESPEyz2-uK4D7B8X8epoKhg@mail.gmail.com>
	<21b771dc-e9cd-46b9-a456-0950ae1270a3@oss.qualcomm.com>
	<20261102222056.30f23d75@jic23-hlaptop>
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

On Mon, 2 Nov 2026 22:20:56 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 2 Nov 2026 13:23:56 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> 
> > On 02/11/2026 12:48, Vidhu Sarwal wrote:  
> > > On Mon, Nov 02, 2026 at 11:47:56AM +0100, Krzysztof Kozlowski wrote:    
> > >> What changed exactly? b4 diff fails, the patchset cannot be applied on
> > >> any known upstream revision I tried.    
> > > 
> > > I am really sorry for that, I didn't realise it was based on Jonathan's
> > > iio.git (testing branch) instead of linux-next. Patch 3 conflicts in the    
> > 
> > That is fine in general, I'll wait for next linux-next.  
> Might be a little longer. I've pushed out now. Was just waiting for
> anything nasty from the bots on after rebasing on rc1 before pushing
> out.

Applied to the testing branch of iio.git.

thanks

Jonathan

> 
> J
> > 
> > Best regards,
> > Krzysztof  
> 
> 

