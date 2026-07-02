Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A42264C0;
	Thu,  2 Jul 2026 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951948; cv=none; b=KmQUFWfmVJR/Q69DsQ5KgOflUvaB27DNXqkbCWDMF59TvT33pXmqMhFQ7zl+ZItjm4lG2XQ05i1k/teAZ8MPVZ6xm6Wtdx5/yOjJmB3+dFB1TRE57J/dXgKSscsca0r2AtOvaP59h9spjfTiSwLCX21j3ahu1MGEnzMFl1NOX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951948; c=relaxed/simple;
	bh=4/XWGLhuQ63tPtwQELz6+SAQXOr39alQK7EMVM5YvnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvcDSLHp3IZecQFNQmObvUAVmqdMjYJkw94HXpEVcQqPL73zxHmcp9nNLQYX+i18dmDLmGN5Dk21oofu5q7bb8ZDI0TlAzTP0tkwlC1//XrvbT8XmMe6f5DBi/oO6bGdkPpG9TNQZjLs1rXApjBq8FseLyJR4/FaPCzjCuQOuac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN43zJEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN43zJEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9691F000E9;
	Thu,  2 Jul 2026 00:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782951947;
	bh=BjsNZnk2hPM0v+N9nW7xV0Aww4d49DFnt3zWI1vaTi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jN43zJElyXCV3L9396+pBFWWGGn8C6KxdgS4aipL6+V8LKgPqzNsvNeqUQkhyR1ix
	 aAi3nYFznDH1jxtq9W57GyuOf+eY4w8JIn5DzuLZoHutGwiJcUh5gFr5q5zcoYN8gE
	 ++JppFPBVx8wdSd3e6TdTfR9h/01O0eXy4EX5cRhZjZxjxlUGYm/1Qg+npjHlOWo8M
	 2mWyiLjxoroF4PftAOYYW+Dg/6MS8prlzpHxvdSMDMlehbs9COVAZXq4Apus8SvVIS
	 CeJl495GN4jgRz+6On0FX5iWPfKwkh3GmjILf6+fIQyHtPXPvdbnIBMFn+IeEvTzoT
	 EWAnu9kWxD9cQ==
Date: Thu, 2 Jul 2026 01:25:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukas Metz <lukas.metz@gmx.net>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: dac: Add DAC8163
Message-ID: <20260702012541.41fd50c3@jic23-huawei>
In-Reply-To: <f57e9c71-189e-4316-aec4-5779d6211db7@baylibre.com>
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
	<20260623-dac8163-work-v1-2-5b508158faa0@gmx.net>
	<5a19c272-e8fc-4fa9-b137-842b6ed6649b@baylibre.com>
	<ajt0vibLhh6Mmhoc@berta-MS-7693>
	<f57e9c71-189e-4316-aec4-5779d6211db7@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 09:14:43 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/24/26 1:25 AM, Lukas Metz wrote:
> > Thanks a lot for the review. This is my first time submitting a
> > patch so im grateful for the detailed comments and suggestions.
> > 
> > On Tue, Jun 23, 2026 at 02:17:04PM -0500, David Lechner wrote:  
> >> It is more logical to put the dt-bindings patch first in the series
> >> before the driver that makes use of it.  
> > 
> > I will reorder the commits in v2.  
> 
> For future reference, you don't need to respond to comments that you
> agree with (save us time reading).

Better yet, crop them out of further replies and save scrolling too ;)


