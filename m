Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530922BFC8F;
	Sun, 30 Aug 2026 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121142; cv=none; b=ualnGJi+rgE/TJLTRdOwSjUwA1i3Qqtuh1VLV5IHxcFs2H1bLTk1coy6Z58C3d+SquzNN7E9A43BFjdN/pIWnrMQORMmHb6r+GwNuMBCp8kTW/egQOtBMaSXiKCCz8UlXlT3GHebkXVeF/3j8jyif6pgQar3EESyrd5qL/0ZsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121142; c=relaxed/simple;
	bh=gFdcnHzLitFN+WfXJUaU1+e0UbdVLCMriM5Zp3dAhHc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=MMJlrpFlt6RU2DVesW1NS4mp1CHSAjygDhV4yTrEIyZPafctzOfAsgNDQxOy/ChrQ9S/nhzKpOrRXBQlSvzmqDl8UGLXRj/TyTv/fiMKVi6kBJNehYtNEfSFByTxwlAFIQ2v76HhVp1nFGiO6Ogspsi2N77EesBhQoueNrfLwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw6R521S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw6R521S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB85F1F000E9;
	Sun, 30 Aug 2026 20:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788121140;
	bh=5valHy4vnBBktPpX6plSalDk14R3xmNoib3KQEg9z7E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=dw6R521SZdU2bA6l8sFN5acQvAm2gbT0tvNzgq2Y/ojqKM5bikpiDN4U6xQdGmloq
	 0FYHlj2mEhgbEvpWxbwYDRNjAtIoLNHeS3LaaSyQtpWrrjnb7Qd1jmGFO8Bik/iiq+
	 5zqECuSn4Ksqxt16msSsgWOowuX8P4Z7b84y4WEMPHBVgPd2W4vANf7h8r6pVXVN5J
	 K4yMF0c9sC9uW1AtNe+29IV20n3oDs6GFf9cai0tQzQhz4gYMA3noXFo3xzi5V5iL2
	 Ziz5Ojj//I8RH9oREwHosXegcWgirBZxmE2vXu8fb/ml/6S/7W2cYQ7mN2WHrm8LF2
	 BAY9afE/2wePA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/5] iio: adc: bcm_iproc_adc: use devm-managed
 cleanup
From: Jonathan Cameron <jic23@kernel.org>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260830170919.470974-4-mdshahid03@gmail.com>
References: <20260830170919.470974-1-mdshahid03@gmail.com>
 <20260830170919.470974-4-mdshahid03@gmail.com>
Date: Sun, 30 Aug 2026 21:18:41 +0100
Message-Id: <178812112191.2788519.1724251718821055090.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=gFdcnHzLitFN+WfXJUaU1+e0UbdVLCMriM5Zp3dAhHc=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlJAkl6tSVRNmqepL/mprtKJm8M/Z/MHeK2wpx
 K9GjhH4aIKJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapSQJBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiPCOD/wP3KiOH6qh3FNOj3N7WShzTh49BJRqclbUWo62WVYmGJZ
 bcJwQ0RSgif1LyMaP8FUeJYpGkl7dz7aIvIxkfjHLy/Q8dKRkTiReofSbjwkovAbKwQGFZicc2P
 kISguP4ZskcplbOWO+zdkFbvU65qWRpgecZsaJZ013zBZ6YBy46aukeX974zMo6SX4mjGf4NZdv
 9/qMxCL5lzgOa8jp/szW0hZE7IhwFDKTgaw+2QO1FEGC49TdSiKaNDSxQ9vtru35gbhIs0WFOLJ
 vwMPnb48Wpk3MBFjAvxXsvJyQGTrZSrnjs/tYTU1imJJoWshv9M2OX9TbSp+MMgX3mOUQUJ+C+S
 lEBzCkHi+jEDlizz1QEl0WwQiQVXB+MF5SSqE4CWRQ+idV9lY+o9fhxt3izFYuaIQQvuMAIb3lt
 w/1w4dQClkBY0TvOfvS6VdM4EpU+1SHtZdhc/4jtCmt9AQ+VxG90LbGyumfkYHBDQw2lsXIsOIu
 IqlFutDmUvXzpBovT3PjE/oyt6DcYYxRXXJzsGCRtP0w5l8zsf9M70KzGoW8Nw7kAqP16NsuV12
 8wapqZQIFq2uxjiq0MakBqBFNvzuQOUfAwU21v0eHwD3Tg50Ax4i8M8QIhabjFUp/vW7cjdQdnD
 /9ZL212jYFQVjtq6WwJXk7fMhcANCMYWilrXy7g==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Use devm_clk_get_enabled() to manage the ADC clock and
> devm_add_action_or_reset() to manage ADC cleanup.
> 
> Since the clock is only needed during probe, keep it as a local
> variable instead of storing it in struct iproc_adc_priv.
>

Given this section needed discussion...

> Register the ADC cleanup action immediately after enabling the ADC
> so that it is automatically performed on probe failure and device
> removal.

I would have left this for a follow up patch rather than
doing it in this one. Here it is not really the number of changes but
rather focusing the reasoning on one thing.  Even without that
splitting the two changes would have been fine.

> 
> This removes the manual clock cleanup callback and simplifies the
> probe error paths.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>

Otherwise LGTM.  Note this is a minor thing so if nothing else
comes up after we've let this sit for a few days on the list
I'll probably apply it as it stands anyway.

Thanks,

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
