Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3571748986D;
	Sat,  1 Aug 2026 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785551787; cv=none; b=lSL8D8w5jLSqPXf2t6sncWAemjOYHB/cj/dt8lvpGIBUI3F8Rm+U4MINN9u2+5N7UjwL8gJYFuj9tmxH2CVfUUTGqCvYIFTYO8Lp/K0IIQO7TgJ6A8RnmsPNvsfiBlbKLtAvkGysMphtGMtvnz13bCL1ARkTM7+KRTbT7coZQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785551787; c=relaxed/simple;
	bh=ddF0YkfHgng+EJ+hjfOWiSwwQALrxAXCvFKcLtJoJsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwL2FVhfHyxHND8mlG22S2p7eLocxqZRa+Q1jnyzll5kDmv/OI74vCaTAej2oHvzTJwvfbKRn5XKukIYnEvaDHWJX1GkdLrPyTTNwSbYPB7sHPYeZ9f7TVwx93meU/c7Exxi13YgHot9LeHs/FuJbryHAPlfTIlwNeSskoKO6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMgVEMn/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMgVEMn/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C4F1F00AC4;
	Sat,  1 Aug 2026 02:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785551785;
	bh=gxmJBDeXGSHgxM8aT14HC9SlOEm4wkqhJoKIG30HaXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NMgVEMn/a3BwHGxFWICpqZt5cdGK5SPvn0pt9cwm5HHVOZDmeyrP0+gFXT9qtPB/y
	 vBtBcvyZycsSeAfQnn0Fm9P4tdseJu7W029CH68gmbxJYlYRtAj28OB8eWFCfHzp85
	 ++opSU3Gv4B+PLdnWAGd9sKKHTxfxx2gTl9hPPupdo+PChpWqxDMI8lC8VnVYPCvnJ
	 W5XAhFeCYVSpbLy3AtywZs2LlvTXLn8vNoFI499I8ntMMl4hZHDVJsr218QtuF+LWH
	 vJzR456H8GqeZHTNkVOIFaVu2te2Bxly6D9CKgHSziyRmkq4SQLqBwCJyA0bgGBUaz
	 gQzvnmnKHA0Ew==
Date: Sat, 1 Aug 2026 03:36:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij
 <linusw@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andy Shevchenko <andy@kernel.org>, Brian
 Masney <masneyb@onstation.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>
Subject: Re: [PATCH 0/9] iio: fix write_raw() return values and remove pm
 helpers
Message-ID: <20260801033620.40bcb242@jic23-huawei>
In-Reply-To: <20260727184755.2055414-1-ekffu200098@gmail.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 03:47:37 +0900
Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Hello,
> 
Nice series - thanks for doing this.

Applied to the testing branch of iio.git to get some build testing
before I push it out for linux-next to pick up.

Thanks,

Jonathan
