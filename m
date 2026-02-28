Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC743E4AB;
	Sat, 28 Feb 2026 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772284431; cv=none; b=pd9dRHLCUPnQktOL2yvk6wz/2YugvZCYKzgJDhx97qHd9BRhG2F0TCP96PykLbzUlXpsLpP/Qd4NsGwpykmYno/Y63WiavQv8rCCLBT800OMDnrR7BT3Pmzy01gRWE1RtQ1GV0QbDf3B/L6UnlRoalt5jE7JrWrshCtFb92QyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772284431; c=relaxed/simple;
	bh=C2co0zaqZkyUwBDaRHwsjSmehY5ZmT4y7h+mubJeXbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3FSoTOKzI2eUGPrJR/PGHsEHoUDGcNZGABTLfoyExR73f4+ZlgER/KLx9PnJQzkt2M55Zr/lCGx6B4/wD9FniRFP59vMwZxyJ7w/jEC2ykLDJ/+a4amn2ekb52egGG3Rw6jL89F9y8XmHUc6JfFi3YLNIalSzGDg1fbvSnC40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUrnJ4Yd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUrnJ4Yd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C573C116D0;
	Sat, 28 Feb 2026 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772284431;
	bh=C2co0zaqZkyUwBDaRHwsjSmehY5ZmT4y7h+mubJeXbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IUrnJ4YdTyWvxwHjzfSK0SreYIeBTHqOBNJhUskYTKz8rI7CIREoI8qUjbreoWN/l
	 +m1YiUTCJw6RKAIdHVEPX4wOLRO2u7PQdtqA12wSRnaKqI2RhSVZsQXZtvmadyhhON
	 NiDmt2xABiKrcpuSkUDvnYCnf26aMoWA4OXYBi4mxQsksNqTXwBfBBOrutUg+M12DR
	 wY8TGYXf33tdYDOsU4LUYnS1G+HPHfS5rI1Qn3umsbFDXyvXUSdA+MHE2ZZs31RKmA
	 w0og07I3oPCN3vGP4nIvPvZaLV2KB7uXItCboPcS2K+Y56Tw00hoIWgsRC+eWfyRyE
	 rXHzVzx++xsQA==
Date: Sat, 28 Feb 2026 13:13:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: tsl2772: fix all kernel-doc warnings
Message-ID: <20260228131343.6be72f76@jic23-huawei>
In-Reply-To: <aZ_-pVTbTUkByPIJ@smile.fi.intel.com>
References: <20260226051258.555019-1-rdunlap@infradead.org>
	<aZ_-pVTbTUkByPIJ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 10:04:53 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Feb 25, 2026 at 09:12:57PM -0800, Randy Dunlap wrote:
> > Use the correct kernel-doc notation for struct members to eliminate
> > kernel-doc warnings:
> > 
> > Warning: include/linux/platform_data/tsl2772.h:88 struct member
> >  'prox_diode' not described in 'tsl2772_settings'
> > Warning: include/linux/platform_data/tsl2772.h:88 struct member
> >  'prox_power' not described in 'tsl2772_settings'  
> 
> Hmm... I do not see any of the user of this header file.
> Have you checked if these values are even used?
> Perhaps we can simply kill all this?
> 
> But if Jonathan wants to take this as a quick fix to make less
> warnings appear effective immediately I'm fine with the change
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
I've picked it up because even if we do rip out platform data support
it's likely the structures will remain and then we'll want them
to have correctly formatted docs

So applied

Thanks,

Jonathan

> 


