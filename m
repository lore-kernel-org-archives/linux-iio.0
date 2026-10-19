Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDB3D75D3;
	Mon, 19 Oct 2026 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379306; cv=none; b=BLIcK5fK20y4kNixzEeYEn+pBZD57Yjbe3TUUDo2WiSsptjd+HDsRxIgNc45gxkV0fw9/7qNMCid7FrptzzlAd6wfezrqzvH/qb0hm1I4gO/4lRpNqR02ps9eFHni4SSzkpz9JvX/KariHB13hXASKjnE7l5opo2hg1LzSVLbP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379306; c=relaxed/simple;
	bh=ffsEe9o2YKbKkP24NhYSYUcg1Q1AoOkNSul7Dx2ASuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8HqF6WPMlP0nHUPE5F3Afvsnnsumzj3vp5iZyLPWdS1/F3yKptXLmSe4v8TePeiLtboDf/WBs3WoqL9vfLuhDEaPBaIYoNP3JJEC3lBmJ5VqvcOdz6Cgr3kVCZl1IEVxDAH4Jc1Uhg1/Ozf1p7bzmKJgYgIf52nJGHLb0qbZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7r9ShC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7r9ShC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7471F000C4;
	Mon, 19 Oct 2026 03:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792379302;
	bh=nPNJjCUolFLacGGsuBJD97/L2BcR0+/CNG7S9sXboPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y7r9ShC82awtABDlAsfko1XRN6kxfWUkNBOU+41qD+ufaMlPJng0wKIuiUAEp3Yjn
	 kG9/VpYWH4G9M0DR8MwZ1sW4fGqiVhRIbOegxSdxiktGFM0ux5ujinsrn8Z+woEccC
	 s5KZ7tKtvs67X7Hn7RmYKVWgbIwg7mIANcA9WQGzNMfUxGf1JKCnkMe+pZJKNbIS3H
	 jpffMoGKqb7uqT54Cq3ANvKFlFAF6E+npY2hGNsbU/SMAch52AViVNPKCpzLR3yr/q
	 73hpE8Lcyk96hexGWK7+D3yEExX1sCj6FUZ2Hv+2zRSgaK1JBjV4dFoFWVyo5230J1
	 ftD3UTQFRMz1w==
Date: Mon, 19 Oct 2026 04:08:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: adt7316: use kstrtobool() for sysfs
 boolean parsing
Message-ID: <20261019040817.655a1114@jic23-hlaptop>
In-Reply-To: <CANpqX3YDqtqGeeqscxF0YqMWMmSB9fpkMbxapq8WbbZWSQH=EA@mail.gmail.com>
References: <20261014091111.20059-1-abdelnasserhussein11@gmail.com>
	<20261017231747.4906975c@jic23-hlaptop>
	<CANpqX3YDqtqGeeqscxF0YqMWMmSB9fpkMbxapq8WbbZWSQH=EA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 09:22:35 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Hi Jonathan,
> 
> Thank you for your feedback.
> 
> I apologize for the confusion regarding Joshua's tag. When Joshua
> reviewed v1, he pointed out the necessary fixes and concluded with
> "Otherwise LGTM." Therefore, I mistakenly assumed that I was required
> to add a "Reviewed-by" tag for him in the next version to acknowledge
> his review.
> 
> Thank you for clarifying this for me, and I hope it didn't cause too
> much extra noise.
> 
> I also really appreciate your encouraging words about these small cleanups.
> 
> Best regards, Abdelnasser

Applied with Josh's tag dropped.

Thanks

Jonathan
