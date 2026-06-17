Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A94418F0
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705903; cv=none; b=A6TtV1uGk3qzAGwAuJpiOsoHHoCwJLmgT8qRMCQPMaxmbi/pt3kX6qZz/YDNepXUbfXBdHdZZ+B8FofSadpgVUpTNOxI57eHpevCHV6xK+0deF+9cnFLJXjLfPnOQNQrWPYqDX+/+Lkm6c25AGDYLGJYF+k1o2Qp/7Q3glSQO/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705903; c=relaxed/simple;
	bh=sA+Tle1vs414zE4TCmYbF75Vdjowlx7Ma0delr9FXpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHUNUqvm6R4WPck+H/TvfnhEEmdzAV56wiTSxgbabpikyAeYP3uf+FGEDuIhCc/TiQR7RknVij5HDEKsDCTlkYfxZ31jVIZnoBFtCifa0W5orDsEJGu/ZNeMBmgIi4bNldj7mtT6Z5mevB4Sp4nlv6SlrsqOpuIb6aPrtyiRlOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxJqk1gg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxJqk1gg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so61501105e9.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 07:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781705900; x=1782310700; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cQSROIE/nRw8mnMESq2FVi6xdwggcJcKAlPZBkdjBkU=;
        b=nxJqk1gg1IBm8sEPQ7J9m232EoQryIGgOJlkmTp3wI5WUw3Hi0cQmRkGahVfT/aN4Y
         WqEVyI3RFX1C3RFmEwmakQXt+lapvhpL31BZDMWrxwOFt9bD8O0bH3z29kAN9a9Gd+9X
         NBLguU/UhPIA7EdzXqpLvQ2r+cgoSVTcB1WAzjeE5RAEbQedHusF9p8VzgEnA+z99ngH
         x1YC06xaOM7nbaASwMov4HfQwrApmCBQl65gtfAe8DnZmwN1mCSxL6Zf2vwiAeuGo5zY
         aKHsDk601OcwYJx0O42b/sF2D2j0bkDUpYqfJwREKKUDx5rFjXjjDmnnJGCkqdvd0uon
         vMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781705900; x=1782310700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQSROIE/nRw8mnMESq2FVi6xdwggcJcKAlPZBkdjBkU=;
        b=KiqcO0R7EB7S5W0KzB3GUPC104GpyAhB4ZzAqSS/E2P975n2Ql3bOnVtn61GCt/Yz4
         vjCUPitswLmKrJE6W6+eLSPMxPs+3P6y5FixOmf76GJAhzVKwMgD7IxYi0koUTu1gWnU
         KzQMZFG6kpSTIake9xrVZdmRHbMbB+X64Mucr2v0xNDmKwbXw9wClM+FgNvQzgYft33i
         oCJVLISMtkyBxfiFOpgBGCcrhv8iYLGoqnCUvCB1IuewhTgNeGjJEBQqouD7VW59MRAy
         VbPDL5Wnv7VgWGmfy5yeK4N8eKPAxJ0Tzg8Cpuj7sWkyIKKrv+6RJxlM6oq/LF/sg5zu
         Ex4w==
X-Forwarded-Encrypted: i=1; AFNElJ+jw+VqsdNICVj/PhFhwqwmhcVygBRn9LFJ7DWt7avDgvss4MfmnhOwunZLHEhnqQLaTKFYK0oNDl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKbjXLcDowzgT0H5VeJOkruqQj33PI8b463ofZRf/7t+DO8lf9
	7RpISuwuIHBpWfiMIuNKWKvovz6tH0tjRfaewMZeon2iyPEUKp0fOTgR
X-Gm-Gg: Acq92OElmORUe6izVVQbRKcFofDxZndRsk0oPIxQq7+mvwhfYOeQwqkpqaHwT2Rkbgv
	cA+yFIXDL/+gtHzPi5gu/w+5Fz5/U5IylwoX77tE0mAWbwalCwDumW6QjR8X4OmI9we/q/Zpt31
	Ep+8zYxM7kQV4aA2l817ptDnoC/3+Tirf1YUpzJJj5kgBgIcS6iCFe9NSKS5MDLGYKbYsAlJIwt
	B+f0e3mBAgaLQ82WUOmewh2jj0ritZH5bPAOR8bdy3yLW90xvL6Mi0kacMulR5cM15DqCEbTnUf
	c575ukobi9Pdw3RjDIj1889/66+CcXp4+WgPN5Ncq1qDbDQl4o+mnUhl5Mz74U2PDIgHaZkL5VM
	MZBNnfcpYx/norB61cjLRaaw+7lZ6oCluOmEDQMyoV0I8GdYxuC1sOQgOpKTdZCwp+K37vufs+v
	XtjY+M
