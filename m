Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7DE2F1FC9;
	Mon, 29 Jun 2026 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756515; cv=none; b=bT5FyfbdEeI64HafpskpYoBWb7aWG8XEA4ne5UVVZEYiWI5NmOxRrcer3iz1Wh/rDGWVkiMZdA1YWcaatdgEENgxcvPYqwGWWcg4x6JvW6NmbJ+JTTbgWW0zbo+cOS4DYzhOSH6uhhBiG9+8N/QxNoDeG2gl+L6spTivdjoXcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756515; c=relaxed/simple;
	bh=+2z3Kmb3ZaOzmZ1vksFf7oybVJ/EJqBt0T8LN7TbUU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNZRQucBzDLQ321i9mQzr9DYTRyVk4VJRgjzDZJF2E0lGA2pSJlgnhYoz5kngoUD7HLY36sy+SNPwj79qqi3BkxMd986aYHgtt2c+022EXeucPELXxRaB9aVGfbNRW4OFOK+2yLyB26GxGAafE1zjpfAdjLLJHicV/nBKobE/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr7Z9Mm3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr7Z9Mm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F411F000E9;
	Mon, 29 Jun 2026 18:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782756514;
	bh=M11gWjMC29nnRXaIzbq/854Gu2IQm5IrZVsomSvAMdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dr7Z9Mm3bL0tazhOpF8JlDex5a30DXEF6LDvraoQyhrw481XdInDjk3VK/ygsrlD1
	 xG0t0aDO33LZqtzAXIJFKB9BiL7Ny9p9zrWakrf93VQeZwGDDuzygp8pwxA/i16tDS
	 8yqQ6Mxn3xi/I8n/V6iDawR8ZYqH13BDIPtVSXRK5Dr0pOAMhX8mSJ8BIsIee7Fcio
	 VaybNR0v4jYXHFCyZliNkSvQAJ3D49EH1q+EMThoKjqxEeKe2RWnkYnzCWEIIEMpy7
	 AZK3IJCVMJZW0ZIrrYu2kFV3R/dI78yTcOhgw70ulYHyHu5BwmCZQpq8ril9MWgjPj
	 reLTXlpGyusog==
Date: Mon, 29 Jun 2026 19:08:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>, Conall O'Griofa
 <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Update Xilinx AMS driver maintainers
Message-ID: <20260629190830.0d764d7e@jic23-huawei>
In-Reply-To: <0e4fc27a-9bef-4a78-9cc8-4d9c69c87773@amd.com>
References: <20260629140615.213750-1-sai.krishna.potthuri@amd.com>
	<0e4fc27a-9bef-4a78-9cc8-4d9c69c87773@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 16:10:42 +0200
Michal Simek <michal.simek@amd.com> wrote:

> On 6/29/26 16:06, Sai Krishna Potthuri wrote:
> > Salih Erim is no longer with AMD to maintain the Xilinx AMS driver.
> > Replace Salih Erim with Sai Krishna Potthuri in the Xilinx AMS driver
> > MAINTAINERS entry for continued development and maintenance of the driver.
> > 
> > Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> > ---
> > v2:
> > - Replaced Salih Erim with Sai Krishna Potthuri.
> > 
> >   MAINTAINERS | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6b4560681b51..d8591066f182 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -29458,7 +29458,7 @@ F:	include/uapi/linux/dqblk_xfs.h
> >   F:	include/uapi/linux/fsmap.h
> >   
> >   XILINX AMS DRIVER
> > -M:	Salih Erim <salih.erim@amd.com>
> > +M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> >   M:	Conall O'Griofa <conall.ogriofa@amd.com>
> >   L:	linux-iio@vger.kernel.org
> >   S:	Maintained  
> 
> Acked-by: Michal Simek <michal.simek@amd.com>
Applied. I also picked up Conall's tag from v1

Thanks for taking over Sai and thanks to Salih for work
on this driver in the past.

Jonathan

> 
> Thanks,
> Michal

