Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D3C385D89
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377626; cv=none; b=bLyUAL92TlMcS3AgLG8CX0zOIQBb/FTlBes4MzlUjRx9nrGMpHvzlQmVPSPQ/5hSE1mtAhCHYHvW8DM9FRG0MK3UIt0Hp3c4M/YcFt8LC/L1V2lPGa8BzBCCIuV6gE0kJduglUP+PID0qZTm4tQdn6sFeNyWCjy8aXvGYv3cKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377626; c=relaxed/simple;
	bh=aG9UPb6X3t49TQGKWNh8CixzzbYHvf/dhqIW9MNKXCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvkacCifwjcwIxXiGSOtanroQDU2ATg9aHGzynKYC71bSBn0TaIyzzfX07EABdyXPgFdMWPHzpdA97RH4kmmT/cDIXSfnnEQ4gglG9dracqb7FBD6BmNY2WydOP1ahEOIHoE3m3VQ2dpBSq9uet+d7zHlKiqMGGd9q3CCllPfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdLasqpf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdLasqpf"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so14077155e9.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 01:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782377624; x=1782982424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rOgQcEJt6Q/UXFy+W00eved1xO9DzXrtsP5AvlpEQN4=;
        b=MdLasqpfkOXRRB466ILiGSAwfihYqJyXKtgfkNP9i/GMOs6Xx374FGCX7/yMAPPHEw
         n9XHR6qu7ob3UARi7qiX1eBctc6QHCbQPSDT+irE79FzKu9grfJbbsN5ojtTMWDI5cjt
         axSLYMqdylwbaanqlIHYUY9dEKJOQcmHR1wTj7bAr/miJE6svZ88O0X7WQCBBNv6oBsx
         P0jskw0Kht/LMv7fNnn5NOj5yPEaP0XZQ7YbcbnkD0XLanOU+mJjRHgz2aWQDiLJpmO1
         RNM1FUOWe3WV554YXZ5Jwvyk65CWptz66eRDHZZCZ/k+SVqvUwwK0IQERfXWD6QgmGYi
         ZUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377624; x=1782982424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOgQcEJt6Q/UXFy+W00eved1xO9DzXrtsP5AvlpEQN4=;
        b=k71iqiNgPQBM0C22sSgnxuqZDpnhLdYQDN0d2IVrS1WNOP4TyGFpwja45EnpU2PTcF
         /fx75f5f8Tx2vCE1G5OYeZ5Gz/p2czX8VqHod4SU3gT3DPJc3ekuTG2qbH25VOIe1S5g
         xrfF8wq4MONGpqBryJ7XUQVqOJYx2cHLXypUn/f/IELIcCue6+oIw8q2WJTP6IirjeFA
         KPf5sDYIuWG360KXmNQma2WCZfqlkvm63qZBv6Tn1si78dqAmU+7ix+yH9LR/H/3aFpl
         cxeFanOBsqjzDDWIgbC0A1J0pmHuPvQ8RkxWCKKyMDD+tunHhLAsnS7hPRG7LeCddU7b
         Htqg==
X-Forwarded-Encrypted: i=1; AFNElJ+LExhjoDCWWBedEd0JPW+Gay24ZkQV8xBgd8fjxGanShMF/I+fgolhCXMFQgwPdXvKjGXY5JLQKNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWP+T9VrftNv8HUioRlyHmHXe4WhZy4elv4lmQQJkFCp9kVeRk
	cUZHzvbSbaNzyFLEo1DcrLNTruAYAwyJ2IDyZPJTJUta6xPDGfWWyTeb
X-Gm-Gg: AfdE7ckVv1yeV+ImJeGdSNHNkdmyAtRwtNbnRjfP2Laa0pOEAuIf0XNZM8pdxIdoodv
	NusYz5MtdW4oD6Y75yzeHHzPflXaBcELPuwM7/d9j/Jzcaeiu11fXCJpQVVMWK6taryVUURx+gb
	+JAhd+KWQ3A4VeTdoXgkCz3CIh/ZF7BtuXpIRnOwuseN8DKN5gQjhFYqpXbsT2eSWVr3cMKO809
	dcjQQ53iAp45BUsAWYaguKd1DbooNqybFdZ8iN23ctG2G9GQ6jqkqdheW3Wu0RNBEnKwirjf2Ma
	vA+EX04V2k6EoF9M13D+LFMX4kKm0WycSUheM0DL5CSqBFdPX4FM9qcr0RXrd6USQvzbPupaB+L
	1m1WKzWMOzigBDlI7p6mL1ItmoIG2TEasLWV+32QxdojGkge8X0A/JZIb7v699aJKP7EyUFUR+N
	h0iw==
