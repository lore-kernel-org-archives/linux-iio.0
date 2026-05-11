Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC9426D0D;
	Mon, 11 May 2026 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515527; cv=none; b=DRYa70jpS3T9pxa63+OyQM5HHdnsKizZ15jdeUs1BqTWKlRXpAiZw4z9xHbL65Wy5bYr64BbG3TfmSsGgTCtFPDHqWHiUi8sLbTYd1GCHIMEnEwSSFC0pFO6k7CiqMM6kWy5pmhYoiTX/wfl3ILdhXOFXFfMsFwEFl4LOnIwE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515527; c=relaxed/simple;
	bh=OC30CTDYYP8HGkjCaQAIE4BfP6M58+iTsfv+Bqq1eRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+D1abVFy8Qej7JwjmbjmjNxfGc3g8cXKMnAh+CxS1y0wYZGSiTS67hqbduaae5sj8YWjmQGj15XG6apWlNq6PJVvBLZ/zs8g3B3tU+slDIcR1TMNjRYXl83Zt051EDsFHrdvRrPIwjfK6inEPVjmKFyBHvXXzGc/n1MYt8WMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl2irjo8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl2irjo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81B9C2BCFA;
	Mon, 11 May 2026 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778515527;
	bh=OC30CTDYYP8HGkjCaQAIE4BfP6M58+iTsfv+Bqq1eRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pl2irjo8l4uipm4yox1HbZlpcloRHMWF8y1m/wNzpl6dsyMdGsJFejCXZam785+uM
	 XE78+CPvWchzF2c2A4Lwy839JzJyxbpK0V4aa1gY+cOeQoa0HMUfz050XiXqmzAteR
	 QR656KyDLVpKi1xaMBifmpyZ4Y08EeI2vn59MtNAZYNj36UJsV9N+vN8lL1phiiqZB
	 Ma/M9kw7Yla4bAhZx/Pd3HYhFmp9/HZkcNv+amhh3DFGURs3LcnKnMhzbBdRlbsSyz
	 jWX41CPDrZ8+dtcmqh/Mq3MvM0H89rLzYfSThKKODrAjvt9ZwiwJ3iM+3tQSADhtOF
	 llKlH97+byLtg==
Date: Mon, 11 May 2026 17:05:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: shofiqtest@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: ti-ads1298: Add parentheses around
 macro parameter
Message-ID: <20260511170519.4f381ae2@jic23-huawei>
In-Reply-To: <20260509113809.26224-1-sozdayvek@gmail.com>
References: <20260509151959.3475-2-shofiqtest@gmail.com>
	<20260509113809.26224-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 16:38:09 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> The current call sites all pass plain identifiers (chan_index,
> channel, i), so this is a preventive hardening rather than a bug
> fix, but wrapping macro arguments matches the kernel macro style
> recommended by checkpatch and avoids surprises for future callers
> that pass an expression.
> 
> Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
> 
> Stepan

Picked up this patch.

J
