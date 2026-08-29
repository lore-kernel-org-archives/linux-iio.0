Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71775E56A;
	Sat, 29 Aug 2026 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788047294; cv=none; b=S93ueoBxdjMgA1Kmr+DSM4s/PuZ+QOlDox584D4YqMh3WCFDzBmHycN7HtPgfLqtnIRTYSoYRRlT0/zR8NLLofHZ9R2kBSbDD1LtpU6ZpG09pFaSpAfLRdjEoE683SK9P3BEU343AQu1QW9ijtHc8th5JIv3vqijjfNxQUaADPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788047294; c=relaxed/simple;
	bh=3HQmYyFqAGUPgzg5dFMvpQ/HUjuFZ2dGRZu1+FPlfRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l67d8PnNb82ZWWoqmk/SbfkqWAhFBmzd3ihpeMJ45GvY+EIqUHdXCGDfXnMq4s+hl9Kk6EhDSEgR8Y4vXO2HT0NfH6V91nPOpvS0grUoIUOVFBCudKwdnu3aUwjwKbTB6p8n3qsWj7EPC1llZK0Ww6HOSSrRWkIbeYqg9ThE5QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLp3G467; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLp3G467"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6D71F000E9;
	Sat, 29 Aug 2026 23:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788047292;
	bh=ALBoQYYIcRTpmoF6uunqFzqVWm4G2ST65XR+GG1EnFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JLp3G467ZsmrzgsbQ1SRBA7TXHnAx/vNT5tA7tScA1vvY18Rq6pdUR7Q75nzuNZ+o
	 A1P+fqFALuP1wPt926g0vjd1UAC04AZtXfBDI/akvxbqAbTPPCp8hGnrobu4sxS5Z+
	 oOSjl4NSPG3/UtpdRez7QTaHAFB3GFhkGhlvi+8dzo1wF7tBokFNZHzGLHXZeTUxGm
	 qxYz6+q2V2lhffpj4p5TlaafYgbzjg+oc7xHbUobGUv7DqUCJkesK+k8foAMmLHSxE
	 +kwmXosLASJJDC7B3w28D74D2SYIEIFP6Jtd6+m5/UZ1Hx6oZI12yT5NhLLKcWFIJw
	 o1+l2GmtUFBTA==
Date: Sun, 30 Aug 2026 00:48:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Crt Mori
 <cmo@melexis.com>, Puranjay Mohan <puranjay@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] iio: temperature: ltc2983: make headers
 conform to IWYU
Message-ID: <20260830004807.64a68777@jic23-huawei>
In-Reply-To: <CALoEA-yLuDJFfL4MszuY5GAdOL5ZyLK12ZLXE=-tQbtQswhoOQ@mail.gmail.com>
References: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
	<20260829-kernel-header-removal-v2-3-c67739d5dedf@gmail.com>
	<178802625991.2637008.10318808016519364966.b4-review@b4>
	<CALoEA-yLuDJFfL4MszuY5GAdOL5ZyLK12ZLXE=-tQbtQswhoOQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Aug 2026 22:24:47 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sat, 29 Aug 2026 at 19:57, Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> > > Remove the catch-all kernel.h header and add the missing headers to
> > > enforce IWYU.  
> >
> > Sashiko correctly observed that this wasn't really IWYU.  So, to avoid
> > confusion we should be referring to something "approximate IWYU taking into
> > account some headers that always include others".  
> 
> On another note - since we paste Sashiko outputs regularly into patch reviews,
> isn't it time to send a pull request to the Sashiko repo to Cc
> linux-iio on reviews?
> I remember the last email thread discussing this died out unfortunately :(
Let's pick up on that original thread again rather than buried in here.

There were some valid concerns and there is work more generally going on
to solve the new contributor information gap.

Jonathan

> 
> --
> Kind regards,
> Joshua Crofts
> 