X-Received: by 2002:a05:600c:c1d7:10b0:492:4667:8c40 with SMTP id 5b1f17b1804b1-492668638c1mr15548305e9.8.1782377623588;
        Thu, 25 Jun 2026 01:53:43 -0700 (PDT)
Received: from nsa ([45.94.208.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49264082426sm58844265e9.9.2026.06.25.01.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:53:43 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:54:46 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com, 
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajzsjhXHzpV2phby@nsa>
References: <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
 <ajlMAijTUHsnOhEQ@SMW015318>
 <ajlR9QiXiBAH4mWH@nsa>
 <ajmAP2nKzi2dPEVx@SMW015318>
 <ajpYvzlHSPiJRvnX@nsa>
 <ajpfmQ6JID5rHLMF@ashevche-desk.local>
 <ajv4NVSmSR_dn9CJ@nsa>
 <ajwKq0CB8sGdvvcO@SMW015318>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajwKq0CB8sGdvvcO@SMW015318>

On Wed, Jun 24, 2026 at 11:49:47AM -0500, Frank Li wrote:
> On Wed, Jun 24, 2026 at 04:33:53PM +0100, Nuno Sá wrote:
> > On Tue, Jun 23, 2026 at 01:27:37PM +0300, Andy Shevchenko wrote:
> > > On Tue, Jun 23, 2026 at 11:14:51AM +0100, Nuno Sá wrote:
> > > > On Mon, Jun 22, 2026 at 01:34:39PM -0500, Frank Li wrote:
> > > > > On Mon, Jun 22, 2026 at 05:09:10PM +0100, Nuno Sá wrote:
> > > > > > On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> > > > > > > On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:
> > >
> > > ...
> > >
> > > > > If support 4Byte, it native supportted any N*4Byte.
> > > > >
> > > > > So needn't bit mask to indicate all support bytes.
> > > >
> > > > > > > each transfer, dma_slave_cfg should set specific bus width requirement.
> > > > > > >
> > > > > > > If memory have requirement for 32bytes, typical cache line length for
> > > > > > > hardwaer coherence transfer, it should use dmaengine_alignment.
> > > > > > >
> > > > > > > So I think only need set min value should be enough if fix pcm_dmaegine.c.
> > > > > >
> > > > > > What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
> > > > > > there... The code seems to use the dma bus width to match against PCM
> > > > > > formats supported and filter only the ones we can support (per dma cap).
> > > > >
> > > > > if cap is one byte, it should support 8, 16, 24, 32, 64
> > > > > if cap is two byte, it should support 16, 32, 64
> > > > > if cap is 4 byte,  it only support 32 and 64.
> > > >
> > > > Well, Now I see your point but not exactly. Because we do have
> > > >
> > > > DMA_SLAVE_BUSWIDTH_3_BYTES
> > > >
> > > > and it might be used by the pcm_dmaengine code,
> > > >
> > > > There are also some controllers that set it. But it looks like all that
> > > > set it also set 1byte.
> > >
> > > But this might be not true for all HW in the world. In previous reply I made
> > > a comparison with MMIO accesses where not all HW that needs 1-byte read can
> > > cope with that. If there is some proof that this is the case when 1-byte
> > > DMA bus implies 3-bytes (or other odd number), I would like to see it.
> >
> > True. I'm also not too keen in making the above assumption and have no
> > proof that it will work for the controllers we support.
> 
> Okay, I think it is fine by use bitmask. suggest change name to
> src_bus_widths,  addr_wdiths is quite confused.

Ack

> 
> And since not much place use it. suggest change all consumers and cleanup
> original u32 src_addr_widths in followup patches.
> 

Alright! Will include all consumers conversion in followups of the
initial patchset!

Thx!
- Nuno Sá

> 
> 
> >
> > - Nuno Sá
> >
> > >
> > > > So your suggestion might still hold and work but I'm not too convinced
> > > > that having the array complicates things that bad when compared with the
> > > > risk of breaking existing code.
> > >
> > > > > Needn't mask each bit.
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >
