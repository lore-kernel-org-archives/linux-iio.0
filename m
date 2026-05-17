Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B0277C9D;
	Sun, 17 May 2026 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779033322; cv=none; b=KggvfpzDZpLlidP+6QpE31OYVz+xRnGgDY0AZpb1v2nlek+jeB2q8o0UgYqAMEWxb/9FIy7+yGC3eaelWw0cCUjjGRRnsB3r5pCfHoXSOR53U1h7xRy5IGLikhGPivLetDRYMpQb/HukXNSl2Gu5unrDkNDuMCnAHUMPDfgi3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779033322; c=relaxed/simple;
	bh=vuEiq6kXUHmnExqvqbNZrlASQuYXEDFkmYRBJ2KIifA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHC7VWFuhAlMEANJmXpOMWPb4HA6+TcWGipMnVVihLDjmsU461w5FXR70JfPXMt+Zsyukc+wRFvuiSz/Hqk2ubGEhjcMOBYBoNYeA2OsPWhaakFL7dMWByry0JbFQNwMhZGFBlGmhE4dK28fWh+QOuUtsnMLz6eirOPuDgbj6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q83DkYiA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q83DkYiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9E6C2BCC6;
	Sun, 17 May 2026 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779033322;
	bh=vuEiq6kXUHmnExqvqbNZrlASQuYXEDFkmYRBJ2KIifA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q83DkYiA7zSDa0jq3uQb/lUCY1fzyOAiE016Lmy4FwGHDLx/oplGf30aaqYpIw17F
	 b6i5AB6evQYdIrl/DadnqHFf5crWLS973Ugt3Y8xzOYxholDqZv99cR2KtBFYNO/Zx
	 3zPXDT33bmxzj4aT1AaNK2Mo2DkBzd7vd/BBnSUZAQO7Jwz7px+WmMGvJbjzq5F5Kb
	 /PkbGLEqw1oJvGMPpxj82AlEh+tuvDJWo5BQ67QjDO4Fo2s4Wv589str4U5Kr68hKe
	 Df+SdS5mQtLfnksdrMSMDT+q5YOw7OxVUD45u728L8IaMS4IPvA85iN6BC0IeN3rpZ
	 e3pYeTawfCH+w==
Date: Sun, 17 May 2026 16:55:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: veml3328: add support for new device
Message-ID: <20260517165514.1bf08426@jic23-huawei>
In-Reply-To: <CALoEA-z5dJLYC_L93hPo5zpgB+yhjH3iOje1V5XgQ1aOPppU=Q@mail.gmail.com>
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
	<20260516-veml3328-v1-2-1d4b663e2fe3@gmail.com>
	<20260517143449.6c30b99f@jic23-huawei>
	<CALoEA-z5dJLYC_L93hPo5zpgB+yhjH3iOje1V5XgQ1aOPppU=Q@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +
> > > +struct veml3328_data {
> > > +     struct regmap *regmap;
> > > +     struct device *dev;  
> > The use of the one embedded in regmap got mentioned already in another review.  
> > > +     struct mutex lock;  
> > All locks need a comment saying what data they are protecting
> > (might well be in the device).
> >
> > Mind you - I'm seeing quite a bit of locking around simple regmap calls.
> > Given there are locks in regmap, you may need to call out if there
> > is a particular readout sequence that must not be interrupted.
> >
> > I'm not immediately seeing one and as such you might not need a local
> > lock.  
> 
> I was on the fence with this one - my understanding was that the locking
> in regmap was just for i2c bus interactions, not actual value read/writes.
> I've no problem with removing it though if I am mistaken.
> 
The regmap calls themselves are all safe against races.
E.g.
 */
int regmap_update_bits_base(struct regmap *map, unsigned int reg,
			    unsigned int mask, unsigned int val,
			    bool *change, bool async, bool force)
{
	int ret;

	map->lock(map->lock_arg);

	map->async = async;

	ret = _regmap_update_bits(map, reg, mask, val, change, force);

	map->async = false;

	map->unlock(map->lock_arg);

	return ret;
}
EXPORT_SYMBOL_GPL(regmap_update_bits_base);

is taking the lock - under the hood probably uses regmap_lock_mutex() but
I haven't checked this specific config.

So you only tend to need your own locking if:
1) read modify write cycles occur that aren't handled by the simple regmap calls.
2) need to maintain consistency between some internal state and a register.
3) need to ensure a sequence of regmap accesses aren't interrupted.

Jonathan
