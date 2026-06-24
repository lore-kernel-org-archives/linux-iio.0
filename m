Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB32F8E94
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315173; cv=none; b=R5zWyoaPVRo4rFSojXxWqO/kLCZxiW0yWTgfLt5pvV2Vun6Grjdg1y/urShoN96Z6ZCit5BJP1mhrHODhZLpYH+i1WSUDmefd3Fjw6XKv7rkGBM+nWa3wiY+PKQMbMWxoBH8xk87jI/KNaMD5h29gif0/6IA0tb02WSix4Ti6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315173; c=relaxed/simple;
	bh=zmaMjgv40gr9Cbe4PP1/xmSyogH/GhfILjqn5Z331oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4jExEXXpHzhJ8qRKRlXLpB5iIlP5gqKA6SdSunyOr80w6Nagy1FtQ4oBmm5C3mq6aUF39dPOf6ciUHtxh0lcu2iEdm862Otee+O3dowe8P16V3apPUXrUlRjV3t6rBYrNA9PUfEquYii+rPfthjFgv2HXiPSvVUD8NGtnDg7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkVTd9sq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkVTd9sq"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45fd464d51fso740878f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782315171; x=1782919971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ezPfHam7P5uRLw1NJIu4UguQk94Etz5IiSadwTXLKSc=;
        b=dkVTd9sqb4bi34C+k5oIGqm8UsEVy4ygNm6mVnAcsttnDzcYOKef4buJhnP3mAVJ0U
         X5seLZszpe0AeMVhfjAndjvez0yLyzyRMesY9mzp7pJPOF28D7dl3COJNJ8xWkcVJCZ2
         ptr8SRL3kYU+xqF/VG2Afll0gWIs5TKGK2qXA+pZhz1sWxasx9xTZKYacPxeqttLbW9/
         8O00R8wY8a7fZ9d8bCUamVfHp6SRKGMEceUq26891N67CfljPB4GF0YwTmP1TSOaXNU2
         zvr55jKNS0U8Vj5B+E3hCwW+KRZNitA8mrTknuv1gXHCqioHYcbxx4xpjfgGFK+POXYh
         2ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782315171; x=1782919971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezPfHam7P5uRLw1NJIu4UguQk94Etz5IiSadwTXLKSc=;
        b=Gth2mUe5/qLTBtEZXy4VfiFlXoyHsxIGI952GX7BBs8ZBWiqPaL+1NZudCf1bHYpXb
         USGgljlnt74NNBpZHFSXV/Ix44VAnqwBB2UVxO/W2WO6PQwX1XqWG4vJxW9fPoLVg5Ed
         wJpkKKwBJxMezJoC1jpHJweLKH5SG6aep+MEq/K5krdAcOjVFBsM6TIn1/yKpwsNFWX3
         UCH3V4CB7cM4M2qQ0v4vUWOw7gm6JPCKzFMbpRAZHTrKUWH/WpHjQkcqEnFIes89pYGl
         big9WF6jtOj1TN3sQxDozcBNQtiz3KkSRuO3PUjK0N34+CJPENKUXQ9UCdJDOitBi9SJ
         HMtQ==
X-Forwarded-Encrypted: i=1; AHgh+RqT/eDP+Q+z3A/X8+1Rano/75R3jvYU9X0ewJZfGKrj+pernHhhJi5uqrHeMNhpuH0ZbGRBmKr5kpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFlTnMWHMM5mLehP9s4gq6YPN05Kz0ouw2G2Q7BpM59N8j1Tjo
	rVHt4OcKG19Ps4n72yQl/QW4aDDIBSK0hm/G4ShCEzUxXsFi3bCLthVy
