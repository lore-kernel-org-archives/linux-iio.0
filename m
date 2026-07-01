Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744033ACA40;
	Wed,  1 Jul 2026 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938691; cv=none; b=P+moq5//RaYOTE2xG0Boh+R4zDTsSZjEWRVhJa1JFUmNFiLgZbwZL96MZBz5LHzevl8RRFCa/y0eP4FteMws4umiOCRk2h8RF2lILwQMHkMHbzzXRvnv+GN4Iz0rOTBx5fiWJvD5TP9iNRSuHDyhphgNou6PwPbV58ydZtNr5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938691; c=relaxed/simple;
	bh=u1ek2Gg6AelRX+JgUmfj2CXD1X/DxmN/cTfomGsM4pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnICUQEe2j/ziCDKWZTwNvMeyeymudo0UuSJN4Jg2eD0MDsfFI3mgcuJJ1b24MpAmEmqo8SSCyj3gKDlWdlYMjW3FD1acGWdgYwQDYe3RJQROctr9eZ+gbk44bqfYhUA/OrSotn0N3UUFQ1/gXEGygLCkMXuelAlllZ4zDAorR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBuhsyNv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBuhsyNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676691F000E9;
	Wed,  1 Jul 2026 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782938690;
	bh=W8F51lPI7R9r3F98mCiYiM3cuZ6tBwhZItI4B/x0P3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bBuhsyNvrh/l/VcD9WCNVu9b68gLOl5mu1nEk1Dd5mzZ8NGaH1SI9IBOjpOLUb38Q
	 muYzzY9Vot5OExvElidvuCabwLoT5JzEoC+U1AR5ANVW51+wVW5DtksryjeABYrVV4
	 c4lmQc6Ev0X8lgShm/TBfpSTYrzmUP1ZSMaPfYe4CZF64/bdPXg0XIHcSR0SdjOTnE
	 rAC5eUACZ0fR2Dkssl85SDr67J2lfy8b1LFiWICaj9/8WvCg1EmJ3KhjtViSC2wVBD
	 fIZ4bEaTdyrg0j/tisEaqHGSdNQMxnPJFPazlEZMCOTuWqcaTIrItdoAgJUNPUwkBs
	 cMGOcuadupt6w==
Date: Wed, 1 Jul 2026 21:44:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: reorder all driver
 headers
Message-ID: <20260701214445.7141553c@jic23-huawei>
In-Reply-To: <aj06fxvDJ2Rc1mmG@ashevche-desk.local>
References: <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-0-8b4c8bfa96d7@tdk.com>
	<20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-1-8b4c8bfa96d7@tdk.com>
	<aj06fxvDJ2Rc1mmG@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 17:26:08 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jun 25, 2026 at 02:24:52PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:
> 
> > Reorder headers includes following linux rules.  
> 
> Strictly speaking 'linux rules' should be 'the Linux kernel IIO subsystem
> preferences'.
> 
I tweaked the description and applied.

Thanks

J
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> (haven't I given this?)
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

