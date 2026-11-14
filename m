Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614783;
	b=pUCbs/s8o79pJ7Vpiq+X0OCA33xmm9kaV4z4404O9qVk3HgUIJXWCsLukrnFDIE6F0wW
	 xrtu/chqcGYIHCr5nwUqaY0XukZ+24mdqBLcvKcnWiUseDVdNqYMIVQXpEFEokd8GdrBE
	 gil8IJ8Fl6hQfetyLucJu79gK7VlQgz6b7VhcqmxeDdlGdCMMl+Sh5tjOIzVAQda4ePQe
	 zCxxFcd0iAjOsQt9PoM9QxMwPrmYrt4GZauxnL9FNxn/xCKm3KoFlrPzaa3mJvEYkf/67
	 dHDlch7tCNUiVrRCY/D4r5bG/i9O4KmYWNu5pvZl36fvb4SGEMGCChTZ2WjXVRA3R7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614783;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wE03TbsB9gImhYnU2nKTXD/1I5ExgnTiNLVen12piB8=;
	b=bVJeJjKHR81is8RDEKSt9hpN4gvHPN4g3Z85SxEJFUqLUh1pYLZpK3WCh2rCz6ybUovc
	 QoXXJY8+gMdZ2NHkl9a22tIgHmFlQwJ67rTmVNrs3p+1Xnwaxky8b/+eUZPw7Xkco7LTb
	 gX7l6CbQutp13K4t/vMukFerIOg/kF5OAvswTRDFhcffPyjt+RDxF2R5AS8VmC8VZK5NB
	 QAtv/dcdNbOQr5JNOPxQvzueFiulGRvc731Bk4od3tANneV5P1QojkehVn8k9NhCN4SRn
	 Impvu8bjLNBqKAN6Px+u87jWgQ4Kya5qsmF/Ng6u/bTiJXXEMaujBCdpeaeTHoVYudA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4AWpDRt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF6606A32D;
	Sat, 14 Nov 2026 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4AWpDRt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD661F000C4;
	Sat, 14 Nov 2026 00:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794614783;
	bh=wE03TbsB9gImhYnU2nKTXD/1I5ExgnTiNLVen12piB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k4AWpDRt8LvwPevye0mEuE5EvOZY+d4tlO8zpe60/D44bONfLBzIpNvyKdBckF+sL
	 S9DPoXRrauM8EhUrnx/IXRWqm89zHXKxYaob9vvMqwfvvqkTo2CGi21FvCWf8PYbrs
	 9GyPav1lSxd+4RL3BKoL+L8LVL48GJa0TsmfaE+0rfojt1iD3d1FRVOWQZI/CiXoGj
	 p/17LFrQRfqUtYtMMss4HvtNrj4TS7kw5X/mwDhYgIkCOe7vM19EGeeOwLlfA3mGdS
	 KoDkadPjAskREnC+MQpWcNtLgkq7TjzyCTtaRbY4VyJN1fZGgIexxyu20Q3W1ekF3d
	 AyW9ykmo6QYlg==
Date: Sat, 14 Nov 2026 00:06:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, <kernel@axis.com>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: Add some drivers supported by Axis
 Communications to MAINTAINERS
Message-ID: <20261114000617.57be5556@jic23-hlaptop>
In-Reply-To: <cover.1794589264.git.waqar.hameed@axis.com>
References: <cover.1794589264.git.waqar.hameed@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Fri, 13 Nov 2026 18:20:41 +0100
Waqar Hameed <waqar.hameed@axis.com> wrote:

> This patch series adds some drivers that Axis Communications originally
> authored to the MAINTAINERS file. We have resources to maintain and
> review patches for these, e.g. hardware and test frameworks.
> 
> Waqar Hameed (2):
>   MAINTAINERS: Add Murata IRS-D200 PIR sensor driver
>   MAINTAINERS: Add Nicera D3-323-AA PIR sensor driver
Excellent. 

Applied to the testing branch of iio.git

thanks,

Jonathan

> 
>  MAINTAINERS | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> 
> base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b