X-Gm-Gg: AfdE7cn3g7nWGMwQ/BmVITmaIGj7aQfqJMtLLJCMFjB7UfFIUmTv/G9Mbo/jcs2Krng
	69Sort/Yux4/CfH6AnS3OKTgOkoV/hFg4gQqmYp6gmVygACvc1LOgF9NhGmdQblhDVQNwIT6SI1
	RMsSAjvw/qTngUUwTmwPimcPMQzen3L+6nRzakhKtOwlsC8YUmHf8aJV2bwqOdUItrg41b8WrMF
	YkQKVjCzDLJsPGJPIr4NBms4qF4hOFKtieWo1FCWddM3DdthIquXvz2Y6hxsxHpjutnAu2ikACI
	6oQIX2OjmC77OCqPUHqPXYhfmMzyuCW9t5Ob28UzQNzC5rqeOVqg7XxCrY3Zf74O2u/6UB9/22z
	OWcVYEBc5GYPsNau5SNDiKAhA4XB2XkpCdHO82LsunexJ0rJkCVaNPptEWVwspR49f9p/8fKcNu
	xlSNWc
X-Received: by 2002:a05:6000:4305:b0:46c:f1be:2f9e with SMTP id ffacd0b85a97d-46cf1be307bmr2219481f8f.38.1782315170532;
        Wed, 24 Jun 2026 08:32:50 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46caa798f43sm3963188f8f.8.2026.06.24.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 08:32:50 -0700 (PDT)
Date: Wed, 24 Jun 2026 16:33:53 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Frank Li <Frank.li@oss.nxp.com>, nuno.sa@analog.com, 
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajv4NVSmSR_dn9CJ@nsa>
References: <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
 <ajlMAijTUHsnOhEQ@SMW015318>
 <ajlR9QiXiBAH4mWH@nsa>
 <ajmAP2nKzi2dPEVx@SMW015318>
 <ajpYvzlHSPiJRvnX@nsa>
 <ajpfmQ6JID5rHLMF@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajpfmQ6JID5rHLMF@ashevche-desk.local>

On Tue, Jun 23, 2026 at 01:27:37PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 23, 2026 at 11:14:51AM +0100, Nuno Sá wrote:
> > On Mon, Jun 22, 2026 at 01:34:39PM -0500, Frank Li wrote:
> > > On Mon, Jun 22, 2026 at 05:09:10PM +0100, Nuno Sá wrote:
> > > > On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> > > > > On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:
> 
> ...
> 
> > > If support 4Byte, it native supportted any N*4Byte.
> > > 
> > > So needn't bit mask to indicate all support bytes.
> > 
> > > > > each transfer, dma_slave_cfg should set specific bus width requirement.
> > > > >
> > > > > If memory have requirement for 32bytes, typical cache line length for
> > > > > hardwaer coherence transfer, it should use dmaengine_alignment.
> > > > >
> > > > > So I think only need set min value should be enough if fix pcm_dmaegine.c.
> > > >
> > > > What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
> > > > there... The code seems to use the dma bus width to match against PCM
> > > > formats supported and filter only the ones we can support (per dma cap).
> > > 
> > > if cap is one byte, it should support 8, 16, 24, 32, 64
> > > if cap is two byte, it should support 16, 32, 64
> > > if cap is 4 byte,  it only support 32 and 64.
> > 
> > Well, Now I see your point but not exactly. Because we do have
> > 
> > DMA_SLAVE_BUSWIDTH_3_BYTES
> > 
> > and it might be used by the pcm_dmaengine code,
> > 
> > There are also some controllers that set it. But it looks like all that
> > set it also set 1byte.
> 
> But this might be not true for all HW in the world. In previous reply I made
> a comparison with MMIO accesses where not all HW that needs 1-byte read can
> cope with that. If there is some proof that this is the case when 1-byte
> DMA bus implies 3-bytes (or other odd number), I would like to see it.

True. I'm also not too keen in making the above assumption and have no
proof that it will work for the controllers we support.

- Nuno Sá

> 
> > So your suggestion might still hold and work but I'm not too convinced
> > that having the array complicates things that bad when compared with the
> > risk of breaking existing code.
> 
> > > Needn't mask each bit.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
