Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586D3CB2FC;
	Wed,  3 Jun 2026 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483519; cv=none; b=cfiUWC+vwyNDps82AAiMUtA5yFBqRyETU1dvhEEXqrvMiBnOhy+7WeIHUw8AWSJFrVuTTY0FoqXXm20JrIbxPZteDmRBbYDFuOiJeO4W2pmt9C/gTPSwMgVnR77KWQpY7KZs8gfkajjgBzNyN2vnA02bGpHceoQgktp4PTobpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483519; c=relaxed/simple;
	bh=/WR1KiSI9gp0AEObe/8EW9nqvfjRYO+Tx7+MHI8sZGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1miJb8g+XqXGlsFxzFAm8hUQNy5yheWNCvCslalK9VdCPxth2JXuzbCnfLOc47V5Gl0gnqFOPPKdR2q0OiEIW7s10GRp02GKaEtmpCpDWA17+nbb6Zh0pWqMq8zFc1q0fX5KSH/LAKiRzHTLi9/86ahMlA10YtLHB4VWVh3lb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbmrRLrM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbmrRLrM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BE91F00893;
	Wed,  3 Jun 2026 10:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780483518;
	bh=K8zPBq2LY6KEUrGUdS5cpbZTDM6avCb7lW1rCGYYvbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VbmrRLrMh2MAWozYkzLBR1fdhYqvZ4jDeng9yNAGEsYK6ZSAgkoKh0FRsr96ywFBH
	 Com7L+oP1BO83feNqBJ8hruop+6PMI70z0kjNt2BfAS12a6Tm2jEKbwwB34nCnHKw+
	 3VZCmNVkGAyHmXvb31RO8VZRXS20ghcuNq5iidLn9VooXZ6LU6Z2G4JcywNvnPFcn/
	 7cXvqf5Jsd/Z7Rz5nCWINI55PFFZNBWDnunu3cWoShAPYQ3qIYCnCQh8oPTmYpvNS3
	 LQBB79mHuTHketh/Iuv0WTcCskHgq5iRAtbYivCXd06X85BBC2SEfAoWzgvoO/UBo/
	 40+DiP5zjvGxg==
Date: Wed, 3 Jun 2026 11:45:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Miao Li
 <limiao870622@163.com>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <bigeasy@linutronix.de>, <marcus.folkesson@gmail.com>,
 <dixitparmar19@gmail.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <limiao@kylinos.cn>
Subject: Re: [PATCH] iio: accel: stk8ba50: Update includes to match IWYU
Message-ID: <20260603114509.1623e3d4@jic23-huawei>
In-Reply-To: <pnda4tc12x1.a.out@axis.com>
References: <20260603015033.187735-1-limiao870622@163.com>
	<ah_BL85vs88ynvQ2@ashevche-desk.local>
	<pnda4tc12x1.a.out@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 09:47:06 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Wed, Jun 03, 2026 at 08:52 +0300 Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> [...]
> 
> >> +#include <linux/iio/types.h>  
> >
> > Not sure if we need this one to be explicitly added when iio.h is included.  
> 
> I would vote for removing this, to be consistent with most other drivers.

I've merged changes recently where some included this and some didn't.
I agree that we can assume iio.h will always include it so probably better
to drop it from these sorts of change. I don't want to see lots of patches dropping
from existing drivers though as that's just too much churn.

Jonathan