X-Received: by 2002:a05:600c:4e02:b0:490:c2a3:1781 with SMTP id 5b1f17b1804b1-492333f7765mr73033755e9.34.1781705899755;
        Wed, 17 Jun 2026 07:18:19 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa97a07sm287081775e9.14.2026.06.17.07.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:18:19 -0700 (PDT)
Date: Wed, 17 Jun 2026 15:19:20 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org, 
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 0/3] dmaengine: Support address bus widths of 32
 bytes and above
Message-ID: <ajKqOaDcmGbSSap1@nsa>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <ajJvouBANqhVaHXJ@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajJvouBANqhVaHXJ@ashevche-desk.local>

On Wed, Jun 17, 2026 at 12:57:54PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 04:40:51PM +0100, Nuno Sá via B4 Relay wrote:
> > The DMA engine slave capabilities advertise the supported source and
> > destination bus widths in src_addr_widths / dst_addr_widths. These are
> > plain u32 bitmasks where a set bit's position equals the corresponding
> > enum dma_slave_buswidth value, e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets
> > bit 4.
> > 
> > The consequence is that widths of 32 bytes and above cannot be
> > represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
> > 32, 64 and 128, which simply do not fit in a u32. Hardware with wider
> > data paths is becoming common, so we need a representation that can
> > express these widths while still using enum dma_slave_buswidth.
> > 
> > This series switches the masks to bitmaps that span the full enum
> > range. Because there are many producers (DMA controllers) and a number
> > of consumers spread across the tree, converting everything in one go is
> > not realistic. To allow an incremental migration, the legacy u32 fields
> > are kept alongside the new bitmaps:
> > 
> > - producers set the bitmap via the new dma_set_{src,dst}_addr_mask()
> > helpers, which also mirror the low 32 bits back into the legacy u32;
> > - legacy producers that still assign the u32 directly keep working, and
> > dma_get_slave_caps() folds such a u32 into the bitmap it returns, so
> > new consumers always see a complete bitmap;
> > - consumers can read either the legacy u32 or the new bitmap during the
> > transition.
> > 
> > The axi-dmac controller and the IIO dmaengine buffer are converted as
> > examples of a producer and a consumer. And this actually fixes a very
> > open coded path to undefined behavior in the axi-dmac driver and
> > possibly others.
> > 
> > The end goal is to convert every producer and consumer, then drop the
> > legacy u32 src/dst_addr_widths fields and rename the *_mask members.
> > I cannot commit to a timeline for that conversion (it touches a lot of
> > drivers across several subsystems), but I do intend to see it through.
> > 
> > Sending as RFC mainly to agree on the approach!
> 
> I have another idea. Why not having 8-bit mask for power-of-two and 8-bit mask
> for non-standard ones?
> 
> So, u8 power_of_2_mask represents the respective sizes directly as ORed values
> and u8 non_standard_mask (only to cover 3, 5, 6, and 7) does the original
> approach for it, id est ORed BIT():s of the sizes? And yes, I understand that
> it's not so KISS as above from data type point of view, but I think wei should
> never need to have a heavy bitmap() API calls just for them.

Well, that looks like much more disruptive than what we have now. Might
also make the transition not so simple. I'm also not too worried about
the heavy bitmap() as I don't think we need to handle this at any
fastpath. I think this is handled either in probe or at some preparatory
step, so not sure the churn of not doing it simpler is justifiable.

So personally, I'm not that keen in changing the approach unless Vinod
or Frank really ask for it.

- Nuno Sá

> 
> The whole exercise seems due to DMA_SLAVE_BUSWIDTH_3_BYTES. and we have less
> than dozen drivers that use it.
> 
> > I'm also not sure if the dma_slave_caps_get_{src,dst}_width_min() accessors
> > are worth having? Their purpose is purely to keep consumers from touching
> > the representation directly, so that the eventual u32 removal + mask
> > rename is a no-op for consumers. The alternative is to let consumers use
> > the bitmap directly (find_first_bit()/test_bit()/etc.) and just delete the
> > u32 members at the end. I mean, now we do have a bitmask so the _mask
> > suffix can of makes sense.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
