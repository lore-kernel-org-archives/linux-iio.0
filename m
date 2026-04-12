Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A029D265;
	Sun, 12 Apr 2026 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776009532; cv=none; b=dhDQzNIlOv4SN+0VFaz0sTFrpU/lyU1tt9uzYlYvGx6OUcvPp8WAPeWWeV7Z1mieUt3Srkk4qER/NvF4qe2kXFFPJUBtKZ5lpobM64ghXQevcYBD/RP5diFKoqGURJ27Pd5Orq7UtugHzg4/BNlI/fGDfVs1npjpj6KdjTIWJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776009532; c=relaxed/simple;
	bh=5Cq8WP/jkqRt5ZwXONKgc8jpbwmFUdH/Oe9BwIcBqXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkHDJ60Pjtkpdt/2EQdCGCpXf2oTpZfpQ7AgaMOUSiNvOoQ2UEx9maSzWnmlEl8T4i8bFuo1tET/wXvdvTqm0/QhHDcOHPi2Vgo6DPRuGZtnAoswKT3wkH+a7SeJyDFrCFWoPt/A/nOEYSP+IFDNTj6BXkzHkx4hR/rL1P7O61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX9tDwSP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX9tDwSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4CBC19424;
	Sun, 12 Apr 2026 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776009531;
	bh=5Cq8WP/jkqRt5ZwXONKgc8jpbwmFUdH/Oe9BwIcBqXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YX9tDwSPsHHlvbatBRSUSpWGKql2FIvrrgPjORC/9StTHvXFpX2vJ1O3+vARRySW5
	 Y530Kqu+WXI08pmw15OcVgmIxbOGpNiHsQRMZnTKrhu58t+cd4yvLjsoBfuOgRXPWr
	 F19G7iSSC8UBbDrDmAT8dVp6x5WuKE5yBVWaI6bIEr+eyG3yLVCUj+PPnivLNMckDv
	 aIaUH5V42sTilOxt5OYLD338JtK7MKcw2wzTzrqWp++XP/8eMrbfm/RcvGkXmY9Oxy
	 e85KDc1Fcf7wLgGQcYv2MlmK9TFvdU0xesuDkIBiDzzq1SRSAGec+tp4g4bZK810xQ
	 vbLiku+5nWZoQ==
Date: Sun, 12 Apr 2026 16:58:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] iio: light: veml6070: Fix resource leak in probe
 error path
Message-ID: <20260412165843.64623b05@jic23-huawei>
In-Reply-To: <20260327-veml6070-v2-1-10c3c67eb171@gmail.com>
References: <20260327-veml6070-v2-1-10c3c67eb171@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 20:27:54 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

> The driver calls i2c_new_dummy_device() to create a dummy device,
> then calls i2c_smbus_write_byte(). If i2c_smbus_write_byte() fails and
> returns, the cleanup via devm_add_action_or_reset() was never registered,
> so the dummy device leaks.
> 
> Switch to devm_i2c_new_dummy_device() which registers cleanup atomically
> with device creation, eliminating the error-path window.
> 
> Fixes: 7501bff87c3e ("iio: light: veml6070: add action for i2c_unregister_device")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
