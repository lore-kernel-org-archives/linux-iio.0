Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4780E3DE434;
	Sat, 16 May 2026 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778932814; cv=none; b=a5LvaWcgPQiKMPVKsj5epoAl2P+vVSHZCxCPYNfTrwWSQOwJAYzXK+P0SabgQ1waN6koDLbKv9YuQsJwY5iXt7dGKATzj3UnuzwaO1qhlHFBR07aXtdrMdXJ+xcRYdNlx32xxz8NsHSVj9UiFg091KnDV7vYRl/y6uKKnFyw2KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778932814; c=relaxed/simple;
	bh=hZPiwtE0+NzjAt52VRen0T7Ph1Km7F7CX0qXRFhaMxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HM82WO6TT6hdBfs1lPaMHL/qnYD0mF1//ss9BFRbvUVx13oYuj3lEClsN0wa4ZhYUZP+Q8QC+NJeP1IZHjjIR2tofu5xYYzPsLGG80U/d/KpyEYTIOHKUsdEC39dABEGTv/85oUC5WZJnB9iraB0mc1jTEtaUbJwl/LrjEs9j4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwKpaG9I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwKpaG9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6FFC2BCB3;
	Sat, 16 May 2026 12:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778932813;
	bh=hZPiwtE0+NzjAt52VRen0T7Ph1Km7F7CX0qXRFhaMxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qwKpaG9IPHW2mhKrEkmao71GCw8asEcsAxz6/IH+XbSLH/DCT+bzP1GdZF3tuf8la
	 Z2NINFzM5g/ew+9WxsdrMRjUnsenJN33Lv7Pgx1Eb6IEQSci4gP7npB3dRM7rqwimV
	 CXe5JCfq+BnOd69Nu8IM2awybCbPWqAqzERnPIU2GiVJlWCtp5CnfYKddNTfhL4gjk
	 dZE1UDAK8IPmNHsrBANWBqX0zZ5AIOn/GxVd8oqwQkiOkYLt+fVG3S3qFjfh3NZN9z
	 EeAmv0pT/pgQF4dY4fP/PbE+Q4w7zO259ytkqBEdaPEtcQDI+BhEBmimuNwW9v5QoJ
	 4WVVUO88C2Ssw==
Date: Sat, 16 May 2026 13:00:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Alexander Koch <mail@alexanderkoch.net>, Michael Hornung
 <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] iio: light: opt3001: use macros from bits.h
 header
Message-ID: <20260516130005.5afa6552@jic23-huawei>
In-Reply-To: <20260512-opt3001-cleanup-v2-3-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
	<20260512-opt3001-cleanup-v2-3-8018cf3a8a0a@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 12:57:23 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Use GENMASK() and BIT() macros from bits.h header where it makes
> sense. While at it, remove unused macro.
> 
> No functional change.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
This one is also good on it's own so applied.

Thanks,

Jonathan
