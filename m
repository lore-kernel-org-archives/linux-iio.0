Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090724;
	b=LGsESpZTfqYd8FxRpySuLdwJVuFCA7CQEskan5A1uDyTgbTIW0OnHjCzXDDvc0JSA24B
	 X/q4ap8YKz7kIeX8/Jrg2gau329H/kZi1KZPlEa2ZKgnT168uNN/5kOzR70UUunv9xB9s
	 ZnbVuScH/aMuiuqbvcDUvXJVDZInKWACkY8nUJXrS/de2srMEghTBqCfNjNqmZ0DGh5Np
	 eHFZKpFvlYIqqn7vnrgff7jsDXxCXSJ2MOY6XQf41y9BeZMwzARAtG9PumuftsWbs2Hah
	 xQ4BLDbhsZaOyb84Iw6J2ve6eCrLG9tW8FPqDnM8Mcz8bCnmPALqH+BBbh8gxswPqsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090724;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5KMHHkzr0VrWngWsjnMLo1w51qe8S4fGQdolu2SQuO4=;
	b=PHtmjtc4HCWdbIp0FP+RMIG7NI8idR0eOy6/ci04lCXG0u+3mQDR92xQ8iF/8JiGSAgp
	 N3iD4zi5mYxVNaCQgAlbly/5P1woOagYQHRfA0DufdKOmFpSNVvt6kuXDoGHFW22b3h1I
	 MC88hL4blkLhheyR9EuvT6Bo9+CyIyQ9gLOdeaVh91KDmUIWnjoADGsI9h0jPvN9Wbu2H
	 r79zCKt5dUiLXTFsGqt8dNyupCRJZX6i45DzPcS5MPjeaFTTdOI4TLeyYOMmNg2IK5luO
	 OD00eumcEL4XOsMKWcFD6i3er9UI4XdfsCqGku2mdstvFs0YOvYKkrRoW7krfe7EPoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OwxhDpva;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD4606A326;
	Sat,  7 Nov 2026 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OwxhDpva
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152B91F0089F;
	Sat,  7 Nov 2026 22:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090723;
	bh=5KMHHkzr0VrWngWsjnMLo1w51qe8S4fGQdolu2SQuO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OwxhDpva3J+9FWhxhiI/B455DDEj+6L0o1HyPtEKO6nsUvHWRafl6zGPrfbtyNzwF
	 k/hDZyedVKqCEWscPg/sBuMU9SvbGSAWemT0rTTK9ehUNYG63FCt3BlJH1YLOwyk9Z
	 Q4+wsi9kR8KxAql11d6H0yfWaVj1i9MsexVF8FWongIkUJKiiEbzKI4TwMuwB988pj
	 XKyBQjgDDF09qo0bwj7SpiHpEMp7ok8eA0S4FnOT6WhzmxRA2o37UfHDM7+kZc52tm
	 9R0z6v158Voqv41KfdUFFoqJom295YFMTbW4Fft8KMy+2Vz+ODmdeF62chB3ayORtV
	 8kk77Qy1ovIig==
Date: Sat, 7 Nov 2026 22:31:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Maria Sheikh <mariasheikh812@gmail.com>, outreachy@lists.linux.dev,
 nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 andy@kernel.org, gregkh@linuxfoundation.org, linux@analog.com,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: addac: adt7316: return 0 in
 _adt7316_store_enabled
Message-ID: <20261107223156.7d64b095@jic23-hlaptop>
In-Reply-To: <20261104090008.00002b25@gmail.com>
References: <20261104041237.7978-1-mariasheikh812@gmail.com>
	<20261104090008.00002b25@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Nov 2026 09:00:08 +0100
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed,  4 Nov 2026 09:10:45 +0500
> Maria Sheikh <mariasheikh812@gmail.com> wrote:
> 
> > _adt7316_store_enabled() writes the config register and returns -EIO if
> > the write fails. When execution reaches the final "return ret;", the
> > write has succeeded, so ret is always 0. Return 0 directly to make the
> > success path obvious.
> > 
> > Found with cppcheck (identicalConditionAfterEarlyExit). All callers
> > either check for a negative return value or pass it through, so
> > behavior does not change.
> > 
> > Compile-tested with W=1. The disassembly of adt7316.o is identical
> > before and after this change.  
> 
> I'd move the testing info below the ---, as it's only compile tested.
> No need to resend however, this can be fixed up when applying.
> 
Done whilst applying.

Applied to the testing branch of iio.git

thanks,

Jonathan

> Reviewed-by: Joshua Crofts <crofts@kernel.org>
> 
