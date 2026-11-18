Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794991898;
	b=32xRzJpcEhFNQ2bO3sbAQSeT0Yae3+W5Lq9AqgFkiW9zW88DTNMx33BkRisNgd0Ef20e
	 6rv3AxCYhAQ+UYiRatrRgcQh328EqYjv1wZjyLTrlVZxIQMUku72/ilK/h+UaBO/OnP0J
	 ztAigxP2k8UNMSTRUrhJYZ/L+/VkCEZLxFKWJXp+bTtx3basctDYXo/uQDUEE8TsQG1gG
	 hz6T38scDEAGbrOmeZbPlr94Ns8T3oz6SI0TX4U7nQAfg8T1uh3m8jVYmPnaJeF+h9ugT
	 MFaU96Y5H0TmNGDupMRjGpzw95Jkc79EwTbIGdk3K7d0vk8nwSyNzJnby1OIBPGUlYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991898;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OYNOuehFr9NKTiBYghlfnXrv0u5UnoGpuXJ7k9IkVak=;
	b=kMPf+AZXd9vAJDtfh9R0yS/+mmUDwRKJvRnLuDky75GoHbmB2f2NhJGzwKPH3S1pVwlh
	 PdlOWEJLuHEaZg1AspPcIC7OeW2OQB3oHInTEpz3e3iz+nE5WlhTLaswypPpYD8TddjUo
	 DHpV7b2vYMFafRMilWUud3GafLoDq92gYZ8q4uvEki2ImZpBuX4Z1pH1BtYhAZn9/PspN
	 V4cy0SWRTY0eOsKa/YWLM1m/C5t4w+cbkpTygIw0Gy73wmNbmbKMlTVghlJdXvkeVYTu8
	 JUckN9huj7dXdy6/db6o/ABaRB04iOxuLoML9moQwwRm9G38+CUoOWOENwtHr1Xpnmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ID6rWIt6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F077606A31C;
	Wed, 18 Nov 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ID6rWIt6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794991897;
	b=vNvVpTiaouaEomfxG8EqDitdaimjQB3dQWS2DAxeUTEC4RQw2rsktXTrQBAZpWJpFx0L
	 pKpQNtcNO+EtmARhuNhyDo4NiYmpQAADZXwPJKMkdZ6lRFadgXgLrV6DimA0sWdFRMHvA
	 /3uIBnDJBcG6MnZ5YKYzhhDh5W3KCUkg653mgtyYG95b6RFxnlw218FivOUWliWO/3eEn
	 MUHarjq8rdkwQARpD9s/SKpORQEtzhzvbqIrMPC3x7ZwjU8+VGBLMLy8pGvBS1BmvWhu4
	 MbxSqdNPzbwFaqAT8JT442PUw+kraUtD5Py25udQsnwKVY9t0obIPT8aGsXJnAcrk0Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794991897;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OYNOuehFr9NKTiBYghlfnXrv0u5UnoGpuXJ7k9IkVak=;
	b=JGF6FP1qD0nKEBGBbXEZuq7cscDUGy5sEufrx5/4qv5QxblLj6OAwnZbn4DaZmCR98dq
	 Imxlk4HVOdMIMLfQPedWzyr+hhIERT9H27iol3+OFwT3OebNq9XCMCQDxSf4JjGynmxvJ
	 cy+2HPJzZDArRmsuC8MzGsrRPpv0dOep9ZopJPcfwlIr5XtcMwXtSFp9g8pn80dBDLDZW
	 4RPQVkGE4UBPGDEc82alEmLFd1zwGijB6Zqbaj3HXGaULZ1rym9dO8gIfKcPlvnw1D85S
	 mvvnRJhJ6Xntj1v/nxjnYSP4C+DQuADImJrTHL94dnip9QnvcnOjyR0MN/9gzGfiDng==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id DD7D01F000C5;
	Wed, 18 Nov 2026 08:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991897;
	bh=OYNOuehFr9NKTiBYghlfnXrv0u5UnoGpuXJ7k9IkVak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ID6rWIt6dpA9/J1+Q/lGQ4/qxeKKdXsQJrLWR2Uyha/ClhyVqq6DSPiXw5OXNk3lx
	 h2Ah+ujXWRHnzMzwNwUXiAMfNPQwLoiajRTR+G/F2e5Qpf4jRkM1rVuWqySrivAjyr
	 SOHI9naAhqr61MCXF1s8KNPDJ3kCAjfacFbW1t9rD2xw8IFVreV7ATFWCoIMDaRMgs
	 OaEJw7D3mbwWMrlWpLUVZPvYGzqyx4TZu9KS0agKuxE7Y3i5qkUrHCZafQjD9GOBat
	 8OeOfg4NazDo3nJN9CJuiocQEz+iLfVAAsXL05aFOBhbPHaZHq6AtN7k0u4ZyLS1w1
	 4hj+O2M4CFtDA==
Date: Wed, 18 Nov 2026 09:51:26 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, <linux-iio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v5 02/16] iio: adc: xilinx-xadc: Fix coding style issues
Message-ID: <20261118095126.00004f1e@kernel.org>
In-Reply-To: <20261110050201.1850399-3-dileepkumar.nagavarapu@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
	<20261110050201.1850399-3-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 10:31:47 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Address checkpatch.pl warnings in the XADC driver:
> - function prototypes/definitions split across lines that now
>   fit within the line length limit
> - Realign remaining multi-line statements to the opening parenthesis
> - Add a missing space around a binary operator
> - Fix pointer/const spacing ("*const" vs "* const")
> - Adjust blank lines around a few statements
> - Reorder the local declarations (size_t n and void *data) in
>   xadc_update_scan_mode(), the only token-order change
>   (not a checkpatch warning)
> 
> No functional changes intended.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> ---

An exhausting review :)

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
