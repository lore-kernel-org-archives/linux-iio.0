Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6982AD0C;
	Wed, 29 Apr 2026 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455192; cv=none; b=QuIdIFE+sf2I8WqCTDTY13GquSO0dsfwopIRd9CNOYtRPjyhhxf3ePlwmhpkcnKG3n/+ltqchJgKyqb3CHQTCjZ7d4Sv9NhjwhH6/V90dHYXpkqewSsMDxuT1UbQUku9sPjU9bHj9TCjL480PCRAGOxh6eGGdlqdjdnIelVhSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455192; c=relaxed/simple;
	bh=tI7rkJ1ujiMJxEfqKFxugw8sHRx+TnngLor6nLOfras=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRDFzfl1PgnaLLwZd77QaMCqY93jStWwMFlJRfTVhyPXqSg6AhcV1odrX93eycC33P3ulXLM1X4cRIFRSrR+/ZGGlwhcrf0KFE3OhospU7xT4WI7+3WVNiVEbjsDZcPIRBXpA89m6ByzSMAesoTCTGGP01x9enW4OS+keA0NhqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aedMjvvn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aedMjvvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8662EC19425;
	Wed, 29 Apr 2026 09:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777455192;
	bh=tI7rkJ1ujiMJxEfqKFxugw8sHRx+TnngLor6nLOfras=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aedMjvvnTgvTT4WMojD8CBhpYOMD22ZkbTGvBU/HdQZTpbLKmeWsgoEyHbDvtTTDH
	 2hgboTOn2tW3L30SIOijFPA2BOdxiya6XqAeCA7AU/1ZqtvjxKGjLCFxVgONS/kK9h
	 TYr4d+ioPae6UEe60/MID2IDC/xYwCeOeYdbMkNKOURmWIIt8Ot36FsN8BQoL7Lz6k
	 wTN/xZJEyXBCzshpV02+EwF3XwAhSow1LRa/+CvSCuLl2N6mR1T6SbpCjOGCJID/02
	 7Xs/FHHold2DgocDhc+2eUvWxUw+7ZFFIZW0F6OCNvCLlZIi9dHqNagkVwGGO7Us0n
	 yVBix8/BApmDQ==
Date: Wed, 29 Apr 2026 10:33:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Salah Triki <salah.triki@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tsys01: fix broken PROM checksum
 validation
Message-ID: <20260429103304.654ed9a0@jic23-huawei>
In-Reply-To: <afDXJLGYzF8uwaj5@ashevche-desk.local>
References: <20260428152239.66213-1-salah.triki@gmail.com>
	<afDXJLGYzF8uwaj5@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 18:49:56 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 28, 2026 at 04:22:39PM +0100, Salah Triki wrote:
> > The CRC check function was incorrectly using only the first word of the
> > PROM (n_prom[0]) instead of iterating through all words. This caused
> > the driver to fail probing on most devices due to incorrect checksum
> > calculation.
> > 
> > - Fix loop to use the correct index n_prom[cnt].
> > - Ensure all bytes are summed as per the datasheet specification.  
> 
> ...
> 
> >  	u8 sum = 0;
> >  
> >  	for (cnt = 0; cnt < TSYS01_PROM_WORDS_NB; cnt++)
> > -		sum += ((n_prom[0] >> 8) + (n_prom[0] & 0xFF));
> > +		sum += ((n_prom[cnt] >> 8) + (n_prom[cnt] & 0xFF));
> >  
> >  	return (sum == 0);  
> 
> This change makes more questions than answers. How had it been tested,
> if tested at all? (This question is to before and to after, the commit
> message is also unclear about what datasheet says or the real field
> testing gives.)
> 
I'll guess first word of the PROM is typically 0?

The datasheet indicates that it exists but then says absolutely nothing
about what is in that word - unlike all the others that are documented.

To me the fix looks right (based on the datasheet) but absolutely this
patch description should make that clear if this isn't tested on hardware.



