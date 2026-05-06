Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E3478E5B;
	Wed,  6 May 2026 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078232; cv=none; b=gY55xKoP8dzJsJbspZsdhNP6cztIrdhp4PKRJgz8cRbUF6Ub/5I1ZhCXv+XZ7yIRsFT7xkgy4wNd/E6ikY/fiWOby/CJjAFvfEsuVcfSQeZ6Thj8BGzwp+LAcdtw1hhjGkPEj8xjsPuPj1we2699YjYHEZBZ/uHxcmArSXP7scg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078232; c=relaxed/simple;
	bh=62CxnL5h3UKSUFzY7aJctB3qlSrYU79QU65ujNjK1io=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9u3udK1QCBnABBrjbP+JfZDZm7QjpF4E3qZmdeO4XoVpUyYUm34skn3dQrIPXpywI63m8n67VSneurZt7ODVmm+HOLaPZwrJu1CCFO8yLwg2qYcjjxqef5NWgqIe3D0fMQywCDfq/AsiClGTvheZvIkSt2hIUVDfxUvfn28Gzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdzQU3TX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdzQU3TX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4257DC2BCB0;
	Wed,  6 May 2026 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778078231;
	bh=62CxnL5h3UKSUFzY7aJctB3qlSrYU79QU65ujNjK1io=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jdzQU3TXHoAVoojfLcaZWJqEhGZwtxELOer0dZCcJf8EuC7q7pC0acfV0n5pdJi6S
	 84NFHlbv34gUm6S3+m/zRXl3WquABoeXaaT+XmqN2rv6m52XfJcJkeSaaLNNUMndC/
	 1o2tOmRzWhxbGkc0CpaRlmCV1sZFc8STgOaBIjkJrnnkLfIX32CJ+58zct9Wwt6dkz
	 GSOqzgfcP3ck1fPUcr+sQJOWL36IWfHu0EFyKrTkApQSh4m/x9UtlyNPtREXWiVHgt
	 klTFRyS1X3gnstYVJbMj10npBXpRrYqKPRetcs7g81FckAbVoe5pI0X6iQnb9JLpd3
	 ZOnpmM1azEA1Q==
Date: Wed, 6 May 2026 15:37:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
 christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
 kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/9] iio: ssp_sensors: factor out pending list
 add/remove helper(s)
Message-ID: <20260506153700.351fec68@jic23-huawei>
In-Reply-To: <afrvsw4cTU05oV2Q@ashevche-desk.local>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
	<20260426091710.3722035-3-sanjayembedded@gmail.com>
	<20260426150830.7ab41ad3@jic23-huawei>
	<F6B75893-D8A8-4072-BB26-83F630805700@gmail.com>
	<20260505173859.19b79034@jic23-huawei>
	<afrvsw4cTU05oV2Q@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 May 2026 10:37:23 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, May 05, 2026 at 05:38:59PM +0100, Jonathan Cameron wrote:
> > On Sun, 03 May 2026 16:53:27 +0530
> > Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote: =20
> > > On 26 April 2026 7:38:30=E2=80=AFpm IST, Jonathan Cameron <jic23@kern=
el.org> wrote: =20
> > > >On Sun, 26 Apr 2026 14:47:03 +0530
> > > >Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote: =20
>=20
> ...
>=20
> > > >> +	if (msg->length =3D=3D 0)
> > > >> +		return;   =20
> > > >
> > > >I know Andy suggested your bring these into the helpers, but to me
> > > >it's obscuring flow as it looks at the caller like it was added
> > > >to the pending list when it wasn't..  And we end up with multiple
> > > >checks on msg_length where we had one before.
> > > >
> > > >One option would be to have it return a bool to indicate whether
> > > >it was added to the pending list or not.
> > > >
> > > >Andy, would that work for you? =20
>=20
> I don't remember if I answered anything to this, but returning bool is fi=
ne...
>=20
> ...
>=20
> > > If we convert this change to sub-function then suggested use_irq woul=
d be
> > > shifted to sub-function; then how would you suggest to handle that bo=
ol ?
> > > - keep msg->length as it is
> > > - in sub function __ssp_do_transfer(data, msg), should we pass additi=
onal
> > > parameter to bool for further execution? =20
> > Pass in any additional parameters you need. If it becomes too long then=
=20
> > this was a bad idea and you should ignore me ;) =20
>=20
> ...however, the coding style (or some documentation) suggests against bool
> parameters to the functions.
>=20
How much duplication do we actually get if we split it?  So have totally
seperate functions for what would otherwise have been true / false values
of that parameter and pick at the caller?

Maybe that ends up cleaner.  To be honest this needs someone to play around
and see what works out as least hideous.

Jonathan

> > > Or any better alternative to handle both ?
> > >  =20
> > > >Then we only have a simple check on return value from that to decide
> > > >to increment the counter and exit on error. =20
>=20

