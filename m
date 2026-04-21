Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F420E334
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786901; cv=none; b=S7QDJKxSRrL4gEtl4tK8i+Dy5RdBpn3yEblLUcAavqIrTXWv3O32qvM25A7Gwg7+X/IL9+7ENuDSycyIEfyRFybwYwNNIpAZI2yAv+ZhwNN3zrs4MAqkLiLRFdyYl704VJiSZ1h2Bl9qO9PDRhx8LZL+Idpktd1jxaV7qybjeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786901; c=relaxed/simple;
	bh=DSsw5BTMo3nXm/Xt9LqkJDLkgXsio/Srvohw2vQgfiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGr/9Lc/MyS5MM4+z2sj1EFF0QDWpQgccH0/bGb05XM2os+9tFr4Z290h6/az2ddJCGvss1yuwha5Q+JS8j+4WXglZ+WUu8BdgEF4uMgkkx7F16XR1bW/LXQxIBoMvgfGhyqtbpKEdQRzSs9D01UPghs9OsbGLhdFknl1e7DVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbrbbzk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbrbbzk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A94C2BCB6;
	Tue, 21 Apr 2026 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776786900;
	bh=DSsw5BTMo3nXm/Xt9LqkJDLkgXsio/Srvohw2vQgfiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xbrbbzk5Bl1XNQmT3qFqV4ajXn6YvLxin2RAS3Lqu1uOEDhZXBCKuw3RC5G59kUKf
	 CA8/ahF055GiwZmbDzH1IK+NgYiqjv8bv8rdIb9gTda0XGxWereDN1CAFayo3KKb9X
	 xZKaa5n8DGlQIRgkbfQa/sGvmLxStWacr1EheF5j0dUspCgc1h7mYikOgwhskNHtep
	 mtfeeW4zIc1cICdvp195Jptjg+dnj37O55IZPIt4CBBVpQ4e/xu5vwU2r6LiBbHBFV
	 66yoUYKPoDUa23PSSwvDbPe9279fifqBOdLU3prEgorJbhLT4x0hjF3Ap3g3iDvXE9
	 wRBzu1Mczj3KA==
Date: Tue, 21 Apr 2026 16:54:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Machado Lage <marcelomlage@usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, Vinicius
 Lira <vinilira@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: adc: mcp3422: rewrite mask macros using
 bits.h macros
Message-ID: <20260421165452.76df9b7c@jic23-huawei>
In-Reply-To: <20260420191455.529923-2-marcelomlage@usp.br>
References: <20260420191455.529923-1-marcelomlage@usp.br>
	<20260420191455.529923-2-marcelomlage@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 16:14:54 -0300
Marcelo Machado Lage <marcelomlage@usp.br> wrote:

> Rewrite MCP3422_CHANNEL_MASK, MCP3422_PGA_MASK, MCP3422_PGA_MASK
> and MCP3422_CONT_SAMPLING using GENMASK() and BIT() macros from
> bits.h.
https://sashiko.dev/#/patchset/20260420191455.529923-1-marcelomlage%40usp.br
pointed out repetition of PGA_MASK.

The other comments are a mixed bag but it's worth taking a look to see
if you think any of them matter.  They are all really about the existin
code.


> 
> The other macros MCP3422_SRATE_{240, 60, 15, 3} were not changed
> because they are also used as array indices.
> 
> Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
> Co-developed-by: Vinicius Lira <vinilira@usp.br>
> Signed-off-by: Vinicius Lira <vinilira@usp.br>
