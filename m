Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F903B3C0A;
	Sun, 18 Oct 2026 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364730; cv=none; b=rKm8tfhPz20EfecmDDtTyGv4+upcqUKqaXzuWQNG4FJGymtAs3ELho6DIB+6GWqm1Jm6HxNaFkmxQVES+Jh+5H22CLdX5Om/g18p48XvT8PsYfBgwvlrF8bPODE2xYBjxgauYpDFGYXT0d/ObmpItXw5hmSPl0vnG/HGq3aSk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364730; c=relaxed/simple;
	bh=4HD0lAO8v546yC+QMAF9WeT6PBff4wRNZnt0RTJsqMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnGyiLHG0EezL+0K7dAlYhZkdxoWvQhvbHIjNqRnBFCm/Ou9xeNF/VBXRup24jdCQgHkWzxNKyES8n0ThF4mg9FPiaCXzzGmqZKSyIv8nqgNq0glalSW6hDywPn0WZLm1gdGl/MxfvHsXfZ/B98VgNZWzfDIk6dRTFWbV5S8NE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDhzf4vO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDhzf4vO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033571F000C4;
	Sun, 18 Oct 2026 23:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792364729;
	bh=JfACGKPe+h8nDKAZVwEcwCcmLmR66lsR2ZVXVM0MTwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RDhzf4vOwQ7Im6J4biLteio5aHEFnsOkSxqX8OQhAYON9Wy3OAoBwYY9NTG7IzNVP
	 1s4R/DL9mVi71YEHjydDYoP6r2jV5dhKztw0iT8Nzt/2t5+FWA10SkZQvwnfEWI9pM
	 aPXzExqHA94vH7Lun3e2MmNPEs9rAmro3aj5QUGHV21bO8+Gag0pjfAipubi4OQX/x
	 otknxECxWSjbyLIVAYNIFlcyDtwpn2pLWev0imF0CHQwl9AWk2FVue7+rdcfmK7S7Z
	 Lwg802s2blWuR8kqaMpEsxSrxf3T1zZ+smhA65Nr6zMTIBSfv7EKI6GwbHRxQashum
	 VTF9+j6A8cHmA==
Date: Mon, 19 Oct 2026 00:05:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Conall O'Griofa <conall.ogriofa@amd.com>,
 <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>, Sai Krishna Potthuri
 <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v4 04/15] iio: adc: xilinx-xadc: Drop unnecessary
 masking and dead code
Message-ID: <20261019000523.1d43a8d1@jic23-hlaptop>
In-Reply-To: <20261005094205.1045874-5-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
	<20261005094205.1045874-5-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 15:11:54 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Remove a no-operation bitwise-OR with zero (dead code) and the redundant
> 16-bit masking when storing values into u16 destinations, where the
> mask has no effect. Also remove the unused macros.

Hi Dileep,

Why?  If they are expressing the rest of the fields in a register
simply knowing there is stuff there an be useful even if not
explicitly used. There are three approaches I tend to accept to
such defines.

1) Comprehensive.  Sometimes it is just easier to define anything -
   particularly if codegen involved.
2) Comprehensive for a subset of registers + nothing for the contents
   of other registers - fits the above definition of useful by defining
   what the bits we are leaving alone do.
3) Exactly what is used.  I actually don't particularly like this and
   prefer option (2) but I don't tend to consider it a reason to not
   merge a driver.

Now, if the stuff you are dropping is inconsistent across IPs or similar
then that is fine, but say so here.

Jonathan


> 
> No functional change intended.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>

