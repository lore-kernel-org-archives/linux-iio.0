Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634944210F
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 23:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887660; cv=none; b=s/bb+UWPxGgakPVOC3OaHdR9PzYBgb3I4HV/50N2Om6le7KKRSSaCBTB8paOzUf64G0AOBZAYO6QYAULyH/luqPqbHdwu99TxFUm29tAc9HyW+bZefvbYMqh0fJTXvfpAVrPuEZf6QYdQnndJ/U8p2rBmLUbu7skZpUaJCausU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887660; c=relaxed/simple;
	bh=f1a8e+j7vjoBpFbvvGeSwVtweT4b83+zdyVNtsp/W6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqNLXF7g/pFA3SeAOB70P7i01qZkLqHlfmOkQuye4SZG9DAF4wF+0U96ZtZD/2sM8dP6Imk6tNGPEYCafmBotXNUwn+/sWoed0uGq81yzq9/yWkDtCFSMICuhqmcntUwfeA3KWALeRnqEmpWurRu3mX3FlrFNrufl77nNUDrd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzokVbdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzokVbdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B071F000E9;
	Tue,  4 Aug 2026 23:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887659;
	bh=6JSVW+riHjeII8SqQmG2Or3smecc/sAkSXIauTJEMQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IzokVbdugYj51q4GMN7e68tm0nacOgpG1q+5aDwqM4SERdta0GDarDynRAcj/TKjK
	 0NxncRIr847VhRS2I4nj5m1rEHIviGMYkFIbqM0NbRi8BLqBPWhnEcYe2A1knzkftF
	 RDwP0jH+zhUdLMFcmRQYxqUfykhfyTg3hVqCn1i795Ga7hd9+IPNSwxeUsjhkYBQPQ
	 IIMpbmBbAXMgSW6oQPflvi9STGOAjXT8GkTpjxB7zmQ8A99KVJ288xPjLUaI5mpHPq
	 fdV9ftHw57dqDA1NcKgNOD88u/t49j4VIwgReCAdwUzNFKyhzxw9Vcce+bvCirpn3A
	 okWzpQwhH3DkA==
Date: Wed, 5 Aug 2026 00:54:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: linux-iio@vger.kernel.org, Jinseob Kim <kimjinseob88@gmail.com>, Sanjay
 Chitroda <sanjayembeddedse@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, sashiko-bot@kernel.org, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v2] iio: buffer: Ensure bounce buffer used for unaligned
 case is zeroed.
Message-ID: <20260805005412.08c879f4@jic23-huawei>
In-Reply-To: <20260803112637.000045af@gmail.com>
References: <20260803012224.219493-1-jic23@kernel.org>
	<20260803112637.000045af@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 11:26:37 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon,  3 Aug 2026 02:22:24 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > 
> > iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
> > to userspace if the data passed in is not a multiple of 8 bytes and the
> > timestamp is enabled. Specify __GFP_ZERO for the devm_krealloc()
> > to ensure any extra space is cleared.
> > 
> > Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260529121005.1470-1-kimjinseob88%40gmail.com
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > ---  
> 
> LGTM, but shouldn't this be a V3 as the previous patch was a V2?
> I got confused for a bit...

Oops. Indeed. Fat fingered.

> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 


