Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BBC40DFDC;
	Sat, 25 Apr 2026 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777131298; cv=none; b=inyzxL4/3XwHRfyXbDQaJLg5fB4HJYovCmsgnnxuPLoAfPcw6cO0XuHVTzn94gYjqqH5lvz0kR0PWlZkpjP7Y3j6EoMzJWmIR3qcG5rSltDPFxOUdn5BJjlpi6kouVRzhxZ/4c/yG8UYua04Fab43kkQ5NLydM2jJp8OT7TBlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777131298; c=relaxed/simple;
	bh=Ri838Yv4Wz7//y5S43QdY3pnUhe+/Yx9CpoGk2g9iz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKa9o3FsYmbNVaWXvAOqXmL/82fgTeII8ip8RaiaB9oixRpeGJM5aetw6lsOkjDamC4jbGTm9ZWTXlUKJZqMTn6Ych1LRgIRMAFFDj9HApsVi1ftH5XKBkyjx+022vGI0EC0A+6wDHQf9Gpu0KKRMrPm34EY1AlX5rjcm1Ycq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltGuX0Iv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltGuX0Iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0BDC2BCB0;
	Sat, 25 Apr 2026 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777131298;
	bh=Ri838Yv4Wz7//y5S43QdY3pnUhe+/Yx9CpoGk2g9iz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ltGuX0IvOosps7Qozb+OzSpxpc1SGFLfTaqfkEPvazMhWj7TjndqUIBke7VCYB4l7
	 NwcasdxSyXJQIzil8bpuDhYrQWN24VZRL3Gu/hnggrjG+1wI05bFB/PvQtfzdlRX7M
	 yG5XEVIChPN5uxsxK68HA4QswfIQZXDq2iX9m0SWdPkOjdb4h40Uk6nDPoVE4o+pLq
	 l6HDUfeE4ALsMJvMalAZZIPlfy/havMtR5cNjI9D6CZhCQIqDoih7URjC1HqyJVN/Y
	 Jd8u9KLllbmDsTjlku2uveziG3fBg/ivmnYlbodxCtKO8gW3Jy5AH1yizwEPAKKTce
	 f5lm1TvNmhkUg==
Date: Sat, 25 Apr 2026 16:34:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Cc: Salih Erim <salih.erim@amd.com>, Conall O'Griofa
 <conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: adc: xilinx-ams: refactor alarm handling to
 table-driven design
Message-ID: <20260425163449.547b7ed9@jic23-huawei>
In-Reply-To: <20260414224245.8493-1-guilherme.bozi@usp.br>
References: <20260414224245.8493-1-guilherme.bozi@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 19:40:32 -0300
Guilherme Ivo Bozi <guilherme.bozi@usp.br> wrote:

> This series addresses significant code duplication in alarm handling
> logic across the Xilinx AMS IIO driver.
> 
> To address this, the series introduces a centralized table-driven
> mapping (alarm_map) that replaces multiple switch statements spread
> across the driver.
> 
> This improves:
> - maintainability (single source of truth for mappings)
> - readability (removes repeated switch logic)
> - extensibility (new alarms require only table updates)
> 
> No functional changes are intended.
This series looks fine to me.

Given the AMD Xilinx folk are fairly active reviewers I'm just
waiting on them taking a look.


> 
> Series overview:
> - Patch 1: fix out-of-bounds channel lookup 
> - Patch 2: convert mutex handling to guard(mutex) 
> - Patch 3: introduce table-driven alarm mapping
> 
> v1 -> v2:
> - Fixed Fixes tag format
> - Replaced AMS_ALARM_INVALID with AMS_ALARM_NONE
> - Changed alarm_map base_offset type
> 
> v2 -> v3:
> - Replace 'i >= num_channels' with 'i == num_channels'
> - Add missing trailing comma in alarm_map array initializer
> 
> Guilherme Ivo Bozi (3):
>   iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event
>     handling
>   iio: adc: xilinx-ams: use guard(mutex) for automatic locking
>   iio: adc: xilinx-ams: refactor alarm mapping to table-driven approach
> 
>  drivers/iio/adc/xilinx-ams.c | 190 +++++++++++++----------------------
>  1 file changed, 71 insertions(+), 119 deletions(-)
> 

