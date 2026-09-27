Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4FD35CB95;
	Sun, 27 Sep 2026 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536883; cv=none; b=tZLqgkCzdS0RlNPCNpaC6Wo+srvEP3JmiowtYblIeXfASgk6UqKbSvixrTDQ7BgPdEmOkYuDdmnIKTUt1hYOmpSZGXsYev/GecF8Z+z+CoNeDaNctBRAYgUU0z4ppG5rrEr7QVahQInMLCCM/gzmmA2lavj2qYSTDYXdJZNjI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536883; c=relaxed/simple;
	bh=pT/g357OQnWhsy5ERImIRYEyrP7OHaCbkJH06k/2nz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSN8hUz7Tmo668layrjoFU0tojeBB1jJbiUKFBLSiillZktCSFKXYHGcIp0AzQuFch8/YeT8w5cxhH+tFQeBrrw51d3MdSk8EuRVYR0I55H9GZ4Oxiy6JSRvdZTzi5Qm//ld9JcTqK4IWdbsXvIeM3erwgIykhxVhFPt+a48ob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=earYQG+b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="earYQG+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF141F000FF;
	Sun, 27 Sep 2026 19:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790536881;
	bh=9OEr1IRN4XgSD+aBRpKzIVj95AUPl3h/Qpn1S5XAVgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=earYQG+b4V1Hm6q2jaZy0vPnmxa5/dsrbhN6+T+GXXnBErP+U3/iFVodR4TB6pC9S
	 YWGj+OLgDNnEvlEPAkCOYFRBc5WkpafRsmQ0oHZC1UMixUFtWrtQMg+Vnb1KsvIfEK
	 0wH0++q3IJ0jDdoP5E9Wx2D43K3IH09gi+PpguDAvKsJQB/aJWI9sNvfhmhSlwPVyr
	 ZAIhf5LOX/8EIAgpQpBrb4SJe3TM3Uki2AHhYJw9SpM2t1WXh6vt1zDqGkwEk3AD14
	 +tbo7iH9gKYHCYNbLLWAFJV2L0+y6x42Rducwd73WfK4Gg9Dmg28is1Z1OtOdgrTIH
	 pMWX44OMkPMUA==
Date: Sun, 27 Sep 2026 20:21:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Joel Stanley <joel@jms.id.au>, Justin Stitt <justinstitt@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v8 05/10] iio: pressure: dps310: add triggered buffer
 support
Message-ID: <20260927202117.04eac945@jic23-hlaptop>
In-Reply-To: <20260921183132.233136-6-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
	<20260921183132.233136-6-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 21:31:27 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> Add a triggered buffer to capture continuously on both channels instead
> of one sysfs read at a time.
> 
> Raw register value is not useful on its own, pressure has to go through
> the compensation polynomial and needs a temperature reading. Report raw
> in Pa with 1/1000 scale to keep full resolution in the buffer without
> changing what the existing processed attribute reports.
> 
> Raw and processed reads return -EBUSY while buffer is on, so does any
> reconfiguration.
> 
> Assisted-by: LLM
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Applied.
