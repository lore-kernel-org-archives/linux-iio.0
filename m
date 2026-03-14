Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8B2459C5;
	Sat, 14 Mar 2026 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773490315; cv=none; b=q7H29DiTKq40NFGlRgW4TF2rWSdMbBLuRxQLAg5i3znVKcXk8K0scL5GYxvurcCC5wF/UBBfvBwg68JgkzLRdaxm+Ps+HVUHd8TJ6/46ftJykJD3d+GK93XQoISfV5hxvWAJLoVS1LPPqtBaEuZ1UctpTNDzwjafnkzMKSV7N0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773490315; c=relaxed/simple;
	bh=Pxs4FUzqu1vZ76/dN5s5F5pUTQYJKl8R62jaNxm/Zzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2CSIvoIY0o3uJi82WWcrlsWNlOmBXzoNCTF5FtMl9PDjXJ+76r8UGOskZ7NJJe97OCrBX5GK0c96WfQEzvOQH0vP3LMSnzcMAEZwtxlc8xMRqSA7v155Du8mZo48899V430hcJXuTHcRFDwOISfbCi4W/zn2W9hGpzWFwSV8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vA3R9zBM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vA3R9zBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1CDC116C6;
	Sat, 14 Mar 2026 12:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773490315;
	bh=Pxs4FUzqu1vZ76/dN5s5F5pUTQYJKl8R62jaNxm/Zzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vA3R9zBMgCVg9Xa8IjibBRTW5i3O6fRxwWqtTWCbk8exndm6Rt0FWZCpNuv7DF07X
	 3PzCNwd45gACN00CUEVNpEHkDdUndXscShy0xalp/dCYdymzjys+P2E2B00FTknp/q
	 1vLkalo9sfm4yNizFvtT24mnLvDYddRd/N3GiNWOjtjYRRNMZ2cmAssx+gCc3L7k8C
	 Xz99wgTkva6mdClfXBTljI+A4VSFne7v2HdRIkxbWeEbjFqyu54D6j7r3FPas5C0UX
	 4jaenEy8p7qPUWMKZrDCQvmUNQ6sdN1yR6eA58ax4MYOh68GllbgIRfGWScDe77ri2
	 OHXZ9hhLvsXEQ==
Date: Sat, 14 Mar 2026 12:11:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: max1363: Reformat enum and array
 initializers
Message-ID: <20260314121143.1b1b34a7@jic23-huawei>
In-Reply-To: <aa3ZeBGgvylPqAAr@ashevche-desk.local>
References: <20260307071555.14683-2-giorgitchankvetadze1997@gmail.com>
	<aa3ZeBGgvylPqAAr@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Mar 2026 22:18:00 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Mar 07, 2026 at 11:15:56AM +0400, Giorgi Tchankvetadze wrote:
> > Reformat the device enum so each entry is on its own line and add a
> > trailing comma to the final enumerator. Also reformat the nearby monitor
> > speeds array for consistency.
> > 
> > No functional change.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Tah. Added and fresh tree pushed out.



