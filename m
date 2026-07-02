Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053F1C695;
	Thu,  2 Jul 2026 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011412; cv=none; b=Y7MrIG5s/U0tei+0nrW5hkO56dYHLlwf+bjcR51dI00jgI1oRYpBaj/5q0a9SqLJmh/SDKCn7LLa+8/TdbWi4Slk51bFcDTDnxC3wXHRd2jYDBrlB9JUt0DddrxPCIHyAEFSprs4lZQ1hqN//MlFqVSZYUtClfDRYh9FlpfxLZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011412; c=relaxed/simple;
	bh=x7vNEF5cK7EtyMELsFBbWHCLp85HtpM/wv9NO2mcF2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjvlXh+YBKOlu6WWfbn9+f+Y9ZTy2vIwqtGzIcw+djNK6BKfx6w8qqz6bDFWyXNiaHoAlKRCcv9LDpWmItZb2CzrWqh50l3cBAIXX5JkwEEbm5ozQID2Cb8H0VqKWLVtXcrvZvObDyZgbMS41i3XZ2WyQ66Zvuvv36NxxnIev/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUbqSmNj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUbqSmNj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324931F00A3A;
	Thu,  2 Jul 2026 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783011411;
	bh=1Iwe+sVemTiwXQ02gD+XBU2UE7BCp2KoHab4Y8mMj4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JUbqSmNjDalchiapy6QmwPw+BGXAMU7jsca+94+RVXM2C859l4cPQnx2MavvGX0HQ
	 6xbpsGB3+jdvyZp+DMtdZUFp19MMvSJn5YyoV7hIiwwrQrxYBwDDrzcWK+y6Obo+LR
	 I4n2VN37bFxMeOK4r80IcF4CjS9rN61yHezT5tbMj/I674zokVyBAThM8e0wlbzy4u
	 TpEF4hs2Rag+0yUojQhloTyeRnloN5IxtDKMYSIy+NlUkuSDbFRDkyHis+gWAFWyuc
	 WCljdKZWWaBfu9nW9V7ttsulozdezg8xxvH7UlWUNAErMBozDVjgpXdLf0FdHes5Ft
	 gisA0EgOvqXWA==
Date: Thu, 2 Jul 2026 17:56:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Anas Khan <anxkhn28@gmail.com>, Nuno Sa <nuno.sa@analog.com>, Olivier
 Moysan <olivier.moysan@foss.st.com>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix typos in comments
Message-ID: <20260702175646.17081ccb@jic23-huawei>
In-Reply-To: <akZGGzt59mRGMBXH@ashevche-desk.local>
References: <20260702101129.62445-1-anxkhn28@gmail.com>
	<akZGGzt59mRGMBXH@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 14:06:03 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jul 02, 2026 at 03:41:29PM +0530, Anas Khan wrote:
> > Fix several comment typos in industrialio-backend.c: correct "through"
> > in a channel-spec comment, "initiates a process" in the activation
> > comment, and drop a stray apostrophe from "Gets" in two getter
> > kerneldoc comments.  
> 
> Makes sense.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied.

Thanks,

J

