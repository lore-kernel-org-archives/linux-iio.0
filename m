Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE80B23392E;
	Fri, 10 Jul 2026 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650157; cv=none; b=jSDVe9O61mVxqTWyajQMTOuaDgVoif8KWOqdjJ0uAIDxEV+L0N25zizpMcE3vom6nVkZKdQI+4oZS+7jk6Rl+CrDp1yGY0CszEMhRL7FwoQjMLwjWeh951HTJgNTkLeQjVDqGJ3H/CSrMuC2MeRWkFSyWaKrxTzYu/i6dVdVzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650157; c=relaxed/simple;
	bh=45JPMhleAzaeP0ezko4oRJZt2vKNj1QLVn3e8YUqwiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrHw9vsmuv+MurrFfn7a9fwDVWWSwyVJfEkksGT60rcY4bp/boQloZ8HKwkZk2j8H9V444TniCBRf+17MOVJ11+JVih7orBGs3o7XJNHEmNEtKJ82C6Ruam43nUNW1pPJHsNM6p/XqwrnK19udTaT92tmlC4npoN3XIvC+1Zhqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O77/S7PQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O77/S7PQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F821F000E9;
	Fri, 10 Jul 2026 02:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783650156;
	bh=70dgz9TsQ3juJfcvdgXueV2yDRQKwQtzwec3LMLM5rI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O77/S7PQScfF6rCRGHIw4WQfELuc2nMk2ws41YIY/cym5V19WegSnKAjezEeEKoNZ
	 jL1WXmOxQgXQiZ9sYUvXRBTYB5lVRyFNzxbQyVFQ6F1zBQP3xOuBfXcsDEgjpm6Dae
	 4bX2xZ4i3a1XNjwMjz8hZgibZuCRbsR0huZ6Fh6Ece77SEh/mQbdugKyOiNx4RMeyS
	 hCuLQn08mVKxqs21B2eiomF/TGjVXFToS46dV/2CZTdHerMNEAqshei7gdwNGl8Z8p
	 6Wv/4WZ2hpPuXSPqyFdD7o96JZSe36RDeoGdhbQKg2zsX/Wa7XxPjQGu9KGGVdgFLG
	 zdck0HfiAyXag==
Date: Fri, 10 Jul 2026 03:22:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <julianbraha@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v6 2/4] iio: adc: ltc2378: Add support for LTC2378-20
 and similar ADCs
Message-ID: <20260710032232.520fb8a4@jic23-huawei>
In-Reply-To: <965e5a31bf10cb49b53f7351266eeed55e8f6bd5.1783629101.git.marcelo.schmitt@analog.com>
References: <cover.1783629101.git.marcelo.schmitt@analog.com>
	<965e5a31bf10cb49b53f7351266eeed55e8f6bd5.1783629101.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2026 17:49:53 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Support for LTC2378-20 and similar analog-to-digital converters.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
https://sashiko.dev/#/patchset/cover.1783629101.git.marcelo.schmitt%40analog.com

The comment about not holding the local lock long enough looks right to me.
You should never rely on the internal locks of IIO for modes to serialise.
Maybe that implementation will change one day (probably not but it's a layering
mess to rely on that).

I'll take another look at the rest in next few days.
(other sashiko comments are fine I think)


