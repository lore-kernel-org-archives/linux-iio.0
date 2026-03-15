Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0935AC14;
	Sun, 15 Mar 2026 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773597917; cv=none; b=BA7KS1ULSkZ9HSRxtI82y0h8R7bEpLGg9ary98PL4iMRUMp53yx8fU8ZcU4j+5hzqvNezgmT/ca1xlV0ika1KanuG0iJlIUBsf3S9zR1SDZBaiqZGWcPnyRfHhBiTXjT48H9jUoqDzQA7ab37KL0uMTr5i0RoJMtRdaAH8miRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773597917; c=relaxed/simple;
	bh=RWalcaxaqTMohZK05+717ZAGrRogfTquskorkutq7dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gi1NPRdjcD7eXa9dQL+GIZKZNFckgixUma1ZYHxgz3BANOcw6WG28GtZeF8Ao9oAzPjtkC6Md2aGKc9xdglu33oDbAr+Ni81wV3lcsx6ZoIQutgFzFyM3B/6jfM86Divoh/HyAFCUfnFDfsTfKNm3XoXNoTW+YTzqIX7P6dEMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6Mko4sa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6Mko4sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3620AC4CEF7;
	Sun, 15 Mar 2026 18:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773597917;
	bh=RWalcaxaqTMohZK05+717ZAGrRogfTquskorkutq7dQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y6Mko4saEGAnHU+b7FDqja1cBrmrWJ6intKUD1eKJmF/i1ubsKcchxytHqev3xyXo
	 38dDQTMVRwDMDzIoEffjPnkGjplNAMEhQ28D6i8VJAeB2XCbPWQAirdUn6niG4iY0W
	 j0L9g8UbK7JfitUhh7ZR3WTMa6LLGxHDrXDxCDRrYty9dOkRm/3nh6wJndLphwbZst
	 aVVo2m52qVs1j0awbXn5sOjxCpgo4pj7zLbXILYmcIHlIhcbVRLze39I9MsxfvZLJb
	 rgXIfOYfei6DS6zP4DSZCSX5Ee9mvfOOSwDhL3s9dlZ8Ew3//V4FbM26txF/Xm+9fc
	 eqHyFswo8Iv/g==
Date: Sun, 15 Mar 2026 18:05:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: ShiHao <i.shihao.999@gmail.com>
Cc: Dhruva Gole <d-gole@ti.com>, andriy.shevchenko@intel.com,
 andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, m-chawdhry@ti.com, daniel.baluta@nxp.com,
 simona.toaca@nxp.com
Subject: Re: [PATCH v4 0/6] iio: fix spelling mistakes in comments
Message-ID: <20260315180511.13674dc6@jic23-huawei>
In-Reply-To: <abappH2DGoqTU82e@fedora>
References: <20260311093933.21333-1-i.shihao.999@gmail.com>
	<20260311101007.gaqcner4fzamyirm@lcpd911>
	<abappH2DGoqTU82e@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 18:14:20 +0530
ShiHao <i.shihao.999@gmail.com> wrote:

> On Wed, Mar 11, 2026 at 03:40:07PM +0530, Dhruva Gole wrote:
> > 
> > I just tried applying this series locally, on top of linux-next tag: next-20260310
> > 
> > Could you please make sure to use git format-patch with the option --base HEAD~N
> > where N is the number of your patches?
> > This will help identify what you used as the base commit for all your
> > changes. Make sure it's usually on top of the latest linux-next.
> > 
> > I also ran checkpatch on them, and saw a bunch of errors and warnings,
> > not sure if you've run it on your end and ensured it's clean?
> >
> > Also, in the changelog, please add links to your previous revisions.
> > This make reviewing things and getting context much easier.
> > Best regards,
> > Dhruva Gole
> > Texas Instruments Incorporated  
> 
> 
> Hi everyone,
> 
> I have a quick question regarding my patch series. I noticed that a 
> similar patch was already submitted and has been accepted, so I removed
> those changes from my series. However, I have added a few additional
> fixes and the series has now grown to about 13 patches. The original
> series had only 6 patches, so I am unsure whether I should send this
> as v5 or resend it as a new series. I would appreciate any guidance.
> I want to avoid creating unnecessary noise on the mailing list.
> 
> Best regards,
> Shi Hao
Hi.

Send it as a v5 and state the above in the cover letter.

Thanks,

Jonathan

> 
> 

