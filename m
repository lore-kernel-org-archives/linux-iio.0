Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC7A3D332C;
	Wed,  6 May 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088011; cv=none; b=cSMwL8Qvvrma5wM9bZveyvEVFDJP2msJUFzUpoaZalyB5CJLdahaO1PFJhUljKGCAirvTTIlBAscDeC5rkhPsCcjFOIEWSfLPbNfJ00nCcS7UK+JXX6cirjMqVENCM7EHgAVYmDelPvhQYLetPCCp64fnFVb2sDlF3jsCRPhGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088011; c=relaxed/simple;
	bh=JWkrK6knOIJV+jdbRzBYiejjXcG3CmYeByJ1Y/vp9gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ujy9pu/eqJsyhj7yLqwMXYSC/7plCACKWpcyPO+B9VAgeRJxjEA/RKdeUI+fCQ+fV3tkkYFIMK6cjBw7x4vmaYjIlAZVh2tafLDQuMo4M8TIA5GiAAeaL5a0XmiKvlrw9juLOLUkICMMvCaRHHqm4xeRBIydGrS92h45YCuTmVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je4cig9P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je4cig9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8F9C2BCB0;
	Wed,  6 May 2026 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778088009;
	bh=JWkrK6knOIJV+jdbRzBYiejjXcG3CmYeByJ1Y/vp9gQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=je4cig9P716lDsQVA5/REsO3pmSDXFaCtWB/RkaxXruEuROQIPf6b7Q5v6hz+RowA
	 CLRj/Djrv8M/WzUy3uhuZRImY47jWFzwAAK29z9VvL4LFOK0fPhnO7uB3K9DxUJ8ao
	 WSzpbj5qTUg1XEk8ol9Wqdkr9oj6GU78TFSjS9tIo7A+tFNCivjWQeAJ5hnTb2SqFC
	 Dl7txktWGp9iyr5tK2ldnmPm2rqxIz8JHib+HYdegMtJzLfLvpJln643zknwYocsHB
	 cV34i9URRA7mpxOgGsumnX23VENU0apayXMocsalXZioOEkSNCAmM83F7uj6mGd0vs
	 xmUBEf5dNGWkQ==
Date: Wed, 6 May 2026 18:20:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 03/12] iio: dac: ad5686: acquire lock when doing
 powerdown control
Message-ID: <20260506182000.3662e1c3@jic23-huawei>
In-Reply-To: <20260505-ad5686-fixes-v6-3-c2d5f7be32be@analog.com>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
	<20260505-ad5686-fixes-v6-3-c2d5f7be32be@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 13:35:04 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Protect access of pwr_down_mode and pwr_down_mask fields with existing
> mutex lock. Each channel exposes their own attributes for controlling
> powerdown modes and powerdown state. This fixes potential race conditions
> as those the write functions perform non-atomic read-modify-write
> operations to those pwr_down_* fields. This issue exists since the ad5686
> driver was first introduced.
> 
> Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Applied to the fixes-togreg branch of iio.git (1 and 2 already on there)

Marked for stable.
