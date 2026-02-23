Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F905331200;
	Mon, 23 Feb 2026 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881498; cv=none; b=Qbv6dpXc3MUkz+YWRc7JfaX6MASZD9fUc2YzGtfoTnPTe87SMv3ytO3JKklvF7o16LJxPD2lm9nhNz8ofCS0hhv61dgrUMfMA9DBz53zWFdFBKJ8cUjQLOBN7qIJ6Y6/AjXKy6kvYiNl+8ZDIaNcg0Prl/Y7g9ZH+0N8wFO+nnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881498; c=relaxed/simple;
	bh=kmDwqq82f60vdECvT1e1GdFjGynZ2MW+gChhpxU70B4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUpF9O8OcRYn05owszK00sdzo8JKAorVNpX5jICxo8k/ogQMl/31/zqC66HdzFprqlqKI9RvFXr2DEYoAylxvnn1ue3hwVBOk8exl1j5BpanAAFvyryP/s4iO0GaP4vNtOz7h8n339AHfvyR6q2mXfkvVVshbXaUeyMOxk7nU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASldDNLc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASldDNLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B6BC116C6;
	Mon, 23 Feb 2026 21:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771881498;
	bh=kmDwqq82f60vdECvT1e1GdFjGynZ2MW+gChhpxU70B4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ASldDNLc2U0yHprc/neX3ibMKC8olY53bWGgk8C4mYuPnjwDCnn/g+y1H0OpctulK
	 2qswpwfJzLNuSgP+qW0aJZP4QrizVDcp63sAZMp0TvzSFLSgGyGyHSs+5ii4On13IP
	 RhNWBXPjd9q4bybKAXwnn9e5vosIzFIr+sFn7OPTdoLDx863oRSdlXDUffq2SksBvU
	 KJv5lmDxxqTH96MonlcJ/2WMKaXgeXjxVoQ8Ivlns+qYpshCKMPJ6so91fw8AYdvOj
	 ksWrNd4C6f9ookpW0wf8DFoTHzQdYy7Nl6JgKM/uppXA5HJbiBsJlmtGfRIaireKLe
	 Exhv7Y9BVrs1A==
Date: Mon, 23 Feb 2026 21:18:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] General clean up and bug fixes
Message-ID: <20260223211810.63ecc189@jic23-huawei>
In-Reply-To: <aZxFSoTwIpDKNU4N@smile.fi.intel.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
	<aZxFDIaOiqSqAbd9@smile.fi.intel.com>
	<aZxFSoTwIpDKNU4N@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 14:17:14 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Feb 23, 2026 at 02:16:17PM +0200, Andy Shevchenko wrote:
> > On Sun, Feb 22, 2026 at 09:40:10PM -0600, Ethan Tidmore wrote:  
> > > This series performs a general cleanup of the gp2ap020a00f IIO driver.
> > > 
> > > It integrates my original work switching to the guard() cleanup handler,
> > > fixing a signedness warning from Smatch, an error swallow bug originally
> > > spotted by Andy Shevchenko which I expanded to cover both buffer setup
> > > functions and general cleanups written by Andy Shevchenko [1].  
> 
> ...
> 
> > > v5:
> > > - Patch 1: Integrate some of Andy Shevchenko's changes.
> > > - Patch 4: Split patch up as requested by Andy Shevchenko.
> > > - Patch 5: Split this patch from the patch number 4, to keep bug fix
> > >   separate from style fix.  
> > 
> > Jonathan, this version is good to go in my opinion except patch 6
> > ("iio: light: gp2ap020a00f: Fix possible error swallow").
> > 
> > Ethan, do *not* send a new version until we decide what to do with patch 6,
> > and actually the rest may be applied by Jonathan if he is okay with them.  
> 
> It's patch 5, sorry for the confusion.

I tweaked it and applied the series to the testing branch of iio.git

thanks!

Jonathan

> 

