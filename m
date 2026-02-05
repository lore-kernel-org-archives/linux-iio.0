Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32613EBF07;
	Thu,  5 Feb 2026 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770320647; cv=none; b=Zu0vZrGNaHqRsyZ2Z4tJDdW8zBCrd92PeAgOWbLZZdXZsdg3WMzdzDIQ3bVSKvQpKs0DFurzSvHLpfgB9M+m4cpw3tNDQoCtF9GBRYIe/7Cq+/p3UtV78AYZrR2VlnQA+rKpa54kVcmKVl4Jj5rG7HfZr+16sMuH0UUZvSdk+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770320647; c=relaxed/simple;
	bh=6GKsR1UGDaI2kFu6+Ifiu666cSkmslW/zGyy2MiofTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSJBOj7hXi+LnlEiP52pXIo9eDp8GdemKamz8hS0pD7S16t/BrBuB1kRuw7C+2/+UUvkh8uBo2TOTmX8NqSzmEGjjlFIh9hNQKDLod1jELlapAHr5/6UZTLnokLODFs3tqeUoMA0VgFII/eegLQIn6sgTz9HyxCXOLF2I0SpSNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqsDL0Cg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqsDL0Cg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB5AC4CEF7;
	Thu,  5 Feb 2026 19:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770320646;
	bh=6GKsR1UGDaI2kFu6+Ifiu666cSkmslW/zGyy2MiofTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hqsDL0CgNmIMIVwzC8w+qH15fj+8Z/BeMcWDECP26tMj9rUfqyvwkXiVslgfJaTlh
	 972X8jy/6FDRvGS1TSF1KqRNeFP2v2g7QJJepPcHbxn/0GTdSVJ9fg1ucEN/crAI2V
	 cO7ngjjZAdlThJqDWaWjSMoY2qWaxZ+UARQV0Tc0plmsqL6xmzahbAJNr7a6nP4AzF
	 xRSzAacBojmeetFBYkBRwyZSQtHsoba5JHMXSdu4rSep7LzbVa0f/xRpRPtmMdk395
	 yiD/uJessrYECNuTcMVdNOvxxCUrQ6OKKt733bIxLgYHjCocm6UkmJbyzceuX/RdOW
	 xumLAFm7h38hQ==
Date: Thu, 5 Feb 2026 19:43:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
 <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v7 0/8] Add SPI offload support to AD4030
Message-ID: <20260205194354.1e13143c@jic23-huawei>
In-Reply-To: <cover.1770309522.git.marcelo.schmitt@analog.com>
References: <cover.1770309522.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Feb 2026 13:46:28 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Hi,
> 
Hi Marcelo

Just a quick note to say I took another look through and what I spotted
was a subset of stuff Andy already pointed out.

Given this is now next cycle material anyway, please just tidy those
bits up in a v8 and I'll get this queued up.

Thanks,

Jonathan
