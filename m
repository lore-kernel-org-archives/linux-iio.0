Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A930674E;
	Sun, 21 Jun 2026 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063391; cv=none; b=bz3vF2fgU715VCHlX+odJPbnfUrYZFObo/AoYex9AChEKagSwFwMglaf10iY47qp45D8WcSdncawZk3cwZDRRVrI0oJWwnlRPNrNbsP09QYRdtt2Ayg5D71nQTF0j3v+RrAeoZ1h9n3bw1TkHhg6A595cg1KzihVRJ4g6x7oz+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063391; c=relaxed/simple;
	bh=YHnpvmz1ZJSBqGw7sTYK+x9Mfy35u2Ste/tbuveI0ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AP72WYq6UQXbZVrxuOEsigUsWbC4U8sIFJvorUjGgvP4ScNrrrggDNpOOG9PrvrEj7HC6FjwXqBjd8lbve4LyUCPb3vjJeIodNpUbFazgvCqVTItCWd3PqWjXXyn2yMgmZeC20zbgTLCEZ+RyyUUeoUrx+CzRhQpjsMONAkXKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQcWocXv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQcWocXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FCA1F000E9;
	Sun, 21 Jun 2026 17:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782063389;
	bh=79ag9ElUJF477aZhr5OqDggdcMTsrOOZX7Pg2ovv39o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HQcWocXvj3L0AOIzcVvPkIJ8sOIA/qzKcJr/CWadhi8d6EMtKLRR6Vmvw5EYSj9vv
	 qZ0sngjyy0Ru1793mg3j10i1LOfhD6oCGef6F3PcvNqEYqwGIRmeDVk2yWexE6Fyuj
	 7WO7Xd58A3WUIOwbEieAr9Tu9fA23j1xJDePlMrFuih4eENrLNC5Kta227nmMQWjVS
	 fS0QDIQKYwcCtLV47MtLU/X9UrRXkFYkry069Sg2jt/TRatJYWXPulgPm8B9pYtAdI
	 QZrCzNFe2cxt3zD4jBYcXLoOr+3bG5ECAu1cjTnqWt4dG2h4rYC6LwPMqgqCizL9dJ
	 vWsYVOh99wDEw==
Date: Sun, 21 Jun 2026 18:36:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V13 7/9] iio: imu: inv_icm42607: Add Accelerometer for
 icm42607
Message-ID: <20260621183618.31e8d704@jic23-huawei>
In-Reply-To: <20260615172554.160910-8-macroalpha82@gmail.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
	<20260615172554.160910-8-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 12:25:50 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add icm42607 accelerometer sensor for icm42607.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
FWIW I think this has the same issue as the gyro patch around
management of the cache of what is enabled, but
this one sashiko gave a clean bill of health...

:)
