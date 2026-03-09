Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101B3CD8CF;
	Mon,  9 Mar 2026 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084747; cv=none; b=YX1AEAxQodSj5V5i6Kwmk6CRdvU2D6pM6Yjlj5kC11doeIEYRaAjO1J9ZP1ZCidCZb66mCLLkswN7NhdcSI8rU2hhuyT+TTtC4jYo0sh079U5HTfR2KSALi/gVDGWftZsH+BK+m+CrC0udUCrdn8sVA+MVTZ/1cS7dfD674DrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084747; c=relaxed/simple;
	bh=imtx4QHotDzs0cR+51OtqmKqWMB0xnjlLSdI5ZdM5dw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2tNz4tcsXT33SKP9u/HUyop7FM6Cz8fN6eWBoIMS0TSZgQPGNMYAaEo7zqaA8uo7/0RVzOgr2q96mfFm8//54CoE81XnvAaCKFjWDH6ixqnIq0SXa/i9RLoaTWEsTi2zOb7IoC8a5KVXd2YEzWCDXi8GAWPWdD3PMJT9pJ+ybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St+Oosnw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St+Oosnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E432C4CEF7;
	Mon,  9 Mar 2026 19:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773084747;
	bh=imtx4QHotDzs0cR+51OtqmKqWMB0xnjlLSdI5ZdM5dw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=St+OosnwLq2YkK3dS2lwko2ntd+YHaq2QKy+wsZVs7w/244/vYLsN2NxERVp5j9me
	 WEljpUmpwSmH/9k8c8pSsBoG67TC0BeFQAZ2ORdWf50FrGERhL7YB+zJnpYV3GeY4W
	 UFI5A0CiEjgq64EEljIIK63DEzYM2eZcLMStQXUeJ3sJisrjigjdamtwD//ieubzhk
	 uIP0smJRiYO0Hcy9qTCDa9aS8I7SWe55AVwatAwmveAXb8sk2IndiwpmjRjkMvm3Bz
	 +O5Qaskq6VsclFTWSxdJuPj4nLRKUl8NtIrRCvcP/BcvgKjhb6VdEZVtpYFpvXmsjo
	 MruifiutVvf7Q==
Date: Mon, 9 Mar 2026 19:32:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Shi Hao <i.shihao.999@gmail.com>, andy@kernel.org,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
 mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v3 4/6] iio: cdc: fix spelling mistakes in comments
Message-ID: <20260309193217.4491cebb@jic23-huawei>
In-Reply-To: <aa6yZIx2MlIC08Rr@ashevche-desk.local>
References: <20260309104513.40359-1-i.shihao.999@gmail.com>
	<20260309104513.40359-5-i.shihao.999@gmail.com>
	<aa6yZIx2MlIC08Rr@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Mar 2026 13:43:32 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 09, 2026 at 04:15:11PM +0530, Shi Hao wrote:
> > fix incorrect spelling in comments
> > 
> > - becaue -> because
> > - reenable -> re-enable
> > - irq's -> IRQs  
> 
> Same comment as per patch 6.
> 
> ...
> 
> > -		/* reenable any irq's we disabled whilst changing mode */
> > +		/* re-enable any IRQs we disabled while changing mode */  
> 
> 'whilst' is okay, no?

There are bonus points for British English ;)


> 

