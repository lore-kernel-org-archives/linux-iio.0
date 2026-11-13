Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534535;
	b=QqP0Cc9QnLpK2Eit6Vh9lPw3z3xGVyrwONqvGVGYZFpFqPUg1VNDvXeNmNnBZkdFPHSZ
	 cI/AP34KpWOoAgaAFAdGv6d9wa1C/BAF9lhQmXhFxNJkCBLvSdSS+0m/PcOqW48wMZO+O
	 67LkT59psPlA8LNtPQXgEXo1fUKqtpzsz1CzsAxCCvUmpa3IJG4nOGN0IfZ4rOxLCzoct
	 8rPW2XJB355PK/RpLZwxht2XzkUb2DcgZ18SzLPFbO808Je+dlRMHMbbm0e1qiEVPqmMr
	 yT79EpT9SggiladHgk8TbwPHhCIj4JpMUm8/CLfYXKClT8vB+dthd5BsagOyvJ261Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534535;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+t2Wz+7xHGJsYmdZFUvkouxudHhMKG8B+4FhaqdWGpM=;
	b=jCo9/U6VydfBeHkjhkbAHkNuQIMMYdA3JqnqSo6+1RcIVmF+dWp1GK2KTB6DLxq3vfN6
	 yWAkJCaB/JOHvK8X3bVg9sXSar1Xmfkocf/Kr1mZxKC04AVpPnS51SPCqVa+IvRM1FiWc
	 C8tI5iiWCPGfuvdUT2c1ZEyz4reyvb29xYh4aXe1DVWMjYbaIsUyBZZy3kLia8iG+y303
	 T4jx5VMOUXxvgD2Uzd8PTVyJH+PaO4YGXootBNXc+adDb1ChXCny1h/VMWzLjm0BEXQGp
	 CZYG3DfciRLjqvUCIOebqmOcBsB7euXOIPnamL+8uPkWgM/xQQBxkepw3LE5i1wiVKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGqKFfR1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95819606A330;
	Fri, 13 Nov 2026 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGqKFfR1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40181F000C7;
	Fri, 13 Nov 2026 01:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794534535;
	bh=+t2Wz+7xHGJsYmdZFUvkouxudHhMKG8B+4FhaqdWGpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RGqKFfR14FqCDbj8hteCgpex08X+i7U9RKSxhx6f1tB3HnkRWrlq7h4Q+9nZ5vizd
	 FRDjlhmzNqKkgNuSqdEEZ7hIAondo41S3G2fZ0tV3Shz5tOEVVxcyhk5jc4lDO0SvQ
	 PWA5rdsuACWmj/ZV4lD+UNVw4OgOPdo+hns0xTnrXTclk3E1XyBzIfNkFaKNBd+CZv
	 AoqdZqojyAJwKI3tG9WTQugOVFSj7Bjmi906+9Sg5inYDxJpphyqd5CIT8quPzbEUA
	 PM9qDViimUSY44BcIxxrE1+egZgRhklNMsHG3HXEvmq215W/e35+LPleUY6Zu70GJy
	 222sozkcYhFLA==
Date: Fri, 13 Nov 2026 01:48:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
 andriy.shevchenko@intel.com
Cc: andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v9 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <20261113014849.06ab464d@jic23-hlaptop>
In-Reply-To: <MW2PR12MB252344E62EC2FDEB8237D5DBA5712@MW2PR12MB2523.namprd12.prod.outlook.com>
References: <avSBP7Ib1dYpu_Ek@ashevche-desk.local>
	<MW2PR12MB252344E62EC2FDEB8237D5DBA5712@MW2PR12MB2523.namprd12.prod.outlook.com>
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

On Wed, 11 Nov 2026 09:16:12 -0600
Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

> > > > Changes in v9:
> > > > - Patch 4
> > > >   - Added comment explaining why we set use_single_read = true
> > > > 
> > > > - Link to v8: https://lore.kernel.org/SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com  
> > > 
> > > I think I gave a tag, why it's not here, please?  
> > 
> > I meant for the patch 4/4.  
> 
> I addressed your comments and then forgot to edit the patch description :(
> Could you give it again under this version, so that it's picked
> up if it's merged?

I snaffled Andy's tag from v8 given clearly he expected it to be here.

Applied to the testing branch of iio.git.

I'll let the bots poke at that for a few days at least before
pushing out as togreg which linux-next picks up.

thanks,

Jonathan
