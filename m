Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3BF18C332;
	Fri,  3 Jul 2026 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783040262; cv=none; b=DrVu7xF8vRDfuCzm4jHLbtMm3Bfy8DOJWfjPUEd8+wUoyp//0DpbKOtr5krjRxeSeXGAaXEL7pXYcSnm9IMS6mbBdasnUcnMCYL0coTTxq7+Az1szrDYkyYtPk7AEleHJ9CmycfwdOh26u0kAoakNKCVbR/f58vf7goedWOmzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783040262; c=relaxed/simple;
	bh=8tWo6Q0644PyRF7YBZcu76mfXlMXySY0t9qyIdZP05k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j47xDc0TDZS+tHII/MYYYRPHXO6jWBdXAvMp7ModFhhZsFPm6iY6RttfiTgpF/2ZYvgNUZUfLTxJjROsr2yd5tE45wN5Y7UsDmTSbTLVjnASWlDSVUwStAp0oKB7Q5vVMa2WF23DRgwUlDvNFWAUGo6tNh83lIR24rTTorj6Zqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XetlJrW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XetlJrW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5194C1F00A3A;
	Fri,  3 Jul 2026 00:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783040260;
	bh=dgOSzXi3H3wJeZW1ociIAvvOzPFpS+FmJNkakpTdycU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XetlJrW020pJ2/NodgckE91pFr2iY+JQaacOLVnDqnPf4tkEAprlnkwak07XsOePW
	 GvKmsk6KS9YdrF0BoQkJZHJjCgzCeHre65sz0qfKZGuCx5IluCAsrGQ6bsy2hgr7yF
	 hc8u4QhVJcG5JD3ZKHG52W1KqvVFm7Rpjb68FSpLd+aqc5upA0AZVKd50bYYqiRK2G
	 vM0MhPb/6ACRq7DO3mT6kRpQ7hUR1B4iz4z7sjgCtIPAJV8tRL1058fJOBf684uxRA
	 J3s8i5JyuMmFUU1NHFCEI6QZrTZ3MQcoVX3xYV36HXV8dFPEG08Hoy0J6fns67rtcM
	 TQ+OFVo9iheLQ==
Date: Fri, 3 Jul 2026 01:57:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 05/14] iio: light: lm3533-als: Remove redundant pdata
 helpers
Message-ID: <20260703015735.1403d1de@jic23-huawei>
In-Reply-To: <20260617080031.99156-6-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
	<20260617080031.99156-6-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 11:00:22 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> The lm3533_als_set_input_mode() and lm3533_als_set_resistor() functions
> are used only in lm3533_als_setup(). Incorporate their code into
> lm3533_als_setup() directly to simplify driver readability.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
LGTM
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
