Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9641DDE3;
	Tue,  1 Sep 2026 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278439; cv=none; b=m5VMIY38PEFr0pn/Rq9uupWv6CtX5gkYObyS4bpXujLfPQfQN/5DKstJVxTSUfVChG3Jn66Y+abp+FagZYUFQgl7/08DEN0qXcI/CxiaqF7+Fv4k3CBjg95LcUXw6XRuyis+ZybrqpwjS8LiAskOLcrmvymAnI8AeGJhbsXpF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278439; c=relaxed/simple;
	bh=CxI83XN8I4lxseIe9nw0DK8+BxHfKlymmUuLO1j6vBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWX4v2LbLLMHpek2kN+DcU+ymJwhCyzGMzJg6Gj0Eh/nkcNqoFiUDxNw880wwX+p4uV/fgScdC+dgFE+UDQUmYZ062ceYHYEPQjjnxnPOOQ+Pv5LkxobXlrYhEccLaS6fifQx+vu9dQ31yXOwFQvAJftGnGVUAOyluNebZk4VqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjnxvUqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjnxvUqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B4E1F000E9;
	Tue,  1 Sep 2026 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788278437;
	bh=TIKv8E8evR5d2hcE9sikzBcAxzkD4wFQ4y3I6MsdiEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gjnxvUqSqjuy2nPxq+927DQFz0WTfTK8ZJFUQ+LAuXJbyIm/Rf38BAfYpn0JfIxTX
	 cE+ZgPgwgyBbl/trP/XJCVCuykdIuhW8CMh4YS6bVsKvnSc69Vi6DvxB6+sINWKps7
	 NBVps23evqJOnZxe2b/BYCcu1JH7fTkOMUpLHfrPyIQ7ytmz53o+NbIc8FVYV/NqDK
	 P4ujEtGNRdg8n0ZjPaOhkdT3xm9jAK3ob9QrFLKMOZv88yFf9G2fQF7H9EvEIpzBP3
	 kQ9h0qtfYgHcDoR/zMKz8i4KhOjknTxj+9WIyUV0szHF4pQoOlDAW2bURauLTx9Ljx
	 vh2yf4WWvqJ+A==
Date: Tue, 1 Sep 2026 17:00:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: rename stale IIO_DEV_ACQUIRE_ERR reference to
 IIO_DEV_ACQUIRE_FAILED
Message-ID: <20260901170032.3980bd42@jic23-huawei>
In-Reply-To: <DL35HECJMI8L.2J440RRGS0HNB@gmail.com>
References: <20260831-doc_acquire_failed-v1-1-3c8e59c07d18@gmail.com>
	<apVp6vRQmyPi4EQH@ashevche-desk.local>
	<20260831143004.00007913@gmail.com>
	<DL35HECJMI8L.2J440RRGS0HNB@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 15:07:06 +0200
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> On Mon Aug 31, 2026 at 2:30 PM CEST, Joshua Crofts wrote:
> > On Mon, 31 Aug 2026 14:47:54 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >  
> >> On Mon, Aug 31, 2026 at 12:09:09PM +0200, Javier Carrasco wrote:  
> >> > Update the kernel-doc reference left over from an earlier revision
> >> > of the series, before the macro was renamed to IIO_DEV_ACQUIRE_FAILED().  
> >>
> >> I would argue that it might be good to be backported, but who reads documentation?  
> >
> > Only LLMs these days...  
> 
> And at least one human ;)

Applied.  Not backported as at least to humans it should be easy to figure out
what it should be once grep doesn't find any instances of _FAILED() form.

Thanks

Jonathan
