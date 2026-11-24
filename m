Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514696;
	b=0vL6ax1uKFGP2HiIZAkhvn4PGcDdTfpCEzgl2jerAEZp++efokVjLP2tbYqAHqLjcf7F
	 bNafCX0PqEh+rNawmwUJblgCiwL/mDtqmcMo75AGUA5erTethcIg+QUOj50j3BXBkbSaa
	 GYqMOWSqEkQuQeGa6KHVDjjnwZ8WCdM6cPrN8YBHr3w03ESiagTVM7jhLxq3B5mv9mVpA
	 iLTS3ZiQqRR3+ybd0uHB8pX6jmSW7AFfNQ1H/RdwAafPhBmMD3MAnxBHnzJBcJKVdFy1y
	 Pqr4+XLjB/J28Gs6ZIXf4/XUiHEtX7tMU0rX45Yf+xYuaqQsu0CnETP8i3aIenTML3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514696;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dPIgCQ7z+VWTh7vm7YGyyZqaKN+uOhUO2eBW9nqHcq0=;
	b=2I8vhx/IIMglUQyUkwFDxDEwXTI+EfN+CyfzdknTLzQ5mxeKgyZCgtTM6wSpklyeXJrQ
	 heUU8NDQ16sEIa1Kct1NCu/Orcqhkxbk87qMjS57GiYogOy89v0BBCsB3CVAUiEaAQOmY
	 tFtXz1LFVQ3PaF1pDYL+ZHUXM2lfQr1LHMd/jv0ceqGmEOOvu7vtLoWakdRtprucOwLsA
	 UijuiZwsFpJbSXrlqSRKpfTVuu2GK/iaMUDGUH3DXqQbXyaoyr5Bu5NaL2XEnIDBrnbj+
	 W1hepLYgYHw4KdIsIm3kfOsfmlNZ68W1BQeocCdKKCYEqjYAjQdxQ/IHcpImh5LGefw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+itEhR0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346E606A32E;
	Tue, 24 Nov 2026 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+itEhR0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7B41F000C4;
	Tue, 24 Nov 2026 10:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795514696;
	bh=dPIgCQ7z+VWTh7vm7YGyyZqaKN+uOhUO2eBW9nqHcq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=I+itEhR0MPR705ataNWyGF9sb/CI9V0jhdZYt1Sm7Kwl8mQEdnd5oOgnGmyiN6XGM
	 Vlx6YmqCG0p6fZB4RstSW+dl1a+06jxgpZi1n5mcuu8+gl1+P0FrN8i5waAY6FxhbU
	 MZolTXMHlgwNPG3Yjo0mbTtc3RSjh+yvRMsr1hcA7+ZcSMN1mBCbZ5lnHuAq9U6Qni
	 3TJ1XJ2MwpEqh50xsTofZOCfnB/CAfi/jLB9TbgLr18EzfnPrjSgop3xO0oyruotwx
	 wsxzknPV4zIvufde746AfPX8l+b3BoQZhBzsfERnNditODvCzvO92e9JAhFqvsEeIi
	 ygCgQTBDTqkGA==
Message-ID: <1cacc0ae-2d42-4d8f-9184-5b38c42430ea@kernel.org>
Date: Tue, 24 Nov 2026 11:04:51 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/4] iio: magnetometer: mmc5633: Binding, supply and
 mount matrix
To: Gerard Marull-Paretas <gerard@teslabs.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Frank Li <Frank.li@nxp.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261124094632.8879-1-gerard@teslabs.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261124094632.8879-1-gerard@teslabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24-Nov-26 10:46, Gerard Marull-Paretas wrote:
> The MMC5603 and MMC5633 are listed in trivial-devices.yaml, but boards
> need to describe their supply and orientation. Patch 1 gives them a
> binding of their own. These bindings are also used by PebbleOS, which
> is where the need came from.
> 
> Patches 2 to 4 add the matching support to the driver. I have no board
> running Linux with these sensors, so they are only compile tested (W=1);
> feel free to take only patch 1 if you prefer.
> 
> Changes in v5:
> - List the datasheets under the section in the tSR comment, and give
>   tOp the same full reference instead of pointing at tSR's (Andy)
> - Add Andy's Reviewed-by to patches 2 and 4

Could you please slow down? You managed to send 3 revisions in the past~24 hours... Please wait at least 24 hours between versions (for series
it should be a bit longer, but at least yours is short).

Thanks.

-- 
Kind regards,
Joshua Crofts
