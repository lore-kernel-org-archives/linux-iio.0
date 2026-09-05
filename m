Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298528690;
	Sat,  5 Sep 2026 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573018; cv=none; b=IuGRGpWWIqypRpSvSQb/mWZsPmRuDjgFieoDOXA5SEzAaxp/eYy8ZlraaB7hYV0nmpizATRGOPGtxt4a4CPIN7tmwxOKaWR+cr+MDIkHp+M5bg2NIVh+bLOsWUWpaP71BiqGbTHCmLYnfJ8d0Kryr5QzmfwNQQ7bCDJDIGuEen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573018; c=relaxed/simple;
	bh=LtMkKtQEZszOPF9Q7gJ/4Ghb+YgjGgH2kd8+WQjV0bM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UT7F3KtQJInNzsTYw2euft+eM4q9a1ZRxDJGH5bKlp5tFeTqEOC8Pnzj7SmM1T+MNPD/hAMzSGp8ObCDnRf51CBRtEx+Su/hHCP2xJimW+wFquzYTK2Qz4jM3jhldmEOVudwSA55PGMRW5aKGsuNnzOF7r2kSOMH8/rTmin2THQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M79XyMDs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M79XyMDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24051F00A3E;
	Sat,  5 Sep 2026 01:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573017;
	bh=XAeoxCmGU5OkJ5I+S0j+zco+84wTrEuL6HCoSbdlzjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M79XyMDsfT5A9/bwGCm4NFKsGS710bBjCxCckfLGOQ8plcJe9r+w1bMKSecQeqWUd
	 5AgpfuauXHuSkxaQW4h0sPKldMPIipfeTfKiX79vmeHqrT16GSWbUUEuStMkL8x6jW
	 221ZPxBd8+PP8nX/+1CR7/ZKyG3NUacCc06oIITrKzR6F7SWf2mbRw2TX0q9HGd7Rn
	 udnl3Wr5YZMIWMIP/p6ElFDFtakYBKTOARznWapAXwIjR0xH4bbsvAYurQ83ekNgnK
	 WtR5Y+q3OXNcOJiBgR8bKr/DlDkaZGDPCMFnGvY+BigrqLJvFVbyHC/XC3gILDLi+c
	 3ZqEjzfoUCeTw==
Date: Sat, 5 Sep 2026 02:50:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Hemanth Selam <hemanth.selam@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Matti Vaittinen
 <mazziesaccount@gmail.com>, linux-kernel@vger.kernel.org, linux@analog.com,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: fix typos in comments
Message-ID: <20260905025011.7959de66@jic23-huawei>
In-Reply-To: <20260904172231.00004b28@gmail.com>
References: <20260904121628.25537-1-hemanth.selam@gmail.com>
	<20260904172231.00004b28@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Sep 2026 17:22:31 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri,  4 Sep 2026 17:46:25 +0530
> Hemanth Selam <hemanth.selam@gmail.com> wrote:
> 
> > Fix typos in comments, reported by scripts/checkpatch.pl using the
> > misspelling list in scripts/spelling.txt.  Only touches comments, no code
> > changes.
> > 
> > Assisted-by: Cursor:claude-opus-5  
> 
> FYI, the process now is to just add 'Assisted-by: LLM' as to prevent
> free advertising in commit messages.
I'd missed that. Thanks for the heads up. I tweaked it.
> 
> > Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> > ---  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
Applied.


