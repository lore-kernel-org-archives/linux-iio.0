Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B142E01E;
	Mon, 11 May 2026 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515842; cv=none; b=MWz7vfJhjBrZH6cDVHgBhZI5TZplEmfHCbDiT0RyASd+TRaHVGPfxL7rHvJH0GkPRJKtodeoHQCBlYxvVyqU8ONTIQXFigupc2BvlV3kmV15PnKmYR+Dxul35Od2TBbPhNP2oL2q+8317zvIpUrGatL7kwbr3OkQ+tIQpUQtag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515842; c=relaxed/simple;
	bh=HXBuLgxawd+7ChGf8cf0vBywoZnDoHbsr5LgqDBLgU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4jJTS4Z329l/pa/AcPH+jcvxKpFYPBaW8Bv8HwNpZG9WilRXL+hWHFxBw3Kl3C9GVf8ReWPS2AemMs9aWbsFusviaR8Zm7Q143LCAuQVDJeX+5nEIpvqjV4HifznS8H/3crJzken0tWrSYr3b/gA+8/VDlr12n5BiGiQg/PyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InNr06vu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InNr06vu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC32C2BCB0;
	Mon, 11 May 2026 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778515842;
	bh=HXBuLgxawd+7ChGf8cf0vBywoZnDoHbsr5LgqDBLgU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=InNr06vucC3fAgLam8U+5lsEnDPSnwk98EDWgXeHAf7MBRBEcuMHuxzz4r5EEtTCm
	 6pD3+GiPcq2JCp83kJ/6IPTYOR/neTjceyn2YRVjcbI901dDWUYGcPGhGcBRNsnZWf
	 HmD2ijQqkb2r9gwHqWDixtBgx4/yc709mr07MYBCF/vPGy63PQUwabeWuNNd4vhCGz
	 BFfc3P0SWL050xAt0wPrCmrMVRFtJtIZ7HLWRgecaN7HC42HcwXv1SmFWocNoqI3Y1
	 s+FQKZ1ilmdkp5GONEOgi8Wlob5eRzBDRwp4BS23YagQzBRLHV7RodaommbmyU3SPQ
	 odVls3OKC0SlA==
Date: Mon, 11 May 2026 17:10:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, alisa.roman@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: ad7192: replace usleep_range() with
 fsleep()
Message-ID: <20260511171033.2000a763@jic23-huawei>
In-Reply-To: <agHZh32XjOMcPv2F@ashevche-desk.local>
References: <20260510113921.50133-1-sozdayvek@gmail.com>
	<20260511025545.41631-1-sozdayvek@gmail.com>
	<agHZh32XjOMcPv2F@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 16:28:39 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 11, 2026 at 07:55:44AM +0500, Stepan Ionichev wrote:
> > The AD7192 datasheet (Rev. A, page 34, RESET section) says:
> > "When a reset is initiated, the user must allow a period of
> > 500 us before accessing any of the on-chip registers."  
> 
> > Use fsleep(500) instead of usleep_range(500, 1000). The 500 us
> > minimum stays the same; fsleep() picks the upper slack itself
> > (about +25% on a default config).  
> 
> The second sentence here...
> 
> > Add a code comment with the datasheet reference so the "why"
> > of the wait is visible at the call site.  
> 
> ...and this paragraph are unneeded details.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Tweaked and applied.
