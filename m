Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F974192D8A;
	Wed,  1 Jul 2026 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865001; cv=none; b=FhXlw+YbTBtZevSu1p7l9+JQVltIwSPYf7NQ+ilVH5kTsayet9orNMHRjctzRVeoe1DNyh+X1ICh/lnuyripB59BPEVyTcK6IV+QT01oMN1endsfoGgoKvRsxJStuqF564O9voWgmAUXOfyfp6Jty3GjRXpauJijS7yxmz2uMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865001; c=relaxed/simple;
	bh=2SiaY9a2d15WiR7quMS4lxIfLcg2qmbCWrxZiEK1JBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABuxJZ2KBaGJJfQSMI+wM4OnNcr3619wA/zXnFeFZSiHIeoYzlXTnhMb90eGh/2+pSnFnjhqrvCfXW+rCHbGCXD5CNDcnZJDVC/F5e8yb39sX4sgq3c/oo6dNRPfAljp6x55lxMaRqVvhvLlUFPtEYS0UMAT73cY+jNKycU+BTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2D6lSll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2D6lSll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA8A1F000E9;
	Wed,  1 Jul 2026 00:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865000;
	bh=kgSAwF76Z/mL9dQxxMa3Za1h3O5zncIcNyY8G/itchA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T2D6lSll239DjA9WXLZRRGz9VhEYMwvrxiWRW5BT9wSXrMM8LpkUzt1g2Lb3ELUAq
	 QqfxXA9sLc8NGl3dmZnLYE+5Z1l/hrvQM4un+auaudnWz5JCzc//GpoADQyAyM4/uE
	 +r6Mgj78ncrFJLak3mdgakn65PEVIKWP1eHw9J5I4yTImgC8pAi6OW0HcFDNb7McRs
	 6XL/+Ay9Esfyh4/7sEgPfzlrb7ZNzNGTPR+YHfn0jAuSrPo3HY/tRHX9Ao8JXO2bQL
	 ySUniceoaqgxNvHnfwU8Ib0XhbullnRMCrctM48EjYmvOaUmpkRvynmjEhKyoyCaCQ
	 QG7oPCHWFUP9A==
Date: Wed, 1 Jul 2026 01:16:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Moksh Panicker <mokshpanicker.7@gmail.com>, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH v2 0/2] iio: adc: ad7779: Remove dead code and redundant
 error message
Message-ID: <20260701011635.30f6bedb@jic23-huawei>
In-Reply-To: <20260630145327.00001b9f@gmail.com>
References: <20260628145734.77191-1-mokshpanicker.7@gmail.com>
	<20260628191350.583470a7@systembl0wer>
	<20260630001156.61ef50d9@jic23-huawei>
	<CAK0z5Okxj7r_hdB8xzdkVBX9z4xHyfcv4ZKfkumYHiObCc9tfw@mail.gmail.com>
	<20260630145327.00001b9f@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 14:53:27 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 30 Jun 2026 12:43:04 +0000
> Moksh Panicker <mokshpanicker.7@gmail.com> wrote:
> 
> > Thanks for the feedback, I'll fix the blank line and wait before sending v3.  
> 
> Also, please don't top-post!
> 
Also please don't send replies to say you'll do what was suggested. That info
should be in the change log for the next version (or in the case of the slow
down reflected in slowing down ;)  Replying like was done here just adds noise
to the mailing list.  It's a common mistake for new contributors so don't worry
too much about it being pointed out to you specifically!

I've just sent a note on this to someone else and may be a little
more grumpy than average as I'm about 450 emails behind on linux-iio
and a lot more on other lists!

Jonathan
