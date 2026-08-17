Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5070218ADD;
	Mon, 17 Aug 2026 01:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786930664; cv=none; b=no/BPwHOtp7RAtyJTjUR5mjV2Bd5k2LB9clJmjdlN4GfdWAqL3KnVQgHv31nu95Phq31LBrVjkk1qr0lEd1CzShqaaZGVFdHOnZuengAhDpoDSIQdhtu+401aBUZC0XvN51crjuR5loEnM9INH4K349EcvpEQtMNbw2Lk0HiFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786930664; c=relaxed/simple;
	bh=ONEyWe6j7MWfljV17Ucl4DKYC4laQx7+OLZdfFzwQC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoP0fW7InhjxFjsd3HST1Nsn0+jQzeIALRUJixCcclSMfY+6Af/w+aXBvnY0JU3oTPIodUWXxMZ7Pq9oUC40LTvCeVAlTC7WY7PssUTqjscCPIsEWOW6HH3ZFfFmpsuXfENZpjEM9LIZZ/0V/BSsd1YwPWpv5z1nPQjAJKTRcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtqDrcUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtqDrcUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE821F000E9;
	Mon, 17 Aug 2026 01:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786930663;
	bh=q8WHBeZfF7Ni4KTJBY2NpfsHj3T65p9LXXPfS9xaRw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NtqDrcUxlh/MW/358rKetbIzDxbAHr4q2Z4XIi/Scq3C4oVntzyPEsng9Og8Eo55J
	 vL0duRfWkC8TZUSgobJ/TrBrmQbwsYcIYg/cixkNpc/KU3a2L/QQ7+qdkSP5qyiONJ
	 DkAVRqo1ONOzrj9KAi2eVIkrnLMltE0/ozdOmufDRbU9dT3A4wgwIfwVOeJvUONK87
	 tEx0Mwi28Ez7Z2Lgjg9ppS/1quELsCQctl2iX+n2YZwq1Tn4OlBgmqlYM4awELWUj2
	 9cALG2GCjTiuUO5Azgx84tR9/C+nkFF0yjcOinUt12fk3kYtDQ604lgCWPV9yD4ktx
	 sH7lCbewiiOtQ==
Date: Mon, 17 Aug 2026 02:37:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen
 <matti.vaittinen@linux.dev>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi Djait
 <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 10/12] iio: accel: kionix-kx022a: Fix array boundary
 check
Message-ID: <20260817023740.1b07559f@jic23-huawei>
In-Reply-To: <anxb3anPmo3zjIV5@mdjait-mobl>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<159f1048852afc74cfc2d219298a5a6f9d70cbb4.1786347811.git.mazziesaccount@gmail.com>
	<anxb3anPmo3zjIV5@mdjait-mobl>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 13:43:35 +0200
Mehdi Djait <mehdi.djait@linux.intel.com> wrote:

> Hi Matti,
> 
> Thank you for that patch!
> 
> On Mon, Aug 10, 2026 at 10:54:32AM +0300, Matti Vaittinen wrote:
> > From: Matti Vaittinen <mazziesaccount@gmail.com>
> > 
> > The driver performs a sanity check for an array size, when converting a
> > register value to an array index. The check incorrectly accepts the
> > sizeof(array) as a last index, when last valid index should be
> > sizeof(array) - 1.
> > 
> > Fix the check by bailing out when index >= sizeof(array).
> >    
> 
> Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
Applied thanks,

Jonathan

> 
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")  
> 
> --
> Kind Regards
> Mehdi Djait

